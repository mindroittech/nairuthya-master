using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;

public partial class register : System.Web.UI.Page
{
    private readonly DataClassesDataContext db =
        new DataClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                if (Request.QueryString["pro"]=="sub")
                {
                    ShowSuccess("Account Created Successfull");
                }
            }
        }
        catch
        {
            ShowError(
                "Unable to load the registration page. Please try again."
            );
        }
    }
    protected void txtIFSC_TextChanged(object sender, EventArgs e)
    {
        string ifsc = txtIFSC.Text.Trim().ToUpperInvariant();

        txtIFSC.Text = ifsc;
        txtBankName.Value = "";
        txtBranch.Value = "";

        string bankName;
        string branchName;

        if (GetBankDetails(ifsc, out bankName, out branchName))
        {
            txtBankName.Value = bankName;
            txtBranch.Value = branchName;

            Label2.Text = "Bank details fetched successfully.";
        }
        else
        {
            Label2.Text = "Invalid IFSC code or unable to fetch bank details.";
        }
    }
    private bool GetBankDetails(
    string ifsc,
    out string bankName,
    out string branchName)
    {
        bankName = "";
        branchName = "";

        if (string.IsNullOrWhiteSpace(ifsc))
            return false;

        ifsc = ifsc.Trim().ToUpperInvariant();

        if (!Regex.IsMatch(ifsc, @"^[A-Z]{4}0[A-Z0-9]{6}$"))
            return false;

        try
        {
            string url = "https://ifsc.razorpay.com/" +
                         Uri.EscapeDataString(ifsc);


            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            HttpWebRequest request =
                (HttpWebRequest)WebRequest.Create(url);

            request.Method = "GET";
            request.Timeout = 10000;
            request.ReadWriteTimeout = 10000;
            request.Accept = "application/json";

            using (HttpWebResponse response =
                (HttpWebResponse)request.GetResponse())
            using (StreamReader reader =
                new StreamReader(response.GetResponseStream()))
            {
                string json = reader.ReadToEnd();

                JavaScriptSerializer serializer =
                    new JavaScriptSerializer();

                Dictionary<string, object> data =
                    serializer.Deserialize<Dictionary<string, object>>(json);

                if (data == null ||
                    !data.ContainsKey("IFSC") ||
                    !data.ContainsKey("BANK") ||
                    !data.ContainsKey("BRANCH"))
                {
                    return false;
                }

                string returnedIFSC =
                    Convert.ToString(data["IFSC"]).Trim();

                if (!string.Equals(
                    returnedIFSC, ifsc,
                    StringComparison.OrdinalIgnoreCase))
                {
                    return false;
                }

                bankName = Convert.ToString(data["BANK"]);
                branchName = Convert.ToString(data["BRANCH"]);

                return !string.IsNullOrWhiteSpace(bankName) &&
                       !string.IsNullOrWhiteSpace(branchName);
            }
        }
        catch (WebException)
        {
            // Invalid IFSC, API unavailable, or network error.
            return false;
        }
        catch (Exception)
        {
            return false;
        }
    }



    // ============================================================
    // REGISTER BUTTON
    // ============================================================

    protected void btnContinueMember_Click(
        object sender,
        EventArgs e)
    {
        ClearMessage();

        try
        {
           
            // ----------------------------------------------------
            // NAME
            // ----------------------------------------------------

            string name =
                SafeTrim(txtName.Value);


            if (string.IsNullOrWhiteSpace(name))
            {
                ShowError(
                    "Please enter your full name."
                );

                return;
            }

            // 2. Validate mobile number
            string mobile = SafeTrim(txtMobile.Value);

            if (!Regex.IsMatch(mobile, @"^[6-9][0-9]{9}$"))
            {
                ShowError("Please enter a valid 10-digit mobile number.");
                return;
            }

            // 3. Validate PAN
            string pan = SafeTrim(txtPAN.Value).ToUpperInvariant();

            if (!Regex.IsMatch(pan, @"^[A-Z]{5}[0-9]{4}[A-Z]$"))
            {
                ShowError("Please enter a valid PAN number.");
                return;
            }

            // 4. Validate bank account number
            string accountNo = SafeTrim(txtAccountNo.Value);

            if (!Regex.IsMatch(accountNo, @"^[0-9]{6,30}$"))
            {
                ShowError("Please enter a valid bank account number.");
                return;
            }

            // 5. Verify IFSC and retrieve bank details from the API
            string ifsc = txtIFSC.Text.Trim().ToUpperInvariant();
            string bankName;
            string branchName;

            if (!GetBankDetails(ifsc, out bankName, out branchName))
            {
                ShowError("Invalid IFSC or bank details could not be verified.");
                return;
            }

            // 6. Validate units: strictly greater than 270
            int units;

            if (!int.TryParse(txtUnits.Value, out units) || units <= 270)
            {
                ShowError("No. of units must be greater than 270.");
                return;
            }


            // ----------------------------------------------------
            // TERMS
            // ----------------------------------------------------

            if (!terms.Checked)
            {
                ShowError(
                    "Please accept the Terms & Conditions."
                );

                return;
            }

            // 7. Calculate all amounts on the server
            decimal amount = units * 10m;
            decimal handlingCharges = Math.Round(
                amount * 0.004m, 2, MidpointRounding.AwayFromZero);

            decimal grandTotal = amount + handlingCharges;

            tblMember member = new tblMember();

            member.username = GenerateUsername();
            member.name = name;
            member.mobile = mobile;
            member.pan = pan;
            member.account = accountNo;
            member.ifsc = ifsc;
            member.bankname = bankName;
            member.branch = branchName;
            member.noOfunits = units;
            member.handlingCharge = handlingCharges;
            member.grandTotal = grandTotal;

            // Store the base amount in the existing amount column.
            member.amount = amount;

            member.isActive = 1;
            member.joindate = DateTime.UtcNow.AddHours(5.5);
            member.credit = 0;
            member.debit = 0;
            member.status = "Active";

            db.tblMembers.InsertOnSubmit(member);

            db.SubmitChanges();

            Response.Redirect(
                "subscribe.aspx?pro=sub"
            );

            Context.ApplicationInstance.CompleteRequest();
        }
        catch (Exception ex)
        {
            /*
             * Log ex here.
             *
             * Do NOT:
             *
             * throw ex;
             *
             * because that resets the stack trace.
             */

            LogRegistrationError(ex);

            ShowError(
                "Something went wrong while creating your account. Please try again."
            );
        }
    }


    // ============================================================
    // USERNAME
    // ============================================================

    private string GenerateUsername()
    {
        List<string> usernames = db.tblMembers
            .Where(x => x.username.StartsWith("N"))
            .Select(x => x.username)
            .ToList();

        int maxNumber = 0;

        foreach (string username in usernames)
        {
            if (username.Length > 1 &&
                username.StartsWith("N", StringComparison.OrdinalIgnoreCase))
            {
                int number;

                if (int.TryParse(username.Substring(1), out number))
                {
                    if (number > maxNumber)
                        maxNumber = number;
                }
            }
        }

        return "N" + (maxNumber + 1).ToString();
    }

    private string SafeTrim(string value)
    {
        return value == null
            ? ""
            : value.Trim();
    }


    // ============================================================
    // UI HELPERS
    // ============================================================

    private void ClearMessage()
    {
        Label2.Visible = false;
        Label2.Text = "";
    }


    private void ShowError(string message)
    {
        Label2.Text =
            HttpUtility.HtmlEncode(message);

        Label2.ForeColor =
            System.Drawing.Color.Red;

        Label2.Visible =
            true;
    }


    private void ShowSuccess(string message)
    {
        Label2.Text =
            HttpUtility.HtmlEncode(message);

        Label2.ForeColor =
            System.Drawing.Color.Green;

        Label2.Visible =
            true;
    }


    // ============================================================
    // ERROR LOGGING
    // ============================================================

    private void LogRegistrationError(
        Exception ex)
    {
        /*
         * Replace this with your existing logger.
         *
         * Do not expose exception details to the user.
         */

        System.Diagnostics.Trace.TraceError(
            "Registration Error: " +
            ex.ToString()
        );
    }
}