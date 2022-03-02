<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="FarmBusinessInformation.aspx.cs" Inherits="ImpGrantApp.FarmBusinessInformation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/CurrencyController.js"></script>
    <style type="text/css">
        .FormatRadioButtonList label {
            margin-left: 5px;
        }

        .auto-style2 {
            width: 354px;
        }

        .auto-style3 {
            width: 352px;
        }

        .auto-style5 {
            width: 344px;
        }

        .auto-style7 {
            border: 1px solid #678FC2;
            background-color: #edeeee;
            font-size: 8pt;
            font-family: helvetica, sans-serif;
        }

        .auto-style8 {
            width: 545px;
        }

        .checkboxlist_nowrap label {
            white-space: nowrap;
            display: inline-block;
        }
    </style>
    <div class="jumbotron">
        <p class="lead">SECTION B: FARM BUSINESS INFORMATION</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>
                    <table>

                        <tr>
                            <td class="auto-style8"><span class="labelClass" style="margin-left: 10px">Farm Name:
                                <br />
                                <span style="margin-left: 10px">Business name as listed on most recent tax forms (if different than farm name)</span></span></td>
                            <td>
                                <asp:TextBox ID="txtOrgName" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style8"><span class="labelClass" style="margin-left: 10px">Website:</span></td>

                            <td style="height: 10px">
                                <asp:TextBox ID="txtWebsite" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="auto-style8"><span class="labelClass" style="margin-left: 10px">Ownership Structure:</span></td>
                            <td style="vertical-align:bottom">
                                <asp:RadioButtonList ID="rdBtnOrgStructure" runat="server" Width="158px" RepeatDirection="Vertical" RepeatLayout="Table" CssClass="FormatRadioButtonList">
                                    <asp:ListItem>Sole Proprietor</asp:ListItem>
                                    <asp:ListItem>Partnership</asp:ListItem>
                                    <asp:ListItem>LLC</asp:ListItem>
                                    <asp:ListItem>Corporation</asp:ListItem>
                                    <asp:ListItem>Other (Specify)</asp:ListItem>
                                </asp:RadioButtonList>
                          
                            
                                <asp:TextBox ID="txtOrgStructureOther" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                    </table>
                    <div class="panel-width" runat="server" id="dvNewAddress">
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Please provide financial information for the most recent tax year (REQUIRED):</h3>
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
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Gross Sales:</span></td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtGrossSales" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Net Income:</span></td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtNetIncome" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>

                                            <%-- <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Net Worth:</span></td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtNetWorth" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Gross Payroll:</span></td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtGrossPayroll" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>--%>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Family FTEs (Full-time equivalent, including self):</span></td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtFamilyETF" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Non-Family FTEs :</span></td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtNonFamilyETF" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Is your farm, or any of the land you own:</span></td>
                                                <td colspan="2">
                                                    <asp:CheckBoxList ID="cbOwnLandList" runat="server" AutoPostBack="false" Width="450px">
                                                    </asp:CheckBoxList>

                                                    <%--   <asp:CheckBoxList ID="cbListLandown" runat="server" Width="270px" RepeatDirection="Vertical" RepeatLayout="Table" CssClass="FormatRadioButtonList">
                                                        <asp:ListItem>Organic</asp:ListItem>
                                                        <asp:ListItem>Conserved</asp:ListItem>
                                                        <asp:ListItem>In Lake Champlain Basin</asp:ListItem>
                                                    </asp:CheckBoxList>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style5"><span class="labelClass" style="margin-left: 10px">Year began managing business or organization:</span></td>
                                                <td colspan="2">
                                                    <asp:DropDownList ID="ddlFiscalyr" CssClass="auto-style7" runat="server" Height="20px" Width="167px"></asp:DropDownList>
                                                    <%--<asp:TextBox ID="txtFiscalyr" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Please give current numbers of:</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="Div1">
                                <asp:Panel runat="server" ID="Panel1">


                                    <table style="width: 100%">
                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Acres Owned:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtAcresOwned" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Acres Leased:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtAcresLeased" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Acres in Crop Production:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtAcresinProduction" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Acres in Pasture:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtPastureAcres" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                    </table>


                                </asp:Panel>
                            </div>
                        </div>

                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">For non-dairy farms - Number of:</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="Div4">
                                <asp:Panel runat="server" ID="Panel4">


                                    <table style="width: 100%">
                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Cows:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtCows" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Hogs:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtHogs" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Poultry:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtPoultry" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style3"><span class="labelClass" style="margin-left: 10px">Other (please specify):</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtOtherNonDiaryFarms" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                    </table>

                                </asp:Panel>
                            </div>
                        </div>

                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">For dairy farms:</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="Div7">
                                <asp:Panel runat="server" ID="Panel6">


                                    <table style="width: 100%">
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Animals milked daily:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtMilkedDaily" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Primary animal type(s) (cow, goat, sheep, etc.):</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtPrimaryAnimalTypes" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Total Herd Number:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtHerd" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Rolling Herd Average:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtRollingHerd" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Pounds milk shipped per year:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtMilkPounds" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Average cull rate:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtAvgCullRate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Somatic cell count:</span></td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtSomaticCell" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 5px"></td>

                                        </tr>
                                        <tr>
                                            <td class="auto-style2"><span class="labelClass" style="margin-left: 10px">Where do you sell your milk? (Select all that apply):</span></td>
                                            <td colspan="2">
                                                <asp:CheckBoxList Width="300px" ID="lstMilkSold" runat="server" RepeatDirection="Vertical" RepeatColumns="1" BorderWidth="0"
                                                    Datafield="description" DataValueField="value" CssClass="checkboxlist_nowrap">
                                                    <asp:ListItem Text="St. Albans Coop/Dairy Farmers of America" Value="St. Albans Coop/Dairy Farmers of America" />
                                                    <asp:ListItem Text="Organic Valley" Value="Organic Valley" />
                                                    <asp:ListItem Text="NFO" Value="NFO" />
                                                    <asp:ListItem Text="Agrimark" Value="Agrimark" />
                                                    <asp:ListItem Text="Horizon Organic" Value="Horizon Organic" />
                                                    <asp:ListItem Text="Stonyfield" Value="Stonyfield" />
                                                    <asp:ListItem Text="HP Hood" Value="HP Hood" />
                                                    <asp:ListItem Text="Upstate Niagara" Value="Upstate Niagara" />
                                                    <asp:ListItem Text="N/A" Value="N/A" />
                                                    <asp:ListItem Text="Other" Value="Other" />
                                                </asp:CheckBoxList>
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
            toCurrencyControl($('#<%= txtGrossSales.ClientID%>').val(), $('#<%= txtGrossSales.ClientID%>'));
            toCurrencyControl($('#<%= txtNetIncome.ClientID%>').val(), $('#<%= txtNetIncome.ClientID%>'));
            <%-- toCurrencyControl($('#<%= txtNetWorth.ClientID%>').val(), $('#<%= txtNetWorth.ClientID%>'));
             toCurrencyControl($('#<%= txtGrossPayroll.ClientID%>').val(), $('#<%= txtGrossPayroll.ClientID%>'));--%>

            $('#<%= txtGrossSales.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtGrossSales.ClientID%>').val(), $('#<%= txtGrossSales.ClientID%>'));
             });
            $('#<%= txtNetIncome.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtNetIncome.ClientID%>').val(), $('#<%= txtNetIncome.ClientID%>'));
             });
           <%--  $('#<%= txtNetWorth.ClientID%>').keyup(function () {
                 toCurrencyControl($('#<%= txtNetWorth.ClientID%>').val(), $('#<%= txtNetWorth.ClientID%>'));
              });
             $('#<%= txtGrossPayroll.ClientID%>').keyup(function () {
                 toCurrencyControl($('#<%= txtGrossPayroll.ClientID%>').val(), $('#<%= txtGrossPayroll.ClientID%>'));
              });--%>
        });
    </script>
</asp:Content>
