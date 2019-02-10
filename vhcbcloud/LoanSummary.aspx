<%@ Page Title="Loan Summary" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoanSummary.aspx.cs" Inherits="vhcbcloud.LoanSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">Loan Summary</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-body">
                    <%--<p class="labelClass">
                        &nbsp;&nbsp;<span class="labelClass">Project # :</span>
                        <asp:DropDownList ID="ddlProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProj_SelectedIndexChanged"></asp:DropDownList>
                        <asp:TextBox ID="txtFromCommitedProjNum" runat="server" CssClass="clsTextBoxBlueSm" Width="120px"></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender ID="aceCommitAuto" runat="server" TargetControlID="txtFromCommitedProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                            OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetProjectsByFilter">
                        </ajaxToolkit:AutoCompleteExtender>
                        <asp:ImageButton ID="AwardSummaryReport" ImageUrl="~/Images/print.png" ToolTip="Loan Summary Report"
                            Style="border: none; vertical-align: middle;" runat="server" />
                    </p>--%>
                    <div class="panel-heading">
                        <table style="width: 100%;">
                                <tr>
                                    <td style="width: 80px"><span class="labelClass">Project Name:</span></td>
                                    <td style="width: 200px"><asp:Label ID="lblProjectName" class="labelClass" Text=" " runat="server"></asp:Label></td>
                                    <td style="width: 48px"><span class="labelClass">Loan #:</span></td>
                                    <td style="width: 100px"><asp:Label ID="lblLoanID" class="labelClass" Text=" " runat="server"></asp:Label></td>
                                    <td style="width: 77px"><span class="labelClass">Note Amount:</span></td>
                                    <td style="width: 100px"><asp:Label ID="lblNoteAmount" class="labelClass" Text=" " runat="server"></asp:Label></td>
                                    <td style="width: 78px"><span class="labelClass">Beg. Balance:</span></td>
                                    <td style="width: 100px"><asp:Label ID="lblBegBalance" class="labelClass" Text=" " runat="server"></asp:Label></td>
                                    <td>
                                        <asp:ImageButton ID="ImgLoanSummaryReport" ImageUrl="~/Images/print.png" ToolTip="Loan Summary Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgLoanSummaryReport_Click"/>
                                    </td>
                                </tr>
                            </table>
                    </div>
                    <asp:Panel runat="server" ID="Panel1" Width="100%" Height="300px" ScrollBars="None">
                        <asp:GridView ID="gvLoanSummary" runat="server" AutoGenerateColumns="False" 
                            CssClass="gridView" EnableTheming="True" GridLines="None" OnRowDataBound="gvLoanSummary_RowDataBound"
                            ShowFooter="True" Width="100%" AllowSorting="False">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>
                                <asp:TemplateField HeaderText="Trans Type" SortExpression="FundType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("FundType") %>' />
                                    </ItemTemplate>
                                     <FooterTemplate>
                                        Totals :
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEffectiveDate" runat="Server" Text='<%# Eval("EffectiveDate", "{0:MM/dd/yyyy}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Disbursement" SortExpression="Disbursement">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDisbursement" runat="Server" Text='<%# Eval("Disbursement", "{0:C2}") %>' />
                                    </ItemTemplate>
                                     <FooterTemplate>
                                        <asp:Label ID="lblDisbursementTotal" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Modifications" SortExpression="Modifications">
                                    <ItemTemplate>
                                        <asp:Label ID="lblModifications" runat="Server" Text='<%# Eval("Modifications", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblModificationsTotal" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Receipts" SortExpression="Receipts">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceipts" runat="Server" Text='<%# Eval("Receipts", "{0:C2}") %>' />
                                    </ItemTemplate>
                                     <FooterTemplate>
                                        <asp:Label ID="lblReceiptsTotal" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Balance" SortExpression="Balance">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBalance" runat="Server" Text='<%# Eval("Balance", "{0:C2}") %>' />
                                        <asp:Label ID="lblStar" runat="Server"/>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblBalanceTotal" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                        <span class="labelClass"> *  includes Beginning Balance in calculation</span>
                    </asp:Panel>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                    </p>
                </div>
                <div class="panel-body">
                </div>
                <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
                <asp:HiddenField ID="hfProjId" runat="server" />
                <asp:HiddenField ID="hfRecordCount" runat="server" Value ="0" />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function OnContactSelected(source, eventArgs) {

            var hdnValueID = "<%= hdnValue.ClientID %>";

            document.getElementById(hdnValueID).value = eventArgs.get_value();
            __doPostBack(hdnValueID, "");
        }

        function gridviewScroll(gridId) {
            $(gridId).gridviewScroll({
                width: 980,
                height: 350
            });
        }

        function gridviewScrollDetail(gridId) {
            $(gridId).gridviewScroll({
                width: 980,
                height: 600
            });
        }
    </script>
</asp:Content>
