using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
      
        try
        {
            string admin = Session["admin"].ToString();
            if (!IsPostBack)
                bind();
        }
        catch
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }
    protected void bind(DateTime? d1 = null, DateTime? d2 = null)
    {
        try
        {
            var get = from c 
                      in db.tbldividents
                      orderby c.DividendDate descending
                      select new {
                         
                          c.Id,
                          c.TotalDividendBonus,
                          c.TotalEligibleMembers,
                          c.TotalShares,
                          c.DividendDate,
                          c.DividendPerShare,
                          c.Remarks,
                      
                      };

            if (d1 != null && d2 != null)
            {
                get = get.Where(x => x.DividendDate.Date >= d1 && x.DividendDate.Date <= d2);
            }

            GridView1.DataSource = get;
            GridView1.DataBind();
          
        }
        catch
        { }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DateTime? d1 = null, d2 = null;

        if (TextBox1.Text != string.Empty && TextBox2.Text != string.Empty)
        {
            d1 = Convert.ToDateTime(TextBox1.Text);
            d2 = Convert.ToDateTime(TextBox2.Text);
        }
     
        bind(d1, d2);

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Button1_Click(null, null);
    }
   
}