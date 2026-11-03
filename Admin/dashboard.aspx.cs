using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_dashboard : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            string admin = Session["admin"].ToString();

            var payout = db.tblMembers
                  .Where(x => x.status == "Active" && x.amount > 0);

            decimal totalRoi = payout.Sum(x => (decimal?)x.amount) ?? 0m;

            lbltotalroi.Text = totalRoi.ToString("0.00");
            DateTime to = DateTime.Today.Date;

            decimal todaysRoi = payout
                .Where(x => x.joindate == to)
                .Sum(x => (decimal?)x.amount) ?? 0m;

            lblroi.Text = todaysRoi.ToString("0.00");


            var top = db.tblMembers
              .Where(x => x.status == "Active");

            decimal totaltop = top.Sum(x => (decimal?)x.amount) ?? 0m;

            lbltotal.Text= totaltop.ToString("0.00");


        }
        catch (Exception ex)
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }
    
}