using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class printprofile : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();

            string uname = Request.QueryString["uname"].ToString();

            if (!IsPostBack)
            {

                var get = (from c in db.tblMembers
                           where c.username == uname
                           select c).SingleOrDefault();
                lblName.Text = get.name;
                lblUser.Text = get.username;
                lblMobile.Text = get.mobile;
                lblAadhar.Text = get.aadhar;
                lblAddress.Text = get.address;
                lblPincode.Text = get.pincode;
                lblSate.Text = get.state;
                lblCity.Text = get.city;

                lblBank.Text = get.bankname;
                lblBranch.Text = get.branch;
                lblAccout.Text = get.account;
                lblIfsc.Text = get.ifsc;
                lblPAN.Text = get.pan;

                lblDate.Text = get.joindate.Value.ToString("dd/MM/yyyy");

            }
        }
        catch
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }
}