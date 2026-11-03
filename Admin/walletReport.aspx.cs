using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_walletReport : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();

            if (!IsPostBack)
            {
                bind();
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }

    private void bind(string uname = null)
    {
        var get = from c in db.tblMembers
                  where c.status == "Active" && (c.credit > 0)
                  && c.isActive == 1
                  select new { c.username, 
                      c.name, 
                      wallet = c.credit, 
                      c.debit,
                      credits = db.Payouts.Where(x => x.username == c.username && c.credit != null).Sum(x => x.credit) ?? 0};
        if (uname != null)
            get = get.Where(x => x.name == uname);
        GridView1.DataSource = get;
        GridView1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        bind(TextBox1.Text);
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
}