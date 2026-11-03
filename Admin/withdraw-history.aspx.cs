using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.IO;

public partial class admin_withdraw_history : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();

            if(!IsPostBack)
                bind();
        }
        catch
        {
            //Response.Redirect("../adminlogin.aspx");
            throw;
        }
    }

    protected void bind()
    {
        DateTime? d1 = null;
        DateTime? d2 = null;

        if (!string.IsNullOrEmpty(TextBox1.Text))
            d1 = Convert.ToDateTime(TextBox1.Text);

        if (!string.IsNullOrEmpty(TextBox2.Text))
            d2 = Convert.ToDateTime(TextBox2.Text);

        var get = from c in db.PaymentRequests
                  join d in db.tblMembers
                  on c.username equals d.username
                  where c.status == "Paid" &&
                        (d1 == null || c.date >= d1) &&
                        (d2 == null || c.date <= d2)
                  orderby c.date descending
                  select new
                  {
                      c.paymentid,
                      c.username,
                      c.amount,
                      c.transaction,
                      c.cashavailable,
                      c.comments,
                      c.date,
                      c.paiddate,
                      c.tax,
                      c.sc,
                      c.netpay,
                      c.status,
                      d.name,
                      c.deduction
                  };

        GridView1.DataSource = get;
        GridView1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        bind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[6].Text == "Paid")
                e.Row.Cells[6].ForeColor = Color.Green;
            else
                e.Row.Cells[6].ForeColor = Color.Red;
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void Export()
    {
        
        bind(); // Call with filters

        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment; filename=Withdrawal_History.xls");
        Response.ContentType = "application/vnd.ms-excel";
        Response.Charset = "";
        EnableViewState = false;

        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                // Style the GridView before rendering
                GridView1.AllowPaging = false;
                GridView1.DataBind();
                GridView1.RowStyle.HorizontalAlign = HorizontalAlign.Center;

                GridView1.RenderControl(htw);

                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Export();
    }
}