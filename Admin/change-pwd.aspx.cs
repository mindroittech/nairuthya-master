using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_change_pwd : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();

            if (Request.QueryString["g"] == "t")
            {
                Label5.Visible = true;
                Label5.Text = "Your password has been updated";
            }
        }
        catch
        {
            Response.Redirect("../adminlogin.aspx");
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string admin = Session["admin"].ToString();

        var res = db.Admins.Single(x => x.username == admin);
        if (res.password == TextBox1.Text)
        {
            try
            {
                res.password = TextBox2.Text;
                db.SubmitChanges();
                Response.Redirect("change-pwd.aspx?g=t", false);
            }
            catch (Exception ex)
            {
                Label4.Visible = true;
                Label4.Text = ex.Message;
            }
        }
        else
        {
            Label4.Visible = true;
            Label4.Text = "You old password does not match";
        }
    }
}