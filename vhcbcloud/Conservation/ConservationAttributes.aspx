<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConservationAttributes.aspx.cs" MasterPageFile="~/Site.Master"
    MaintainScrollPositionOnPostback="true" Inherits="vhcbcloud.Conservation.ConservationAttributes" %>


<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
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
                            <td style="text-align: right">
                                 <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" 
                                    Style="border: none; vertical-align: middle;" runat="server" Text="Project Search"
                                    OnClientClick="window.location.href='../ProjectSearch.aspx'; return false;"></asp:ImageButton>
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" Text="Award Summary" Style="border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" Text="Project Notes" Style="border: none; vertical-align: middle;" />
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
                                        <asp:TemplateField HeaderText="Conserve Attrib ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveAttribID" runat="Server" Text='<%# Eval("ConserveAttribID") %>' />
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

                <div class="panel-width" runat="server" id="dvNewAffordability">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Affordability Mechanisms</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAffMechanism" runat="server" Text="Add New Affordability Mechanism" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvAffordabilityForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Affordability Mechanism:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAffordability" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddAffordability" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAffordability_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvAffordabilityGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel2" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAffordability" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvAffordability_RowEditing" OnRowCancelingEdit="gvAffordability_RowCancelingEdit"
                                    OnRowUpdating="gvAffordability_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConserveAffmechID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveAffmechID" runat="Server" Text='<%# Eval("ConserveAffmechID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Affordability Mechanism">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAffordabilityMechanism" runat="Server" Text='<%# Eval("AffordabilityMechanism") %>' />
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

                <div class="panel-width" runat="server" id="dvNewPA">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Type of Public Access</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddPA" runat="server" Text="Add New Type of Public Access" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvPAForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Type of Public Access:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlPA" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddPA" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddPA_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvPAGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvPA" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvPA_RowEditing" OnRowCancelingEdit="gvPA_RowCancelingEdit" OnRowUpdating="gvPA_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConservePAcessID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConservePAcessID" runat="Server" Text='<%# Eval("ConservePAcessID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type of Public Access">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPublicAccess" runat="Server" Text='<%# Eval("PublicAccess") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
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

                <div class="panel-width" runat="server" id="dvNewAltEnergy">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Alternative Energy</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAltEnergy" runat="server" Text="Add New Alternative Energy" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvAltEnergyForm">
                            <asp:Panel runat="server" ID="Panel5">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Alternative Energy:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAltEnergy" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddAltEnergy" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAltEnergy_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvAltEnergyGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel6" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAltEnergy" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvAltEnergy_RowEditing" OnRowCancelingEdit="gvAltEnergy_RowCancelingEdit" OnRowUpdating="gvAltEnergy_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConsserveAltEnergyID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConsserveAltEnergyID" runat="Server" Text='<%# Eval("ConsserveAltEnergyID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Alternative Energy">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAlternativeEnergy" runat="Server" Text='<%# Eval("AlternativeEnergy") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
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

                <%--<div class="panel-width" runat="server" id="dvNewBuffer">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Buffers</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddBuffer" runat="server" Text="Add New Buffer Type" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvBufferForm">
                            <asp:Panel runat="server" ID="Panel7">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Buffer Type:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlBufferType" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddBuffer" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddBuffer_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvBufferGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel10" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvBuffer" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvBuffer_RowEditing" OnRowCancelingEdit="gvBuffer_RowCancelingEdit" OnRowUpdating="gvBuffer_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConserveBufferID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveBufferID" runat="Server" Text='<%# Eval("ConserveBufferID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Buffer Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBufferType" runat="Server" Text='<%# Eval("BufferType") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
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
                </div>--%>

                <div class="panel-width" runat="server" id="dvNewOT">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Owner Types</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddOT" runat="server" Text="Add New Owner Type" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvOTForm">
                            <asp:Panel runat="server" ID="Panel11">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Owner Type:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlOT" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddOT" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddOT_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvOTGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel12" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvOT" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvOT_RowEditing" OnRowCancelingEdit="gvOT_RowCancelingEdit" OnRowUpdating="gvOT_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConserveOTypeID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveOTypeID" runat="Server" Text='<%# Eval("ConserveOTypeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Owner Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblOwnerType" runat="Server" Text='<%# Eval("OwnerType") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
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

                <div class="panel-width" runat="server" id="dvNewLegalInterest">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Legal Interest</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddLegalInterest" runat="server" Text="Add New Legal Interest" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvLegalInterestForm">
                            <asp:Panel runat="server" ID="Panel13">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Legal Interest:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlLegalInterest" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddLegalInterest" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddLegalInterest_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvLegalInterestGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel14" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvLegalInterest" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvLegalInterest_RowEditing" OnRowCancelingEdit="gvLegalInterest_RowCancelingEdit" OnRowUpdating="gvLegalInterest_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConserveLegInterestID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveLegInterestID" runat="Server" Text='<%# Eval("ConserveLegInterestID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Legal Interest">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLegalInterest" runat="Server" Text='<%# Eval("LegalInterest") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
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

                <div class="panel-width" runat="server" id="dvNewLegalMechanism">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Legal Mechanism</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddLegalMechanism" runat="server" Text="Add New Legal Mechanism" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvLegalMechanismForm">
                            <asp:Panel runat="server" ID="Panel15">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Legal Mechanism:</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlLegalMechanism" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddLegalMechanism" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddLegalMechanism_Click" />
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

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvLegalMechanismGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel16" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvLegalMechanism" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvLegalMechanism_RowEditing" OnRowCancelingEdit="gvLegalMechanism_RowCancelingEdit" OnRowUpdating="gvLegalMechanism_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ConserveLegMechID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveLegMechID" runat="Server" Text='<%# Eval("ConserveLegMechID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Legal Mechanism">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLegalMechanism" runat="Server" Text='<%# Eval("LegalMechanism") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="500px" />
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
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfConserveId" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvAttributeForm.ClientID%>').toggle($('#<%= cbAddAttribute.ClientID%>').is(':checked'));

            $('#<%= cbAddAttribute.ClientID%>').click(function () {
                $('#<%= dvAttributeForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvAffordabilityForm.ClientID%>').toggle($('#<%= cbAddAffMechanism.ClientID%>').is(':checked'));
            $('#<%= cbAddAffMechanism.ClientID%>').click(function () {
                $('#<%= dvAffordabilityForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvPAForm.ClientID%>').toggle($('#<%= cbAddPA.ClientID%>').is(':checked'));
            $('#<%= cbAddPA.ClientID%>').click(function () {
                $('#<%= dvPAForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvAltEnergyForm.ClientID%>').toggle($('#<%= cbAddAltEnergy.ClientID%>').is(':checked'));
            $('#<%= cbAddAltEnergy.ClientID%>').click(function () {
                $('#<%= dvAltEnergyForm.ClientID%>').toggle(this.checked);
            }).change();

           <%-- $('#<%= dvBufferForm.ClientID%>').toggle($('#<%= cbAddBuffer.ClientID%>').is(':checked'));
            $('#<%= cbAddBuffer.ClientID%>').click(function () {
                $('#<%= dvBufferForm.ClientID%>').toggle(this.checked);
            }).change();--%>

            $('#<%= dvOTForm.ClientID%>').toggle($('#<%= cbAddOT.ClientID%>').is(':checked'));
            $('#<%= cbAddOT.ClientID%>').click(function () {
                $('#<%= dvOTForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvLegalInterestForm.ClientID%>').toggle($('#<%= cbAddLegalInterest.ClientID%>').is(':checked'));
            $('#<%= cbAddLegalInterest.ClientID%>').click(function () {
                $('#<%= dvLegalInterestForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvLegalMechanismForm.ClientID%>').toggle($('#<%= cbAddLegalMechanism.ClientID%>').is(':checked'));
            $('#<%= cbAddLegalMechanism.ClientID%>').click(function () {
                $('#<%= dvLegalMechanismForm.ClientID%>').toggle(this.checked);
            }).change();

        });


        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>
