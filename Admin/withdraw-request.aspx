
<%@ Page Title="Withdraw Requests" Language="C#" MasterPageFile="admin.master"
    AutoEventWireup="true" CodeFile="withdraw-request.aspx.cs"
    Inherits="admin_withdraw_request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .wr-page {
            padding-bottom: 25px;
        }

        .wr-card {
            background: #fff;
            border: 1px solid #e7ebf1;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(25, 42, 70, .06);
            margin-bottom: 22px;
            overflow: hidden;
        }

        .wr-card-header {
            padding: 17px 22px;
            background: #fafbfd;
            border-bottom: 1px solid #edf0f4;
        }

        .wr-card-header h3 {
            margin: 0;
            color: #263449;
            font-size: 17px;
            font-weight: 700;
        }

        .wr-card-body {
            padding: 22px;
        }

        .wr-filter-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
            align-items: end;
        }

        .wr-field label {
            display: block;
            margin-bottom: 8px;
            color: #475467;
            font-size: 13px;
            font-weight: 600;
        }

        .wr-input {
            width: 100%;
            height: 43px;
            padding: 9px 12px;
            border: 1px solid #d8dee8;
            border-radius: 7px;
            background: #fff;
            color: #263449;
            font-size: 14px;
            box-sizing: border-box;
        }

        .wr-input:focus {
            border-color: #315fcb;
            outline: none;
            box-shadow: 0 0 0 3px rgba(49, 95, 203, .12);
        }

        .wr-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }

        .wr-btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-height: 42px;
            padding: 10px 19px;
            border: 0;
            border-radius: 7px;
            color: #fff !important;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none !important;
            cursor: pointer;
            box-sizing: border-box;
        }

        .wr-btn-search {
            background: #315fcb;
        }

        .wr-btn-search:hover {
            background: #244da9;
        }

        .wr-btn-all {
            background: #667085;
        }

        .wr-btn-all:hover {
            background: #475467;
        }

        .wr-btn-export {
            background: #198754;
        }

        .wr-btn-export:hover {
            background: #146c43;
        }

        .wr-toolbar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 16px;
        }

        .wr-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid #e7ebf1;
            border-radius: 8px;
        }

        .wr-grid {
            width: 100%;
            min-width: 1050px;
            margin: 0;
            border-collapse: collapse;
            background: #fff;
        }

        .wr-grid th {
            padding: 13px 12px;
            background: #1f5fc0;
            color: #fff;
            border: 0;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            white-space: nowrap;
        }

        .wr-grid td {
            padding: 12px;
            color: #475467;
            border-top: 1px solid #edf0f4;
            vertical-align: middle;
            font-size: 13px;
        }

        .wr-grid tr:nth-child(even) td {
            background: #f8faff;
        }

        .wr-grid tr:hover td {
            background: #eef4ff;
        }

        .wr-grid td input[type="text"] {
            width: 145px !important;
            max-width: 100%;
            height: 36px;
            padding: 7px 9px;
            border: 1px solid #d8dee8;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .wr-grid a {
            display: inline-block;
            margin: 3px 0;
            font-weight: 600;
            text-decoration: none;
            white-space: nowrap;
        }

        .wr-grid a[id*="LinkButton1"] {
            color: #198754;
        }

        .wr-grid a[id*="LinkButton2"] {
            color: #dc3545;
        }

        .wr-help {
            margin-top: 10px;
            color: #7b8494;
            font-size: 12px;
        }

        @media (max-width: 991px) {
            .wr-filter-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .wr-filter-actions {
                grid-column: 1 / -1;
            }
        }

        @media (max-width: 575px) {
            .wr-card-header {
                padding: 15px;
            }

            .wr-card-body {
                padding: 15px;
            }

            .wr-filter-grid {
                grid-template-columns: minmax(0, 1fr);
                gap: 15px;
            }

            .wr-filter-actions {
                grid-column: auto;
            }

            .wr-filter-actions .wr-btn {
                flex: 1;
                width: 100%;
            }

            .wr-toolbar .wr-btn {
                width: 100%;
            }

            .wr-grid {
                min-width: 1050px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>

    <div class="wrapper main-wrapper row wr-page">

        <!-- Page Heading -->
        <div class="col-xs-12">
            <div class="page-title">
                <div class="pull-left">
                    <h1 class="title">Withdraw Requests</h1>
                </div>

                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li>
                            <a href="dashboard.aspx">
                                <i class="fa fa-home"></i> Home
                            </a>
                        </li>
                        <li class="active">
                            <strong>Withdraw Requests</strong>
                        </li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-lg-12 col-sm-12 col-xs-12">

            <!-- Filters -->
            <div class="wr-card">

                <div class="wr-card-header">
                    <h3>
                        <i class="fa fa-filter"></i>
                        Filter Withdrawal Requests
                    </h3>
                </div>

                <div class="wr-card-body">

                    <div class="wr-filter-grid">

                        <div class="wr-field">
                            <label for="<%= TextBox1.ClientID %>">
                                Start Date
                            </label>

                            <asp:TextBox ID="TextBox1"
                                TextMode="Date"
                                runat="server"
                                CssClass="wr-input">
                            </asp:TextBox>
                        </div>

                        <div class="wr-field">
                            <label for="<%= TextBox2.ClientID %>">
                                End Date
                            </label>

                            <asp:TextBox ID="TextBox2"
                                TextMode="Date"
                                runat="server"
                                CssClass="wr-input">
                            </asp:TextBox>
                        </div>

                        <div class="wr-field">
                            <label for="<%= drpDate.ClientID %>">
                                Date-wise
                            </label>

                            <asp:DropDownList ID="drpDate"
                                runat="server"
                                CssClass="wr-input">
                            </asp:DropDownList>
                        </div>

                        <div class="wr-filter-actions">
                            <div class="wr-actions">

                                <asp:Button ID="Button11"
                                    runat="server"
                                    Text="Search"
                                    CssClass="wr-btn wr-btn-search"
                                    OnClick="Button11_Click" />

                                <asp:Button ID="Button4"
                                    runat="server"
                                    Text="View All"
                                    CssClass="wr-btn wr-btn-all"
                                    OnClick="Button4_Click" />

                            </div>
                        </div>

                    </div>

                </div>
            </div>

            <!-- Requests Table -->
            <div class="wr-card">

                <div class="wr-card-header">
                    <h3>
                        <i class="fa fa-list-alt"></i>
                        Pending Withdrawal Requests
                    </h3>
                </div>

                <div class="wr-card-body">

                    <div class="wr-toolbar">
                        <asp:Button ID="Button1"
                            runat="server"
                            Text="Export to Excel"
                            CssClass="wr-btn wr-btn-export"
                            OnClick="Button1_Click" />
                    </div>

                    <div class="wr-table-wrap">

                        <asp:GridView ID="GridView1"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table wr-grid"
                            HeaderStyle-ForeColor="White"
                            DataKeyNames="username,sc"
                            Width="100%"
                            EmptyDataText="No withdrawal requests found."
                            OnRowCommand="GridView1_RowCommand"
                            PageSize="50"
                            GridLines="None">

                            <Columns>

                                <asp:TemplateField HeaderText="No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNO"
                                            runat="server"
                                            Text='<%# Container.DataItemIndex + 1 %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField
                                    DataField="name"
                                    HeaderText="Name"
                                    SortExpression="name" />

                                <asp:BoundField
                                    DataField="amount"
                                    HeaderText="Amount Requested (₹)"
                                    DataFormatString="{0:N2}"
                                    SortExpression="amount" />

                                <asp:BoundField
                                    DataField="date"
                                    HeaderText="Request Date"
                                    DataFormatString="{0:dd-MMM-yyyy}"
                                    SortExpression="date" />

                                <asp:BoundField
                                    DataField="account"
                                    HeaderText="Account No" />

                                <asp:BoundField
                                    DataField="ifsc"
                                    HeaderText="IFSC" />

                                <asp:BoundField
                                    DataField="bankname"
                                    HeaderText="Bank" />

                                <asp:BoundField
                                    DataField="branch"
                                    HeaderText="Branch" />

                                <asp:TemplateField HeaderText="Transaction No">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtbox"
                                            runat="server"
                                            MaxLength="100"
                                            placeholder="Enter transaction no">
                                        </asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action"
                                    ItemStyle-Width="115px">

                                    <ItemTemplate>

                                        <asp:LinkButton ID="LinkButton1"
                                            CommandName="send"
                                            CommandArgument='<%# Eval("paymentid") %>'
                                            runat="server">
                                            <i class="fa fa-check-circle"></i> Send
                                        </asp:LinkButton>

                                        <asp:ConfirmButtonExtender
                                            ID="ConfirmButtonExtender1"
                                            ConfirmOnFormSubmit="true"
                                            runat="server"
                                            ConfirmText="Are you sure you want to send?"
                                            Enabled="True"
                                            TargetControlID="LinkButton1">
                                        </asp:ConfirmButtonExtender>

                                        &nbsp; | &nbsp;

                                        <asp:LinkButton ID="LinkButton2"
                                            runat="server"
                                            CommandName="del"
                                            CommandArgument='<%# Eval("paymentid") %>'>
                                            <i class="fa fa-times-circle"></i> Reject
                                        </asp:LinkButton>

                                        <asp:ConfirmButtonExtender
                                            ID="ConfirmButtonExtender2"
                                            ConfirmOnFormSubmit="true"
                                            runat="server"
                                            ConfirmText="Are you sure you want to reject?"
                                            Enabled="True"
                                            TargetControlID="LinkButton2">
                                        </asp:ConfirmButtonExtender>

                                    </ItemTemplate>

                                    <ItemStyle Width="115px"></ItemStyle>

                                </asp:TemplateField>

                            </Columns>

                            <HeaderStyle BackColor="#1f5fc0" />

                        </asp:GridView>

                    </div>


                </div>
            </div>

        </div>
    </div>

</asp:Content>
