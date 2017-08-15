<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ExistingReallocations.aspx.cs" Inherits="vhcbcloud.ExistingReallocations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                                <asp:ListItem> Assignments &nbsp;</asp:ListItem>
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
                            <div class="panel-heading">Reallocations</div>
                            <div class="panel-body" id="pnlReallocateFrom" runat="server">
                                <table style="width: 100%" class="">
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                                        <td style="width: 20%; float: left">
                                            <%--<asp:DropDownList ID="ddlRFromProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" Visible="false" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlRFromProj_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            --%><%--<asp:TextBox ID="txtFromProjNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1"></asp:TextBox>

                                            <ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtFromProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetCommittedPendingProjectslistByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>--%>

                                            <%-- <asp:TextBox ID="txtFromProjNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1"></asp:TextBox>--%>
                                            <%-- <ajaxToolkit:MaskedEditExtender ID="ameProjNum" runat="server" ClearMaskOnLostFocus="false" Mask="9999-999-999" MaskType="Number" TargetControlID="txtProjNum">
                                            </ajaxToolkit:MaskedEditExtender>--%>
                                            <%--<ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtFromProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetProjectsByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>--%>

                                            <asp:TextBox ID="txtFromCommitedProjNum" runat="server" Visible="false" CssClass="clsTextBoxBlueSm" Width="120px"></asp:TextBox>
                                            <%--<ajaxToolkit:MaskedEditExtender ID="ameCommitExt" runat="server" ClearMaskOnLostFocus="false" Mask="9999-999-999" MaskType="Number" TargetControlID="txtCommitedProjNum">
                                            </ajaxToolkit:MaskedEditExtender>--%>
                                            <ajaxToolkit:AutoCompleteExtender ID="aceCommitAuto" runat="server" TargetControlID="txtFromCommitedProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                OnClientItemSelected="OnRelocationProjectSelected" CompletionInterval="100" ServiceMethod="GetCommittedPendingProjectslistByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>

                                        </td>
                                        <td style="width: 10%; float: left">&nbsp;</td>
                                        <td style="width: 20%; float: left">
                                            <asp:Label ID="lblProjName" runat="server" class="labelClass" Text=" "></asp:Label>
                                        </td>
                                        <td style="width: 20%; float: left">
                                            <asp:Label ID="lblGrantee" runat="server" class="labelClass" Text=" "></asp:Label>
                                        </td>
                                        <td style="width: 30%; float: left"></td>

                                    </tr>
                                    <tr>
                                        <td style="height: 4px" colspan="6" />
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left">&nbsp;</td>
                                        <td style="width: 20%; float: left">&nbsp;</td>
                                        <td style="width: 10%; float: left">&nbsp;</td>
                                        <td style="width: 20%; float: left">&nbsp;</td>
                                        <td style="width: 20%; float: left">&nbsp;</td>
                                        <td style="width: 20%; float: left">
                                            <asp:Label ID="lblAvailFund" runat="server" class="labelClass" Text="" Visible="false">
                                            </asp:Label>
                                            <asp:Label ID="lblAvailVisibleFund" runat="server" class="labelClass" Visible="False"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:GridView ID="gvReallocate" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvReallocate_RowCancelingEdit" OnRowEditing="gvReallocate_RowEditing"
                                    OnRowUpdating="gvReallocate_RowUpdating" OnRowDeleting="gvReallocate_RowDeleting" OnSelectedIndexChanged="gvReallocate_SelectedIndexChanged" OnRowCreated="gvReallocate_RowCreated" TabIndex="7">
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
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="10px" />
                                            <FooterStyle Width="10px" />
                                            <HeaderStyle Width="10px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trans Date" SortExpression="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>'></asp:Label>
                                                <asp:TextBox ID="txtTransDate" Visible="false" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="acebdt" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <FooterStyle Width="50px" />
                                            <HeaderStyle Width="50px" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Fund Name" SortExpression="FromFundName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FromFundName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                            <FooterStyle Width="100px" />
                                            <HeaderStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Type" SortExpression="FromFundtransType">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("FromFundtransType") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <FooterStyle Width="50px" />
                                            <HeaderStyle Width="50px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trans Amount" SortExpression="TransAmt" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                                <asp:HiddenField ID="HiddenField2" runat="server" Value='<%#Eval("TransAmt")%>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblTrAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <FooterStyle Width="50px" />
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
                                                &nbsp;
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="delete" OnClientClick="return confirm('Are you sure you want to delete this transaction?');"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" UpdateText="Activate" Visible="false" />
                                    </Columns>
                                    <FooterStyle CssClass="footerStyle" />
                                </asp:GridView>
                                <br />
                                <p class="lblErrMsg">
                                    <asp:Label runat="server" ID="lblRErrorMsg" Font-Size="Small"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>

                </asp:Panel>
                <asp:Panel ID="pnlTranDetails" runat="server" Visible="false">
                    <div class="container">
                        <div class="panel-width">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <asp:Label runat="server" ID="lblTransDetHeader" Text="Transaction Detail"></asp:Label>
                                </div>
                                <div class="panel-body">
                                    <div id="dvReallocateToForm" runat="server">
                                        <table style="width: 100%" id="tblFundDet" runat="server">
                                            <tr>
                                                <td style="width: 10%; float: left">
                                                    <span class="labelClass">Fund # :</span></td>
                                                <td style="width: 20%; float: left">
                                                    <asp:DropDownList ID="ddlAcctNum" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;"
                                                        OnSelectedIndexChanged="ddlAcctNum_SelectedIndexChanged" AutoPostBack="True" TabIndex="8">
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtAcctNum" runat="server" Visible="false" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1"></asp:TextBox>

                                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtAcctNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                        OnClientItemSelected="OnContactSelected" CompletionInterval="100" ServiceMethod="GetFundAccountsByFilter">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 10%; float: left"><span class="labelClass">Fund Name :</span></td>
                                                <td style="width: 20%; float: left">
                                                    <asp:DropDownList ID="ddlFundName" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlFundName_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <asp:Label ID="lblFundName" class="labelClass" Text=" " runat="server" Visible="false"></asp:Label>
                                                </td>
                                                <td style="width: 10%; float: left"><span class="labelClass">Trans Type :</span></td>
                                                <td style="width: 30%; float: left">
                                                    <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" TabIndex="9">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 4px" colspan="6" />
                                            </tr>
                                            <tr>
                                                <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                                <td style="width: 20%; float: left">
                                                    <asp:TextBox ID="txtAmt" CssClass="clsTextBoxMoney" runat="server" onkeyup='toAmtFormatter(value)' TabIndex="10"></asp:TextBox></td>
                                                <td style="width: 10%; float: left">
                                                    <asp:Label ID="lblUsePermit" class="labelClass" runat="server" Visible="false" Text="Use Permit:"></asp:Label>
                                                </td>
                                                <td colspan="3" style="width: 60%; float: left">
                                                    <asp:DropDownList ID="ddlUsePermit" CssClass="clsDropDown" runat="server" Visible="false" TabIndex="10">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <asp:Button ID="btnReallocateSubmit" runat="server" Enabled="true" Text="Submit" class="btn btn-info" OnClick="btnReallocateSubmit_Click" TabIndex="11" />
                                    </div>
                                    <br />
                                </div>
                                <asp:GridView ID="gvbRelocationDetails" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True"
                                    AllowSorting="True" ShowFooter="True" OnRowCancelingEdit="gvbRelocationDetails_RowCancelingEdit"
                                    OnRowEditing="gvbRelocationDetails_RowEditing" OnRowUpdating="gvbRelocationDetails_RowUpdating" OnRowDataBound="gvbRelocationDetails_RowDataBound" OnRowDeleting="gvbRelocationDetails_RowDeleting" TabIndex="12">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                            <ItemTemplate>
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
                                                <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("Name") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlEditFundName" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtFundName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Name") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterAmount" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtTransType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lktranstype") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                Balance Amount :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" SortExpression="Amount" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAmount" runat="Server" onkeyup='toGridAmtFormatter(value)' CssClass="clsTextBoxMoney" Text='<%# Eval("Amount", "{0:0.00}") %>'></asp:TextBox>
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
                                        <asp:TemplateField Visible="false" HeaderText="Trans Id" SortExpression="transid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransId" runat="Server" Text='<%# Eval("Transid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LnkBtnEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete the detail?');"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="footerStyle" />
                                </asp:GridView>
                                <br />
                                <br />
                                <br />
                            </div>
                        </div>
                    </div>
            </div>
            </asp:Panel>
                <asp:HiddenField ID="hfGrantee" runat="server" />
            <asp:HiddenField ID="hfTransAmt" runat="server" Value="0" />
            <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
            <asp:HiddenField ID="hfTransId" runat="server" />
            <asp:HiddenField ID="hfRFromTransId" runat="server" />
            <asp:HiddenField ID="hfProjId" runat="server" />
            <asp:HiddenField ID="hfToProjId" runat="server" />
            <asp:HiddenField ID="hfReallocateGuid" runat="server" />
            <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
            <asp:HiddenField ID="hdnRelocationProjValue" OnValueChanged="hdnRelocationProjValue_ValueChanged" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            var balAmt = document.getElementById("<%=hfBalAmt.ClientID%>").value;

            if (needToConfirm && balAmt != 0)
                return "You have attempted to leave this page.  Please make sure balance amount is 0 for each transaction, otherwise the transaction can't be used for board financial transactions.  Are you sure you want to exit this page?";
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

        function OnRelocationProjectSelected(source, eventArgs) {

            var hdnCommitedProjValueID = "<%= hdnRelocationProjValue.ClientID %>";

            document.getElementById(hdnCommitedProjValueID).value = eventArgs.get_value();
            __doPostBack(hdnCommitedProjValueID, "");
            $('#totMoney').focus();
        }


        function OnFundAcctSelected(source, eventArgs) {

            var hdnfundAcct = "<%= hdnRelocationProjValue.ClientID %>";

            document.getElementById(hdnCommitedProjValueID).value = eventArgs.get_value();
            __doPostBack(hdnCommitedProjValueID, "");
            $('#totMoney').focus();
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
        toRFromAmtFormatter = value => {
            const digits = this.getDigitsFromValue(value);
            const digitsWithPadding = this.padDigits(digits);

            let result = this.addDecimalToNumber(digitsWithPadding);

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

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvReallocate.ClientID%>");
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

        toAmtFormatter = value => {
            const digits = this.getDigitsFromValue(value);
            const digitsWithPadding = this.padDigits(digits);

            let result = this.addDecimalToNumber(digitsWithPadding);

            var inputElement = document.getElementById("txtAmt");

            //inputElement.value = "$" + result;
            $('#<%= txtAmt.ClientID%>').val(formatter.format(result));
                };
    </script>
</asp:Content>
