<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventMaintenance.aspx.cs" Inherits="vhcbcloud.EventMaintenance" %>


<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Event Maintenance </p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading" style="padding: 5px 5px 5px 5px">
                    <table style="width: 100%;">
                        <tr>
                            <td></td>
                            <td style="text-align: right;">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>

                 <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvNewProjectEvent">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 5px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Events</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddProjectEvent" runat="server" Text="Add New Event" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectEventForm">
                            <asp:Panel runat="server" ID="Panel10">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Program</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlEventProgram" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlEventProgram_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 140px">
                                            <span class="labelClass">Project</span>
                                        </td>
                                        <td style="width: 237px">
                                            <asp:DropDownList ID="ddlEventProject" CssClass="clsDropDown" runat="server" AutoPostBack="true" 
                                                OnSelectedIndexChanged="ddlEventProject_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 101px"><span class="labelClass">Entity</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlEventEntity" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="txtEventEntity" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"
                                                ClientIDMode="Static" Visible="true"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtEventEntity" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetPrimaryApplicant" OnClientPopulated="onListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Event</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlEvent" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 140px">
                                            <span class="labelClass">Event SubCategory</span>
                                        </td>
                                        <td style="width: 237px">
                                            <asp:DropDownList ID="ddlEventSubCategory" CssClass="clsDropDown" runat="server">
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
                                        <td style="width: 150px"><span class="labelClass">Notes</span></td>
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
                                </table>
                            </asp:Panel>
                        </div>

                         <div class="panel-body" id="dvProjectEventGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="500px" ScrollBars="Vertical">
                                <asp:GridView ID="gvProjectEvent" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvProjectEvent_RowEditing" OnRowCancelingEdit="gvProjectEvent_RowCancelingEdit"
                                    OnRowDataBound="gvProjectEvent_RowDataBound" OnSorting="gvProjectEvent_Sorting">
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
                                        <asp:TemplateField HeaderText="Entity" SortExpression="applicantname">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApplicantName" runat="Server" Text='<%# Eval("applicantname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Event" SortExpression="Event">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEvent" runat="Server" Text='<%# Eval("Event") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date" SortExpression="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="User" SortExpression="username">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUser" runat="Server" Text='<%# Eval("username") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes" SortExpression="Notes">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active" SortExpression="RowIsActive">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePS" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
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
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfProjectEventID" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvProjectEventForm.ClientID%>').toggle($('#<%= cbAddProjectEvent.ClientID%>').is(':checked'));

             $('#<%= cbAddProjectEvent.ClientID%>').click(function () {
                 $('#<%= dvProjectEventForm.ClientID%>').toggle(this.checked);
            }).change();
        });

        <%--function onListPopulated() {
            var completionList = $find('<%=AutoCompleteExtender2.ClientID%>').get_completionList();
            completionList.style.width = 'auto';
        }--%>
    </script>
</asp:Content>
