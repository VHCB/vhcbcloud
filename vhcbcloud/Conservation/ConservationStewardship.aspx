<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConservationStewardship.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Conservation.ConservationStewardship" MaintainScrollPositionOnPostback="true" %>

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
                            <td style="width: 192px">
                                
                            </td>
                            <td></td>
                            <td style="text-align: left">
                                
                            </td>
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
                                     <td><span class="labelClass">Primary Steward Organization:</span></td>
                                    <td>
                                        <asp:DropDownList ID="ddlPSO" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    </td>
                                     <td>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" style="height: 5px"></td>
                                </tr>
                                
                            </table>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewMajor">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Major Amendments</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMajor" runat="server" Text="Add New Major Amendment" />
                                        <asp:ImageButton ID="ImgConservationMajorAmendments" ImageUrl="~/Images/print.png" ToolTip="Grid Conservation Major Amendments Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgConservationMajorAmendments_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMajorForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Amendment</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlMjrAmendment" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Request Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtMjrReqDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtMjrReqDate" TargetControlID="txtMjrReqDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Disposition</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlMjrDisposition" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Disposition Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtMjrDispositionDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtMjrDispositionDate" TargetControlID="txtMjrDispositionDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">URL</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtMajorURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtMajorComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px">
                                            <asp:CheckBox ID="cbMajorActive" CssClass="ChkBox" runat="server" Text="Active" Checked="true" Enabled="false" />
                                        </td>
                                        <td colspan="5">
                                            <asp:Button ID="btnAddMajor" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddMajor_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvMajorGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMajor" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvMajor_RowEditing" OnRowCancelingEdit="gvMajor_RowCancelingEdit"
                                    OnRowDataBound="gvMajor_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve MajAmend ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveMajAmendID" runat="Server" Text='<%# Eval("ConserveMajAmendID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amendment">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMajAmend" runat="Server" Text='<%# Eval("amendment") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Request Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMjrReqDate" runat="Server" Text='<%# Eval("ReqDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDisposition" runat="Server" Text='<%# Eval("disposition") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDispositionDate" runat="Server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comments">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="Server" ToolTip='<%# Eval("FullComments") %>' Text='<%# Eval("Comments") %>' />
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
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewMinor">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Minor Amendments</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddMinor" runat="server" Text="Add New Minor Amendment" />
                                        <asp:ImageButton ID="ImgConservationMinorAmendments" ImageUrl="~/Images/print.png" ToolTip="Conservation Minor Amendments Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgConservationMinorAmendments_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMinorForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Amendment</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlMinorAmendment" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Request Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtMinorReqDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtMinorReqDate" TargetControlID="txtMinorReqDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Disposition</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlMinorDisposition" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Disposition Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtMinorDispositionDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtMinorDispositionDate" TargetControlID="txtMinorDispositionDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">URL</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtMinorURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtMinorComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px">
                                            <asp:CheckBox ID="cbMinorActive" CssClass="ChkBox" runat="server" Text="Active" Checked="true" Enabled="false" />
                                        </td>
                                        <td colspan="5">
                                            <asp:Button ID="btnAddMinor" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddMinor_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvMinorGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel2" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMinor" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvMinor_RowEditing" OnRowCancelingEdit="gvMinor_RowCancelingEdit"
                                    OnRowDataBound="gvMinor_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve MinorAmend ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveMinAmendID" runat="Server" Text='<%# Eval("ConserveMinAmendID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amendment">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMinorAmend" runat="Server" Text='<%# Eval("amendment") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Request Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMinorReqDate" runat="Server" Text='<%# Eval("ReqDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMinorDisposition" runat="Server" Text='<%# Eval("disposition") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMinorDispositionDate" runat="Server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comments">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="Server" ToolTip='<%# Eval("FullComments") %>' Text='<%# Eval("Comments") %>' />
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
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewViolation">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Violations</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddViolation" runat="server" Text="Add New Violation" />
                                        <asp:ImageButton ID="ImgConservationViolations" ImageUrl="~/Images/print.png" ToolTip="Grid Conservation Violations Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgConservationViolations_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvViolationForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Violation</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlViolations" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Request Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtViolationReqDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtViolationReqDate" TargetControlID="txtViolationReqDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Disposition</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlViolationDisposition" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Disposition Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtViolationDispDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtViolationDispDate" TargetControlID="txtViolationDispDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">URL</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtViolationURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtViolationComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px">
                                            <asp:CheckBox ID="cbViolationActive" CssClass="ChkBox" runat="server" Text="Active" Checked="true" Enabled="false" />
                                        </td>
                                        <td colspan="5">
                                            <asp:Button ID="btnAddViolation" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddViolation_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvViolationGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvViolation" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvViolation_RowEditing" OnRowCancelingEdit="gvViolation_RowCancelingEdit"
                                    OnRowDataBound="gvViolation_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve Violations ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveViolationsID" runat="Server" Text='<%# Eval("ConserveViolationsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Violation">
                                            <ItemTemplate>
                                                <asp:Label ID="lblViolations" runat="Server" Text='<%# Eval("violation") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Request Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblViolationsReqDate" runat="Server" Text='<%# Eval("ReqDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition">
                                            <ItemTemplate>
                                                <asp:Label ID="lblViolationsDisposition" runat="Server" Text='<%# Eval("disposition") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblViolationsDispositionDate" runat="Server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comments">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="Server" ToolTip='<%# Eval("FullComments") %>' Text='<%# Eval("Comments") %>' />
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
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewApproval">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Approvals</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddApproval" runat="server" Text="Add New Approval" />
                                        <asp:ImageButton ID="ImgeConservationApprovals" ImageUrl="~/Images/print.png" ToolTip="Grid Conservation Approvals Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgeConservationApprovals_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvApprovalForm">
                            <asp:Panel runat="server" ID="Panel5">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Approval</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlApproval" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Request Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtApprovalReqdate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtApprovalReqdate" TargetControlID="txtApprovalReqdate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Disposition</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlApprovalDisposition" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Disposition Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtApprovalDispositionDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtApprovalDispositionDate" TargetControlID="txtApprovalDispositionDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">URL</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtApprovalURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtApprovalComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px">
                                            <asp:CheckBox ID="cbApprovalActive" CssClass="ChkBox" runat="server" Text="Active" Checked="true" Enabled="false" />
                                        </td>
                                        <td colspan="5">
                                            <asp:Button ID="btnAddApproval" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddApproval_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvApprovalGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel6" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvApproval" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvApproval_RowEditing" OnRowCancelingEdit="gvApproval_RowCancelingEdit"
                                    OnRowDataBound="gvApproval_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve Approvals ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveApprovalID" runat="Server" Text='<%# Eval("ConserveApprovalID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Approval">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApprovals" runat="Server" Text='<%# Eval("approval") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Request Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApprovalsReqDate" runat="Server" Text='<%# Eval("ReqDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApprovalsDisposition" runat="Server" Text='<%# Eval("disposition") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Disposition Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApprovalsDispositionDate" runat="Server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comments">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="Server" ToolTip='<%# Eval("FullComments") %>' Text='<%# Eval("Comments") %>' />
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
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewPlan">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Management Plans</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddPlan" runat="server" Text="Add New Plan" />
                                        <asp:ImageButton ID="ImgConservationManagementPlans" ImageUrl="~/Images/print.png" ToolTip="Grid Conservation Management Plans Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgConservationManagementPlans_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvPlanForm">
                            <asp:Panel runat="server" ID="Panel7">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Plan</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlPlan" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtPlanDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtPlanDate" TargetControlID="txtPlanDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">URL</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtPlanURL" CssClass="clsTextBoxBlue1" runat="server" Width="189px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtPlanComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px">
                                            <asp:CheckBox ID="cbPlanActive" CssClass="ChkBox" runat="server" Text="Active" Checked="true" Enabled="false" />
                                        </td>
                                        <td colspan="5">
                                            <asp:Button ID="btnAddPlan" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddPlan_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvPlanGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel10" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvPlan" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvPlan_RowEditing" OnRowCancelingEdit="gvPlan_RowCancelingEdit"
                                    OnRowDataBound="gvPlan_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve Plan ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConservePlanID" runat="Server" Text='<%# Eval("ConservePlanID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Plan">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlan" runat="Server" Text='<%# Eval("MangePlan") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlanDate" runat="Server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="URL">
                                            <ItemTemplate>
                                                <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comments">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="Server" ToolTip='<%# Eval("FullComments") %>' Text='<%# Eval("Comments") %>' />
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
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
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
                                        <asp:CheckBox ID="cbAddMilestone" runat="server" Text="Add New Milestone" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvMilestoneForm">
                            <asp:Panel runat="server" ID="Panel11">
                                <div runat="server" id="dvProjectMilestone">
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

                        <div class="panel-body" id="dvMilestoneGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel12" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvMilestone" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvMilestone_RowEditing" OnRowCancelingEdit="gvMilestone_RowCancelingEdit"
                                    OnRowUpdating="gvMilestone_RowUpdating">
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
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible='<%# GetIsVisibleBasedOnRole() %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />--%>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <%-- <div class="panel-width" runat="server" id="dvNewEvent">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Events</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddEvent" runat="server" Text="Add New Event" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvEventForm">
                            <asp:Panel runat="server" ID="Panel11">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Event</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlEvent" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Date
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtEventDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtEventDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddEvent" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddEvent_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvEventGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel12" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvEvent" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvEvent_RowEditing" OnRowCancelingEdit="gvEvent_RowCancelingEdit"
                                    OnRowUpdating="gvEvent_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve Event ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveEventID" runat="Server" Text='<%# Eval("ConserveEventID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Event">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEvent" runat="Server" Text='<%# Eval("EventName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEventDate" runat="Server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEventDate" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("DispDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtEventDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfConserveId" runat="server" />
    <asp:HiddenField ID="hfConserveMajAmendID" runat="server" />
    <asp:HiddenField ID="hfConserveMinAmendID" runat="server" />
    <asp:HiddenField ID="hfConserveViolationsID" runat="server" />
    <asp:HiddenField ID="hfConserveApprovalID" runat="server" />
    <asp:HiddenField ID="hfConservePlanID" runat="server" />
    <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvMajorForm.ClientID%>').toggle($('#<%= cbAddMajor.ClientID%>').is(':checked'));
            $('#<%= dvMinorForm.ClientID%>').toggle($('#<%= cbAddMinor.ClientID%>').is(':checked'));
            $('#<%= dvViolationForm.ClientID%>').toggle($('#<%= cbAddViolation.ClientID%>').is(':checked'));
            $('#<%= dvApprovalForm.ClientID%>').toggle($('#<%= cbAddApproval.ClientID%>').is(':checked'));
            $('#<%= dvPlanForm.ClientID%>').toggle($('#<%= cbAddPlan.ClientID%>').is(':checked'));
            $('#<%= dvMilestoneForm.ClientID%>').toggle($('#<%= cbAddMilestone.ClientID%>').is(':checked'));

            $('#<%= cbAddMajor.ClientID%>').click(function () {
                $('#<%= dvMajorForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddMinor.ClientID%>').click(function () {
                $('#<%= dvMinorForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddViolation.ClientID%>').click(function () {
                $('#<%= dvViolationForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddApproval.ClientID%>').click(function () {
                $('#<%= dvApprovalForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= cbAddPlan.ClientID%>').click(function () {
                $('#<%= dvPlanForm.ClientID%>').toggle(this.checked);
            }).change();

           $('#<%= cbAddMilestone.ClientID%>').click(function () {
                $('#<%= dvMilestoneForm.ClientID%>').toggle(this.checked);
             }).change();

        });

        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>
