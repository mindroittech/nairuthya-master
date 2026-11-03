
<%@ Page Title="View Members" Language="C#" MasterPageFile="admin.master"
    EnableEventValidation="false" AutoEventWireup="true"
    CodeFile="view-members.aspx.cs" Inherits="admin_view_members" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /* Original master-page header styles are not changed */

        .vm-card {
            background: #fff;
            border: 1px solid #e8edf3;
            border-radius: 10px;
            box-shadow: 0 3px 14px rgba(31, 45, 61, .05);
            margin-bottom: 22px;
            overflow: hidden;
        }

        .vm-card-header {
            padding: 16px 20px;
            border-bottom: 1px solid #edf0f4;
            background: #fff;
        }

        .vm-card-header h3 {
            margin: 0;
            font-size: 17px;
            font-weight: 700;
            color: #263445;
        }

        .vm-card-header p {
            margin: 5px 0 0;
            font-size: 12px;
            color: #8994a3;
        }

        .vm-card-body {
            padding: 20px;
        }

        .vm-filter-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            align-items: end;
        }

        .vm-field {
            min-width: 0;
        }

        .vm-field label {
            display: block;
            margin-bottom: 7px;
            font-size: 13px;
            font-weight: 600;
            color: #475467;
        }

        .vm-input {
            display: block;
            width: 100%;
            height: 42px;
            padding: 8px 11px;
            box-sizing: border-box;
            border: 1px solid #dce3eb;
            border-radius: 6px;
            background: #fff;
            color: #344054;
            font-size: 13px;
        }

        .vm-input:focus {
            outline: none;
            border-color: #1f5fc0;
            box-shadow: 0 0 0 2px rgba(31, 95, 192, .10);
        }

        .vm-filter-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 9px;
            align-items: center;
            margin-top: 18px;
        }

        .vm-btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-height: 40px;
            padding: 9px 18px;
            border: 0;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            box-sizing: border-box;
        }

        .vm-btn-search {
            background: #1f5fc0;
            color: #fff;
        }

        .vm-btn-search:hover {
            background: #194f9f;
            color: #fff;
        }

        .vm-btn-view {
            background: #198754;
            color: #fff;
        }

        .vm-btn-view:hover {
            background: #146c43;
            color: #fff;
        }

        .vm-btn-excel {
            background: #176b45;
            color: #fff;
        }

        .vm-btn-excel:hover {
            background: #125538;
            color: #fff;
        }

        .vm-btn-deactivate {
            background: #dc3545;
            color: #fff;
        }

        .vm-btn-deactivate:hover {
            background: #bb2d3b;
            color: #fff;
        }

        .vm-message {
            display: block;
            margin-bottom: 15px;
            padding: 10px 13px;
            border-radius: 6px;
            background: #fff1f0;
            border: 1px solid #ffd7d4;
            color: #c62828;
            font-size: 13px;
        }

        .vm-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }

        .vm-toolbar-title {
            color: #263445;
            font-size: 16px;
            font-weight: 700;
        }

        .vm-toolbar-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 9px;
        }

        .vm-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .vm-table {
            width: 100%;
            min-width: 900px;
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 13px;
        }

        /* Preserve the original blue table-header style */
        .vm-table th {
            padding: 13px 12px !important;
            background: #1f5fc0 !important;
            color: #fff !important;
            border: 0 !important;
            font-weight: 600;
            white-space: nowrap;
            vertical-align: middle !important;
        }

        .vm-table td {
            padding: 12px !important;
            color: #475467;
            border-top: 1px solid #edf0f4 !important;
            vertical-align: middle !important;
            white-space: nowrap;
        }

        .vm-table tbody tr:hover td {
            background: #f5f8ff;
        }

        .vm-table input[type="checkbox"] {
            width: 17px;
            height: 17px;
            cursor: pointer;
            vertical-align: middle;
        }

        .vm-table a {
            color: #1f5fc0;
            font-weight: 600;
            text-decoration: none;
        }

        .vm-table a:hover {
            text-decoration: underline;
        }

        .vm-table .vm-pager td {
            padding: 12px !important;
            white-space: normal;
        }

        .vm-table .vm-pager a,
        .vm-table .vm-pager span {
            display: inline-block;
            margin: 2px;
            padding: 6px 10px;
            border: 1px solid #dce3eb;
            border-radius: 5px;
            text-decoration: none;
        }

        .vm-table .vm-pager span {
            color: #fff;
            background: #1f5fc0;
            border-color: #1f5fc0;
        }

        .vm-scroll-note {
            display: none;
            padding: 10px 14px;
            border-top: 1px solid #edf0f4;
            color: #7b8794;
            font-size: 12px;
        }

        @media (max-width: 991px) {
            .vm-filter-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 575px) {
            .vm-card-body {
                padding: 14px;
            }

            .vm-card-header {
                padding: 14px;
            }

            .vm-filter-grid {
                grid-template-columns: 1fr;
                gap: 13px;
            }

            .vm-filter-actions {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }

            .vm-filter-actions .vm-btn {
                width: 100%;
                padding-left: 8px;
                padding-right: 8px;
            }

            .vm-toolbar {
                align-items: stretch;
            }

            .vm-toolbar-actions {
                display: grid;
                grid-template-columns: 1fr 1fr;
                width: 100%;
            }

            .vm-toolbar-actions .vm-btn {
                width: 100%;
                padding-left: 8px;
                padding-right: 8px;
            }

            .vm-scroll-note {
                display: block;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>

    <div class="wrapper main-wrapper row">

        <div class="col-xs-12">

            <!-- ORIGINAL PAGE HEADER: unchanged -->
            <div class="page-title">
                <div class="pull-left">
                    <h1 class="title">View Members</h1>
                </div>

                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li>
                            <a href="dashboard.aspx">
                                <i class="fa fa-home"></i>Home
                            </a>
                        </li>
                        <li class="active">
                            <strong>View Members</strong>
                        </li>
                    </ol>
                </div>
            </div>

        </div>

        <div class="clearfix"></div>

        <!-- SEARCH FILTERS -->
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <div class="vm-card">

                <div class="vm-card-header">
                    <h3>
                        <i class="fa fa-filter" style="margin-right:8px;color:#1f5fc0;"></i>
                        Search Members
                    </h3>
                    <p>Filter members by joining date, name, or mobile number.</p>
                </div>

                <div class="vm-card-body">

                    <asp:Label ID="Label2" runat="server"
                        ForeColor="Red"
                        Text="Label"
                        Visible="False"
                        CssClass="vm-message">
                    </asp:Label>

                    <div class="vm-filter-grid">

                        <div class="vm-field">
                            <label for="<%= TextBox1.ClientID %>">Start Date</label>
                            <asp:TextBox ID="TextBox1" runat="server"
                                TextMode="Date"
                                CssClass="vm-input">
                            </asp:TextBox>
                        </div>

                        <div class="vm-field">
                            <label for="<%= TextBox2.ClientID %>">End Date</label>
                            <asp:TextBox ID="TextBox2" runat="server"
                                TextMode="Date"
                                CssClass="vm-input">
                            </asp:TextBox>
                        </div>

                        <div class="vm-field">
                            <label for="<%= TextBox3.ClientID %>">Name / Mobile</label>
                            <asp:TextBox ID="TextBox3" runat="server"
                                CssClass="vm-input"
                                placeholder="Enter name or mobile">
                            </asp:TextBox>
                        </div>

                    </div>

                    <div class="vm-filter-actions">

                        <asp:Button ID="Button3" runat="server"
                            Text="Search by Date"
                            CssClass="vm-btn vm-btn-search"
                            OnClick="Button3_Click" />

                        <asp:Button ID="Button5" runat="server"
                            Text="Search Name / Mobile"
                            CssClass="vm-btn vm-btn-search"
                            OnClick="Button5_Click" />

                    </div>

                </div>
            </div>

        </div>

        <!-- MEMBER GRID -->
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <div class="vm-card">

               

                <div class="vm-card-body">

                    <div class="vm-toolbar">

                        <div class="vm-toolbar-title">
                            Member List
                        </div>

                        <div class="vm-toolbar-actions">

                            <asp:Button ID="Button4" runat="server"
                                Text="View All"
                                CssClass="vm-btn vm-btn-view"
                                OnClick="Button4_Click" />

                            <asp:Button ID="Button1" runat="server"
                                Text="View in Excel"
                                CssClass="vm-btn vm-btn-excel"
                                OnClick="Button1_Click" />

                        </div>

                    </div>

                    <div class="vm-table-wrap">

                        <asp:GridView ID="GridView1" runat="server"
                            CssClass="table table-striped table-bordered vm-table"
                            HeaderStyle-ForeColor="White"
                            AutoGenerateColumns="False"
                            DataKeyNames="username,id"
                            DataSourceID="SqlDataSource1"
                            PagerStyle-CssClass="vm-pager"
                            EmptyDataText="No records found"
                            AllowPaging="True"
                            PageSize="50"
                            Width="100%"
                            OnRowCommand="GridView1_RowCommand"
                            GridLines="None">

                            <Columns>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Sr No
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNO" runat="server"
                                            Text='<%# Container.DataItemIndex + 1 %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="name"
                                    HeaderText="Name"
                                    SortExpression="name">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="amount"
                                    HeaderText="Amount"
                                    DataFormatString="{0:N2}" />

                                <asp:BoundField DataField="noOfunits"
                                    HeaderText="Units"
                                    DataFormatString="{0:N0}" />

                                <asp:BoundField DataField="mobile"
                                    HeaderText="Mobile"
                                    SortExpression="mobile" />

                                <asp:BoundField DataField="status"
                                    HeaderText="Status"
                                    SortExpression="plan" />

                                <asp:BoundField DataField="joindate"
                                    HeaderText="Join Date"
                                    ItemStyle-HorizontalAlign="Left"
                                    ItemStyle-Width="100px"
                                    DataFormatString="{0:dd/MMM/yyyy}"
                                    HtmlEncode="False"
                                    SortExpression="joindate">
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:BoundField>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Profile
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton2"
                                            CommandName="profile"
                                            CommandArgument='<%# Eval("username") %>'
                                            runat="server">
                                            View
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Select
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                            </Columns>

                            <HeaderStyle BackColor="#1f5fc0" ForeColor="White" />
                        </asp:GridView>

                    </div>

                    <div class="vm-scroll-note">
                        <i class="fa fa-arrows-h"></i>
                        Swipe horizontally to see all member details.
                    </div>

                    <div style="display:flex;justify-content:flex-end;margin-top:18px;">
                        <asp:Button ID="Button2" runat="server"
                            Text="Deactivate Selected"
                            CssClass="vm-btn vm-btn-deactivate"
                            OnClientClick="return confirm('Are you sure you want to deactivate the selected members?');"
                            OnClick="Button2_Click" />
                    </div>

                    <%-- Original SMS button retained as a comment
                    <asp:Button ID="btnSms" runat="server"
                        Text="Send Login Sms"
                        OnClick="btnSms_Click" />
                    --%>

                </div>
            </div>

        </div>

        <!-- ORIGINAL SQL DATA SOURCE -->
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:MyBusinessConnectionString %>"
            SelectCommand="SELECT m.id, m.[username], m.[name], m.[pan],
                m.[status], m.[mobile], m.[amount], m.[joindate], m.[noOfunits]
                FROM [tblMember] m
                WHERE m.[isActive] = @flag
                ORDER BY m.id DESC">

            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="flag" Type="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>

    </div>

</asp:Content>
