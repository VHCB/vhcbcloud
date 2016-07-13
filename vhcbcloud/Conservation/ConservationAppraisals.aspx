<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConservationAppraisals.aspx.cs" MasterPageFile="~/Site.Master"
    MaintainScrollPositionOnPostback="true" Inherits="vhcbcloud.Conservation.ConservationAppraisals" %>

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
                        <div class="panel-heading ">
                            <h3 class="panel-title">Appraisal Value</h3>
                        </div>
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
                                    <td><span class="labelClass">Total Acres</span></td>
                                    <td>
                                        <asp:TextBox ID="txtTotalAcres" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Value BEFORE</span></td>
                                    <td>
                                        <asp:TextBox ID="txtValueBefore" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Value AFTER:</span></td>
                                    <td>
                                        <asp:TextBox ID="txtValueafter" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Value of land with option</span></td>
                                    <td>
                                        <asp:TextBox ID="txtValueofLandWithOption" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td><span class="labelClass">Enhanced Exclusion Value</span></td>
                                    <td>
                                        <asp:TextBox ID="txtEnhancedExclusionValue" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                    </td>
                                    <td><span class="labelClass">Easement Value</span></td>
                                    <td><span class="labelClass" id="spEasementValue" runat="server"></span></td>
                                    <td><span class="labelClass">Easement Value/Acre</span></td>
                                    <td><span class="labelClass" id="spEasementValuePerAcre" runat="server"></span></td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                                    </td>
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
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewAppraisalInfo">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Appraisal Info</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAppraisalInfo" runat="server" Text="Add New Appraisal Info" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAppraisalInfoForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Appraiser</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlAppraiser" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 185px">
                                            <span class="labelClass">Date Ordered</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtDateOrdered" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDateOrdered" TargetControlID="txtDateOrdered">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Date Received</span></td>
                                        <td>
                                            <asp:TextBox ID="txtDateReceived" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDateReceived" TargetControlID="txtDateReceived">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Effective Date</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtEffectiveDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEffectiveDate" TargetControlID="txtEffectiveDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 185px">
                                            <span class="labelClass">Total Cost</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtTotalCost" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Date Sent to NRCS</span></td>
                                        <td>
                                            <asp:TextBox ID="txtDateNRCS" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDateNRCS" TargetControlID="txtDateNRCS">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Review Approved?</span></td>
                                        <td style="width: 250px">
                                            <asp:CheckBox ID="cbReviewApproved" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td style="width: 185px"><span class="labelClass">Review Approved</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtReviewApprovedDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtReviewApprovedDate" TargetControlID="txtReviewApprovedDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td><span class="labelClass">Active:</span></td>
                                        <td>
                                            <asp:CheckBox ID="chkAppraisalInfoActive" Enabled="false" runat="server" Checked="true" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Comments</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="705px" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px">
                                            <asp:Button ID="btnAddAppraisalInfo" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddAppraisalInfo_Click" />
                                        </td>
                                        <td style="width: 250px"></td>
                                        <td style="width: 185px"></td>
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

                        <div class="panel-body" id="dvAppraisalInfoGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAppraisalInfo" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvAppraisalInfo_RowEditing" OnRowCancelingEdit="gvAppraisalInfo_RowCancelingEdit"
                                    OnRowDataBound="gvAppraisalInfo_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="AppraisalInfoID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAppraisalInfoID" runat="Server" Text='<%# Eval("AppraisalInfoID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectAppraisalInfo" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectAppraisalInfo_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenAppraisalInfoID" runat="server" Value='<%#Eval("AppraisalInfoID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Appraiser">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAppraiser" runat="Server" Text='<%# Eval("Appraiser") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Ordered">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAppOrdered" runat="Server" Text='<%# Eval("AppOrdered", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Received">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAppRecd" runat="Server" Text='<%# Eval("AppRecd", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Cost" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAppCost" runat="Server" Text='<%# Eval("AppCost", "{0:c2}") %>' />
                                                <asp:HiddenField ID="HiddenAppraisalTotalCost" runat="server" Value='<%#Eval("AppCost")%>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="70px" />
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

                <div class="panel-width" runat="server" id="dvNewAppraisalPay" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Responsible Parties for Payment</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAppraisalPay" runat="server" Text="Add New Responsible Parties for Payment" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvAppraisalPayForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Responsible Party</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlPayParty" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">Amount</span>
                                        </td>
                                        <td style="width: 167px">
                                            <asp:TextBox ID="txtPayAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddPay" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddPay_Click" Style="margin-left: 0" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvAppraisalPayGrid" runat="server">
                            <div id="dvPayWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblPayWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvAppraisalPay" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="True"
                                    OnRowEditing="gvAppraisalPay_RowEditing" OnRowCancelingEdit="gvAppraisalPay_RowCancelingEdit"
                                    OnRowUpdating="gvAppraisalPay_RowUpdating" OnRowDataBound="gvAppraisalPay_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="AppraisalPayID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAppraisalPayID" runat="Server" Text='<%# Eval("AppraisalPayID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Responsible Party">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWhoPaid" runat="Server" Text='<%# Eval("WhoPaid") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlPayParty" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtWhoPaid" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("applicantid") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                            <ItemStyle Width="400px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPayAmt" runat="Server" Text='<%# Eval("PayAmt", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtPayAmount" runat="Server" CssClass="clsTextBoxBlueSm"
                                                    Text='<%# Eval("PayAmt", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalPayAmount" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
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
            </div>
            <asp:HiddenField ID="hfProjectId" runat="server" />
            <asp:HiddenField ID="hfAppraisalID" runat="server" />
            <asp:HiddenField ID="hfAppraisalInfoID" runat="server" />
            <asp:HiddenField ID="hfAppraisalPayID" runat="server" />
            <asp:HiddenField ID="hfSelectedAppraisalTotalCost" runat="server" />
            <asp:HiddenField ID="hfPayWarning" runat="server" />


            <script language="javascript">
                $(document).ready(function () {
                    $('#<%= dvAppraisalInfoForm.ClientID%>').toggle($('#<%= cbAddAppraisalInfo.ClientID%>').is(':checked'));
                    $('#<%= cbAddAppraisalInfo.ClientID%>').click(function () {
                        $('#<%= dvAppraisalInfoForm.ClientID%>').toggle(this.checked);
                    }).change();

                    $('#<%= dvAppraisalPayForm.ClientID%>').toggle($('#<%= cbAddAppraisalPay.ClientID%>').is(':checked'));
                    $('#<%= cbAddAppraisalPay.ClientID%>').click(function () {
                        $('#<%= dvAppraisalPayForm.ClientID%>').toggle(this.checked);
                    }).change();

                    $('#<%= txtValueBefore.ClientID%>').blur(function () {
                        CalEasementVal();
                    });
                    $('#<%= txtValueafter.ClientID%>').blur(function () {
                        CalEasementVal();
                    });

                    $('#<%= txtTotalAcres.ClientID%>').blur(function () {
                        CalEasementValPerAcre();
                    });
                });

                function CalEasementVal() {
                    var Before = parseInt($('#<%=txtValueBefore.ClientID%>').val(), 10);
                    var After = parseInt($('#<%=txtValueafter.ClientID%>').val(), 10);

                    var EasementVal = Before - After;
                    $('#<%= spEasementValue.ClientID%>').html(EasementVal);
                    CalEasementValPerAcre();
                };

                function CalEasementValPerAcre() {
                    var Total = parseInt($('#<%=txtTotalAcres.ClientID%>').val(), 10);
             var Eval = parseInt($('#<%=spEasementValue.ClientID%>').text(), 10);
             var EasementValPerAcre = Eval / Total;

             $('#<%= spEasementValuePerAcre.ClientID%>').html(EasementValPerAcre.toPrecision(2));
        };

        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvAppraisalInfo.ClientID%>");
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
        </div>
    </div>
</asp:Content>
