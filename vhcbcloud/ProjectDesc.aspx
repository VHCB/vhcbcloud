<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SiteWithoutHeader.Master" CodeBehind="ProjectDesc.aspx.cs"
    Inherits="vhcbcloud.ProjectDesc" %>
<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">

                <table style="width: 100%;">
                    <tr>
                        <td><b>Project Description</b></td>
                        <td style="text-align: right">
                        </td>
                    </tr>
                </table>
            </div>

            <div id="dvMessage" runat="server">
                <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg1"></asp:Label></p>
            </div>
            <div>
                <asp:Panel runat="server" ID="pnlProjectInfo">
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Description</span></td>
                            <td colspan="3">
                                <asp:TextBox ID="txtDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="600px" Height="173px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 5px">
                                <br />
                                <asp:Button ID="btnSubmitDesc" runat="server" class="btn btn-info" OnClick="btnSubmitDesc_Click"  Text="Submit" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
