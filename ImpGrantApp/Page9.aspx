<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page9.aspx.cs" Inherits="ImpGrantApp.Page9" %>

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
                            <td colspan="2"><span class="labelClass"><strong>PROJECT QUESTIONS</strong></span>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass">7.	Describe how your project will have a positive impact on water quality. Where possible, please include concrete numbers for how the project will improve water quality (ex. “Barnyard runoff is estimated to decrease by X%”). If the purpose of this project is to help you comply with state water quality regulations, please explain how the project will help you meet regulations. (250 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtPositiveImpact7" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">8.	List any technical advisors you are or plan to be working with for this project, including advisors from USDA- NRCS, Vermont Agency or Agriculture Food and Markets, the Vermont Association of Conservation Districts, etc. (50 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtTechAdvisors8" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">9.	Describe how this project fits in with long-term plans for your business and any non-water quality outcomes that you anticipate. How will it benefit your farm, your family, your community, or overall farm viability? (100 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtLongTermPlans9" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass">10.	Describe what would happen if you don’t receive this grant. Would you be able to complete this project? (100 words) <em><strong>(Required)</strong></em> </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtNoGrant10" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">11.	What is the estimated timeline for the project? (50 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtTimeline11" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                       <%-- <tr>
                            <td colspan="2"><span class="labelClass">12.	VHCB may award Water Quality Grants to help cover required cost share on state or federal grants under the circumstances described in the application instructions. If you are receiving state or federal grant funds for this project and you cannot contribute the expected farm cost share, please explain. (100 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtNoContribution12" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">12.	If your farm has a nutrient management plan, please indicate when it was completed and by whom. Please summarize key components of the plan and whether any upcoming farm changes might impact nutrient management. (100 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtNutrientManagementPlan13" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">13.	List any federal, state, or local permits or approvals that will be necessary for you to implement this projects, and the status of these applications or processes. If your farm is conserved, please confirm that the proposed project does not conflict with the terms of the conservation easement. (100 words) <em><strong>(Required)</strong></em></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtPermits14" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="879px" Height="150px" />
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

