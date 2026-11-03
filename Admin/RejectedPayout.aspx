<%@ Page Title="Rejected Payouts" Language="C#" MasterPageFile="~/Admin/admin.master"
    AutoEventWireup="true" CodeFile="RejectedPayout.aspx.cs" Inherits="Admin_RejectedPayout" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                        Rejected Payouts</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Rejected Payouts</strong> </li>
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

                  
                        <table class="boxgborder" style="width: 80%; margin-left:10px;">
                            <tr class="danger">
                                <td style="width: 75px">
                                    <b style="font-weight: bold;">Start Date</b>
                                </td>
                                <td >
                                    <asp:TextBox ID="TextBox1" TextMode="Date" runat="server"></asp:TextBox>
                                    
                                </td>
                                <td style="width: 75px">
                                    <b style="font-weight: bold;">End Date</b>
                                </td>

                                <td>
                                    <asp:TextBox ID="TextBox2" TextMode="Date" runat="server"></asp:TextBox>
                                </td>
                                 <td style="width: 75px">
                                    <b style="font-weight: bold;">Date-wise</b>
                                </td>
                                <td style="width: 75px">
                                 <asp:DropDownList ID="drpDate" Width="150px" runat="server"></asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;<asp:Button ID="Button11" runat="server" Text="Search" OnClick="Button11_Click"
                                        Style="height: 26px" />
                                    &nbsp;&nbsp;&nbsp;<asp:Button ID="Button4" runat="server" Text="View All"  OnClick="Button4_Click"
                                        Style="height: 26px" />
                                </td>
                            </tr>
                        </table>

                        
                       </div>
     </form>
     </div>
     </section>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <section class="box ">
                            <div class="content-body">
                          
                                <div class="row" style="padding-top:21px;">

                                   
                                    <div class="col-xs-12">
									   <%-- <div>
                

                         <asp:Button ID="Button1" runat="server" style="float:right"  Text="Export to Excel" CssClass="btn btn-success"
                        OnClick="Button1_Click" />
                       
                </div>--%>
                <br /> 
                <div class="table-responsive">        
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                            HeaderStyle-ForeColor="White" DataKeyNames="username,sc" Width="100%" EmptyDataText="No records found."
                            OnRowCommand="GridView1_RowCommand" PageSize="50"
                            GridLines="None">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        No</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="username" HeaderText="ID" SortExpression="username" />
                                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                                <asp:BoundField DataField="cashavailable" HeaderText="Available Credit" />
                                <asp:BoundField DataField="amount" HeaderText="Amount Req" SortExpression="amount" />
                                <asp:BoundField DataField="tax" HeaderText="TDS(5%)">
                                    <HeaderStyle Font-Size="12px"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="sc" HeaderText="A.C(5%)">
                                    <HeaderStyle Font-Size="12px"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="netpay" HeaderText="NetPay (Rs)" />
                                <asp:BoundField DataField="date" HeaderText="Date" SortExpression="date" DataFormatString="{0:dd-MMM-yyyy}">
                                    <ItemStyle Width="110px"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Transaction No
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtbox" runat="server" Width="90px">  </asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Bank Details</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton3" CommandName="view" CommandArgument='<%# Eval("username") %>'
                                            runat="server">View</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="115px">
                                    <HeaderTemplate>
                                        Action</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" CommandName="send" CommandArgument='<%# Eval("paymentid") %>'
                                            runat="server">Send</asp:LinkButton>
                                        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" ConfirmOnFormSubmit="true"
                                            runat="server" ConfirmText="Are you sure you want to send?" Enabled="True" TargetControlID="LinkButton1">
                                        </asp:ConfirmButtonExtender>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="del" CommandArgument='<%# Eval("paymentid") %>'>Remove</asp:LinkButton>
                                        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender2" ConfirmOnFormSubmit="true"
                                            runat="server" ConfirmText="Are you sure you want to remove?" Enabled="True"
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
     </section>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
