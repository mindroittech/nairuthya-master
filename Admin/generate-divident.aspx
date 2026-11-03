<%@ Page Title="Generate Divident" Language="C#" MasterPageFile="~/Admin/admin.master"
    AutoEventWireup="true" CodeFile="generate-divident.aspx.cs" Inherits="Admin_walletReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .dividend-card {
            max-width: 750px;
            margin: 20px auto;
            padding: 30px 35px;
            background: #fff;
            border: 1px solid #e8eaf0;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .dividend-row {
            display: flex;
            align-items: center;
            margin-bottom: 22px;
            gap: 15px;
        }

        .dividend-label {
            flex: 1;
            color: #424b5a;
            font-size: 15px;
            font-weight: 500;
        }

        .dividend-value {
            min-width: 150px;
            color: #222;
            font-size: 16px;
            font-weight: 600;
        }

        .dividend-input {
            width: 190px;
            max-width: 100%;
            height: 42px;
            padding: 9px 12px;
            border: 1px solid #cfd5df;
            border-radius: 6px;
            font-size: 15px;
            color: #333;
            background: #fff;
            box-sizing: border-box;
        }

            .dividend-input:focus {
                border-color: #bd8b2d;
                outline: none;
                box-shadow: 0 0 0 3px rgba(189, 139, 45, 0.12);
            }

        .dividend-total {
            color: #16834a;
            font-size: 19px;
            font-weight: 700;
        }

        .dividend-submit {
            display: block;
            min-width: 150px;
            margin: 28px auto 0;
            padding: 11px 28px;
            background: #bd8b2d;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

            .dividend-submit:hover {
                background: #9e7020;
            }

        @media (max-width: 576px) {
            .dividend-card {
                padding: 20px 15px;
            }

            .dividend-row {
                align-items: flex-start;
                flex-direction: column;
                gap: 8px;
                margin-bottom: 20px;
            }

            .dividend-value,
            .dividend-input {
                width: 100%;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="wrapper main-wrapper row" style=''>
        <div class='col-xs-12'>
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">Generate Divident</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Generate Divident</strong> </li>
                    </ol>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <!-- MAIN CONTENT AREA STARTS -->
        <div class="col-lg-12">

            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <section class="box ">
                        <div class="content-body">

                            <div class="row" style="padding-top: 21px;">


                                <div class="col-xs-12">

                                    <div class="table-responsive">
                                        <div align="center">
                                            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"
                                                EnableViewState="false" />
                                        </div>
                                        <div class="dividend-card">

                                            <div class="dividend-row">
                                                <span class="dividend-label">Total No. of Eligible Members:
                                              </span>
                                                <asp:Label ID="lblEligibleMembers" runat="server"
                                                    CssClass="dividend-value" Text="0" />
                                            </div>

                                            <div class="dividend-row">
                                                <span class="dividend-label">Total No. of Shares:
                                              </span>
                                                <asp:Label ID="lblTotalShares" runat="server"
                                                    CssClass="dividend-value" Text="0" />
                                            </div>

                                            <div class="dividend-row">
                                                <label class="dividend-label"
                                                    for="<%= txtBonusPerShare.ClientID %>">
                                                    Dividend Bonus (₹) Per Share:
                           
                                                </label>
                                                <asp:TextBox ID="txtBonusPerShare" runat="server"
                                                    CssClass="dividend-input"
                                                    Text="0"
                                                    AutoPostBack="true"
                                                    OnTextChanged="txtBonusPerShare_TextChanged"
                                                    TextMode="Number"
                                                    step="0.01"
                                                    min="0" />
                                            </div>

                                            <div class="dividend-row">
                                                <span class="dividend-label">Total Dividend Bonus (₹):
                                                 </span>
                                                <asp:Label ID="lblTotalDividend" runat="server"
                                                    CssClass="dividend-value dividend-total"
                                                    Text="0" />
                                            </div>

                                            <div class="dividend-row">
                                                <label class="dividend-label"
                                                    for="<%= txtRemarks.ClientID %>">
                                                    Remarks:
                           
                                                </label>
                                                <asp:TextBox ID="txtRemarks" runat="server"
                                                    CssClass="dividend-input"
                                                    Text="October Bonus" />
                                            </div>

                                            <asp:Button ID="btnSubmit" runat="server"
                                                Text="SUBMIT"
                                                CssClass="dividend-submit"
                                                OnClick="btnSubmit_Click"
                                                OnClientClick="return confirm('Are you sure you want to generate the dividend?');" />


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
