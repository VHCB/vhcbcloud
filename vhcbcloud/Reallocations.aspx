<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Reallocations.aspx.cs" Inherits="vhcbcloud.Reallocations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    all<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="jumbotron clearfix" id="vhcb">

                <p class="lead">Board Reallocations</p>
                <div class="container">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:RadioButtonList ID="rdBtnFinancial" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4" onclick="needToConfirm = true;"
                                RepeatDirection="Horizontal"
                                OnSelectedIndexChanged="rdBtnFinancial_SelectedIndexChanged">
                                <asp:ListItem> Commitment &nbsp;</asp:ListItem>
                                <asp:ListItem> DeCommitment &nbsp;</asp:ListItem>
                                <asp:ListItem Selected="true"> Reallocation &nbsp;</asp:ListItem>
                                <%-- <asp:ListItem> Cash Refund &nbsp;</asp:ListItem>--%>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>

                <asp:Panel ID="pnlReallocations" runat="server" Visible="true">
                    <div class="container">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <asp:RadioButtonList ID="rdBtnSelection" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal" onclick="needToConfirm = true;"
                                                OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                                <asp:ListItem Selected="True">New    </asp:ListItem>
                                                <asp:ListItem>Existing</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                        <td style="text-align: right">
                                            <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" Style="border: none;" runat="server" Text="Project Search" Visible="true"
                                                OnClientClick="PopupProjectSearch(); return false;"></asp:ImageButton>
                                            &nbsp;
                                        <asp:ImageButton ID="imgNewAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="true"
                                            OnClientClick="PopupNewAwardSummary(); return false;"></asp:ImageButton>
                                            <asp:ImageButton ID="imgExistingAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="false"
                                                OnClientClick="PopupExistingAwardSummary(); return false;"></asp:ImageButton>
                                            &nbsp;
                                <asp:ImageButton ID="btnProjectNotes" ImageUrl="~/Images/notes.png" ToolTip="Notes" runat="server" Text="Project Notes" Style="border: none;"></asp:ImageButton>
                                            &nbsp;
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes" CancelControlID="btnClose"
                                BackgroundCssClass="MEBackground">
                            </ajaxToolkit:ModalPopupExtender>
                            <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                                <iframe style="width: 750px; height: 600px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                                <br />
                                <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />

                            </asp:Panel>
                            <div class="panel-heading">Reallocate from</div>
                            <div class="panel-body">

                                <table style="width: 100%" class="">
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:DropDownList ID="ddlRFromProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlRFromProj_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="txtFromProjNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1"></asp:TextBox>

                                            <ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtFromProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetCommittedPendingProjectslistByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>--%>

                                        </td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Date :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:TextBox ID="txtRfromDate" runat="server" CssClass="clsTextBoxBlue1"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtRfromDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 10%; float: left">
                                            <span class="labelClass">Fund :</span>
                                        </td>
                                        <td style="width: 30%; float: left">
                                            <asp:DropDownList ID="ddlRFromFund" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRFromFund_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="txtToProjNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1"></asp:TextBox>

                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtToProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetCommittedPendingProjectslistByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>--%>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="height: 4px" colspan="6" />
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Type :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:DropDownList ID="ddlRFromFundType" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;">
                                            </asp:DropDownList></td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:TextBox ID="txtRfromAmt" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%; float: left"></td>
                                        <td style="width: 30%; float: left">
                                            
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <p class="lblErrMsg">
                                    <asp:Label runat="server" ID="lblRErrorMsg" Font-Size="Small"></asp:Label>
                                </p>

                            </div>
                        </div>
                    </div>
                    <div class="container" id="divReallocateTo" runat="server">
                        <div class="panel panel-default">
                            <div class="panel-heading">Reallocate To</div>
                            <div class="panel-body">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Project# :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:DropDownList ID="ddlRToProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;"
                                                OnSelectedIndexChanged="ddlRToProj_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Fund :</span></td>
                                        <td style="width: 60%; float: left" colspan="3">
                                            <asp:DropDownList ID="ddlRToFund" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRToFund_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 4px" colspan="6" />
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Type :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:DropDownList ID="ddlRtoFundType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                        <td style="width: 60%; float: left" colspan="3">
                                            <asp:TextBox ID="txtRToAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>

                                    </tr>

                                </table>
                                <br />
                                <asp:Button ID="btnReallocateSubmit" runat="server" Enabled="true" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;" OnClick="btnReallocateSubmit_Click" />
                                <br />
                                <br />

                                <asp:GridView ID="gvReallocate" runat="server" AllowPaging="false" AllowSorting="true" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True"
                                    GridLines="None"
                                    PagerSettings-Mode="NextPreviousFirstLast" ShowFooter="True" Width="90%">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings FirstPageText="&amp;lt;" LastPageText="&amp;gt;" Mode="NumericFirstLast" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("transid")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project #" SortExpression="proj_num">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRProjNum" runat="Server" Text='<%# Eval("proj_num") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Account Number" SortExpression="Account">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                            </ItemTemplate>
                                            <%--<EditItemTemplate>
                                    <asp:TextBox ID="txtAcctNum" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Account") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
                                            <FooterTemplate>
                                                Running Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund Name" SortExpression="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("Name") %>' />
                                            </ItemTemplate>
                                            <%-- <EditItemTemplate>
                                    <asp:TextBox ID="txtFundName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Name") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFooterAmount" runat="server" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                            <%--<EditItemTemplate>
                                        <asp:DropDownList ID="ddlTransType" runat="server" CssClass="clsDropDown">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtTransType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lktranstype") %>' Visible="false"></asp:TextBox>
                                    </EditItemTemplate>--%>
                                            <FooterTemplate>
                                                Balance Amount :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" SortExpression="Amount" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFooterBalance" runat="server" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                            <FooterStyle Width="200px" />
                                            <HeaderStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund Id" SortExpression="FundID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Detail Id" SortExpression="detailid" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDetId" runat="Server" Text='<%# Eval("detailid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                    <FooterStyle CssClass="footerStyle" />
                                </asp:GridView>

                                <br />
                                <asp:Button ID="btnNewTransaction" runat="server" class="btn btn-info" Enabled="true" OnClick="btnNewTransaction_Click" TabIndex="11" Text="Add New Reallocation" Visible="False" />
                                <br />

                                <br />
                            </div>
                        </div>
                    </div>
                    <asp:HiddenField ID="hfTransAmt" runat="server" Value="0" />
                    <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
                    <asp:HiddenField ID="hfTransId" runat="server" />
                    <asp:HiddenField ID="hfRFromTransId" runat="server" />
                    <asp:HiddenField ID="hfProjId" runat="server" />
                </asp:Panel>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            var balAmt = document.getElementById("<%=hfBalAmt.ClientID%>").value;
            //var traAmt = document.getElementById("<%=hfTransAmt.ClientID%>").value;

            if (needToConfirm && balAmt != 0)
                return "You have attempted to leave this page.  Please make sure balance amount is 0 for each transaction, otherwise the transaction can't be used for board financial transactions.  Are you sure you want to exit this page?";
        }

        function PopupNewAwardSummary() {
            window.open('./awardsummary.aspx?Reallocations=true&projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function PopupExistingAwardSummary() {
            window.open('./awardsummary.aspx?Reallocations=true&projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function PopupProjectSearch() {
            window.open('./projectsearch.aspx')
        };

    </script>
</asp:Content>
