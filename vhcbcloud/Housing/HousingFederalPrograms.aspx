<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HousingFederalPrograms.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Housing.HousingFederalPrograms" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs"></ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 171px"><span class="labelClass">Project #</span></td>
                            <td style="width: 192px">
                                <span class="labelClass" id="ProjectNum" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Name:</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="ProjName" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Total Units:</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="TotalUnits" runat="server"></span>
                            </td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" Style="border: none; vertical-align: middle;" runat="server" Text="Project Search"
                                    OnClientClick="window.location.href='../ProjectSearch.aspx'; return false;"></asp:ImageButton>
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" Text="Award Summary"
                                    Style="border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" Text="Project Notes"
                                    Style="border: none; vertical-align: middle;" />
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

                <div class="panel-width" runat="server" id="dvNewProgramSetup">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Program Setup</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddFedProgram" runat="server" Text="Add New Federal Program" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvProgramSetupForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Federal Program</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlFederalProgram" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 140px"><span class="labelClass">Number of Units</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtTotFedProgUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="AddFederalProgram" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="AddFederalProgram_Click" />
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

                        <div class="panel-body" id="dvFedProgramGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="130px" ScrollBars="Vertical">
                                <asp:GridView ID="gvFedProgram" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvFedProgram_RowEditing" OnRowCancelingEdit="gvFedProgram_RowCancelingEdit"
                                    OnRowUpdating="gvFedProgram_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectFederalID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectFederalID" runat="Server" Text='<%# Eval("ProjectFederalID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectFederalProgram" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectFederalProgram_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenProjectFederalID" runat="server" Value='<%#Eval("ProjectFederalID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Federal Program">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFedProgram" runat="Server" Text='<%# Eval("FedProgram") %>' />
                                                <asp:HiddenField ID="HiddenFedProgram" runat="server" Value='<%#Eval("FedProgram")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number of units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumUnits" runat="Server" Text='<%# Eval("NumUnits") %>' />
                                                <asp:HiddenField ID="HiddenFedProgramNumUnits" runat="server" Value='<%#Eval("NumUnits")%>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNumUnits" CssClass="clsTextBoxBlueSm" runat="server"
                                                    Text='<%# Eval("NumUnits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 2px 15px 0px 2px" runat="server" id="dvFedProgramHome" visible="false">
                            <div class="panel panel-default" style="margin-bottom: 2px;">

                                <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title"><span id ="spnFormTitle" runat="server" >HOME </span></h3>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvFedProgramHomeForm">
                                    <asp:Panel runat="server" ID="Panel1">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 182px"><span class="labelClass">Recertification Month</span></td>
                                                <td style="width: 189px">
                                                    <asp:DropDownList ID="ddlRecreationMonth" CssClass="clsDropDown" runat="server" Style="margin-left: 18">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 139px"><span class="labelClass">Affordability Period</span></td>
                                                <td style="width: 151px">
                                                    <asp:DropDownList ID="ddlAffPeriod" CssClass="clsDropDown" runat="server" Style="margin-left: 18">
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtAffPeriod" CssClass="clsTextBoxBlueSm" Text="30" runat="server" ></asp:TextBox>
                                                     <asp:RangeValidator runat="server" Type="Integer" class="lblErrMsg" SetFocusOnError="True" 
                                                         MinimumValue="30" MaximumValue="9999"
                                                        ControlToValidate="txtAffPeriod" ErrorMessage="Affordability Period not be less than 30 Years"
                                                        Style="top: 435px; left: 730px; position: absolute; height: 218px; width: 355px" />
                                                </td>
                                                <td style="width: 235px"><span class="labelClass">Affordability Period Start Date</span></td>
                                                <td style="width: 180px">
                                                    <asp:TextBox ID="txtAffrdStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtAffrdStartDate" TargetControlID="txtAffrdStartDate">
                                                    </ajaxToolkit:CalendarExtender>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 182px"><span class="labelClass">Affordability Period End Date</span></td>
                                                <td style="width: 189px">
                                                    <asp:TextBox ID="txtAffrdEndDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtAffrdEndDate" TargetControlID="txtAffrdEndDate">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                                 <td style="width: 139px"><span class="labelClass">Inspection Frequency</span></td>
                                                <td style="width: 151px">
                                                    <asp:TextBox ID="txtFreq" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                    <asp:RangeValidator runat="server" Type="Integer" class="lblErrMsg" SetFocusOnError="True" MinimumValue="1" MaximumValue="3"
                                                        ControlToValidate="txtFreq" ErrorMessage="Inspection Frequency should only accept numbers 1-3"
                                                        Style="top: 510px; left: 730px; position: absolute; height: 218px; width: 355px" />
                                                </td>

                                                <td style="width: 235px"><span class="labelClass" id="spnCHDORequest" runat="server">CHDO Project</span></td>
                                                <td style="width: 180px">
                                                    <asp:CheckBox ID="chkCHDO" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 182px"><span class="labelClass" id="spnCHDORecertMonth" runat="server">CHDO Recertification Month</span></td>
                                                <td style="width: 189px">
                                                    <asp:DropDownList ID="ddlCHRDoRecert" CssClass="clsDropDown" runat="server" Style="margin-left: 18">
                                                    </asp:DropDownList>
                                                </td>
                                                <%--<td style="width: 165px"><span class="labelClass">Inspection Frequency</span></td>
                                                <td style="width: 180px">
                                                    <asp:TextBox ID="txtFreq" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                    <asp:RangeValidator runat="server" Type="Integer" class="lblErrMsg" SetFocusOnError="True" MinimumValue="1" MaximumValue="3"
                                                        ControlToValidate="txtFreq" ErrorMessage="Inspection Frequency should only accept numbers 1-3"
                                                        Style="top: 520px; left: 650px; position: absolute; height: 218px; width: 355px" />
                                                </td>--%>
                                                <td style="width: 139px"><span class="labelClass"></span></td>
                                                <td style="width: 151px"></td>
                                                <td style="width: 235px"><span class="labelClass"></span></td>
                                                <td style="width: 180px"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel panel-default" style="margin-bottom: 0px;">
                                    <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <h3 class="panel-title">IDIS Info</h3>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="Div2">
                                        <asp:Panel runat="server" ID="Panel4">
                                            <table class="nav-justified">
                                                <tr>
                                                    <td style="width: 159px"><span class="labelClass">IDIS #</span></td>
                                                    <td style="width: 189px">
                                                        <asp:TextBox ID="txtIDSNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 106px"><span class="labelClass">Setup Date</span></td>
                                                    <td style="width: 153px">
                                                        <asp:TextBox ID="txtSetupDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                        <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtSetupDate" TargetControlID="txtSetupDate">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td style="width: 156px"><span class="labelClass">Completed By</span></td>
                                                    <td style="width: 180px">
                                                        <asp:DropDownList ID="ddlCompletedBy" CssClass="clsDropDown" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 159px"><span class="labelClass">Funded Date</span></td>
                                                    <td style="width: 189px">
                                                        <asp:TextBox ID="txtFundedDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                        <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtFundedDate" TargetControlID="txtFundedDate">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                    <td style="width: 106px"><span class="labelClass">Completed By</span></td>
                                                    <td style="width: 153px">
                                                        <asp:DropDownList ID="ddlFundedDateCompleteBy" CssClass="clsDropDown" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 156px"><span class="labelClass">IDIS Completion Date</span></td>
                                                    <td style="width: 180px">
                                                        <asp:TextBox ID="txtCloseDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                        <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtCloseDate" TargetControlID="txtCloseDate">
                                                        </ajaxToolkit:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 159px"><span class="labelClass">Completed By</span></td>
                                                    <td style="width: 189px">
                                                        <asp:DropDownList ID="ddlIDISCompletionDateCompletedBy" CssClass="clsDropDown" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 106px"></td>
                                                    <td style="width: 153px"></td>
                                                    <td style="width: 156px"></td>
                                                    <td style="width: 180px">
                                                        <asp:Button ID="btnSubmitHomeForm" runat="server" Text="Submit" class="btn btn-info"
                                                            OnClick="btnSubmitHomeForm_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="height: 5px"></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewHomeAff" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title"><span id="spnIncomeRest" runat="server">HOME Income Restrictions</span></h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHomeAff" runat="server" Text="Add New HOME Income Restriction" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHomeAffForm">
                            <asp:Panel runat="server" ID="Panel12">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px">
                                            <span class="labelClass" id="spnIncomeRestrictionsLabel" runat="server">HOME123</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHomeAff" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtHomeUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddHomeAff" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddHomeAff_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHomeAffGrid" runat="server">
                            <div id="dvHomeAffWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblHomeAffWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel13" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvNewHomeAff" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvNewHomeAff_RowEditing" OnRowCancelingEdit="gvNewHomeAff_RowCancelingEdit"
                                    OnRowUpdating="gvNewHomeAff_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectFederalIncomeRestID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectFederalIncomeRestID" runat="Server" Text='<%# Eval("ProjectFederalIncomeRestID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Income">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCB" runat="Server" Text='<%# Eval("Home") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="#Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHomeNumunits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtHomeNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterHomeTotalUnits" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="200px" />
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

                <div class="panel-width" runat="server" id="dvRentalAffordability" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title"><span id="spnRentRest" runat="server">HOME Rent Restrictions</span></h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddRentalAffordability" runat="server" Text="Add New HOME Rent Restriction" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvRentalAffordabilityForm">
                            <asp:Panel runat="server" ID="Panel5">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Unit Type</span></td>
                                        <td style="width: 215px">
                                            <div>
                                                <asp:DropDownList ID="ddlUnitType" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Number of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtUnitTypeUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddRentalAffordability" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddRentalAffordability_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvRentalAffordabilityGrid" runat="server">
                            <div id="dvRentalAffordabilityWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblSubTypeWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel6" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvRentalAffordability" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvRentalAffordability_RowEditing" OnRowCancelingEdit="gvRentalAffordability_RowCancelingEdit"
                                    OnRowUpdating="gvRentalAffordability_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="FederalAffordID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFederalAffordID" runat="Server" Text='<%# Eval("FederalAffordID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnitType" runat="Server" Text='<%# Eval("AffordTypeName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="#Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnits" runat="Server" Text='<%# Eval("NumUnits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtUnits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("NumUnits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalUnits" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="200px" />
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

                <div class="panel-width" runat="server" id="dvUnitOccupancy" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title"><span id="spnUnitSizes" runat="server">HOME Unit Sizes</span></h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddUnitOccupancy" runat="server" Text="Add New HOME Unit Sizes" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvUnitOccupancyForm">
                            <asp:Panel runat="server" ID="Panel7">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Unit Type</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlUnitOccupancyUnitType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Number of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtUnitOccupancyNumUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddUnitType" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddUnitType_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvUnitOccupanyGrid" runat="server">
                            <div id="dvUnitOccupanyWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblUnitOccupanyWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvUnitOccupany" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvUnitOccupany_RowEditing" OnRowCancelingEdit="gvUnitOccupany_RowCancelingEdit"
                                    OnRowUpdating="gvUnitOccupany_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="FederalUnitID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFederalUnitID" runat="Server" Text='<%# Eval("FederalUnitID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit Size">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnitType" runat="Server" Text='<%# Eval("UnitTypeName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="#Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnits" runat="Server" Text='<%# Eval("NumUnits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtUnits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("NumUnits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalUnits" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="200px" />
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

                <div class="panel-width" runat="server" id="dvNewInspections" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 0px;">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Inspections</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddNewInspections" runat="server" Text="Add New Inspection" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvInspectionsForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 151px"><span class="labelClass">Inspection Date</span></td>
                                        <td style="width: 158px">
                                            <asp:TextBox ID="txtInspectDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtInspectDate" TargetControlID="txtInspectDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 138px"><span class="labelClass">Inspection performed by</span></td>
                                        <td style="width: 177px">
                                            <asp:DropDownList ID="ddlStaff" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 156px"><span class="labelClass">Next Inspection year</span></td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtNextInspect" CssClass="clsTextBoxBlueSm" runat="server" Style="margin-left: 2px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 151px"><span class="labelClass">Date Inspection letter sent</span></td>
                                        <td style="width: 158px">
                                            <asp:TextBox ID="txtInspectLetter" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtInspectLetter" TargetControlID="txtInspectLetter">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 138px"><span class="labelClass">Date of Response</span></td>
                                        <td style="width: 177px">
                                            <asp:TextBox ID="txtRespDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtRespDate" TargetControlID="txtRespDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 156px"><span class="labelClass">Deficiency(ies) Found?</span></td>
                                        <td style="width: 180px">
                                            <asp:CheckBox ID="cbDeficiency" runat="server" Checked="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 151px"><span class="labelClass">Next Inspection Deadline</span></td>
                                        <td style="width: 158px">
                                            <asp:TextBox ID="txtNextInspDeadLine" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtNextInspDeadLine" TargetControlID="txtNextInspDeadLine">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 138px"><span class="labelClass">Active:</span></td>
                                        <td style="width: 177px">
                                            <asp:CheckBox ID="chkInspectionActive" Enabled="false" runat="server" Checked="true" /></td>
                                        <td style="width: 156px">
                                            <asp:Button ID="btnAddInspection" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddInspection_Click" />
                                        </td>
                                        <td style="width: 180px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvInspectionGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel10" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvInspection" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="false"
                                    OnRowEditing="gvInspection_RowEditing" OnRowCancelingEdit="gvInspection_RowCancelingEdit"
                                    OnRowDataBound="gvInspection_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="FederalProjectInspectionID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFederalProjectInspectionID" runat="Server" Text='<%# Eval("FederalProjectInspectionID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Inspection Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInspectDate" runat="Server" Text='<%# Eval("InspectDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="250px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Performed By">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInspectionPerformedBy" runat="Server" Text='<%# Eval("InspectionPerformedBy") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="300px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Next Inspection year">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNextInspect" runat="Server" Text='<%# Eval("NextInspect") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="80px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <%--<div class="panel-width" runat="server" id="dvMedianIncome" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Median Income</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMedianIncome" runat="server" Text="Add New Median Income" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMedianIncomeForm">
                            <asp:Panel runat="server" ID="Panel10">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Median Income</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlMedianIncome" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Number of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtMedianIncomeUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddMedianIncome" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddMedianIncome_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvMedianIncomeGrid" runat="server">
                            <div id="dvMedianIncomeWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblMedianIncomeWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMedianIncome" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvMedianIncome_RowEditing" OnRowCancelingEdit="gvMedianIncome_RowCancelingEdit"
                                    OnRowUpdating="gvMedianIncome_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="FederalMedIncomeID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFederalMedIncomeID" runat="Server" Text='<%# Eval("FederalMedIncomeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Median Income">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMedIncomeName" runat="Server" Text='<%# Eval("MedIncomeName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="#Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnits" runat="Server" Text='<%# Eval("NumUnits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtUnits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("NumUnits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalUnits" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="200px" />
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
                </div>--%>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfProjectFederalID" runat="server" />
    <asp:HiddenField ID="hfProjectFederalProgramDetailID" runat="server" />
    <asp:HiddenField ID="hfProjectFedProgram" runat="server" />
    <asp:HiddenField ID="hfSubTypeWarning" runat="server" />
    <asp:HiddenField ID="hfTotalProgramUnits" runat="server" />
    <asp:HiddenField ID="hfUnitOccupancyWarning" runat="server" />
    <asp:HiddenField ID="hfMedianIncomeWarning" runat="server" />
    <asp:HiddenField ID="hfHousingID" runat="server" />
    <asp:HiddenField ID="hfHomeAffWarning" runat="server" />
    <asp:HiddenField ID="hfFederalProjectInspectionID" runat="server" />
    

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= txtAffrdStartDate.ClientID%>').blur(function () {
                if ($('#<%=txtAffrdStartDate.ClientID%>').val() == "") {
                    $('#<%=txtAffrdStartDate.ClientID%>').val($('#<%=txtCloseDate.ClientID%>').val());
                }
                PopupAffrdEndDate();
            });
            $('#<%= ddlAffPeriod.ClientID%>').change(function () {
                PopupAffrdEndDate();
            });

            <%--$('#<%= txtFreq.ClientID%>').blur(function () {
                PopupNextInspectionYear();
            });--%>

            $('#<%= txtInspectDate.ClientID%>').blur(function () {
                PopupNextInspectionDeadLine();
            });

            $('#<%= cbDeficiency.ClientID%>').click(function () {
                PopupNextInspectionDeadLine();
            });


            $('#<%= dvProgramSetupForm.ClientID%>').toggle($('#<%= cbAddFedProgram.ClientID%>').is(':checked'));
            $('#<%= cbAddFedProgram.ClientID%>').click(function () {
                $('#<%= dvProgramSetupForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHomeAffForm.ClientID%>').toggle($('#<%= cbAddHomeAff.ClientID%>').is(':checked'));
            $('#<%= cbAddHomeAff.ClientID%>').click(function () {
                $('#<%= dvHomeAffForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvInspectionsForm.ClientID%>').toggle($('#<%= cbAddNewInspections.ClientID%>').is(':checked'));
            $('#<%= cbAddNewInspections.ClientID%>').click(function () {
                $('#<%= dvInspectionsForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvRentalAffordabilityForm.ClientID%>').toggle($('#<%= cbAddRentalAffordability.ClientID%>').is(':checked'));
            $('#<%= cbAddRentalAffordability.ClientID%>').click(function () {
                $('#<%= dvRentalAffordabilityForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvUnitOccupancyForm.ClientID%>').toggle($('#<%= cbAddUnitOccupancy.ClientID%>').is(':checked'));
            $('#<%= cbAddUnitOccupancy.ClientID%>').click(function () {
                $('#<%= dvUnitOccupancyForm.ClientID%>').toggle(this.checked);
            }).change();

<%--            $('#<%= dvMedianIncomeForm.ClientID%>').toggle($('#<%= cbAddMedianIncome.ClientID%>').is(':checked'));
            $('#<%= cbAddMedianIncome.ClientID%>').click(function () {
                $('#<%= dvMedianIncomeForm.ClientID%>').toggle(this.checked);
            }).change();--%>

            $('#<%= ddlUnitType.ClientID%>').each(function () {
                var i = 0;
                var sel = this;
                for (i = 0; i < sel.length; i++) {
                    if (sel.options[i].text.toLowerCase() == 'home high') {
                        sel.options[i].title = '30% of 65% AMI, adjusted for # of bedrooms or FMR, whichever is lower';
                    }
                    else if (sel.options[i].text.toLowerCase() == 'home low') {
                        sel.options[i].title = '30% of 50% AMI, adjusted for # of bedrooms or FMR, whichever is lower';
                    } else {
                        sel.options[i].title = '';
                    }
                }
            });
        });

        function PopupAffrdEndDate() {
            if ($('#<%=txtAffrdStartDate.ClientID%>').val() != "") {
                var noYears;
                switch ($('#<%=ddlAffPeriod.ClientID %> option:selected').text()) {
                    case "5 years":
                        noYears = 5;
                        break;
                    case "10 years":
                        noYears = 10;
                        break;
                    case "20 years":
                        noYears = 20;
                        break;
                    default:
                        noYears = 0;
                }

                var startDate = new Date($('#<%=txtAffrdStartDate.ClientID%>').val());
                var endDate = new Date(startDate.getFullYear() + noYears, startDate.getMonth(), startDate.getDate())
                console.log(startDate);
                console.log(endDate);
                $('#<%=txtAffrdEndDate.ClientID%>').val(endDate.getMonth() + 1 + "/" + endDate.getDate() + "/" + endDate.getFullYear());
            }
            else {
                $('#<%=txtAffrdEndDate.ClientID%>').val('');
            }
        };

        function PopupNextInspectionDeadLine() {
            if ($('#<%=txtInspectDate.ClientID%>').val() != "" && $('#<%= cbDeficiency.ClientID%>').is(':checked')) {
                var startDate = new Date($('#<%=txtInspectDate.ClientID%>').val());
                console.log(startDate);
                startDate.setFullYear(startDate.getFullYear() + 1);
                console.log(startDate);
                var dd = startDate.getDate();
                var mm = startDate.getMonth() + 1;
                var y = startDate.getFullYear();

                var someFormattedDate = mm + '/' + dd + '/' + y;
                console.log(someFormattedDate);
                $('#<%=txtNextInspDeadLine.ClientID%>').val(someFormattedDate);
            }
            else {
                $('#<%=txtNextInspDeadLine.ClientID%>').val('');
            }
        };

        <%--function PopupNextInspectionYear() {
            if (!isNaN($('#<%=txtFreq.ClientID%>').val()) && $('#<%=txtLastInspect.ClientID%>').val() != "") {

                var startDate = new Date($('#<%=txtLastInspect.ClientID%>').val());
                console.log(startDate);
                $('#<%=txtNextInspect.ClientID%>').val(startDate.getFullYear() + parseFloat($('#<%=txtFreq.ClientID%>').val()));
            }
            else {
                $('#<%=txtNextInspect.ClientID%>').val('');
            }
        };--%>

        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvFedProgram.ClientID%>");
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
</asp:Content>
