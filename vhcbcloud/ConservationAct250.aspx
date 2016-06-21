<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConservationAct250.aspx.cs"
    MaintainScrollPositionOnPostback="true" Inherits="vhcbcloud.ConservationAct250" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Conservation - Act250</p>
        <div class="container">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: left"></td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" ToolTip="Award Summary" Text="Award Summary" Style="width: 25px; height: 25px; border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="width: 25px; height: 25px; border: none; vertical-align: middle;" />
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>

                <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes" CancelControlID="btnClose"
                    BackgroundCssClass="MEBackground">
                </ajaxToolkit:ModalPopupExtender>

                <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                    <iframe style="width: 750px; height: 600px;" id="ifProjectNotes" src="../ProjectNotes.aspx" runat="server"></iframe>
                    <br />
                    <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
                </asp:Panel>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvNewAct250Info">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Act250 Info</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAct250Info" runat="server" Text="Add New Act 250 Info" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAct250InfoForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 117px"><span class="labelClass">Land Use Permit</span></td>
                                        <td style="width: 194px">
                                            <asp:TextBox ID="txtLandUsePermit" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 149px">
                                            <span class="labelClass">Town of Development</span>
                                        </td>
                                        <td style="width: 176px">
                                            <asp:DropDownList ID="ddlTown" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 134px"><span class="labelClass">Type</span></td>
                                        <td class="modal-sm" style="width: 115px">
                                            <asp:DropDownList ID="ddlFarmType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 163px"><span class="labelClass">Developer</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlDeveloper" CssClass="clsDropDown" runat="server" Style="margin-left: 0"></asp:DropDownList>
                                        </td>
                                        <td style="width: 117px"><span class="labelClass">Development Name</span></td>
                                        <td style="width: 194px">
                                            <asp:TextBox ID="txtDevname" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 149px">
                                            <span class="labelClass">District #</span>
                                        </td>
                                        <td style="width: 176px">
                                            <asp:TextBox ID="txtDistrictNo" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 134px"><span class="labelClass">Prime soils acres lost</span></td>
                                        <td class="modal-sm" style="width: 115px">
                                            <asp:TextBox ID="txtPrimeSoilsAcresLost" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 163px"><span class="labelClass">State soils acres lost</span></td>
                                        <td>
                                            <asp:TextBox ID="txtStateSoilsAcresLost" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 117px"><span class="labelClass">Total acres lost</span></td>
                                        <td style="width: 194px">
                                            <asp:TextBox ID="txtTotAcresLost" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 149px">
                                            <span class="labelClass">Acres Developed</span>
                                        </td>
                                        <td style="width: 176px">
                                            <asp:TextBox ID="txtAcresDeveloped" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 134px"><span class="labelClass">Anticipated Funds</span></td>
                                        <td class="modal-sm" style="width: 115px">
                                            <asp:TextBox ID="txtAnticipatedFunds" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 163px"><span class="labelClass">Mitigation Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMitigationDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtMitigationDate" TargetControlID="txtMitigationDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 149px">
                                            <span class="labelClass">Active:</span>
                                        </td>
                                        <td style="width: 176px">
                                            <asp:CheckBox ID="chkAct250Active" Enabled="false" runat="server" Checked="true" />
                                        </td>
                                        <td style="width: 134px"></td>
                                        <td class="modal-sm" style="width: 115px"></td>
                                        <td style="width: 163px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 117px">
                                            <asp:Button ID="btnAddAct250Info" runat="server" Text="Submit" class="btn btn-info"
                                                OnClick="btnAddAct250Info_Click" />
                                        </td>
                                        <td style="width: 194px"></td>
                                        <td style="width: 149px"></td>
                                        <td style="width: 176px"></td>
                                        <td style="width: 134px"></td>
                                        <td class="modal-sm" style="width: 115px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAct250InfoGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="170px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAct250Info" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvAct250Info_RowEditing" OnRowCancelingEdit="gvAct250Info_RowCancelingEdit"
                                    OnRowDataBound="gvAct250Info_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Act250FarmID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAct250FarmID" runat="Server" Text='<%# Eval("Act250FarmID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectAct250Info" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectAct250Info_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenAct250FarmID" runat="server" Value='<%#Eval("Act250FarmID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Land Use Permit">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUsePermit" runat="Server" Text='<%# Eval("UsePermit") %>' />
                                                <asp:HiddenField ID="HiddenUsePermit" runat="server" Value='<%#Eval("UsePermit")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Developer">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDeveloper" runat="Server" Text='<%# Eval("DeveloperName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total acres lost">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotalAcresLost" runat="Server" Text='<%# Eval("TotalAcreslost") %>' />
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

                <div class="panel-width" runat="server" id="dvNewDeveloperPayments" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Developer Payments</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddDeveloperPayment" runat="server" Text="Add New Developer Payment" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvDeveloperPaymentsForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 70px"><span class="labelClass">Amount $</span></td>
                                        <td style="width: 100px">
                                            <asp:TextBox ID="txtDevPaymentAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Date Received</span>
                                        </td>
                                        <td style="width: 100px">
                                            <asp:TextBox ID="txtDevPaymentReceived" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDevPaymentReceived" TargetControlID="txtDevPaymentReceived">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 50px"><span class="labelClass">Active</span></td>
                                        <td class="modal-sm" style="width: 70px">
                                            <asp:CheckBox ID="chkUnitActive" runat="server" Enabled="false" Checked="true" />
                                        </td>
                                        <td style="width: 10px">
                                            <asp:Button ID="btnAddDevPayments" runat="server" Text="Submit" class="btn btn-info"
                                                OnClick="btnAddDevPayments_Click" />
                                        </td>
                                        <td style="width: 400px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvDeveloperPaymentsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="170px" ScrollBars="Vertical">
                                <asp:GridView ID="gvDeveloperPayments" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="True"
                                    OnRowEditing="gvDeveloperPayments_RowEditing" OnRowCancelingEdit="gvDeveloperPayments_RowCancelingEdit"
                                    OnRowDataBound="gvDeveloperPayments_RowDataBound" OnRowUpdating="gvDeveloperPayments_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Act250PayID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAct250PayID" runat="Server" Text='<%# Eval("Act250PayID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="DateRec">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDateRec" runat="Server" Text='<%# Eval("DateRec", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDevPayReceived" CssClass="clsTextBoxBlueSm" runat="server"
                                                    Text='<%# Eval("DateRec", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDevPayReceived" TargetControlID="txtDevPayReceived">
                                                </ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="AmtRec" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmtRec" runat="Server" Text='<%# Eval("AmtRec", "{0:C2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtpaymentAmount" CssClass="clsTextBoxBlueSm" runat="server"
                                                    Text='<%# Eval("AmtRec", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalAmtRec" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="60px" />
                                            <FooterStyle Width="60px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                            <FooterStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewlandUsePermitFinancials" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="height: 25px">
                                        <h3 class="panel-title"><span id="headingForLandUsePermitFinancials" runat="server"></span></h3>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" id="dvLandUsePermitFinancialsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="170px" ScrollBars="Vertical">
                                <asp:GridView ID="gvLandUsePermitFinancials" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="True">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Running Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalAmount" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="60px" />
                                            <FooterStyle Width="60px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                            <FooterStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblType" runat="Server" Text='<%# Eval("Type") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Balance Amount :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="Server" Text='<%# Eval("Status") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterBalanceAmount" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewVHCBProjects" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Potential VHCB Projects</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddVHCBProjects" runat="server" Text="Add New VHCB Projects" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvVHCBProjectsForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 70px"><span class="labelClass">Project #</span></td>
                                        <td style="width: 83px">
                                            <asp:DropDownList ID="ddlProjects" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 108px">
                                            <span class="labelClass">Conservation Town</span>
                                        </td>
                                        <td style="width: 100px">
                                            <asp:DropDownList ID="ddlConservationTown" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 99px"><span class="labelClass">Anticipated Funds</span></td>
                                        <td style="width: 100px">
                                            <asp:TextBox ID="txtAntFunds" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 70px"><span class="labelClass">Date Closed</span></td>
                                        <td style="width: 100px">
                                            <asp:TextBox ID="txtDateClosed" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDateClosed" TargetControlID="txtDateClosed">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 50px"><span class="labelClass">Active</span></td>
                                        <td class="modal-sm" style="width: 70px">
                                            <asp:CheckBox ID="cbActiveProjects" runat="server" Enabled="false" Checked="true" />
                                        </td>
                                        <td style="width: 10px">
                                            <asp:Button ID="btnAddVHCBProject" runat="server" Text="Submit" class="btn btn-info"
                                                OnClick="btnAddVHCBProject_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="12" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvVHCBProjectsgrid" runat="server">
                            <div id="dvVHCBProjectsWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblVHCBProjectsWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="170px" ScrollBars="Vertical">
                                <asp:GridView ID="gvVHCBProjects" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="True"
                                     OnRowEditing="gvVHCBProjects_RowEditing" OnRowCancelingEdit="gvVHCBProjects_RowCancelingEdit"
                                     OnRowUpdating="gvVHCBProjects_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Act250ProjectID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAct250ProjectID" runat="Server" Text='<%# Eval("Act250ProjectID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Conservation Town">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConservationTown" runat="Server" Text='<%# Eval("ConservationTown") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Anticipated Funds" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAnticipatedFunds" runat="Server" Text='<%# Eval("AmtFunds", "{0:C2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAnticipatedFunds" CssClass="clsTextBoxBlueSm" runat="server" 
                                                    Text='<%# Eval("AmtFunds", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterAnticipatedFunds" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="120px" />
                                            <FooterStyle Width="120px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Closed">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDateClosed" runat="Server" Text='<%# Eval("DateClosed", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtProjectDateClosed" CssClass="clsTextBoxBlueSm" runat="server"
                                                    Text='<%# Eval("DateClosed", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtProjectDateClosed" 
                                                    TargetControlID="txtProjectDateClosed">
                                                </ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="10px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfAct250FarmID" runat="server" />
        <asp:HiddenField ID="hfUsePermit" runat="server" />
        <asp:HiddenField ID="hfTotalDevPayments" runat="server" />
        <asp:HiddenField ID="hfLandUsePermitFinancialsBalance" runat="server" />
        <asp:HiddenField ID="hfProjectsWarning" runat="server" />
        
        <script language="javascript">
            $(document).ready(function () {
                $('#<%= dvAct250InfoForm.ClientID%>').toggle($('#<%= cbAddAct250Info.ClientID%>').is(':checked'));
                $('#<%= cbAddAct250Info.ClientID%>').click(function () {
                    $('#<%= dvAct250InfoForm.ClientID%>').toggle(this.checked);
                }).change();

                $('#<%= dvDeveloperPaymentsForm.ClientID%>').toggle($('#<%= cbAddDeveloperPayment.ClientID%>').is(':checked'));
                $('#<%= cbAddDeveloperPayment.ClientID%>').click(function () {
                    $('#<%= dvDeveloperPaymentsForm.ClientID%>').toggle(this.checked);
                }).change();

                $('#<%= dvVHCBProjectsForm.ClientID%>').toggle($('#<%= cbAddVHCBProjects.ClientID%>').is(':checked'));
                $('#<%= cbAddVHCBProjects.ClientID%>').click(function () {
                    $('#<%= dvVHCBProjectsForm.ClientID%>').toggle(this.checked);
                }).change();
            });

            function PopupAwardSummary() {
                window.open('awardsummary.aspx?projectid=0');
            };

            function RadioCheck(rb) {
                var gv = document.getElementById("<%=gvAct250Info.ClientID%>");
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
        </script>
    </div>
</asp:Content>
