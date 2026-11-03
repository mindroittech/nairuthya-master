using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_mprofile : System.Web.UI.Page
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

                HyperLink1.NavigateUrl = "printprofile.aspx?uname=" + uname;

                var get = (from c in db.tblMembers
                           where c.username == uname
                           select c).SingleOrDefault();
                TextBox2.Text = get.name;
                TextBox4.Text = get.mobile;

                TextBox6.Text = get.address;
                TextBox7.Text = get.pincode;
                DropDownList2.SelectedValue = get.state;
                TextBox13.Text = get.city;

                txtAdhar.Text = get.aadhar;
                txtNominee.Text = get.nominee;
                TextBox8.Text = get.bankname;
                TextBox9.Text = get.branch;
                TextBox10.Text = get.account;
                TextBox11.Text = get.ifsc;
                TextBox12.Text = get.pan;
                txtUnits.Text = get.noOfunits.ToString();
                txtAmount.Text = get.amount.ToString();
                txtHandlingCharges.Text = get.handlingCharge.ToString();
                txtGrandTotal.Text = get.grandTotal.ToString();

            }

        }
        catch
        {
            Response.Redirect("view-members.aspx");
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {

            string uname = Request.QueryString["uname"].ToString();

            var get = (from c in db.tblMembers
                       where c.username == uname
                       select c).SingleOrDefault();

            get.name = TextBox2.Text;

            get.mobile = TextBox4.Text;

            get.nominee = txtNominee.Text;
            get.aadhar = txtAdhar.Text;

            get.address = TextBox6.Text;
            get.pincode = TextBox7.Text;
            get.state = DropDownList2.SelectedValue;

            get.city = TextBox13.Text;

            get.bankname = TextBox8.Text;
            get.branch = TextBox9.Text;
            get.account = TextBox10.Text;
            get.ifsc = TextBox11.Text;
            get.pan = TextBox12.Text;
          
            //get.amount = Convert.ToDecimal(txtcapital.Text);
            db.SubmitChanges();

            Panel1.Visible = true;

        }

        catch
        {

        }
    }
}