<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="MilestonesQuickentry.aspx.cs" Inherits="vhcbcloud.MilestonesQuickentry"
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
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdBtnSelection" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                    <asp:ListItem Selected="True">Project    </asp:ListItem>
                                    <asp:ListItem>Entity</asp:ListItem>
                                </asp:RadioButtonList></td>
                            <td style="text-align: right;">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" Visible="false"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
                <div class="panel-width" runat="server" id="dvNewMilestone">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Milestones</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMilestone" runat="server" Text="Add New Milestone" Visible="false" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMilestoneForm">
                            <asp:Panel runat="server" ID="Panel10">

                                <div runat="server" id="dvEventMilestone">
                                    <div>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 128px"><span class="labelClass">Entity</span></td>
                                                <td style="width: 222px">
                                                    <asp:TextBox ID="txtEntityDDL" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"
                                                        ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender ID="EntityAE" runat="server" TargetControlID="txtEntityDDL" MinimumPrefixLength="1"
                                                        EnableCaching="true" CompletionSetCount="1"
                                                        CompletionInterval="100" ServiceMethod="GetPrimaryApplicant" OnClientPopulated="onApplicantListPopulated">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 136px"></td>
                                                <td style="width: 312px"></td>
                                                <td style="width: 119px"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div runat="server" id="dvEntity">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 128px"><span class="labelClass">Entity Milestone</span></td>
                                                <td class="modal-sm" style="width: 222px">
                                                    <asp:DropDownList ID="ddlEntityMilestone" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlEntityMilestone_SelectedIndexChanged" Height="20px" Width="185px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <div runat="server" id="dvSubEntityMilestone" visible="false">
                                                        <table>
                                                            <tr>
                                                                <td style="width: 140px"><span class="labelClass">Entity Sub Milestone</span></td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlEntitySubMilestone" CssClass="clsDropDown" runat="server" Height="20px" Width="185px">
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
                                </div>

                                <div runat="server" id="dvProjectMilestone">
                                    <div>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 128px"><span class="labelClass">Project #</span></td>
                                                <td class="modal-sm" style="width: 225px">
                                                    <asp:TextBox ID="txtProjectNumDDL" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"
                                                        ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProjectNumDDL" MinimumPrefixLength="1"
                                                        EnableCaching="true" CompletionSetCount="1"
                                                        CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 136px"><span class="labelClass">Project Name</span></td>
                                                <td style="width: 312px">
                                                    <span class="labelClass" id="spnProjectName" runat="server"></span>
                                                </td>
                                                <td style="width: 119px"><span class="labelClass">Program</span></td>
                                                <td>
                                                    <span class="labelClass" id="spnProgram" runat="server"></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </div>

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
                            </asp:Panel>
                        </div>

                        <div class="panel-heading" id="dvPMFilter" runat="server">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 100%;">
                                        <h3 class="panel-title">    &nbsp;&nbsp;&nbsp;&nbsp;</h3>
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
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="300px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMilestone" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvMilestone_RowEditing" OnRowCancelingEdit="gvMilestone_RowCancelingEdit"
                                    OnRowDataBound="gvMilestone_RowDataBound" OnRowDeleting="gvMilestone_RowDeleting">
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
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Prog MS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgramMilestone" runat="Server" Text='<%# Eval("ProgEvent") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Prog Sub MS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgramSubMilestone" runat="Server" Text='<%# Eval("ProgSubEvent") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
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
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePS" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowEditButton="True" />--%>
                                        <asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvEntityMilestoneGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="300px" ScrollBars="Vertical">
                                <asp:GridView ID="gvEntityMilestone" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvMilestone_RowEditing" OnRowCancelingEdit="gvMilestone_RowCancelingEdit"
                                    OnRowDataBound="gvMilestone_RowDataBound" OnRowDeleting="gvEntityMilestone_RowDeleting">
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
                                                <asp:Label ID="lblEntity" runat="Server" Text='<%# Eval("applicantname") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEntityMilestone" runat="Server" Text='<%# Eval("EntityMilestone") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Entity Sub Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEntitySubMilestone" runat="Server" Text='<%# Eval("EntitySubMilestone") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="190px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
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
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePS" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowEditButton="True" />--%>
                                        <asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
            <asp:HiddenField ID="hfProjectId" runat="server" />
            <asp:HiddenField ID="hfProgramId" runat="server" />
            <asp:HiddenField ID="hfProjectProgram" runat="server" />

        </div>
    </div>
    <script language="javascript">
        $(document).ready(function () {
            <%--$('#<%= dvMilestoneForm.ClientID%>').toggle($('#<%= cbAddMilestone.ClientID%>').is(':checked'));

            $('#<%= cbAddMilestone.ClientID%>').click(function () {
                $('#<%= dvMilestoneForm.ClientID%>').toggle(this.checked);
            }).change();--%>
        });
        function onApplicantListPopulated() {
            var completionList = $find('<%=EntityAE.ClientID%>').get_completionList();
             completionList.style.width = 'auto';
         }

         function GetProjectName(source, eventArgs) {
             var projectArray = eventArgs.get_value().split('|');
             $('#<%=spnProjectName.ClientID%>').text(projectArray[1]);
            $('#<%=spnProgram.ClientID%>').text(projectArray[0]);
        }
    </script>
</asp:Content>
