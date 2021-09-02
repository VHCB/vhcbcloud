<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WaterQualityGrants.aspx.cs" Inherits="vhcbExternalApp.WaterQualityGrants" Async="true" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <style type="text/css">
        .scroll_checkboxes {
            height: 350px;
            padding: 5px;
            overflow: auto;
            border: 1px solid #ccc;
        }

        .FormatRadioButtonList label {
            margin-left: 5px;
        }

        .auto-style5 {
            width: 344px;
        }

        .auto-style6 {
            width: 354px;
        }

        .auto-style7 {
            width: 354px;
            height: 12px;
            border-radius: 6px;
        }

        .auto-style8 {
            height: 12px;
        }

        .auto-style9 {
            width: 354px;
            border-radius: 6px;
        }
    </style>
    <div class="jumbotron">
        <p class="lead">SECTION B – FARM BUSINESS INFORMATION CONTINUED</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>
                    <table>

                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Farm Size:</span></td>
                            <td class="auto-style8">
                                <asp:DropDownList ID="ddlFarmSize" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                <%--<asp:ListBox runat="server" CssClass="clsTextBoxBlue1" SelectionMode="Multiple" ID="lstFarmSize" Height="80px" Width="261px"></asp:ListBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">If you are unsure of the size of your farm, please refer to this factsheet from the Vermont Agency of Agriculture, Food, and Markets: <a href="http://agriculture.staging.vermont.gov/sites/agriculture/files/documents/Water_Quality/FarmSizeClass.pdf" target="_blank">FarmSizeClass.pdf </a><a href="http://vermont.gov" target="_blank">(vermont.gov) </a>
                            </span>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style9"><span class="labelClass" style="margin-left: 10px">Watershed:</span></td>
                            <td>
                                <asp:DropDownList ID="ddlWaterShed" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                <%--<asp:ListBox runat="server" CssClass="clsTextBoxBlue1" SelectionMode="Multiple" ID="lstFarmSize" Height="80px" Width="261px"></asp:ListBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                    </table>
                    <div class="panel-width" runat="server" id="dvNewAddress">
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Farm Enterprise - Crops / Products</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="dvProjectAddressForm">
                                <asp:Panel runat="server" ID="Panel2">

                                    <div id="dvAddress" runat="server">
                                        <br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Primary Product  (select one):</span></td>
                                                <td colspan="2">
                                                    <asp:DropDownList ID="ddlPrimaryProduct" CssClass="clsDropDown" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Secondary Product(s) (select all that apply):</span></td>
                                                <td colspan="2">
                                                    <div class="scroll_checkboxes">
                                                        <asp:CheckBoxList Width="180px" ID="cblSecProduct" runat="server" RepeatDirection="Vertical" RepeatColumns="1" BorderWidth="0"
                                                            Datafield="description" DataValueField="value" CssClass="checkboxlist_nowrap">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                    <%--  <asp:DropDownList ID="ddlProduct" CssClass="clsDropDown" runat="server">
                                                    </asp:DropDownList>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;
                                                 <asp:Button ID="previousButton" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="previousButton_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
