<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EntityMaintenance.aspx.cs" Inherits="vhcbcloud.EntityMaintenance"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Entity (Organization / Individual) </p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdBtnAction" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="rdBtnAction_SelectedIndexChanged">
                                    <asp:ListItem Enabled="false">New</asp:ListItem>
                                    <asp:ListItem>Existing</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="text-align: right;">
                                <asp:ImageButton ID="btnProjectNotes1" Visible="false" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" Visible="false" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes1"
                        CancelControlID="btnClose" BackgroundCssClass="MEBackground">
                    </ajaxToolkit:ModalPopupExtender>
                    <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                        <iframe style="width: 750px; height: 550px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                        <br />
                        <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
                    </asp:Panel>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div id="dvEntityRole" runat="server">
                    <table>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 100px"><span class="labelClass">Entity Role</span></td>
                            <td style="width: 170px">
                                <asp:DropDownList ID="ddlEntityRole" CssClass="clsDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEntityRole_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 2px"></td>
                            <td style="width: 270px">
                                <div id="dvExistingEntities" runat="server" visible="false">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <span class="labelClass">Entity Name</span>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlEntityName" CssClass="clsDropDown" runat="server"
                                                    OnSelectedIndexChanged="ddlEntityName_SelectedIndexChanged" AutoPostBack="True">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td style="width: 170px">
                                
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvIndividual">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                            <h3 class="panel-title">Individual</h3>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px">
                            <asp:Panel runat="server" ID="pnlIndividualForm">
                                <table style="width: 100%">
                                    <tr>
                                        <td><span class="labelClass">Acct #</span></td>
                                        <td>
                                            <span class="labelClass" runat="server" id="spnAcctNumber"></span>
                                        </td>
                                        <td>
                                            <span class="labelClass">Last Name</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLastName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="ac_txtLastName" runat="server" TargetControlID="txtLastName"
                                                MinimumPrefixLength="1"
                                                EnableCaching="false" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetIndividualLastNames"
                                                OnClientItemSelected="PopulateLnameDetails"
                                                OnClientPopulated="onLirstNamePopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td><span class="labelClass">First Name</span></td>
                                        <td>
                                            <asp:TextBox ID="txtFirstName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="ac_txtFirstName" runat="server" TargetControlID="txtFirstName"
                                                MinimumPrefixLength="1"
                                                EnableCaching="false" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetIndividualFirstNames"
                                                OnClientItemSelected="PopulateFnameDetails"
                                                OnClientPopulated="onFirstNamePopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Role</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlPosition" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Title</span></td>
                                        <td>
                                            <asp:TextBox ID="txtTitle" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td>
                                            <%-- <span class="labelClass">Email</span>--%>
                                        </td>
                                        <td>
                                            <%--<asp:TextBox ID="txtEmail" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>--%>
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

                <div class="panel-width" runat="server" id="dvCommonForm">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                            <h3 class="panel-title"><span id="CommonFormHeader" runat="server">Entity (Organization / Individual)</span> </h3>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px">
                            <asp:Panel runat="server" ID="pnlCommonForm">
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <span class="labelClass">Legal Structure</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlEntityType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Name</span></td>
                                        <td>
                                            <asp:TextBox ID="txtApplicantName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="ae_txtApplicantName" runat="server" TargetControlID="txtApplicantName" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetEntityNames" OnClientPopulated="onEntityListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td><span class="labelClass">Fiscal Yr End</span></td>
                                        <td>
                                            <asp:TextBox ID="txtFiscalYearEnd" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="labelClass">Website</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWebsite" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass">State Vendor ID</span></td>
                                        <td>
                                            <asp:TextBox ID="txtStateVendorId" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <span class="labelClass">Home Phone</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtHomePhone" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:MaskedEditExtender runat="server" ID="ameHomePhoneNumber" Mask="(999)999-9999" ClearMaskOnLostFocus="false"
                                                MaskType="Number" TargetControlID="txtHomePhone">
                                            </ajaxToolkit:MaskedEditExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="labelClass">Work Phone</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWorkPhone" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:MaskedEditExtender runat="server" ID="ameWorkPhoneNumber" Mask="(999)999-9999" ClearMaskOnLostFocus="false"
                                                MaskType="Number" TargetControlID="txtWorkPhone">
                                            </ajaxToolkit:MaskedEditExtender>
                                        </td>
                                        <td>
                                            <span class="labelClass">CellPhone</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCellPhone" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:MaskedEditExtender runat="server" ID="ameCellPhoneNumber" Mask="(999)999-9999" ClearMaskOnLostFocus="false"
                                                MaskType="Number" TargetControlID="txtCellPhone">
                                            </ajaxToolkit:MaskedEditExtender>
                                        </td>
                                        <td><span class="labelClass" runat="server" id="lblW9">W9</span></td>
                                        <td>
                                            <asp:CheckBox ID="ckbW9" CssClass="ChkBox" runat="server" Text="" Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="labelClass">Email</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmail" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <span class="labelClass" runat="server" id="spnDefaultRole">Default Role</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlDefaultRole" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass" runat="server" id="Span1">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbMilestoneActive" runat="server" Text="" Enabled="false" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                   <tr>
                                        <td>
                                            <span class="labelClass" runat="server" id="spnTier1">Tier 1</span>
                                        </td>
                                        <td style="width: 322px">
                                            <asp:CheckBox ID="cbTear1" CssClass="ChkBox" runat="server" Text=""  Enabled="false"/>
                                        </td>
                                        <td>
                                            <span class="labelClass" runat="server" id="spnFileHold">FileHold</span>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbFileHold" CssClass="ChkBox" runat="server" Text=""  Enabled="false"/>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>



                <div class="panel-width" runat="server" id="dvFarm">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 10px 5px">
                            <h3 class="panel-title">Farm</h3>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td><span class="labelClass">Farm Type</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlFarmType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <span class="labelClass">Farm Name</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFarmName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass">Acres in Production</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAcresInProduction" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Acres Owned</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAcresOwned" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td>
                                            <span class="labelClass">Acres Leased</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAcresLeased" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <span class="labelClass">Acres Leased Out</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAcresLeasedOut" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Total Acres</span></td>
                                        <td>
                                            <asp:TextBox ID="txtTotalAcres" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td>
                                            <span class="labelClass">No Longer in Business</span>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbIsNoLongerBusiness" CssClass="ChkBox" runat="server" Text="Yes" />
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Note</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="850px" Height="49px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Agricultural Education</span></td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtAgrEdu" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="500px" Height="49px" />
                                        <td>
                                            <span class="labelClass">Years Managing Farm</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtYearsManagingForm" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
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

                <div id="dvNewEntirySubmit" runat="server">
                    <table>
                        <tr>
                            <td style="height: 10px" colspan="5">&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="height: 5px">&nbsp;&nbsp;&nbsp;</td>
                            <td style="height: 5px"></td>
                            <td style="height: 5px"></td>
                            <td style="height: 5px">
                                <asp:Button ID="btnEntitySubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnEntitySubmit_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px"></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvNewAddress">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Addresses</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAddress" runat="server" Text="Add New Address" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectAddressForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 120px"><span class="labelClass">State</span></td>
                                        <td style="width: 250px" colspan="4">
                                            <asp:DropDownList ID="ddlState" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 234px"></td>
                                        <td style="width: 336px"></td>
                                        <td style="width: 354px"></td>
                                        <td></td>
                                    </tr>
                                </table>
                                
                                <div id="dvAddress" runat="server" visible="false">
                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 150px"><span class="labelClass">Address Type</span></td>
                                            <td style="width: 250px">
                                                <asp:DropDownList ID="ddlAddressType" CssClass="clsDropDown" runat="server">
                                                </asp:DropDownList>
                                            </td>

                                            <td style="width: 100px"><span class="labelClass">Street #</span></td>
                                            <td style="width: 270px">
                                                <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox><%-- onkeyup="SetContextKey()"--%>
                                                <ajaxToolkit:AutoCompleteExtender ID="ae_txtStreetNo" runat="server" TargetControlID="txtStreetNo" MinimumPrefixLength="1"
                                                    EnableCaching="true" CompletionSetCount="1" CompletionListCssClass="clsAutoExtDropDown"
                                                    CompletionInterval="100" ServiceMethod="GetAddress1" OnClientItemSelected="GetAddressDetails" OnClientPopulated="onListPopulated">
                                                </ajaxToolkit:AutoCompleteExtender>
                                                <asp:CheckBox ID="cbReqStreetNo" runat="server" Checked="true" ToolTip="Required Street #" />
                                            </td>
                                            <td style="width: 170px">
                                                <span class="labelClass">Address1:</span>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 170px"><span class="labelClass">Address2</span></td>
                                            <td>
                                                <asp:TextBox ID="txtAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                            </td>
                                            <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                            <td style="width: 250px">
                                                <asp:TextBox ID="txtZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="5"></asp:TextBox>
                                            </td>
                                            <td style="width: 100px">
                                                <span class="labelClass">Town</span>
                                            </td>
                                            <td style="width: 270px">
                                                <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50" Visible="false"></asp:TextBox>
                                                <asp:DropDownList ID="ddlTown" CssClass="clsDropDown" runat="server" AutoPostBack="true" Visible="true" OnSelectedIndexChanged="ddlTown_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px"><span class="labelClass">County</span></td>
                                            <td style="width: 250px">
                                                <asp:TextBox ID="txtCounty" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Visible="false"></asp:TextBox>
                                                <asp:DropDownList ID="ddlCounty" CssClass="clsDropDown" runat="server" Visible="true">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 100px">
                                                <span class="labelClass" runat="server" id="spnVillage" visible="true">Village</span>
                                            </td>
                                            <td style="width: 270px">
                                                <asp:DropDownList ID="ddlVillage" CssClass="clsDropDown" runat="server" Visible="true">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 170px"><span class="labelClass">Default Address</span></td>
                                            <td>
                                                <asp:CheckBox ID="cbDefaultAddress" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px"><span class="labelClass">Active</span></td>
                                            <td style="width: 250px">
                                                <asp:CheckBox ID="cbActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                            </td>
                                            <td style="width: 150px"><span class="labelClass">Lattitude</span></td>
                                            <td style="width: 250px">
                                                <asp:TextBox ID="txtLattitude" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                            <td><span class="labelClass">Longitude</span></td>
                                            <td>
                                                <asp:TextBox ID="txtLongitude" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px">
                                                <asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" /></td>
                                            <td style="width: 250px">
                                                <asp:Button ID="btnGetLatLong" runat="server" Text="Get Lat Long" class="btn btn-info" OnClick="btnGetLatLong_Click"/>
                                            </td>
                                            <td style="width: 150px">
                                                <asp:Button ID="btnGetAddress" runat="server" Text="Update Address from Lat/Long" class="btn btn-info" OnClick="btnGetAddress_Click" />
                                            </td>
                                            <td style="width: 250px"></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAddressGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvAddress_RowCancelingEdit" OnRowDataBound="gvAddress_RowDataBound"
                                    OnRowEditing="gvAddress_RowEditing">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Address Id" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddressId" runat="Server" Text='<%# Eval("AddressId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddressType" runat="Server" Text='<%# Eval("AddressType") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="St.##">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStreetNum" runat="Server" Text='<%# Eval("Street#") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address1">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress1" runat="Server" Text='<%# Eval("Address1") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress2" runat="Server" Text='<%# Eval("Address2") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Town/Village">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTown" runat="Server" Text='<%# Eval("Town") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="County">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCounty" runat="Server" Text='<%# Eval("County") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="State">
                                            <ItemTemplate>
                                                <asp:Label ID="lblState" runat="Server" Text='<%# Eval("State") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Default">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDefault" runat="Server" Text='<%# Eval("Defaddress") %>' />
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

                <div class="panel-width" runat="server" id="dvNewAttribute">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Attributes</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAttribute" runat="server" Text="Add New Attribute" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvAttributeForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Attribute</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAttribute" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="AddAttribute" runat="server" Text="Add" class="btn btn-info" OnClick="AddAttribute_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvAttributeGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAttribute" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvAttribute_RowEditing" OnRowCancelingEdit="gvAttribute_RowCancelingEdit"
                                    OnRowUpdating="gvAttribute_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Farm Attribute ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFarmAttributeID" runat="Server" Text='<%# Eval("FarmAttributeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Attribute">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttribute" runat="Server" Text='<%# Eval("Attribute") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
                                            <%--<EditItemTemplate>
                                                <asp:DropDownList ID="ddlAttributeE" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtLkConsAttrib" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("LkConsAttrib") %>' Visible="false">
                                                </asp:TextBox>
                                            </EditItemTemplate>--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <ItemStyle Width="350px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewProduct">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Products</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddProduct" runat="server" Text="Add New Product" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvProductForm">
                            <asp:Panel runat="server" ID="Panel4">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Product</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlProduct" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 140px"><span class="labelClass">Start Date</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtStartDate" TargetControlID="txtStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddProduct" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddProduct_Click" />
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvProductGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvProduct_RowEditing" OnRowCancelingEdit="gvProduct_RowCancelingEdit"
                                    OnRowUpdating="gvProduct_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Farm Products ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFarmProductsID" runat="Server" Text='<%# Eval("FarmProductsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Attribute">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttribute" runat="Server" Text='<%# Eval("Product") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="Server" Text='<%# Eval("StartDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("StartDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_StartDate" TargetControlID="txtStartDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <ItemStyle Width="350px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvAttachEntities" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Attach Entities</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAttachEntities" runat="server" Text="Attach Entities" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvAttachEntitiesForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Entity Role</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlEntityRole1" CssClass="clsDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEntityRole1_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 180px"><span class="labelClass">Applicant Name</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlEntityName1" CssClass="clsDropDown" runat="server"
                                                OnSelectedIndexChanged="ddlEntityName1_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td style="width: 300px">
                                            <asp:Button ID="btnAttachEntities" runat="server" Text="Attach" class="btn btn-info" OnClick="btnAttachEntities_Click" />
                                        </td>
                                        <td style="width: 270px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvAttachEntitiesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAttachEntities" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowCancelingEdit="gvAttachEntities_RowCancelingEdit" OnRowEditing="gvAttachEntities_RowEditing" OnRowUpdating="gvAttachEntities_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ApplicantApplicantId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApplicantApplicantId" runat="Server" Text='<%# Eval("ApplicantApplicantId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Applicant Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttachedApplicantName" runat="Server" Text='<%# Eval("AttachedApplicantName") %>' />
                                            </ItemTemplate>
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
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewMilestone">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Milestones</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMilestone" runat="server" Text="Add New Milestone" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMilestoneForm">
                            <asp:Panel runat="server" ID="Panel10">

                                <div runat="server" id="dvEventMilestone">
                                    <div>
                                        <%-- <table style="width: 100%">
                                            <tr>
                                                <td style="width: 128px"><span class="labelClass">Entity</span></td>
                                                <td style="width: 222px">
                                                    <asp:TextBox ID="txtEntityDDL" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"
                                                        ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender ID="EntityAE" runat="server" TargetControlID="txtEntityDDL" MinimumPrefixLength="1"
                                                        EnableCaching="true" CompletionSetCount="1"
                                                        CompletionInterval="100" ServiceMethod="GetPrimaryApplicant" OnClientPopulated="onApplicantListPopulated">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 136px"></td>
                                                <td style="width: 312px"></td>
                                                <td style="width: 119px"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 5px"></td>
                                            </tr>
                                        </table>--%>
                                    </div>

                                    <div runat="server" id="dvEntity">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 128px"><span class="labelClass">Entity Milestone</span></td>
                                                <td class="modal-sm" style="width: 222px">
                                                    <asp:DropDownList ID="ddlEntityMilestone" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlEntityMilestone_SelectedIndexChanged" Height="20px" Width="185px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <div runat="server" id="dvSubEntityMilestone" visible="false">
                                                        <table>
                                                            <tr>
                                                                <td style="width: 140px"><span class="labelClass">Entity Sub Milestone</span></td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlEntitySubMilestone" CssClass="clsDropDown" runat="server" Height="20px" Width="185px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 128px"><span class="labelClass">Date</span></td>
                                        <td style="width: 224px">
                                            <asp:TextBox ID="txtEventDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtEventDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 136px"><span class="labelClass">URL</span></td>
                                        <td style="width: 319px">
                                            <asp:TextBox ID="txtURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass"></span></td>
                                        <td>
                                            <%--<asp:CheckBox ID="chkProjectEventActive" Enabled="false" runat="server" Checked="true" />--%>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 80px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtEntityMilestoneComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="height: 5px">
                                            <asp:Button ID="btnAddMilestone" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddMilestone_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvEntityMilestoneGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvEntityMilestone" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvEntityMilestone_RowEditing" OnRowCancelingEdit="gvEntityMilestone_RowCancelingEdit"
                                     OnRowDataBound="gvEntityMilestone_RowDataBound"
                                    OnRowUpdating="gvEntityMilestone_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Project Event ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectEventID" runat="Server" Text='<%# Eval("ProjectEventID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEntity" runat="Server" Text='<%# Eval("applicantname") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEntityMilestone" runat="Server" Text='<%# Eval("EntityMilestone") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity Sub Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEntitySubMilestone" runat="Server" Text='<%# Eval("EntitySubMilestone") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="190px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URL") %></a>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="150px" />
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
            </div>

            <asp:HiddenField ID="hfVillage" runat="server" />
            <asp:HiddenField ID="hfApplicatId" runat="server" />
            <asp:HiddenField ID="hfAddressId" runat="server" />
            <asp:HiddenField ID="hfFarmId" runat="server" />
            <asp:HiddenField ID="hfProjectId" runat="server" />
            <asp:HiddenField ID="hfProjectEventID" runat="server" />
            <asp:HiddenField ID="hfIsCreated" runat="server" />

        </div>
    </div>
    </div>

    <script language="javascript" src="https://maps.google.com/maps/api/js?key=AIzaSyCm3xOguaZV1P3mNL0ThK7nv-H9jVyMjSU"></script>
    <script language="javascript">
        $('#<%= txtFirstName.ClientID %>').bind('keypress keyup blur', function () {
            $('#<%= txtApplicantName.ClientID %>').val($(this).val() + ', ' + $('#<%= txtLastName.ClientID %>').val());
        });

        $('#<%= txtLastName.ClientID %>').bind('keypress keyup blur', function () {
            $('#<%= txtApplicantName.ClientID %>').val($(this).val() + ', ' + $('#<%= txtFirstName.ClientID %>').val());
        });

        $('#<%= txtFarmName.ClientID %>').bind('keypress keyup blur', function () {
            $('#<%= txtApplicantName.ClientID %>').val($(this).val());
        });

        $('#<%= txtApplicantName.ClientID %>').bind('keypress keyup blur', function () {
            $('#<%= txtFarmName.ClientID %>').val($(this).val());
        });

        if ($('#<%=ddlEntityRole.ClientID %> option:selected').text() == 'Individual') {
            $('#<%= txtApplicantName.ClientID %>')
                 .attr("disabled", "disabled")
        }
        else {
            $('#<%= txtApplicantName.ClientID %>')
                     .removeAttr("disabled")
        }

        $('#<%= dvAttributeForm.ClientID%>').toggle($('#<%= cbAddAttribute.ClientID%>').is(':checked'));
        $('#<%= cbAddAttribute.ClientID%>').click(function () {
            $('#<%= dvAttributeForm.ClientID%>').toggle(this.checked);
        }).change();

        $('#<%= dvProductForm.ClientID%>').toggle($('#<%= cbAddProduct.ClientID%>').is(':checked'));
        $('#<%= cbAddProduct.ClientID%>').click(function () {
            $('#<%= dvProductForm.ClientID%>').toggle(this.checked);
        }).change();

        $('#<%= dvAttachEntitiesForm.ClientID%>').toggle($('#<%= cbAttachEntities.ClientID%>').is(':checked'));
        $('#<%= cbAttachEntities.ClientID%>').click(function () {
            $('#<%= dvAttachEntitiesForm.ClientID%>').toggle(this.checked);
        }).change();

        $('#<%= dvMilestoneForm.ClientID%>').toggle($('#<%= cbAddMilestone.ClientID%>').is(':checked'));

        $('#<%= cbAddMilestone.ClientID%>').click(function () {
            $('#<%= dvMilestoneForm.ClientID%>').toggle(this.checked);
        }).change();

        function onEntityListPopulated() {
            var completionList = $find('<%=ae_txtApplicantName.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }
        function onFirstNamePopulated() {
            var completionList = $find('<%=ac_txtFirstName.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }
        function onLirstNamePopulated() {
            var completionList = $find('<%=ac_txtLastName.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }

        function PopulateFnameDetails(source, eventArgs) {
            //alert(' Key : ' + eventArgs.get_text() + '  Value :  ' + eventArgs.get_value());
            var addressArray = eventArgs.get_value().split(',');
            $('#<%=txtFirstName.ClientID%>').val(addressArray[0].trim());
            $('#<%=txtLastName.ClientID%>').val(addressArray[1].trim());
            $('#<%=txtEmail.ClientID%>').val(addressArray[2].trim());
        }

        function PopulateLnameDetails(source, eventArgs) {
            //alert(' Key : ' + eventArgs.get_text() + '  Value :  ' + eventArgs.get_value());
            var addressArray = eventArgs.get_value().split(',');
            $('#<%=txtFirstName.ClientID%>').val(addressArray[1].trim());
            $('#<%=txtLastName.ClientID%>').val(addressArray[0].trim());
            $('#<%=txtEmail.ClientID%>').val(addressArray[3].trim());
        }
        function SetContextKey() {
            $find('<%=ae_txtStreetNo.ClientID%>').set_contextKey($get("<%=txtStreetNo.ClientID %>").value);
        }

        function onListPopulated() {
            var completionList = $find('<%=ae_txtStreetNo.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }

        function GetAddressDetails(source, eventArgs) {
            //alert(' Key : ' + eventArgs.get_text() + '  Value :  ' + eventArgs.get_value());
            var addressArray = eventArgs.get_value().split('~');
            $('#<%=txtStreetNo.ClientID%>').val(addressArray[0]);
            $('#<%=txtAddress1.ClientID%>').val(addressArray[1]);
            $('#<%=txtAddress2.ClientID%>').val(addressArray[2]);
            $('#<%=ddlState.ClientID%>').val(addressArray[3]);
            $('#<%=txtZip.ClientID%>').val(addressArray[4]);
            $('#<%=txtTown.ClientID%>').val(addressArray[5]);
            $('#<%=txtCounty.ClientID%>').val(addressArray[6]);
            $('#<%=txtLattitude.ClientID%>').val(addressArray[7]);
            $('#<%=txtLongitude.ClientID%>').val(addressArray[8]);
        }

        $(document).ready(function () {
            $('#<%= dvProjectAddressForm.ClientID%>').toggle($('#<%= cbAddAddress.ClientID%>').is(':checked'));
            $('#<%= cbAddAddress.ClientID%>').click(function () {
                $('#<%= dvProjectAddressForm.ClientID%>').toggle(this.checked);
            }).change();


            $('#<%= txtZip.ClientID%>').blur(function () {
                getAddressInfoByZip($('#<%= txtZip.ClientID%>').val());
            });
        });

        function getLocation() {
            getAddressInfoByZip(document.forms[0].zip.value);
        }

        function response(obj) {
            console.log(obj);
        }
        function getAddressInfoByZip(zip) {
            $('#<%= txtTown.ClientID%>').val('');
             $('#<%= ddlState.ClientID%>').val('');
             $('#<%= txtCounty.ClientID%>').val('');
             if (zip.length >= 5 && typeof google != 'undefined') {
                 var addr = {};
                 var geocoder = new google.maps.Geocoder();
                 geocoder.geocode({ 'address': zip }, function (results, status) {
                     if (status == google.maps.GeocoderStatus.OK) {
                         if (results.length >= 1) {
                             for (var ii = 0; ii < results[0].address_components.length; ii++) {
                                 var street_number = route = street = city = state = zipcode = country = formatted_address = '';
                                 var types = results[0].address_components[ii].types.join(",");
                                 if (types == "street_number") {
                                     addr.street_number = results[0].address_components[ii].long_name;
                                 }
                                 if (types == "route" || types == "point_of_interest,establishment") {
                                     addr.route = results[0].address_components[ii].long_name;
                                 }
                                 if (types == "sublocality,political" || types == "locality,political" || types == "neighborhood,political" || types == "administrative_area_level_3,political") {
                                     addr.city = (city == '' || types == "locality,political") ? results[0].address_components[ii].long_name : city;
                                     $('#<%= txtTown.ClientID%>').val(addr.city);
                                }
                                if (types == "administrative_area_level_1,political") {
                                    addr.state = results[0].address_components[ii].short_name;
                                    $('#<%= ddlState.ClientID%>').val(addr.state);
                                }
                                if (types == "postal_code" || types == "postal_code_prefix,postal_code") {
                                    addr.zipcode = results[0].address_components[ii].long_name;
                                }
                                if (types == "country,political") {
                                    addr.country = results[0].address_components[ii].long_name;
                                }
                                if (types == "administrative_area_level_2,political") {
                                    addr.county = results[0].address_components[ii].short_name;
                                    $('#<%= txtCounty.ClientID%>').val(addr.county.replace('County', ''));
                            }
                        }
                        addr.success = true;
                        $('#<%= txtLattitude.ClientID%>').val(results[0].geometry.location.lat());
                            $('#<%= txtLongitude.ClientID%>').val(results[0].geometry.location.lng());
                            for (name in addr) {
                                console.log('### google maps api ### ' + name + ': ' + addr[name]);
                            }
                            response(addr);
                        } else {
                            response({ success: false });
                        }
                    } else {
                        response({ success: false });
                    }
                });
            } else {
                response({ success: false });
            }
        }

        <%-- function onApplicantListPopulated() {
            var completionList = $find('<%=EntityAE.ClientID%>').get_completionList();
                    completionList.style.width = 'auto';
                }--%>
    </script>
</asp:Content>
