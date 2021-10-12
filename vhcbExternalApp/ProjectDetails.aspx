<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProjectDetails.aspx.cs" Inherits="vhcbExternalApp.ProjectDetails" Async="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <style type="text/css">
        .FormatRadioButtonList label {
            margin-left: 5px;
        }
        .auto-style1 {
            width: 500px
        }
        .auto-style7 {
            height: 5px;
        }
    </style>
    <div class="jumbotron">
        <p class="lead">Viability Application</p>
        <div class="container">
            <div class="panel panel-default">
                <div id="dvEntityRole" runat="server">
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                    <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label></p>
                    </div>
                    <table>

                        <%-- <tr>
                            <td><span class="labelClass" style="margin-left: 10px">Which of these best describes you</span></td>
                            <td>
                                <asp:RadioButtonList ID="rdBtnProjType" runat="server" Width="270px" RepeatDirection="Vertical" RepeatLayout="Table" CssClass="FormatRadioButtonList">
                                    <asp:ListItem>Farm Enterprise</asp:ListItem>
                                    <asp:ListItem>Food Enterprise</asp:ListItem>
                                    <asp:ListItem>Forest Products Enterprise</asp:ListItem>
                                    <asp:ListItem>Forest Landowner</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>--%>

                        <tr>
                            <td colspan="2" style="text-decoration: underline;" class="auto-style7"><strong>Applicant Information</strong></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">All Owners/Operators (including primary contact)</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtOwners" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">Primary Contact </span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtPrimaryContact" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
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
                                            <h3 class="panel-title">Mailing Address</h3>
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
                                                <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtStreetNo" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                                </td>

                                                <td style="width: 100px"><span class="labelClass">Address1:</span></td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                                <td style="width: 170px">
                                                    <span class="labelClass">Address2</span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 170px"><span class="labelClass">City</span></td>
                                                <td>
                                                    <asp:TextBox ID="txtCity" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px"><span class="labelClass">Zip Code</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtZipCode" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px">
                                                    <span class="labelClass">Village</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtVillage" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">County</span></td>
                                                <td style="width: 250px">
                                                    <asp:DropDownList ID="ddlCounty" CssClass="clsDropDown" runat="server" Visible="true">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px">
                                                    <span class="labelClass" runat="server" id="spnVillage" visible="true"></span>
                                                </td>
                                                <td style="width: 270px"></td>
                                                <td style="width: 170px"><span class="labelClass"></span></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>


                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
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
                                            <h3 class="panel-title">Physical Address / Location (if different from Mailing Address Above)</h3>
                                        </td>
                                        <td style="text-align: right"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" runat="server" id="Div1">
                                <asp:Panel runat="server" ID="Panel1">

                                    <div id="Div2" runat="server">
                                        <br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">Street #</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtPhyStreet1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="12"></asp:TextBox>
                                                </td>

                                                <td style="width: 100px"><span class="labelClass">Address1</span></td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtPhyAddress1" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                                <td style="width: 170px">
                                                    <span class="labelClass">Address2</span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPhyAddress2" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 170px"><span class="labelClass">City</span></td>
                                                <td>
                                                    <asp:TextBox ID="txtPhyCity" CssClass="clsTextBoxBlue1" runat="server" MaxLength="60"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px"><span class="labelClass">Zip code</span></td>
                                                <td style="width: 250px">
                                                    <asp:TextBox ID="txtPhyZip" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px">
                                                    <span class="labelClass">Village</span>
                                                </td>
                                                <td style="width: 270px">
                                                    <asp:TextBox ID="txtPhyVillage" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"><span class="labelClass">County</span></td>
                                                <td style="width: 250px">
                                                    <asp:DropDownList ID="ddlPhyCounty" CssClass="clsDropDown" runat="server" Visible="true">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px"></td>
                                                <td style="width: 270px"></td>
                                                <td style="width: 170px"><span class="labelClass"></span></td>
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
                        <div class="panel panel-default" style="margin-bottom: 2px;">
                            <table>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px">Work Phone</span></td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtWorkPhone" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                        <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtWorkPhone"
                                            Mask="(999)999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                        </asp:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 5px"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px">Cell Phone</span></td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtCellPhone" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                        <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtCellPhone"
                                            Mask="(999)999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                        </asp:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px">Home Phone</span></td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtHomePhone" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                        <asp:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtHomePhone"
                                            Mask="(999)999-9999" MessageValidatorTip="true" ErrorTooltipEnabled="True">
                                        </asp:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px">Email</span></td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtEmail" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px">How did you hear about the Vermont Farm & Forest Viability Program?</span></td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="ddlHearAbout" CssClass="clsDropDown" runat="server" Visible="true">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px">Have you participated in the Vermont Farm & Forest Viability Program before:</span></td>
                                    <td colspan="2">
                                        <asp:RadioButtonList ID="rdBtnPriorParticipation" runat="server" CellPadding="2" CellSpacing="4" AutoPostBack="true" OnSelectedIndexChanged="rdBtnPriorParticipation_SelectedIndexChanged"
                                            RepeatDirection="Horizontal">
                                            <asp:ListItem>Yes</asp:ListItem>
                                            <asp:ListItem>No</asp:ListItem>
                                            <asp:ListItem>Not Sure</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                 <tr>
                                    <td class="auto-style1"><span class="labelClass" style="margin-left: 10px" id="lblPrimeAdvisor" runat="server" visible="false">When and who was your business advisor?</span></td>
                                    <td colspan="2">
                                      <asp:TextBox ID="txtPrimeAdvisor" CssClass="clsTextBoxBlue1" runat="server" Width="253px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                                <%--<tr>
                                    <td style="width: 252px"><span class="labelClass" style="margin-left: 10px">Which is your preferred contact?</span>  </td>
                                    <td colspan="2">
                                        <asp:RadioButtonList ID="rbPreferredContact" runat="server" Width="270px" RepeatDirection="Vertical" CssClass="FormatRadioButtonList">
                                            <asp:ListItem>Work Phone</asp:ListItem>
                                            <asp:ListItem>Cell Phone</asp:ListItem>
                                            <asp:ListItem>Home Phone</asp:ListItem>
                                            <asp:ListItem>Email</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                </tr>--%>
                                <tr>
                                    <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" /></td>
                                </tr>
                                  <tr>
                                    <td colspan="3" style="height: 10px"></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
