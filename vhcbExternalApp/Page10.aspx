<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page10.aspx.cs" Inherits="vhcbExternalApp.Page10" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <div class="jumbotron">
        <p class="lead"><strong>SECTION F: CONFIDENTIALITY</strong></p>
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
                            <td colspan="2"><span class="labelClass">Sharing your application: Can we forward your application to other Vermont Agriculture Water Quality Partnership Funders, such as USDA-NRCS or the Vermont Agency of Agriculture, Food & Markets, if they have applicable funding available?</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:RadioButtonList ID="rdBtnConfidentSharing" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">If your project is receiving funding from USDA-NRCS or the Vermont Agency of Agriculture, Food & Markets, do we have your permission to discuss your project with staff at those agencies?</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 10px">
                                <asp:RadioButtonList ID="rdbtnConfidentFunding" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" >
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>

                            </td>
                        </tr>
                       <tr>
                            <td colspan="2" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">By submitting your application materials, you agree to allow your business plan and application materials to be read by members of the Review Committee and by staff at the Vermont Farm & Forest Viability Program in accordance with our program’s Confidentiality Policy. No other persons will have access to your application, and all copies will be collected for safekeeping following the meeting of the Review Committee.</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="margin-left: 25px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px">Signature: The information provided in this application and all attachments is true to the best of my (our) knowledge. I/We agree to allow the above-mentioned committee and staff members to read our application. NOTE: Signatures typed within this application are acceptable.
                            </td>
                        </tr>
                       <tr>
                            <td colspan="2" style="height: 25px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass">Signature(s) </span>
                                <asp:TextBox ID="txtConfidentSignature" CssClass="clsTextBoxBlueSm" Width="531px" Height="28px" runat="server"></asp:TextBox>
                                <span class="labelClass">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date </span>
                                <asp:TextBox ID="txtConfidentDate" CssClass="clsTextBoxBlueSm" Width="202px" Height="28px" runat="server"></asp:TextBox>
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


