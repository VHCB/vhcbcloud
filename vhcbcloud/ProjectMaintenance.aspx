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
                                    <asp:ListItem>New    </asp:ListItem>
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

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvProjectInfo">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Project Info</h3>
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
                                            <asp:DropDownList ID="ddlProject" CssClass="clsDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged">
                                            </asp:DropDownList>
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
                                            <asp:DropDownList ID="ddlPrimaryApplicant" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Program</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Type</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlProjectType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Manager</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlManager" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Verified</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbVerified" CssClass="ChkBox" runat="server" Text="Yes" />
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Closing Date</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtClosingDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtClosingDate" TargetControlID="txtClosingDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
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
                                            <asp:DropDownList ID="ddlEventProject" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 101px"><span class="labelClass">Entity</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlEventEntity" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
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
                                        <asp:TemplateField HeaderText="Event">
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
                        </div>
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
                                        <asp:CommandField ShowEditButton="True" />
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
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectAddressForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                         <td style="width: 150px"><span class="labelClass">Address Type</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlAddressType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                         <td style="width: 100px"><span class="labelClass">Street #</span></td>
                                         <td style="width: 270px">
                                            <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox><%-- onkeyup="SetContextKey()"--%>
                                            <ajaxToolkit:AutoCompleteExtender ID="ae_txtStreetNo" runat="server" TargetControlID="txtStreetNo" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1" CompletionListCssClass="clsAutoExtDropDown"
                                                CompletionInterval="100" ServiceMethod="GetAddress1" OnClientItemSelected="GetAddressDetails" OnClientPopulated="onListPopulated">
                                            </ajaxToolkit:AutoCompleteExtender>
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
                                        <td style="width: 100px"><span class="labelClass">Zip Code</span></td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="5"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <span class="labelClass">Town</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Village</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlVillages" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">County</span></td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtCounty" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <span class="labelClass">State</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtState" CssClass="clsTextBoxBlue1" runat="server" MaxLength="2"></asp:TextBox>
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
                                        <td style="width: 170px"><span class="labelClass">Lattitude</span></td>
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
                                            <asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" /></td>
                                        <td style="width: 250px"></td>
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
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="100px" ScrollBars="Vertical">
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
                                        <asp:CommandField ShowEditButton="True" />
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
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvProjectEntityForm">
                            <asp:Panel runat="server" ID="Panel4">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 130px"><span class="labelClass">Entity Name</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDown" runat="server" OnSelectedIndexChanged="ddlApplicantName_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">Role</span></td>
                                        <td style="width: 370px">
                                            <asp:DropDownList ID="ddlApplicantRole" CssClass="clsDropDown" runat="server"></asp:DropDownList></td>
                                        <td style="width: 70px">
                                            <asp:Button ID="btnAddEntity" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEntity_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvEntityGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
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
                                        <asp:CommandField ShowEditButton="True" />
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
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvRelatedProjectsForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Related Project</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlRelatedProjects" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px">
                                            <span class="labelClass">
                                                <asp:TextBox ID="txtRelatedProjectName" CssClass="clsTextBoxBlueSm" runat="server" Width="150px"></asp:TextBox>
                                            </span>
                                        </td>
                                        <td style="width: 300px">
                                            <asp:Button ID="btnAddRelatedProject" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddRelatedProject_Click" />
                                        </td>
                                        <td style="width: 270px"></td>
                                        <td></td>
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
                                        <asp:CommandField ShowEditButton="True" />
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
            </div>
        </div>
    </div>
    <script language="javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
    <script language="javascript">
        function SetContextKey() {
            $find('<%=ae_txtStreetNo.ClientID%>').set_contextKey($get("<%=txtStreetNo.ClientID %>").value);
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
            $('#<%=ddlVillages.ClientID%>').empty();
            $('#<%=ddlVillages.ClientID%>').append($("<option></option>").val(addressArray[9]).html(addressArray[9]));
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
                getAddressInfoByZip($('#<%= txtZip.ClientID%>').val());
                $('#<%=hfVillage.ClientID%>').val('');
                LoadVillages();
            });

            $('#<%= btnAddAddress.ClientID%>').click(function () {
                //console.log($('#<%= ddlVillages.ClientID%>').val());
                $('#<%=hfVillage.ClientID%>').val($('#<%= ddlVillages.ClientID%>').val());
            });

            $('#<%= ddlRelatedProjects.ClientID%>').change(function () {
                var arr = $('#<%= ddlRelatedProjects.ClientID%>').val().split('|');
                $('#<%=txtRelatedProjectName.ClientID%>').val(arr[1]);
            });

            $('#<%= txtProjNum.ClientID%>').blur(function () {
                IsProjectNumberExist();
            });

           <%-- $('#<%= cbActiveOnly.ClientID%>').click(function (e) {
                alert('Rama');
                RefreshGrids();
            });--%>
        });

        function PopupAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= ddlProject.ClientID%>  option:selected").val())
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
