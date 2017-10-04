<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectLeadMilestones.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Lead.ProjectLeadMilestones" MaintainScrollPositionOnPostback="true" %>

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
                                    <td><span class="labelClass">Milestone:</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMilestone" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Date:</span></td>
                                    <td>
                                        <asp:TextBox ID="txtDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtClearanceDate" TargetControlID="txtDate">
                                        </ajaxToolkit:CalendarExtender>
                                    </td>
                                    <td><span class="labelClass">Bldg #:</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlBldgNumber" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlBldgNumber_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td><span class="labelClass">Unit #:</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlUnitNumber" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                     <td><span class="labelClass">URL</span></td>
                                    <td>
                                         <asp:TextBox ID="txtURL" CssClass="clsTextBoxBlueSm" Width="170px" Height="22px" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Active:</span></td>
                                    <td>
                                        <asp:CheckBox ID="chkMilestoneActive" Enabled="false" runat="server" Checked="true" /></td>
                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" /></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" id="dvMilestoneGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMilestone" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="false"
                                     OnRowEditing="gvMilestone_RowEditing" OnRowCancelingEdit="gvMilestone_RowCancelingEdit" OnRowDataBound="gvMilestone_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LeadMilestoneID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLeadMilestoneID" runat="Server" Text='<%# Eval("LeadMilestoneID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMilestone" runat="Server" Text='<%# Eval("Milestone") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMSDate" runat="Server" Text='<%# Eval("MSDate") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Building #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBuilding" runat="Server" Text='<%# Eval("Building") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnit" runat="Server" Text='<%# Eval("Unit") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
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
    <asp:HiddenField ID="hfLeadMilestoneID" runat="server" />
    
    <script language="javascript">
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>
