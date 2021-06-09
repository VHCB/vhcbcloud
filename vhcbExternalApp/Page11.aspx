<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page11.aspx.cs" Inherits="vhcbExternalApp.Page11" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <div class="jumbotron">
        <p class="lead"><strong>SECTION G: ATTACHMENTS</strong></p>
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
                            <td colspan="2"><span class="labelClass"><strong>1.	FINANCIAL STATEMENTS - REQUIRED</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass">Please do not submit tax returns unless you do not track your income and expenses any other way. If you need to submit tax returns, please black out your social security or EIN number.</span>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">&nbsp;&nbsp;a.	Current Balance Sheet: a snap-shot of financial condition showing assets and liabilities </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;REQUIRED: most recent year-end or current balance sheet
OPTIONAL: any previous year’s balance sheets</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">&nbsp;&nbsp;b.	Historical Income Statement: a listing of farm income and farm expenses (also known as Profit & Loss) </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;REQUIRED: most recent income statement
OPTIONAL: any previous year’s income statements</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">&nbsp;&nbsp;c.	Projection or budget: typical cash-based projections of income and expenses for 1-3 years or more. Should take into account income and expenses that affect cash available. </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;REQUIRED: cash-flow projection for current and next year 
OPTIONAL: cash-flow projections beyond next year</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>2.	MAP - REQUIRED</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass">Please provide a map of your farm operation; at least one map is required. The map should illustrate where the proposed project will be located. The map should also show on-farm surface waters.</span>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>3.	VT AGENCY of AGRICULTURE, FOOD, AND MARKETS AGENCY or USDA-NRCS PROJECT BUDGETS – REQUIRED FOR PROJECTS RECEIVING VAAFM OR USDA-NRCS GRANT FUNDS</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>If your project is receiving funding from either the Vermont Agency of Agriculture, Food & Markets or the USDA-Natural Resources Conservation Service, please provide project budgets that show a list of the practices that these funding sources will pay for and at what rates.</span>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>4.	LETTERS OF SUPPORT – REQUIRED IN SOME CASES</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>If you are receiving funds from USDA-NRCS or the Vermont Agency of Agriculture, Food & Markets, please attach a letter or email confirming that these funds have been secured. If your project is designed to fix a water quality problem or a regulatory issue, please include a letter of support from any technical advisor or state employee who is helping you address the problem.</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>5.	BUSINESS PLAN – OPTIONAL</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>If you have completed a business plan, please attach it to this application.
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>6.	PHOTOS - OPTIONAL</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>Include up to five photos to show the issue you are addressing or the solution you plan to implement with this project.
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>7.	QUOTES - REQUIRED IF YOU ARE APPLYING FOR A GRANT TO PURCHASE EQUIPMENT</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>If you are applying for a grant to purchase equipment, please provide a quote for the type of equipment you are planning to purchase. This quote should include both the specifications of the particular piece of equipment you plan to purchase, and the cost.
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height: 5px; margin-left: 10px"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="#" target="_blank" runat="server" id="UploadLink">Upload completed financial spreadsheet</a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;
                                                 <asp:Button ID="previousButton" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="previousButton_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                 <asp:Button ID="btnSaveExit" runat="server" Text="Save/Exit" class="btn btn-info" OnClick="btnSaveExit_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnNext" runat="server" Text="Submit" class="btn btn-info" OnClick="btnNext_Click"/></td>
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



