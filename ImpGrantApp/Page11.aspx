<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page11.aspx.cs" Inherits="ImpGrantApp.Page11" %>

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
                            <td colspan="2"><span class="labelClass"><strong>&nbsp;&nbsp;1.	BUSINESS PLAN – REQUIRED</strong></span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>If you have completed a business plan, please attach it to this application. This is not required, but may give the review committee a more complete picture of your business.
                            </span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                          <tr>
                            <td colspan="2"><span class="labelClass"><strong>&nbsp;&nbsp;2.	VIABILITY PROGRAM BUDGET SHEET – REQUIRED</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">Please use the download link on page 5, SECTION D: BUDGET NARRATIVE AND TABLES, of this application to download a blank budget. Please follow the instructions on the blank workbook</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"  style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>&nbsp;&nbsp;3.	FINANCIAL STATEMENTS - REQUIRED</strong></span>
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
                            <td colspan="2" style="margin-left: 25px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>REQUIRED</strong>: most recent year-end or current balance sheet<br />&nbsp;&nbsp;&nbsp;&nbsp;
<strong>OPTIONAL</strong>: any previous year’s balance sheets</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">&nbsp;&nbsp;b.	Historical Income Statement: a listing of farm income and farm expenses (also known as Profit & Loss) </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>REQUIRED</strong>: most recent income statement<br />&nbsp;&nbsp;&nbsp;&nbsp;
<strong>OPTIONAL</strong>: any previous year’s income statements</td>
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
                            <td colspan="2" style="margin-left: 25px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>REQUIRED</strong>: cash-flow projection for current and next year <br />&nbsp;&nbsp;&nbsp;&nbsp;
<strong>OPTIONAL</strong>: cash-flow projections beyond next year</td>
                        </tr>
                       <tr>
                            <td colspan="2"  style="height: 15px"></td>
                        </tr>
                        
                       

                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>&nbsp;&nbsp;4.	LETTERS OF SUPPORT – OPTIONAL BUT RECOMMENDED</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>Please include a letter of support from any service provider, consultant, or technical advisor who is helping you with this project.  This is not required, but can strengthen an application. </span>
                            </td>
                        </tr>
                       <tr>
                            <td colspan="2"  style="height: 15px"></td>
                        </tr>
                       
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>&nbsp;&nbsp;5.	PHOTOS - OPTIONAL</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span>Include up to five photos to show the issue you are addressing or the solution you plan to implement with this project.
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"  style="height: 15px"></td>
                        </tr>
                       
                         <tr>
                            <td colspan="2" style="height: 5px; margin-left: 10px"> &nbsp;&nbsp;&nbsp;&nbsp; <a href="#" target="_blank" runat="server" id="UploadLink"><strong><span style="font-size: large">Upload all attachments using this link</span></strong></a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;
                                                 <asp:Button ID="previousButton" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="previousButton_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                 <asp:Button ID="NextButton" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="NextButton_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
<%--                                 <asp:Button ID="btnSaveExit" runat="server" Text="Save/Exit" class="btn btn-info" OnClick="btnSaveExit_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnNext" runat="server" Text="Submit" class="btn btn-info" OnClick="btnNext_Click"/>--%>

                            </td>
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



