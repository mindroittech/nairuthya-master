<%@ Page Title="" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true"
    CodeFile="detail.aspx.cs" Inherits="admin_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Details</title>
    <style type="text/css">
        .style14
        {
            border-style: solid;
            border-width: 1px;
            margin-left: 60px;
            width: 300px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
           
            <div class="col-12 grid-margin">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title" style="color:#ff9c00;font-weight:600;"></h4><hr/>
        <br /><br />
        <table  cellpadding="5"  class="table table-hover table-bordered" style=" width:40%">
            <tr class="danger">
                <td >
                    Bank Name</td>
                <td style="background:#dff2fd;">
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr class="danger">
                <td >
                    Branch</td>
                <td style="background:#dff2fd;">
                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr class="danger">
                <td >
                    Acc No</td>
                <td style="background:#dff2fd;">
                    <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr class="danger">
                <td >
                    IFSC</td>
                <td style="background:#dff2fd;">
                    <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
           
        </table>
    
        <br />
        <br />
        </div>
        </div>
        </div>
        </div>
</asp:Content>
