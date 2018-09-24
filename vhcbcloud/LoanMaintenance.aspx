<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="LoanMaintenance.aspx.cs" Inherits="vhcbcloud.LoanMaintenance"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Loan Maintenance </p>
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs">
                    </ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td></td>
                            <td style="text-align: right;">
                                <%--<asp:ImageButton ID="btnProjectNotes1" Visible="false" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;--%>
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div id="dvProject" runat="server">
                    <table>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 60px"><span class="labelClass">Project #</span></td>
                            <td style="width: 150px">
                                <asp:TextBox ID="txtProjectNumDDL" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"
                                    ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProjectNumDDL" MinimumPrefixLength="1"
                                    EnableCaching="true" CompletionSetCount="1"
                                    CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                            <td style="width: 80px"><span class="labelClass" runat="server" id="lblProjName" visible="false">Project Name:</span></td>
                            <td style="width: 270px">
                                <span class="labelClass" id="txtProjName" runat="server" visible="false"></span>
                            </td>
                            <td style="width: 1px"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvNewProjectInfo" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Loan Master</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddLoanMaster" runat="server" Text="Add New Loan Master" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectInfoForm">
                            <asp:Panel runat="server" ID="pnlProjectInfo">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Loan Id</span></td>
                                        <td style="width: 250px">
                                            <span class="labelClass" runat="server" id="spnLoanId"></span></td>
                                        <td style="width: 142px">
                                            <span class="labelClass">Applicant</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlPrimaryApplicant" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="txtPrimaryApplicant" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"
                                                ClientIDMode="Static" Visible="true"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtPrimaryApplicant" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetPrimaryApplicant" OnClientPopulated="onListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>--%>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Note Amount $</span></td>
                                        <td>
                                            <asp:TextBox ID="txtNoteAmount" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Owner of Note</span>&nbsp;</td>
                                        <td style="width: 250px">
                                             <asp:DropDownList ID="ddlNoteOwner" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 142px">
                                            <span class="labelClass">Tax Credit Partnership</span></td>
                                        <td style="width: 270px">
                                             <asp:DropDownList ID="ddltaxCreditPartner" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbLoanMasterActive" runat="server" Checked="true" CssClass="ChkBox" Enabled="false" Text="Yes" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px">&nbsp;</td>
                                        <td style="width: 250px">
                                            &nbsp;</td>
                                        <td style="width: 142px">
                                            <span class="labelClass"></span>
                                        </td>
                                        <td style="width: 270px"></td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Button ID="btnLoanMaster" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnLoanMaster_Click" /></td>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvLoanMasterGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvLoanMaster" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvLoanMaster_RowEditing" OnRowCancelingEdit="gvLoanMaster_RowCancelingEdit"
                                    OnRowDataBound="gvLoanMaster_RowDataBound"
                                    OnSelectedIndexChanged="gvLoanMaster_SelectedIndexChanged">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectLoan" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectLoan_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenLoanID" runat="server" Value='<%#Eval("LoanID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Loan ID" Visible="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanID" runat="Server" Text='<%# Eval("LoanID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Note Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoteAmt" runat="Server" Text='<%# Eval("NoteAmt", "{0:c2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Note Owner">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoteOwner" runat="Server" Text='<%# Eval("NoteOwner") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax Credit Partnership">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTaxCreditPartner" runat="Server" Text='<%# Eval("TaxCreditPartner") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                 <div class="panel-width" runat="server" id="dvNewFundInfo" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Fund Details</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddNewFundDetails" runat="server" Text="Add New Fund Details" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvFundDetailsForm">
                            <asp:Panel runat="server" ID="Panel7">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 120px"><span class="labelClass">Fund</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlFund" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 134px"><span class="labelClass">Amount</span></td>
                                        <td style="width: 336px">
                                            <asp:TextBox ID="txtFundAmount" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                        </td>
                                        <td style="width: 354px"></td>
                                        <td><asp:Button ID="btnAddFund" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddFund_Click" /></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <!-- Grid Here -->
                        <div class="panel-body" id="dvFundDetailsGrid" runat="server">
                            <div id="dvFundAmountWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblFundAmountWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="130px" ScrollBars="Vertical">
                                <asp:GridView ID="gvFundDetails" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="True"
                                    OnRowCancelingEdit="gvFundDetails_RowCancelingEdit"
                                    OnRowEditing="gvFundDetails_RowEditing" 
                                    OnRowUpdating="gvFundDetails_RowUpdating"
                                    OnRowDataBound="gvFundDetails_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LoanFundID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanFundID" runat="Server" Text='<%# Eval("LoanFundID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFund" runat="Server" Text='<%# Eval("Fund") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlFundEdit" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtFundID" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("FundID") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundAmount1" runat="Server" Text='<%# Eval("Amount", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtFundAmount1" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalAmount" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActiveFund" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEditFund" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewLoanDetailInfo" visible="false">
                    <div class="panel panel-default">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Loan Details</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddNewLoanDetails" runat="server" Text="Add New Loan Details" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvLoanDetailsForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Legal Docs</span></td>
                                        <td style="width: 242px">
                                            <asp:DropDownList ID="ddlLegalDocs" runat="server" CssClass="clsDropDown">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 163px">
                                            <span class="labelClass">Loan Category</span>
                                        </td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlLoanCat" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 183px"><span class="labelClass">Original Date of Note</span></td>
                                        <td>
                                            <asp:TextBox ID="txtOriginalDateOfNote" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtProjectNotesDate" TargetControlID="txtOriginalDateOfNote">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Final Maturity Date of Note</span></td>
                                        <td style="width: 242px">
                                            <asp:TextBox ID="txtMaturityDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtMaturityDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 163px">
                                            <span class="labelClass">Note Amt</span></td>
                                        <td style="width: 215px">
                                            <span class="labelClass" runat="server" id="spnNoteAmt"></span></td>
                                        <td style="width: 183px"><span class="labelClass">Interest Rate %</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtIntrestRate" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Compounded</span></td>
                                        <td style="width: 242px">
                                            <asp:DropDownList ID="ddlCompounded" runat="server" CssClass="clsDropDown">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 163px">
                                            <span class="labelClass">Payment Frequency</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlPaymentFreq" runat="server" CssClass="clsDropDown">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 183px"><span class="labelClass">Payment Type</span>&nbsp;</td>
                                        <td>
                                            <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="clsDropDown">
                                            </asp:DropDownList>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Watch Date</span></td>
                                        <td style="width: 242px">
                                            
                                            <asp:TextBox ID="txtWatchDate" runat="server" CssClass="clsTextBoxBlue1"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtWatchDate">
                                            </ajaxToolkit:CalendarExtender>
                                            
                                        </td>
                                        <td style="width: 163px"><span class="labelClass">File Hold LinK</span></td>
                                        <td style="width: 215px">
                                             <asp:TextBox ID="txtFileURL" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 183px"><span class="labelClass">Effective Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtEffectiveDate" runat="server" CssClass="clsTextBoxBlue1"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="CalendarExtender19" runat="server" TargetControlID="txtEffectiveDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td style="width: 180px"><span class="labelClass">Active</span></td>
                                        <td style="width: 242px">
                                            <asp:CheckBox ID="cbLoanDetailActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <div id="Div1" runat="server" visible="true">
                                    <table>
                                        <tr>
                                            <td style="height: 1px">&nbsp;&nbsp;</td>
                                            <td style="height: 1px">
                                                <asp:Button ID="btnAddLoanDetails" runat="server" Text="Add" class="btn btn-info"
                                                    OnClick="btnAddLoanDetails_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 1px" colspan="2"></td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvProjectLoanDetailsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProjectLoanDetails" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowCancelingEdit="gvProjectLoanDetails_RowCancelingEdit" OnRowDataBound="gvProjectLoanDetails_RowDataBound"
                                    OnRowEditing="gvProjectLoanDetails_RowEditing">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LoanDetailID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanDetailID" runat="Server" Text='<%# Eval("LoanDetailID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="LegalDoc">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLegalDoc" runat="Server" Text='<%# Eval("LegalDoc") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="NoteDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoteDate" runat="Server" Text='<%# Eval("NoteDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Note Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNoteAmt" runat="Server" Text='<%# Eval("NoteAmt", "{0:c2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Loan Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanCategory" runat="Server" Text='<%# Eval("LoanCategory") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MaturityDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMaturityDate" runat="Server" Text='<%# Eval("MaturityDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Intrest Rate %">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIntRate" runat="Server" Text='<%# Eval("IntRate", "{0:0.00}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="File Hold Link">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URL") %></a>
                                                <%--<asp:Label ID="lblFHL" runat="Server" Text='<%# Eval("URL") %>' />--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActiveLD" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewEvent" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Events, etc.</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddEvent" runat="server" Text="Add New Loan Event" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvEventForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 100px"><span class="labelClass">Description</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtEventDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server" Style="margin-left: 0px"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 100px">
                                            <asp:Button ID="AddEvent" runat="server" Text="Add" class="btn btn-info" OnClick="AddEvent_Click" />
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvLoanEventsGrid" runat="server">
                            <asp:Panel runat="server" ID="pnlGrid" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvLoanEvents" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvLoanEvents_RowCancelingEdit"
                                    OnRowEditing="gvLoanEvents_RowEditing" OnRowUpdating="gvLoanEvents_RowUpdating"
                                    OnRowDataBound="gvLoanEvents_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LoanEventID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanEventID" runat="Server" Text='<%# Eval("LoanEventID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDescription" runat="Server" CssClass="clsApplicantBlue" Text='<%# Eval("Description") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActiveEvent" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEditEvent" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvTransaction" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Transactions</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddTransaction" runat="server" Text="Add New Loan Transaction" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvTransactiontForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 120px"><span class="labelClass">Trans Type</span></td>
                                        <td style="width: 215px" colspan="4">
                                            <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 234px"></td>
                                        <td style="width: 336px"></td>
                                        <td style="width: 354px"></td>
                                        <td></td>
                                    </tr>
                                </table>

                                <div id="dvAdgustment" runat="server" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="ad_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender4" TargetControlID="ad_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Interest Rate %</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="ad_txtTransIntrestRate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Compounding</span></td>
                                            <td>
                                                <asp:DropDownList ID="ad_ddlTransCompounding" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Payment Frequency</span></td>
                                            <td style="width: 215px">
                                                <asp:DropDownList ID="ad_ddlTransPaymentFreq" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Payment Type</span></td>
                                            <td style="width: 336px">
                                                <asp:DropDownList ID="ad_ddlTransPaymentType" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass" runat="server" id="span5">Maturity Date</span></td>
                                            <td>
                                                <asp:TextBox ID="ad_txtTransMaturityDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender8" TargetControlID="ad_txtTransMaturityDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Start Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="ad_txtTransStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender9" TargetControlID="ad_txtTransStartDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Amount</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="ad_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Stop Date</span></td>
                                            <td>
                                                <asp:TextBox ID="ad_txtTransStopDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender10" TargetControlID="ad_txtTransStopDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Principle</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="ad_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Interest</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="ad_txtTransIntrest" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Description</span></td>
                                            <td>
                                                <asp:TextBox ID="ad_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Project Transferred To</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="ad_txtTransProjTransfered" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Project Converted From</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="ad_txtTransProjConverted" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Active</span></td>
                                            <td>
                                                <asp:CheckBox ID="ad_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvCaptalizing" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 140px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cap_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender15" TargetControlID="cap_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 234px"><span class="labelClass" runat="server" id="span7">Payment Type</span></td>
                                            <td style="width: 336px">
                                                <asp:DropDownList ID="cap_ddlTransPaymentType" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 89px"><span class="labelClass" runat="server" id="span8">Amount</span></td>
                                            <td>
                                                <asp:TextBox ID="cap_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 140px"><span class="labelClass">Principle</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cap_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>
                                            <td style="width: 234px"><span class="labelClass" runat="server" id="span9">Description</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="cap_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 89px"><span class="labelClass" runat="server" id="span10">Active</span></td>
                                            <td>
                                                <asp:CheckBox ID="cap_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvCR" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 140px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cr_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender7" TargetControlID="cr_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 234px"><span class="labelClass" runat="server" id="span1">Amount</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="cr_txtTransAmount" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass" runat="server" id="span2">Principle</span></td>
                                            <td>
                                                <asp:TextBox ID="cr_txtTransPrinciple" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 140px"><span class="labelClass" id="span25" runat="server">Interest</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cr_txtTransIntrest" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                            </td>
                                            <td style="width: 234px"><span id="span26" runat="server" class="labelClass">Description</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="cr_txtTransDescription" runat="server" CssClass="clsTextBoxBlueSm" Width="200px"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Effective Date</span></td>
                                            <td>
                                                <asp:TextBox ID="cr_txtEffectiveDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender18" TargetControlID="cr_txtEffectiveDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 140px">
                                                <span class="labelClass">Active</span></td>
                                            <td colspan="4">
                                                <asp:CheckBox ID="cr_cbLoanTransActive" runat="server" Checked="true" CssClass="ChkBox" Enabled="false" Text="Yes" />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvConversion" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 196px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cv_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender3" TargetControlID="cv_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 234px"><span class="labelClass">Interest Rate %</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="cv_txtTransIntrestRate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Compounding</span></td>
                                            <td>
                                                <asp:DropDownList ID="cv_ddlTransCompounding" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 196px"><span class="labelClass">Payment Frequency</span></td>
                                            <td style="width: 215px">
                                                <asp:DropDownList ID="cv_ddlTransPaymentFreq" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 234px"><span class="labelClass">Payment Type</span></td>
                                            <td style="width: 336px">
                                                <asp:DropDownList ID="cv_ddlTransPaymentType" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass" runat="server" id="spanPaymentType">Start Date</span></td>
                                            <td>
                                                <asp:TextBox ID="cv_txtTransStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender5" TargetControlID="cv_txtTransStartDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 196px"><span class="labelClass">Amount</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cv_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 234px"><span class="labelClass">Stop Date</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="cv_txtTransStopDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender6" TargetControlID="cv_txtTransStopDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Principle</span></td>
                                            <td>
                                                <asp:TextBox ID="cv_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 196px"><span class="labelClass">Interest</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="cv_txtTransIntrest" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 234px"><span class="labelClass">Description</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="cv_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Project Converted From</span></td>
                                            <td>
                                                <asp:TextBox ID="cv_txtTransProjConverted" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 196px"><span class="labelClass">Interest</span></td>
                                            <td style="width: 215px" colspan="4">
                                                <asp:CheckBox ID="cv_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                            </td>
                                        </tr>


                                    </table>
                                </div>

                                <div runat="server" id="dvDisbursement" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 105px"><span class="labelClass">Amount</span></td>
                                            <td style="width: 127px">
                                                <asp:TextBox ID="dis_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 70px"><span class="labelClass" runat="server" id="span6">Principle</span></td>
                                            <td style="width: 123px" class="modal-sm">
                                                <asp:TextBox ID="dis_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 73px"><span class="labelClass" runat="server" id="span11">Description</span></td>
                                            <td>
                                                <asp:TextBox ID="dis_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 105px"><span class="labelClass">Active</span></td>
                                            <td style="width: 127px">
                                                <asp:CheckBox ID="dis_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                            </td>
                                            <td style="width: 70px"><span class="labelClass" runat="server" id="span12"></span></td>
                                            <td style="width: 123px" class="modal-sm"></td>
                                            <td style="width: 73px"><span class="labelClass" runat="server" id="span13"></span></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvForgiveness" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 109px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="fg_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender11" TargetControlID="fg_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 81px"><span class="labelClass" runat="server" id="span14">Amount</span></td>
                                            <td style="width: 154px">
                                                <asp:TextBox ID="fg_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 64px"><span class="labelClass" runat="server" id="span15">Principle</span></td>
                                            <td>
                                                <asp:TextBox ID="fg_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 109px"><span class="labelClass">Description</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="fg_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 81px"><span class="labelClass" runat="server" id="span16">Active</span></td>
                                            <td style="width: 154px">
                                                <asp:CheckBox ID="fg_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                            </td>
                                            <td style="width: 64px"><span class="labelClass" runat="server" id="span17"></span></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvTransfer" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 114px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="tr_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender12" TargetControlID="tr_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 146px"><span class="labelClass" runat="server" id="span18">Amount</span></td>
                                            <td style="width: 171px">
                                                <asp:TextBox ID="tr_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 141px"><span class="labelClass" runat="server" id="span19">Principle</span></td>
                                            <td>
                                                <asp:TextBox ID="tr_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 114px"><span class="labelClass">Description</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="tr_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 146px"><span class="labelClass" runat="server" id="span20">Project Converted To</span></td>
                                            <td style="width: 171px">
                                                <asp:TextBox ID="tr_txtTransProjTransfered" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 141px"><span class="labelClass" runat="server" id="span21">Project Converted From</span></td>
                                            <td>
                                                <asp:TextBox ID="tr_txtTransProjConverted" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 114px"><span class="labelClass">Active</span></td>
                                            <td style="width: 215px">
                                                <asp:CheckBox ID="tr_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                            </td>
                                            <td style="width: 146px"><span class="labelClass" runat="server" id="span22"></span></td>
                                            <td style="width: 171px"></td>
                                            <td style="width: 141px"><span class="labelClass" runat="server" id="span23"></span></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvNoteModification" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Transaction Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="nm_txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender13" TargetControlID="nm_txtTransDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Interest Rate %</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="nm_txtTransIntrestRate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Compounding</span></td>
                                            <td>
                                                <asp:DropDownList ID="nm_ddlTransCompounding" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Payment Frequency</span></td>
                                            <td style="width: 215px">
                                                <asp:DropDownList ID="nm_ddlTransPaymentFreq" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Payment Type</span></td>
                                            <td style="width: 336px">
                                                <asp:DropDownList ID="nm_ddlTransPaymentType" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass" runat="server" id="span24">Maturity Date</span></td>
                                            <td>
                                                <asp:TextBox ID="nm_txtTransMaturityDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender14" TargetControlID="nm_txtTransMaturityDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Start Date</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="nm_txtTransStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender16" TargetControlID="nm_txtTransStartDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Amount</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="nm_txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Stop Date</span></td>
                                            <td>
                                                <asp:TextBox ID="nm_txtTransStopDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender17" TargetControlID="nm_txtTransStopDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Principle</span></td>
                                            <td style="width: 215px">
                                                <asp:TextBox ID="nm_txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 344px"><span class="labelClass">Interest</span></td>
                                            <td style="width: 336px">
                                                <asp:TextBox ID="nm_txtTransIntrest" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 354px"><span class="labelClass">Description</span></td>
                                            <td>
                                                <asp:TextBox ID="nm_txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 268px"><span class="labelClass">Active</span></td>
                                            <td style="width: 215px">
                                                <asp:CheckBox ID="nm_cbLoanTransActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                            </td>
                                            <td style="width: 344px"><span class="labelClass"></span></td>
                                            <td style="width: 336px"></td>
                                            <td style="width: 354px"><span class="labelClass"></span></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAddTransaction" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddTransaction_Click" Visible="false" /></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <!-- Grid Here -->
                        <div class="panel-body" id="dvLoanTransGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel6" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvLoanTrans" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowCancelingEdit="gvLoanTrans_RowCancelingEdit"
                                    OnRowDataBound="gvLoanTrans_RowDataBound"
                                    OnRowEditing="gvLoanTrans_RowEditing">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LoanTransID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanTransID" runat="Server" Text='<%# Eval("LoanTransID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="TransTypeDesc">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransTypeDesc" runat="Server" Text='<%# Eval("TransTypeDesc") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("TransDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("Amount", "{0:c2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Principal">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrincipal" runat="Server" Text='<%# Eval("Principal", "{0:c2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Interest">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInterest" runat="Server" Text='<%# Eval("Interest", "{0:c2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActiveLD" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNotes" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Notes</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddNotes" runat="server" Text="Add New Loan Notes" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvNotesForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <%--<tr>
                                            <td style="width: 5px"><span class="labelClass">Fund</span></td>
                                            <td style="width: 215px">
                                                <asp:DropDownList ID="ddlNotesFund" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>--%>
                                    <tr>
                                        <td style="width: 5px"><span class="labelClass">Notes</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="480px" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5px"><span class="labelClass">FileHold Link</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtFHL" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5px"><span class="labelClass">Active</span></td>
                                        <td style="width: 215px">
                                            <asp:CheckBox ID="cbLoanNoteActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                            &nbsp;&nbsp;<asp:Button ID="btnAddNotes" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddNotes_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvProjectLoanNotesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProjectLoanNotes" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowCancelingEdit="gvProjectLoanNotes_RowCancelingEdit"
                                    OnRowDataBound="gvProjectLoanNotes_RowDataBound"
                                    OnRowEditing="gvProjectLoanNotes_RowEditing">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LoanNoteID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanNoteID" runat="Server" Text='<%# Eval("LoanNoteID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="LoanNote">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanNote" runat="Server" Text='<%# Eval("LoanNote") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="FHLink">
                                             <ItemTemplate>
                                                <a href='<%# Eval("FHLink") %>' runat="server" id="hlurl" target="_blank"><%# Eval("FHLink") %></a>
                                                <%--<asp:Label ID="lblFHL" runat="Server" Text='<%# Eval("URL") %>' />--%>
                                            </ItemTemplate>

                                           <%-- <ItemTemplate>
                                                <asp:Label ID="lblFHLink" runat="Server" Text='<%# Eval("FHLink") %>' />
                                            </ItemTemplate>--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActiveNote" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
            <asp:HiddenField ID="hfProjectId" runat="server" />
            <asp:HiddenField ID="hfLoanId" runat="server" />
            <asp:HiddenField ID="hfLoanDetailID" runat="server" />
            <asp:HiddenField ID="hfLoanNoteID" runat="server" />
            <asp:HiddenField ID="hfLoanTransID" runat="server" />
            <asp:HiddenField ID="hfSelectedNoteAmt" runat="server" />
            <asp:HiddenField ID="hfFundAmountWarning" runat="server" />
        </div>
    </div>
    <script language="javascript">
        $(document).ready(function () {
            toCurrencyControl($('#<%= txtNoteAmount.ClientID%>').val(), $('#<%= txtNoteAmount.ClientID%>'));
            
            $('#<%= ad_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= ad_txtTransAmount.ClientID%>').val(), $('#<%= ad_txtTransAmount.ClientID%>'));
            });
            $('#<%= ad_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= ad_txtTransPrinciple.ClientID%>').val(), $('#<%= ad_txtTransPrinciple.ClientID%>'));
            });
            $('#<%= ad_txtTransIntrest.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= ad_txtTransIntrest.ClientID%>').val(), $('#<%= ad_txtTransIntrest.ClientID%>'));
            });
            
            $('#<%= cap_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cap_txtTransAmount.ClientID%>').val(), $('#<%= cap_txtTransAmount.ClientID%>'));
            });
            $('#<%= cap_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cap_txtTransPrinciple.ClientID%>').val(), $('#<%= cap_txtTransPrinciple.ClientID%>'));
            });
            
            $('#<%= cr_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cr_txtTransAmount.ClientID%>').val(), $('#<%= cr_txtTransAmount.ClientID%>'));
            });
            $('#<%= cr_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cr_txtTransPrinciple.ClientID%>').val(), $('#<%= cr_txtTransPrinciple.ClientID%>'));
            });
            $('#<%= cr_txtTransIntrest.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cr_txtTransIntrest.ClientID%>').val(), $('#<%= cr_txtTransIntrest.ClientID%>'));
            });
            $('#<%= cv_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cv_txtTransAmount.ClientID%>').val(), $('#<%= cv_txtTransAmount.ClientID%>'));
            });
            $('#<%= cv_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cv_txtTransPrinciple.ClientID%>').val(), $('#<%= cv_txtTransPrinciple.ClientID%>'));
            });
            $('#<%= cv_txtTransIntrest.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= cv_txtTransIntrest.ClientID%>').val(), $('#<%= cv_txtTransIntrest.ClientID%>'));
            });

            $('#<%= dis_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= dis_txtTransAmount.ClientID%>').val(), $('#<%= dis_txtTransAmount.ClientID%>'));
            });
            $('#<%= dis_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= dis_txtTransPrinciple.ClientID%>').val(), $('#<%= dis_txtTransPrinciple.ClientID%>'));
            });

            $('#<%= fg_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= fg_txtTransAmount.ClientID%>').val(), $('#<%= fg_txtTransAmount.ClientID%>'));
            });
            $('#<%= fg_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= fg_txtTransPrinciple.ClientID%>').val(), $('#<%= fg_txtTransPrinciple.ClientID%>'));
            });

            $('#<%= tr_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= tr_txtTransAmount.ClientID%>').val(), $('#<%= tr_txtTransAmount.ClientID%>'));
            });
            $('#<%= tr_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= tr_txtTransPrinciple.ClientID%>').val(), $('#<%= tr_txtTransPrinciple.ClientID%>'));
            });
            $('#<%= nm_txtTransAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= nm_txtTransAmount.ClientID%>').val(), $('#<%= nm_txtTransAmount.ClientID%>'));
            });
            $('#<%= nm_txtTransPrinciple.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= nm_txtTransPrinciple.ClientID%>').val(), $('#<%= nm_txtTransPrinciple.ClientID%>'));
            });
            $('#<%= nm_txtTransIntrest.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= nm_txtTransIntrest.ClientID%>').val(), $('#<%= nm_txtTransIntrest.ClientID%>'));
            });
            $('#<%= txtNoteAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtNoteAmount.ClientID%>').val(), $('#<%= txtNoteAmount.ClientID%>'));
            });

            $('#<%= txtFundAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtFundAmount.ClientID%>').val(), $('#<%= txtFundAmount.ClientID%>'));
             });

            $('#<%= dvProjectInfoForm.ClientID%>').toggle($('#<%= cbAddLoanMaster.ClientID%>').is(':checked'));

            $('#<%= cbAddLoanMaster.ClientID%>').click(function () {
                $('#<%= dvProjectInfoForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvFundDetailsForm.ClientID%>').toggle($('#<%= cbAddNewFundDetails.ClientID%>').is(':checked'));

            $('#<%= cbAddNewFundDetails.ClientID%>').click(function () {
                $('#<%= dvFundDetailsForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvLoanDetailsForm.ClientID%>').toggle($('#<%= cbAddNewLoanDetails.ClientID%>').is(':checked'));

            $('#<%= cbAddNewLoanDetails.ClientID%>').click(function () {
                $('#<%= dvLoanDetailsForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvEventForm.ClientID%>').toggle($('#<%= cbAddEvent.ClientID%>').is(':checked'));

            $('#<%= cbAddEvent.ClientID%>').click(function () {
                $('#<%= dvEventForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvTransactiontForm.ClientID%>').toggle($('#<%= cbAddTransaction.ClientID%>').is(':checked'));

            $('#<%= cbAddTransaction.ClientID%>').click(function () {
                $('#<%= dvTransactiontForm.ClientID%>').toggle(this.checked);
            }).change();


            $('#<%= dvNotesForm.ClientID%>').toggle($('#<%= cbAddNotes.ClientID%>').is(':checked'));

            $('#<%= cbAddNotes.ClientID%>').click(function () {
                $('#<%= dvNotesForm.ClientID%>').toggle(this.checked);
            }).change();

            toCurrencyControl($('#<%= ad_txtTransAmount.ClientID%>').val(), $('#<%= ad_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= ad_txtTransPrinciple.ClientID%>').val(), $('#<%= ad_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= ad_txtTransIntrest.ClientID%>').val(), $('#<%= ad_txtTransIntrest.ClientID%>'));
            toCurrencyControl($('#<%= cap_txtTransAmount.ClientID%>').val(), $('#<%= cap_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= cap_txtTransPrinciple.ClientID%>').val(), $('#<%= cap_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= cr_txtTransAmount.ClientID%>').val(), $('#<%= cr_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= cr_txtTransPrinciple.ClientID%>').val(), $('#<%= cr_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= cr_txtTransIntrest.ClientID%>').val(), $('#<%= cr_txtTransIntrest.ClientID%>'));
            
            toCurrencyControl($('#<%= cv_txtTransAmount.ClientID%>').val(), $('#<%= cv_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= cv_txtTransPrinciple.ClientID%>').val(), $('#<%= cv_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= cv_txtTransIntrest.ClientID%>').val(), $('#<%= cv_txtTransIntrest.ClientID%>'));
            toCurrencyControl($('#<%= dis_txtTransAmount.ClientID%>').val(), $('#<%= dis_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= dis_txtTransPrinciple.ClientID%>').val(), $('#<%= dis_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= fg_txtTransAmount.ClientID%>').val(), $('#<%= fg_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= fg_txtTransPrinciple.ClientID%>').val(), $('#<%= fg_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= tr_txtTransAmount.ClientID%>').val(), $('#<%= tr_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= tr_txtTransPrinciple.ClientID%>').val(), $('#<%= tr_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= nm_txtTransAmount.ClientID%>').val(), $('#<%= nm_txtTransAmount.ClientID%>'));
            toCurrencyControl($('#<%= nm_txtTransPrinciple.ClientID%>').val(), $('#<%= nm_txtTransPrinciple.ClientID%>'));
            toCurrencyControl($('#<%= nm_txtTransIntrest.ClientID%>').val(), $('#<%= nm_txtTransIntrest.ClientID%>'));
            
            toCurrencyControl($('#<%= txtFundAmount.ClientID%>').val(), $('#<%= txtFundAmount.ClientID%>'));
        });

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvLoanMaster.ClientID%>");
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

       <%-- function onListPopulated() {
            var completionList = $find('<%=AutoCompleteExtender2.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }--%>
    </script>
</asp:Content>
