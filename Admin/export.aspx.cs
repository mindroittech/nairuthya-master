using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.IO;

public partial class admin_export : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

        string type = Request.QueryString["t"].ToString();
        if (!string.IsNullOrEmpty(Request.QueryString["d1"]) && !string.IsNullOrEmpty(Request.QueryString["d2"]))
        {
            bind(type, Convert.ToDateTime(Request.QueryString["d1"]), Convert.ToDateTime(Request.QueryString["d2"]));
        }
        if (!string.IsNullOrEmpty(Request.QueryString["date"]))
        {
            bind(type, null, null ,  Convert.ToDateTime(Request.QueryString["date"]));
        }
        else
            bind(type);

        ExportToExcel("Payouts");

    }

    protected void bind(string type, DateTime? d1 = null, DateTime? d2 = null, DateTime? date=null)
    {

        var getpayout = from c in db.PaymentRequests
                        join d in db.tblMembers
                        on c.username equals d.username
                        where c.status == "Pending"
                        //&& c.comments == type
                        orderby c.date
                        select new
                        {
                            c.paymentid,
                            c.username,
                            c.cashavailable,
                            amount = c.amount,
                            d.name,
                            tax = c.tax,
                            sc = c.sc,
                            netpay = c.netpay,
                            date = c.date,
                            d.bankname,
                            d.branch,
                            d.account,
                            d.ifsc,
                           // c.comments
                        };

        if (d1 != null && d2 != null)
        {
            getpayout = getpayout.Where(x => x.date >= d1 && x.date <= d2);
        }
        if(date!=null)
            getpayout = getpayout.Where(x => x.date == date);


        // ✅ Group by username + date
        var grouped = from g in getpayout
                      group g by new { g.username, g.date } into grp
                      select new
                      {
                          Username = grp.Key.username,
                          Date = grp.Key.date,
                          cashavailable = grp.Sum(x => x.cashavailable), // pick one value
                          amount = grp.Sum(x => x.amount),
                          tax = grp.Sum(x => x.tax),
                          sc = grp.Sum(x => x.sc),
                          netpay = grp.Sum(x => x.netpay),
                          name = grp.Max(x => x.name), // pick one representative value
                          bankname = grp.Max(x => x.bankname),
                          branch = grp.Max(x => x.branch),
                          account = grp.Max(x => x.account),
                          ifsc = grp.Max(x => x.ifsc),
                        
                      };

        GridView1.DataSource = grouped;
        GridView1.DataBind();


    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void ExportToExcel(string fileName)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GridView1.AllowPaging = false;
            GridView1.DataBind();

            if (GridView1.HeaderRow != null)   // prevent null exception
            {
                GridView1.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
            }
          
            foreach (GridViewRow row in GridView1.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GridView1.RowStyle.BackColor;
                    }
                    if (row.Cells[7] == cell|| row.Cells[10] == cell)
                        cell.CssClass = "text";
                    else
                        cell.CssClass = "textmode";
                }
            }

            GridView1.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } .text{mso-number-format:\@; }  </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }
}