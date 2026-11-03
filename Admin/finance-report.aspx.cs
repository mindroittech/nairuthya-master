using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_finance_report : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
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

    protected void bind(DateTime? date1 = null, DateTime? date2 = null)
    {
        // Step 1: Get real dates — Replace this with your actual date source
        //List<DateTime> allDates = db.PinManagaers
        //                            .Select(x => x.date.Value.Date)
        //                            .Distinct()
        //                            .ToList();

        // Step 2: Filter dates by date1 and date2
        //if (date1 != null && date2 != null)
        //{
        //    allDates = allDates
        //               .Where(x => x.Date >= date1.Value.Date && x.Date <= date2.Value.Date)
        //               .ToList();
        //}

        //// Step 3: Build report data
        //var getData = allDates
        //    .OrderByDescending(d => d)
        //    .Select(d =>
        //    {
        //        var pin = 0;
        //        var selfpin =0;
        //        var payout = Helper.totalPayout(d);

        //        return new
        //        {
        //            date = d,
        //            pin = pin,
        //            pinvalue = pin * 1999,
        //            selfpin = selfpin,
        //            selfvalue = selfpin * 1999, // Assuming this is what you meant
        //            payout = payout
        //            // Add collection if needed
        //        };
        //    }).ToList();

        //// Step 4: Totals (if needed)
        //decimal totalPay = getData.Sum(c => c.payout);
        //decimal totalpaid = getData.Sum(c => c.pinvalue); // Example fallback
        //decimal totalself = getData.Sum(c => c.selfvalue); // Example fallback

        //CultureInfo indian = new CultureInfo("hi-IN");

        //lblpaid.Text = totalpaid.ToString("C", indian);     // ₹ formatted
        //lblself.Text = totalself.ToString("C", indian);     // ₹ formatted
        //lblpayout.Text = totalPay.ToString("C", indian);    // ₹ formatted
        //// Step 5: Bind to GridView
        //GridView1.DataSource = getData;
        //GridView1.DataBind();
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        if (TextBox1.Text == string.Empty || TextBox2.Text == string.Empty)
        {
            return;
        }
        else
        {

            bind(Convert.ToDateTime(TextBox1.Text), Convert.ToDateTime(TextBox2.Text));
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = TextBox2.Text = string.Empty;
        bind();
    }


}