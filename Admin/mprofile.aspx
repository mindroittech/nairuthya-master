<%@ Page Title="Member Profile" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true"
    CodeFile="mprofile.aspx.cs" Inherits="Admin_mprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>

    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            // Allow only numbers (0–9)
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
</script>
    
<style type="text/css">
    /* Main profile container */
    .content-body {
        background: #ffffff;
        padding: 25px 28px;
        border-radius: 12px;
        box-shadow: 0 4px 18px rgba(0, 0, 0, 0.07);
    }

    /* Section headings */
    #printableArea .card-description {
        display: block;
        font-size: 16px !important;
        font-weight: 700 !important;
        color: #c58b24 !important;
        padding: 12px 15px;
        margin: 12px 0 22px;
        background: #fff9ed;
        border-left: 4px solid #d5a13b;
        border-radius: 5px;
        letter-spacing: 0.3px;
    }

    /* Consistent row spacing */
    #printableArea .row {
        margin-left: -12px;
        margin-right: -12px;
    }

    #printableArea .col-md-6 {
        padding-left: 12px;
        padding-right: 12px;
    }

    #printableArea .form-group.row {
        display: flex;
        align-items: center;
        margin: 0 0 20px;
    }

    /* Labels */
    #printableArea .col-form-label {
        color: #394150;
        font-size: 13px;
        font-weight: 600;
        line-height: 1.5;
        padding: 0 10px 0 0;
        text-align: left;
        overflow-wrap: anywhere;
    }

    /* Input fields */
    #printableArea .form-control {
        width: 100%;
        height: 42px;
        padding: 9px 12px;
        font-size: 14px;
        color: #333;
        background-color: #fff;
        border: 1px solid #dce1e8;
        border-radius: 6px;
        box-shadow: none;
        transition: border-color 0.2s, box-shadow 0.2s;
    }

    #printableArea .form-control:focus {
        border-color: #d2a044;
        box-shadow: 0 0 0 3px rgba(210, 160, 68, 0.13);
        outline: none;
    }

    #printableArea select.form-control {
        cursor: pointer;
    }

    #printableArea textarea.form-control {
        height: auto;
        min-height: 80px;
    }

    /* Disabled fields */
    #printableArea .form-control:disabled,
    #printableArea .form-control[disabled] {
        background: #f3f5f8;
        color: #666;
        cursor: not-allowed;
    }

    /* Validation messages */
    #printableArea .text-danger {
        display: block;
        margin-top: 5px;
        font-size: 12px;
        line-height: 1.4;
    }

    /* Success message */
    #<escape>ContentPlaceHolder1_Panel1</escape> {
        display: block;
        margin-bottom: 20px;
        padding: 12px 15px;
        color: #176b38 !important;
        background: #eaf8ef;
        border: 1px solid #b9e7c8;
        border-radius: 6px;
        font-weight: 600;
    }

    /* Buttons */
    .content-body .btn {
        min-width: 115px;
        padding: 10px 22px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .content-body .btn-primary {
        background: #bd8b2d;
        color: #fff;
    }

    .content-body .btn-primary:hover {
        background: #9e7020;
        color: #fff;
    }

    /* Button alignment */
    .content-body center {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 12px;
        margin-top: 25px;
        flex-wrap: wrap;
    }

    /* Mobile alignment */
    @media (max-width: 767px) {
        .content-body {
            padding: 16px 12px;
        }

        #printableArea .form-group.row {
            display: block;
            margin-bottom: 16px;
        }

        #printableArea .col-form-label {
            display: block;
            width: 100%;
            margin-bottom: 7px;
            padding-right: 0;
        }

        #printableArea .form-group.row > div {
            width: 100%;
        }

        #printableArea .col-md-6 {
            width: 100%;
        }

        .content-body .btn {
            min-width: 105px;
        }
    }

    /* Print layout */
    @media print {
        .content-body {
            padding: 10px;
            box-shadow: none;
        }

        #printableArea .form-control {
            border: 1px solid #ccc;
            background: #fff;
            color: #000;
        }
    }
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="wrapper main-wrapper row" style=''>
        <div class='col-xs-12'>
            <div class="page-title">
                <div class="pull-left">
                    <!-- PAGE HEADING TAG - START -->
                    <h1 class="title">
                        Member Profile</h1>
                    <!-- PAGE HEADING TAG - END -->
                </div>
                <div class="pull-right hidden-xs">
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-home"></i>Home</a> </li>
                        <li class="active"><strong>Member Profile</strong> </li>
                    </ol>
                </div>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <div class="col-lg-12">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <section class="box ">
                        <div class="content-body">
                            <form id="general_validate" action="javascript:;" novalidate="novalidate">
                                <div class="row" style="padding:10px 8px">


                    <asp:Panel ID="Panel1" runat="server" ForeColor="#009933" Visible="False">
                        Your profile has been successfully updated.</asp:Panel>
                  
                    <div id="printableArea">
                        <br />
                        <p class="card-description" style="font-size: 15px; color: #ff9c00; font-weight: 600;">
                            Personal info
                        </p>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Name</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                             <div class="form-group row">
                                 <label class="col-sm-3 col-form-label">
                                     Mobile No*</label>
                                 <div class="col-sm-9">
                                     <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server" 
                                         ControlToValidate="TextBox4" ErrorMessage="Mobile No is required." 
                                         CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>

                                     <asp:RegularExpressionValidator ID="revMobile" runat="server"
                                         ControlToValidate="TextBox4" 
                                         ValidationExpression="^[0-9]{10}$"
                                         ErrorMessage="Enter a valid 10-digit Mobile Number." 
                                         CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                                 </div>
                                 </div>
                             </div>
                        </div>
                       
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        State*</label>
                                    <div class="col-sm-9">
                                        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control">
                                            <asp:ListItem>Select State</asp:ListItem>
                                            <asp:ListItem>Andaman and Nicobar</asp:ListItem>
                                            <asp:ListItem>Andhra Pradesh</asp:ListItem>
                                            <asp:ListItem>Arunachal Pradesh</asp:ListItem>
                                            <asp:ListItem>Assam</asp:ListItem>
                                            <asp:ListItem>Bihar</asp:ListItem>
                                            <asp:ListItem>Chandigadh</asp:ListItem>
                                            <asp:ListItem>Chattisgadh</asp:ListItem>
                                            <asp:ListItem>Dadra and Nagar Haveli</asp:ListItem>
                                            <asp:ListItem>Daman and Diu</asp:ListItem>
                                            <asp:ListItem>Delhi</asp:ListItem>
                                            <asp:ListItem>Goa</asp:ListItem>
                                            <asp:ListItem>Gujarat</asp:ListItem>
                                            <asp:ListItem>Haryana</asp:ListItem>
                                            <asp:ListItem>Himachal Pradesh</asp:ListItem>
                                            <asp:ListItem>Jammu and Kashmir</asp:ListItem>
                                            <asp:ListItem>Jharkhand</asp:ListItem>
                                            <asp:ListItem>Karnataka</asp:ListItem>
                                            <asp:ListItem>Kerala</asp:ListItem>
                                            <asp:ListItem>Lakshadweep</asp:ListItem>
                                            <asp:ListItem>Madhya Pradesh</asp:ListItem>
                                            <asp:ListItem>Maharashtra</asp:ListItem>
                                            <asp:ListItem>Manipur</asp:ListItem>
                                            <asp:ListItem>Meghalaya</asp:ListItem>
                                            <asp:ListItem>Mizoram</asp:ListItem>
                                            <asp:ListItem>Nagaland</asp:ListItem>
                                            <asp:ListItem>Puducherry</asp:ListItem>
                                            <asp:ListItem>Punjab</asp:ListItem>
                                            <asp:ListItem>Rajasthan</asp:ListItem>
                                            <asp:ListItem>Sikkim</asp:ListItem>
                                            <asp:ListItem>Tamil Nadu</asp:ListItem>
                                            <asp:ListItem>Tripura</asp:ListItem>
                                            <asp:ListItem>Uttar Pradesh</asp:ListItem>
                                            <asp:ListItem>Uttarakhand</asp:ListItem>
                                            <asp:ListItem>West Bengal</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        City*</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox13" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Address*</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Pincode</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox7" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Aadhar</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtAdhar" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                              <div class="col-md-6">
     <div class="form-group row">
         <label class="col-sm-3 col-form-label">
             PAN</label>
         <div class="col-sm-9">
             <asp:TextBox ID="TextBox12" CssClass="form-control" runat="server"></asp:TextBox>
         </div>
     </div>
 </div>
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Nominee</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtNominee" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                           
                        </div>
                      
                        <p class="card-description" style="font-size: 15px; color: #ff9c00; font-weight: 600;">
                            Bank Information
                        </p>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Bank Name*</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Branch*</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        A/c Number*</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="TextBox10" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                           <div class="col-md-6">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label">
                                    IFSC*</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TextBox11" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        </div>
                  

                        
                        <p class="card-description">
                            Investment Details
                        </p>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        No. of Units
                                    </label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtUnits" runat="server"
                                            ClientIDMode="Static"
                                            CssClass="form-control"
                                            Text="0" Enabled="false"
                                            >
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Amount (₹)
                                    </label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtAmount" runat="server"
                                            ClientIDMode="Static"
                                            CssClass="form-control"
                                            Text="0.00"
                                            Enabled="false">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Handling Charges (0.4%)
                                    </label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtHandlingCharges" runat="server"
                                            ClientIDMode="Static"
                                            CssClass="form-control" Enabled="false"
                                            Text="0.00"
                                            ReadOnly="true">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-3 col-form-label">
                                        Grand Total (₹)
                                    </label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtGrandTotal" runat="server"
                                            ClientIDMode="Static" Enabled="false" Font-Bold="true"
                                            CssClass="form-control"
                                            Text="0.00"
                                            ReadOnly="true">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <center>
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary mr-2" OnClick="Button1_Click"
                            Text="Update" />
                        &nbsp;&nbsp;
                        <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" CssClass="btn btn-primary mr-2">Print</asp:HyperLink>
                    </center>
                   
                    
                </div>
                </form>
                </div>
                </section>
                </div>
            </div>
        </div>
</asp:Content>
