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

            // 6. Validate units: strictly greater than 1000
            int units;

            if (!int.TryParse(txtUnits.Value, out units) || units < 1000)
            {
                ShowError("No. of units must be greater than 1000.");
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
            decimal amount = units * 50m;
            decimal handlingCharges = Math.Round(
                amount * 0.004m, 2, MidpointRounding.AwayFromZero);

            decimal grandTotal = amount + handlingCharges;



            // Create pending registration
            tblPendingRegistration pending =
                new tblPendingRegistration();

            pending.Name = name;
            pending.Mobile = mobile;
            pending.PAN = pan;
            pending.AccountNo = accountNo;
            pending.IFSC = ifsc;
            pending.BankName = bankName;
            pending.Branch = branchName;

            pending.NoOfUnits = units;
            pending.Amount = amount;
            pending.HandlingCharge = handlingCharges;
            pending.GrandTotal = grandTotal;

            // Unique Cashfree order ID
            string orderId = "REG_" +
                Guid.NewGuid().ToString("N");

            pending.OrderId = orderId;
            pending.PaymentStatus = "Pending";
            pending.CreatedDate = DateTime.UtcNow.AddHours(5.5);

            db.tblPendingRegistrations.InsertOnSubmit(pending);
            db.SubmitChanges();

            try
            {
                // Create Cashfree order
                Dictionary<string, object> cfResponse =
                    CashfreeHelper.CreateOrder(
                        orderId,
                        grandTotal,
                        name,
                        mobile
                    );

                string paymentSessionId =
                    Convert.ToString(
                        cfResponse["payment_session_id"]);

                string cfOrderId =
                    Convert.ToString(
                        cfResponse["cf_order_id"]);

                if (string.IsNullOrWhiteSpace(paymentSessionId))
                    throw new Exception("Cashfree payment session not received.");

                pending.PaymentSessionId = paymentSessionId;
                pending.CFOrderId = cfOrderId;

                db.SubmitChanges();

                // Open Cashfree checkout
                JavaScriptSerializer serializer =
                    new JavaScriptSerializer();

                string sessionJson =
                    new System.Web.Script.Serialization.JavaScriptSerializer()
                    .Serialize(paymentSessionId);

                                string script = @"
                                    (function () {
                                        if (typeof Cashfree !== 'function') {
                                            alert('Cashfree SDK could not be loaded. Please refresh and try again.');
                                            return;
                                        }

                                        var cashfree = Cashfree({
                                            mode: 'sandbox'
                                        });

                                        cashfree.checkout({
                                            paymentSessionId: " + sessionJson + @",
                                            redirectTarget: '_self'
                                        }).then(function (result) {
                                            console.log('Cashfree checkout result:', result);
                                        }).catch(function (error) {
                                            console.error('Cashfree checkout error:', error);
                                            alert('Unable to open Cashfree payment screen.');
                                        });
                                    })();
                                ";

                ScriptManager.RegisterStartupScript(
                    this,
                    this.GetType(),
                    "OpenCashfreeCheckout",
                    script,
                    true
                );


                //string sessionJson =
                //    serializer.Serialize(paymentSessionId);

                //string script =
                //    "var cashfree = Cashfree({mode:'sandbox'});" +
                //    "cashfree.checkout({" +
                //    "paymentSessionId:" + sessionJson + "," +
                //    "redirectTarget:'_self'" +
                //    "});";

                //ClientScript.RegisterStartupScript(
                //    this.GetType(),
                //    "CashfreeCheckout",
                //    script,
                //    true
                //);
            }
            catch (Exception ex)
            {
                LogRegistrationError(ex);

                ShowError(
                    "Unable to initiate payment. Please try again."
                );
            }

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