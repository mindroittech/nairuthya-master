using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class portal_Admin_manualDebit : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string uname = Session["admin"].ToString();
            if (Request.QueryString["v"] == "sub")
            {
                lbSuccess.InnerHtml = "Amount " + Request.QueryString["s"] + " user account successfully";
                lbSuccess.Visible = true;
            }
            if (Request.QueryString["id"] != null)
            {
                txtUser.Text = Request.QueryString["u"];
                txtUser_Changed(null, null);
               
                TextBox2.Text = Math.Round(Convert.ToDecimal(Request.QueryString["am"])).ToString();
            }
            if (!IsPostBack)
            {
                rdOption.SelectedIndex = 0;
                bind();
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../adminlogin.aspx");
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    private void bind()
    {
        var bind = from c in db.Payouts
                   join d in db.tblMembers
                   on c.username equals d.username
                   where c.desc.Contains("Wallet")
                   orderby c.confirmdate descending
                   select new
                   {
                       c.username,
                       d.name,
                       c.confirmdate,
                       c.remarks,
                       c.credit,
                       c.desc,
                       c.debit
                   };
        GridView1.DataSource = bind;
        GridView1.DataBind();
    }

    protected void txtUser_Changed(object sender, EventArgs e)
    {
        var get = db.tblMembers.Where(x => x.username == txtUser.Text.Trim()).SingleOrDefault();
        if (get != null)
        {
            lblName.InnerText = get.name;
            lbbal.InnerText = get.credit.ToString();
        }
        else
        {
            lblName.InnerText = "";
            lbbal.InnerText = "0";
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string uname = txtUser.Text.Trim();

            decimal Amount = Convert.ToDecimal(TextBox2.Text);
            var user = db.tblMembers.Where(x => x.username == uname).SingleOrDefault();
            string status = rdOption.SelectedValue == "1" ? "Credited to" : "Debited from";
            if (user == null)
            {
                lbErrormsg.InnerText = "Invalid User ID.";
                lbErrormsg.Visible = true;
                return;
            }

            if (rdOption.SelectedValue == "1")  // for credit
            {
                string desc = "";
                string remarks = txtRemarks.Text;

                user.credit = user.credit + Amount;
                desc = "Wallet Credit";

                var history = new Payout
                {
                    username = uname,
                    credit = Amount,
                    debit = 0,
                    date = DateTime.UtcNow.AddHours(5.5).Date,
                    confirmdate = DateTime.UtcNow.AddHours(5.5),
                    desc = desc,
                    remarks = remarks,
                    status = "Send",
                   // reward = user.credit + Amount
                };
                db.Payouts.InsertOnSubmit(history);
            }

            else if (rdOption.SelectedValue == "2")  // for debit
            {
                string desc = "";
                string remarks = txtRemarks.Text;

                user.credit = user.credit - Amount;
                user.debit += Amount;
                desc = "Wallet Debit";

                var history = new Payout
                {
                    username = uname,
                    credit = 0,
                    debit = Amount,
                    date = DateTime.UtcNow.AddHours(5.5).Date,
                    confirmdate = DateTime.UtcNow.AddHours(5.5),
                    desc = desc,
                    remarks = txtRemarks.Text,
                    status = "Send",
                   // reward = user.credit - Amount
                };

                db.Payouts.InsertOnSubmit(history);

            }

            db.SubmitChanges();
            Response.Redirect("manualDebit.aspx?v=sub&s=" + status);
        }
        catch (Exception ex)
        {
            lbErrormsg.InnerText = ex.Message;
        }
    }

}