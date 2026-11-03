using Org.BouncyCastle.Asn1.Ocsp;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_walletReport : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string admin = Session["admin"].ToString();

            if (!IsPostBack)
            {
                LoadDividendDetails();

                if (Request.QueryString["v"]=="s")
                {
                    lblMessage.Text =
                              "Dividend distributed successfully";
                }
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }

    private void LoadDividendDetails()
    {
        DateTime cutoffDate = DateTime.Now.AddDays(-30);

        var eligibleMembers = db.tblMembers.Where(m =>
            m.status == "Active" &&
            m.joindate < cutoffDate);

        // Total eligible members
        int totalMembers = eligibleMembers.Count();

        // Total shares for eligible members
        int totalShares = eligibleMembers.Sum(
            m => (int?)m.noOfunits) ?? 0;

        lblEligibleMembers.Text = totalMembers.ToString();
        lblTotalShares.Text = totalShares.ToString();

        CalculateTotalDividend(totalShares);
    }
    private void CalculateTotalDividend(int totalShares)
    {
        decimal bonusPerShare = 0;

        if (!decimal.TryParse(
            txtBonusPerShare.Text,
            NumberStyles.Number,
            CultureInfo.InvariantCulture,
            out bonusPerShare) || bonusPerShare < 0)
        {
            lblTotalDividend.Text = "0.00";
            return;
        }

        decimal totalDividend = totalShares * bonusPerShare;

        lblTotalDividend.Text = totalDividend.ToString("0.00");
    }

    protected void txtBonusPerShare_TextChanged(object sender, EventArgs e)
    {
        // Reload counts from the database and recalculate on the server.
        LoadDividendDetails();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Data.Common.DbTransaction transaction = null;

        try
        {
            // Validate admin session
            if (Session["admin"] == null)
            {
                Response.Redirect("../adminlogin.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Validate bonus per share
            decimal bonusPerShare;

            if (!decimal.TryParse(
                txtBonusPerShare.Text,
                NumberStyles.Number,
                CultureInfo.InvariantCulture,
                out bonusPerShare) ||
                bonusPerShare <= 0)
            {
                lblMessage.Text = "Enter a valid bonus per share greater than zero.";
                return;
            }

            // Validate remarks
            string remarks = txtRemarks.Text.Trim();

            if (string.IsNullOrWhiteSpace(remarks))
            {
                lblMessage.Text = "Please enter remarks.";
                return;
            }


            // Eligibility cutoff
            DateTime now = DateTime.UtcNow.AddHours(5.5);
            DateTime cutoffDate = now.AddDays(-30).Date;

            // Open a database transaction
            if (db.Connection.State != System.Data.ConnectionState.Open)
                db.Connection.Open();

            transaction = db.Connection.BeginTransaction();
            db.Transaction = transaction;

            // Get eligible members
            var eligibleMembers = db.tblMembers
                .Where(m =>
                    m.status == "Active" &&
                    m.joindate.Value.Date < cutoffDate)
                .ToList();

            if (eligibleMembers.Count == 0)
            {
                transaction.Rollback();
                lblMessage.Text = "No eligible members found.";
                return;
            }

            // Calculate shares
            decimal totalShares = eligibleMembers.Sum(
                m => Convert.ToDecimal(m.noOfunits));

            if (totalShares <= 0)
            {
                transaction.Rollback();
                lblMessage.Text = "No eligible shares found.";
                return;
            }

            decimal totalDividend = totalShares * bonusPerShare;

            // Unique reference per member and dividend period
            int processed = 0;

            foreach (var member in eligibleMembers)
            {
                decimal units = Convert.ToDecimal(member.noOfunits);

                if (units <= 0)
                    continue;

                decimal memberDividend = Math.Round(
                    units * bonusPerShare, 2,
                    MidpointRounding.AwayFromZero);

                if (memberDividend <= 0)
                    continue;

                // Add dividend to member credit
                member.credit = (member.credit ?? 0) + memberDividend;

                // Insert transaction record
                Payout payout = new Payout();

                payout.username = member.username;
                payout.desc = "Dividend Bonus";
                payout.credit = memberDividend;
                payout.debit = 0;
                payout.tax = 0;
                payout.netpayout = memberDividend;
                payout.date = now.Date;
                payout.confirmdate = now;
                payout.status = "Send";
                payout.incomefrom = "Dividend";
                payout.remarks = remarks;
                payout.units = member.noOfunits;
                payout.perShare = bonusPerShare;

                db.Payouts.InsertOnSubmit(payout);

                processed++;
            }

            if (processed == 0)
            {
                transaction.Rollback();
                lblMessage.Text = "No positive dividend amounts to distribute.";
                return;
            }

            var dividendRecord = new tbldivident
            {
               TotalEligibleMembers = eligibleMembers.Count,
               TotalShares = totalShares,
               DividendPerShare = bonusPerShare,
               TotalDividendBonus = totalDividend,
               Remarks = remarks,
               DividendDate = now
            };
            db.tbldividents.InsertOnSubmit(dividendRecord);

            // Save member credits and payout records together
            db.SubmitChanges();
            transaction.Commit();

            Response.Redirect("generate-divident.aspx?v=s", false);
          
        }
        catch (Exception ex)
        {
            if (transaction != null)
            {
                try
                {
                    transaction.Rollback();
                }
                catch
                {
                    // Transaction may already have been rolled back.
                }
            }

            // Log ex using your application's existing logging mechanism.
            lblMessage.Text =
                "Dividend generation failed. No transaction was committed.";
        }
        finally
        {
            if (db.Transaction != null)
                db.Transaction = null;

            if (db.Connection.State == System.Data.ConnectionState.Open)
                db.Connection.Close();
        }
    }
}