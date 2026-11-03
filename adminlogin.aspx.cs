using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void login_click(object sender, EventArgs e)
    {
        try
        {
            var login = (from c in db.Admins
                         where c.username == userid.Value && c.password == psswd.Value
                         select c).SingleOrDefault();
            if (login != null)
            {

                Session["admin"] = login.username;
                Session["name"] = login.name;
                Response.Redirect("admin/dashboard.aspx");
            }
            else
            {
                Label1.Visible = true;
                Label1.Text = "Invalid Username or Password";
            }
        }
        catch
        {
            Label1.Visible = true;
            Label1.Text = "Invalid Username or Password";
        }
    }
}