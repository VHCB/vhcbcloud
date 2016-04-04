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
                    <div class="panel panel-primary ">
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
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div id="dvNewProjectName" runat="server">
                    <table>
                        <tr style="float: left">
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="cbAddProjectName" CssClass="ChkBox" runat="server" Text="Add Project Name" AutoPostBack="True" OnCheckedChanged="cbProjectName_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvProjectName">
                    <div class="panel panel-primary ">
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
                    <asp:Panel runat="server" ID="pnlGrid" Width="100%" Height="150px" ScrollBars="Vertical">
                        <asp:GridView ID="gvProjectNames" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvProjectNames_RowCancelingEdit" OnRowEditing="gvProjectNames_RowEditing" OnRowUpdating="gvProjectNames_RowUpdating">
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
                                        <asp:CheckBox ID="chkDefName" runat="server" Checked='<%# Eval("DefName") %>' />
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
                                <asp:CheckBox ID="cbAddAddress" CssClass="ChkBox" runat="server" Text="Add Address" AutoPostBack="True" OnCheckedChanged="cbAddAddress_CheckedChanged" /></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvAddress">
                    <div class="panel panel-primary ">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Project Address</h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Address1:</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtAddress1" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Address2</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAddress2" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtZip" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>

                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Town</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtTown" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Village</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlVillage" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">County</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtCounty" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">State</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtState" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Defailt Address</span></td>
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
                                            <asp:CheckBox ID="cdActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
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
                                        <td style="width: 150px"><asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" /></td>
                                        <td style="width: 250px">
                                            
                                        </td>
                                        <td style="width: 150px"></td>
                                        <td style="width: 250px">
                                        </td>
                                        <td></td>
                                        <td>
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

                <div class="panel-body" id="dvAddressGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel3" Width="100%" Height="150px" ScrollBars="Vertical">
                        <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvAddress_RowCancelingEdit" OnRowEditing="gvAddress_RowEditing" OnRowUpdating="gvAddress_RowUpdating">
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
                                        <asp:CheckBox ID="chkDefName" runat="server" Checked='<%# Eval("DefName") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" />
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
                                <asp:Button ID="btnProjectUpdate" runat="server" Text="Update" class="btn btn-info" OnClick="btnProjectUpdate_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="2"></td>
                        </tr>
                    </table>
                </div>

                <asp:HiddenField ID="hfProjectId" runat="server" />
            </div>
        </div>
    </div>
    <%--        <script type="text/javascript">
        $('#<%= cbProjectName.ClientID %>').click(function () {
            if ($('#<%= cbProjectName.ClientID %>').is(":checked")) {
                $('#<%= dvProjectName.ClientID %>').show();
            }
            else {
                $('#<%= dvProjectName.ClientID %>').hide();
            }
        });
    </script>--%>
</asp:Content>
