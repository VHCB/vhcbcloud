<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Entity.aspx.cs" Inherits="vhcbcloud.Entity" %>


<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Entity (Organization / Individual) </p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table>
                        <tr style="float: left">
                            <td></td>
                            <td>
                                <asp:RadioButtonList ID="rdBtnIndividual" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnIndividual_SelectedIndexChanged">
                                    <asp:ListItem>New    </asp:ListItem>
                                    <asp:ListItem Selected="True">Existing</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                    </table>
                </div>
                <div id="dvExistingSearch" runat="server">
                    <table>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 100px"><span class="labelClass">Entity Name</span></td>
                            <td style="width: 170px">
                                <%-- <asp:TextBox ID="txtApplicantNameSearch" CssClass="clsTextBoxBlue1" runat="server" Width="200px"></asp:TextBox>
                              <ajaxToolkit:AutoCompleteExtender ID="aceApplicantName" runat="server" TargetControlID="txtApplicantNameSearch" MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1"
                            CompletionInterval="100" ServiceMethod="GetApplicantName">
                        </ajaxToolkit:AutoCompleteExtender>--%>
                                <asp:DropDownList ID="ddlApplicantNameSearch" CssClass="clsDropDown" runat="server" OnSelectedIndexChanged="ddlApplicantNameSearch_SelectedIndexChanged" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:HiddenField ID="hfApplicatId" runat="server" />
                            </td>
                            <td style="width: 2px">
                                <%--<asp:Button ID="btnApplicantSearch" runat="server" Text="Search" class="btn btn-info" OnClick="btnApplicantSearch_Click" />--%>
                                <%-- <button id="btnApplicantSearch" runat="server"  class="btn btn-info">
                                    <span class="glyphicon glyphicon-search"></span>Search
                                </button>--%>
                            </td>
                            <td style="width: 270px"></td>
                            <td style="width: 170px"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvCommonForm">
                    <div class="panel panel-default">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Entity (Organization / Individual) </h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="pnlCommonForm">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Individual</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbInd" CssClass="ChkBox" runat="server" Text="Yes" />
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Type</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlEntityType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Name</span></td>
                                        <td>
                                            <asp:TextBox ID="txtApplicantName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Fiscal Yr End</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtFiscalYearEnd" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Website</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtWebsite" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">State Vendor ID</span></td>
                                        <td>
                                            <asp:TextBox ID="txtStateVendorId" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Phone Type</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlPhoneType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Phone</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtPhone" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:MaskedEditExtender runat="server" ID="amePhoneNumber" Mask="(999)999-9999" ClearMaskOnLostFocus="false"
                                                MaskType="Number" TargetControlID="txtPhone">
                                            </ajaxToolkit:MaskedEditExtender>
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
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvIndividual">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Individual</h3>
                        </div>

                        <div class="panel-body">
                            <asp:Panel runat="server" ID="pnlIndividualForm">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px">First Name</td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtFirstName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Last Name</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtLastName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Position</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlPosition" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px">Title</td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtTitle" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Email</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtEmail" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
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

                <div class="panel-width" runat="server" id="dvAddress">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Address</h3>
                        </div>

                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Address1:</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Address2</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="5"></asp:TextBox>

                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Town</span>
                                        </td>
                                        <td style="width: 270px">
                                            <%--<asp:DropDownList ID="ddlTown" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>--%>
                                            <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">County</span></td>
                                        <td>
                                            <asp:TextBox ID="txtCounty" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                            <%-- <asp:DropDownList ID="ddlCounty" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>--%>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">State</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtState" CssClass="clsTextBoxBlue1" runat="server" MaxLength="2"></asp:TextBox>
                                        </td>
                                        <td style="width: 150px"><span class="labelClass">Address Type</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlAddressType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbIsActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Default Address?</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbIsDefault" CssClass="ChkBox" runat="server" Text="Yes" />
                                        </td>
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
                            <div id="dvAddressButton" runat="server">
                                <table>
                                    <tr>
                                        <td style="height: 5px">&nbsp;&nbsp;&nbsp;</td>
                                        <td style="height: 5px">
                                            <asp:Button ID="btnAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddress_Click" />
                                            &nbsp;&nbsp;<asp:Button ID="btnAddressCancel" runat="server" Text="Cancel" class="btn btn-info" OnClick="btnAddressCancel_Click" />
                                            <asp:HiddenField ID="hfAddressId" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-body" id="dvAddressGrid" runat="server">
                    <asp:Panel runat="server" ID="pnlGrid" Width="100%" Height="150px" ScrollBars="Vertical">
                        <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" OnRowCancelingEdit="gvAddress_RowCancelingEdit" OnRowDataBound="gvAddress_RowDataBound" OnRowEditing="gvAddress_RowEditing">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="Address Id" Visible="false" SortExpression="AddressId">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAddressId" runat="Server" Text='<%# Eval("AddressId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Street #">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStreetNo" runat="Server" Text='<%# Eval("Street#") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Address1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAddress1" runat="Server" Text='<%# Eval("Address1") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Town">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTown" runat="Server" Text='<%# Eval("Town") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="State">
                                    <ItemTemplate>
                                        <asp:Label ID="lblState" runat="Server" Text='<%# Eval("State") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Defaddress">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDefaddress" runat="Server" Text='<%# Eval("Defaddress") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" UpdateText="" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                <div id="dvSubmit" runat="server">
                    <table>
                        <tr>
                            <td style="height: 5px">&nbsp;&nbsp;&nbsp;</td>
                            <td style="height: 5px">
                                <asp:Button ID="btnAddAddress" runat="server" Text="Add Address" class="btn btn-info" OnClick="btnAddAddress_Click" /></td>
                            <td style="height: 5px">&nbsp;&nbsp;</td>
                            <td style="height: 5px">
                                <asp:Button ID="btnEntitySubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnEntitySubmit_Click" />
                            </td>



                        </tr>
                        <tr>
                            <td style="height: 10px"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script language="javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
    <script language="javascript">
        $(document).ready(function () {
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
    <script type="text/javascript">

        $('#<%= txtFirstName.ClientID %>').bind('keypress keyup blur', function () {
            $('#<%= txtApplicantName.ClientID %>').val($(this).val());
        });

        $('#<%= txtLastName.ClientID %>').bind('keypress keyup blur', function () {
            $('#<%= txtApplicantName.ClientID %>').val($(this).val() + ', ' + $('#<%= txtFirstName.ClientID %>').val());
        });

        if (!$('#<%= cbInd.ClientID %>').is(":checked")) {
            $('#<%= dvIndividual.ClientID %>').hide();
        }

        $('#<%= cbInd.ClientID %>').click(function () {
            if ($('#<%= cbInd.ClientID %>').is(":checked")) {
                 $('#<%= txtApplicantName.ClientID %>')
                .attr("disabled", "disabled")
                //.css("background-color", "#DDDDDD");

                $('#<%= dvIndividual.ClientID %>').show();
            }
            else {
                $('#<%= txtApplicantName.ClientID %>')
                   .removeAttr("disabled")
                //.css("background-color", "white");

                $('#<%= dvIndividual.ClientID %>').hide();
                $('#<%= txtApplicantName.ClientID %>').val("");
                $('#<%= txtFirstName.ClientID %>').val("");
                $('#<%= txtLastName.ClientID %>').val("");
            }
         });
    </script>
</asp:Content>

