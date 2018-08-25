<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HOPWASetup.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.SetUp.HOPWASetup" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <div class="container">
            <div class="panel panel-default">

                <div class="panel-heading">
                </div>
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvNewHOPWADef">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">HOPWA Defaults</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHopwaDef" runat="server" Text="Add New HOPWA Defaults" Visible="false" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvHOPWADefForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Current Record</span></td>
                                        <td style="width: 215px">
                                            <asp:CheckBox ID="cbIsCurrent" runat="server" Text="Yes" />
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">Year</span></td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtYear" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Fund</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlFund" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">Previous Fund</span></td>
                                        <td style="width: 180px">
                                            <asp:DropDownList ID="ddlPrevFund" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Start Date</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtStartDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass">End Date</span></td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtEndDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtEndDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                     <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">STRMU Max Amount</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtSTRMUMaxAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"><span class="labelClass"></span></td>
                                        <td style="width: 180px">
                                           
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px">
                                            <asp:Button ID="AddHOPWADef" runat="server" Text="Add" class="btn btn-info" OnClick="AddHOPWADef_Click" /></td>
                                        <td style="width: 215px"></td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px"></td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 10px 10px 10px 10px" id="dvHOPWADefFormGrid" runat="server" visible="false">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="100px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWADefForm" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvHOPWADefForm_RowCancelingEdit"
                                    OnRowDataBound="gvHOPWADefForm_RowDataBound"
                                    OnRowEditing="gvHOPWADefForm_RowEditing" OnRowUpdating="gvHOPWADefForm_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWADefaultID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWADefaultID" runat="Server" Text='<%# Eval("HOPWADefaultID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IsCurrent">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIsCurrent" runat="Server" Text='<%# Eval("IsCurrent") %>' />
                                            </ItemTemplate>
                                           
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Year">
                                            <ItemTemplate>
                                                <asp:Label ID="lblYear" runat="Server" Text='<%# Eval("Year") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Current Fund">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCurrentFund" runat="Server" Text='<%# Eval("CurrentFundName") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Previous Fund">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPreviousFund" runat="Server" Text='<%# Eval("PreviousFundName") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="Server" Text='<%# Eval("FundStartDate") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="End Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEndDate" runat="Server" Text='<%# Eval("FundEndDate") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="STRMU Max Amt">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSTRMUMaxAmt" runat="Server" Text='<%# Eval("STRMUMaxAmt") %>' />
                                            </ItemTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible="true"></asp:LinkButton>
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
    <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />
    <asp:HiddenField ID="hfHOPWADefaultID" runat="server" />
    <script language="javascript">

        $(document).ready(function () {
            toCurrencyControl($('#<%= txtSTRMUMaxAmt.ClientID%>').val(), $('#<%= txtSTRMUMaxAmt.ClientID%>'));
             $('#<%= txtSTRMUMaxAmt.ClientID%>').keyup(function () {
                        toCurrencyControl($('#<%= txtSTRMUMaxAmt.ClientID%>').val(), $('#<%= txtSTRMUMaxAmt.ClientID%>'));
                      });
           <%-- $('#<%= dvHOPWADefForm.ClientID%>').toggle($('#<%= cbAddHopwaDef.ClientID%>').is(':checked'));


         $('#<%= cbAddHopwaDef.ClientID%>').click(function () {
             $('#<%= dvHOPWADefForm.ClientID%>').toggle(this.checked);
            }).change();--%>


     });
    </script>
</asp:Content>

