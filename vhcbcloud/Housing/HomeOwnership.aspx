<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeOwnership.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Housing.HomeOwnership" MaintainScrollPositionOnPostback="true" %>

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
                            <td style="text-align: right">
                                <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search"
                                    Style="border: none; vertical-align: middle;" runat="server" Text="Project Search"
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

                <div class="panel-width" runat="server" id="dvNewAddress">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Add New Address</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAddress" runat="server" Text="Add New Address" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvNewAddressForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 67px"><span class="labelClass">Address:</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlAddress" CssClass="clsDropDownLong" runat="server" Style="margin-left: 0px"></asp:DropDownList>
                                        </td>
                                        <td style="width: 164px">
                                            <span class="labelClass">Manufactured/Mobile Home:</span>
                                        </td>
                                        <td style="width: 78px">
                                            <asp:CheckBox ID="cbMH" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td style="width: 144px"><span class="labelClass">Single Family Detached:</span></td>
                                        <td style="width: 97px">
                                            <asp:CheckBox ID="cbSFD" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td style="width: 47px"><span class="labelClass">Condo:</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbCondo" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td><span class="labelClass">Active:</span></td>
                                        <td>
                                            <asp:CheckBox ID="chkAddressActive" Enabled="false" runat="server" Checked="true" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td style="width: 67px">
                                            <asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" />
                                        </td>
                                         <td style="width: 250px">
                                        </td>
                                        <td style="width: 164px">
                                        </td>
                                        <td style="width: 78px">
                                        </td>
                                        <td style="width: 144px"></td>
                                        <td style="width: 97px">
                                        </td>
                                        <td style="width: 47px"></td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAddressFormGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAddressForm" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvAddressForm_RowEditing" OnRowCancelingEdit="gvAddressForm_RowCancelingEdit" 
                                    OnRowDataBound="gvAddressForm_RowDataBound"
                                    OnSelectedIndexChanged="gvAddressForm_SelectedIndexChanged">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HomeOwnershipID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHomeOwnershipID" runat="Server" Text='<%# Eval("HomeOwnershipID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectAddress" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectAddress_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenHomeOwnershipID" runat="server" Value='<%#Eval("HomeOwnershipID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress" runat="Server" Text='<%# Eval("Address") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Manufactured/Mobile Home">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkMH" Enabled="false" runat="server" Checked='<%# Eval("MH") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Single Family Detached">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSFD" Enabled="false" runat="server" Checked='<%# Eval("SFD") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Condo">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkCondo" Enabled="false" runat="server" Checked='<%# Eval("Condo") %>' />
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

            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfHomeOwnershipID" runat="server" />
    
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvNewAddressForm.ClientID%>').toggle($('#<%= cbAddAddress.ClientID%>').is(':checked'));
            $('#<%= cbAddAddress.ClientID%>').click(function () {
                $('#<%= dvNewAddressForm.ClientID%>').toggle(this.checked);
            }).change();

        });
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>

