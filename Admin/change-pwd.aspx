<%@ Page Title="Change Password" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true"
    CodeFile="change-pwd.aspx.cs" Inherits="admin_change_pwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="wrapper main-wrapper row" style=''>
        <div class='col-xs-12'>
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Change Password</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Change Password</strong> </li>
                    </ol>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <!-- MAIN CONTENT AREA STARTS -->
        <div class="col-lg-12">
            <div class="row" >
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <section class="box ">
                        <div class="content-body" style="padding:25px 10px 0px 10px">
                            <form id="general_validate" action="javascript:;" novalidate="novalidate">
                             

<asp:Label ID="Label5" runat="server" Text="Label" Visible="False"></asp:Label>


    <div class="row">
                      <div class="col-md-3">
                        <div class="form-group row">
                          <div class="col-sm-12">
                            
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ValidationGroup="val" TextMode="Password" placeholder="Old Password*"></asp:TextBox>
                         
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextBox1" ErrorMessage="Field can not be empty" 
                    ForeColor="Red" ValidationGroup="val"></asp:RequiredFieldValidator>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-3">
                        <div class="form-group row">
                          <div class="col-sm-12">
                           
                             <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" placeholder="New Password*" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="TextBox2" ErrorMessage="Field can not be empty" 
                    ForeColor="Red" ValidationGroup="val"></asp:RequiredFieldValidator>
                          </div>
                        </div>
                      </div>
					  <div class="col-md-3">
                        <div class="form-group row">
                          <div class="col-sm-12">
                          
                              <asp:TextBox ID="TextBox3" runat="server" TextMode="Password" 
                    CssClass="form-control" placeholder="Retype Password*"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="TextBox3" ErrorMessage="Field can not be empty" 
                    ForeColor="Red" ValidationGroup="val"></asp:RequiredFieldValidator>
                    <br />    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="TextBox2" ControlToValidate="TextBox3" 
                    ErrorMessage="Password does not match" ForeColor="Red" 
                    ValidationGroup="val"></asp:CompareValidator>
                          </div>
                        </div>
                      </div>
					  <div class="col-md-3">
                        <div class="form-group row">
                          <div class="col-sm-12">
                           
                                     <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary mr-2" 
                    onclick="Button1_Click" Text="Submit" ValidationGroup="val" />
                          </div>
                        </div>
                      </div>
                    </div>
				
                  </form>
                    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="Label" 
                    Visible="False"></asp:Label>
                </div>
                </section>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
