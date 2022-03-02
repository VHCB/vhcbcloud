<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="BudgetNarrativeTables.aspx.cs" Inherits="ImpGrantApp.BudgetNarrativeTables" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <div class="jumbotron">
        <p class="lead">SECTION D: BUDGET TABLES AND NARRATIVE</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                      <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>
                    <table style="width=100%">
                        <tr>
                            <td colspan="2"><span class="labelClass"></span></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">Please follow link below to download a blank financial spreadsheet to show all expenses involved in this project, as well as which funding source will pay for each expense. Please be specific about where VHCB funds will go. VHCB funds can be used for capital improvements only – please read the application instructions to ensure your expenses are eligible.</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass">On the blank worksheet, tab 1 is an example page. Please do not attempt to edit this tab. Please complete tab 2 with your project’s budget expenses. All totals will be added for you. Further instructions are included on the spreadsheet. You will be able to upload the spreadsheet at the end of this application</span></td>
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
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>Budget Narrative:</strong> Please complete the above budget sheet (required), and provide a budget narrative to demonstrate how VHCB funds will be used, where matching funds are expected to come from, and what matching funds are already secured. In addition, you may provide a more detailed project budget in your own format, or identify where such project details are described in your business plan, although this is not required. (~150 words)
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                              
                                 <asp:TextBox ID="txtSupportingFunds" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="900px" Height="100px" />
                            </td>
                        </tr>
<%--                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">For projects that are receiving funds from USDA NRCS or the Vermont Agency of Agriculture, Food & Markets, please describe:
                                  <br />
                                <ul>
                                    <li>the practices that these funding sources will pay for,</li>
                                    <ul>
                                        <li>  whether there are any expenses that these programs cannot cover, and</li>

                                        <li>  the status of these grants (i.e. when contracts will be signed if they are not already).</li>

                                    </ul>
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                               
                                 <asp:TextBox ID="txtNRCSExpensesandStatus" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">In some cases, the Viability Program may consider awarding Water Quality Grants to applicants who cannot meet the 50% match requirement. If you do not have the funds to contribute a 50% match for this project and would like to request a waiver, please explain. (100 words)
                            </span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                               
                                 <asp:TextBox ID="txtWaverRequest" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>--%>
                         <tr>
                            <td colspan="2" style="height: 15px"></td>
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
