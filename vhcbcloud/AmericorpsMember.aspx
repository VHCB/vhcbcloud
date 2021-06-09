<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AmericorpsMember.aspx.cs"
    Inherits="vhcbcloud.AmericorpsMember" MaintainScrollPositionOnPostback="true" %>

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

                <div class="panel-width" runat="server" id="dvmemberInfo">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Member Information</h3>
                                    </td>
                                    <td style="text-align: right"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvMemberInfoForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Member Name</span></td>
                                        <td class="modal-sm" style="width: 245px">&nbsp;
                                           <asp:Label ID="lblMemberName" runat="Server"></asp:Label>
                                        </td>
                                        <td style="width: 88px"><span class="labelClass">Email</span></td>
                                        <td class="modal-sm" style="width: 237px">
                                            <asp:Label ID="lblEmail" runat="Server"></asp:Label>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Cell Phone</span></td>
                                        <td class="modal-sm" style="width: 245px">
                                            <asp:Label ID="lblCellPhone" runat="Server"></asp:Label>
                                        </td>
                                        <td style="width: 88px"><span class="labelClass">DOB</span></td>
                                        <td class="modal-sm" style="width: 237px">
                                            <asp:TextBox ID="txtDOB" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtDOB">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnUpdatememberDOB" runat="server" Text="Update" class="btn btn-info"
                                                OnClick="btnUpdatememberDOB_Click" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvMemberAddress">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Address</h3>
                                    </td>
                                    <td style="text-align: right"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="Div2">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Address Type</span></td>
                                        <td class="modal-sm" style="width: 245px">&nbsp;
                                           <asp:Label ID="lblAddressType" runat="Server"></asp:Label>
                                        </td>
                                        <td style="width: 88px"><span class="labelClass">Street #</span></td>
                                        <td class="modal-sm" style="width: 155px">
                                            <asp:Label ID="lblStreetNo" runat="Server"></asp:Label>
                                        </td>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass">Address1</span>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAddress1" runat="Server"></asp:Label>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Address2</span></td>
                                        <td class="modal-sm" style="width: 245px">&nbsp;
                                           <asp:Label ID="lblAddress2" runat="Server"></asp:Label>
                                        </td>
                                        <td style="width: 88px"><span class="labelClass">City</span></td>
                                        <td class="modal-sm" style="width: 155px">
                                            <asp:Label ID="lblCity" runat="Server"></asp:Label>
                                        </td>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass">State</span>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblState" runat="Server"></asp:Label>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Zip code</span></td>
                                        <td class="modal-sm" style="width: 245px">&nbsp;
                                           <asp:Label ID="lblZip" runat="Server"></asp:Label>
                                        </td>
                                        <td style="width: 88px"><span class="labelClass">Country</span></td>
                                        <td class="modal-sm" style="width: 155px">
                                            <asp:Label ID="lblCountry" runat="Server"></asp:Label>
                                        </td>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass"></span>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfApplicantId" runat="server" />

</asp:Content>
