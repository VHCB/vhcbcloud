<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectLeadData.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Lead.ProjectLeadData" MaintainScrollPositionOnPostback="true" %>

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
                            <td style="width: 171px"></td>
                            <td style="width: 192px"></td>
                            <td></td>
                            <td style="text-align: left"></td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" Text="Award Summary" Style="border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                <%-- <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />--%>
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

                <div class="panel-width">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <table style="width: 100%">
                                <tr>
                                    <td><span class="labelClass">Project #:</span></td>
                                    <td>
                                        <span class="labelClass" id="ProjectNum" runat="server"></span>
                                    </td>
                                    <td><span class="labelClass">Name:</span></td>
                                    <td>
                                        <span class="labelClass" id="ProjName" runat="server"></span>
                                    </td>
                                    <td><span class="labelClass">Project Start Date:</span></td>
                                    <td>
                                        <span class="labelClass">&nbsp;&nbsp;</span>
                                        <asp:TextBox ID="txtProjStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtProjStartDate" TargetControlID="txtProjStartDate">
                                        </ajaxToolkit:CalendarExtender>
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">All Units Cleared Date:</span></td>
                                    <td>
                                        <span class="labelClass">&nbsp;&nbsp;</span>
                                        <asp:TextBox ID="txtAllUnitsClrDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtAllUnitsClrDate" TargetControlID="txtAllUnitsClrDate">
                                        </ajaxToolkit:CalendarExtender>
                                    </td>
                                    <td><span class="labelClass">Grant Amount: </span></td>
                                    <td>
                                        <span class="labelClass">$</span>
                                        <asp:TextBox ID="txtGrantAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">HH Intervention Amount:</span></td>
                                    <td>
                                        <span class="labelClass">$</span>
                                        <asp:TextBox ID="txtHHIntAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Loan Amount:</span></td>
                                    <td>
                                        <span class="labelClass">$</span>
                                        <asp:TextBox ID="txtLoanAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Relocation Amount:</span></td>
                                    <td><span class="labelClass">$</span>
                                        <asp:TextBox ID="txtRelocationAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Clearance De-commit:</span></td>
                                    <td>
                                        <span class="labelClass">$</span>
                                        <asp:TextBox ID="txtClearanceDeCommit" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                     <td><span class="labelClass">Total Award:</span></td>
                                    <td>
                                        <span class="labelClass">$</span>
                                        <asp:TextBox ID="txtTotalAwardAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Testing Consultant:</span></td>
                                    <td>
                                        <span class="labelClass">&nbsp;&nbsp;</span>
                                        <asp:DropDownList ID="ddlTestingConsultant" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    </td>
                                    <td><span class="labelClass">PB Contractor:</span></td>
                                    <td>
                                        <span class="labelClass">&nbsp;&nbsp;</span>
                                        <asp:DropDownList ID="ddlPBContractor" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                                    </td>
                                    <td colspan="5">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />

    <script language="javascript">
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>
