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
    protected void bind(DateTime? d1 = null, DateTime? d2 = null, string type = "",string user="")
    {
        try
        {
            var get = from c 
                      in db.tblMembers
                      orderby c.joindate descending
                      select new {
                         
                          c.id,
                          c.name,
                          c.joindate,
                          c.amount,
                          c.noOfunits,
                          c.grandTotal,
                          c.handlingCharge,
                          c.status,
                          c.mobile
                      };

            if (d1 != null && d2 != null)
            {
                get = get.Where(x => x.joindate.Value.Date >= d1 && x.joindate.Value.Date <= d2);
            }
            if (type != "")
            { 
               if(type=="Active")
                    get = get.Where(x => x.status == "Active");
               else
                    get = get.Where(x => x.status != "Active");
            }

            if (user != "")
                get = get.Where(x => (x.name == user || x.mobile == user));

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
        string type =DropDownList1.SelectedValue;
        string user = txtuser.Text;
        bind(d1, d2, type,user);

    }
    protected void lnkAction_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        int id = Convert.ToInt32(btn.CommandArgument);

        var record = db.tblMembers.SingleOrDefault(x => x.id == id);
        if (record == null) return;

        record.status = "Withdrawn";
        record.enddate = DateTime.UtcNow.AddHours(5.5);
        db.SubmitChanges();
        bind();

        ScriptManager.RegisterStartupScript(
            this, GetType(), "msg",
            "alert('Withdrawal completed successfully');", true
        );
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Button1_Click(null, null);
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblStatus = (Label)e.Row.FindControl("lblStatus");

            string memberStatus = Convert.ToString(
               DataBinder.Eval(e.Row.DataItem, "status")
            );

            if (lblStatus != null)
            {
                if (lblStatus.Text == "Active")
                {
                    lblStatus.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }
            }

            DateTime topupDate = Convert.ToDateTime(
            DataBinder.Eval(e.Row.DataItem, "joindate")
            );

            LinkButton lnk = (LinkButton)e.Row.FindControl("lnkAction");

            if (lnk != null)
            {
                // ✅ check if date is older than 364 days
                if ((DateTime.Now.Date - topupDate.Date).TotalDays > 30 && memberStatus =="Active")
                {
                    lnk.Visible = true;
                }
                else
                {
                    lnk.Visible = false;
                }
            }

        }
    }
}