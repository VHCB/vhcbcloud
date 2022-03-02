<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Eligibility.aspx.cs" Inherits="ImpGrantApp.Eligibility" %>



<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <div class="jumbotron">
        <p class="lead"><strong>SECTION Eligibility</strong></p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red" Visible="false"></asp:Label></p>
                    </div>
                    <table style="width=100%">

                       <%-- <tr>
                            <td colspan="2"><span class="labelClass">Did you complete a planning project through the Viability Program in 2020, 2021, or 2022?</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:RadioButtonList ID="rdBtnCompletePlanning" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnCompletePlanning_SelectedIndexChanged">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="2" style="height: 15px"><span class="labelClass" style="margin-left: 10px" id="lblCompletePlanningMessage" runat="server" visible="false"><strong>If you did not complete a planning project through the Viability Program between 2020 and 2022, you are not eligible for this round of grant funding. Please reach out to Aaron Guman, Aaron@vhcb.org or 802-828-5587, for questions regarding eligibility.</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">Which Viability Program service provider or consultant/advisor(s) did you work with through the Viability Program?</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:TextBox ID="txtPrimeAdvisor2" CssClass="clsTextBoxBlue1" runat="server" Width="253px" MaxLength="150"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">At which organization is your consultant/advisor based? </span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAdvisorOrg" CssClass="clsDropDown" runat="server" Visible="true" Style="margin-left: 0">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Other</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOtherAdvisor" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>

                        <tr>
                            <td colspan="2" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;
                                                 <asp:Button ID="previousButton" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="previousButton_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>



