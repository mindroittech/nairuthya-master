
<%@ Page Title="Deactivated" Language="C#" MasterPageFile="~/Admin/admin.master"
    AutoEventWireup="true" CodeFile="deactivated.aspx.cs" Inherits="Admin_deactivated" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /* Original page header styling is preserved */

        .dm-card {
            background: #fff;
            border: 1px solid #e8edf3;
            border-radius: 10px;
            box-shadow: 0 3px 14px rgba(31, 45, 61, .05);
            margin-bottom: 22px;
            overflow: hidden;
        }

        .dm-card-header {
            padding: 16px 20px;
            border-bottom: 1px solid #edf0f4;
            background: #fff;
        }

        .dm-card-header h3 {
            margin: 0;
            color: #263445;
            font-size: 17px;
            font-weight: 700;
        }

        .dm-card-header p {
            margin: 5px 0 0;
            color: #8994a3;
            font-size: 12px;
        }

        .dm-card-body {
            padding: 20px;
        }

        .dm-search-row {
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 12px;
            align-items: end;
        }

        .dm-field {
            min-width: 0;
        }

        .dm-field label {
            display: block;
            margin-bottom: 7px;
            color: #475467;
            font-size: 13px;
            font-weight: 600;
        }

        .dm-input {
            display: block;
            width: 100%;
            height: 42px;
            padding: 8px 12px;
            border: 1px solid #dce3eb;
            border-radius: 6px;
            background: #fff;
            color: #344054;
            font-size: 13px;
            box-sizing: border-box;
        }

        .dm-input:focus {
            outline: none;
            border-color: #1f5fc0;
            box-shadow: 0 0 0 2px rgba(31, 95, 192, .10);
        }

        .dm-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 41px;
            padding: 9px 17px;
            border: 0;
            border-radius: 6px;
            color: #fff;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            box-sizing: border-box;
        }

        .dm-btn-search {
            background: #1f5fc0;
        }

        .dm-btn-search:hover {
            background: #194f9f;
            color: #fff;
        }

        .dm-btn-view {
            background: #1f5fc0;
        }

        .dm-btn-view:hover {
            background: #194f9f;
            color: #fff;
        }

        .dm-btn-activate {
            background: #198754;
        }

        .dm-btn-activate:hover {
            background: #146c43;
            color: #fff;
        }

        .dm-message {
            display: block;
            margin-bottom: 15px;
            padding: 10px 13px;
            border: 1px solid #ffd7d4;
            border-radius: 6px;
            background: #fff1f0;
            color: #c62828;
            font-size: 13px;
        }

        .dm-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 16px;
        }

        .dm-toolbar-title {
            color: #263445;
            font-size: 16px;
            font-weight: 700;
        }

        .dm-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .dm-table {
            width: 100%;
            min-width: 900px;
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 13px;
        }

        /* Preserve original blue GridView header */
        .dm-table th {
            padding: 13px 12px !important;
            background: #1f5fc0 !important;
            color: #fff !important;
            border: 0 !important;
            font-weight: 600;
            white-space: nowrap;
            vertical-align: middle !important;
        }

        .dm-table td {
            padding: 12px !important;
            color: #475467;
            border-top: 1px solid #edf0f4 !important;
            vertical-align: middle !important;
            white-space: nowrap;
        }

        .dm-table tbody tr:hover td {
            background: #f5f8ff;
        }

        .dm-table input[type="checkbox"] {
            width: 17px;
            height: 17px;
            vertical-align: middle;
            cursor: pointer;
        }

        .dm-table a {
            color: #1f5fc0;
            font-weight: 600;
            text-decoration: none;
        }

        .dm-table a:hover {
            text-decoration: underline;
        }

        .dm-table .dm-pager td {
            padding: 12px !important;
            white-space: normal;
        }

        .dm-table .dm-pager a,
        .dm-table .dm-pager span {
            display: inline-block;
            margin: 2px;
            padding: 6px 10px;
            border: 1px solid #dce3eb;
            border-radius: 5px;
            text-decoration: none;
        }

        .dm-table .dm-pager span {
            color: #fff;
            background: #1f5fc0;
            border-color: #1f5fc0;
        }

        .dm-scroll-note {
            display: none;
            padding: 10px 14px;
            border-top: 1px solid #edf0f4;
            color: #7b8794;
            font-size: 12px;
        }

        .dm-bottom-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 18px;
        }

        @media (max-width: 767px) {
            .dm-card-body {
                padding: 14px;
            }

            .dm-card-header {
                padding: 14px;
            }

            .dm-search-row {
                grid-template-columns: 1fr;
            }

            .dm-search-row .dm-btn {
                width: 100%;
            }

            .dm-toolbar {
                align-items: stretch;
            }

            .dm-toolbar .dm-btn {
                width: 100%;
            }

            .dm-bottom-actions .dm-btn {
                width: 100%;
            }

            .dm-scroll-note {
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

            <!-- ORIGINAL HEADER: unchanged -->
            <div class="page-title">
                <div class="pull-left">
                    <h1 class="title">Deactivated Members</h1>
                </div>

                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li>
                            <a href="dashboard.aspx">
                                <i class="fa fa-home"></i>Home
                            </a>
                        </li>
                        <li class="active">
                            <strong>Deactivated Members</strong>
                        </li>
                    </ol>
                </div>
            </div>

        </div>

        <div class="clearfix"></div>

        <!-- SEARCH CARD -->
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <div class="dm-card">

                <div class="dm-card-header">
                    <h3>
                        <i class="fa fa-search" style="margin-right:8px;color:#1f5fc0;"></i>
                        Search Deactivated Members
                    </h3>
                    <p>Search using  name, or mobile number.</p>
                </div>

                <div class="dm-card-body">

                    <div class="dm-search-row">

                        <div class="dm-field">
                            <label for="<%= TextBox3.ClientID %>">ID / Name / Mobile</label>

                            <asp:TextBox ID="TextBox3" runat="server"
                                CssClass="dm-input"
                                placeholder="Enter name, or mobile">
                            </asp:TextBox>
                        </div>

                        <div>
                            <asp:Button ID="Button5" runat="server"
                                Text="Search"
                                CssClass="dm-btn dm-btn-search"
                                OnClick="Button5_Click" />
                        </div>

                    </div>

                </div>
            </div>

        </div>

        <!-- DEACTIVATED MEMBERS GRID -->
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <div class="dm-card">

                <div class="dm-card-body">

                    <asp:Label ID="Label2" runat="server"
                        ForeColor="Red"
                        Text="Label"
                        Visible="False"
                        CssClass="dm-message">
                    </asp:Label>

                    <div class="dm-toolbar">

                        <div class="dm-toolbar-title">
                            Member List
                        </div>

                        <asp:Button ID="Button4" runat="server"
                            Text="View All"
                            CssClass="dm-btn dm-btn-view"
                            OnClick="Button4_Click" />

                    </div>

                    <div class="dm-table-wrap">

                        <asp:GridView ID="GridView1" runat="server"
                            CssClass="table table-striped table-bordered dm-table"
                            HeaderStyle-ForeColor="White"
                            AutoGenerateColumns="False"
                            DataKeyNames="username,id"
                            DataSourceID="SqlDataSource1"
                            PagerStyle-CssClass="dm-pager"
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

                    <div class="dm-scroll-note">
                        <i class="fa fa-arrows-h"></i>
                        Swipe horizontally to view all member details.
                    </div>

                    <div class="dm-bottom-actions">
                        <asp:Button ID="Button2" runat="server"
                            Text="Activate Selected"
                            CssClass="dm-btn dm-btn-activate"
                            OnClientClick="return confirm('Are you sure you want to activate the selected members?');"
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
                <asp:Parameter DefaultValue="0" Name="flag" Type="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>

    </div>

</asp:Content>
