using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_deactivated : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    sendsms send = new sendsms();
    protected void Page_Load(object sender, EventArgs e)
    {
        Label2.Visible = false;
        try
        {
            string admin = Session["admin"].ToString();

        }

        catch
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chk = row.FindControl("CheckBox1") as CheckBox;

                if (chk != null && chk.Checked)
                {
                    int memberId = Convert.ToInt32(
                        GridView1.DataKeys[row.RowIndex].Values["id"]
                    );

                    var member = db.tblMembers
                                   .SingleOrDefault(c => c.id == memberId);

                    if (member != null)
                    {
                        member.isActive = 1;
                    }
                }
            }
        }

        db.SubmitChanges();

        Response.Redirect("deactivated.aspx");
    }

    public bool IsVisible(string status)
    {

        if (status == "Stopped")
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("deactivated.aspx");
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string uname = e.CommandArgument.ToString();

          
            if (e.CommandName == "profile")
            {
                Response.Redirect("mprofile.aspx?uname=" + uname);
            }
          
            if (e.CommandName == "stop")
            {
                var find = db.tblMembers.Where(x => x.username == uname).SingleOrDefault();

                find.status = "Stopped";
                find.enddate = DateTime.UtcNow.AddHours(5.5);

                db.SubmitChanges();

                Response.Redirect("view-members.aspx");
            }

        }
        catch
        { }
    }

    protected void Button5_Click(object sender, EventArgs e)
    {

        if (TextBox3.Text == string.Empty)
        {
            Label2.Text = "Enter Username or Name or Mobile";
            Label2.Visible = true;
            return;
        }
        var get = from c in db.tblMembers
                  where ( c.name.Contains(TextBox3.Text) || c.mobile.Contains(TextBox3.Text)) && c.isActive == 0
                  select c;
        GridView1.DataSourceID = null;
        GridView1.AllowPaging = false;
        GridView1.DataSource = get;
        GridView1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        // Export();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
}