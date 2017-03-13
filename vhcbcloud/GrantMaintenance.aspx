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
                                <asp:DropDownList ID="ddlFundName" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 90px"><span class="labelClass">Program</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 100px"><span class="labelClass">Grant Agency</span></td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlGrantAgency" CssClass="clsDropDown" runat="server">
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

                <div class="panel-width" runat="server" id="dvNewGrantInfo" visible="false">
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
