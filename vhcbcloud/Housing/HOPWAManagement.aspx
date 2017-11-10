<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HOPWAManagement.aspx.cs" 
    Inherits="vhcbcloud.Housing.HOPWAManagement" MaintainScrollPositionOnPostback="true" EnableEventValidation="false"%>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">HOPWA Maintenance </p>
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
                            <td style="text-align: left;">
                                <span class="labelClass">Primary ASO: </span>&nbsp;&nbsp;&nbsp;
                                <span class="labelClass" id="spnPrimaryASO" runat="server"></span>
                                </td>
                            <td style="text-align: right;">
                                <asp:ImageButton ID="btnProjectNotes1" Visible="false" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>

                    <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes1"
                        CancelControlID="btnClose" BackgroundCssClass="MEBackground">
                    </ajaxToolkit:ModalPopupExtender>

                    <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                        <iframe style="width: 750px; height: 550px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                        <br />
                        <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
                    </asp:Panel>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvHOPWAMaster" visible="true">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Individual Data</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAMaster" runat="server" Text="Add New UUID" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHOPWAMasterForm">
                            <asp:Panel runat="server" ID="pnlHOPWAMaster">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">UUID</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtUUID" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 179px">
                                            <span class="labelClass">Recent Living Situation</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlLivingSituation" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">HH Includes</span></td>
                                        <td>
                                            <asp:TextBox ID="txtHHIncludes" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass"># with HIV</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtWithHIV" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 179px">
                                            <span class="labelClass"># in Household</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtInHouseHold" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"># of Minors (<18)</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMinors" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Gender</span></td>
                                        <td style="width: 250px">
                                            <%--<asp:TextBox ID="txtGender" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>--%>
                                            <asp:DropDownList ID="ddlGender" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 179px">
                                            <span class="labelClass">Age</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtAge" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Ethnicity</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlEthnicity" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Race</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlRace" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 179px">
                                            <span class="labelClass">GMI</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlGMI" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">% AMI</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlAMI" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass"># Beds</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtBeds" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 179px">
                                            <span class="labelClass">Special Needs</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlSpecialNeeds" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Active</span></td>
                                        <td> <asp:CheckBox ID="cbHOPWAMaster" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Notes</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Button ID="btnHOPWAMaster" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnHOPWAMaster_Click" /></td>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHOPWAMasterGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="500px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAMaster" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvHOPWAMaster_RowEditing" OnRowCancelingEdit="gvHOPWAMaster_RowCancelingEdit"
                                    OnRowDataBound="gvHOPWAMaster_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAID" runat="Server" Text='<%# Eval("HOPWAID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectHOPWAMaster" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectHOPWAMaster_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenHOPWAID" runat="server" Value='<%#Eval("HOPWAID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UUID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUUID" runat="Server" Text='<%# Eval("UUID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="HH Includes">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHHIncludes" runat="Server" Text='<%# Eval("HHincludes") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="# in Household">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHouseHoldNum" runat="Server" Text='<%# Eval("InHousehold") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes">
                                            <ItemTemplate>
                                                 <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
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

                <div class="panel-width" runat="server" id="dvNewHOPWAProgram" visible="true">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Type of Assistance</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddProgram" runat="server" Text="Add New Type of Assistance" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHOPWAProgramForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Type of Assistance</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Fund</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlFund" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Yr1</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbYear1" CssClass="ChkBox" runat="server" Checked="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Yr2</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbYear2" CssClass="ChkBox" runat="server" Checked="false" />
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Yr3</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:CheckBox ID="cbYear3" CssClass="ChkBox" runat="server" Checked="false" />
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Start Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">End Date</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtEndDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender2" TargetControlID="txtEndDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Active</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:CheckBox ID="cbProgramActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
                                        <td>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Notes</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtProgramNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnProgram" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnProgram_Click" /></td>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHOPWAProgramGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAProgram" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvHOPWAProgram_RowEditing" OnRowCancelingEdit="gvHOPWAProgram_RowCancelingEdit"
                                    OnRowDataBound="gvHOPWAProgram_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAProgramID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAProgramID" runat="Server" Text='<%# Eval("HOPWAProgramID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectProgram" runat="server" AutoPostBack="true" onclick="RadioCheck1(this);"
                                                    OnCheckedChanged="rdBtnSelectProgram_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenProgramId" runat="server" Value='<%#Eval("HOPWAProgramID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type of Assistance">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgram" runat="Server" Text='<%# Eval("ProgramName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFund" runat="Server" Text='<%# Eval("Fundname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="Server" Text='<%# Eval("StartDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="End Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEndDate" runat="Server" Text='<%# Eval("EndDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Yr1">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chYr1" Enabled="false" runat="server" Checked='<%# Eval("Yr1") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Yr2">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chYr2" Enabled="false" runat="server" Checked='<%# Eval("Yr2") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Yr3">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chYr3" Enabled="false" runat="server" Checked='<%# Eval("Yr3") %>' />
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

                <div class="panel-width" runat="server" id="dvNewExpenses" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Expenses / Category</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddExpense" runat="server" Text="Add another Expense" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvExpensesForm">
                            <asp:Panel runat="server" ID="Panel10">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Amount</span></td>
                                        <td style="width: 174px">
                                            <asp:TextBox ID="txtAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Date</span>
                                        </td>
                                        <td style="width: 172px">
                                             <asp:DropDownList ID="ddlExpensesDate" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                           <%-- <asp:TextBox ID="txtExpensesDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender5" TargetControlID="txtExpensesDate">
                                            </ajaxToolkit:CalendarExtender>--%>
                                        </td>
                                        <td style="width: 137px"><span class="labelClass">Disbursement Record</span></td>
                                        <td>
                                            <span class="labelClass" id="spnDisRecord" runat="server"></span>
                                            <%--<asp:TextBox ID="txtDisRecord" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <table style="width: 100%" id="tblPHP" runat="server" visible="false">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">PHP Use</span></td>
                                        <td style="width: 174px">
                                            <asp:DropDownList ID="ddlPHPuse" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass"></span>
                                        </td>
                                        <td style="width: 172px"></td>
                                        <td style="width: 137px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <table style="width: 100%" id="tblSTRMU" runat="server" visible="false">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Rent</span></td>
                                        <td style="width: 174px">
                                            <asp:CheckBox ID="cbRent" CssClass="ChkBox" runat="server" Checked="false" />
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Mortgage</span>
                                        </td>
                                        <td style="width: 172px">
                                            <asp:CheckBox ID="cbMortgage" CssClass="ChkBox" runat="server" Checked="false" />
                                        </td>
                                        <td style="width: 137px"><span class="labelClass">Utilities</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbUtilities" CssClass="ChkBox" runat="server" Checked="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Active</span></td>
                                        <td style="width: 174px">
                                            <asp:CheckBox ID="cbExpensesActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass"></span>
                                        </td>
                                        <td style="width: 172px"></td>
                                        <td style="width: 137px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAddExpense" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddExpense_Click" /></td>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvExpensesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvExpenses" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvExpenses_RowEditing" OnRowCancelingEdit="gvExpenses_RowCancelingEdit"
                                    OnRowDataBound="gvExpenses_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAExpID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAExpID" runat="Server" Text='<%# Eval("HOPWAExpID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Program">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgram" runat="Server" Text='<%# Eval("ProgramName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFooterAmount" runat="server" Text=""></asp:Label>
                                            </FooterTemplate>


                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disbursement Record">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDisbursementRecord" runat="Server" Text='<%# Eval("DisbursementRecord") %>' />
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

                <div class="panel-width" runat="server" id="dvNewHOPWARace" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">HouseHold Members Race</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWARace" runat="server" Text="Add another HH Member" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWARACEForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 93px"><span class="labelClass">Race</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHOPWARace" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 126px"><span class="labelClass">Household #</span></td>
                                        <td class="modal-sm" style="width: 77px">
                                            <asp:TextBox ID="txtHOPWAHousehold" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="4"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddRace" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddRace_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWARaceGrid" runat="server">
                             <div id="dvHOPWARaceWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblHOPWARaceWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel2" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWARace" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvHOPWARace_RowEditing" OnRowCancelingEdit="gvHOPWARace_RowCancelingEdit"
                                    OnRowUpdating="gvHOPWARace_RowUpdating" OnRowDataBound="gvHOPWARace_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWARaceID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWARaceID" runat="Server" Text='<%# Eval("HOPWARaceID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Race">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRace" runat="Server" Text='<%# Eval("RaceName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlHOPWARace1" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtRaceId" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Race") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                Total :
                                            </FooterTemplate>
                                            <%--<ItemStyle Width="500px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Household #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHousehold" runat="Server" Text='<%# Eval("HouseholdNum") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtHouseHold1" runat="Server" CssClass="clsTextBoxBlueSm" MaxLength="4"
                                                    Text='<%# Eval("HouseholdNum") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotal" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <%--<ItemStyle Width="300px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="250px" />--%>
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

                <div class="panel-width" runat="server" id="dvNewHOPWAEthnicity" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">HouseHold Members Ethnicity</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAEthnicity" runat="server" Text="Add another Ethnicity" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWAEthnicityForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 93px"><span class="labelClass">Ethnicity</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHOPWAEthnicity" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 126px"><span class="labelClass">Household #</span></td>
                                        <td class="modal-sm" style="width: 77px">
                                            <asp:TextBox ID="txtHOPWAEthnicityHH" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="4"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddEthnicity" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEthnicity_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWAEthnicityGrid" runat="server">
                             <div id="dvHOPWAEthnicityWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblHOPWAEthnicityWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAEthnicity" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvHOPWAEthnicity_RowEditing" OnRowCancelingEdit="gvHOPWAEthnicity_RowCancelingEdit"
                                    OnRowUpdating="gvHOPWAEthnicity_RowUpdating" OnRowDataBound="gvHOPWAEthnicity_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAEthnicID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAEthnicID" runat="Server" Text='<%# Eval("HOPWAEthnicID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Ethnicity">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEthnic" runat="Server" Text='<%# Eval("EthnicName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlHOPWAEthnicity1" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtEthnicId" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Ethnic") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                Total :
                                            </FooterTemplate>
                                            <%--<ItemStyle Width="500px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Household #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEthnicNum" runat="Server" Text='<%# Eval("EthnicNum") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEthnicHH1" runat="Server" CssClass="clsTextBoxBlueSm" MaxLength="4"
                                                    Text='<%# Eval("EthnicNum") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotal" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <%--<ItemStyle Width="300px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="250px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton14" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton15" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewHOPWAAge" visible="false">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Gender by Age</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAAge" runat="server" Text="Add another Age/Gender" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWAAgeForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 93px"><span class="labelClass">AgeGender</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlAgeGender" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 46px"><span class="labelClass">Number</span></td>
                                        <td class="modal-sm" style="width: 77px">
                                            <asp:TextBox ID="txtAgeNum" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="4"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="btnAddAge" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAge_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWAAgeGrid" runat="server">
                            <div id="dvHOPWAAgeWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblHOPWAAgeWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAAge" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True"
                                    OnRowEditing="gvHOPWAAge_RowEditing" OnRowCancelingEdit="gvHOPWAAge_RowCancelingEdit"
                                    OnRowUpdating="gvHOPWAAge_RowUpdating" OnRowDataBound="gvHOPWAAge_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                     <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAAgeId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAAgeId" runat="Server" Text='<%# Eval("HOPWAAgeId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="AgeGender">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAgeGender" runat="Server" Text='<%# Eval("AgeGenderName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlHOPWAAgeGender1" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtAgeGenderId" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("GenderAgeID") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                Total :
                                            </FooterTemplate>
                                            <%--<ItemStyle Width="500px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGANum" runat="Server" Text='<%# Eval("GANum") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAgeNum1" runat="Server" CssClass="clsTextBoxBlueSm" MaxLength="4"
                                                    Text='<%# Eval("GANum") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                             <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotal" Text=""></asp:Label>
                                            </FooterTemplate>
                                            <%--<ItemStyle Width="300px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                            <%--<ItemStyle Width="250px" />--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton14" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton15" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
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
        <asp:HiddenField ID="hfHOPWAId" runat="server" />
        <asp:HiddenField ID="hfProgramId" runat="server" />
        <asp:HiddenField ID="hfExpId" runat="server" />
        <asp:HiddenField ID="hfProgramName" runat="server" />
        <asp:HiddenField ID="hfProjectId" runat="server" />
        <asp:HiddenField ID="hfHouseHold" runat="server" />
        
        <asp:HiddenField ID="hfHOPWARaceWarning" runat="server" />
        <asp:HiddenField ID="hfHOPWAEthnicityWarning" runat="server" />
        <asp:HiddenField ID="hfHOPWAAgeWarning" runat="server" />
         <asp:HiddenField ID="hfAppNameId" runat="server" />
    </div>
    <script language="javascript">
        $(document).ready(function () {
            if ($('#dvExpensesForm').css('display') == 'none') {
                alert('rama');
                toCurrencyControl($('#<%= txtAmount.ClientID%>').val(), $('#<%= txtAmount.ClientID%>'));
            }

            $('#<%= ddlExpensesDate.ClientID%>').change(function () {
                $('#<%=spnDisRecord.ClientID%>').text($('#<%= ddlExpensesDate.ClientID%>').val());
            });

            $('#<%= ddlExpensesDate.ClientID%>').change(function () {
                var x = $('#<%= ddlExpensesDate.ClientID%>').value;
                console.log(x);
            });
            

            $('#<%= txtAmount.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtAmount.ClientID%>').val(), $('#<%= txtAmount.ClientID%>'));
            });

            $('#<%= dvHOPWAMasterForm.ClientID%>').toggle($('#<%= cbAddHOPWAMaster.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWAMaster.ClientID%>').click(function () {
                $('#<%= dvHOPWAMasterForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWAProgramForm.ClientID%>').toggle($('#<%= cbAddProgram.ClientID%>').is(':checked'));

            $('#<%= cbAddProgram.ClientID%>').click(function () {
                $('#<%= dvHOPWAProgramForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWARACEForm.ClientID%>').toggle($('#<%= cbAddHOPWARace.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWARace.ClientID%>').click(function () {
                $('#<%= dvHOPWARACEForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWAEthnicityForm.ClientID%>').toggle($('#<%= cbAddHOPWAEthnicity.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWAEthnicity.ClientID%>').click(function () {
                $('#<%= dvHOPWAEthnicityForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvHOPWAAgeForm.ClientID%>').toggle($('#<%= cbAddHOPWAAge.ClientID%>').is(':checked'));

            $('#<%= cbAddHOPWAAge.ClientID%>').click(function () {
                $('#<%= dvHOPWAAgeForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvExpensesForm.ClientID%>').toggle($('#<%= cbAddExpense.ClientID%>').is(':checked'));

            $('#<%= cbAddExpense.ClientID%>').click(function () {
                $('#<%= dvExpensesForm.ClientID%>').toggle(this.checked);
            }).change();

            //Input Validation
            $('#<%= txtHOPWAHousehold.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtHOPWAHousehold.ClientID%>').val(), $('#<%= txtHOPWAHousehold.ClientID%>'));
            });

            $("input[id*=txtHouseHold1]").keyup(function () {
                toNumericControl($('input[id*=txtHouseHold1]').val(), $('input[id*=txtHouseHold1]'));
            });

            $('#<%= txtHOPWAEthnicityHH.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtHOPWAEthnicityHH.ClientID%>').val(), $('#<%= txtHOPWAEthnicityHH.ClientID%>'));
            });

            $("input[id*=txtEthnicHH1]").keyup(function () {
                toNumericControl($('input[id*=txtEthnicHH1]').val(), $('input[id*=txtEthnicHH1]'));
            });

            $('#<%= txtAgeNum.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtAgeNum.ClientID%>').val(), $('#<%= txtAgeNum.ClientID%>'));
            });

            $("input[id*=txtAgeGenderId1]").keyup(function () {
                toNumericControl($('input[id*=txtAgeGenderId1]').val(), $('input[id*=txtAgeGenderId1]'));
            });

        });

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvHOPWAMaster.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }

        function RadioCheck1(rb) {
            var gv = document.getElementById("<%=gvHOPWAProgram.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
    </script>
</asp:Content>

