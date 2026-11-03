using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Configuration;

public partial class admin_withdraw_request : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    sendsms sm = new sendsms();
    private static int count = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();


            if (!IsPostBack)
            {
                bind(GridView1);
                if (GridView1.Rows.Count == 0)
                {
                    Button1.Visible = false;
                }
            }
        }

        catch (Exception ex)
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("withdraw-request.aspx");
    }

    protected void Button11_Click(object sender, EventArgs e)
    {
        count++;
        DateTime? d1 = null;
        DateTime? d2 = null;
        DateTime? date = null;
        if (TextBox1.Text != string.Empty && TextBox2.Text != string.Empty)
        {
            d1 = Convert.ToDateTime(TextBox1.Text);
            d2 = Convert.ToDateTime(TextBox2.Text);
        }
        if (drpDate.SelectedValue != string.Empty)
        {
            date = Convert.ToDateTime(drpDate.SelectedValue);
        }

        bind(GridView1, d1, d2, date);

        if (GridView1.Rows.Count == 0)
        {
            Button1.Visible = false;
        }
    }

    protected void bind(GridView grdView, DateTime? d1 = null, DateTime? d2 = null, DateTime? date = null)
    {
        var getpayout = from c in db.PaymentRequests
                        join d in db.tblMembers
                        on c.username equals d.username
                        where c.status == "Pending"
                        orderby c.date
                        select new
                        {
                            c.paymentid,
                            c.username,
                            c.cashavailable,
                            amount = c.amount,
                            d.name,
                            tax = c.tax,
                            sc = c.sc,
                            netpay = c.netpay,
                            date = c.date,
                            d.bankname,
                            d.branch,
                            d.account,
                            d.ifsc,
                            c.comments,
                            c.deduction,
                           
                        };

        if (d1 != null && d2 != null)
        {

            getpayout = getpayout.Where(x => x.date >= d1 && x.date <= d2);
        }
        if (date != null)
            getpayout = getpayout.Where(x => x.date == date);

        grdView.DataSource = getpayout.OrderByDescending(x => x.date);
        grdView.DataBind();

        var list = getpayout.Select(x => x.date).Distinct();
        drpDate.Items.Clear();
        foreach (var l in list)
        {
            drpDate.Items.Add(new ListItem(l.Value.ToString("dd-MMM-yyyy"), l.Value.ToString()));

        }
        drpDate.Items.Insert(0, new ListItem("All", ""));
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "send")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            TextBox txt = row.FindControl("txtbox") as TextBox;

            PaymentRequest add = db.PaymentRequests.Where(x => x.paymentid == id).SingleOrDefault();

            add.status = "Paid";
            add.transaction = txt.Text;
            add.paiddate = DateTime.UtcNow.AddHours(5.5).Date;

            var debit = (from c in db.tblMembers
                         where c.username == add.username
                         select c).SingleOrDefault();

            var insert = new Payout();
            insert.username = add.username;
            insert.tax = 0;
            insert.debit = add.amount;
            insert.desc = "Debit";
            insert.credit = 0;
        
            insert.netpayout = 0;
            insert.status = "Send";
            insert.remarks = "Withdrawal";
            insert.date = DateTime.UtcNow.AddHours(5.5).Date;
            insert.confirmdate = DateTime.UtcNow.AddHours(5.5);
            db.Payouts.InsertOnSubmit(insert);

            debit.debit = debit.debit + add.amount;
            db.SubmitChanges();

            Response.Redirect("withdraw-request.aspx");
        }
        if (e.CommandName == "view")
        {
            string uname = e.CommandArgument.ToString();
            string url = "detail.aspx?uname=" + uname;
            string s = "window.open('" + url + "', 'popup_window', 'width=800,height=480,left=150,top=150,resizable=yes');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        }
        if (e.CommandName == "del")
        {

            int id = Convert.ToInt32(e.CommandArgument);

            PaymentRequest add = db.PaymentRequests.Where(x => x.paymentid == id).SingleOrDefault();

            add.status = "Rejected";
            add.paiddate = DateTime.UtcNow.AddHours(5.5);
            db.SubmitChanges();

            Response.Redirect("withdraw-request.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (count > 0)
            Response.Redirect("export.aspx?t=Monthly&d1=" + TextBox1.Text + "&d2=" + TextBox2.Text + "&date=" + drpDate.SelectedValue);
        else
            Response.Redirect("export.aspx?t=Monthly");
    }
}