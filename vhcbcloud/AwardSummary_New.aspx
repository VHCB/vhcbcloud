<%@ Page Title="Award Summary" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AwardSummary_New.aspx.cs" Inherits="vhcbcloud.AwardSummary_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">Award Summary</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span class="labelClass">Current Award Status for project: <b>
                        <asp:Label runat="server" ID="lblProjId"></asp:Label></b></span>
                </div>
                <div class="panel-body">
                    <p class="labelClass">
                        <span class="labelClass">Project # :</span>
                        <asp:DropDownList ID="ddlProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProj_SelectedIndexChanged"></asp:DropDownList>
                        <asp:TextBox ID="txtFromCommitedProjNum" runat="server" CssClass="clsTextBoxBlueSm" Width="120px"></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender ID="aceCommitAuto" runat="server" TargetControlID="txtFromCommitedProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                            OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetProjectsByFilter">
                        </ajaxToolkit:AutoCompleteExtender>
                        <asp:ImageButton ID="AwardSummaryReport" ImageUrl="~/Images/print.png" ToolTip="Award Summary Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="AwardSummaryReport_Click" />
                    </p>
                    <asp:Panel runat="server" ID="Panel1" Width="100%" Height="300px" ScrollBars="None">
                        <asp:GridView ID="gvCurrentAwdStatus" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                          
                            ShowFooter="True" Width="100%" AllowSorting="True" OnSorting="gvCurrentAwdStatus_Sorting">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>
                                <asp:TemplateField HeaderText="Account" SortExpression="account">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundAcct" runat="Server" Text='<%# Eval("Account") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund" SortExpression="FundName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FundName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Type" SortExpression="FundTransTypeName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("FundTransTypeName") %>' />
                                    </ItemTemplate>
                                     <FooterTemplate>
                                                    Totals :
                                                </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Commited" SortExpression="FinalCommited">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommitedAmt" runat="Server" Text='<%# Eval("FinalCommited", "{0:C2}") %>' />
                                    </ItemTemplate>
                                     <FooterTemplate>
                                        <asp:Label ID="lblCommited" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Disbursed" SortExpression="Disbursed">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDisbursedAmt" runat="Server" Text='<%# Eval("Disbursed", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblDisbursed" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Balance" SortExpression="Balanced">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBalanceAmt" runat="Server" Text='<%# Eval("Balanced ", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblBalance" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Pending" SortExpression="Pending">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPendingAmt" runat="Server" Text='<%# Eval("Pending", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblPending" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                    </asp:Panel>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                    </p>
                </div>
                <div class="panel-heading">Transaction Detail</div>
                <div class="panel-body">
                    <asp:Panel runat="server" ID="pnlTransDet" Width="100%" Height="400px" ScrollBars="None">
                        <asp:GridView ID="gvTransDetail" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                            AllowPaging="false" Width="100%" AllowSorting="True" OnSorting="gvTransDetail_Sorting" OnRowDataBound="gvTransDetail_RowDataBound">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                               <%-- <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField2" runat="server" Value='<%#Eval("fundid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Fund Acct" SortExpression="account">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="Server" Text='<%# Eval("account") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date" SortExpression="TransDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("TransDate", "{0:M-dd-yyyy}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Project" SortExpression="ProjectName">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Name" SortExpression="FundName">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="Server" Text='<%# Eval("FundName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Type" SortExpression="FundType">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="Server" Text='<%# Eval("FundType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction" SortExpression="Transaction">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransaction" runat="Server" Text='<%# Eval("Transaction") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="Server" Text='<%# Eval("Status") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Detail" SortExpression="Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDetail" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                    <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
                    <asp:HiddenField ID="hfProjId" runat="server" />

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="Scripts/jquery.min.js"></script> 
    <script type="text/javascript" src="Scripts/jquery-ui.min.js"></script>
    <script type="text/javascript" src="Scripts/gridviewScroll.min.js"></script>

    <script type="text/javascript">
        function OnContactSelected(source, eventArgs) {

            var hdnValueID = "<%= hdnValue.ClientID %>";

             document.getElementById(hdnValueID).value = eventArgs.get_value();
             __doPostBack(hdnValueID, "");
        }

        $(document).ready(function () {
            gridviewScroll(<%=gvCurrentAwdStatus.ClientID%>);
            gridviewScroll(<%=gvTransDetail.ClientID%>);
        });

        function gridviewScroll(gridId) {
            $(gridId).gridviewScroll({
                width: 980,
                height: 400
            });
        }

    </script>
</asp:Content>