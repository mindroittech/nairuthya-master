<%@ Page Language="C#" AutoEventWireup="true" CodeFile="printprofile.aspx.cs" Inherits="printprofile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>My Business</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="table-responsive" id="printableArea">      
        <table class="table">
            <tbody>
                <tr>
                    <td colspan="4">
                        <p style="text-align: center;">
           
                        <img src="../nairuthyalogo.png" height="90px"/></p>
                    </td>
                   
                </tr>
                <tr>
                    <td colspan="4" >
                        <h4 style="color: #ff9c00; font-weight: 600; padding-top:-30px; text-align: center;">
                            Member Profile</h4>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p style="text-align: right;">
                            <img>
                            <asp:Image ID="Image1"  Width="80px"
                                Height="90px" runat="server" />
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Username :
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblUser" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Name :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Email :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Mobile No :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblMobile" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Gender :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblGender" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Date of Birth :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblDOB" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            State :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblSate" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            City :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblCity" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Address :</p>
                    </td>
                    <td style="width:45%">
                        <p style="text-align: left;">
                            <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Pincode :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblPincode" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p style="text-align: left; font-weight:bold">
                            Bank Information</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Bank Name :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblBank" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Branch :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblBranch" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            A/c Number :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblAccout" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            PAN :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblPAN" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            IFSC :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblIfsc" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                        Aadhar :
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                         <asp:Label ID="lblAadhar" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p style="text-align: left;font-weight:bold">
                            Sponsor Details</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Sponsor Id :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblSPonsorId" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Sponsor Name :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblSponsor" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Referrer Id :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblReferralId" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Referrer Name :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblReferral" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style="text-align: left;">
                            Surity Check No :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblSurity" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            Date of Agreement :</p>
                    </td>
                    <td>
                        <p style="text-align: left;">
                            <asp:Label ID="lblDate" runat="server" Text=""></asp:Label>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
  
    <script>

        $(document).ready(function () {
            printDiv('printableArea');

            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;

                document.body.innerHTML = printContents;

                window.print();

                document.body.innerHTML = originalContents;
            }

        });
    </script>
</body>
</html>
