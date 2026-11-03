
<%@ Page Title="YOU SHINE GLOBAL — Create Account" Language="C#"
    MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="subscribe - Copy.aspx.cs" Inherits="register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap"
        rel="stylesheet" />

    <style>
        * {
            box-sizing: border-box;
        }

        html, body {
            margin: 0;
            padding: 0;
            background: #ffffff !important;
            color: #1f2937;
            font-family: 'DM Sans', Arial, sans-serif;
            overflow-x: hidden;
        }

        .page {
            min-height: 100vh;
            width: 100%;
            background: #ffffff;
            padding: 30px 15px;
        }

        .right {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            background: #ffffff !important;
        }

        .form-wrap {
            width: 100%;
            max-width: 900px;
            padding: 30px;
            background: #ffffff !important;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            box-shadow: 0 6px 30px rgba(0, 0, 0, 0.07);
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            width: 180px;
            max-width: 100%;
            height: auto;
        }

        .form-title {
            color: #172033;
            font-size: 30px;
            font-weight: 700;
            text-align: center;
            margin: 0 0 10px;
        }

        .form-sub {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.7;
            text-align: center;
            margin: 0 auto 25px;
            max-width: 600px;
        }

        .section-title {
            font-size: 17px;
            color: #172033;
            font-weight: 700;
            margin: 24px 0 16px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e5e7eb;
        }

        .fields-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 0 20px;
        }

        .field {
            min-width: 0;
            margin-bottom: 18px;
        }

        .field-full {
            grid-column: 1 / -1;
        }

        .field label {
            display: block;
            color: #374151;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 7px;
        }

        .field input {
            display: block;
            width: 100%;
            min-width: 0;
            height: 44px;
            padding: 10px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #ffffff !important;
            color: #111827 !important;
            font-family: inherit;
            font-size: 14px;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }

        .field input::placeholder {
            color: #9ca3af;
        }

        .field input:focus {
            border-color: #586eec;
            box-shadow: 0 0 0 3px rgba(88, 110, 236, 0.12);
        }

        .field input[readonly] {
            background: #f3f4f6 !important;
            font-weight: 700;
            color: #111827 !important;
            cursor: default;
        }

        .terms-row {
            display: flex;
            align-items: flex-start;
            gap: 9px;
            margin: 15px 0;
            color: #4b5563;
            font-size: 13px;
            line-height: 1.6;
        }

        .terms-row input {
            margin-top: 3px;
            flex-shrink: 0;
        }

        .terms-row a,
        .signin-cta a {
            color: #4558d4;
            text-decoration: none;
            font-weight: 600;
        }

        .terms-row a:hover,
        .signin-cta a:hover {
            text-decoration: underline;
        }

        .btn-submit {
            display: block;
            width: 100%;
            min-height: 48px;
            padding: 12px 18px;
            margin: 18px 0;
            background: #d2ae15;
            color: #172033;
            border: none;
            border-radius: 8px;
            font-family: inherit;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: background .2s, transform .2s;
        }

        .btn-submit:hover {
            background: #bfa010;
            transform: translateY(-1px);
        }

        .signin-cta {
            text-align: center;
            color: #6b7280;
            font-size: 13px;
            margin: 12px 0;
        }

        .trust-row {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 12px 25px;
            padding-top: 20px;
            margin-top: 22px;
            border-top: 1px solid #e5e7eb;
        }

        .trust-item {
            color: #6b7280;
            font-size: 12px;
        }

        .message-row {
            text-align: center;
            min-height: 25px;
            margin-bottom: 10px;
        }

        .ajax-loading-overlay {
            position: fixed;
            z-index: 999999;
            inset: 0;
            background: rgba(0, 0, 0, .25);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .ajax-loading-box {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 16px 22px;
            border-radius: 10px;
            background: #ffffff;
            color: #172033;
            box-shadow: 0 10px 35px rgba(0, 0, 0, .2);
        }

        .ajax-spinner {
            width: 21px;
            height: 21px;
            border: 3px solid #e5e7eb;
            border-top-color: #586eec;
            border-radius: 50%;
            animation: spin .7s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        @media (max-width: 600px) {
            .page {
                padding: 12px 8px;
            }

            .form-wrap {
                padding: 18px 14px;
                border-radius: 12px;
            }

            .form-title {
                font-size: 24px;
            }

            .form-sub {
                font-size: 13px;
                margin-bottom: 20px;
            }

            .fields-grid {
                grid-template-columns: minmax(0, 1fr);
                gap: 0;
            }

            .field-full {
                grid-column: auto;
            }

            .field {
                margin-bottom: 15px;
            }

            .field input {
                height: 45px;
                font-size: 14px;
            }

            .trust-row {
                gap: 10px 16px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1"
    runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <asp:UpdateProgress ID="upProgress" runat="server"
        AssociatedUpdatePanelID="upRegister">

        <ProgressTemplate>
            <div class="ajax-loading-overlay">
                <div class="ajax-loading-box">
                    <div class="ajax-spinner"></div>
                    <span>Processing...</span>
                </div>
            </div>
        </ProgressTemplate>

    </asp:UpdateProgress>

    <div class="page">
        <div class="right">

            <div class="form-wrap">

                <!-- LOGO -->
                <div class="logo">
                    <a href="/">
                        <img src="../nairuthyalogo.png"
                            alt="YOU SHINE GLOBAL" />
                    </a>
                </div>

                <h1 class="form-title">Create Your Account</h1>

                <p class="form-sub">
                    Fill in your personal, bank and transaction details below.
                    Please verify all information before submitting.
                </p>

                <asp:UpdatePanel ID="upRegister" runat="server"
                    UpdateMode="Conditional"
                    ChildrenAsTriggers="true">

                    <ContentTemplate>

                        <!-- MESSAGE -->
                        <div class="message-row">
                            <asp:Label ID="Label2" runat="server"
                                Visible="false">
                            </asp:Label>
                        </div>

                        <!-- PERSONAL DETAILS -->
                        <div class="section-title">Personal Details</div>

                        <div class="fields-grid">

                            <div class="field field-full">
                                <label for="txtName">Full Name</label>
                                <input type="text" id="txtName"
                                    runat="server"
                                    placeholder="Enter your full name"
                                    autocomplete="name"
                                    required="required" />
                            </div>

                            <div class="field">
                                <label for="txtMobile">Mobile Number</label>
                                <input type="tel" id="txtMobile"
                                    runat="server"
                                    ClientIDMode="Static"
                                    maxlength="10"
                                    inputmode="numeric"
                                    pattern="[0-9]{10}"
                                    placeholder="10-digit mobile number"
                                    autocomplete="tel"
                                    required="required" />
                            </div>

                            <div class="field">
                                <label for="txtPAN">PAN Number</label>
                                <input type="text" id="txtPAN"
                                    runat="server"
                                    ClientIDMode="Static"
                                    maxlength="10"
                                    pattern="[A-Za-z]{5}[0-9]{4}[A-Za-z]"
                                    placeholder="ABCDE1234F"
                                    style="text-transform:uppercase"
                                    required="required" />
                            </div>

                        </div>

                        <!-- BANK DETAILS -->
                        <div class="section-title">Bank Details</div>

                        <div class="fields-grid">

                            <div class="field">
                                <label for="txtAccountNo">A/c Number</label>
                                <input type="text" id="txtAccountNo"
                                    runat="server"
                                    ClientIDMode="Static"
                                    maxlength="20"
                                    inputmode="numeric"
                                    placeholder="Enter account number"
                                    autocomplete="off"
                                    required="required" />
                            </div>

                          <div class="field">
                            <label for="txtIFSC">IFSC Code</label>
                            <asp:TextBox ID="txtIFSC"
                                runat="server"
                                ClientIDMode="Static"
                                MaxLength="11"
                                AutoPostBack="true"
                                OnTextChanged="txtIFSC_TextChanged"
                                placeholder="Enter IFSC code" required
                                Style="text-transform:uppercase">
                            </asp:TextBox>
                        </div>
                            <div class="field">
                                <label for="txtBankName">Bank Name</label>
                                <input type="text" id="txtBankName"
                                    runat="server"
                                    ClientIDMode="Static"
                                    maxlength="100"
                                    placeholder="Enter bank name"
                                    required="required" />
                            </div>

                            <div class="field">
                                <label for="txtBranch">Branch</label>
                                <input type="text" id="txtBranch"
                                    runat="server"
                                    ClientIDMode="Static"
                                    maxlength="100"
                                    placeholder="Enter branch name"
                                    required="required" />
                            </div>

                        </div>

                      <!-- TRANSACTION DETAILS -->
                        <div class="section-title">Transaction Details</div>

                        <div class="fields-grid">
                            <div class="field">
                                <label for="txtUnits">No. of Units (Must be greater than 270)</label>
                                <input type="number"
                                       id="txtUnits"
                                       runat="server"
                                       ClientIDMode="Static"
                                       min="271"
                                       step="1"
                                       value="0"
                                       required="required" />
                            </div>

                            <div class="field">
                                <label for="txtAmount">Amount (₹)</label>
                                <input type="number"
                                       id="txtAmount"
                                       runat="server"
                                       ClientIDMode="Static"
                                       value="0.00"
                                       readonly="readonly" />
                            </div>

                            <div class="field">
                                <label for="txtHandling">Handling Charges (0.4%) (₹)</label>
                                <input type="number"
                                       id="txtHandling"
                                       runat="server"
                                       ClientIDMode="Static"
                                       value="0.00"
                                       readonly="readonly" />
                            </div>

                            <div class="field">
                                <label for="txtGrandTotal">Grand Total (₹)</label>
                                <input type="number"
                                       id="txtGrandTotal"
                                       runat="server"
                                       ClientIDMode="Static"
                                       value="0.00"
                                       readonly="readonly" />
                            </div>
                        </div>

                        <!-- TERMS -->
                        <div class="terms-row">
                            <input type="checkbox" id="terms"
                                runat="server"
                                required="required" />

                            <span>
                                I accept the
                                <a href="#" target="_blank">
                                    Terms &amp; Conditions
                                </a>
                            </span>
                        </div>

                        <!-- SUBMIT -->
                        <asp:Button ID="btnRegister" runat="server"
                            Text="Create Account"
                            CssClass="btn-submit"
                            OnClick="btnContinueMember_Click"
                            CausesValidation="true"
                            UseSubmitBehavior="false" />


                        <!-- TRUST BADGES -->
                        <div class="trust-row">
                            <div class="trust-item">Secure &amp; Encrypted</div>
                            <div class="trust-item">Verified Platform</div>
                            <div class="trust-item">24/5 Support</div>
                        </div>

                    </ContentTemplate>

                    <Triggers>
                        <asp:AsyncPostBackTrigger
                            ControlID="btnRegister"
                            EventName="Click" />
                    </Triggers>

                </asp:UpdatePanel>

            </div>
        </div>
    </div>

    
    <script>
        (function () {
            function calculateTotal() {
                var unitsField = document.getElementById("txtUnits");
                var amountField = document.getElementById("txtAmount");
                var handlingField = document.getElementById("txtHandling");
                var totalField = document.getElementById("txtGrandTotal");

                if (!unitsField || !amountField || !handlingField || !totalField)
                    return;

                var units = parseInt(unitsField.value, 10);

                // Keep the initial values at zero until valid units are entered.
                if (isNaN(units) || units <= 270) {
                    amountField.value = "0.00";
                    handlingField.value = "0.00";
                    totalField.value = "0.00";
                    return;
                }

                var amount = units * 10;
                var handling = amount * 0.004;
                var grandTotal = amount + handling;

                amountField.value = amount.toFixed(2);
                handlingField.value = handling.toFixed(2);
                totalField.value = grandTotal.toFixed(2);
            }

            document.addEventListener("input", function (event) {
                if (event.target && event.target.id === "txtUnits") {
                    calculateTotal();
                }
            });

            document.addEventListener("change", function (event) {
                if (event.target && event.target.id === "txtUnits") {
                    calculateTotal();
                }
            });

            calculateTotal();

            if (typeof Sys !== "undefined" &&
                Sys.WebForms &&
                Sys.WebForms.PageRequestManager) {
                Sys.WebForms.PageRequestManager.getInstance()
                    .add_endRequest(calculateTotal);
            }
        })();
    </script>
</asp:Content>
