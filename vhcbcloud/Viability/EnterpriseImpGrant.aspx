<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnterpriseImpGrant.aspx.cs"
    Inherits="vhcbcloud.Viability.EnterpriseImpGrant" MaintainScrollPositionOnPostback="true" %>

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
                            <td style="height: 5px"><span class="labelClass">Other Names</span></td>
                            <td  style="height: 5px" colspan="5">
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

                <div class="panel-width" runat="server" id="dvGrantApplication">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Grant Application</h3>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvGrantApplicationForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 14%"><span class="labelClass">FY/Grant Round</span></td>
                                        <td style="width: 19%">
                                            <asp:DropDownList ID="ddlFYGrantRound" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 14%">
                                            <span class="labelClass">Title</span>
                                        </td>
                                        <td style="width: 17%">
                                            <asp:TextBox ID="txtProjectTitle" CssClass="clsTextBoxBlue1" runat="server" Width="232px"></asp:TextBox>
                                        </td>
                                        <td style="width: 13%"><span class="labelClass"></span>
                                        </td>
                                        <td style="width: 45%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 14%"><span class="labelClass">Description</span></td>
                                        <td style="width: 100%" colspan="5">
                                            <asp:TextBox ID="txtProjectDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 14%"><span class="labelClass">Project Cost</span></td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtProjCost" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 14%">
                                            <span class="labelClass">Amount Requested</span>
                                        </td>
                                        <td style="width: 17%">
                                            <asp:TextBox ID="txtAmountReq" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 13%"><span class="labelClass"></span>
                                        </td>
                                        <td style="width: 45%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 14%">
                                            <asp:Button ID="btnAddGrantApplication" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddGrantApplication_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-width" runat="server" id="dvNewGrantMatch">
                            <div class="panel panel-default ">
                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Grant Match</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:CheckBox ID="cbAddGrantmatch" runat="server" Text="Add New Grant Match" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" runat="server" id="dvGrantMatchForm">
                                    <asp:Panel runat="server" ID="Panel1">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 136px"><span class="labelClass">Match Description</span></td>
                                                <td style="width: 215px">
                                                    <asp:DropDownList ID="ddlMatchDescription" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 106px">
                                                    <span class="labelClass">Grant Amount</span></td>
                                                <td style="width: 180px">
                                                    <asp:TextBox ID="txtGrantAmt" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 170px"></td>
                                                <td>
                                                    <asp:Button ID="btnAddMatchDesc" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddMatchDesc_Click" /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 15px"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvGrantMatchGrid" runat="server">
                                    <asp:Panel runat="server" ID="Panel4" Width="100%" Height="100px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvGrantMatch" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                            OnRowEditing="gvGrantMatch_RowEditing" OnRowCancelingEdit="gvGrantMatch_RowCancelingEdit"
                                            OnRowUpdating="gvGrantMatch_RowUpdating">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <FooterStyle CssClass="footerStyleTotals" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="EnterpriseGrantMatchID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEnterpriseGrantMatchID" runat="Server" Text='<%# Eval("EnterpriseGrantMatchID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="MatchDesc">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMatchDesc" runat="Server" Text='<%# Eval("MatchDesc") %>' />
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        Total :
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Grant Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblGrantAmount" runat="Server" Text='<%# Eval("GrantAmt", "{0:C2}") %>' />
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblFooterAmount" runat="server" Text=""></asp:Label>
                                                    </FooterTemplate>
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

                        <div class="panel-width" runat="server" id="dvGrantAward" visible="false">
                            <div class="panel panel-default ">
                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Grant Award</h3>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="panel-body" runat="server" id="dvGrantAwardForm">
                                    <asp:Panel runat="server" ID="Panel2">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 14%"><span class="labelClass">Award Amount</span></td>
                                                <td style="width: 19%">
                                                    <asp:TextBox ID="txtAwardAmount" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 11%">
                                                    <span class="labelClass">Leveraged Funds</span>
                                                </td>
                                                <td style="width: 17%"><span class="labelClass" id="spnLevFunds" runat="server"></span></td>
                                                <td style="width: 13%"></td>
                                                <td style="width: 45%"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 14%"><span class="labelClass">Award Description</span></td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtAwardDescription" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 14%"><span class="labelClass">Comments</span></td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 14%">
                                                    <asp:Button ID="btnUpdateGrantAward" runat="server" Text="Update" class="btn btn-info" OnClick="btnUpdateGrantAward_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                            </div>
                        </div>

                        <div class="panel-width" runat="server" id="dvAttribute">
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
                                    <asp:Panel runat="server" ID="Panel5">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 240px"><span class="labelClass">Grant Attribute:</span></td>
                                                <td style="width: 215px">
                                                    <asp:DropDownList ID="ddlAttribute" CssClass="clsDropDownLong" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px"></td>
                                                <td style="width: 180px">
                                                    <asp:Button ID="btnAddAttribute" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAttribute_Click" />

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
                                    <asp:Panel runat="server" ID="Panel6" Width="100%" Height="100px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvAttribute" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                            OnRowEditing="gvAttribute_RowEditing" OnRowCancelingEdit="gvAttribute_RowCancelingEdit" OnRowUpdating="gvAttribute_RowUpdating">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="EnterImpAttributeID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEnterImpAttributeID" runat="Server" Text='<%# Eval("EnterImpAttributeID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Attribute">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAttribute" runat="Server" Text='<%# Eval("Attribute") %>' />
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
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfProjectId" runat="server" />
        <asp:HiddenField ID="hfEnterImpGrantID" runat="server" />
        <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />

        <script language="javascript">
            $(document).ready(function () {
                $('#<%= dvGrantMatchForm.ClientID%>').toggle($('#<%= cbAddGrantmatch.ClientID%>').is(':checked'));

                $('#<%= cbAddGrantmatch.ClientID%>').click(function () {
                    $('#<%= dvGrantMatchForm.ClientID%>').toggle(this.checked);
                }).change();

                $('#<%= dvAttributeForm.ClientID%>').toggle($('#<%= cbAddAttribute.ClientID%>').is(':checked'));

                $('#<%= cbAddAttribute.ClientID%>').click(function () {
                    $('#<%= dvAttributeForm.ClientID%>').toggle(this.checked);
                }).change();

                toCurrencyControl($('#<%= txtProjCost.ClientID%>').val(), $('#<%= txtProjCost.ClientID%>'));
                toCurrencyControl($('#<%= txtAmountReq.ClientID%>').val(), $('#<%= txtAmountReq.ClientID%>'));
                toCurrencyControl($('#<%= txtAwardAmount.ClientID%>').val(), $('#<%= txtAwardAmount.ClientID%>'));
                toCurrencyControl($('#<%= txtGrantAmt.ClientID%>').val(), $('#<%= txtGrantAmt.ClientID%>'));

                $('#<%= txtGrantAmt.ClientID%>').keyup(function () {
                    toCurrencyControl($('#<%= txtGrantAmt.ClientID%>').val(), $('#<%= txtGrantAmt.ClientID%>'));
                });

                $('#<%= spnLevFunds.ClientID%>').text(formatter.format($('#<%= spnLevFunds.ClientID%>').text())); //Todo Not working

                $('#<%= txtProjCost.ClientID%>').keyup(function () {
                    toCurrencyControl($('#<%= txtProjCost.ClientID%>').val(), $('#<%= txtProjCost.ClientID%>'));
                });

                $('#<%= txtAmountReq.ClientID%>').keyup(function () {
                    toCurrencyControl($('#<%= txtAmountReq.ClientID%>').val(), $('#<%= txtAmountReq.ClientID%>'));
                });

                $('#<%= txtAwardAmount.ClientID%>').keyup(function () {
                    toCurrencyControl($('#<%= txtAwardAmount.ClientID%>').val(), $('#<%= txtAwardAmount.ClientID%>'));
                });

                $('#<%= txtProjCost.ClientID%>').blur(function () {
                    CalculateLivFund();
                });
                $('#<%= txtAwardAmount.ClientID%>').blur(function () {
                    CalculateLivFund();
                });
            });

            function CalculateLivFund() {
                var ProjCost = parseInt($('#<%=txtProjCost.ClientID%>').val(), 10);
                var AwardAmount = parseInt($('#<%=txtAwardAmount.ClientID%>').val(), 10);

                if (isNaN(ProjCost)) {
                    var ProjCost = 0;
                }

                if (isNaN(AwardAmount)) {
                    var AwardAmount = 0;
                }

                var LiveFund = ProjCost - AwardAmount;
                $('#<%= spnLevFunds.ClientID%>').text(LiveFund);
            };

            function PopupAwardSummary() {
                window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
            };
        </script>
    </div>
</asp:Content>
