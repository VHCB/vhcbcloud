<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnterpriseServiceProviders.aspx.cs"
    Inherits="vhcbcloud.Viability.EnterpriseServiceProviders" MaintainScrollPositionOnPostback="true" %>

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
                            <td><span class="labelClass">Name</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="ProjName" runat="server"></span>
                            </td>
                            <td>
                                <%--<asp:CheckBox ID="cbLatestBudget" runat="server" Checked="true" Text=" Is Latest Budget" />--%>
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

                <div class="panel-width" runat="server" id="dvServiceProviders">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Enterprise Service Providers</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddYear" runat="server" Text="Add New Year" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvServiceYearForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass">Year</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:TextBox ID="txtYear" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 175px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass"># Business plans/Year |  Projects</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:TextBox ID="TextBox1" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 175px">
                                            <span class="labelClass"> Cost per project
                                            </span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCostPerProject" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass"># Cash Flow/Short Term Year |  project</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:TextBox ID="TextBox2" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 175px">
                                            <span class="labelClass"> Cost per project
                                            </span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox3" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass"># Year 2 Follow-ups</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:TextBox ID="TextBox4" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 175px">
                                            <span class="labelClass"> Cost per project
                                            </span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox5" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass"># Additional Enrollee Projects</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:TextBox ID="TextBox6" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 175px">
                                            <span class="labelClass"> Cost per project
                                            </span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox7" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass"># Workshops / Special Events</span></td>
                                        <td class="modal-sm" style="width: 164px">
                                            <asp:TextBox ID="TextBox8" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 175px">
                                            <span class="labelClass"> Cost per project
                                            </span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox9" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td class="modal-sm" style="width: 250px"><span class="labelClass">Notes</span></td>
                                        <td class="modal-sm" style="width: 164px" colspan="3">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="480px" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 5px">
                                            <asp:Button ID="btnAddServiceProviders" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddServiceProviders_Click"  />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td colspan="4" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <%--<div class="panel-body" id="dvConsevationSourcesGrid" runat="server">
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
                                            <ItemStyle Width="500px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="Server" Text='<%# Eval("Total", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTotal" CssClass="clsTextBoxBlue1" style="width: 100px" runat="server" Text='<%# Eval("Total", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterTotalAmount" Text=""></asp:Label>
                                        </FooterTemplate>
                                            <ItemStyle Width="200px" />
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
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
             $('#<%= dvServiceYearForm.ClientID%>').toggle($('#<%= cbAddYear.ClientID%>').is(':checked'));

            $('#<%= cbAddYear.ClientID%>').click(function () {
                $('#<%= dvServiceYearForm.ClientID%>').toggle(this.checked);
            }).change();
        });


        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>
