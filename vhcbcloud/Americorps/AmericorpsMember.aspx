<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AmericorpsMember.aspx.cs"
    MasterPageFile="~/Site.Master" Inherits="vhcbcloud.Americorps.AmericorpsMember" MaintainScrollPositionOnPostback="true" %>

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

                <div class="panel-width" runat="server" id="Div3">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="Div1">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Start Date</span></td>
                                        <td class="modal-sm" style="width: 245px">
                                            <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 122px"><span class="labelClass">End Date</span></td>
                                        <td class="modal-sm" style="width: 155px">
                                            <asp:TextBox ID="txtEndDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender2" TargetControlID="txtEndDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass">Slot Fulfilled</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlSlotFullFilled" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Service Type</span></td>
                                        <td class="modal-sm" style="width: 245px">
                                            <asp:DropDownList ID="ddlServiceType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 122px"><span class="labelClass">Dietary Preference</span></td>
                                        <td class="modal-sm" style="width: 155px">
                                            <asp:DropDownList ID="ddlDietryPref" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass">T-shirt size</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTShirtSize" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Sweat-shirt size</span></td>
                                        <td class="modal-sm" style="width: 245px"><asp:DropDownList ID="ddlSwatShirtSize" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 122px"><span class="labelClass"></span></td>
                                        <td class="modal-sm" style="width: 155px">
                                            <asp:Label ID="Label10" runat="Server"></asp:Label>
                                        </td>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass"></span>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Medical Concerns</span></td>
                                        <td class="modal-sm" style="width: 245px" colspan="5">
                                            <asp:TextBox ID="txtMedConcern" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="5" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"><span class="labelClass">Notes</span></td>
                                        <td class="modal-sm" style="width: 245px" colspan="5">&nbsp;<asp:TextBox ID="TextNotesBox1" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="5" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td class="modal-sm" style="width: 137px"> 
                                              <asp:Button ID="btnAddmemberData" runat="server" Text="Submit" class="btn btn-info"
                                                OnClick="btnAddmemberData_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                 <div class="panel-width" runat="server" id="Div4">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Member Form</h3>
                                    </td>
                                    <td style="text-align: right"></td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="Div5">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td class="modal-sm" style="width: 134px"><span class="labelClass">Group</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlFormGroup" CssClass="clsDropDown" runat="server" AutoPostBack="true" 
                                                OnSelectedIndexChanged="ddlFormGroup_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                         <div class="panel-body" id="dvEntityGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvACMemberForm" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvACMemberForm_RowCancelingEdit"
                                    OnRowEditing="gvACMemberForm_RowEditing" OnRowUpdating="gvACMemberForm_RowUpdating" OnRowDataBound="gvACMemberForm_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="AC Member Form ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblACmemberformID" runat="Server" Text='<%# Eval("ACmemberformID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Form Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFormName" runat="Server" Text='<%# Eval("Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Received">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReceived" runat="Server" Text='<%# Eval("Received") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkReceived" Text="Yes" runat="server" Checked='<%# Eval("Received") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                             <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                             <EditItemTemplate>
                                                <asp:TextBox ID="txtReceivedDate" CssClass="clsTextBoxBlueSm" runat="server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender2" TargetControlID="txtReceivedDate">
                                            </ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                             <ItemTemplate>
                                                <asp:Label ID="lblURL" runat="Server" Text='<%# Eval("URL") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtURL" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("URL") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Notes">
                                             <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" Text='<%# Eval("Notes") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNotes" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Notes") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEditEntity" runat="server" Checked='<%# Eval("RowIsActive") %>' />
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
        <asp:HiddenField ID="hfProjectId" runat="server" />
        <asp:HiddenField ID="hfApplicantId" runat="server" />

    </div>
</asp:Content>
