<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="BudgetNarrativeTables.aspx.cs" Inherits="vhcbExternalApp.BudgetNarrativeTables" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <style type="text/css">
            .normalfont {
                font-weight: normal !important;
            }
        </style>
    <div class="jumbotron">
        <p class="lead">SECTION D: BUDGET TABLE AND NARRATIVE</p>
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
                            <td colspan="2"><span class="labelClass"><strong>Please save this and all future pages frequently to avoid losing any work. Pages may time out.</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">Please follow link below to download a blank financial spreadsheet to show all expenses involved in this project, as well as which funding source will pay for each expense. Please be specific about where VHCB funds will go. VHCB funds can be used for capital improvements only – please read the application instructions to ensure your expenses are eligible</td>
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
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>State, Federal, or Other Funding:</strong> Please describe the funds that will support this project and whether the other funding sources are secured. Please explain specifically which components of the project VHCB funds will pay for.
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                              
                                 <asp:TextBox ID="txtSupportingFunds" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">Do you plan to use any of the following funding sources for your project?  If yes, please provide program name(s), amount(s), and grant number(s) if applicable.
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span style="font-weight: bold">Agency of Agriculture Best Management Practices (BMP)</span>
                                <asp:RadioButtonList ID="rdBtnBMP" runat="server" CellPadding="2" CellSpacing="4" RepeatDirection="Horizontal" RepeatLayout="Table" CssClass="normalfont">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Have not applied, but planning to</asp:ListItem>
                                </asp:RadioButtonList>

                                <%-- <asp:TextBox ID="txtNRCSExpensesandStatus" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">If yes, please provide program name(s), amount(s), and grant number(s) if applicable
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                             <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtBMPYes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="3" runat="server" Width="879px" Height="70px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px"><span style="font-weight: bold">Vermont Agency of Agriculture Capital Equipment Assistance Program (CEAP)</span>
                                <asp:RadioButtonList ID="rdBtnCEAP" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" CssClass="normalfont">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Have not applied, but planning to</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2" style="margin-left: 10px">If yes, please provide program name(s), amount(s), and grant number(s) if applicable
                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                             <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtCEAPYes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="3" runat="server" Width="879px" Height="70px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px"><span style="font-weight: bold">USDA NRCS EQIP</span>
                                <asp:RadioButtonList ID="rdBtnEQIP" runat="server" RepeatDirection="Horizontal" CssClass="normalfont">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Have not applied, but planning to</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">If yes, please provide program name(s), amount(s), and grant number(s) if applicable
                            
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtEQIPYes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="3" runat="server" Width="879px" Height="70px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px"><span style="font-weight: bold">Other grant programs</span>
                                <asp:RadioButtonList ID="rdbtnOtherYN" runat="server" RepeatDirection="Horizontal" CssClass="normalfont">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Have not applied, but planning to</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">If yes, please provide program name(s), amount(s), and grant number(s) if applicable
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">&nbsp;&nbsp;&nbsp;
                               
                                 <asp:TextBox ID="txtOtherYes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="3" runat="server" Width="879px" Height="70px" />
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
                               
                                 <asp:TextBox ID="txtWaverRequest" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="50px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;
                                                 <asp:Button ID="previousButton" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="previousButton_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" />
                                &nbsp;&nbsp;<asp:Label runat="server" ID="Label1" class="labelClass" Text="Go To"></asp:Label>
                                <asp:DropDownList ID="ddlGoto" CssClass="clsDropDown" runat="server" Height="23px" Width="185px" AutoPostBack="true" OnSelectedIndexChanged="ddlGoto_SelectedIndexChanged">
                                    <asp:ListItem Text="Select" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Applicant Information" Value="ProjectDetails.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Farm Business Information" Value="FarmBusinessInformation.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Farm Business Information - continued" Value="WaterQualityGrants.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Grant Request" Value="WaterQualityGrantsProgramPage4.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Budget Tables & Narrative" Value="BudgetNarrativeTables.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Narrative Questions" Value="Page7.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Narrative Questions - continued" Value="Page8.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Project Questions" Value="Page9.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Attachments" Value="Page11.aspx"></asp:ListItem>
                                    <asp:ListItem Text="Confidentiality/Submit" Value="Page10.aspx"></asp:ListItem>
                                </asp:DropDownList>
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
