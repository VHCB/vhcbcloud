<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="GrantMaintenance.aspx.cs" Inherits="vhcbcloud.GrantMaintenance"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Grant Maintenance </p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <h3 class="panel-title">Grant Search</h3>
                            </td>
                            <td style="text-align: right;">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div id="dvFund" runat="server">
                    <table>
                        <tr>
                            <td colspan="6" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 115px"><span class="labelClass">VHCB Name</span></td>
                            <td style="width: 180px">
                                <asp:TextBox ID="txtVHCBNameSearch" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 90px"><span class="labelClass">Program</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlProgramSearch" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 100px"><span class="labelClass">Grant Agency</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlGrantAgencySearch" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 80px"><span class="labelClass">Grantor</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlGrantor" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 1px"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 30px"></td>
                            <td style="height: 10px">
                                <asp:Button ID="btnGrantSearch" runat="server" Text="Search" class="btn btn-info"
                                    OnClick="btnGrantSearch_Click" /></td>
                            <td colspan="4" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 15px"></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvNewGrantInfo">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Grant Info</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddGrantInfo" runat="server" Text="Add New Grant Info" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvGrantInfoForm">
                            <asp:Panel runat="server" ID="Panel10">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">VHCB Name</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtVHCBName" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 140px">
                                            <span class="labelClass">Award Amt</span>
                                        </td>
                                        <td style="width: 237px">
                                            <asp:TextBox ID="txtAwardAmt" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 101px"><span class="labelClass">Begin Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtBeginDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtBeginDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">End Date</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtEndDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender" TargetControlID="txtEndDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 140px">
                                            <span class="labelClass">Granting Agency</span>
                                        </td>
                                        <td style="width: 237px">
                                            <asp:DropDownList ID="ddlGrantingAgency" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 101px"><span class="labelClass">Grant Name</span></td>
                                        <td>
                                            <asp:TextBox ID="txtGrantName" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Grantor Contact</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlGrantorContact" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Award #</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAwardNum" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass">CFDA #</span></td>
                                        <td>
                                            <asp:TextBox ID="txtCFDANum" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Grant Type</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlGrantType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Staff</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlStaff" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Program</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Federal Funds</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbFederalFunds" runat="server" />
                                        </td>
                                        <td><span class="labelClass">Admin</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbAdmin" runat="server" />
                                        </td>
                                        <td><span class="labelClass">Match</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbMatch" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Funds Received/Available</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbFundsReceived" runat="server" />
                                        </td>
                                        <td><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbFundActive" Enabled="false" runat="server" Checked="true" />
                                        </td>
                                        <td><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="height: 5px">
                                            <asp:Button ID="btnGrantInfo" runat="server" Text="Add" class="btn btn-info" OnClick="btnGrantInfo_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvGrantInfoGrid" runat="server" visible="false">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvGrantInfo" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvGrantInfo_RowEditing" OnRowCancelingEdit="gvGrantInfo_RowCancelingEdit"
                                    OnRowDataBound="gvGrantInfo_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="GrantinfoID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrantinfoID" runat="Server" Text='<%# Eval("GrantinfoID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectGrantinfo" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectGrantinfo_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenGrantinfoID" runat="server" Value='<%#Eval("GrantinfoID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="GrantName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrantName" runat="Server" Text='<%# Eval("GrantName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VHCB Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCBName" runat="Server" Text='<%# Eval("VHCBName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
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

                <div class="panel-width" runat="server" id="dvNewAttachedFunds" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Attached Funds</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAttachedFunds" runat="server" Text="Add to Fund" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAttachedFundsForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Fund Name</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlFundName" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFundName_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">Fund</span>
                                        </td>
                                        <td style="width: 167px">
                                            <asp:DropDownList ID="ddlFund" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFund_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddAttachFund" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddAttachFund_Click" Style="margin-left: 0" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAttachedFundsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAttachedFunds" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="false"
                                    OnRowEditing="gvAttachedFunds_RowEditing" OnRowCancelingEdit="gvAttachedFunds_RowCancelingEdit"
                                    OnRowUpdating="gvAttachedFunds_RowUpdating" OnRowDataBound="gvAttachedFunds_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="FundGrantinfoID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundGrantinfoID" runat="Server" Text='<%# Eval("FundGrantinfoID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FundName") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundID" runat="Server" Text='<%# Eval("FundID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewFyAmounts" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Fiscal Year Amounts</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddFyAmounts" runat="server" Text="Add to Fiscal Year Amount" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvFyAmountsForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Fiscal Year</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlFyYear" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFundName_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">Amount</span>
                                        </td>
                                        <td style="width: 167px">
                                            <asp:TextBox ID="txtFyAmt" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnFyAmt" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnFyAmt_Click" Style="margin-left: 0" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvFyAmountsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel5" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvFyAmounts" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="false"
                                    OnRowEditing="gvFyAmounts_RowEditing" OnRowCancelingEdit="gvFyAmounts_RowCancelingEdit"
                                    OnRowUpdating="gvFyAmounts_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="GrantInfoFY" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrantInfoFY" runat="Server" Text='<%# Eval("GrantInfoFY") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Year">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLkYear" runat="Server" Text='<%# Eval("Year") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("Amount", "{0:c2}") %>'/>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtFyAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount", "{0:0.00}") %>'>
                                                </asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewMilestones" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Milestones</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMilestone" runat="server" Text="Add New Milestone" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMilestonesForm">
                            <asp:Panel runat="server" ID="Panel6">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 96px"><span class="labelClass">Grant Milestone</span></td>
                                        <td style="width: 214px">
                                            <asp:DropDownList ID="ddlMilestone" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">Date</span>
                                        </td>
                                        <td style="width: 239px">
                                            <asp:TextBox ID="txtMilestoneDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender2" TargetControlID="txtMilestoneDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 44px">
                                            <span class="labelClass">URL</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtURL" CssClass="clsTextBoxBlueSm" Width="170px" Height="22px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 96px"><span class="labelClass">Note</span></td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtNote" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="480px" Height="80px" />
                                        </td>
                                        <td style="width: 44px"><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbMilestoneActive" Enabled="false" runat="server" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 96px">
                                            <asp:Button ID="btnAddMileStone" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddMileStone_Click" Style="margin-left: 0" /></td>
                                        <td style="width: 214px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvMilestonesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel7" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMilestones" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="false"
                                    OnRowEditing="gvMilestones_RowEditing" OnRowCancelingEdit="gvMilestones_RowCancelingEdit"
                                    OnRowUpdating="gvMilestones_RowUpdating" OnRowDataBound="gvMilestones_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="MilestoneGrantID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMilestoneGrantID" runat="Server" Text='<%# Eval("MilestoneGrantID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Milestone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMilestone" runat="Server" Text='<%# Eval("Milestone") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Note") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
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
        <asp:HiddenField ID="hfGrantinfoID" runat="server" />
        <asp:HiddenField ID="hfGrantInfoFYID" runat="server" />
        <asp:HiddenField ID="hfMilestoneID" runat="server" />
    </div>
    
    <script language="javascript">
        $(document).ready(function () {
            toCurrencyControl($('#<%= txtAwardAmt.ClientID%>').val(), $('#<%= txtAwardAmt.ClientID%>'));
            
            $('#<%= txtFyAmt.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtFyAmt.ClientID%>').val(), $('#<%= txtFyAmt.ClientID%>'));
            });

             $('#<%= txtAwardAmt.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtAwardAmt.ClientID%>').val(), $('#<%= txtAwardAmt.ClientID%>'));
            });

            //$("input[id*=txtFyAmount]").keyup(function () {
            //    toCurrencyControl($('input[id*=txtFyAmount]').val(), $('input[id*=txtFyAmount]'));
            //});
            
            //if ($('input[id*=txtFyAmount]').val() >= 0) {
            //    toCurrencyControl($('input[id*=txtFyAmount]').val(), $('input[id*=txtFyAmount]'));
            //}

            $('#<%= dvGrantInfoForm.ClientID%>').toggle($('#<%= cbAddGrantInfo.ClientID%>').is(':checked'));
            $('#<%= cbAddGrantInfo.ClientID%>').click(function () {
                $('#<%= dvGrantInfoForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvAttachedFundsForm.ClientID%>').toggle($('#<%= cbAddAttachedFunds.ClientID%>').is(':checked'));
            $('#<%= cbAddAttachedFunds.ClientID%>').click(function () {
                $('#<%= dvAttachedFundsForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvFyAmountsForm.ClientID%>').toggle($('#<%= cbAddFyAmounts.ClientID%>').is(':checked'));
            $('#<%= cbAddFyAmounts.ClientID%>').click(function () {
                $('#<%= dvFyAmountsForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvMilestonesForm.ClientID%>').toggle($('#<%= cbAddMilestone.ClientID%>').is(':checked'));
            $('#<%= cbAddMilestone.ClientID%>').click(function () {
                $('#<%= dvMilestonesForm.ClientID%>').toggle(this.checked);
            }).change();
        });

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvGrantInfo.ClientID%>");
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
