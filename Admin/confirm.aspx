<%@ Page Title="Confirmation" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true"
    CodeFile="confirm.aspx.cs" Inherits="confirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            font-size: 22px;
            color: #800000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <asp:Panel ID="Panel1" Width="92%" Style="margin: 10px 15px; padding-left: 20px"
        runat="server" BackColor="WhiteSmoke" Height="260px" Visible="False">
        <div style="font-size: 17px;">
            <span class="style1">
                <br />
                Congratuations!! You have successfully registered
                <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                to
                <%= System.Configuration.ConfigurationManager.AppSettings["companyname"].ToString() %>
                <br />
                <br />
            </span>Login Information has been sent to user registered mobile number.<br />
            <br />
            <a href="new-member.aspx">Add New Member</a> &nbsp;
        </div>
    </asp:Panel>
    <br />
    <br />
</asp:Content>
