
<%@ Page Title="Withdraw History" Language="C#" MasterPageFile="admin.master"
    AutoEventWireup="true" CodeFile="withdraw-history.aspx.cs"
    Inherits="admin_withdraw_history" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .withdraw-page {
            padding-bottom: 25px;
        }

        .withdraw-card {
            background: #fff;
            border: 1px solid #e8edf3;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(25, 42, 70, 0.06);
            margin-bottom: 22px;
            overflow: hidden;
        }

        .withdraw-card-header {
            padding: 18px 22px;
            border-bottom: 1px solid #edf0f4;
            background: #fafbfd;
        }

        .withdraw-card-header h3 {
            margin: 0;
            color: #263449;
            font-size: 17px;
            font-weight: 700;
        }

        .withdraw-card-body {
            padding: 22px;
        }

        .withdraw-filter-row {
            display: flex;
            align-items: flex-end;
            flex-wrap: wrap;
            gap: 16px;
        }

        .withdraw-filter-field {
            flex: 1 1 180px;
            min-width: 0;
        }

        .withdraw-filter-field label {
            display: block;
            margin-bottom: 8px;
            color: #475467;
            font-size: 13px;
            font-weight: 600;
        }

        .withdraw-filter-input {
            display: block;
            width: 100%;
            height: 42px;
            padding: 8px 12px;
            border: 1px solid #d8dee8;
            border-radius: 7px;
            background: #fff;
            color: #263449;
            font-size: 14px;
            box-sizing: border-box;
        }

        .withdraw-filter-input:focus {
            border-color: #3869d4;
            outline: none;
            box-shadow: 0 0 0 3px rgba(56, 105, 212, 0.12);
        }

        .withdraw-btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-height: 42px;
            padding: 10px 22px;
            border: 0;
            border-radius: 7px;
            color: #fff !important;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none !important;
            transition: background 0.2s ease;
        }

        .withdraw-btn-search {
            background: #315fcb;
        }

        .withdraw-btn-search:hover {
            background: #244da9;
        }

        .withdraw-btn-export {
            background: #198754;
        }

        .withdraw-btn-export:hover {
            background: #146c43;
        }

        .withdraw-toolbar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 16px;
        }

        .withdraw-message {
            display: block;
            padding: 10px 14px;
            margin: 0 0 15px;
            border-radius: 6px;
            background: #fff1f0;
            color: #c62828;
            font-size: 13px;
        }

        .withdraw-grid-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid #e7ebf1;
            border-radius: 8px;
        }

        .withdraw-grid {
            width: 100%;
            min-width: 760px;
            margin: 0;
            border-collapse: collapse;
            background: #fff;
        }

        .withdraw-grid th {
            padding: 13px 12px;
            background: #1f5fc0;
            color: #fff;
            border: 0;
            text-align: left;
            white-space: nowrap;
            font-size: 13px;
            font-weight: 600;
        }

        .withdraw-grid td {
            padding: 12px;
            color: #475467;
            border-top: 1px solid #edf0f4;
            vertical-align: middle;
            font-size: 13px;
        }

        .withdraw-grid tr:nth-child(even) td {
            background: #f8faff;
        }

        .withdraw-grid tr:hover td {
            background: #eef4ff;
        }

        .withdraw-grid td:first-child,
        .withdraw-grid th:first-child {
            text-align: center;
        }

        .withdraw-grid td:nth-child(6) {
            color: #198754;
            font-weight: 700;
            white-space: nowrap;
        }

        .withdraw-grid td:nth-child(4),
        .withdraw-grid td:nth-child(5) {
            white-space: nowrap;
        }

        .withdraw-grid a {
            color: #315fcb;
            font-weight: 600;
        }

        @media (max-width: 767px) {
            .withdraw-card-header {
                padding: 15px;
            }

            .withdraw-card-body {
                padding: 15px;
            }

            .withdraw-filter-row {
                flex-direction: column;
                align-items: stretch;
                gap: 14px;
            }

            .withdraw-filter-field {
                flex: 1 1 auto;
                width: 100%;
            }

            .withdraw-filter-field .withdraw-btn {
                width: 100%;
                box-sizing: border-box;
            }

            .withdraw-toolbar {
                margin-bottom: 12px;
            }

            .withdraw-toolbar .withdraw-btn {
                width: 100%;
            }

            .withdraw-grid {
                min-width: 760px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="wrapper main-wrapper row withdraw-page">

        <!-- Page Header -->
        <div class="col-xs-12">
            <div class="page-title">
                <div class="pull-left">
                    <h1 class="title">Withdraw History</h1>
                </div>

                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li>
                            <a href="dashboard.aspx">
                                <i class="fa fa-home"></i> Home
                            </a>
                        </li>
                        <li class="active">
                            <strong>Withdraw History</strong>
                        </li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <!-- Main Content -->
        <div class="col-lg-12 col-sm-12 col-xs-12">

            <!-- Date Filter Card -->
            <div class="withdraw-card">

                <div class="withdraw-card-header">
                    <h3>
                        <i class="fa fa-filter"></i>
                        Filter Withdrawal Records
                    </h3>
                </div>

                <div class="withdraw-card-body">

                    <div class="withdraw-filter-row">

                        <div class="withdraw-filter-field">
                            <label for="<%= TextBox1.ClientID %>">
                                Start Date
                            </label>

                            <asp:TextBox ID="TextBox1"
                                TextMode="Date"
                                runat="server"
                                CssClass="withdraw-filter-input">
                            </asp:TextBox>
                        </div>

                        <div class="withdraw-filter-field">
                            <label for="<%= TextBox2.ClientID %>">
                                End Date
                            </label>

                            <asp:TextBox ID="TextBox2"
                                TextMode="Date"
                                runat="server"
                                CssClass="withdraw-filter-input">
                            </asp:TextBox>
                        </div>

                        <div class="withdraw-filter-field">
                            <asp:Button ID="Button1"
                                runat="server"
                                Text="Search Records"
                                CssClass="withdraw-btn withdraw-btn-search"
                                OnClick="Button1_Click" />
                        </div>

                    </div>

                </div>
            </div>

            <!-- Withdrawal History Card -->
            <div class="withdraw-card">

                <div class="withdraw-card-header">
                    <h3>
                        <i class="fa fa-history"></i>
                        Withdrawal History
                    </h3>
                </div>

                <div class="withdraw-card-body">

                    <div class="withdraw-toolbar">
                        <asp:Button ID="Button3"
                            runat="server"
                            Text="Export Excel"
                            CssClass="withdraw-btn withdraw-btn-export"
                            OnClick="Button3_Click" />
                    </div>

                    <asp:Label ID="Label1"
                        runat="server"
                        CssClass="withdraw-message"
                        Text=""
                        Visible="False">
                    </asp:Label>

                    <!-- Responsive GridView -->
                    <div class="withdraw-grid-wrap">

                        <asp:GridView ID="GridView1"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table withdraw-grid"
                            HeaderStyle-ForeColor="White"
                            PagerStyle-CssClass="PagerStyle"
                            EmptyDataText="No withdrawal records found."
                            PageSize="50"
                            OnRowDataBound="GridView1_RowDataBound"
                            GridLines="None">

                            <Columns>

                                <asp:TemplateField HeaderText="S.No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNO"
                                            runat="server"
                                            Text='<%# Container.DataItemIndex + 1 %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField
                                    DataField="transaction"
                                    HeaderText="Transaction No" />

                                <asp:BoundField
                                    DataField="name"
                                    HeaderText="Name" />

                                <asp:BoundField
                                    DataField="date"
                                    DataFormatString="{0:dd-MM-yyyy}"
                                    HeaderText="Request Date"
                                    SortExpression="date" />

                                <asp:BoundField
                                    DataField="paiddate"
                                    DataFormatString="{0:dd-MM-yyyy}"
                                    HeaderText="Paid Date"
                                    SortExpression="paiddate" />

                                <asp:BoundField
                                    DataField="amount"
                                    HeaderText="Amount (₹)"
                                    DataFormatString="{0:N2}"
                                    SortExpression="amount" />

                                <asp:BoundField
                                    DataField="status"
                                    HeaderText="Status"
                                    SortExpression="status" />

                            </Columns>

                            <HeaderStyle BackColor="#1f5fc0" />

                        </asp:GridView>

                    </div>

                </div>
            </div>

        </div>
    </div>

</asp:Content>
