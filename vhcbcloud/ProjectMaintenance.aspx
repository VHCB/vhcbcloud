<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProjectMaintenance.aspx.cs" Inherits="vhcbcloud.ProjectMaintenance" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Project Maintenance</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table>
                        <tr style="float: left">
                            <td></td>
                            <td>
                                <asp:RadioButtonList ID="rdBtnSelection" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                    <asp:ListItem>New    </asp:ListItem>
                                    <asp:ListItem Selected="True">Existing</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                    </table>
                </div>

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
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Name</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtProjectName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
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
                                        <td style="width: 170px"><span class="labelClass">App Status</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlAppStatus" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Application Rec'd</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtApplicationReceived" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtApplicationReceived" TargetControlID="txtApplicationReceived">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Manager</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlManager" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Board Date</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlBoardDate" CssClass="clsDropDown" runat="server">
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
                                        <td style="width: 170px"><span class="labelClass">Grant Expiration Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtGrantExpirationDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtGrantExpirationDate" TargetControlID="txtGrantExpirationDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
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

                <div id="dvNewProjectStatus" runat="server">
                    <table>
                        <tr style="float: left">
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="cbAddProjectStatus" CssClass="ChkBox" runat="server" Text="Add New Status" AutoPostBack="True" OnCheckedChanged="cbAddProjectStatus_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvProjectStatus">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Project Status</h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Project Status</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlProjectStatus" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Status Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtStatusDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtStatusDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddProjectStatus" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddProjectStatus_Click" /></td>
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

                <div class="panel-body" id="dvProjectStatusGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel9" Width="100%" Height="100px" ScrollBars="Vertical">
                        <asp:GridView ID="gvProjectStatus" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="Project Status ID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProjectStatusID" runat="Server" Text='<%# Eval("ProjectStatusID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProjectStatus" runat="Server" Text='<%# Eval("ProjectStatus") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatusDate" runat="Server" Text='<%# Eval("StatusDate") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:CommandField ShowEditButton="True" />--%>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                <div id="dvNewProjectName" runat="server">
                    <table>
                        <tr style="float: left">
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="cbAddProjectName" CssClass="ChkBox" runat="server" Text="Add New Name" AutoPostBack="True" OnCheckedChanged="cbProjectName_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvProjectName">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Project Name</h3>
                        </div>
                        <div class="panel-body">
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
                    </div>
                </div>

                <div class="panel-body" id="dvProjectNamesGrid" runat="server">
                    <asp:Panel runat="server" ID="pnlGrid" Width="100%" Height="100px" ScrollBars="Vertical">
                        <asp:GridView ID="gvProjectNames" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvProjectNames_RowCancelingEdit" OnRowEditing="gvProjectNames_RowEditing" OnRowUpdating="gvProjectNames_RowUpdating"
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
                                <asp:TemplateField HeaderText="DefName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDefName" runat="Server" Text='<%# Eval("DefName") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkDefName" runat="server" Checked='<%# Eval("DefName1") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                <div id="dvNewAddress" runat="server">
                    <table>
                        <tr style="float: left">
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="cbAddAddress" CssClass="ChkBox" runat="server" Text="Add New Address" AutoPostBack="True" OnCheckedChanged="cbAddAddress_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvAddress">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Project Address</h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Address1:</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Address2</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="5"></asp:TextBox>

                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Town</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Village</span></td>
                                        <td>
                                            <asp:TextBox ID="txtVillage" CssClass="clsTextBoxBlue1" runat="server" MaxLength="35"></asp:TextBox>
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
                                        <td style="width: 100px">
                                            <span class="labelClass">State</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtState" CssClass="clsTextBoxBlue1" runat="server" MaxLength="2"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Default Address</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbDefaultAddress" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Active</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                                        </td>
                                        <td style="width: 150px"><span class="labelClass">Lattitude</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtLattitude" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass">Longitude</span></td>
                                        <td>
                                            <asp:TextBox ID="txtLongitude" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
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
                    </div>
                </div>

                <div class="panel-body" id="dvAddressGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel3" Width="100%" Height="100px" ScrollBars="Vertical">
                        <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvAddress_RowCancelingEdit1" OnRowDataBound="gvAddress_RowDataBound" OnRowEditing="gvAddress_RowEditing1" OnRowUpdating="gvAddress_RowUpdating1">
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
                                <asp:CommandField ShowEditButton="True" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                <div id="dvNewEntity" runat="server">
                    <table>
                        <tr style="float: left">
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="cbAttachNewEntity" CssClass="ChkBox" runat="server" Text="Add New Entity" AutoPostBack="True" OnCheckedChanged="cbAttachNewEntity_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvEntity">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">New Project Entity</h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel4">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 130px"><span class="labelClass">Applicant Name</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 70px">
                                            <asp:Button ID="btnAddEntity" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEntity_Click" /></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 370px"></td>
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

                <div class="panel-body" id="dvEntityGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
                        <asp:GridView ID="gvEntity" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvEntity_RowCancelingEdit" OnRowEditing="gvEntity_RowEditing" OnRowUpdating="gvEntity_RowUpdating">
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
                                <asp:TemplateField HeaderText="Applicant Name">
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
                                <asp:CommandField ShowEditButton="True" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                <div id="dvNewRelatedProjects" runat="server">
                    <table>
                        <tr style="float: left">
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="cbRelatedProjects" CssClass="ChkBox" runat="server" Text="Add Related Projects"
                                    AutoPostBack="True" OnCheckedChanged="cbRelatedProjects_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvRelatedProjects">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Related Projects</h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 180px"><span class="labelClass">Related Project</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlRelatedProjects" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRelatedProjects_SelectedIndexChanged">
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
                    </div>
                </div>

                <div class="panel-body" id="dvRelatedProjectsGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                        <asp:GridView ID="gvRelatedProjects" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false">
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
                                <%--<asp:CommandField ShowEditButton="True" />--%>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
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

                <asp:HiddenField ID="hfTown" runat="server" />
            </div>
        </div>
    </div>
    <script language="javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= txtZip.ClientID%>').blur(function () {
                getAddressInfoByZip($('#<%= txtZip.ClientID%>').val());
            });
        });

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
