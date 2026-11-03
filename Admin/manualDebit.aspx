<%@ Page Title="Admin Manual Payment" Language="C#" MasterPageFile="admin.master"
    AutoEventWireup="true" CodeFile="manualDebit.aspx.cs" Inherits="portal_Admin_manualDebit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="wrapper main-wrapper row" style=''>
        <div class='col-xs-12'>
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Manual Credit/Debit</h1>
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager2" runat="server">
                    </asp:ToolkitScriptManager>
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Credit/Debit</strong> </li>
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
                   <div class="row" style="padding-top:21px;">
                    
                                    <div class="col-xs-12">
                <div>
                    <span id="lbSuccess" runat="server" visible="false" style="color: Green"></span>
                    <span id="lbErrormsg" runat="server" visible="false" class="text-warning"></span>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Username
                                    </label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtUser" runat="server" MaxLength="11" AutoPostBack="true" CssClass="form-control"
                                            required OnTextChanged="txtUser_Changed"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <span id="lblName" runat="server" class="text-info"></span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Credit/Debit
                                    </label>
                                    <div class="col-sm-5">
                                        <asp:RadioButtonList ID="rdOption" runat="server" RepeatDirection="Horizontal">
                                            <%--<asp:ListItem Value="1">Credit</asp:ListItem>--%>
                                            <asp:ListItem Value="2">Debit</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Font-Size="Small" ForeColor="Red"
                                            ControlToValidate="rdOption" runat="server" ErrorMessage="Select Credit or Debit"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Wallet Balance
                                    </label>
                                    <div class="col-sm-5">
                                        <span id="lbbal" runat="server" class="form-control">0</span>
                                    </div>
                                    <div class="col-md-4">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Amount
                                    </label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="TextBox2" runat="server" required CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers,Custom"
                                            TargetControlID="TextBox2" ValidChars="." />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Remarks
                                    </label>
                                    <div class="col-sm-5">
                                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="row">
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="btnSubmit_Click"
                                Text="Submit" />
                        </div>
                    </div>
                    <div class="col-md-4">
                    </div>
                </div>
         
  
   <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="table-responsive">
                        <asp:GridView ID="GridView1"  AutoGenerateColumns="False" runat="server" EmptyDataText="No records found"
                            AllowPaging="True" Width="100%" PageSize="50" CssClass="table table-striped table-bordered" HeaderStyle-BackColor="#1f5fc0"
                            HeaderStyle-ForeColor="White" OnPageIndexChanging="GridView1_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        SNo.</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="username" HeaderText="Username" />
                                <asp:BoundField DataField="name" HeaderText="Name" />
                                <asp:BoundField DataField="desc" HeaderText="DESC" />
                                <asp:BoundField DataField="confirmdate" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" />
                                <asp:BoundField DataField="credit" HeaderText="Credit" />
                                <asp:BoundField DataField="debit" HeaderText="Debit" />
                                <asp:BoundField DataField="remarks" HeaderText="Remarks" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </div>
    </section>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
