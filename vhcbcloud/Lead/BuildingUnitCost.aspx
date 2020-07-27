<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BuildingUnitCost.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Lead.BuildingUnitCost" MaintainScrollPositionOnPostback="true" %>

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
                            <td style="width: 171px"><span class="labelClass">Project #:</span></td>
                            <td style="width: 192px"><span class="labelClass" id="ProjectNum" runat="server"></span></td>
                            <td><span class="labelClass">Name:</span></td>
                            <td style="text-align: left"><span class="labelClass" id="ProjName" runat="server"></span></td>
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

                <div class="panel-width" runat="server" id="dvNewCheckRequest">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Check Request Info</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddCheckRequestInfo" runat="server" Text="Add New Check Request Info" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvCheckRequestForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Check Request Date</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlCheckRequest" CssClass="clsDropDownLong" runat="server" Style="margin-left: 1"></asp:DropDownList>
                                        </td>
                                        <td style="width: 185px">
                                            <%--<span class="labelClass">Payee</span>--%>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:Button ID="btnAddCRInfo" runat="server" Text="Submit" class="btn btn-info" OnClick="btnAddCRInfo_Click" />
                                        </td>
                                        <td style="width: 170px">
                                            <%--<span class="labelClass">Amount</span>--%>

                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvCRInfoGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvCRInfo" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnSelectedIndexChanged="gvCRInfo_SelectedIndexChanged">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectMasterLeadCostsID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectMasterLeadCostsID" runat="Server" Text='<%# Eval("ProjectMasterLeadCostsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectCRInfo" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectCRInfo_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenProjectMasterLeadCostsID" runat="server" Value='<%#Eval("ProjectMasterLeadCostsID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CRDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCRDate" runat="Server" Text='<%# Eval("CRDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Payee">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPayee" runat="Server" Text='<%# Eval("Payee") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Is Balanced">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIsBalanced" runat="Server" Text='<%# Eval("IsBalanced") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewCost" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Cost</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddCost" runat="server" Text="Add New Cost" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvCostForm">
                            <asp:Panel runat="server" ID="Panel7">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Building #</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlBldgNumber" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlBldgNumber_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <span class="labelClass">Unit #</span>
                                        </td>
                                        <td style="width: 227px">
                                            <asp:DropDownList ID="ddlUnitNumber" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td><span class="labelClass">Cost</span></td>
                                        <td>
                                            <asp:TextBox ID="txtCost" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Comments</span></td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="40%" Height="80px" />
                                        </td>
                                        <td><span class="labelClass">Active:</span></td>
                                    <td>
                                        <asp:CheckBox ID="chkCostActive" Enabled="false" runat="server" Checked="true" /></td>
                                
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px">
                                            <asp:Button ID="btnCostSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnCostSubmit_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvCostGrid" runat="server">
                            <div id="dvCostWarning" runat="server">
                                <p class="bg-info">
                                    &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span>
                                    <asp:Label runat="server" ID="lblCostWarning" class="labelClass"></asp:Label>
                                </p>
                            </div>
                            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvCost" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvCost_RowEditing"
                                    OnRowCancelingEdit="gvCost_RowCancelingEdit"
                                    OnRowDataBound="gvCost_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="LeadCostsID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLeadCostsID" runat="Server" Text='<%# Eval("LeadCostsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField SortExpression="Building" HeaderText="Building #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBuilding" runat="Server" Text='<%# Eval("Building") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField SortExpression="Unit" HeaderText="Unit #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnit" runat="Server" Text='<%# Eval("Unit") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Running Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cost" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCost" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>                                            
                                            <FooterTemplate>
                                                <asp:Label ID="lblFooterAmount" runat="server" Text=""></asp:Label>
                                            </FooterTemplate>
                                             <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="">
                                          <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Notes">
                                           <ItemTemplate>
                                                <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                Balance Amount :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFooterBalance" runat="server" Text=""></asp:Label>
                                            </FooterTemplate>
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
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfProjectMasterLeadCostsID" runat="server" />
    <asp:HiddenField ID="hfLeadCostsID" runat="server" />
    <asp:HiddenField ID="hfCostWarning" runat="server" />
    <asp:HiddenField ID="hfCRAmount" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvCheckRequestForm.ClientID%>').toggle($('#<%= cbAddCheckRequestInfo.ClientID%>').is(':checked'));
            $('#<%= cbAddCheckRequestInfo.ClientID%>').click(function () {
                $('#<%= dvCheckRequestForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvCostForm.ClientID%>').toggle($('#<%= cbAddCost.ClientID%>').is(':checked'));
            $('#<%= cbAddCost.ClientID%>').click(function () {
                $('#<%= dvCostForm.ClientID%>').toggle(this.checked);
            }).change();

             toCurrencyControl($('#<%= txtCost.ClientID%>').val(), $('#<%= txtCost.ClientID%>'));
             $('#<%= txtCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtCost.ClientID%>').val(), $('#<%= txtCost.ClientID%>'));
             });
        });





        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
    };

    function RadioCheck(rb) {
        var gv = document.getElementById("<%=gvCRInfo.ClientID%>");
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
