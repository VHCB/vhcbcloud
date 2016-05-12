<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HousingSourcesUses.aspx.cs"
    Inherits="vhcbcloud.Housing.HousingSourcesUses" MaintainScrollPositionOnPostback="true" %>


<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
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
                                <asp:DropDownList ID="ddlHousingType" CssClass="clsDropDown" runat="server" AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                            <td><span class="labelClass">Total Units</span></td>
                            <td>
                                <asp:TextBox ID="txtTotalUnits" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>

                            <td style="height: 5px"></td>
                        </tr>
                    </table>
                </div>
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
</asp:Content>

