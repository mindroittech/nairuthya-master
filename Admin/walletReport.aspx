
<%@ Page Title="Wallet Report" Language="C#" MasterPageFile="~/Admin/admin.master"
    AutoEventWireup="true" CodeFile="walletReport.aspx.cs" Inherits="Admin_walletReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .wr-page {
            padding-bottom: 25px;
        }

        .wr-card {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .wr-card-title {
            color: #263445;
            font-size: 16px;
            font-weight: 700;
            margin: 0 0 18px;
        }

        .wr-label {
            display: block;
            color: #465366;
            font-weight: 600;
            margin-bottom: 7px;
        }

        .wr-input {
            width: 100%;
            height: 42px;
            border: 1px solid #d8dee8;
            border-radius: 6px;
            padding: 8px 12px;
            box-shadow: none;
        }

        .wr-actions {
            display: flex;
            align-items: flex-end;
            gap: 10px;
            min-height: 65px;
        }

        .wr-btn {
            min-height: 40px;
            border-radius: 6px;
            padding: 9px 17px;
            font-weight: 600;
        }

        .wr-table-card {
            background: #fff;
            border: 1px solid #e6eaf0;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        }

        .wr-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .wr-grid {
            min-width: 600px;
            width: 100%;
            margin-bottom: 0;
            background: #fff;
        }

        .wr-grid th {
            background-color: #1f5fc0 !important;
            color: #fff !important;
            white-space: nowrap;
            vertical-align: middle !important;
            padding: 12px 10px !important;
        }

        .wr-grid td {
            padding: 11px 10px !important;
            vertical-align: middle !important;
        }

        .wr-grid tr:hover td {
            background-color: #f5f8fc;
        }

        @media (max-width: 767px) {
            .wr-card {
                padding: 15px;
            }

            .wr-actions {
                display: flex;
                min-height: auto;
                margin-top: 5px;
            }

            .wr-actions .btn {
                flex: 1;
                text-align: center;
                white-space: normal;
            }

            .wr-table-card {
                padding: 8px;
            }
        }

        @media (max-width: 380px) {
            .wr-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .wr-actions .btn {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="wrapper main-wrapper row wr-page">
        <div class="col-xs-12">
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Wallet Report</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Wallet Report</strong> </li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

            <!-- Search Panel -->
            <div class="wr-card">
                <h4 class="wr-card-title">
                    <i class="fa fa-search"></i> Search Wallet Report
                </h4>

                <div class="row">
                    <div class="col-md-5 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="wr-label" for="<%= TextBox1.ClientID %>">
                                Name
                            </label>
                            <asp:TextBox ID="TextBox1" runat="server"
                                CssClass="form-control wr-input">
                            </asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-5 col-sm-6 col-xs-12">
                        <div class="wr-actions">
                            <asp:Button ID="Button1" runat="server"
                                Text="Search"
                                CssClass="btn btn-success wr-btn"
                                OnClick="Button1_Click" />

                            <asp:HyperLink ID="Button2" runat="server"
                                CssClass="btn btn-success wr-btn"
                                NavigateUrl="~/Admin/walletReport.aspx">
                                <i class="fa fa-refresh"></i> Show All
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Wallet Report Grid -->
            <div class="wr-table-card">
                <div class="wr-table-wrap">
                    <asp:GridView ID="GridView1" runat="server"
                        CssClass="table table-striped table-bordered wr-grid"
                        HeaderStyle-BackColor="#1f5fc0"
                        HeaderStyle-ForeColor="White"
                        GridLines="None"
                        EmptyDataText="No records found"
                        AutoGenerateColumns="False"
                        DataKeyNames="username"
                        Width="100%"
                        AllowPaging="true"
                        PageSize="50"
                        OnPageIndexChanging="GridView1_PageIndexChanging">

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
                            </asp:TemplateField>

                            <asp:BoundField DataField="name"
                                HeaderText="Name"
                                SortExpression="name" />

                            <asp:BoundField DataField="wallet"
                                HeaderText="Wallet"
                                SortExpression="amount"
                                DataFormatString="{0:0.0}" />

                            <asp:BoundField DataField="credits"
                                HeaderText="Credit"
                                SortExpression="amount"
                                DataFormatString="{0:0.0}" />

                            <asp:BoundField DataField="debit"
                                HeaderText="Debit"
                                SortExpression="amount"
                                DataFormatString="{0:0.0}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>

</asp:Content>