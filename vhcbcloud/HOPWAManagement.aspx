<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HOPWAManagement.aspx.cs"
    Inherits="vhcbcloud.HOPWAManagement" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">HOPWA Maintenance </p>
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
                            <td style="text-align: right;">
                                <asp:ImageButton ID="btnProjectNotes1" Visible="false" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
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

                <div class="panel-width" runat="server" id="dvHOPWAMaster" visible="true">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Individual Data</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAMaster" runat="server" Text="Add New UUID" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHOPWAMasterForm">
                            <asp:Panel runat="server" ID="pnlHOPWAMaster">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">UUID</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtUUID" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Primary ASO</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlPrimaryASO" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">HH Includes</span></td>
                                        <td>
                                            <asp:TextBox ID="txtHHIncludes" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass"># with HIV</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtWithHIV" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass"># in Household</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtInHouseHold" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"># of Minors (<18)</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMinors" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Gender</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtGender" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Age</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtAge" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Ethnicity</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlEthnicity" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Race</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlRace" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">GMI</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlGMI" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">% AMI</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlAMI" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass"># Beds</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtBeds" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Active</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:CheckBox ID="cbHOPWAMaster" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Notes</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Button ID="btnHOPWAMaster" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnHOPWAMaster_Click" /></td>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHOPWAMasterGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAMaster" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvHOPWAMaster_RowEditing" OnRowCancelingEdit="gvHOPWAMaster_RowCancelingEdit"
                                    OnRowDataBound="gvHOPWAMaster_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAID" runat="Server" Text='<%# Eval("HOPWAID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectHOPWAMaster" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectHOPWAMaster_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenHOPWAID" runat="server" Value='<%#Eval("HOPWAID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UUID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUUID" runat="Server" Text='<%# Eval("UUID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Primary ASO">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrimaryASO" runat="Server" Text='<%# Eval("PrimaryASOST") %>' />
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

                <div class="panel-width" runat="server" id="dvNewHOPWARace" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">HouseHold Members Race</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWARace" runat="server" Text="Add another HH Member" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWARACEForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 93px"><span class="labelClass">Race</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHOPWARace" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 126px"><span class="labelClass">Household #</span></td>
                                        <td class="modal-sm" style="width: 77px">
                                            <asp:TextBox ID="txtHOPWAHousehold" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="4"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddRace" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddRace_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWARaceGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel2" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWARace" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvHOPWARace_RowEditing" OnRowCancelingEdit="gvHOPWARace_RowCancelingEdit"
                                    OnRowUpdating="gvHOPWARace_RowUpdating" OnRowDataBound="gvHOPWARace_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWARaceID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWARaceID" runat="Server" Text='<%# Eval("HOPWARaceID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Race">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRace" runat="Server" Text='<%# Eval("RaceName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlHOPWARace1" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtRaceId" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Race") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="500px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Household #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHousehold" runat="Server" Text='<%# Eval("HouseholdNum") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtHouseHold1" runat="Server" CssClass="clsTextBoxBlueSm" MaxLength="4"
                                                    Text='<%# Eval("HouseholdNum") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="300px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="250px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewHOPWAEthnicity" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">HouseHold Members Ethnicity</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAEthnicity" runat="server" Text="Add another Ethnicity" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWAEthnicityForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 93px"><span class="labelClass">Ethnicity</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHOPWAEthnicity" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 126px"><span class="labelClass">Household #</span></td>
                                        <td class="modal-sm" style="width: 77px">
                                            <asp:TextBox ID="txtHOPWAEthnicityHH" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="4"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddEthnicity" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEthnicity_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWAEthnicityGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAEthnicity" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvHOPWAEthnicity_RowEditing" OnRowCancelingEdit="gvHOPWAEthnicity_RowCancelingEdit"
                                    OnRowUpdating="gvHOPWAEthnicity_RowUpdating" OnRowDataBound="gvHOPWAEthnicity_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAEthnicID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAEthnicID" runat="Server" Text='<%# Eval("HOPWAEthnicID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Ethnicity">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEthnic" runat="Server" Text='<%# Eval("EthnicName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlHOPWAEthnicity1" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtEthnicId" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Ethnic") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="500px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Household #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEthnicNum" runat="Server" Text='<%# Eval("EthnicNum") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEthnicHH1" runat="Server" CssClass="clsTextBoxBlueSm" MaxLength="4"
                                                    Text='<%# Eval("EthnicNum") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="300px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="250px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton14" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton15" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewHOPWAAge" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Gender by Age</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAAge" runat="server" Text="Add another Age/Gender" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWAAgeForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 93px"><span class="labelClass">AgeGender</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAgeGender" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 46px"><span class="labelClass">Number</span></td>
                                        <td class="modal-sm" style="width: 77px">
                                            <asp:TextBox ID="txtAgeNum" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="4"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddAge" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAge_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWAAgeGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAAge" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvHOPWAAge_RowEditing" OnRowCancelingEdit="gvHOPWAAge_RowCancelingEdit"
                                    OnRowUpdating="gvHOPWAAge_RowUpdating" OnRowDataBound="gvHOPWAAge_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAAgeId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAAgeId" runat="Server" Text='<%# Eval("HOPWAAgeId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="AgeGender">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAgeGender" runat="Server" Text='<%# Eval("AgeGenderName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlHOPWAAgeGender1" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtAgeGenderId" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("GenderAgeID") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="500px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGANum" runat="Server" Text='<%# Eval("GANum") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAgeNum1" runat="Server" CssClass="clsTextBoxBlueSm" MaxLength="4"
                                                    Text='<%# Eval("GANum") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="300px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="250px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton14" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton15" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <asp:HiddenField ID="hfHOPWAId" runat="server" />
    </div>
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvHOPWAMasterForm.ClientID%>').toggle($('#<%= cbAddHOPWAMaster.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWAMaster.ClientID%>').click(function () {
                $('#<%= dvHOPWAMasterForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWARACEForm.ClientID%>').toggle($('#<%= cbAddHOPWARace.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWARace.ClientID%>').click(function () {
                $('#<%= dvHOPWARACEForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWAEthnicityForm.ClientID%>').toggle($('#<%= cbAddHOPWAEthnicity.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWAEthnicity.ClientID%>').click(function () {
                $('#<%= dvHOPWAEthnicityForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWAAgeForm.ClientID%>').toggle($('#<%= cbAddHOPWAAge.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWAAge.ClientID%>').click(function () {
                $('#<%= dvHOPWAAgeForm.ClientID%>').toggle(this.checked);
            }).change();
            //Input Validation
            $('#<%= txtHOPWAHousehold.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtHOPWAHousehold.ClientID%>').val(), $('#<%= txtHOPWAHousehold.ClientID%>'));
            });

            $("input[id*=txtHouseHold1]").keyup(function () {
                toNumericControl($('input[id*=txtHouseHold1]').val(), $('input[id*=txtHouseHold1]'));
            });

            $('#<%= txtHOPWAEthnicityHH.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtHOPWAEthnicityHH.ClientID%>').val(), $('#<%= txtHOPWAEthnicityHH.ClientID%>'));
            });

            $("input[id*=txtEthnicHH1]").keyup(function () {
                toNumericControl($('input[id*=txtEthnicHH1]').val(), $('input[id*=txtEthnicHH1]'));
            });

             $('#<%= txtAgeNum.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtAgeNum.ClientID%>').val(), $('#<%= txtAgeNum.ClientID%>'));
            });

            $("input[id*=txtAgeGenderId1]").keyup(function () {
                toNumericControl($('input[id*=txtAgeGenderId1]').val(), $('input[id*=txtAgeGenderId1]'));
            });

        });

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvHOPWAMaster.ClientID%>");
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

