<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page7.aspx.cs" Inherits="ImpGrantApp.Page7" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <div class="jumbotron">
        <p class="lead"></p>
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
                            <td colspan="2"><span class="labelClass"><strong>
                               SECTION F: BUSINESS PLAN AND NARRATIVE QUESTIONS</strong></span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">FARM QUESTIONS</span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">1.	Overview of Business. Please provide a basic description of your business, including a brief history, products produced, how products are marketed, ownership and management, etc. Feel free to include an excerpt from your business plan (~200 words). <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                          <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtBusinessOverview" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">2.	Proposed Project Description. Please describe the proposed investment (project) for which you are seeking assistance. Please list page number/s in your plan where the new activity is described: <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtProjectDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                          <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">3.	Coordination with your Business Plan. Explain how this project fits in with your overall plans for your business. Please provide a brief description of the goals and implementation plans set forth in your business plan and describe how this project fits in.  It will be most helpful to your application for you to reference specific portions of your plan.  (~200 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtPlanCoordination" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
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
