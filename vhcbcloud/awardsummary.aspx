<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="awardsummary.aspx.cs" Inherits="vhcbcloud.awardsummary" %>

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
                    <asp:Panel runat="server" ID="Panel1" Width="100%" Height="200px" ScrollBars="Vertical">
                        <asp:GridView ID="gvCurrentAwdStatus" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                            OnRowCreated="gvCurrentAwdStatus_RowCreated"
                            ShowFooter="True" Width="90%" AllowSorting="True" OnSorting="gvCurrentAwdStatus_Sorting">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>

                                <asp:TemplateField HeaderText="Reallocate To">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReallocateTo" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        Totals :
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("fundid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Account" SortExpression="account">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundAcct" runat="Server" Text='<%# Eval("account") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund" SortExpression="FundName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FundName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Type" SortExpression="FundType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("FundType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pending Committed" SortExpression="pendingamount" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPendingAmt" runat="Server" Text='<%# Eval("pendingamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblPending" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Committed" SortExpression="CommitmentAmount" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommitAmt" runat="Server" Text='<%# Eval("commitmentamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblCommit" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Pending Disburse" SortExpression="expendedamount" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpendAmd" runat="Server" Text='<%# Eval("expendedamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblExpend" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Final Disburse" SortExpression="finaldisbursedamount" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFinalExpendAmt" runat="Server" Text='<%# Eval("finaldisbursedamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblFinalExpend" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Provisional Balance" SortExpression="balance" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("balance", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblBalance" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Id" SortExpression="FundID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                    </ItemTemplate>
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
                    <asp:Panel runat="server" ID="pnlTransDet" Width="100%" Height="350px" ScrollBars="Vertical">
                        <asp:GridView ID="gvTransDetail" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                            AllowPaging="false" Width="90%" AllowSorting="True" OnSorting="gvTransDetail_Sorting">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("fundid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Acct" SortExpression="account">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundAcct" runat="Server" Text='<%# Eval("account") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date" SortExpression="TransDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("TransDate", "{0:M-dd-yyyy}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Name" SortExpression="name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfundName" runat="Server" Text='<%# Eval("name") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Type" SortExpression="FundType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("FundType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction" SortExpression="Transaction">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransaction" runat="Server" Text='<%# Eval("Transaction") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" SortExpression="lkstatus">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="Server" Text='<%# Eval("lkstatus") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Detail" SortExpression="detail">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDetail" runat="Server" Text='<%# Eval("detail", "{0:C2}") %>' />
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

    <script type="text/javascript">
        function OnContactSelected(source, eventArgs) {

            var hdnValueID = "<%= hdnValue.ClientID %>";

             document.getElementById(hdnValueID).value = eventArgs.get_value();
             __doPostBack(hdnValueID, "");
         }
    </script>
</asp:Content>

