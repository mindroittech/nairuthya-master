
<%@ Page Title="Accounts By Date" Language="C#" MasterPageFile="admin.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="account-bydate.aspx.cs" Inherits="admin_account_bydate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .abd-page {
            padding-bottom: 25px;
        }

        .abd-filter-card {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .abd-filter-title {
            font-size: 16px;
            font-weight: 700;
            color: #263445;
            margin: 0 0 18px;
        }

        .abd-field {
            margin-bottom: 12px;
        }

        .abd-field label {
            display: block;
            font-weight: 600;
            color: #465366;
            margin-bottom: 7px;
        }

        .abd-field .form-control {
            width: 100%;
            height: 42px;
            border-radius: 6px;
            border: 1px solid #d8dee8;
            box-shadow: none;
        }

        .abd-actions {
            display: flex;
            align-items: flex-end;
            height: 100%;
            min-height: 64px;
        }

        .abd-btn {
            min-height: 40px;
            border-radius: 6px;
            font-weight: 600;
            padding: 9px 17px;
        }

        .abd-summary {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 18px 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
            height: 100%;
        }

        .abd-summary-label {
            color: #667085;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .abd-summary-value {
            color: #dc3545;
            font-size: 25px;
            font-weight: 700;
            line-height: 1.3;
            overflow-wrap: anywhere;
        }

        .abd-summary-icon {
            float: right;
            font-size: 23px;
            color: #dc3545;
            opacity: .8;
        }

        .abd-export-row {
            margin-bottom: 15px;
        }

        .abd-grid-card {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .abd-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .abd-grid {
            min-width: 950px;
            margin-bottom: 0;
            background: #fff;
        }

        .abd-grid th {
            background-color: #1f5fc0 !important;
            color: #fff !important;
            white-space: nowrap;
            vertical-align: middle !important;
            padding: 12px 10px !important;
        }

        .abd-grid td {
            padding: 10px !important;
            vertical-align: middle !important;
            overflow-wrap: anywhere;
        }

        .abd-grid tr:hover td {
            background-color: #f7fafc;
        }

        .abd-error {
            display: block;
            margin-bottom: 12px;
            font-weight: 600;
        }

        @media (max-width: 767px) {
            .abd-filter-card {
                padding: 15px;
            }

            .abd-summary {
                padding: 15px;
                margin-bottom: 12px;
            }

            .abd-summary-value {
                font-size: 22px;
            }

            .abd-actions {
                min-height: auto;
                display: block;
            }

            .abd-actions .btn {
                width: 100%;
            }

            .abd-export-row .btn {
                width: 100%;
            }

            .abd-grid-card {
                padding: 8px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="wrapper main-wrapper row abd-page">
        <div class="col-xs-12">
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Account By Date</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Account By Date</strong> </li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
            </asp:ToolkitScriptManager>

            <asp:Label ID="Label9" runat="server"
                Text="Username doesnot exist"
                ForeColor="Red"
                Visible="False"
                CssClass="abd-error">
            </asp:Label>

            <!-- Date Filter -->
            <div class="abd-filter-card">
                <h4 class="abd-filter-title">
                    <i class="fa fa-calendar"></i> Filter Accounts by Date
                </h4>

                <div class="row">
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="abd-field">
                            <label for="<%= TextBox1.ClientID %>">Start Date</label>
                            <asp:TextBox ID="TextBox1" runat="server"
                                TextMode="Date" CssClass="form-control">
                            </asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="abd-field">
                            <label for="<%= TextBox2.ClientID %>">End Date</label>
                            <asp:TextBox ID="TextBox2" runat="server"
                                TextMode="Date" CssClass="form-control">
                            </asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-12 col-xs-12">
                        <div class="abd-field abd-actions">
                            <asp:Button ID="Button1" runat="server"
                                OnClick="Button1_Click"
                                CssClass="btn btn-primary abd-btn"
                                Text="Search" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Credit and Debit Summary -->
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="abd-summary">
                        <div class="abd-summary-label">
                            Total Credits
                            <i class="fa fa-arrow-circle-up abd-summary-icon"></i>
                        </div>
                        <div class="abd-summary-value">
                            <asp:Label ID="Label7" runat="server" Text="0"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="abd-summary">
                        <div class="abd-summary-label">
                            Total Debit
                            <i class="fa fa-arrow-circle-down abd-summary-icon"></i>
                        </div>
                        <div class="abd-summary-value">
                            <asp:Label ID="Label8" runat="server" Text="0"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Export Button -->
            <div class="row abd-export-row">
                <div class="col-xs-12">
                    <asp:Button ID="Button2" runat="server"
                        Text="Export to Excel"
                        CssClass="btn btn-success abd-btn"
                        OnClick="Button2_Click" />
                </div>
            </div>

            <!-- Accounts Grid -->
            <div class="abd-grid-card">
                <div class="abd-table-wrap">
                    <asp:GridView ID="GridView1" runat="server"
                        CssClass="table table-striped table-bordered abd-grid"
                        HeaderStyle-ForeColor="White"
                        AutoGenerateColumns="False"
                        PagerStyle-CssClass="PagerStyle"
                        OnRowDataBound="GridView1_RowDataBound"
                        EmptyDataText="No records found"
                        AllowPaging="True"
                        Width="100%"
                        PageSize="50"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        GridLines="None">

                        <Columns>
                            <asp:TemplateField HeaderStyle-Width="80">
                                <HeaderTemplate>
                                    SNo.
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSRNO" runat="server"
                                        Text='<%# Container.DataItemIndex + 1 %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                            </asp:TemplateField>

                            <asp:BoundField DataField="name" HeaderText="Name" />
                            <asp:BoundField DataField="desc" HeaderText="DESC" />
                            <asp:BoundField DataField="credit" HeaderText="Credit" />
                            <asp:BoundField DataField="units" HeaderText="Units" />
                            <asp:BoundField DataField="perShare" HeaderText="Per Share" />
                            <asp:BoundField DataField="debit" HeaderText="Debit" />
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

                      
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
