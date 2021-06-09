﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WaterQualityGrantsProgramPage4.aspx.cs" Inherits="vhcbExternalApp.WaterQualityGrantsProgramPage4" Async="true" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <script type="text/javascript" src="Scripts/jquery.min.js"></script> 
     <script type="text/javascript" src="Scripts/CurrencyController.js"></script> 
    <style type="text/css">
        .FormatRadioButtonList label {
            margin-left: 5px;
        }

        .auto-style61 {
            height: 5px;
            width: 234px;
        }

        .auto-style7 {
            width: 126px;
        }

        .auto-style62 {
            width: 199px;
        }
        .auto-style63 {
            width: 234px;
        }
    </style>
    <div class="jumbotron">
        <p class="lead">Water Quality Grants Program : Application</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>

                    <div class="panel-width" runat="server" id="dvNewAddress">
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">SECTION C:  GRANT REQUEST</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="dvProjectAddressForm">
                                <asp:Panel runat="server" ID="Panel2">

                                    <div id="dvAddress" runat="server">
                                        <br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td colspan="2"><span class="labelClass" style="margin-left: 10px">Please provide a Project Title, a description of the project, and how much funding you are requesting from VHCB.</span></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style63"><span class="labelClass" style="margin-left: 10px">Project Title <em><strong>(Required)</strong></em>:</span></td>
                                                <td>
                                                    <asp:TextBox ID="txtProjTitle" CssClass="clsTextBoxBlue1" runat="server" Style="margin-left: 0" Width="525px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style61"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><span class="labelClass" style="margin-left: 10px">Project Description (2-4 paragraphs) - Please describe the proposed project you are applying for, how it relates to water quality, and how it fits in with long-term plans for your business <em><strong>(Required)</strong></em>:</span></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" class="auto-style7">
                                                    <asp:TextBox ID="txtProjDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="793px" Height="115px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td><span class="labelClass" style="margin-left: 10px">Grant Funding Request<em><strong> (Required)</strong></em>:</span></td>
                                                <td>
                                                    <span class="labelClass" style="margin-left: 10px"></span>
                                                    <asp:TextBox ID="txtRequest" CssClass="clsTextBoxBlue1" runat="server" Style="margin-left: 24" Width="97px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><span class="labelClass" style="margin-left: 10px">Total Project Cost (Please include all matching funds, including USDA-NRCS and Vermont Agency of Agriculture, Food & Markets grants, bank loans, and/or farm cash that will be used to pay for the project) <em><strong>(Required)</strong></em>:</span></td>
                                            </tr>


                                            <tr>
                                                <td colspan="2" class="auto-style7">
                                                    <span class="labelClass" style="margin-left: 10px"></span>
                                                    <asp:TextBox ID="txtProjCost" CssClass="clsTextBoxBlue1" runat="server" Style="margin-left: 24" Width="97px"></asp:TextBox>

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
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <script language="javascript">
         $(document).ready(function () {
             toCurrencyControl($('#<%= txtRequest.ClientID%>').val(), $('#<%= txtRequest.ClientID%>'));
             toCurrencyControl($('#<%= txtProjCost.ClientID%>').val(), $('#<%= txtProjCost.ClientID%>'));
            

             $('#<%= txtRequest.ClientID%>').keyup(function () {
                 toCurrencyControl($('#<%= txtRequest.ClientID%>').val(), $('#<%= txtRequest.ClientID%>'));
             });
              $('#<%= txtProjCost.ClientID%>').keyup(function () {
                 toCurrencyControl($('#<%= txtProjCost.ClientID%>').val(), $('#<%= txtProjCost.ClientID%>'));
              });
            
         });
                </script>
</asp:Content>
