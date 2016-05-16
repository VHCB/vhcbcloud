<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HousingUnitsServices.aspx.cs"
    Inherits="vhcbcloud.Housing.HousingUnitsServices" MaintainScrollPositionOnPostback="true" %>

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
                            <td><span class="labelClass">Project #</span></td>
                            <td>
                                <span class="labelClass" id="ProjectNum" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Name</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="ProjName" runat="server"></span>
                            </td>
                            <td style="text-align: right">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Housing Type</span></td>
                            <td>
                                <asp:DropDownList ID="ddlHousingType" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlHousingType_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td><span class="labelClass">Total Units</span></td>
                            <td>
                                <asp:TextBox ID="txtTotalUnits" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>

                            <td style="height: 5px"><asp:Button ID="btnAddHousing" runat="server" Text="Submit" class="btn btn-info" OnClick="btnAddHousing_Click" /></td>
                        </tr>
                    </table>
                </div>
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvNewHousingSubType">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Housing SubType(s)</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHousingSubType" runat="server" Text="Add New Housing SubType" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHousingSubTypeForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Housing SubType</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlHousingSubType" CssClass="clsDropDownLong" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"># of Units
                                            </span>
                                        </td>
                                        <td style="width: 180px">
                                            <asp:TextBox ID="txtHousingSubTypeUnits" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px">
                                            <asp:Button ID="btnAddHousingSubType" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddHousingSubType_Click" /></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvConsevationSourcesGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="250px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHousingSubType" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="True">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Conserve Sources ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblConserveSourcesID" runat="Server" Text='<%# Eval("ConserveSourcesID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSourceName" runat="Server" Text='<%# Eval("SourceName") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Grand Total :
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="Server" Text='<%# Eval("Total", "{0:c2}") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTotal" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("Total") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" ID="lblFooterTotalAmount" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
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
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvHousingSubTypeForm.ClientID%>').toggle($('#<%= cbAddHousingSubType.ClientID%>').is(':checked'));

            $('#<%= cbAddHousingSubType.ClientID%>').click(function () {
                $('#<%= dvHousingSubTypeForm.ClientID%>').toggle(this.checked);
            }).change();

        });
    </script>
</asp:Content>

