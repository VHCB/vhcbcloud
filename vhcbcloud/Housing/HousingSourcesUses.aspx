<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HousingSourcesUses.aspx.cs"
    Inherits="vhcbcloud.Housing.HousingSourcesUses" MaintainScrollPositionOnPostback="true" %>


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
                            <td style="text-align: right">
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" Text="Award Summary" Style="width: 25px; height: 25px; border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" Text="Project Notes" Style="width: 25px; height: 25px; border: none; vertical-align: middle;" />
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td><span class="labelClass">Budget Period</span></td>
                            <td>
                                <asp:DropDownList ID="ddlBudgetPeriod" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlBudgetPeriod_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td colspan="2">
                                <div runat="server" id="dvImport">
                                    <table>
                                        <tr>
                                            <td style="height: 5px"><span class="labelClass">Import From &nbsp;</span></td>
                                            <td style="height: 5px">
                                                <asp:DropDownList ID="ddlImportFrom" CssClass="clsDropDown" runat="server" AutoPostBack="true" 
                                                    OnSelectedIndexChanged="ddlImportFrom_SelectedIndexChanged">
                                                </asp:DropDownList></td>
                                        </tr>
                                    </table>
                                </div>
                            </td>

                            <td style="height: 5px"></td>
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

                 <div class="panel-width" runat="server" id="dvNewSource">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Sources</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddSource" runat="server" Text="Add New Source" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvSourceForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Sources</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlSource" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Total
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtSourceTotal" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddSources" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddSources_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvConsevationSourcesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="250px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHousingSources" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                     OnRowEditing="gvHousingSources_RowEditing" OnRowCancelingEdit="gvHousingSources_RowCancelingEdit" OnRowUpdating="gvHousingSources_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HouseSourceID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHouseSourceID" runat="Server" Text='<%# Eval("HouseSourceID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="&nbsp;Source">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSourceName" runat="Server" Text='<%# Eval("SourceName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="Server" Text='<%# Eval("Total", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTotal" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("Total") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterTotalAmount" Text=""></asp:Label>
                                        </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewUse">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Uses</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddUse" runat="server" Text="Add New Use" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvUseForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">VHCB</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlVHCBUses" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Amount $
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtVHCBUseAmount" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                                        </td>
                                        <td style="width: 140px"><span class="labelClass">Other</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlOtherUses" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Amount $
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtOtherUseAmount" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                                        </td>
                                        <%--<td style="width: 100px">
                                            <span class="labelClass">Total $
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtUsesTotal" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                                        </td>--%>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddOtherUses" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddOtherUses_Click"/>
                                        </td>
                                        <%--<td></td>--%>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvConsevationUsesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel2" Width="100%" Height="250px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHousingUsesGrid" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="true"
                                     OnRowEditing="gvHousingUsesGrid_RowEditing" OnRowCancelingEdit="gvHousingUsesGrid_RowCancelingEdit" OnRowUpdating="gvHousingUsesGrid_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HouseUseID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHouseUseID" runat="Server" Text='<%# Eval("HouseUseID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="&nbsp;VHCB Use">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCBUseName" runat="Server" Text='<%# Eval("VHCBUseName") %>' />
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VHCB Total">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="Server" Text='<%# Eval("VHCBTotal", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtVHCBTotal" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("VHCBTotal") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterVHCBTotalAmount" Text=""></asp:Label>
                                        </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Other Use">
                                            <ItemTemplate>
                                                <asp:Label ID="lblOtherUseName" runat="Server" Text='<%# Eval("OtherUseName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Other Total">
                                            <ItemTemplate>
                                                <asp:Label ID="lblOtherTotal" runat="Server" Text='<%# Eval("OtherTotal", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtOtherTotal" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("OtherTotal") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterOtherTotalAmount" Text=""></asp:Label>
                                        </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="Server" Text='<%# Eval("Total", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterGrandTotalAmount" Text=""></asp:Label>
                                        </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
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
    <asp:HiddenField ID="hfNavigatedProjectId" runat="server" />
    <asp:HiddenField ID="hfHousingId" runat="server" />
    
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvSourceForm.ClientID%>').toggle($('#<%= cbAddSource.ClientID%>').is(':checked'));
            $('#<%= dvUseForm.ClientID%>').toggle($('#<%= cbAddUse.ClientID%>').is(':checked'));

            $('#<%= cbAddSource.ClientID%>').click(function () {
                $('#<%= dvSourceForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddUse.ClientID%>').click(function () {
                $('#<%= dvUseForm.ClientID%>').toggle(this.checked);
            }).change();
        });

        
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>

