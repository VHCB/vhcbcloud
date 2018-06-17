<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProjectMaintenance.aspx.cs" Inherits="vhcbcloud.ProjectMaintenance"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs">
                    </ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <%-- <p class="lead">Project Maintenance</p>--%>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdBtnSelection" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                    <asp:ListItem Enabled="false">New    </asp:ListItem>
                                    <asp:ListItem Selected="True">Existing</asp:ListItem>
                                </asp:RadioButtonList></td>
                            <td style="text-align: right;">
                                <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search"
                                    Style="border: none; vertical-align: middle;" runat="server" Text="Project Search"
                                    OnClientClick="window.location.href='../ProjectSearch.aspx'; return false;"></asp:ImageButton>
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" ToolTip="Award Summary" Text="Award Summary"
                                    Style="border: none; vertical-align: middle;" Visible="false"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes1" runat="server" ImageUrl="~/Images/notes.png" Text="Project Notes"
                                    ToolTip="Project Notes" Style="border: none; vertical-align: middle;" Visible="false" />
                                <asp:ImageButton ID="btnProjectDesc" runat="server" ImageUrl="~/Images/pen.png" Text="Project Description"
                                    ToolTip="Project Description" Style="border: none; vertical-align: middle;" Visible="true" />
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>

                <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes1" CancelControlID="btnClose"
                    BackgroundCssClass="MEBackground">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                    <iframe style="width: 750px; height: 600px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                    <br />
                    <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
                </asp:Panel>

                <ajaxToolkit:ModalPopupExtender ID="mpExtender1" runat="server" PopupControlID="pnlProjectDesc" TargetControlID="btnProjectDesc"
                    CancelControlID="btnClose1"
                    BackgroundCssClass="MEBackground">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Panel ID="pnlProjectDesc" runat="server" CssClass="MEPopup1" align="center" Style="display: none">
                    <iframe style="width: 750px; height: 350px;" id="ifProjectDesc" src="ProjectDesc.aspx" runat="server"></iframe>
                    <br />
                    <asp:Button ID="btnClose1" runat="server" Text="Close" class="btn btn-info" />
                </asp:Panel>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvProjectInfo">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Project Info</h3>
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:ImageButton ID="ImgPreviousProject" ImageUrl="~/Images/Left.png" ToolTip="Previous Project"
                                            Style="border: none; vertical-align: middle;" runat="server" Text="Previous Project"
                                            OnClick="ImgPreviousProject_Click"></asp:ImageButton>
                                        <asp:ImageButton ID="ImgNextProject" ImageUrl="~/Images/Right.png" ToolTip="Next Project"
                                            Style="border: none; vertical-align: middle;" runat="server" Text="Next Project"
                                            OnClick="ImgNextProject_Click"></asp:ImageButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="pnlProjectInfo">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Number</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:MaskedEditExtender runat="server" ID="ameProjNum" Mask="9999-999-999" ClearMaskOnLostFocus="false"
                                                MaskType="Number" TargetControlID="txtProjNum">
                                            </ajaxToolkit:MaskedEditExtender>
                                            <%-- <asp:DropDownList ID="ddlProject" CssClass="clsDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged">
                                            </asp:DropDownList>--%>

                                            <asp:TextBox ID="txtProjectNumDDL" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"
                                                ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProjectNumDDL" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                            </ajaxToolkit:AutoCompleteExtender>

                                            <div id="divErrorProjectNumber" style="display: none">
                                                <span style="color: red">Project Number already exist</span>
                                            </div>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Name</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtProjectName" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtProjectName" MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetProjectName">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Primary Applicant</span></td>
                                        <td>
                                            <%--<asp:DropDownList ID="ddlPrimaryApplicant" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>--%>
                                            <asp:TextBox ID="txtPrimaryApplicant" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"
                                                ClientIDMode="Static" Visible="true"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="PrimaryApplicantAE" runat="server" TargetControlID="txtPrimaryApplicant" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetPrimaryApplicant" OnClientPopulated="onApplicantListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Program</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Type</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlProjectType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Key Staff</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlManager" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px; height: 20px;"></td>
                                        <td style="width: 250px; height: 20px;"></td>
                                        <td style="width: 100px; text-align: left; height: 20px;"><span class="labelClass">Verify: </span></td>
                                        <td style="width: 270px; height: 20px;">
                                            <asp:CheckBox ID="chkApprove" runat="server" Text="Verified" />
                                        </td>
                                        <td style="width: 170px; text-align: left; height: 20px;"><span class="labelClass">Date verified: </span></td>
                                        <td>
                                            <asp:Label ID="dtApprove" runat="server" CssClass="labelClass"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px">
                                            <asp:CheckBox ID="cbAddTBDAddress" runat="server" Checked="true" Text="Add default TBD address record" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <div id="dvConserOnly" runat="server" visible="false">
                                            <table>
                                                <tr>
                                                    <td style="width: 115px"><span class="labelClass">Project Goal</span></td>
                                                    <td style="width: 250px" colspan="4">
                                                        <asp:DropDownList ID="ddlProjectGoal" CssClass="clsDropDown" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </tr>
                                </table>
                                <div id="dvUpdate" runat="server" visible="false">
                                    <table>
                                        <tr>
                                            <td style="height: 1px">&nbsp;&nbsp;</td>
                                            <td style="height: 1px">
                                                <asp:Button ID="btnProjectUpdate" runat="server" Text="Update" class="btn btn-info" OnClick="btnProjectUpdate_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 1px" colspan="2"></td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewProjectEvent">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Milestones</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddProjectEvent" runat="server" Text="Add New Milestone" />
                                        <asp:ImageButton ID="ImgMilestoneReport" ImageUrl="~/Images/print.png" ToolTip="Milestones Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgMilestoneReport_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectEventForm">
                            <asp:Panel runat="server" ID="Panel10">
                                <div runat="server" id="dvAdmin">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 128px"><span class="labelClass">Admin Milestone</span></td>
                                            <td class="modal-sm" style="width: 222px">
                                                <asp:DropDownList ID="ddlAdminMilestone" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlAdminMilestone_SelectedIndexChanged" Height="20px" Width="185px">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <div runat="server" id="dvSubAdmin" visible="false">
                                                    <table>
                                                        <tr>
                                                            <td style="width: 140px"><span class="labelClass">Admin Sub Milestone</span></td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlAdminSubMilestone" CssClass="clsDropDown" runat="server" Height="20px" Width="185px">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div runat="server" id="dvProgram">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 128px">
                                                <span class="labelClass">Program Milestone </span>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlProgramMilestone" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlProgramMilestone_SelectedIndexChanged" Height="20px" Width="185px">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <div runat="server" id="dvSubProgram" visible="false">
                                                    <table>
                                                        <tr>
                                                            <td style="width: 140px"><span class="labelClass">Program Sub Milestone</span></td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlProgramSubMilestone" CssClass="clsDropDown" runat="server" Height="20px" Width="185px">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>

                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 128px"><span class="labelClass">Date</span></td>
                                        <td style="width: 224px">
                                            <asp:TextBox ID="txtEventDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtEventDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 136px"><span class="labelClass">URL</span></td>
                                        <td style="width: 319px">
                                            <asp:TextBox ID="txtURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass"></span></td>
                                        <td>
                                            <%--<asp:CheckBox ID="chkProjectEventActive" Enabled="false" runat="server" Checked="true" />--%>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 80px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="height: 5px">
                                            <asp:Button ID="btnAddMilestone" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddMilestone_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>

                                <%-- <table style="width: 100%">

                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Admin Milestone</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlEvent" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEvent_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 140px">
                                            <span class="labelClass">Program Milestone </span>
                                        </td>
                                        <td style="width: 237px">
                                            <asp:DropDownList ID="ddlEventSubCategory" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEventSubCategory_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 101px"><span class="labelClass">Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtEventDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtEventDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Comments</span></td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="605px" Height="49px" />
                                        </td>
                                        <td><span class="labelClass">Active:</span></td>
                                        <td>
                                            <asp:CheckBox ID="chkProjectEventActive" Enabled="false" runat="server" Checked="true" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="height: 5px">
                                            <asp:Button ID="btnAddEvent" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEvent_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>--%>
                            </asp:Panel>
                        </div>
                        <div class="panel-heading" id="dvPMFilter" runat="server">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 100%;">
                                        <h3 class="panel-title">&nbsp;&nbsp;&nbsp;&nbsp;</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:RadioButtonList ID="rdGrid" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                            OnSelectedIndexChanged="rdGrid_SelectedIndexChanged">
                                            <asp:ListItem Selected="True">All    </asp:ListItem>
                                            <asp:ListItem>Admin </asp:ListItem>
                                            <asp:ListItem>Program  </asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" id="dvMilestoneGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel8" Width="100%" Height="100px" ScrollBars="None">
                                <asp:GridView ID="gvMilestone" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvMilestone_RowEditing" OnRowCancelingEdit="gvMilestone_RowCancelingEdit"
                                    OnRowDataBound="gvMilestone_RowDataBound" OnRowUpdating="gvMilestone_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Project Event ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectEventID" runat="Server" Text='<%# Eval("ProjectEventID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Admin MS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEvent" runat="Server" Text='<%# Eval("Event") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Admin Sub MS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAdminSubMilestone" runat="Server" Text='<%# Eval("SubEvent") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="130px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Prog MS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgramMilestone" runat="Server" Text='<%# Eval("ProgEvent") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Prog Sub MS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgramSubMilestone" runat="Server" Text='<%# Eval("ProgSubEvent") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="80px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="130px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowEditButton="True" />
                                        <asp:CommandField ShowEditButton="True" Visible='<%# GetRoleAuth() %>' />--%>
                                        <%--<asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />--%>

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

                        <%-- <div class="panel-body" id="dvProjectEventGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProjectEvent" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvProjectEvent_RowEditing" OnRowCancelingEdit="gvProjectEvent_RowCancelingEdit"
                                    OnRowDataBound="gvProjectEvent_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Project Event ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectEventID" runat="Server" Text='<%# Eval("ProjectEventID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApplicantName" runat="Server" Text='<%# Eval("applicantname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPM" runat="Server" Text='<%# Eval("SubEvent") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Program Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEvent" runat="Server" Text='<%# Eval("Event") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="User">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUser" runat="Server" Text='<%# Eval("username") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePS" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>--%>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewProjectName">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Names</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddProjectName" runat="server" Text="Add New Name" />
                                        <asp:ImageButton ID="ImgNames" ImageUrl="~/Images/print.png" ToolTip="Names Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgNames_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectNameForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 50px"><span class="labelClass">Name</span></td>
                                        <td style="width: 350px">
                                            <asp:TextBox ID="txtProject_Name" CssClass="clsTextBoxBlueSm" runat="server" Width="298px"></asp:TextBox>
                                        </td>
                                        <td style="width: 70px">
                                            <span class="labelClass">
                                                <asp:CheckBox ID="cbDefName" CssClass="ChkBox" runat="server" Text="Default" Checked="true" /></span>
                                        </td>
                                        <td style="width: 300px">
                                            <asp:Button ID="btnAddProjectName" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddProjectName_Click" />
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

                        <div class="panel-body" id="dvProjectNamesGrid" runat="server">
                            <asp:Panel runat="server" ID="pnlGrid" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProjectNames" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvProjectNames_RowCancelingEdit"
                                    OnRowEditing="gvProjectNames_RowEditing" OnRowUpdating="gvProjectNames_RowUpdating"
                                    OnRowDataBound="gvProjectNames_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Type Id" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTypeId" runat="Server" Text='<%# Eval("TypeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDescription" runat="Server" CssClass="clsApplicantBlue" Text='<%# Eval("Description") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Default Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDefName" runat="Server" Text='<%# Eval("DefName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkDefNamePN" runat="server" Checked='<%# Eval("DefName1") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePN" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEditPN" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowEditButton="True" />--%>

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

                <div class="panel-width" runat="server" id="dvNewAddress">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Addresses</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAddress" runat="server" Text="Add New Address" />
                                    </td>
                                    <td style="text-align: right; width: 25px;">
                                        <asp:ImageButton ID="ImgButtonAddressReport" ImageUrl="~/Images/print.png" ToolTip="Address Report"
                                            Style="border: none; vertical-align: middle;" runat="server" Text="Project Search" OnClick="ImgButtonAddressReport_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectAddressForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Address Type</span></td>
                                        <td style="width: 250px"><span class="labelClass">Physical Location</span>
                                            <%-- <asp:DropDownList ID="ddlAddressType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>--%>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">Street #</span></td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox><%-- onkeyup="SetContextKey()"--%>
                                            <ajaxToolkit:AutoCompleteExtender ID="ae_txtStreetNo" runat="server" TargetControlID="txtStreetNo" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1" CompletionListCssClass="clsAutoExtDropDown"
                                                CompletionInterval="100" ServiceMethod="GetAddress1" OnClientItemSelected="GetAddressDetails" OnClientPopulated="onListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
                                            <asp:CheckBox ID="cbReqStreetNo" runat="server" Checked="true" ToolTip="Required Street #" />
                                        </td>
                                        <td style="width: 170px">
                                            <span class="labelClass">Address1:</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px">
                                            <span class="labelClass">Address2</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">Town</span></td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                            
                                        </td>
                                        <td style="width: 170px">
                                            <span class="labelClass">Village</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlVillages" CssClass="clsDropDown" runat="server" Visible="false">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtVillage" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtVillage" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetAllVillages">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">County</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtCounty" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">State</span></td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtState" CssClass="clsTextBoxBlue1" runat="server" MaxLength="2"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <span class="labelClass">Zip Code</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="5"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Default Address</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbDefaultAddress" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">Active</span></td>
                                        <td style="width: 270px">
                                            <asp:CheckBox ID="cbActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Latitude</span></td>
                                        <td>
                                            <asp:TextBox ID="txtLattitude" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Longitude</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtLongitude" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 150px">
                                            <asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" />
                                        </td>
                                        <td style="width: 250px">
                                            <asp:Button ID="btnGetLatLong" runat="server" Text="Get Lat Long" class="btn btn-info" OnClick="btnGetLatLong_Click" />
                                        </td>
                                        <td style="width: 150px"></td>
                                        <td style="width: 250px"></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAddressGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="100px" ScrollBars="None">
                                <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvAddress_RowCancelingEdit1" OnRowDataBound="gvAddress_RowDataBound"
                                    OnRowEditing="gvAddress_RowEditing1" OnRowUpdating="gvAddress_RowUpdating1">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Address Id" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddressId" runat="Server" Text='<%# Eval("AddressId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddressType" runat="Server" Text='<%# Eval("AddressType") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="St.##">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStreetNum" runat="Server" Text='<%# Eval("Street#") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address1">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress1" runat="Server" Text='<%# Eval("Address1") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress2" runat="Server" Text='<%# Eval("Address2") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Town/Village">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTown" runat="Server" Text='<%# Eval("Town") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="County">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCounty" runat="Server" Text='<%# Eval("County") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="State">
                                            <ItemTemplate>
                                                <asp:Label ID="lblState" runat="Server" Text='<%# Eval("State") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Default">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDefault" runat="Server" Text='<%# Eval("PrimaryAdd") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowEditButton="True" />--%>

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

                <div class="panel-width" runat="server" id="dvNewEntity">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Entities</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAttachNewEntity" runat="server" Text="Add New Entity" />
                                        <asp:ImageButton ID="ImgEntity" ImageUrl="~/Images/print.png" ToolTip="Entities Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgEntity_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectEntityForm">
                            <asp:Panel runat="server" ID="Panel4">
                                <table style="width: 100%">
                                    <tr>
                                        <td><span class="labelClass">Entity Role</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlEntityRole" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Entity Name</span></td>
                                        <td>
                                            <%-- <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDown" runat="server" OnSelectedIndexChanged="ddlApplicantName_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>--%>
                                            <asp:TextBox ID="txtEntityDDL" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"
                                                ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');" onkeyup="SetEntityContextKey()"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="EntityAE" runat="server" TargetControlID="txtEntityDDL" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                UseContextKey="true" CompletionInterval="100" ServiceMethod="GetEntitiesByRole" OnClientPopulated="onEntityListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td><span class="labelClass">Role</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlApplicantRole" CssClass="clsDropDown" runat="server"></asp:DropDownList></td>
                                        <td>
                                            <asp:Button ID="btnAddEntity" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEntity_Click" /></td>

                                    </tr>
                                    <tr>
                                        <td colspan="7" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvEntityGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="None">
                                <asp:GridView ID="gvEntity" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvEntity_RowCancelingEdit"
                                    OnRowEditing="gvEntity_RowEditing" OnRowUpdating="gvEntity_RowUpdating" OnRowDataBound="gvEntity_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Project Applicant Id" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectApplicantID" runat="Server" Text='<%# Eval("ProjectApplicantID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Applicant Id">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperLink1" runat="server" target='_blank' 
                                                    NavigateUrl='<%# String.Format("~/EntityMaintenance.aspx?IsSearch=true&ApplicantId={0}&Role={1}", Eval("ApplicantId"), Eval("LKEntityType2")) %>'><%# Eval("ApplicantId") %></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblapplicantname" runat="Server" Text='<%# Eval("applicantname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Email">
                                            <ItemTemplate>
                                                <asp:Label ID="lblemail" runat="Server" Text='<%# Eval("email") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Phone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhone" runat="Server" Text='<%# Eval("Phone") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Role">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLKApplicantRole" runat="Server" Text='<%# Eval("ApplicantRoleDescription") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlLkApplicantRoleEntity" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtLkApplicantRoleEntity" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("LkApplicantRole") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Applicant">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIsApplicant" runat="Server" Text='<%# Eval("IsApplicant1") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkIsApplicant" Text="Yes" runat="server" Checked='<%# Eval("IsApplicant") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Payee">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFinLegal" runat="Server" Text='<%# Eval("FinLegal1") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkFinLegal" Text="Yes" runat="server" Checked='<%# Eval("FinLegal") %>' />
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
                                        <%--<asp:CommandField ShowEditButton="True" />--%>

                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="w9" Visible="false">
                                           <ItemTemplate>
                                                <asp:CheckBox ID="chkw9" Enabled="false" runat="server" Checked='<%# Eval("w9") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkw9" runat="server" Checked='<%# Eval("w9") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewRelatedProjects">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Related Projects</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbRelatedProjects" runat="server" Text="Add Related Projects" />
                                        <asp:ImageButton ID="ImgRelatedProjests" ImageUrl="~/Images/print.png" ToolTip="Related Projects Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgRelatedProjests_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvRelatedProjectsForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Related Project Number</span></td>
                                        <td style="width: 250px">
                                            <%--                                            <asp:DropDownList ID="ddlRelatedProjects" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>--%>
                                            <asp:TextBox ID="txtRelatedProjects" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtRelatedProjects" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetProjectNumbersWithName" OnClientItemSelected="GetRelatedProjectName">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td style="width: 230px">
                                            <span class="labelClass">
                                                <asp:TextBox ID="txtRelatedProjectName" CssClass="clsTextBoxBlueSm" runat="server" Width="150px" ReadOnly="true"></asp:TextBox>
                                            </span>
                                        </td>
                                        <td style="width: 200px"> <asp:CheckBox ID="chkDualGoal" runat="server" Text="Dual Goal" /></td>
                                        <td></td>
                                        <td style="width: 300px">
                                            <asp:Button ID="btnAddRelatedProject" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddRelatedProject_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvRelatedProjectsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvRelatedProjects" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvRelatedProjects_RowCancelingEdit" OnRowEditing="gvRelatedProjects_RowEditing" OnRowUpdating="gvRelatedProjects_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Related Project Id" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRelProjectId" runat="Server" Text='<%# Eval("RelProjectId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project#">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectNumber" runat="Server" Text='<%# Eval("Proj_num") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Dual Goal">
                                            <ItemTemplate>
                                                 <asp:CheckBox ID="chkDualGoalD" Enabled="false" runat="server" Checked='<%# Eval("DualGoal") %>' />
                                            </ItemTemplate>
                                             <EditItemTemplate>
                                                <asp:CheckBox ID="chkDualGoal" runat="server" Checked='<%# Eval("DualGoal") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Program">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgram" runat="Server" Text='<%# Eval("Program") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEditPR" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowEditButton="True" />--%>

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

                <div id="dvSubmit" runat="server">
                    <br />
                    <table>
                        <tr>
                            <td style="height: 5px">&nbsp;&nbsp;&nbsp;</td>
                            <td style="height: 5px">
                                <asp:Button ID="btnProjectSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnProjectSubmit_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="2"></td>
                        </tr>
                    </table>
                </div>

                <asp:HiddenField ID="hfProjectId" runat="server" />
                <asp:HiddenField ID="hfAddressId" runat="server" />
                <asp:HiddenField ID="hfProgramId" runat="server" />
                <asp:HiddenField ID="hfVillage" runat="server" />
                <asp:HiddenField ID="hfProjectEventID" runat="server" />
                <asp:HiddenField ID="hfIsVerified" runat="server" />
                <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />
                
            </div>
        </div>
    </div>
    <script language="javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="Scripts/jquery.min.js"></script> 
    <script type="text/javascript" src="Scripts/jquery-ui.min.js"></script>
    <script type="text/javascript" src="Scripts/gridviewScroll.min.js"></script>
    <script language="javascript">
        function SetContextKey() {
            $find('<%=ae_txtStreetNo.ClientID%>').set_contextKey($get("<%=txtStreetNo.ClientID %>").value);
        }

        function onApplicantListPopulated() {
            var completionList = $find('<%=PrimaryApplicantAE.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }

        function onEntityListPopulated() {
            var completionList = $find('<%=EntityAE.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }

        function onListPopulated() {
            var completionList = $find('<%=ae_txtStreetNo.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
            //completionList.style.css = 'clsAutoExtDropDownListItem';
        }

        function GetAddressDetails(source, eventArgs) {
            //alert(' Key : ' + eventArgs.get_text() + '  Value :  ' + eventArgs.get_value());
            var addressArray = eventArgs.get_value().split('~');
            $('#<%=txtStreetNo.ClientID%>').val(addressArray[0]);
            $('#<%=txtAddress1.ClientID%>').val(addressArray[1]);
            $('#<%=txtAddress2.ClientID%>').val(addressArray[2]);
            $('#<%=txtState.ClientID%>').val(addressArray[3]);
            $('#<%=txtZip.ClientID%>').val(addressArray[4]);
            $('#<%=txtTown.ClientID%>').val(addressArray[5]);
            $('#<%=txtCounty.ClientID%>').val(addressArray[6]);
            $('#<%=txtLattitude.ClientID%>').val(addressArray[7]);
            $('#<%=txtLongitude.ClientID%>').val(addressArray[8]);
            $('#<%=txtVillage.ClientID%>').val(addressArray[9]);
            $('#<%=ddlVillages.ClientID%>').empty();
            $('#<%=ddlVillages.ClientID%>').append($("<option></option>").val(addressArray[9]).html(addressArray[9]));
        }

        function GetRelatedProjectName(source, eventArgs) {
            //var relatedProjectArray = eventArgs.get_value().split('~');
            //$('#<%=txtRelatedProjects.ClientID%>').val(relatedProjectArray[0]);
            $('#<%=txtRelatedProjectName.ClientID%>').val(eventArgs.get_value());
        }

        $(document).ready(function () {
            $('#<%= dvProjectEventForm.ClientID%>').toggle($('#<%= cbAddProjectEvent.ClientID%>').is(':checked'));
            $('#<%= dvProjectNameForm.ClientID%>').toggle($('#<%= cbAddProjectName.ClientID%>').is(':checked'));
            $('#<%= dvProjectAddressForm.ClientID%>').toggle($('#<%= cbAddAddress.ClientID%>').is(':checked'));
            $('#<%= dvProjectEntityForm.ClientID%>').toggle($('#<%= cbAttachNewEntity.ClientID%>').is(':checked'));
            $('#<%= dvRelatedProjectsForm.ClientID%>').toggle($('#<%= cbRelatedProjects.ClientID%>').is(':checked'));

            $('#<%= cbAddProjectEvent.ClientID%>').click(function () {
                $('#<%= dvProjectEventForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddProjectName.ClientID%>').click(function () {
                $('#<%= dvProjectNameForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddAddress.ClientID%>').click(function () {
                $('#<%= dvProjectAddressForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAttachNewEntity.ClientID%>').click(function () {
                $('#<%= dvProjectEntityForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbRelatedProjects.ClientID%>').click(function () {
                $('#<%= dvRelatedProjectsForm.ClientID%>').toggle(this.checked);
            }).change();


            $('#<%= txtZip.ClientID%>').blur(function () {
                // getAddressInfoByZip($('#<%= txtZip.ClientID%>').val());
                $('#<%=hfVillage.ClientID%>').val('');

                LoadVillages();
            });

            $('#<%= btnAddAddress.ClientID%>').click(function () {
                //console.log($('#<%= ddlVillages.ClientID%>').val());
                $('#<%=hfVillage.ClientID%>').val($('#<%= ddlVillages.ClientID%>').val());
            });

            <%--$('#<%= ddlRelatedProjects.ClientID%>').change(function () {
                var arr = $('#<%= ddlRelatedProjects.ClientID%>').val().split('|');
                $('#<%=txtRelatedProjectName.ClientID%>').val(arr[1]);
            });--%>

            $('#<%= txtProjNum.ClientID%>').blur(function () {
                IsProjectNumberExist();
            });
            gridviewScroll(<%=gvMilestone.ClientID%>);
            gridviewScroll(<%=gvAddress.ClientID%>);
            gridviewScroll(<%=gvEntity.ClientID%>);
        
           <%-- $('#<%= cbActiveOnly.ClientID%>').click(function (e) {
                alert('Rama');
                RefreshGrids();
            });--%>
        });

        function gridviewScroll(gridId) {
            $(gridId).gridviewScroll({
                width: 981,
                height: 100
            });
        }
       
        function PopupAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjectId.ClientID%>").val())
        };

        function IsProjectNumberExist() {
            $.ajax({
                type: "POST",
                url: "ProjectMaintenance.aspx/IsProjectNumberExist",
                data: '{ProjectNumber: "' + $("#<%= txtProjNum.ClientID%>").val() + '" }',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var isExist = JSON.parse(data.d);
                    console.log('is Project Number Exist :' + isExist);

                    if (isExist)
                        $("#divErrorProjectNumber").css("display", "block");
                    else
                        $("#divErrorProjectNumber").css("display", "none");

                },
                error: function (data) {
                    alert("error found");
                }
            });
        }

        function LoadVillages() {
            $.ajax({
                type: "POST",
                url: "ProjectMaintenance.aspx/BindDropdownlist",
                data: '{zip: "' + $("#<%=txtZip.ClientID%>").val() + '" }',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    console.log('jsdata :' + jsdata);

                    $('#<%=ddlVillages.ClientID%>').empty();

                    $.each(jsdata, function (key, value) {

                       <%-- if(key = 0)
                        $('#<%=ddlVillages.ClientID%>')
                            .append($("<option></option>").val(value.ID).html(value.Name).attr("selected", "selected"));--%>

                        $('#<%=ddlVillages.ClientID%>')
                            .append($("<option></option>").val(value.ID).html(value.Name));

                        //$('#<%=hfVillage.ClientID%>').val(value.Name);

                        if (value.Name != 'Select')
                            $('#<%=txtVillage.ClientID%>').val(value.Name);
                    });
                },
                error: function (data) {
                    alert("error found");
                }
            });
        }

        function OnSuccess(result) {
            if (result) {
                console.log('OnSuccess');
            }
        }

        function OnFailure(error) {
            console.log('OnFailure');
        }

        function getLocation() {
            getAddressInfoByZip(document.forms[0].zip.value);
        }

        function response(obj) {
            console.log(obj);
        }

        function SetEntityContextKey() {
            $find('<%=EntityAE.ClientID%>').set_contextKey($('#<%= ddlEntityRole.ClientID%>').val());
        }

        function getAddressInfoByZip(zip) {
            $('#<%= txtTown.ClientID%>').val('');
            $('#<%= txtState.ClientID%>').val('');
            $('#<%= txtCounty.ClientID%>').val('');
            if (zip.length >= 5 && typeof google != 'undefined') {
                var addr = {};
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': zip }, function (results, status) {

                    if (status == google.maps.GeocoderStatus.OK) {
                        //console.log(JSON.stringify(results[0]));
                        console.log(JSON.stringify(results[0].geometry.location.lat));
                        if (results.length >= 1) {
                            for (var ii = 0; ii < results[0].address_components.length; ii++) {
                                var street_number = route = street = city = state = zipcode = country = formatted_address = '';
                                var types = results[0].address_components[ii].types.join(",");
                                if (types == "street_number") {
                                    addr.street_number = results[0].address_components[ii].long_name;
                                }
                                if (types == "route" || types == "point_of_interest,establishment") {
                                    addr.route = results[0].address_components[ii].long_name;
                                }
                                if (types == "sublocality,political" || types == "locality,political" || types == "neighborhood,political" || types == "administrative_area_level_3,political") {
                                    addr.city = (city == '' || types == "locality,political") ? results[0].address_components[ii].long_name : city;
                                    $('#<%= txtTown.ClientID%>').val(addr.city);
                                }
                                if (types == "administrative_area_level_1,political") {
                                    addr.state = results[0].address_components[ii].short_name;
                                    $('#<%= txtState.ClientID%>').val(addr.state);
                                }
                                if (types == "postal_code" || types == "postal_code_prefix,postal_code") {
                                    addr.zipcode = results[0].address_components[ii].long_name;
                                }
                                if (types == "country,political") {
                                    addr.country = results[0].address_components[ii].long_name;
                                }
                                if (types == "administrative_area_level_2,political") {
                                    addr.county = results[0].address_components[ii].short_name;
                                    $('#<%= txtCounty.ClientID%>').val(addr.county.replace('County', ''));
                                }
                            }
                            addr.success = true;
                            $('#<%= txtLattitude.ClientID%>').val(results[0].geometry.location.lat());
                            $('#<%= txtLongitude.ClientID%>').val(results[0].geometry.location.lng());

                            for (name in addr) {
                                console.log('### google maps api ### ' + name + ': ' + addr[name]);
                            }
                            response(addr);

                            $('#<%= txtVillage.ClientID%>').attr("disabled", "disabled");
                            $('#<%=txtVillage.ClientID%>').val('');

                            if ($('#<%= txtState.ClientID%>').val() == 'VT') {
                                $('#<%= txtVillage.ClientID%>').removeAttr("disabled");
                                LoadVillages();
                            }
                        } else {
                            response({ success: false });
                        }
                    } else {
                        response({ success: false });
                    }
                });
            } else {
                response({ success: false });
            }
        }
    </script>
</asp:Content>
