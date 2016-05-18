﻿<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HousingUnitsServices.aspx.cs"
    Inherits="vhcbcloud.Housing.HousingUnitsServices" MaintainScrollPositionOnPostback="true" %>

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
                            <td><span class="labelClass">Project #</span></td>
                            <td>
                                <span class="labelClass" id="ProjectNum" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Name</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="ProjName" runat="server"></span>
                            </td>
                            <td></td>
                            <td style="text-align: right">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>

                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Housing Type</span></td>
                            <td>
                                <asp:DropDownList ID="ddlHousingType" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlHousingType_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td><span class="labelClass">Total Units</span></td>
                            <td>
                                <asp:TextBox ID="txtTotalUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>

                            <td><span class="labelClass">Gross Living Space:</span></td>
                            <td>
                                <asp:TextBox ID="txtGrossLivingSpace" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Units from previous project:</span></td>
                            <td>
                                <asp:TextBox ID="txtUnitsFromPreProject" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">Net NEW Units:</span></td>
                            <td>
                                <asp:TextBox ID="txtNetNewUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">Units released from Covenant:</span></td>
                            <td>
                                <asp:TextBox ID="txtUnitsRelFromCov" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Restrictions Release Date</span></td>
                            <td>
                                <asp:TextBox ID="txtRestrictionsReleaseDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtGrantExpirationDate" TargetControlID="txtRestrictionsReleaseDate">
                                </ajaxToolkit:CalendarExtender>
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" /></td>
                            <td></td>
                            <td></td>
                            <td style="height: 5px"></td>
                        </tr>
                    </table>
                </div>
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvNewHousingSubType">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Housing SubType(s)</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHousingSubType" runat="server" Text="Add New Housing SubType" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHousingSubTypeForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Housing SubType</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHousingSubType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtHousingSubTypeUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddHousingSubType" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddHousingSubType_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHousingSubTypeGrid" runat="server">
                            <div id="dvSubTypeWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblSubTypeWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHousingSubType" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvHousingSubType_RowEditing" OnRowCancelingEdit="gvHousingSubType_RowCancelingEdit" OnRowUpdating="gvHousingSubType_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HousingTypeID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHousingTypeID" runat="Server" Text='<%# Eval("HousingTypeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="House Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHouseType" runat="Server" Text='<%# Eval("HouseType") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnits" runat="Server" Text='<%# Eval("Units") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtUnits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Units") %>'></asp:TextBox>
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

                <div class="panel-width" runat="server" id="dvNewSingle">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Single Unit Types</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddSingleUnit" runat="server" Text="Add New Single Unit Type" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvSingleForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Characteristic</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlSingleUnitCharacteristic" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtSingleUnitNumUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddSingleUnitCharacteristic" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddSingleUnitCharacteristic_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvSingleGrid" runat="server">
                            <div id="dvSingleUnitWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblSingleUnitWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvSingle" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvSingle_RowEditing" OnRowCancelingEdit="gvSingle_RowCancelingEdit" OnRowUpdating="gvSingle_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectSingleCountID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectSingleCountID" runat="Server" Text='<%# Eval("ProjectSingleCountID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Characteristic">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCharacteristic" runat="Server" Text='<%# Eval("Characteristic") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumunits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterSingleUnitTotalUnits" Text=""></asp:Label>
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

                <div class="panel-width" runat="server" id="dvNewMultiple">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Multi Unit Types</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMultiUnit" runat="server" Text="Add New Multi Unit Type" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMultipleForm">
                            <asp:Panel runat="server" ID="Panel4">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Characteristic</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlMultipleUnitCharacteristic" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtMultiUnitNumUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddMultiUnitCharacteristic" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddMultiUnitCharacteristic_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvMultipleGrid" runat="server">
                            <%--<div id="dvMultiUnitWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblMultiUnitWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>--%>
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMultiple" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvMultiple_RowEditing" OnRowCancelingEdit="gvMultiple_RowCancelingEdit" OnRowUpdating="gvMultiple_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectMultiCountID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectMultiCountID" runat="Server" Text='<%# Eval("ProjectMultiCountID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Characteristic">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCharacteristic" runat="Server" Text='<%# Eval("Characteristic") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumunits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterMultiUnitTotalUnits" Text=""></asp:Label>
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

                <div class="panel-width" runat="server" id="dvNewSuppServices">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Supplemental Services</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddSuppService" runat="server" Text="Add New Supplemental Service" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvSuppServiceForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Service</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlSuppService" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtSuppServiceUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddSuppServices" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddSuppServices_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvSuppServiceGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvSuppService" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvSuppService_RowEditing" OnRowCancelingEdit="gvSuppService_RowCancelingEdit" OnRowUpdating="gvSuppService_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectSuppServID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectSuppServID" runat="Server" Text='<%# Eval("ProjectSuppServID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Service">
                                            <ItemTemplate>
                                                <asp:Label ID="lblService" runat="Server" Text='<%# Eval("Service") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumunits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtSuppServiceNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterSuppServiceTotalUnits" Text=""></asp:Label>
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

                <div class="panel-width" runat="server" id="dvNewVHCBAff">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">VHCB Affordability</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddVHCBAff" runat="server" Text="Add New VHCB Affordability" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvVHCBAffForm">
                            <asp:Panel runat="server" ID="Panel9">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">VHCB</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlVHCBAff" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtVHCBUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddVHCBAff" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddVHCBAff_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvVHCBAffGrid" runat="server">
                            <div id="dvVHCBUnitWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblVHCBUnitWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel10" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvVHCBAff" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvVHCBAff_RowEditing" OnRowCancelingEdit="gvVHCBAff_RowCancelingEdit" OnRowUpdating="gvVHCBAff_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectVHCBAffordUnitsID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectVHCBAffordUnitsID" runat="Server" Text='<%# Eval("ProjectVHCBAffordUnitsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VHCB">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCB" runat="Server" Text='<%# Eval("VHCB") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCBNumunits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtVHCBNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterVHCBTotalUnits" Text=""></asp:Label>
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

                <div class="panel-width" runat="server" id="dvNewHomeAff">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Home Affordability</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHomeAff" runat="server" Text="Add New Home Affordability" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHomeAffForm">
                            <asp:Panel runat="server" ID="Panel11">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Home</span></td>
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
                                                OnClick="btnAddHomeAff_Click"/></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHomeAffGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel12" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvNewHomeAff" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                     OnRowEditing="gvNewHomeAff_RowEditing" OnRowCancelingEdit="gvNewHomeAff_RowCancelingEdit" OnRowUpdating="gvNewHomeAff_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectHomeAffordUnitsID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectHomeAffordUnitsID" runat="Server" Text='<%# Eval("ProjectHomeAffordUnitsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Home">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCB" runat="Server" Text='<%# Eval("Home") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
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
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfHousingID" runat="server" />
    <asp:HiddenField ID="hfTotalUnitsFromDB" runat="server" />
    <asp:HiddenField ID="hfSubTypeWarning" runat="server" />
    <asp:HiddenField ID="hfSingleUnitWarning" runat="server" />
    <asp:HiddenField ID="hfVHCBUnitWarning" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= txtTotalUnits.ClientID%>').blur(function () {
                CalculateNewUnits();
            });
            $('#<%= txtUnitsFromPreProject.ClientID%>').blur(function () {
                CalculateNewUnits();
            });

            $('#<%= dvHousingSubTypeForm.ClientID%>').toggle($('#<%= cbAddHousingSubType.ClientID%>').is(':checked'));

            $('#<%= cbAddHousingSubType.ClientID%>').click(function () {
                $('#<%= dvHousingSubTypeForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvSingleForm.ClientID%>').toggle($('#<%= cbAddSingleUnit.ClientID%>').is(':checked'));

            $('#<%= cbAddSingleUnit.ClientID%>').click(function () {
                $('#<%= dvSingleForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvMultipleForm.ClientID%>').toggle($('#<%= cbAddMultiUnit.ClientID%>').is(':checked'));

            $('#<%= cbAddMultiUnit.ClientID%>').click(function () {
                $('#<%= dvMultipleForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvSuppServiceForm.ClientID%>').toggle($('#<%= cbAddSuppService.ClientID%>').is(':checked'));

            $('#<%= cbAddSuppService.ClientID%>').click(function () {
                $('#<%= dvSuppServiceForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvVHCBAffForm.ClientID%>').toggle($('#<%= cbAddVHCBAff.ClientID%>').is(':checked'));

            $('#<%= cbAddVHCBAff.ClientID%>').click(function () {
                $('#<%= dvVHCBAffForm.ClientID%>').toggle(this.checked);
            }).change();

             $('#<%= dvHomeAffForm.ClientID%>').toggle($('#<%= cbAddHomeAff.ClientID%>').is(':checked'));

            $('#<%= cbAddHomeAff.ClientID%>').click(function () {
                $('#<%= dvHomeAffForm.ClientID%>').toggle(this.checked);
            }).change();
        });

        function CalculateNewUnits() {
            var TotalUnits = parseInt($('#<%=txtTotalUnits.ClientID%>').val(), 10);
            var UnitsFromPreProject = parseInt($('#<%=txtUnitsFromPreProject.ClientID%>').val(), 10);

            var NewUnits = TotalUnits - UnitsFromPreProject;
            $('#<%= txtNetNewUnits.ClientID%>').val(NewUnits);
        };
    </script>
</asp:Content>
