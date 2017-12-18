<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Decommitments.aspx.cs" Inherits="vhcbcloud.Decommitments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="jumbotron clearfix" id="vhcb">

                <p class="lead">Board Decommitments</p>
                <div class="container">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:RadioButtonList ID="rdBtnFinancial" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4" onclick="needToConfirm = true;"
                                RepeatDirection="Horizontal"
                                OnSelectedIndexChanged="rdBtnFinancial_SelectedIndexChanged">
                                <asp:ListItem> Commitment &nbsp;</asp:ListItem>
                                <asp:ListItem Selected="true"> DeCommitment &nbsp;</asp:ListItem>
                                <asp:ListItem> Reallocation &nbsp;</asp:ListItem>
                                <asp:ListItem> Assignments &nbsp;</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>

                <asp:Panel ID="pnlHide" runat="server" Visible="true">
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
                            <div class="panel-body">

                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 10%; float: left; height: 28px;"><span class="labelClass">Project # :</span></td>
                                        <td style="width: 30%; float: left; height: 28px;">
                                            <%-- <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;"
                                                OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                            </asp:DropDownList>--%>
                                            <asp:TextBox ID="txtProjNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1"></asp:TextBox>
                                            <%-- <ajaxToolkit:MaskedEditExtender ID="ameProjNum" runat="server" ClearMaskOnLostFocus="false" Mask="9999-999-999" MaskType="Number" TargetControlID="txtProjNum">
                                            </ajaxToolkit:MaskedEditExtender>--%>
                                            <ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetCommittedProjectsByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>

                                            <asp:TextBox ID="txtCommitedProjNum" runat="server" Visible="false" CssClass="clsTextBoxBlueSm" Width="120px"></asp:TextBox>
                                            <%--<ajaxToolkit:MaskedEditExtender ID="ameCommitExt" runat="server" ClearMaskOnLostFocus="false" Mask="9999-999-999" MaskType="Number" TargetControlID="txtCommitedProjNum">
                                            </ajaxToolkit:MaskedEditExtender>--%>
                                            <ajaxToolkit:AutoCompleteExtender ID="aceCommitAuto" runat="server" TargetControlID="txtCommitedProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnCommittedProjectSelected" CompletionInterval="100" ServiceMethod="GetCommittedPendingProjectslistByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>

                                        </td>
                                        <td style="width: 20%; float: left; height: 28px;">
                                            <asp:Label ID="lblProjName" class="labelClass" Text=" " runat="server"></asp:Label></td>
                                        <td style="float: left; height: 28px;">
                                            <asp:Label ID="lblGrantee" class="labelClass" Text=" " runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left; height: 27px;"><span class="labelClass">Available Funds:</span></td>
                                        <td style="width: 30%; float: left; height: 27px;">
                                            <asp:Label ID="lblAvailFund" runat="server" class="labelClass" Text="" Visible="false"></asp:Label>
                                            <asp:Label ID="lblAvailVisibleFund" runat="server" class="labelClass" Text=""></asp:Label></td>
                                        <td style="width: 20%; float: left; height: 27px;"></td>
                                        <td style="float: left; height: 27px;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left">&nbsp;</td>
                                        <td style="width: 20%; float: left">&nbsp;</td>
                                        <td style="width: 10%; float: left">&nbsp;</td>
                                        <td style="float: left">&nbsp;</td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="divPtransEntry" runat="server">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 10%; float: left"><span class="labelClass">Trans Date :</span></td>
                                            <td style="width: 20%; float: left">
                                                <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="aceTransDate" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 20%; float: left"><span class="labelClass">Amount to Decommit $ :</span></td>
                                            <td style="width: 20%; float: left">
                                                <asp:TextBox ID="txtTotAmt" CssClass="clsTextBoxMoney" onkeyup='toTotAmtFormatter(value)' runat="server"></asp:TextBox></td>
                                            <td style="width: 15%; float: left"></td>
                                            <td style="width: 15%; float: left"></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <%--   <asp:LinkButton ID="btnTransSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnTransSubmit_Click" 
                                OnClientClick="needToConfirm = false;" />--%>
                                    <asp:Button ID="btnTransactionSubmit" runat="server" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;" OnClick="btnTransactionSubmit_Click" />
                                    <br />
                                </div>
                                <br />

                                <asp:GridView ID="gvPTrans" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvPTrans_RowCancelingEdit" OnRowCreated="gvPTrans_RowCreated" OnRowDeleting="gvPTrans_RowDeleting" OnRowEditing="gvPTrans_RowEditing" OnRowUpdating="gvPTrans_RowUpdating" OnSelectedIndexChanged="gvPTrans_SelectedIndexChanged">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("transid")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trans Date" SortExpression="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTransDate" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="acebdt" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                            <FooterStyle Width="100px" />
                                            <HeaderStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trans Amount" SortExpression="TransAmt" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                                <asp:HiddenField ID="HiddenField2" runat="server" Value='<%#Eval("TransAmt")%>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTransAmt" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("TransAmt", "{0:0.00}") %>'></asp:TextBox>

                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                            <FooterStyle Width="200px" />
                                            <HeaderStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trans Status" SortExpression="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransStatus" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" Visible="false" runat="server"></asp:DropDownList>
                                                <asp:Label ID="lblTransStatusView" runat="Server" Text='<%# Eval("Description") %>' />
                                                <asp:TextBox ID="txtTransStatus" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lkStatus") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ProjectID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjId" runat="Server" Text='<%# Eval("projectid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="TransId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransId" runat="Server" Text='<%# Eval("transid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <%--<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Update" Text="activate" OnClientClick="return confirm('Are you sure you want to activate this transaction?');"></asp:LinkButton>--%>
                                                &nbsp;
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="delete" OnClientClick="return confirm('Are you sure you want to delete this transaction?');"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="footerStyle" />
                                </asp:GridView>
                                <p class="lblErrMsg">
                                    <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:Panel ID="pnlTranDetails" runat="server" Visible="false">
                        <div class="container">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <asp:Label runat="server" ID="lblTransDetHeader" Text="Transaction Detail"></asp:Label>
                                </div>
                                <div class="panel-body">
                                    <div id="divTransDetailEntry" runat="server">
                                        <table style="width: 100%" runat="server" id="tblFundDet">
                                            <tr>
                                                <td style="width: 10%; float: left">
                                                    <span class="labelClass">Fund # :</span></td>
                                                <td style="width: 20%; float: left">
                                                    <asp:DropDownList ID="ddlAcctNum" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlAcctNum_SelectedIndexChanged" AutoPostBack="True" TabIndex="8">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 10%; float: left"><span class="labelClass">Fund Name :</span></td>
                                                <td style="width: 20%; float: left">
                                                    <asp:DropDownList ID="ddlFundName" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;" AutoPostBack="true" OnSelectedIndexChanged="ddlFundName_SelectedIndexChanged"></asp:DropDownList>
                                                    <asp:Label ID="lblFundName" class="labelClass" Text=" " runat="server" Visible="false"></asp:Label>
                                                </td>
                                                <td style="width: 15%; float: left"><span class="labelClass">Trans Type :</span></td>
                                                <td style="width: 25%; float: left">
                                                    <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" TabIndex="9" OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 4px" colspan="6" />
                                            </tr>
                                            <tr>
                                                <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                                <td style="width: 20%; float: left">
                                                    <asp:TextBox ID="txtAmt" CssClass="clsTextBoxMoney" onkeyup='toAmtFormatter(value)' runat="server" TabIndex="10"></asp:TextBox></td>
                                                <td style="width: 10%; float: left">
                                                    <asp:Label ID="lblUsePermit" class="labelClass" runat="server" Visible="false" Text="Use Permit:"></asp:Label>
                                                </td>
                                                <td style="width: 20%; float: left">
                                                    <asp:DropDownList ID="ddlUsePermit" CssClass="clsDropDown" runat="server" Visible="false" TabIndex="10" AutoPostBack="true" OnSelectedIndexChanged="ddlUsePermit_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 15%; float: left">
                                                    <span class="labelClass">Available Funds:</span>
                                                </td>
                                                <td style="width: 25%; float: left">
                                                    <asp:Label ID="lblAvDetailFund" runat="server" class="labelClass" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <%--  <asp:LinkButton ID="btnDecommitSubmit" runat="server" visible="false" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;"
                                OnClick="btnSubmit_Click" />--%>
                                        <br />
                                        <asp:Button ID="btnDecommitmentSubmit" runat="server" Enabled="true" Text="Submit" class="btn btn-info" OnClick="btnDecommitmentSubmit_Click" />
                                    </div>
                                    <br />
                                    <asp:GridView ID="gvBCommit" runat="server" AutoGenerateColumns="False"
                                        Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                        GridLines="None" EnableTheming="True" AllowPaging="false"
                                        AllowSorting="true" ShowFooter="True" OnRowCancelingEdit="gvBCommit_RowCancelingEdit"
                                        OnRowEditing="gvBCommit_RowEditing" OnRowUpdating="gvBCommit_RowUpdating" OnRowDataBound="gvBCommit_RowDataBound" OnRowDeleting="gvBCommit_RowDeleting">
                                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                        <HeaderStyle CssClass="headerStyle" />
                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                        <RowStyle CssClass="rowStyle" />
                                        <FooterStyle CssClass="footerStyleTotals" />
                                        <Columns>

                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdBtnSelectTransDetail" class="show" runat="server" onclick="RadioCheck1(this);" AutoPostBack="true"
                                                        OnCheckedChanged="rdBtnSelectTransDetail_CheckedChanged" />
                                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("detailid")%>' />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fund #" SortExpression="Account">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    Running Total :
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fund Name" SortExpression="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FundName") %>' />
                                                </ItemTemplate>
                                                <%-- <EditItemTemplate>
                                    <asp:TextBox ID="txtFundName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Name") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblFooterAmount" Text=""></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" Visible="false"></asp:DropDownList>
                                                    <asp:Label ID="lbEditlTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                                    <asp:TextBox ID="txtTransType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lktranstype") %>' Visible="false"></asp:TextBox>
                                                </EditItemTemplate>
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
                                                    <asp:TextBox ID="txtAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount", "{0:0.00}") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblFooterBalance" Text=""></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                </ItemTemplate>
                                                <ItemStyle Width="200px" />
                                                <FooterStyle Width="200px" />
                                                <HeaderStyle Width="200px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false" HeaderText="Fund Id" SortExpression="FundID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false" HeaderText="Detail Id" SortExpression="detailid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDetId" runat="Server" Text='<%# Eval("detailid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowEditButton="True" />
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete?');"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="footerStyle" />
                                    </asp:GridView>
                                    <br />
                                    <asp:Button ID="btnNewTransaction" runat="server" class="btn btn-info" Visible="false" Enabled="true" OnClick="btnNewTransaction_Click" TabIndex="11" Text="Add New Decommitment" />
                                    <br />
                                    <br />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </asp:Panel>
                <asp:HiddenField ID="hfGrantee" runat="server" />
                <asp:HiddenField ID="hfProjId" runat="server" />
                <asp:HiddenField ID="hfTransId" runat="server" />
                <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
                <asp:HiddenField ID="hfTransAmt" runat="server" Value="0" />
                <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
                <asp:HiddenField ID="hdnCommitedProjValue" OnValueChanged="hdnCommitedProjValue_ValueChanged" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <script type="text/javascript">
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            var balAmt = document.getElementById("<%=hfBalAmt.ClientID%>").value;
            //var traAmt = document.getElementById("<%=hfTransAmt.ClientID%>").value;

            if (needToConfirm && balAmt != 0)
                return "You have attempted to leave this page.  Please make sure balance amount is 0 for each transaction, otherwise the transaction can't be used for board financial transactions.  Are you sure you want to exit this page?";
        }
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvPTrans.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }

        function PopupNewAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function PopupExistingAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function PopupProjectSearch() {
            window.open('./projectsearch.aspx')
        };

        function OnCommittedProjectSelected(source, eventArgs) {

            var hdnCommitedProjValueID = "<%= hdnCommitedProjValue.ClientID %>";

            document.getElementById(hdnCommitedProjValueID).value = eventArgs.get_value();
            __doPostBack(hdnCommitedProjValueID, "");
        }

        function OnContactSelected(source, eventArgs) {

            var hdnValueID = "<%= hdnValue.ClientID %>";

            document.getElementById(hdnValueID).value = eventArgs.get_value();
            __doPostBack(hdnValueID, "");
        }
        //Currency formatter code starts below
        var formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD',
            minimumFractionDigits: 2,
        });
        toTotAmtFormatter = value => {
            const digits = this.getDigitsFromValue(value);
            const digitsWithPadding = this.padDigits(digits);

            let result = this.addDecimalToNumber(digitsWithPadding);

            var inputElement = document.getElementById("txtTotAmt");

            //inputElement.value = formatter.format(result);
            $('#<%= txtTotAmt.ClientID%>').val(formatter.format(result));
         };

         toAmtFormatter = value => {
             const digits = this.getDigitsFromValue(value);
             const digitsWithPadding = this.padDigits(digits);

             let result = this.addDecimalToNumber(digitsWithPadding);

             var inputElement = document.getElementById("txtAmt");

             //inputElement.value = "$" + result;
             $('#<%= txtAmt.ClientID%>').val(formatter.format(result));
        };
        getDigitsFromValue = (value) => {
            return value.toString().replace(/\D/g, '');
        };

        padDigits = digits => {
            const desiredLength = 3;
            const actualLength = digits.length;

            if (actualLength >= desiredLength) {
                return digits;
            }

            const amountToAdd = desiredLength - actualLength;
            const padding = '0'.repeat(amountToAdd);

            return padding + digits;
        };
        addDecimalToNumber = number => {
            const centsStartingPosition = number.length - 2;
            const dollars = this.removeLeadingZeros(number.substring(0, centsStartingPosition));
            const cents = number.substring(centsStartingPosition);
            return `${dollars}.${cents}`;
        };
        removeLeadingZeros = number => number.replace(/^0+([0-9]+)/, '$1');
    </script>
</asp:Content>
