<%@ Page Title="Finance Report" Language="C#" MasterPageFile="~/Admin/admin.master"
    AutoEventWireup="true" CodeFile="finance-report.aspx.cs" Inherits="Admin_finance_report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
    .summary-table {
        background-color: #f9f9f9;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        padding: 20px;
        margin-bottom: 20px;
    }

    .summary-table td {
        padding: 10px 15px;
        font-size: 16px;
        vertical-align: middle;
    }

    .summary-table b {
        color: #333;
    }

    .summary-label {
        font-size: 18px;
        font-weight: bold;
        color: green;
    }  .date-filter-table {
        background-color: #fefefe;
        border: 1px solid #dee2e6;
        border-radius: 10px;
        padding: 15px 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        margin-bottom: 20px;
        width: 100%;
    }

    .date-filter-table td {
        padding: 10px 15px;
        vertical-align: middle;
        font-size: 16px;
    }

    .date-filter-table b {
        color: #343a40;
        font-weight: 600;
    }

    .date-filter-table input[type="date"] {
        padding: 6px 10px;
        font-size: 15px;
        border-radius: 5px;
        border: 1px solid #ced4da;
        width: 180px;
    }

    .date-filter-buttons input[type="submit"],
    .date-filter-buttons input[type="button"] {
        padding: 6px 14px;
        font-size: 15px;
        border: none;
        border-radius: 5px;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-left: 10px;
    }

    .date-filter-buttons input[type="submit"]:hover,
    .date-filter-buttons input[type="button"]:hover {
        background-color: #0056b3;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="wrapper main-wrapper row" style=''>
        <div class='col-xs-12'>
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Financial Report</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Financial Report</strong> </li>
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
                            <form id="general_validate" action="javascript:;" novalidate="novalidate">
                                <div class="row" style="padding-top:21px;">

     <div class="table-responsive">
    <table class="date-filter-table">
    <tr>
        <td><b>Start Date</b></td>
        <td>
            <asp:TextBox ID="TextBox1" TextMode="Date" runat="server" />
        </td>
        <td><b>End Date</b></td>
        <td>
            <asp:TextBox ID="TextBox2" TextMode="Date" runat="server" />
            <span class="date-filter-buttons">
                <asp:Button ID="Button1" runat="server" Text="Search" CssClass="search-button" OnClick="Button1_Click" />
                <asp:Button ID="Button2" runat="server" Text="Show All" CssClass="search-button" OnClick="Button2_Click" />
            </span>
        </td>
    </tr>
</table>
   
         <table class="summary-table table">
    <tr>
        <td><b>Paid Pin Value:</b></td>
        <td><asp:Label ID="lblpaid" runat="server" CssClass="summary-label" Text="0"></asp:Label></td>

        <td><b>Self Pin Value:</b></td>
        <td><asp:Label ID="lblself" runat="server" CssClass="summary-label" Text="0"></asp:Label></td>

        <td><b>Total Payout (Rs):</b></td>
        <td><asp:Label ID="lblpayout" runat="server" CssClass="summary-label" Text="0"></asp:Label></td>
    </tr>
</table>
         <br />
    <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered"  HeaderStyle-ForeColor="White" HeaderStyle-BackColor="#1f5fc0" runat="server"
        AutoGenerateColumns="False" Width="100%" AllowPaging="true" PageSize="50" 
        GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    SNo.</HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="date" HeaderText="Date" DataFormatString="{0:dd/MMM/yyyy}" />
            <asp:BoundField DataField="pin" HeaderText="Pin Approved" />
            <asp:BoundField DataField="pinvalue" HeaderText="Pin Value(Rs)" />
            <asp:BoundField DataField="selfpin" HeaderText="Self Pin" />
            <asp:BoundField DataField="selfvalue" HeaderText="Self Pin Value(Rs)" />
            <asp:BoundField DataField="payout" HeaderText="Payout(Rs)" />
        </Columns>
    </asp:GridView>

    <br />

    </div>
    </div>
    </form>
    
    </div>
    </section>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
