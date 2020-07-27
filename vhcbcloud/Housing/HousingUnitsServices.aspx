<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HousingUnitsServices.aspx.cs"
    Inherits="vhcbcloud.Housing.HousingUnitsServices" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <!--  Tabs -->
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
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Housing Type</span></td>
                            <td>
                                <asp:DropDownList ID="ddlHousingType" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlHousingType_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td><span class="labelClass">Units from previous project:</span></td>
                            <td><asp:TextBox ID="txtUnitsFromPreProject" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                
                            </td>

                            <td><span class="labelClass">New Units:</span></td>
                            <td>
                                <asp:TextBox ID="txtNetNewUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Units Removed from Inventory</span></td>
                            <td>
                                <asp:TextBox ID="txtUnitsRemoved" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">Total Units</span></td>
                            <td><span class="labelClass" id="spnTotalUnits" runat="server">0</span>
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
                            <td><span class="labelClass">SASH</span></td>
                            <td>
                                <asp:CheckBox ID="chkSash" runat="server" />
                            </td>
                            <td><span class="labelClass">MHIP</span></td>
                            <td>
                               <asp:TextBox ID="txtMHIP" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">Federal Program Units</span></td>
                            <td>
                               <span class="labelClass" id="snFederalProgramUnits" runat="server"></span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Service Supported Units</span></td>
                            <td><asp:TextBox ID="txtSSUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>
                             <td><span class="labelClass">Total VHCB Affordable Units</span></td>
                            <td>
                                <span class="labelClass" id="spnVHCBAffUnits" runat="server">0</span>
                            </td>
                            <td><span class="labelClass"># of Buildings</span></td>
                            <td><asp:TextBox ID="txtBuildings" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Previous Affordable Units</span></td>
                            <td><asp:TextBox ID="txtPrevAffordUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>
                             <td><span class="labelClass">New Affordable Units</span></td>
                            <td>
                                <asp:TextBox ID="txtNewAffordUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr>
                            <td colspan="5">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" /></td>
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

                <div class="panel-width" runat="server" id="dvNewHousingSubType">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">SubType(s)</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHousingSubType" runat="server" Text="Add New Housing SubType" />
                                        <asp:ImageButton ID="ImgHousingSubType" ImageUrl="~/Images/print.png" ToolTip="Housing Subtypes Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgHousingSubType_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHousingSubTypeForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">SubType</span></td>
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
                                        <asp:TemplateField HeaderText="Sub Type">
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvTaxCredit">
                            <div class="panel panel-default" style="margin-bottom: 2px;">
                                <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Tax Credit</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:CheckBox ID="cbAddTaxCredit" runat="server" Text="Add New Tax Credit" />
                                                <asp:ImageButton ID="ImgTaxCredit" ImageUrl="~/Images/print.png" ToolTip="Tax Credit Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgTaxCredit_Click" />
                                    
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvTaxCreditForm">
                                    <asp:Panel runat="server" ID="Panel19">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 240px"><span class="labelClass">Tax Credit</span></td>
                                                <td style="width: 215px">
                                                    <asp:DropDownList ID="ddlTaxCredit" CssClass="clsDropDownLong" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px"></td>
                                                <td style="width: 180px">
                                                    <asp:Button ID="btnAddTaxCredit" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddTaxCredit_Click" />

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

                                <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvTaxCreditGrid" runat="server">
                                    <asp:Panel runat="server" ID="Panel20" Width="100%" Height="100px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvTaxCredit" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                            OnRowEditing="gvTaxCredit_RowEditing" 
                                            OnRowCancelingEdit="gvTaxCredit_RowCancelingEdit" 
                                            OnRowUpdating="gvTaxCredit_RowUpdating">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="ProjectHouseTaxCredits" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProjectHouseTaxCreditsID" runat="Server" Text='<%# Eval("ProjectHouseTaxCredits") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Tax Credit">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaxCredit" runat="Server" Text='<%# Eval("TaxCreditDesc") %>' />
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
                                                <asp:TemplateField ShowHeader="False">
                                                    <EditItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
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
                                        <h3 class="panel-title">New Construction/Reuse/Rehab</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddSingleUnit" runat="server" Text="Add New Construction/Reuse/Rehab" />
                                        <asp:ImageButton ID="ImgNewConst" ImageUrl="~/Images/print.png" ToolTip="New Construction/Reuse/Rehab Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgNewConst_Click" />
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
                                                <asp:Label ID="lblProjectSingleCountID" runat="Server" Text='<%# Eval("ProjectHouseConsReuseRehabID") %>' />
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
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
                                        <h3 class="panel-title">Accessible/Adaptable</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMultiUnit" runat="server" Text="Add New Accessible/Adaptable" />
                                        <asp:ImageButton ID="ImgAccessible" ImageUrl="~/Images/print.png" ToolTip="Accessible/Adaptable Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgAccessible_Click" />
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
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="false"
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
                                                <asp:Label ID="lblProjectMultiCountID" runat="Server" Text='<%# Eval("ProjectHouseAccessAdaptID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Characteristic">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCharacteristic" runat="Server" Text='<%# Eval("Characteristic") %>' />
                                            </ItemTemplate>
                                           <%-- <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>--%>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumunits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                           <%-- <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterMultiUnitTotalUnits" Text=""></asp:Label>
                                            </FooterTemplate>--%>
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
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
                                        <h3 class="panel-title">Primary Service Support</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddSuppService" runat="server" Text="Add New Primary Service Support" />
                                        <asp:ImageButton ID="ImgPrimary" ImageUrl="~/Images/print.png" ToolTip="Primary Service Support"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgPrimary_Click" />
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
                            <div id="dvPrimaryServiceWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblPrimaryServiceWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewSecServices">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Secondary Service Support</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddSecService" runat="server" Text="Add New Secondary Service Support" />
                                        <asp:ImageButton ID="ImgSecondary" ImageUrl="~/Images/print.png" ToolTip="Secondary Service Support"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgSecondary_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvSecServiceForm">
                            <asp:Panel runat="server" ID="Panel11">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Service</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlSecService" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtSecServiceUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddSecServices" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddSecServices_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvSecServiceGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel12" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvSecService" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvSecService_RowEditing" OnRowCancelingEdit="gvSecService_RowCancelingEdit" 
                                    OnRowUpdating="gvSecService_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectSecSuppServID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectSecSuppServID" runat="Server" Text='<%# Eval("ProjectSecSuppServID") %>' />
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
                                                <asp:TextBox ID="txtSecServiceNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterSecServiceTotalUnits" Text=""></asp:Label>
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewAgeRestrictions">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Age Restrictions</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAgeRes" runat="server" Text="Add New Age Restrictions" />
                                         <asp:ImageButton ID="ImgAge" ImageUrl="~/Images/print.png" ToolTip="Age Restrictions Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgAge_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAgeRestForm">
                            <asp:Panel runat="server" ID="Panel13">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Age Restrictions</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAgeRest" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtAgeRestUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddAgeRest" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddAgeRest_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAgeRestrGrid" runat="server">
                             <div id="dvAgeRestrWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblAgeRestrWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel14" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAgeRestr" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvAgeRestr_RowEditing" OnRowCancelingEdit="gvAgeRestr_RowCancelingEdit"
                                    OnRowUpdating="gvAgeRestr_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectAgeRestrictID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectAgeRestrictID" runat="Server" Text='<%# Eval("ProjectAgeRestrictID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Age Restriction">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAgeRestriction" runat="Server" Text='<%# Eval("AgeRestriction") %>' />
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
                                                <asp:TextBox ID="txtAgeRestrNumunits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterAgeRestrTotalUnits" Text=""></asp:Label>
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
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
                                        <h3 class="panel-title">VHCB Covenant</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddVHCBAff" runat="server" Text="Add New VHCB Covenant" />
                                        <asp:ImageButton ID="ImgVHCBAff" ImageUrl="~/Images/print.png" ToolTip="VHCB Affordability"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgVHCBAff_Click" />
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewTargetEff">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Target/Best Effort</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddTargetEff" runat="server" Text="Add New Target/Best Effort" />
                                        <asp:ImageButton ID="ImgTargetEff" ImageUrl="~/Images/print.png" ToolTip="Target/Best Effort"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgTargetEff_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvTargetEffForm">
                            <asp:Panel runat="server" ID="Panel15">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Target Best Effort</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlTargetEff" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtTargetUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddTargetEff" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddTargetEff_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvTargetEffGrid" runat="server">
                            <div id="dvTargetEffWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblTargetEffWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel16" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvTargetEff" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvTargetEff_RowEditing" 
                                    OnRowCancelingEdit="gvTargetEff_RowCancelingEdit" 
                                    OnRowUpdating="gvTargetEff_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectHouseTargetID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectHouseTargetID" runat="Server" Text='<%# Eval("ProjectHouseTargetID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="TargetBestEffort">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTargetBestEffort" runat="Server" Text='<%# Eval("TargetBestEffort") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTargetUnits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTargetUnits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTargetTotalUnits" Text=""></asp:Label>
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewAffordableTo">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Affordable To</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAffordableTo" runat="server" Text="Add New Affordable To" />
                                        <asp:ImageButton ID="ImgAffordableTo" ImageUrl="~/Images/print.png" ToolTip="Affordable To"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgAffordableTo_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAffordableToForm">
                            <asp:Panel runat="server" ID="Panel17">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Affordable To</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAffordableTo" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtAffordableToUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddAffordableTo" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddAffordableTo_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAffordableToGrid" runat="server">
                            <div id="dvAffordableToWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblAffordableToWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel18" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAffordableTo" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvAffordableTo_RowEditing" 
                                    OnRowCancelingEdit="gvAffordableTo_RowCancelingEdit" 
                                    OnRowUpdating="gvAffordableTo_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectHouseAffordToID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectHouseAffordToID" runat="Server" Text='<%# Eval("ProjectHouseAffordToID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Affordable To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAffordableTo" runat="Server" Text='<%# Eval("AffordableTo") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAffordToUnits" runat="Server" Text='<%# Eval("Numunits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAffordToUnits" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Numunits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterAffordToTotalUnits" Text=""></asp:Label>
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
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                    </div>
                </div>

                <%--<div class="panel-width" runat="server" id="dvNewHomeAff">
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
                </div>--%>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfHousingID" runat="server" />
    <asp:HiddenField ID="hfTotalUnitsFromDB" runat="server" />
    <asp:HiddenField ID="hfSubTypeWarning" runat="server" />
    <asp:HiddenField ID="hfSingleUnitWarning" runat="server" />
    <asp:HiddenField ID="hfVHCBUnitWarning" runat="server" />
    <asp:HiddenField ID="hfPrimaryServiceWarning" runat="server" />
    <asp:HiddenField ID="hfAgeRestrWarning" runat="server" />
    <asp:HiddenField ID="hfNotInCovenantCount" runat="server" Value="0" />
     <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />
    <asp:HiddenField ID="hfTargetEffWarning" runat="server" />
    <asp:HiddenField ID="hfAffordableToWarning" runat="server" />
   
    <script language="javascript">
        $(document).ready(function () {
           <%-- $('#<%= txtTotalUnits.ClientID%>').blur(function () {
                CalculateNewUnits();
            });--%>
            $('#<%= txtUnitsFromPreProject.ClientID%>').blur(function () {
                CalculateTotalUnits();
            });
            $('#<%= txtNetNewUnits.ClientID%>').blur(function () {
                CalculateTotalUnits();
            });
            $('#<%= txtUnitsRemoved.ClientID%>').blur(function () {
                CalculateTotalUnits();
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

            $('#<%= dvTaxCreditForm.ClientID%>').toggle($('#<%= cbAddTaxCredit.ClientID%>').is(':checked'));

            $('#<%= cbAddTaxCredit.ClientID%>').click(function () {
                $('#<%= dvTaxCreditForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvSecServiceForm.ClientID%>').toggle($('#<%= cbAddSecService.ClientID%>').is(':checked'));

            $('#<%= cbAddSecService.ClientID%>').click(function () {
                $('#<%= dvSecServiceForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvAgeRestForm.ClientID%>').toggle($('#<%= cbAddAgeRes.ClientID%>').is(':checked'));

            $('#<%= cbAddAgeRes.ClientID%>').click(function () {
                $('#<%= dvAgeRestForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvVHCBAffForm.ClientID%>').toggle($('#<%= cbAddVHCBAff.ClientID%>').is(':checked'));

            $('#<%= cbAddVHCBAff.ClientID%>').click(function () {
                $('#<%= dvVHCBAffForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddTargetEff.ClientID%>').click(function () {
                $('#<%= dvTargetEffForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvTargetEffForm.ClientID%>').toggle($('#<%= cbAddTargetEff.ClientID%>').is(':checked'));

            $('#<%= cbAddAffordableTo.ClientID%>').click(function () {
                $('#<%= dvAffordableToForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvAffordableToForm.ClientID%>').toggle($('#<%= cbAddAffordableTo.ClientID%>').is(':checked'));

             <%--$('#<%= dvHomeAffForm.ClientID%>').toggle($('#<%= cbAddHomeAff.ClientID%>').is(':checked'));

            $('#<%= cbAddHomeAff.ClientID%>').click(function () {
                $('#<%= dvHomeAffForm.ClientID%>').toggle(this.checked);
            }).change();--%>
        });

        function CalculateTotalUnits() {
            //var TotalUnits = parseInt($('#<%=spnTotalUnits.ClientID%>').text(), 10);
            var UnitsRemoved = parseInt($('#<%=txtUnitsRemoved.ClientID%>').val(), 10);
            console.log("UnitsRemoved" + UnitsRemoved);

            var UnitsFromPreProject = parseInt($('#<%=txtUnitsFromPreProject.ClientID%>').val(), 10);
            console.log("UnitsFromPreProject" + UnitsFromPreProject);

            var NewUnits = parseInt($('#<%=txtNetNewUnits.ClientID%>').val(), 10);
            console.log("NewUnits" + NewUnits);

            var TotalUnits = UnitsFromPreProject + NewUnits - UnitsRemoved;
            $('#<%= spnTotalUnits.ClientID%>').text(TotalUnits);
            console.log("TotalUnits:" + TotalUnits);

            //$('#<%= spnVHCBAffUnits.ClientID%>').text(TotalUnits - parseInt($('#<%=hfNotInCovenantCount.ClientID%>').val(), 10););

        };

        
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>

