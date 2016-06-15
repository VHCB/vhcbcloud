<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FederalRentalAffordability.aspx.cs"
    Inherits="vhcbcloud.FederalRentalAffordability" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Federal Rental Affordability</p>
        <div class="container">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: left"></td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" ToolTip="Award Summary" Text="Award Summary" Style="width: 25px; height: 25px; border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="width: 25px; height: 25px; border: none; vertical-align: middle;" />
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

                <div class="panel-width" runat="server" id="dvNewCountyRents">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Federal Program Info</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddCountyRent" runat="server" Text="Add New County Rent" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvCountyRentsForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 97px"><span class="labelClass">Fed Program</span></td>
                                        <td style="width: 194px">
                                            <asp:DropDownList ID="ddlFedProgram" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">County</span>
                                        </td>
                                        <td style="width: 176px">
                                            <asp:DropDownList ID="ddlCounty" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 70px"><span class="labelClass">Start Date</span></td>
                                        <td class="modal-sm" style="width: 115px">
                                            <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtStartDate" TargetControlID="txtStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 71px"><span class="labelClass">End Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtEndDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEndDate" TargetControlID="txtEndDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 97px">
                                            <asp:Button ID="btnAddCountyRent" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddCountyRent_Click" />
                                        </td>
                                        <td style="width: 194px"></td>
                                        <td style="width: 63px"></td>
                                        <td style="width: 176px"></td>
                                        <td style="width: 70px"></td>
                                        <td class="modal-sm" style="width: 115px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvCountyRentsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvCountyRents" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvCountyRents_RowEditing" OnRowCancelingEdit="gvCountyRents_RowCancelingEdit"
                                    OnRowUpdating="gvCountyRents_RowUpdating" OnRowDataBound="gvCountyRents_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="CountyRentId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCountyRentId" runat="Server" Text='<%# Eval("CountyRentId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectCountyRent" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectCountyRent_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenCountyRentId" runat="server" Value='<%#Eval("CountyRentId")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fed Program">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFedProgram" runat="Server" Text='<%# Eval("FedProgram") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlFedProgram" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtFedProgID" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("FedProgID") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="County">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCounty" runat="Server" Text='<%# Eval("CountyName") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlCounty" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtCounty" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("county") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="Server" Text='<%# Eval("StartDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtStartDate" runat="Server" CssClass="clsTextBoxBlueSm"
                                                    Text='<%# Eval("StartDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtStartDate" TargetControlID="txtStartDate">
                                                </ajaxToolkit:CalendarExtender>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="End Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEndDate" runat="Server" Text='<%# Eval("EndDate", "{0:MM/dd/yyyy}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEndDate" runat="Server" CssClass="clsTextBoxBlueSm"
                                                    Text='<%# Eval("EndDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEndDate" TargetControlID="txtEndDate">
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
                </div>

                <div class="panel-width" runat="server" id="dvNewCountyUnitRent" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Unit Rents</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddCountyUnitRent" runat="server" Text="Add New Unit Rent" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvCountyUnitRentForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 75px"><span class="labelClass">Unit Type</span></td>
                                        <td style="width: 172px">
                                            <asp:DropDownList ID="ddlUnitType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">Low Rent</span>
                                        </td>
                                        <td style="width: 109px">
                                            <asp:TextBox ID="txtLowRent" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 63px">
                                            <span class="labelClass">High Rent</span>
                                        </td>
                                        <td style="width: 119px">
                                            <asp:TextBox ID="txtHighRent" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddUnitRent" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnAddUnitRent_Click" Style="margin-left: 0" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvCountyUnitRentGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvCountyUnitRent" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" ShowFooter="false"
                                    OnRowEditing="gvCountyUnitRent_RowEditing" OnRowCancelingEdit="gvCountyUnitRent_RowCancelingEdit"
                                    OnRowUpdating="gvCountyUnitRent_RowUpdating" OnRowDataBound="gvCountyUnitRent_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="CountyUnitRentID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCountyUnitRentID" runat="Server" Text='<%# Eval("CountyUnitRentID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUnitTypeName" runat="Server" Text='<%# Eval("UnitTypeName") %>' />
                                            </ItemTemplate>
                                           <%-- <EditItemTemplate>
                                                <asp:DropDownList ID="ddlUnitType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                                <asp:TextBox ID="txtUnitType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("UnitType") %>' Visible="false"></asp:TextBox>
                                            </EditItemTemplate>--%>
                                            <ItemStyle Width="300px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Low Rent" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLowRent" runat="Server" Text='<%# Eval("LowRent", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="60px" />
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtLowRent" runat="Server" CssClass="clsTextBoxBlueSm"
                                                    Text='<%# Eval("LowRent", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="High Rent" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHighRent" runat="Server" Text='<%# Eval("HighRent", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="60px" />
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtHighRent" runat="Server" CssClass="clsTextBoxBlueSm"
                                                    Text='<%# Eval("HighRent", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" />
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
        </div>
        <asp:HiddenField ID="hfProjectId" runat="server" />
        <asp:HiddenField ID="hfCountyRentId" runat="server" />

        <script language="javascript">
            $(document).ready(function () {
                $('#<%= dvCountyRentsForm.ClientID%>').toggle($('#<%= cbAddCountyRent.ClientID%>').is(':checked'));
                $('#<%= cbAddCountyRent.ClientID%>').click(function () {
                    $('#<%= dvCountyRentsForm.ClientID%>').toggle(this.checked);
                }).change();

                $('#<%= dvCountyUnitRentForm.ClientID%>').toggle($('#<%= cbAddCountyUnitRent.ClientID%>').is(':checked'));
                $('#<%= cbAddCountyUnitRent.ClientID%>').click(function () {
                    $('#<%= dvCountyUnitRentForm.ClientID%>').toggle(this.checked);
                }).change();


            });
            function PopupAwardSummary() {
                window.open('awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
            };

            function RadioCheck(rb) {
                var gv = document.getElementById("<%=gvCountyRents.ClientID%>");
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
</asp:Content>
