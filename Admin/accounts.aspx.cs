using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class admin_accounts : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();
        }
        catch
        {
            Response.Redirect("../adminlogin.aspx");
        }

    }

    protected void bind()
    {
        try
        {
            string uname = TextBox1.Text;

            var get = from c in db.Payouts
                      join d in db.tblMembers
                      on c.username equals d.username
                      where (d.name == uname || d.mobile==uname)
                      orderby c.date descending
                      select new
                      {
                          credit = c.credit,
                          c.date,
                          c.confirmdate,
                          c.netpayout,
                          c.tax,
                          c.desc,
                          d.name,
                          c.debit,
                          c.username,
                          c.remarks,
                          c.status,
                          c.perShare,
                          c.units
                      };

            GridView1.DataSource = get;
            GridView1.DataBind();
           
            Decimal am = 0;
            foreach (var g in get)
            {
                if (g.desc != "Trading Profit")
                    am = am + (Decimal)g.credit;
              
            }
           
            Label7.Text = am.ToString();
            Label8.Text = db.tblMembers.Where(x => (x.name == uname || x.mobile == uname)).SingleOrDefault().debit.Value.ToString();
            Button2.Visible = true;

        }
        catch
        {
            Label9.Visible = true;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        bind();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Export();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void Export()
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Account_Transactions.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);



       // GridView1.HeaderRow.Style.Add("background-color", "#FFFFFF");
        GridView1.Width = 300;
        GridView1.AllowPaging = false;
        // this.bind();
        GridView1.RenderControl(htw);
        //box.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblStatus = (Label)e.Row.FindControl("lblStatus");
            if (lblStatus != null)
            {
                if (lblStatus.Text == "Send")
                {
                    lblStatus.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}