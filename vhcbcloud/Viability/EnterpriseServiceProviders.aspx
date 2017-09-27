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
                                        <h3 class="panel-title">Service Providers – Agreement</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddYear" runat="server" Text="Add New Application Budget" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvServiceYearForm" style="padding: 1px 1px 1px 1px">
                            <div class="panel-width" runat="server" id="dvYear">
                                <div class="panel panel-default" style="margin-bottom: 2px;">
                                    <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                                        <h3 class="panel-title"><span id="CommonFormHeader" runat="server">Year</span> </h3>
                                    </div>

                                    <div class="panel-body" style="padding: 10px 15px 0px 15px">
                                        <asp:Panel runat="server" ID="pnlCommonForm">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="width: 69px">
                                                        <span class="labelClass">Year</span>
                                                    </td>
                                                    <td style="width: 78px">
                                                        <asp:TextBox ID="txtYear" CssClass="clsTextBoxBlue1" runat="server" Height="20px" Width="60px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <div id="divErrorYear" style="display: none">
                                                            <span style="color: red">Year already exist</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 5px"></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-width" runat="server" id="Div1">
                                <div class="panel panel-default" style="margin-bottom: 2px;">
                                    <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <h3 class="panel-title">Application Budget</h3>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:CheckBox ID="cbAddNewEndOfContract" runat="server" Text="Add New End of Contract" Visible="false" />
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                    <div class="panel-body" style="padding: 10px 15px 0px 15px">
                                        <asp:Panel runat="server" ID="Panel8">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"></span></td>
                                                    <td class="modal-sm" style="width: 164px"></td>
                                                    <td style="width: 100px"></td>
                                                    <td style="width: 223px"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Business plans/Year 1  clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtBusPlans" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtBusPlanProjCost" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnBusPlanTotal" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Cash Flow/Short Term Year 1 clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtCashFlows" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtCashFlowProjCost" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnCashFlowTotal" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Year 2 clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtYr2Followup" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtYr2FollowUpProjCost" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnYest2FollowupsTotal" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Additional clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtAddEnrollees" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtAddEnrolleeProjCost" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnAddEnrolleeProjTotal" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Workshops</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtWorkshopsEvents" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtWorkShopEventProjCost" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnWorkshopsTotal" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"></span></td>
                                                    <td class="modal-sm" style="width: 164px"></td>
                                                    <td style="width: 100px"></td>
                                                    <td style="width: 223px"></td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Grand Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnGrandTotal" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass">Special Projects</span></td>
                                                    <td class="modal-sm" colspan="5">
                                                        <asp:TextBox ID="txtSplProjects" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass">Notes</span></td>
                                                    <td class="modal-sm" colspan="5">
                                                        <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <%--<tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass">Active</span></td>
                                                    <td class="modal-sm" style="width: 164px" colspan="5">
                                                        <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked="true" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>--%>
                                                <tr>
                                                    <td colspan="4" style="height: 5px">
                                                        <asp:Button ID="btnAddAppliationData" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAppliationData_Click" />
                                                        &nbsp; &nbsp;
                                                         <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-info" OnClick="btnCancel_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>

                            <div class="panel-width" runat="server" id="dvEndOfContract" visible="false">
                                <div class="panel panel-default" style="margin-bottom: 2px;">
                                    <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                                        <h3 class="panel-title"><span id="Span2" runat="server">End of Contract</span> </h3>
                                    </div>
                                    <div class="panel-body" style="padding: 10px 15px 0px 15px">
                                        <asp:Panel runat="server" ID="Panel1">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"></span></td>
                                                    <td class="modal-sm" style="width: 164px"></td>
                                                    <td style="width: 100px"></td>
                                                    <td style="width: 223px"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Business plans/Year 1 clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtBusPlans1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtBusPlanProjCost1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnBusPlanTotal1" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Cash Flow/Short Term Year 1 clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtCashFlows1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtCashFlowProjCost1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnCashFlowTotal1" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Year 2 clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtYr2Followup1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtYr2FollowUpProjCost1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnYest2FollowupsTotal1" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Additional clients</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtAddEnrollees1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtAddEnrolleeProjCost1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnAddEnrolleeProjTotal1" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"># Workshops</span></td>
                                                    <td class="modal-sm" style="width: 164px">
                                                        <asp:TextBox ID="txtWorkshopsEvents1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server" onKeyUp="javascript: return RestrictInt(this)"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <span class="labelClass">Cost per client
                                                        </span>
                                                    </td>
                                                    <td style="width: 223px">
                                                        <asp:TextBox ID="txtWorkShopEventProjCost1" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnWorkshopsTotal1" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass"></span></td>
                                                    <td class="modal-sm" style="width: 164px"></td>
                                                    <td style="width: 100px"></td>
                                                    <td style="width: 223px"></td>
                                                    <td style="width: 63px">
                                                        <span class="labelClass">Grand Total
                                                        </span>
                                                    </td>
                                                    <td style="width: 175px">
                                                        <span class="labelClass" id="spnGrandTotal1" runat="server"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass">Special Projects</span></td>
                                                    <td class="modal-sm" colspan="5">
                                                        <asp:TextBox ID="txtSplProjects1" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass">Notes</span></td>
                                                    <td class="modal-sm" colspan="5">
                                                        <asp:TextBox ID="txtNotes1" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <%--<tr>
                                                    <td class="modal-sm" style="width: 213px"><span class="labelClass">Active</span></td>
                                                    <td class="modal-sm" style="width: 164px" colspan="5">
                                                        <asp:CheckBox ID="chkActive1" Enabled="false" runat="server" Checked="true" />
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px">
                                                        <asp:Button ID="btnAddEndContractData" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEndContractData_Click" />
                                                        &nbsp; &nbsp;
                                                        <asp:Button ID="btnCancel1" runat="server" Text="Cancel" class="btn btn-info" OnClick="btnCancel_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="height: 5px"></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel-body" id="dvEntProvDataGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="250px" ScrollBars="Vertical">
                                <asp:GridView ID="gvEntProvData" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="False"
                                    OnRowEditing="gvEntProvData_RowEditing" OnRowCancelingEdit="gvEntProvData_RowCancelingEdit" OnRowDataBound="gvEntProvData_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="EnterpriseMasterServiceProvID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEnterpriseMasterServiceProvID" runat="Server" Text='<%# Eval("EnterpriseMasterServiceProvID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Year">
                                            <ItemTemplate>
                                                <asp:Label ID="lblYear" runat="Server" Text='<%# Eval("Year") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%-- <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>--%>
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetRoleAuth() %>'></asp:LinkButton>
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
    <asp:HiddenField ID="hfEnterpriseMasterServiceProvID" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvServiceYearForm.ClientID%>').toggle($('#<%= cbAddYear.ClientID%>').is(':checked'));

            $('#<%= cbAddYear.ClientID%>').click(function () {
                $('#<%= dvServiceYearForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvEndOfContract.ClientID%>').toggle($('#<%= cbAddNewEndOfContract.ClientID%>').is(':checked'));

            $('#<%= cbAddNewEndOfContract.ClientID%>').click(function () {
                $('#<%= dvEndOfContract.ClientID%>').toggle(this.checked);
                toCurrencyControl($('#<%= txtBusPlanProjCost1.ClientID%>').val(), $('#<%= txtBusPlanProjCost1.ClientID%>'));
                toCurrencyControl($('#<%= txtCashFlowProjCost1.ClientID%>').val(), $('#<%= txtCashFlowProjCost1.ClientID%>'));
                toCurrencyControl($('#<%= txtYr2FollowUpProjCost1.ClientID%>').val(), $('#<%= txtYr2FollowUpProjCost1.ClientID%>'));
                toCurrencyControl($('#<%= txtAddEnrolleeProjCost1.ClientID%>').val(), $('#<%= txtAddEnrolleeProjCost1.ClientID%>'));
                toCurrencyControl($('#<%= txtWorkShopEventProjCost1.ClientID%>').val(), $('#<%= txtWorkShopEventProjCost1.ClientID%>'));
                toCurrencyControl($('#<%= spnBusPlanTotal1.ClientID%>').val(), $('#<%= spnBusPlanTotal1.ClientID%>'));

            }).change();

            toCurrencyControl($('#<%= txtBusPlanProjCost.ClientID%>').val(), $('#<%= txtBusPlanProjCost.ClientID%>'));
            toCurrencyControl($('#<%= txtCashFlowProjCost.ClientID%>').val(), $('#<%= txtCashFlowProjCost.ClientID%>'));
            toCurrencyControl($('#<%= txtYr2FollowUpProjCost.ClientID%>').val(), $('#<%= txtYr2FollowUpProjCost.ClientID%>'));
            toCurrencyControl($('#<%= txtAddEnrolleeProjCost.ClientID%>').val(), $('#<%= txtAddEnrolleeProjCost.ClientID%>'));
            toCurrencyControl($('#<%= txtWorkShopEventProjCost.ClientID%>').val(), $('#<%= txtWorkShopEventProjCost.ClientID%>'));
            toCurrencyControl($('#<%= spnBusPlanTotal.ClientID%>').val(), $('#<%= spnBusPlanTotal.ClientID%>'));


            $('#<%= txtBusPlanProjCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtBusPlanProjCost.ClientID%>').val(), $('#<%= txtBusPlanProjCost.ClientID%>'));
            });

            $('#<%= txtCashFlowProjCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtCashFlowProjCost.ClientID%>').val(), $('#<%= txtCashFlowProjCost.ClientID%>'));
            });

            $('#<%= txtYr2FollowUpProjCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtYr2FollowUpProjCost.ClientID%>').val(), $('#<%= txtYr2FollowUpProjCost.ClientID%>'));
            });

            $('#<%= txtAddEnrolleeProjCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtAddEnrolleeProjCost.ClientID%>').val(), $('#<%= txtAddEnrolleeProjCost.ClientID%>'));
            });

            $('#<%= txtWorkShopEventProjCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtWorkShopEventProjCost.ClientID%>').val(), $('#<%= txtWorkShopEventProjCost.ClientID%>'));
            });

            //
            $('#<%= txtBusPlanProjCost1.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtBusPlanProjCost1.ClientID%>').val(), $('#<%= txtBusPlanProjCost1.ClientID%>'));
            });

            $('#<%= txtCashFlowProjCost1.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtCashFlowProjCost1.ClientID%>').val(), $('#<%= txtCashFlowProjCost1.ClientID%>'));
            });

            $('#<%= txtYr2FollowUpProjCost1.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtYr2FollowUpProjCost1.ClientID%>').val(), $('#<%= txtYr2FollowUpProjCost1.ClientID%>'));
            });

            $('#<%= txtAddEnrolleeProjCost1.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtAddEnrolleeProjCost1.ClientID%>').val(), $('#<%= txtAddEnrolleeProjCost1.ClientID%>'));
            });

            $('#<%= txtWorkShopEventProjCost1.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtWorkShopEventProjCost1.ClientID%>').val(), $('#<%= txtWorkShopEventProjCost1.ClientID%>'));
            });
        });

        var bTotal, cTotal, yTotal, aTotal, wTotal

        var txtboxs = $('#<%= txtBusPlans.ClientID%>,#<%= txtBusPlanProjCost.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtBusPlans.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtBusPlans.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtBusPlanProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtBusPlanProjCost.ClientID%>').val()).value(), 10));
                bTotal = CalculateTotal(item, cost);

                $('#<%=spnBusPlanTotal.ClientID%>').text(' $ ' + bTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal();
            });
        });

        var txtboxs = $('#<%= txtCashFlows.ClientID%>,#<%= txtCashFlowProjCost.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtCashFlows.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtCashFlows.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtCashFlowProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtCashFlowProjCost.ClientID%>').val()).value(), 10));
                cTotal = CalculateTotal(item, cost);
                $('#<%=spnCashFlowTotal.ClientID%>').text(' $ ' + cTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal();
            });
        });

        var txtboxs = $('#<%= txtYr2Followup.ClientID%>,#<%= txtYr2FollowUpProjCost.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtYr2Followup.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtYr2Followup.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtYr2FollowUpProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtYr2FollowUpProjCost.ClientID%>').val()).value(), 10));
                yTotal = CalculateTotal(item, cost);
                $('#<%=spnYest2FollowupsTotal.ClientID%>').text(' $ ' + yTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal();
            });
        });

        var txtboxs = $('#<%= txtAddEnrollees.ClientID%>,#<%= txtAddEnrolleeProjCost.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtAddEnrollees.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtAddEnrollees.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtAddEnrolleeProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtAddEnrolleeProjCost.ClientID%>').val()).value(), 10));
                aTotal = CalculateTotal(item, cost);

                $('#<%=spnAddEnrolleeProjTotal.ClientID%>').text(' $ ' + aTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal();
            });
        });

        var txtboxs = $('#<%= txtWorkshopsEvents.ClientID%>,#<%= txtWorkShopEventProjCost.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtWorkshopsEvents.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtWorkshopsEvents.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtWorkShopEventProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtWorkShopEventProjCost.ClientID%>').val()).value(), 10));
                wTotal = CalculateTotal(item, cost);

                $('#<%=spnWorkshopsTotal.ClientID%>').text(' $ ' + wTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));

                GrandTotal();
            });
        });

        function CalculateTotal(a, b) {
            var Total = a * b;
            return Total.toFixed(2);
        };

        function GrandTotal() {

            var itemb = (isNaN(parseFloat($('#<%=txtBusPlans.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtBusPlans.ClientID%>').val(), 10));
            var costb = (isNaN(parseFloat(numeral($('#<%=txtBusPlanProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtBusPlanProjCost.ClientID%>').val()).value(), 10));
            var itemc = (isNaN(parseFloat($('#<%=txtCashFlows.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtCashFlows.ClientID%>').val(), 10));
            var costc = (isNaN(parseFloat(numeral($('#<%=txtCashFlowProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtCashFlowProjCost.ClientID%>').val()).value(), 10));
            var itemy = (isNaN(parseFloat($('#<%=txtYr2Followup.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtYr2Followup.ClientID%>').val(), 10));
            var costy = (isNaN(parseFloat(numeral($('#<%=txtYr2FollowUpProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtYr2FollowUpProjCost.ClientID%>').val()).value(), 10));
            var itema = (isNaN(parseFloat($('#<%=txtAddEnrollees.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtAddEnrollees.ClientID%>').val(), 10));
            var costa = (isNaN(parseFloat(numeral($('#<%=txtAddEnrolleeProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtAddEnrolleeProjCost.ClientID%>').val()).value(), 10));
            var itemw = (isNaN(parseFloat($('#<%=txtWorkshopsEvents.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtWorkshopsEvents.ClientID%>').val(), 10));
            var costw = (isNaN(parseFloat(numeral($('#<%=txtWorkShopEventProjCost.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtWorkShopEventProjCost.ClientID%>').val()).value(), 10));


            //var busTotal = (isNaN(parseFloat(bTotal, 10)) ? 0 : parseFloat(bTotal, 10));
            //var cashTotal = (isNaN(parseFloat(cTotal, 10)) ? 0 : parseFloat(cTotal, 10));
            //var yr2Total = (isNaN(parseFloat(yTotal, 10)) ? 0 : parseFloat(yTotal, 10));
            //var addEnroleeTotal = (isNaN(parseFloat(aTotal, 10)) ? 0 : parseFloat(aTotal, 10));
            //var workShopTotal = (isNaN(parseFloat(wTotal, 10)) ? 0 : parseFloat(wTotal, 10));

            var grandTotal = (itemb * costb + itemc * costc + itema * costa + itemy * costy + itemw * costw).toFixed(2);

            $('#<%=spnGrandTotal.ClientID%>').text(' $ ' + grandTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        }

        var bTotal1, cTotal1, yTotal1, aTotal11, wTotal

        var txtboxs = $('#<%= txtBusPlans1.ClientID%>,#<%= txtBusPlanProjCost1.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtBusPlans1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtBusPlans1.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtBusPlanProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtBusPlanProjCost1.ClientID%>').val()).value(), 10));
                bTotal1 = CalculateTotal(item, cost);

                $('#<%=spnBusPlanTotal1.ClientID%>').text(' $ ' + bTotal1.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal1();
            });
        });

        var txtboxs = $('#<%= txtCashFlows1.ClientID%>,#<%= txtCashFlowProjCost1.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtCashFlows1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtCashFlows1.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtCashFlowProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtCashFlowProjCost1.ClientID%>').val()).value(), 10));
                cTotal1 = CalculateTotal(item, cost);
                $('#<%=spnCashFlowTotal1.ClientID%>').text(' $ ' + cTotal1.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal1();
            });
        });

        var txtboxs = $('#<%= txtYr2Followup1.ClientID%>,#<%= txtYr2FollowUpProjCost1.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtYr2Followup1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtYr2Followup1.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtYr2FollowUpProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtYr2FollowUpProjCost1.ClientID%>').val()).value(), 10));
                yTotal1 = CalculateTotal(item, cost);
                $('#<%=spnYest2FollowupsTotal1.ClientID%>').text(' $ ' + yTotal1.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal1();
            });
        });

        var txtboxs = $('#<%= txtAddEnrollees1.ClientID%>,#<%= txtAddEnrolleeProjCost1.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtAddEnrollees1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtAddEnrollees1.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtAddEnrolleeProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtAddEnrolleeProjCost1.ClientID%>').val()).value(), 10));
                aTotal1 = CalculateTotal(item, cost);

                $('#<%=spnAddEnrolleeProjTotal1.ClientID%>').text(' $ ' + aTotal1.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                GrandTotal1();
            });
        });

        var txtboxs = $('#<%= txtWorkshopsEvents1.ClientID%>,#<%= txtWorkShopEventProjCost1.ClientID%>');
        $.each(txtboxs, function () {
            $(this).blur(function () {
                var item = (isNaN(parseFloat($('#<%=txtWorkshopsEvents1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtWorkshopsEvents1.ClientID%>').val(), 10));
                var cost = (isNaN(parseFloat(numeral($('#<%=txtWorkShopEventProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtWorkShopEventProjCost1.ClientID%>').val()).value(), 10));
                wTotal1 = CalculateTotal(item, cost);

                $('#<%=spnWorkshopsTotal1.ClientID%>').text(' $ ' + wTotal1.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));

                GrandTotal1();
            });
        });

        function GrandTotal1() {
            var itemb = (isNaN(parseFloat($('#<%=txtBusPlans1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtBusPlans1.ClientID%>').val(), 10));
            var costb = (isNaN(parseFloat(numeral($('#<%=txtBusPlanProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtBusPlanProjCost1.ClientID%>').val()).value(), 10));
            var itemc = (isNaN(parseFloat($('#<%=txtCashFlows1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtCashFlows1.ClientID%>').val(), 10));
            var costc = (isNaN(parseFloat(numeral($('#<%=txtCashFlowProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtCashFlowProjCost1.ClientID%>').val()).value(), 10));
            var itemy = (isNaN(parseFloat($('#<%=txtYr2Followup1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtYr2Followup1.ClientID%>').val(), 10));
            var costy = (isNaN(parseFloat(numeral($('#<%=txtYr2FollowUpProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtYr2FollowUpProjCost1.ClientID%>').val()).value(), 10));
            var itema = (isNaN(parseFloat($('#<%=txtAddEnrollees1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtAddEnrollees1.ClientID%>').val(), 10));
            var costa = (isNaN(parseFloat(numeral($('#<%=txtAddEnrolleeProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtAddEnrolleeProjCost1.ClientID%>').val()).value(), 10));
            var itemw = (isNaN(parseFloat($('#<%=txtWorkshopsEvents1.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtWorkshopsEvents1.ClientID%>').val(), 10));
            var costw = (isNaN(parseFloat(numeral($('#<%=txtWorkShopEventProjCost1.ClientID%>').val()).value(), 10)) ? 0 : parseFloat(numeral($('#<%=txtWorkShopEventProjCost1.ClientID%>').val()).value(), 10));

            //var busTotal = (isNaN(parseFloat(bTotal1, 10)) ? 0 : parseFloat(bTotal1, 10));
            //var cashTotal = (isNaN(parseFloat(cTotal1, 10)) ? 0 : parseFloat(cTotal1, 10));
            //var yr2Total = (isNaN(parseFloat(yTotal1, 10)) ? 0 : parseFloat(yTotal1, 10));
            //var addEnroleeTotal = (isNaN(parseFloat(aTotal1, 10)) ? 0 : parseFloat(aTotal1, 10));
            //var workShopTotal = (isNaN(parseFloat(wTotal1, 10)) ? 0 : parseFloat(wTotal1, 10));

            //var grandTotal = (busTotal + cashTotal + yr2Total + addEnroleeTotal + workShopTotal).toFixed(2);
            var grandTotal = (itemb * costb + itemc * costc + itema * costa + itemy * costy + itemw * costw).toFixed(2);

            $('#<%=spnGrandTotal1.ClientID%>').text(' $ ' + grandTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        }
        function RestrictInt(txtBox) {
            val = txtBox.value;

            if (isNaN(val) || val.indexOf('.') > -1) {
                reVal = val.substring(0, val.length - 1);
                txtBox.value = reVal;
                return false;
            }
            return true;
        }

        $('#<%= txtYear.ClientID%>').blur(function () {
            IsYearExist();
        });

        function IsYearExist() {
            $.ajax({
                type: "POST",
                url: "EnterpriseServiceProviders.aspx/IsYearExist",
                data: '{Year: "' + $("#<%= txtYear.ClientID%>").val() + '", ProjectId:"' + $("#<%= hfProjectId.ClientID%>").val() + '" }',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var isExist = JSON.parse(data.d);
                    console.log('is year Exist :' + isExist);

                    if (isExist) {
                        $("#divErrorYear").css("display", "block");
                        $("#<%= btnAddAppliationData.ClientID%>").attr('disabled', true);
                        console.log("Year Exist")
                    }
                    else {
                        $("#divErrorYear").css("display", "none");
                        $("#<%= btnAddAppliationData.ClientID%>").attr('disabled', false);
                        console.log("Year Not Exist")
                    }

                },
                error: function (data) {
                    alert("error found");
                }
            });
        }
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>
