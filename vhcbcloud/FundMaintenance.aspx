<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="FundMaintenance.aspx.cs" Inherits="vhcbcloud.FundMaintenance"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Fund Maintenance </p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <h3 class="panel-title">Fund Search</h3>
                            </td>
                            <td style="text-align: right;">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
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
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 100px"><span class="labelClass">Fund Name</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlFundName" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 90px"><span class="labelClass">Fund #</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlFundNo" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 1px"></td>
                            <td>
                                <asp:Button ID="btnFundSearch" runat="server" Text="Search" class="btn btn-info"
                                    OnClick="btnFundSearch_Click" /></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-width" runat="server" id="dvNewFund" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Fund</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddFund" runat="server" Text="Add New Fund" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
