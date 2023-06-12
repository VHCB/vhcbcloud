<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page7.aspx.cs" Inherits="vhcbExternalApp.Page7" %>


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
                     <div id="dvMessage" runat="server" visible="false">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>
                    <table style="width=100%">
                        <tr>
                            <td colspan="2"><span class="labelClass"><strong>
                               SECTION E: NARRATIVE QUESTIONS</strong></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span> The word counts indicated after each question are suggestions and are not required maximums or minimums. If you experience connectivity issues, please save your progress frequently during this section or copy and paste your answers from a plain text (.txt) document</span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass"><b>FARM QUESTIONS</b></span>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">1.	Please provide a narrative overview of your farm business, including a brief farm history. (250 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                          <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtFarmBusiness1" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">2.	Please provide a brief overview of farm production, including herd size, field practices, pasture management, and production practices. (250 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtFarmProduction2" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                          <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td colspan="2"><span class="labelClass">3.	Please describe all products produced on farm and a description of the markets you sell to. (100 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtProductsProduced3" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
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
