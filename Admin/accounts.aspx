
<%@ Page Title="Account Transactions" Language="C#" MasterPageFile="admin.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="accounts.aspx.cs"
    Inherits="admin_accounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .at-page {
            padding-bottom: 25px;
        }

        .at-card {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .at-card-title {
            color: #263445;
            font-size: 16px;
            font-weight: 700;
            margin: 0 0 18px;
        }

        .at-search-label {
            display: block;
            color: #465366;
            font-weight: 600;
            margin-bottom: 7px;
        }

        .at-search-input {
            width: 100%;
            height: 42px;
            border: 1px solid #d8dee8;
            border-radius: 6px;
            box-shadow: none;
        }

        .at-search-actions {
            display: flex;
            align-items: flex-end;
            height: 100%;
            min-height: 65px;
        }

        .at-btn {
            min-height: 40px;
            border-radius: 6px;
            padding: 9px 17px;
            font-weight: 600;
        }

        .at-error {
            display: block;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .at-summary {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 18px 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .at-summary-label {
            color: #667085;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 7px;
        }

        .at-summary-value {
            color: #198754;
            font-size: 25px;
            font-weight: 700;
            overflow-wrap: anywhere;
        }

        .at-summary-debit {
            color: #dc3545;
        }

        .at-summary-icon {
            font-size: 25px;
            opacity: .8;
        }

        .at-summary-credit-icon {
            color: #198754;
        }

        .at-summary-debit-icon {
            color: #dc3545;
        }

        .at-export-row {
            margin-bottom: 15px;
        }

        .at-grid-card {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .at-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .at-grid {
            min-width: 950px;
            margin-bottom: 0;
            background: #fff;
        }

        .at-grid th {
            background-color: #1f5fc0 !important;
            color: #fff !important;
            white-space: nowrap;
            vertical-align: middle !important;
            padding: 12px 10px !important;
        }

        .at-grid td {
            padding: 10px !important;
            vertical-align: middle !important;
            overflow-wrap: anywhere;
        }

        .at-grid tr:hover td {
            background-color: #f7fafc;
        }

        @media (max-width: 767px) {
            .at-card {
                padding: 15px;
            }

            .at-search-actions {
                min-height: auto;
                display: block;
                margin-top: 5px;
            }

            .at-search-actions .btn {
                width: 100%;
            }

            .at-summary {
                padding: 15px;
                margin-bottom: 12px;
            }

            .at-summary-value {
                font-size: 22px;
            }

            .at-export-row .btn {
                width: 100%;
            }

            .at-grid-card {
                padding: 8px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="wrapper main-wrapper row at-page">
        <div class="col-xs-12">
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Account By User</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Account By User</strong> </li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <!-- Search -->
            <div class="at-card">
                <h4 class="at-card-title">
                    <i class="fa fa-search"></i> Search Account Transactions
                </h4>

                <asp:Label ID="Label9" runat="server"
                    Text="Username doesnot exist"
                    ForeColor="Red"
                    Visible="False"
                    CssClass="at-error">
                </asp:Label>

                <div class="row">
                    <div class="col-md-6 col-sm-8 col-xs-12">
                        <div class="form-group">
                            <label class="at-search-label" for="<%= TextBox1.ClientID %>">
                                Enter Name / Mobile
                            </label>
                            <asp:TextBox ID="TextBox1" runat="server"
                                CssClass="form-control at-search-input">
                            </asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-4 col-xs-12">
                        <div class="at-search-actions">
                            <asp:Button ID="Button1" runat="server"
                                Text="Search"
                                OnClick="Button1_Click"
                                CssClass="btn btn-primary at-btn" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Credit / Debit Summary -->
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="at-summary">
                        <div>
                            <div class="at-summary-label">Total Credits</div>
                            <div class="at-summary-value">
                                <asp:Label ID="Label7" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>
                        <i class="fa fa-arrow-circle-up at-summary-icon at-summary-credit-icon"></i>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="at-summary">
                        <div>
                            <div class="at-summary-label">Total Debits</div>
                            <div class="at-summary-value at-summary-debit">
                                <asp:Label ID="Label8" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>
                        <i class="fa fa-arrow-circle-down at-summary-icon at-summary-debit-icon"></i>
                    </div>
                </div>
            </div>

            <!-- Export -->
            <div class="row at-export-row">
                <div class="col-xs-12">
                    <asp:Button ID="Button2" runat="server"
                        Text="Export To Excel"
                        OnClick="Button2_Click"
                        CssClass="btn btn-success at-btn"
                        Visible="False" />
                </div>
            </div>

            <!-- Transaction Grid -->
            <div class="at-grid-card">
                <div class="at-table-wrap">
                    <asp:GridView ID="GridView1" runat="server"
                        CssClass="table table-striped table-bordered at-grid"
                        HeaderStyle-ForeColor="White"
                        AutoGenerateColumns="False"
                        PagerStyle-CssClass="PagerStyle"
                        EmptyDataText="No records found"
                        AllowPaging="True"
                        Width="100%"
                        OnRowDataBound="GridView1_RowDataBound"
                        PageSize="50"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        GridLines="None">

                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    SNo.
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSRNO" runat="server"
                                        Text='<%# Container.DataItemIndex + 1 %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                            </asp:TemplateField>

                            <asp:BoundField DataField="name" HeaderText="Name" />
                            <asp:BoundField DataField="desc" HeaderText="DESC" />
                            <asp:BoundField DataField="credit" HeaderText="Credit (Rs)" />
                            <asp:BoundField DataField="units" HeaderText="Units" />
                            <asp:BoundField DataField="perShare" HeaderText="Per Share" />
                            <asp:BoundField DataField="debit" HeaderText="Debit (Rs)" />
                            <asp:BoundField DataField="confirmdate"
                                HeaderText="Date"
                                DataFormatString="{0:dd-MMM-yyyy}" />
                            <asp:BoundField DataField="remarks" HeaderText="Remarks" />

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server"
                                        Text='<%# Eval("status") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                        <HeaderStyle BackColor="green" />
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
