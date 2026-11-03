using System;
using System.Collections;
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
        if (!IsPostBack)
        {
            VerifyAndRegister();
        }
    }
    private void VerifyAndRegister()
    {
        try
        {
            string orderId =
                Request.QueryString["order_id"];

            if (string.IsNullOrWhiteSpace(orderId))
            {
                ShowMessage("Invalid payment order.");
                return;
            }

            // Find pending registration
            var pending = db.tblPendingRegistrations
                .FirstOrDefault(x => x.OrderId == orderId);

            if (pending == null)
            {
                ShowMessage("Registration details not found.");
                return;
            }

            // Already registered
            if (pending.PaymentStatus == "Completed")
            {
                ShowMessage(
                    "Your registration is already completed. " +
                    "Member ID: " + pending.MemberUsername
                );
                return;
            }

            // Fetch order directly from Cashfree
            Dictionary<string, object> order =
                CashfreeHelper.FetchOrder(orderId);

            string orderStatus =
                Convert.ToString(order["order_status"]);

            if (orderStatus != "PAID")
            {
                ShowMessage(
                    "Payment is not confirmed yet. " +
                    "Please contact support if your amount was deducted."
                );
                return;
            }

            // Verify amount and currency
            decimal cashfreeAmount =
                Convert.ToDecimal(order["order_amount"]);

            string currency =
                Convert.ToString(order["order_currency"]);

            if (currency != "INR" ||
                cashfreeAmount != pending.GrandTotal)
            {
                ShowMessage(
                    "Payment amount verification failed. Please contact support."
                );
                return;
            }

            // Fetch individual payment transactions
            ArrayList payments =
                CashfreeHelper.FetchPayments(orderId);

            bool paymentSuccess = false;

            foreach (object item in payments)
            {
                Dictionary<string, object> payment =
                    item as Dictionary<string, object>;

                if (payment == null)
                    continue;

                string status =
                    Convert.ToString(payment["payment_status"]);

                if (status == "SUCCESS")
                {
                    decimal paidAmount =
                        Convert.ToDecimal(payment["payment_amount"]);

                    string paidCurrency =
                        Convert.ToString(payment["payment_currency"]);

                    if (paidAmount == pending.GrandTotal &&
                        paidCurrency == "INR")
                    {
                        paymentSuccess = true;
                        break;
                    }
                }
            }

            if (!paymentSuccess)
            {
                ShowMessage(
                    "Successful payment transaction not found."
                );
                return;
            }

            // Create member only after verified payment
            RegisterPaidMember(pending);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Trace.TraceError(
                "Cashfree Verification Error: " + ex.ToString()
            );

            ShowMessage(
                "Unable to verify payment currently. " +
                "Please contact support with your order ID."
            );
        }
    }

    private void RegisterPaidMember(
        tblPendingRegistration pending)
    {
        // If previous execution inserted the member
        // but did not update pending status, do not insert again.

        if (!string.IsNullOrWhiteSpace(pending.MemberUsername))
        {
            var existing = db.tblMembers.FirstOrDefault(
                x => x.username == pending.MemberUsername
            );

            if (existing != null)
            {
                pending.PaymentStatus = "Completed";
                pending.PaidDate = DateTime.UtcNow.AddHours(5.5);

                db.SubmitChanges();

                ShowSuccess(existing.username);
                return;
            }
        }

        // Generate username using existing logic
        string username = GenerateUsername();

        pending.MemberUsername = username;
        pending.PaymentStatus = "Processing";

        // Save username before member insertion.
        db.SubmitChanges();

        tblMember member = new tblMember();

        member.username = username;
        member.name = pending.Name;
        member.mobile = pending.Mobile;
        member.pan = pending.PAN;

        member.account = pending.AccountNo;
        member.ifsc = pending.IFSC;
        member.bankname = pending.BankName;
        member.branch = pending.Branch;

        member.noOfunits = pending.NoOfUnits;

        member.amount = pending.Amount;
        member.handlingCharge = pending.HandlingCharge;
        member.grandTotal = pending.GrandTotal;

        member.isActive = 1;
        member.joindate = DateTime.UtcNow.AddHours(5.5);

        member.credit = 0;
        member.debit = 0;
        member.status = "Active";

        db.tblMembers.InsertOnSubmit(member);
        db.SubmitChanges();

        // Mark payment registration completed
        pending.PaymentStatus = "Completed";
        pending.PaidDate = DateTime.UtcNow.AddHours(5.5);

        db.SubmitChanges();

        ShowSuccess(pending.Name);
    }

    private string GenerateUsername()
    {
        List<string> usernames = db.tblMembers
            .Where(x => x.username.StartsWith("N"))
            .Select(x => x.username)
            .ToList();

        int maxNumber = 0;

        foreach (string username in usernames)
        {
            int number;

            if (username.Length > 1 &&
                int.TryParse(username.Substring(1), out number))
            {
                if (number > maxNumber)
                    maxNumber = number;
            }
        }

        return "N" + (maxNumber + 1).ToString();
    }

    private void ShowSuccess(string username)
    {
        lblStatus.ForeColor =
            System.Drawing.Color.Green;

        lblStatus.Text =
            "Payment successful! Your account has been created. " +
            "Your Member ID is: " +
            HttpUtility.HtmlEncode(username);

        // Optional redirect after showing success.
        // Response.Redirect("subscribe.aspx?pro=sub", false);
        // Context.ApplicationInstance.CompleteRequest();
    }

    private void ShowMessage(string message)
    {
        lblStatus.ForeColor =
            System.Drawing.Color.Red;

        lblStatus.Text =
            HttpUtility.HtmlEncode(message);
    }
}