<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnterpriseInfo.aspx.cs"
    Inherits="vhcbcloud.Viability.EnterpriseInfo" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
     <style type="text/css">
        .scroll_checkboxes {
            height: 100px;
            padding: 1px;
            overflow: auto;
            border: 1px solid #ccc;
        }

        .FormText {
            FONT-SIZE: 11px;
            FONT-FAMILY: tahoma,sans-serif;
        }

        .checkboxlist_nowrap label {
            white-space: nowrap;
            display: inline-block;
        }
    </style>
    <div class="jumbotron" id="vhcb">
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs"></ul>
                </div>
            </div>
        </div>
        <!--  Tabs -->
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td><span class="labelClass">Project #</span></td>
                            <td>
                                <span class="labelClass" id="ProjectNum" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Name:</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="ProjName" runat="server"></span>
                            </td>

                            <td class="modal-sm" style="width: 100px"><span class="labelClass">Enterprise Type:</span></td>
                            <td style="width: 250px">
                                <span class="labelClass" runat="server" id="spnEnterPriseType"></span>
                                <asp:DropDownList ID="ddlEnterPriseType" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>&nbsp;&nbsp;<asp:Button ID="btnEntePriseType" runat="server" Text="Update" class="btn btn-info" OnClick="btnEntePriseType_Click" />
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
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td style="height: 5px"><span class="labelClass">Owner/Operator</span></td>
                            <td style="height: 5px" colspan="5">
                                <asp:TextBox ID="txtOtherNames" CssClass="clsTextBoxBlue1" runat="server" Width="500px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
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

                <div class="panel-width" runat="server" id="Div1">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Enterprise Data</h3>
                                    </td>
                                    <td style="text-align: right"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="Div2">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 194px"><span class="labelClass">Primary Product/Service</span></td>
                                        <td style="width: 200px">
                                            <asp:DropDownList ID="ddlPrimaryProduct" CssClass="clsDropDown" AutoPostBack="false" runat="server"
                                                OnSelectedIndexChanged="ddlPrimaryProduct_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 97px"></td>
                                        <td style="width: 173px"></td>
                                        <td style="width: 58px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 268px"><span class="labelClass">How did you hear about the Viability Program?</span></td>
                                        <td colspan="3">
                                            <asp:DropDownList ID="ddlHearViability" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 268px"><span class="labelClass">Year Began Managing Business</span></td>
                                        <td style="width: 146px">
                                            <asp:TextBox ID="txtYearMangBusiness" CssClass="clsTextBoxBlue1" runat="server" MaxLength="4" Width="44px"></asp:TextBox>
                                            <%-- <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtEventDate">
                                            </ajaxToolkit:CalendarExtender>--%>
                                        </td>
                                        <td class="modal-sm" style="width: 169px"><span class="labelClass">Years Managed Business</span></td>
                                        <td><span class="labelClass" id="spnYearsManagedBusiness" runat="server"></span></td>
                                        <td>
                                            <asp:Button ID="btnAddEntInfo" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEntInfo_Click" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvProduct">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
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

                        <div class="panel-body" runat="server" id="dvProductForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 144px"><span class="labelClass">Products</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:DropDownList ID="ddlProducts" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 97px"><span class="labelClass">Date</span></td>
                                        <td style="width: 173px">
                                            <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 58px"><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked="true" /></td>
                                        <td style="width: 58px"></td>
                                        <td>
                                            <asp:Button ID="btnAddProducts" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddProducts_Click" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvProductsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="False"
                                    OnRowEditing="gvProducts_RowEditing" OnRowCancelingEdit="gvProducts_RowCancelingEdit"
                                    OnRowUpdating="gvProducts_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="EnterpriseProductsID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEnterpriseProductsID" runat="Server" Text='<%# Eval("EnterpriseProductsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProduct" runat="Server" Text='<%# Eval("Product") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="Server" Text='<%# Eval("StartDate",  "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtGridStartDate" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("StartDate",  "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtGridStartDate">
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

                <div class="panel-width" runat="server" id="dvAcres">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Acres</h3>
                                    </td>
                                    <td style="text-align: right"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAcresForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%" runat="server" id="tblAcres">
                                    <tr>
                                        <td class="modal-sm" style="width: 97px"><span class="labelClass">Acres Owned</span></td>
                                        <td class="modal-sm" style="width: 129px">
                                            <asp:TextBox ID="txtAcresOwned" CssClass="clsTextBoxBlue1" runat="server" Width="100px" TabIndex="1"></asp:TextBox>
                                        </td>
                                        <td style="width: 129px"><span class="labelClass">Acres in Production</span></td>
                                        <td style="width: 136px">
                                            <asp:TextBox ID="txtAcresInProd" CssClass="clsTextBoxBlue1" runat="server" Width="100px" TabIndex="3"></asp:TextBox>
                                        </td>
                                        <td style="width: 115px"><span class="labelClass"></span></td>
                                        <td style="width: 140px"></td>
                                        <td style="width: 100px"><span class="labelClass"></span></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 15px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 97px"><span class="labelClass">Acres Leased</span></td>
                                        <td class="modal-sm" style="width: 129px">
                                            <asp:TextBox ID="txtAcresLeased" CssClass="clsTextBoxBlue1" runat="server" Width="100px" TabIndex="2"></asp:TextBox>
                                        </td>
                                        <td style="width: 129px"><span class="labelClass">Access Acres</span></td>
                                        <td style="width: 136px"><asp:TextBox ID="txtAccAcres" CssClass="clsTextBoxBlue1" runat="server" Width="100px" TabIndex="4"></asp:TextBox></td>
                                        <td style="width: 115px"><span class="labelClass"></span></td>
                                        <td style="width: 140px"></td>
                                        <td style="width: 100px"><span class="labelClass"></span></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 15px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 97px"><span class="labelClass">Total Acres</span></td>
                                        <td class="modal-sm" style="width: 129px">
                                            <span class="labelClass" runat="server" id="spnTotalAcres"></span>
                                        </td>
                                        <td style="width: 129px"><span class="labelClass"></span></td>
                                        <td style="width: 136px"></td>
                                        <td style="width: 115px"><span class="labelClass"></span></td>
                                        <td style="width: 140px"></td>
                                        <td style="width: 100px"><span class="labelClass"></span></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 15px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" style="height: 5px"></td>
                                    </tr>
                                </table>
                                 <table style="width: 100%" runat="server" id="tblForectAcres" visible="false">
                                      <tr>
                                        <td class="modal-sm" style="width: 97px">
                                            <span class="labelClass">Forest acres</span></td>
                                        <td class="modal-sm" style="width: 129px">
                                            <asp:TextBox ID="txtForestAcres" CssClass="clsTextBoxBlue1" runat="server" Width="100px" TabIndex="1"></asp:TextBox>
                                        </td>
                                        <td style="width: 129px"><span class="labelClass">Total Acres</span></td>
                                        <td style="width: 136px">
                                            <asp:TextBox ID="txtTotalAcres" CssClass="clsTextBoxBlue1" runat="server" Width="100px" TabIndex="1"></asp:TextBox>
                                        </td>
                                        <td style="width: 115px"><span class="labelClass"></span></td>
                                        <td style="width: 140px"></td>
                                        <td style="width: 100px"><span class="labelClass"></span></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 15px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" style="height: 5px"></td>
                                    </tr>
                                     </table>
                                <table>
                                    <tr>
                                        <td class="modal-sm" style="width: 97px">
                                            <asp:Button ID="btnAddAcres" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAcres_Click" TabIndex="4" />
                                        </td>
                                        <td colspan="9" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvAttribute">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
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

                        <div class="panel-body" runat="server" id="dvAttributeForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 144px"><span class="labelClass">Attribute</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:DropDownList ID="ddlAttribute" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 97px"><span class="labelClass">Date</span></td>
                                        <td style="width: 173px">
                                            <asp:TextBox ID="txtDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 58px"><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox2" Enabled="false" runat="server" Checked="true" /></td>
                                        <td style="width: 58px"></td>
                                        <td>
                                            <asp:Button ID="btnAddAttribute" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAttribute_Click" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAttributeGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="150px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAttribute" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="False"
                                    OnRowEditing="gvAttribute_RowEditing" OnRowCancelingEdit="gvAttribute_RowCancelingEdit"
                                    OnRowUpdating="gvAttribute_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="EnterpriseAttributeID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEnterpriseAttributeID" runat="Server" Text='<%# Eval("EnterpriseAttributeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Attribute">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttribute" runat="Server" Text='<%# Eval("Attribute") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date",  "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtGridDate" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("Date",  "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtGridDate">
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

                <div class="panel-width" runat="server" id="Div3">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Farm Size</h3>
                                    </td>
                                    <td style="text-align: right"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="Div4">
                            <asp:Panel runat="server" ID="Panel5">
                                <table style="width: 100%" runat="server" id="Table1">
                                    <tr>
                                        <td class="modal-sm" style="width: 97px"><span class="labelClass">Farm Size</span></td>
                                        <td class="modal-sm" style="width: 129px">
                                            <asp:DropDownList ID="ddlFarmSize" CssClass="clsDropDown" AutoPostBack="false" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 129px"><span class="labelClass"></span></td>
                                        <td style="width: 136px">
                                            
                                        </td>
                                        <td style="width: 115px">
                                            <asp:Button ID="btnAddFarmSize" runat="server" Text="Update" class="btn btn-info" OnClick="btnAddFarmSize_Click" TabIndex="4" />
                                        </td>
                                        <td style="width: 140px"></td>
                                        <td style="width: 100px"><span class="labelClass"></span></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 15px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewWatershed">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Watershed</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddWatershed" runat="server" Text="Add New Watershed" />
                                        <%--<asp:ImageButton ID="ImgWatershed" ImageUrl="~/Images/print.png" ToolTip="Watershed Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgWatershed_Click" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvNewWatershedForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td><span class="labelClass">Watershed</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlWaterShedNew" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlWaterShedNew_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <span class="labelClass">Sub-Watershed</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlSubWatershedNew" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:CheckBox ID="cbWatershedActive" CssClass="ChkBox" runat="server" Text="Active" Checked="true" Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="labelClass">HUC-12</span>
                                        </td>
                                        <td>
                                            <div class="scroll_checkboxes">
                                                <asp:CheckBoxList Width="180px" ID="cblHUC12" runat="server" RepeatDirection="Vertical" RepeatColumns="1" BorderWidth="0"
                                                    Datafield="description" DataValueField="value" CssClass="checkboxlist_nowrap">
                                                </asp:CheckBoxList>
                                            </div>
                                        </td>
                                        <td><span class="labelClass">Sort By</span></td>
                                        <td>
                                            <asp:RadioButtonList ID="rdHUC12order" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                                OnSelectedIndexChanged="rdHUC12order_SelectedIndexChanged">
                                                <asp:ListItem>HUC12</asp:ListItem>
                                                <asp:ListItem>Name</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnWatershed" runat="server" Text="Add" class="btn btn-info" OnClick="btnWatershed_Click" />
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvWatershedGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvWatershed" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvWatershed_RowEditing" 
                                    OnRowUpdating="gvWatershed_RowUpdating"
                                    OnRowCancelingEdit="gvWatershed_RowCancelingEdit">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="EnterpriseWaterShedID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEnterpriseWaterShedID" runat="Server" Text='<%# Eval("EnterpriseWaterShedID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="EntetrpriseHUCID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEntetrpriseHUCID" runat="Server" Text='<%# Eval("EntetrpriseHUCID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Watershed">
                                            <ItemTemplate>
                                                <asp:Label ID="lblwatershed" runat="Server" Text='<%# Eval("WatershedDesc") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sub Watershed">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSubWatershed" runat="Server" Text='<%# Eval("WatershedSubDesc") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="HUC-12">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHUC12" runat="Server" Text='<%# Eval("HUC12Name") %>' />
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
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfEnterpriseAcresId" runat="server" />
    <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvProductForm.ClientID%>').toggle($('#<%= cbAddProduct.ClientID%>').is(':checked'));

            $('#<%= cbAddProduct.ClientID%>').click(function () {
                $('#<%= dvProductForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvAttributeForm.ClientID%>').toggle($('#<%= cbAddAttribute.ClientID%>').is(':checked'));

            $('#<%= cbAddAttribute.ClientID%>').click(function () {
                $('#<%= dvAttributeForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvNewWatershedForm.ClientID%>').toggle($('#<%= cbAddWatershed.ClientID%>').is(':checked'));
            $('#<%= cbAddWatershed.ClientID%>').click(function () {
                $('#<%= dvNewWatershedForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= txtAcresOwned.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtAcresOwned.ClientID%>').val(), $('#<%= txtAcresOwned.ClientID%>'));
            });
            $('#<%= txtAcresLeased.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtAcresLeased.ClientID%>').val(), $('#<%= txtAcresLeased.ClientID%>'));
            });
            $('#<%= txtAccAcres.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtAccAcres.ClientID%>').val(), $('#<%= txtAccAcres.ClientID%>'));
            });

            $('#<%= txtAcresOwned.ClientID%>').blur(function () {
                CalculateTotalAcres();
            });
            $('#<%= txtAcresLeased.ClientID%>').blur(function () {
                CalculateTotalAcres();
            });
            $('#<%= txtAccAcres.ClientID%>').blur(function () {
                CalculateTotalAcres();
            });
            $('#<%= txtYearMangBusiness.ClientID%>').blur(function () {
                CalculateNumberOfYears();
            });
        });

        function CalculateNumberOfYears() {
            var Year = parseInt($('#<%=txtYearMangBusiness.ClientID%>').val(), 10);
            var currentYear = (new Date).getFullYear();

            if (!isNaN(Year)) {
                $('#<%= spnYearsManagedBusiness.ClientID%>').text(currentYear - Year);
            }
            else
            {
                $('#<%= spnYearsManagedBusiness.ClientID%>').text("");
            }
        };

        function CalculateTotalAcres() {
            var Owned = parseInt($('#<%=txtAcresOwned.ClientID%>').val(), 10);
            var Leased = parseInt($('#<%=txtAcresLeased.ClientID%>').val(), 10);
            var Access = parseInt($('#<%=txtAccAcres.ClientID%>').val(), 10);
            
            if (isNaN(Owned)) {
                var Owned = 0;
            }

            if (isNaN(Leased)) {
                var Leased = 0;
            }

            if (isNaN(Access)) {
                var Access = 0;
            }

            var Total = Owned + Leased + Access;
            $('#<%= spnTotalAcres.ClientID%>').text(Total);
            };

            function PopupAwardSummary() {
                window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>



