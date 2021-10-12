<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FirstPage.aspx.cs" Inherits="VHCBConservationApp.FirstPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/CurrencyController.js"></script>
    <style type="text/css">
        .FormatRadioButtonList label {
            margin-left: 5px;
        }

        .auto-style7 {
            width: 274px;
        }

        .auto-style9 {
            width: 216px;
        }

        .auto-style10 {
            width: 271px;
        }
        .auto-style12 {
            height: 10px;
            width: 416px;
        }
        .auto-style13 {
            width: 416px;
        }
    </style>
    <div class="jumbotron">
        <p class="lead">Conservation Application</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <div id="dvMessage" runat="server" visible="false">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>
                    <table>
                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Project Name</span></td>
                            <td colspan="2">
                                <span class="labelClass" runat="server" id="spnProjectName" visible="true"></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Date Submitted</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtDateSubmitted" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtDateSubmitted" TargetControlID="txtDateSubmitted">
                                </ajaxToolkit:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Board Meeting Date</span></td>
                            <td colspan="2">
                                <asp:DropDownList ID="ddlBoardDate" CssClass="clsDropDown" runat="server" Height="23px" Width="185px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Total Number of Acres to be Conserved</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtConservedAcres" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Total Funds Requested from VHCB</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtFundsRequested" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style7"><span class="labelClass" style="margin-left: 10px">Total Project Expenses (from budget )</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtTotalExpenses" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                    </table>

                    <table>
                        <tr>
                            <td colspan="2" style="text-decoration: underline;" class="auto-style7"><strong>A. APPLICANT INFORMATION</strong>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">Applicant Organization</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtAppOrgan" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">Project Manager</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtProjectManager" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">Phone</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtAppPhone" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtAppPhone"
                                    Mask="(999)-999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                </asp:MaskedEditExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">Email</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtAppEmail" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                    </table>



                    <div class="panel-width" runat="server" id="dvNew">
                        <table>
                            <tr>
                                <td colspan="2" style="text-decoration: underline;" class="auto-style7"><strong>B.  LANDOWNER INFORMATION </strong></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td><span class="labelClass" style="margin-left: 10px">Name(s)</span></td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtLONames" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                        </table>
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Mailing Address</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="dvProjectAddressForm">
                                <asp:Panel runat="server" ID="Panel2">

                                    <div id="dvAddress" runat="server">

                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtloStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                                </td>

                                                <td style="width: 100px"><span class="labelClass">Address1:</span></td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtLoAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                                <td class="auto-style10">
                                                    <span class="labelClass">Address2</span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLoAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 170px"><span class="labelClass">Town</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtLoTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtLOZipCode" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                </td>
                                                <td class="auto-style10">
                                                    <span class="labelClass">Village</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtLOVillage" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">County</span></td>
                                                <td class="auto-style9">
                                                    <asp:DropDownList ID="ddlLOCounty" CssClass="clsDropDown" runat="server" Height="23px" Width="185px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px">
                                                    <span class="labelClass" runat="server" id="spnVillage" visible="true">Email</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtLOEmail" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox></td>
                                                <td class="auto-style10"><span class="labelClass">Home phone</span>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLOHomephone" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                    <asp:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtLOHomephone"
                                                        Mask="(999)-999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                                    </asp:MaskedEditExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Cell phone</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtLoCellPhone" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                    <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtLoCellPhone"
                                                        Mask="(999)-999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                                    </asp:MaskedEditExtender>
                                                </td>
                                                <td style="width: 100px"></td>
                                                <td style="width: 270px"></td>
                                                <td class="auto-style10"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>

                        <table>
                            <tr>
                                <td colspan="2" style="text-decoration: underline;" class="auto-style7"><strong>C.  FARMER INFORMATION </strong></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td><span class="labelClass" style="margin-left: 10px">Name</span></td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtFarmerName" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                        </table>
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Mailing Address</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="Div1">
                                <asp:Panel runat="server" ID="Panel1">

                                    <div id="Div2" runat="server">

                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtFarmerStreet" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                                </td>

                                                <td style="width: 100px"><span class="labelClass">Address1:</span></td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtFarmerAdd1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                                <td class="auto-style10">
                                                    <span class="labelClass">Address2</span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFarmerAdd2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 170px"><span class="labelClass">Town</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtFarmerTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtFarmerZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                </td>
                                                <td class="auto-style10">
                                                    <span class="labelClass">Village</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtFarmerVillage" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">County</span></td>
                                                <td class="auto-style9">
                                                    <asp:DropDownList ID="ddlFarmerCounty" CssClass="clsDropDown" runat="server" Height="23px" Width="185px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px">
                                                    <span class="labelClass" runat="server" id="Span1" visible="true">Email</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtFarmerEmail" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox></td>
                                                <td class="auto-style10"><span class="labelClass">Home phone</span>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFarmerHomePhone" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                    <asp:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFarmerHomePhone"
                                                        Mask="(999)-999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                                    </asp:MaskedEditExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Cell phone</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtFarmerCell" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                    <asp:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtFarmerCell"
                                                        Mask="(999)-999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                                    </asp:MaskedEditExtender>
                                                </td>
                                                <td style="width: 100px"></td>
                                                <td style="width: 270px"></td>
                                                <td class="auto-style10"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>

                        <table>
                            <tr>
                                <td colspan="2" style="text-decoration: underline;" class="auto-style13"><strong>D.  PROPERTY INFORMATION (if different from above) </strong></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="auto-style12"></td>
                            </tr>
                           <%-- <tr>
                                <td><span class="labelClass" style="margin-left: 10px">Name(s)</span></td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtPropertyName" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>--%>
                        </table>
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Address</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="Div3">
                                <asp:Panel runat="server" ID="Panel3">

                                    <div id="Div4" runat="server">

                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtPropertyStreet" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                                </td>

                                                <td style="width: 100px"><span class="labelClass">Address1:</span></td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtPropertyAdd1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                                <td class="auto-style10">
                                                    <span class="labelClass">Address2</span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPropertyAdd2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 170px"><span class="labelClass">Town</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtPropertyTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px"><span class="labelClass">Other Town(s)</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtPropertyOtherTown" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                </td>
                                                <td class="auto-style10">
                                                    <span class="labelClass">State</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtPropertyState" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Zip</span></td>
                                                <td class="auto-style9">
                                                    <asp:TextBox ID="txtPropertyZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px">
                                                    <span class="labelClass" runat="server" id="Span2" visible="true"></span>
                                                </td>
                                                <td style="width: 270px"></td>
                                                <td class="auto-style10"><span class="labelClass"></span>

                                                </td>
                                                <td></td>
                                            </tr>
                                              <tr>
                                                <td colspan="6" style="height: 15px"></td>
                                            </tr>

                                            <tr>
                                                <td colspan="6" style="height: 5px">
                                                      <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" /> &nbsp; &nbsp;
                                                     <asp:Button ID="btnPrint" runat="server" Text="Print Application PDF" class="btn btn-info" OnClick="btnPrint_Click" />
                                                </td>
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
            toCurrencyControl($('#<%= txtFundsRequested.ClientID%>').val(), $('#<%= txtFundsRequested.ClientID%>'));
            toCurrencyControl($('#<%= txtTotalExpenses.ClientID%>').val(), $('#<%= txtTotalExpenses.ClientID%>'));

            $('#<%= txtFundsRequested.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtFundsRequested.ClientID%>').val(), $('#<%= txtFundsRequested.ClientID%>'));
            });

            $('#<%= txtTotalExpenses.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtTotalExpenses.ClientID%>').val(), $('#<%= txtTotalExpenses.ClientID%>'));
            });

        });

    </script>
</asp:Content>

