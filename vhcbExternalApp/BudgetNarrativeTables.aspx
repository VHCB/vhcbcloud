<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="BudgetNarrativeTables.aspx.cs" Inherits="vhcbExternalApp.BudgetNarrativeTables" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <div class="jumbotron">
        <p class="lead">SECTION B: FARM BUSINESS INFORMATION</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <table style="width=100%">
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>SECTION D: BUDGET NARRATIVE AND TABLES</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">Please fill out this budget sheet to show all expenses involved in this project, as well as which funding source will pay for each expense. Please be specific about where VHCB funds will go. VHCB funds can be used for capital improvements only – please read the application instructions to ensure your expenses are eligible.</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <img alt="" src="~/Images/MatchSurce.png" class="auto-style3" runat="server" style="width: 943px; height: 446px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>YOUR PROJECT EXPENSES:</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px; margin-left: 10px"><a href="https://server3.vhcb.org/sharing/eK2SPcBpY" target="_blank">Download blank financial spreadsheet</a>
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
                         <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
