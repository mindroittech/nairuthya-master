using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Admin_task_execute_auto_withdraw : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] == "generate") //weekly withdrawal
        {
            DateTime date = DateTime.UtcNow.AddHours(5.5);

            AutoWithdraw(date);
        }
    }
    private void AutoWithdraw(DateTime date)
    {
        Decimal minPayout = 500;

        var find = (from c in db.tblMembers
                    where c.isActive == 1 && c.credit >= minPayout
                    && c.status == "Active"
                    select c);
        int tds = 0;
        int gst = 0;
        foreach (var f in find)
        {
            var insert = new PaymentRequest
            {
                username = f.username,
                cashavailable = f.credit,
                amount = f.credit,
                tax = f.credit * gst / 100,
                sc = f.credit * tds / 100,
                netpay = f.credit * (100 - gst - tds) / 100,
                date = date.Date,
                status = "Pending",
                comments = "auto"
            };

            f.credit = 0;

            db.PaymentRequests.InsertOnSubmit(insert);
            db.SubmitChanges();
        }
    }
   
   
}