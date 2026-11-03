
<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true"
    CodeFile="dashboard.aspx.cs" Inherits="admin_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="wrapper main-wrapper row" style="">
        <div class="clearfix">
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats one">
                <a href="view-members.aspx">
                    <div class="card-header card-header-warning card-header-icon" style="padding: 25px 10px 25px 10px">
                        <h3 class="card-title" style="font-size: 18px">
                            View Members</h3>
                    </div>
                </a>
            </div>
        </div>
       
        
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats three">
                <a href="withdraw-request.aspx">
                    <div class="card-header card-header-warning card-header-icon" style="padding: 25px 10px 25px 10px">
                        <h3 class="card-title" style="font-size: 18px">
                            Withdraw Requests
                        </h3>
                    </div>
                </a>
            </div>
        </div>
       
         <div class="col-lg-3 col-md-6 col-sm-6">
        <div class="card card-stats five">
                 <a href="account-bydate.aspx">
                     <div class="card-header card-header-warning card-header-icon" style="padding: 15px 10px 25px 10px">
                         <h3 class="card-title" style="font-size: 18px">
                          Todays Reg : <asp:Label ID="lblroi" runat="server" Text="0"></asp:Label> 
                             <br />
                             <br />
                              Total Reg : <asp:Label ID="lbltotalroi" runat="server" Text="0"></asp:Label> 
                         </h3>
                     </div>
                 </a>
             </div>
         </div>

         <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats six">
                     <a href="history.aspx">
                         <div class="card-header card-header-warning card-header-icon" style="padding: 15px 10px 25px 10px">
                             <h3 class="card-title" style="font-size: 18px">
                              Investment History 
                                 <br />
                                 <br />
                                  Rs <asp:Label ID="lbltotal" runat="server" Text="0"></asp:Label> 
                             </h3>
                         </div>
                     </a>
                 </div>
             </div> 
          <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="card card-stats nine">
              <a href="walletReport.aspx">
                  <div class="card-header card-header-warning card-header-icon" style="padding: 15px 10px 25px 10px">
                      <h3 class="card-title" style="font-size: 18px">
                        
                         Wallet Report
                           
                           
                      </h3>
                  </div>
              </a>
          </div>
         </div>

          <div class="col-lg-3 col-md-6 col-sm-6">
              <div class="card card-stats nine">
                  <a href="generate-divident.aspx">
                      <div class="card-header card-header-warning card-header-icon" style="padding: 15px 10px 25px 10px">
                          <h3 class="card-title" style="font-size: 18px">
                          Generate Divident
                          </h3>
                      </div>
                  </a>
              </div>
             </div>
        <!-- MAIN CONTENT AREA ENDS -->
    </div>
</asp:Content>
