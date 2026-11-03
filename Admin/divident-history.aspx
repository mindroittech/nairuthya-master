
<%@ Page Title="Divident History" Language="C#" MasterPageFile="~/Admin/admin.master"
    AutoEventWireup="true" CodeFile="divident-history.aspx.cs" Inherits="Admin_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /* Keep the original master-page header styling unchanged */

        .ih-page {
            padding-bottom: 25px;
        }

        .ih-card {
            background: #fff;
            border: 1px solid #e8edf3;
            border-radius: 10px;
            box-shadow: 0 3px 14px rgba(31, 45, 61, .05);
            margin-bottom: 22px;
            overflow: hidden;
        }

        .ih-card-header {
            padding: 16px 20px;
            border-bottom: 1px solid #edf0f4;
            background: #fff;
        }

        .ih-card-header h3 {
            margin: 0;
            font-size: 17px;
            font-weight: 700;
            color: #263445;
        }

        .ih-card-header p {
            margin: 5px 0 0;
            color: #8994a3;
            font-size: 12px;
        }

        .ih-card-body {
            padding: 20px;
        }

        .ih-filters {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            align-items: end;
        }

        .ih-field {
            min-width: 0;
        }

        .ih-field label {
            display: block;
            margin-bottom: 7px;
            color: #475467;
            font-size: 13px;
            font-weight: 600;
        }

        .ih-control {
            display: block;
            width: 100%;
            height: 42px;
            padding: 8px 11px;
            border: 1px solid #dce3eb;
            border-radius: 6px;
            background: #fff;
            color: #344054;
            font-size: 13px;
            box-sizing: border-box;
        }

        .ih-control:focus {
            outline: none;
            border-color: #198754;
            box-shadow: 0 0 0 2px rgba(25, 135, 84, .10);
        }

        .ih-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 9px;
            grid-column: 1 / -1;
            margin-top: 2px;
        }

        .ih-btn {
            height: 41px;
            padding: 0 22px;
            border: 0;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
        }

        .ih-btn-search {
            background: #198754;
            color: #fff;
        }

        .ih-btn-search:hover {
            background: #146c43;
        }

        .ih-reset {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 41px;
            padding: 0 16px;
            border: 1px solid #dce3eb;
            border-radius: 6px;
            background: #fff;
            color: #475467;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
        }

        .ih-reset:hover {
            color: #198754;
            border-color: #198754;
            text-decoration: none;
        }

        .ih-alert {
            display: block;
            margin-bottom: 16px;
            padding: 11px 14px;
            border: 1px solid #ffd7d4;
            border-radius: 6px;
            background: #fff1f0;
            color: #c62828;
            font-size: 13px;
        }

        /* Investment table */
        .ih-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .ih-table {
            width: 100%;
            min-width: 850px;
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 13px;
        }

        /* Preserve the original green table-header appearance */
        .ih-table th {
            padding: 13px 12px !important;
            background: #1f5fc0 !important;
            color: #fff !important;
            border: 0 !important;
            white-space: nowrap;
            font-weight: 600;
            vertical-align: middle !important;
        }

        .ih-table td {
            padding: 12px !important;
            color: #475467;
            border-top: 1px solid #edf0f4 !important;
            vertical-align: middle !important;
            white-space: nowrap;
        }

        .ih-table tbody tr:hover td {
            background: #f6fbf7;
        }

        .ih-table .ih-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #e8f7ee;
            color: #187747;
            font-size: 11px;
            font-weight: 700;
        }

        .ih-table .ih-status-inactive {
            background: #fff0f0;
            color: #c62828;
        }

        .ih-table .ih-status-pending {
            background: #fff4df;
            color: #946200;
        }

        .ih-table td a {
            font-weight: 600;
        }

        .ih-table .ih-pager td {
            padding: 12px !important;
            background: #fff;
            white-space: normal;
        }

        .ih-table .ih-pager a,
        .ih-table .ih-pager span {
            display: inline-block;
            margin: 2px;
            padding: 6px 10px;
            border: 1px solid #dce3eb;
            border-radius: 5px;
            text-decoration: none;
        }

        .ih-table .ih-pager span {
            background: green;
            border-color: green;
            color: #fff;
        }

        .ih-scroll-note {
            display: none;
            padding: 10px 15px;
            border-top: 1px solid #edf0f4;
            color: #7b8794;
            font-size: 12px;
        }

        @media (max-width: 991px) {
            .ih-filters {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 575px) {
            .ih-card-body {
                padding: 14px;
            }

            .ih-card-header {
                padding: 14px;
            }

            .ih-filters {
                grid-template-columns: 1fr;
                gap: 13px;
            }

            .ih-actions {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }

            .ih-btn,
            .ih-reset {
                width: 100%;
                padding-left: 8px;
                padding-right: 8px;
                box-sizing: border-box;
            }

            .ih-scroll-note {
                display: block;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="wrapper main-wrapper row ih-page">
        <div class="col-xs-12">

            <!-- ORIGINAL PAGE HEADER: styling and markup preserved -->
            <div class="page-title">
                <div class="pull-left">
                    <h1 class="title">Divident History</h1>
                </div>

                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li>
                            <a href="dashboard.aspx">
                                <i class="fa fa-home"></i>Home
                            </a>
                        </li>
                        <li class="active">
                            <strong>Divident History</strong>
                        </li>
                    </ol>
                </div>
            </div>

        </div>

        <div class="clearfix"></div>

        <!-- SEARCH FILTERS -->
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="ih-card">

                <div class="ih-card-header">
                    <h3>
                        <i class="fa fa-filter" style="margin-right:8px;color:green;"></i>
                        Search Divident
                    </h3>
                    <p>Filter Divident records by date</p>
                </div>

                <div class="ih-card-body">

                    <asp:Label ID="Label9" runat="server"
                        Text="Username does not exist"
                        CssClass="ih-alert"
                        ForeColor="Red"
                        Visible="False">
                    </asp:Label>

                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>

                    <div class="ih-filters">

                        <div class="ih-field">
                            <label for="<%= TextBox1.ClientID %>">Start Date</label>
                            <asp:TextBox ID="TextBox1" runat="server"
                                TextMode="Date"
                                CssClass="ih-control">
                            </asp:TextBox>
                        </div>

                        <div class="ih-field">
                            <label for="<%= TextBox2.ClientID %>">End Date</label>
                            <asp:TextBox ID="TextBox2" runat="server"
                                TextMode="Date"
                                CssClass="ih-control">
                            </asp:TextBox>
                        </div>

                        <div class="ih-actions">
                            <asp:Button ID="Button1" runat="server"
                                OnClick="Button1_Click"
                                CssClass="ih-btn ih-btn-search"
                                Text="Search" />

                            <asp:HyperLink ID="lnkReset" runat="server"
                                NavigateUrl="history.aspx"
                                CssClass="ih-reset">
                                <i class="fa fa-refresh" style="margin-right:6px;"></i>
                                Reset Filters
                            </asp:HyperLink>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- INVESTMENT HISTORY GRID -->
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="ih-card">

                <div class="ih-card-header">
                    <h3>
                        <i class="fa fa-history" style="margin-right:8px;color:green;"></i>
                        Divident Generated History
                    </h3>
                   <%-- <p>Investment dates, amounts, units, and status.</p>--%>
                </div>

                <div class="ih-table-wrap">

                    <asp:GridView ID="GridView1" runat="server"
                        CssClass="table table-striped table-bordered ih-table"
                        HeaderStyle-ForeColor="White"
                        AutoGenerateColumns="False"
                        PagerStyle-CssClass="ih-pager"
                     
                        EmptyDataText="No records found"
                        AllowPaging="True"
                        Width="100%"
                        PageSize="50"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        GridLines="None">

                        <Columns>

                            <asp:TemplateField HeaderText="S.No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSRNO" runat="server"
                                        Text='<%# Container.DataItemIndex + 1 %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                            </asp:TemplateField>

                            <asp:BoundField DataField="DividendDate"
                                HeaderText="Date"
                                DataFormatString="{0:dd-MMM-yyyy}"
                                HtmlEncode="False" />

                            <asp:BoundField DataField="TotalEligibleMembers"
                                HeaderText="Total Eligible Members"
                                DataFormatString="{0:N0}" />

                             <asp:BoundField DataField="TotalShares"
                                 HeaderText="Total Shares"
                                 DataFormatString="{0:N2}" />

                            <asp:BoundField DataField="DividendPerShare"
                                HeaderText="Dividend Per Share"
                                DataFormatString="{0:N2}" />

                            <asp:BoundField DataField="TotalDividendBonus"
                                HeaderText="Total Dividend Bonus"
                                DataFormatString="{0:N2}" />
                            
                            <asp:BoundField DataField="Remarks"
                                HeaderText="Remarks" />

                        </Columns>

                            <HeaderStyle BackColor="#1f5fc0" />
                    </asp:GridView>

                </div>

                <div class="ih-scroll-note">
                    <i class="fa fa-arrows-h"></i>
                    Swipe horizontally to view all investment columns.
                </div>

            </div>
        </div>

    </div>

</asp:Content>
