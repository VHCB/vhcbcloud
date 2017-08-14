<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnterpriseFundamentals.aspx.cs"
    Inherits="vhcbcloud.Viability.EnterpriseFundamentals" MaintainScrollPositionOnPostback="true" %>

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

                <div class="panel-width" runat="server" id="dvPlan">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Fundamentals</h3>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvPlanForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 24%"><span class="labelClass">Business Planning Application</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbBusplan" runat="server" Text="" />
                                        </td>
                                        <td style="width: 18%">
                                            <span class="labelClass">Grant Application</span>
                                        </td>

                                        <td style="width: 13%">
                                            <asp:CheckBox ID="cbGrantApp" runat="server" Text="" /></td>
                                        <td style="width: 45%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 24%"><span class="labelClass">Type of Planning Work</span></td>
                                        <td style="width: 18%">
                                            <asp:DropDownList ID="ddlPlanType" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 18%">
                                            <span class="labelClass">Service Provider Org</span>
                                        </td>
                                        <td style="width: 20%">
                                            <asp:DropDownList ID="ddlServiceProvOrg" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 13%"><span class="labelClass">Lead Advisor</span>
                                        </td>
                                        <td style="width: 45%">
                                            <asp:DropDownList ID="ddlLeadAdvisor" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <%--  <tr>
                                        <td style="width: 14%" colspan="2"><span class="labelClass">How did you hear about the Viability Program?</span></td>
                                        <td style="width: 19%">
                                            <asp:DropDownList ID="ddlHearViability" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 11%"></td>
                                        <td style="width: 17%"></td>
                                        <td style="width: 13%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 14%" colspan="2"><span class="labelClass">Year Began Managing Business</span></td>
                                        <td style="width: 19%">
                                            <asp:TextBox ID="txtYearMangBusiness" CssClass="clsTextBoxBlue1" runat="server" MaxLength="4" Width="44px"></asp:TextBox>
                                        </td>
                                        <td style="width: 11%"></td>
                                        <td style="width: 17%"></td>
                                        <td style="width: 13%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>--%>
                                    <tr>
                                        <td style="width: 24%"><span class="labelClass">Business Description</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtBusinessDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 24%"><span class="labelClass">Project Description</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtProjectDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 24%">
                                            <asp:Button ID="btnAddPlanInfo" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddPlanInfo_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-width" runat="server" id="dvNewFinJobs" visible="false">
                            <div class="panel panel-default ">
                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Job/Financial Year</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:CheckBox ID="cbAddMilestone" runat="server" Text="Add New Financial/Job" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" runat="server" id="dvMilestoneForm">
                                    <asp:Panel runat="server" ID="Panel1">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 167px"><span class="labelClass">Milestone</span></td>
                                                <td style="width: 167px">
                                                    <asp:DropDownList ID="ddlMilestone" CssClass="clsDropDown" runat="server" Style="margin-left: 0">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 167px">
                                                    <span class="labelClass">Date</span>
                                                </td>
                                                <td style="width: 147px">
                                                    <asp:TextBox ID="txtMSDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtMSDate">
                                                    </ajaxToolkit:CalendarExtender>
                                                </td>
                                                <td style="width: 139px"><span class="labelClass">Year</span></td>
                                                <td>
                                                    <asp:TextBox ID="txtYear" CssClass="clsTextBoxBlue1" runat="server" MaxLength="4"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 6px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 167px"><span class="labelClass">Gross Sales</span></td>
                                                <td style="width: 167px">
                                                    <asp:TextBox ID="txtGrossSales" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 167px">
                                                    <span class="labelClass">Net Income</span>
                                                </td>
                                                <td style="width: 147px">
                                                    <asp:TextBox ID="txtNetIncome" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 139px"><span class="labelClass">Gross Payroll</span></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossPayroll" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 6px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 167px"><span class="labelClass">Family Full-time Employees</span></td>
                                                <td style="width: 167px">
                                                    <asp:TextBox ID="txtFamilyFTEmp" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 167px">
                                                    <span class="labelClass">Non-Family Full-time Empl</span>
                                                </td>
                                                <td style="width: 147px">
                                                    <asp:TextBox ID="txtNonFamilyFTEmp" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 139px"><span class="labelClass">Total Full-time </span></td>
                                                <td>
                                                    <span class="labelClass" id="spnTotalFulltime" runat="server"></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 6px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 167px"><span class="labelClass">Networth</span></td>
                                                <td style="width: 167px">
                                                    <asp:TextBox ID="txtNetworth" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 167px"><span class="labelClass">Active</span>
                                                </td>
                                                <td style="width: 147px">
                                                    <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked="true" />
                                                </td>
                                                <td style="width: 139px"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 6px"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 6px">
                                                    <asp:Button ID="btnAddMilestone" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddMilestone_Click" /></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-body" id="dvFiniceJobsGrid" runat="server">
                                    <asp:Panel runat="server" ID="Panel9" Width="100%" Height="250px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvFiniceJobs" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="False"
                                            OnRowEditing="gvFiniceJobs_RowEditing" OnRowCancelingEdit="gvFiniceJobs_RowCancelingEdit" OnRowDataBound="gvFiniceJobs_RowDataBound">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <FooterStyle CssClass="footerStyleTotals" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="EnterFinancialJobsID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEnterFinancialJobsID" runat="Server" Text='<%# Eval("EnterFinancialJobsID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Milestone">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMilestone" runat="Server" Text='<%# Eval("Milestone") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="MSDate">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMSDate" runat="Server" Text='<%# Eval("MSDate", "{0:MM/dd/yyyy}") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Year">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblYear" runat="Server" Text='<%# Eval("Year") %>' />
                                                    </ItemTemplate>
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
                                                <td style="width: 240px"><span class="labelClass">Enterprise Engagement Attribute:</span></td>
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
                                                <asp:TemplateField HeaderText="EnterEngageAttrID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEnterEngageAttrID" runat="Server" Text='<%# Eval("EnterEngageAttrID") %>' />
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
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfEnterFundamentalID" runat="server" />
    <asp:HiddenField ID="hfProjectProgram" runat="server" />
    <asp:HiddenField ID="hfEnterFinancialJobsID" runat="server" />


    <script language="javascript">
        $(document).ready(function () {

            $('#<%= dvAttributeForm.ClientID%>').toggle($('#<%= cbAddAttribute.ClientID%>').is(':checked'));

            $('#<%= cbAddAttribute.ClientID%>').click(function () {
                $('#<%= dvAttributeForm.ClientID%>').toggle(this.checked);
                }).change();

            $('#<%= txtFamilyFTEmp.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtFamilyFTEmp.ClientID%>').val(), $('#<%= txtFamilyFTEmp.ClientID%>'));
            });
            $('#<%= txtNonFamilyFTEmp.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtNonFamilyFTEmp.ClientID%>').val(), $('#<%= txtNonFamilyFTEmp.ClientID%>'));
            });
            $('#<%= txtYear.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtYear.ClientID%>').val(), $('#<%= txtYear.ClientID%>'));
            });

            toCurrencyControl($('#<%= txtGrossSales.ClientID%>').val(), $('#<%= txtGrossSales.ClientID%>'));
            toCurrencyControl($('#<%= txtNetIncome.ClientID%>').val(), $('#<%= txtNetIncome.ClientID%>'));
            toCurrencyControl($('#<%= txtGrossPayroll.ClientID%>').val(), $('#<%= txtGrossPayroll.ClientID%>'));
            toCurrencyControl($('#<%= txtNetworth.ClientID%>').val(), $('#<%= txtNetworth.ClientID%>'));

            $('#<%= txtNetworth.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtNetworth.ClientID%>').val(), $('#<%= txtNetworth.ClientID%>'));
            });

            $('#<%= txtGrossSales.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtGrossSales.ClientID%>').val(), $('#<%= txtGrossSales.ClientID%>'));
            });

            $('#<%= txtNetIncome.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtNetIncome.ClientID%>').val(), $('#<%= txtNetIncome.ClientID%>'));
            });

            $('#<%= txtGrossPayroll.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtGrossPayroll.ClientID%>').val(), $('#<%= txtGrossPayroll.ClientID%>'));
            });

            $('#<%= dvMilestoneForm.ClientID%>').toggle($('#<%= cbAddMilestone.ClientID%>').is(':checked'));

            $('#<%= cbAddMilestone.ClientID%>').click(function () {
                $('#<%= dvMilestoneForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= txtFamilyFTEmp.ClientID%>').blur(function () {
                CalculateTotalFT();
            });
            $('#<%= txtNonFamilyFTEmp.ClientID%>').blur(function () {
                CalculateTotalFT();
            });
        });

        function CalculateTotalFT() {
            var FamilyFT = parseInt($('#<%=txtFamilyFTEmp.ClientID%>').val(), 10);
            var NonFamilyFT = parseInt($('#<%=txtNonFamilyFTEmp.ClientID%>').val(), 10);

            if (isNaN(FamilyFT)) {
                var FamilyFT = 0;
            }

            if (isNaN(NonFamilyFT)) {
                var NonFamilyFT = 0;
            }

            var Total = FamilyFT + NonFamilyFT;
            $('#<%= spnTotalFulltime.ClientID%>').text(Total);
        };

        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>


