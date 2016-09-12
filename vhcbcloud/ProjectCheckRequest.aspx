<%@ Page Title="Project Check Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectCheckRequest.aspx.cs" Inherits="vhcbcloud.ProjectCheckRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="jumbotron clearfix" id="vhcb">
                <p class="lead">Check Request</p>
                <div class="container">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rdBtnSelect" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4"
                                            RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnSelect_SelectedIndexChanged">
                                            <asp:ListItem Selected="true"> New &nbsp;</asp:ListItem>
                                            <asp:ListItem> Existing &nbsp;</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                    <%-- <td style="text-align: right">
                                <asp:LinkButton ID="lbAwardSummary" Style="float: right; margin: 0" Visible="false" runat="server" Text="Award Summary" OnClick="lbAwardSummary_Click"></asp:LinkButton>
                                <div style="clear: right;"></div>
                            </td>--%>
                                    <td style="text-align: right">
                                        <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" Style="border: none;" runat="server" Text="Project Search" Visible="true"
                                            OnClientClick="PopupProjectSearch(); return false;"></asp:ImageButton>
                                        &nbsp;<asp:ImageButton ID="imgNewAwardSummary" runat="server" ImageUrl="~/Images/$$.png" OnClientClick="PopupNewAwardSummary(); return false;" Style="border: none;" Text="Award Summary" ToolTip="Award summary" Visible="true" />
                                        <asp:ImageButton ID="imgExistingAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="false" OnClientClick="PopupExistingAwardSummary(); return false;" />
                                        &nbsp;<asp:ImageButton ID="btnProjectNotes" ImageUrl="~/Images/notes.png" ToolTip="Notes" runat="server" Text="Project Notes" Style="border: none;" />

                                        <%--<asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />--%>
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
                            <p class="lblErrMsg">
                                <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                                <asp:Label runat="server" ID="lblMessage" Font-Size="Small"></asp:Label>
                            </p>
                            <table style="width: 100%">

                                <tr>
                                    <td><span class="labelClass">Project # :</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                        </asp:DropDownList></td>
                                    <td>
                                        <span class="labelClass">Project Name :</span>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProjName" class="labelClass" Text="--" runat="server"></asp:Label>
                                    </td>
                                    <td><span class="labelClass">Date :</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlDate" CssClass="clsDropDown" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="aceTransDate" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Applicant :</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDown" runat="server" Height="21px" Width="174px">
                                        </asp:DropDownList>

                                    </td>
                                    <td>
                                        <span class="labelClass">Payee :</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPayee" CssClass="clsDropDown" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td><span class="labelClass">Program:</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Closing/Legal Review :</span></td>
                                    <td>
                                        <asp:CheckBox ID="chkLegalReview" runat="server" Text="Yes" OnCheckedChanged="chkLegalReview_CheckedChanged" AutoPostBack="True"></asp:CheckBox>

                                    </td>

                                    <td><span class="labelClass">LCB :</span></td>
                                    <td>
                                        <asp:CheckBox ID="chkLCB" runat="server" Text="Yes"></asp:CheckBox>
                                    </td>
                                    <td>
                                        <span class="labelClass">Status :</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlStatus" CssClass="clsDropDown" runat="server" Enabled="false">
                                        </asp:DropDownList>

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="labelClass" id="lblAmtEligibleForMatch" visible="false" runat="server">Amount Eligible For Match $ :</span>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEligibleAmt" CssClass="clsTextBoxBlue1" Visible="false" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass" id="lblMatchingGrant" visible="false" runat="server">Matching Grant :</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMatchingGrant" Visible="false" CssClass="clsDropDown" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>

                                <tr>


                                    <td><span class="labelClass">Disbursement $:</span></td>
                                    <td>
                                        <asp:TextBox ID="txtDisbursementAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass" style="visibility: hidden">Available Funds $:</span></td>
                                    <td colspan="5">
                                        <asp:Label ID="lblAvailFund" class="labelClass" Text="" runat="server" Visible="false"></asp:Label></td>

                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top"><span class="labelClass">Nature of Disbursements :</span></td>
                                    <td>
                                        <asp:ListBox runat="server" CssClass="clsTextBoxBlue1" SelectionMode="Multiple" ID="lbNOD" Height="80px" Width="294px"></asp:ListBox></td>
                                    <td style="vertical-align: top"><span class="labelClass">Notes :</span></td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="294px" Height="80px" />
                                    </td>

                                </tr>

                                <tr>
                                    <td colspan="6" style="height: 5px">
                                        <asp:Button ID="btnCRSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnCRSubmit_Click" />
                                        &nbsp;<asp:Button ID="btnCrUpdate" runat="server" class="btn btn-info" OnClick="btnCrUpdate_Click" Text="Update" Visible="False" />
                                        <br />
                                        <br />
                                        <asp:Panel runat="server" ID="pnlFund" >
                                            <asp:GridView ID="gvFund" runat="server" AutoGenerateColumns="False"
                                                Width="95%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                                GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvFund_RowCancelingEdit"
                                                OnRowEditing="gvFund_RowEditing" OnRowUpdating="gvFund_RowUpdating" OnPageIndexChanging="gvFund_PageIndexChanging" AllowSorting="true"
                                                OnSorting="gvFund_Sorting" OnRowDataBound="gvFund_RowDataBound" OnRowDeleting="gvFund_RowDeleting" OnSelectedIndexChanged="gvFund_SelectedIndexChanged">
                                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                                <HeaderStyle CssClass="headerStyle" />
                                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                                <RowStyle CssClass="rowStyle" />
                                                <Columns>
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />                                                            
                                                            <asp:HiddenField ID="hfIDs" runat="server" Value='<%# string.Concat(Eval("ProjectCheckReqId"), "|", Eval("transid"), "|", Eval("TransAmt"), "|", Eval("project_name"))%>' />
                                                        </ItemTemplate>

                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ProjectCheckReqId" Visible="false" SortExpression="ProjectCheckReqId">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProjectCheckReqId" runat="Server" Text='<%# Eval("ProjectCheckReqId") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Proj Name" SortExpression="project_name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("project_name") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Date" SortExpression="initdate">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("initdate", "{0:dd/MM/yyyy}") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Appl Name" SortExpression="Applicantname">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAppName" runat="Server" Text='<%# Eval("Applicantname") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Payee" SortExpression="Payee">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPayee" runat="Server" Text='<%# Eval("Payee") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Trans Amt" SortExpression="TransAmt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:CommandField ShowEditButton="True" UpdateText="" />
                                                    <asp:CommandField ShowDeleteButton="true" DeleteText="Delete" />
                                                </Columns>
                                                <FooterStyle CssClass="footerStyle" />
                                            </asp:GridView>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <br />
                                        <asp:Panel runat="server" ID="pnlPCRData" Width="100%" Height="300px" ScrollBars="Vertical" Visible="false">
                                            <asp:GridView ID="gvPCRData" runat="server" AutoGenerateColumns="False" Visible="false"
                                                Width="100%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                                GridLines="None"
                                                EnableTheming="True"
                                                AllowSorting="true"
                                                OnRowDataBound="gvPCRData_RowDataBound"
                                                OnRowEditing="gvPCRData_RowEditing"
                                                OnRowCancelingEdit="gvPCRData_RowCancelingEdit"
                                                OnSelectedIndexChanged="gvPCRData_SelectedIndexChanged">
                                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                                <HeaderStyle CssClass="headerStyle" />
                                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                                <RowStyle CssClass="rowStyle" />
                                                <Columns>
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                                            <asp:HiddenField ID="hfIDs" runat="server" Value='<%# string.Concat(Eval("ProjectCheckReqId"), "|", Eval("transid"), "|", Eval("TransAmt"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Project Check Req Id" Visible="false" SortExpression="ProjectCheckReqId">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProjectCheckReqId" runat="Server" Text='<%# Eval("ProjectCheckReqId") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Project Name" SortExpression="project_name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("project_name") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Legal Review" SortExpression="LegalReview">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLegalReview" runat="Server" Text='<%# Eval("LegalReview") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Disbursement" SortExpression="TransAmt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Payee" SortExpression="Payee">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblApplicantname" runat="Server" Text='<%# Eval("Payee") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:CommandField ShowEditButton="True" UpdateText="" />
                                                    <%-- <asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />--%>
                                                </Columns>
                                                <FooterStyle CssClass="footerStyle" />
                                            </asp:GridView>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>

                        </div>
                    </div>
                    <div class="panel panel-default" id="pnlDisbursement" runat="server">
                        <div class="panel-heading">Disbursements</div>
                        <div class="panel-body">
                            <table style="width: 100%">
                                <tr>
                                    <td><span class="labelClass">Source (Based on Commitments)</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlFundTypeCommitments" CssClass="clsDropDown" runat="server" OnSelectedIndexChanged="ddlFundTypeCommitments_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList></td>
                                    <td>
                                        <span class="labelClass">Grant/Loan/Contract :</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Amount $:</span></td>
                                    <td>
                                        <asp:TextBox ID="txtTransDetailAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <%-- <span class="labelClass">State/VHCB #s:</span>--%>
                                        <span class="labelClass">Available Funds $:</span>
                                    </td>
                                    <td>
                                        <%-- <asp:DropDownList ID="ddlStateVHCBS" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>--%>

                                        <asp:Label ID="lblCommittedAvailFunds" class="labelClass" Text="" runat="server"></asp:Label>

                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 5px">
                                        <asp:Button ID="btnPCRTransDetails" runat="server" Text="Add" Enabled="true" class="btn btn-info" OnClick="btnPCRTransDetails_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5"></td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <br />
                                        <asp:GridView ID="gvPTransDetails" runat="server" AutoGenerateColumns="False"
                                            Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false"
                                            ShowFooter="True" OnRowCancelingEdit="gvPTransDetails_RowCancelingEdit" OnRowDataBound="gvPTransDetails_RowDataBound" OnRowEditing="gvPTransDetails_RowEditing" OnRowUpdating="gvPTransDetails_RowUpdating">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <FooterStyle CssClass="footerStyleTotals" />
                                            <Columns>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                                    <ItemTemplate>
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
                                                        <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("Name") %>' />
                                                    </ItemTemplate>
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
                                                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label runat="server" ID="lblFooterBalance" Text=""></asp:Label>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="State/VHCB #s">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStateVHCBNos" runat="Server" Text='<%# Eval("StateVHCBNos") %>' />
                                                    </ItemTemplate>

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
                                            </Columns>
                                            <FooterStyle CssClass="footerStyle" />
                                        </asp:GridView>
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <%-- <div class="panel panel-default">
                <div class="panel-heading">Nature of Disbursements</div>
                <div class="panel-body">
                    <table style="width: 50%">
                        <tr>
                            <td><span class="labelClass">Nature of Disbursements :</span></td>
                            <td>
                                <asp:ListBox runat="server" SelectionMode="Multiple" ID="lbNOD1">
                                </asp:ListBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>
            </div>--%>

                    <div class="panel panel-default" runat="server" id="pnlApprovals">
                        <div class="panel-heading">Approvals</div>
                        <div class="panel-body">
                            <table style="width: 100%">
                                <tr>
                                    <td><span class="labelClass">Question :</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlPCRQuestions" CssClass="clsDropDown" runat="server" Width="250px">
                                        </asp:DropDownList></td>
                                    <td>
                                        <%-- <span class="labelClass">Approved By :</span>--%>
                                    </td>
                                    <td>
                                        <%-- <b><span class="labelClass"><%: Context.User.Identity.GetUserName()  %></span></b>--%>
                                    </td>
                                    <td>
                                        <%--<span class="labelClass">Date :</span>--%>
                                    </td>
                                    <td>
                                        <%-- <span class="labelClass"><%:DateTime.Now.ToString() %></span>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" /></td>
                                </tr>
                                <tr>
                                    <td colspan="6"></td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <br />
                                        <asp:GridView ID="gvQuestionsForApproval" runat="server" AutoGenerateColumns="False"
                                            Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false"
                                            ShowFooter="True" OnRowCancelingEdit="gvQuestionsForApproval_RowCancelingEdit"
                                            OnRowDataBound="gvQuestionsForApproval_RowDataBound"
                                            OnRowEditing="gvQuestionsForApproval_RowEditing"
                                            OnRowUpdating="gvQuestionsForApproval_RowUpdating">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <FooterStyle CssClass="footerStyleTotals" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Question" SortExpression="Description">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQuestion" runat="Server" Text='<%# Eval("Description") %>' />
                                                        <asp:HiddenField ID="hfProjectCheckReqQuestionID" runat="server" Value='<%#Eval("ProjectCheckReqQuestionID")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Approved" SortExpression="Approved">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblApproved" runat="Server" Text='<%# Eval("Approved") %>' />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="cbApproved" runat="server" Checked='<%# Eval("Approved") %>' />
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Staff Name" SortExpression="StaffID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStaffId" runat="Server" Text='<%# Eval("StaffID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Date" SortExpression="Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:M-dd-yyyy}") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:CommandField ShowEditButton="True" />
                                            </Columns>
                                            <FooterStyle CssClass="footerStyle" />
                                        </asp:GridView>
                                        <br />
                                        <asp:Button ID="btnNewPCR" runat="server" class="btn btn-info" Text="New Check Request" Visible="False" OnClick="btnNewPCR_Click" />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="hfTransId" runat="server" />
                <asp:HiddenField ID="hfTransAmt" runat="server" Value="0" />
                <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
                <asp:HiddenField ID="hfPCRId" runat="server" />
                <asp:HiddenField ID="hfProjName" runat="server" />
                <asp:HiddenField ID="hfEditPCRId" runat="server" />
                <asp:HiddenField ID="hfProjId" runat="server" />
                <asp:HiddenField ID="hfAvFunds" runat="server" />
                <%--<asp:HiddenField ID="hfPCRIDTransID" runat="server" />--%>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvPCRData.ClientID%>");
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
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvFund.ClientID%>");
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

        function PopupProjectSearch() {
            window.open('./projectsearch.aspx')
        };

        function PopupExistingAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };


    </script>
</asp:Content>
