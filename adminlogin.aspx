
<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="adminlogin.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .admin-login-page {
            min-height: 78vh;
            padding: 55px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            background:
                radial-gradient(circle at 10% 10%, rgba(59,130,246,.10), transparent 32%),
                radial-gradient(circle at 90% 90%, rgba(14,165,233,.10), transparent 32%),
                #f5f7fc;
        }

        .admin-login-card {
            width: 100%;
            max-width: 440px;
            padding: 42px 38px;
            background: #ffffff;
            border: 1px solid #e8edf5;
            border-radius: 22px;
            box-shadow: 0 20px 55px rgba(15, 23, 42, .10);
        }

        .admin-brand {
            text-align: center;
            margin-bottom: 30px;
        }

        .admin-brand img {
            width: 165px;
            max-width: 100%;
            height: auto;
            object-fit: contain;
            margin-bottom: 20px;
        }

        .admin-brand h2 {
            color: #172554;
            font-size: 27px;
            font-weight: 750;
            margin: 0 0 8px;
            letter-spacing: -.5px;
        }

        .admin-brand p {
            color: #64748b;
            font-size: 14px;
            margin: 0;
        }

        .admin-field {
            margin-bottom: 21px;
        }

        .admin-field label {
            display: block;
            margin-bottom: 8px;
            color: #334155;
            font-size: 13px;
            font-weight: 650;
        }

        .admin-input-wrap {
            position: relative;
        }

        .admin-input {
            display: block;
            width: 100%;
            height: 51px;
            padding: 12px 15px;
            border: 1px solid #dce3ed;
            border-radius: 11px;
            background: #f8fafc;
            color: #0f172a;
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
            transition: border-color .2s, box-shadow .2s, background .2s;
        }

        .admin-input:focus {
            background: #ffffff;
            border-color: #2563eb;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, .10);
        }

        .admin-input::placeholder {
            color: #94a3b8;
        }

        .admin-login-btn {
            display: block;
            width: 100%;
            min-height: 51px;
            border: 0;
            border-radius: 11px;
            background: linear-gradient(135deg, #1d4ed8, #2563eb 55%, #0284c7);
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: .3px;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(37, 99, 235, .22);
            transition: transform .2s, box-shadow .2s;
        }

        .admin-login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, .30);
        }

        .admin-login-btn:active {
            transform: translateY(0);
        }

        .admin-message {
            display: block;
            margin-bottom: 18px;
            padding: 11px 13px;
            border: 1px solid #fecaca;
            border-radius: 9px;
            background: #fef2f2;
            color: #b91c1c;
            font-size: 13px;
            line-height: 1.5;
        }

        .admin-security-note {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            margin-top: 25px;
            color: #94a3b8;
            font-size: 12px;
            text-align: center;
        }

        .admin-security-note span {
            color: #16a34a;
        }

        @media (max-width: 480px) {
            .admin-login-page {
                padding: 30px 15px;
                min-height: 70vh;
            }

            .admin-login-card {
                padding: 32px 23px;
                border-radius: 17px;
            }

            .admin-brand h2 {
                font-size: 24px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="admin-login-page">
        <div class="admin-login-card">

            <div class="admin-brand">
                <img src="./nairuthyalogo.png" alt="Company Logo" />
                <h2>Admin Login</h2>
                <p>Sign in to access your administration panel.</p>
            </div>

            <asp:Label ID="Label1" runat="server"
                Visible="False"
                CssClass="admin-message"
                EnableViewState="false">
            </asp:Label>

            <div class="admin-field">
                <label for="<%= userid.ClientID %>">User ID</label>
                <div class="admin-input-wrap">
                    <input type="text"
                        id="userid"
                        runat="server"
                        class="admin-input"
                        placeholder="Enter your user ID"
                        autocomplete="username"
                        required="required" />
                </div>
            </div>

            <div class="admin-field">
                <label for="<%= psswd.ClientID %>">Password</label>
                <div class="admin-input-wrap">
                    <input type="password"
                        id="psswd"
                        runat="server"
                        class="admin-input"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required="required" />
                </div>
            </div>

            <div class="admin-field">
                <asp:Button ID="Button1"
                    runat="server"
                    Text="Sign In to Dashboard"
                    OnClick="login_click"
                    CssClass="admin-login-btn" />
            </div>

            <div class="admin-security-note">
                <span>●</span>
                Authorized administrators only
            </div>

        </div>
    </section>

</asp:Content>
