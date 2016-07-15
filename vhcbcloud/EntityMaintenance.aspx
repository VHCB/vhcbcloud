<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EntityMaintenance.aspx.cs" Inherits="vhcbcloud.EntityMaintenance" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Entity (Organization / Individual) </p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                     <table style="width: 100%;">
                        <tr style="float: left">
                            <td>
                                <asp:RadioButtonList ID="rdBtnAction" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="rdBtnAction_SelectedIndexChanged">
                                    <asp:ListItem>New</asp:ListItem>
                                    <asp:ListItem Selected="True">Existing</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                              <td style="text-align: right;">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
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
                            <td style="width: 170px"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                    </table>
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
                                            <span class="labelClass">Type</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlEntityType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Name</span></td>
                                        <td>
                                            <asp:TextBox ID="txtApplicantName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
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

                <div class="panel-width" runat="server" id="dvIndividual">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                            <h3 class="panel-title">Individual</h3>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px">
                            <asp:Panel runat="server" ID="pnlIndividualForm">
                                <table style="width: 100%">
                                    <tr>
                                        <td><span class="labelClass">First Name</span></td>
                                        <td>
                                            <asp:TextBox ID="txtFirstName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td>
                                            <span class="labelClass">Last Name</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLastName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass">Position</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlPosition" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Title</span></td>
                                        <td>
                                            <asp:TextBox ID="txtTitle" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td>
                                            <span class="labelClass">Email</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmail" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass"></span></td>
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
                                            <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">County</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtCounty" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">State</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtState" CssClass="clsTextBoxBlue1" runat="server" MaxLength="2"></asp:TextBox>
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
                                        <td style="width: 150px"><span class="labelClass"></span></td>
                                        <td style="width: 250px">
                                            
                                        </td>
                                        <td><span class="labelClass"></span></td>
                                        <td>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px">
                                            <asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" /></td>
                                        <td style="width: 250px"></td>
                                        <td style="width: 150px"></td>
                                        <td style="width: 250px"></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
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
                                         <asp:TemplateField HeaderText="Address Type">
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

                <asp:HiddenField ID="hfVillage" runat="server" />
                <asp:HiddenField ID="hfApplicatId" runat="server" />
                <asp:HiddenField ID="hfAddressId" runat="server" />
                <asp:HiddenField ID="hfFarmId" runat="server" />
            </div>
        </div>
    </div>

    <script language="javascript" src="https://maps.google.com/maps/api/js?key=AIzaSyCm3xOguaZV1P3mNL0ThK7nv-H9jVyMjSU"></script>
    <script language="javascript">
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
            $('#<%=txtState.ClientID%>').val(addressArray[3]);
            $('#<%=txtZip.ClientID%>').val(addressArray[4]);
            $('#<%=txtTown.ClientID%>').val(addressArray[5]);
            $('#<%=txtCounty.ClientID%>').val(addressArray[6]);
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
            $('#<%= txtState.ClientID%>').val('');
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
                                    $('#<%= txtState.ClientID%>').val(addr.state);
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
    </script>
</asp:Content>
