<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EasementConfig.aspx.cs" Inherits="VHCBConservationFarm.EasementConfig" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" runat="server" media="screen" href="~/Content/StyleSheet.css" />
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/CurrencyController.js"></script>
    <style type="text/css">
        .FormatRadioButtonList label {
            margin-left: 5px;
        }
         .cblPlanCommisionsInformedStyle td {
            margin-right: 10px;
            padding-right: 20px;
        }
    </style>
    <div class="jumbotron">
        <p class="lead">Farm Conservation Application</p>
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
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-decoration: underline; margin-left: 10px"><strong>J. EASEMENT CONFIGURATION & SPECIAL PROTECTION AREAS</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">1. How many easements will this be?</span></td>
                            <td>
                                <asp:TextBox ID="txtNumEase" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">2.  Which of the following standard easement terms apply to this project?</span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbBldgComplexChk" runat="server" Text="  Building complex(es):list number and approximate acreages" /></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtBldgComplex" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbSoleDiscretionChk" runat="server" Text="  Sole discretion farm labor housing right" /></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtSoleDiscretion" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbFarmLaborChk" runat="server" Text="  Reserved right for new farm labor housing:  list number of new homes and maximum size allowed" /></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtFarmLabor" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbSubdivisionChk" runat="server" Text="  Reserved right for a subdivision: describe reason for the subdivision and show location of subdivision on attached ortho map." /></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtSubdivision" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>


                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbCampRightChk" runat="server" Text="Standard camp right" /></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtCampRight" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbEasementTermsOtherChk" runat="server" Text="Other" /></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtEasementTermsOther" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">3. Will this project be subject to any special easement terms to protect significant wildlife habitat, unique or rare natural communities, historic resources, public access, etc.?  Please check all that apply below:</span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbEcoZoneChk" runat="server" Text="Ecological protection zone: In the box below, describe the reason for the zone(s) – what is it protecting? Show the approximate location of the zone on one of your attached maps." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">Eco Zone Acres:</span>
                                <asp:TextBox ID="txtEcoZoneAcres" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtEcoZone" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbWetlandZoneChk" runat="server" Text="Wetland protection zone: In the box below, describe the reason for the zone(s) – what is it protecting? Show the approximate location of the zone(s) on one of your attached maps." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">Wetland Zone Acres:</span>
                                <asp:TextBox ID="txtWetlandZoneAcres" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtWetlandZone" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbRiparianZoneChk" runat="server" Text="Riparian buffer zone: In the box below, describe the reason for the zone(s) – what is it protecting? Show the approximate location of the zone(s) on one of your attached maps." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">Riparian Zone Acres:</span>
                                <asp:TextBox ID="txtRiparianZoneAcres" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtRiparianZone" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbArcheoZoneChk" runat="server" Text="Archaeological zone: In the box below, describe the reason for the zone(s) – what is it protecting? Show the approximate location of the zone(s) on one of your attached maps." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">Archaeological Zone Acres:</span>
                                <asp:TextBox ID="txtArcheoZoneAcres" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtArcheoZone" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbRiverEasementChk" runat="server" Text="River corridor easement: In the box below, describe the reason for the zone(s) – what is it protecting? Show the approximate location of the zone(s) on one of your attached maps." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">River Easement Acres:</span>
                                <asp:TextBox ID="txtRiverEasementAcres" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtRiverEasement" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbHistoricProvisionChk" runat="server" Text="Historic notice provision: In the box below, describe the historical resources that will be protected." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">Historic Provision Acres:</span>
                                <asp:TextBox ID="txtHistoricProvisionAcres" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtHistoricProvision" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbPublicAccessChk" runat="server" Text="Public access: In the box below, describe the terms of any public access language that will be included in the easement, such as a trail corridor easement." /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">Public Access:</span>
                                <asp:TextBox ID="txtPublicAccess" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtPublicAccessDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;&nbsp;&nbsp;<span class="labelClass" style="margin-left: 10px">
                                <asp:CheckBox ID="cbEasementTermsOther2Chk" runat="server" Text="Other:" /></span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                 <asp:TextBox ID="txtEasementTermsOther2" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />


                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-decoration: underline; margin-left: 10px"><strong>K. LEVERAGE AND SUPPORT</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">1. Describe how this project is in conformance with adopted or proposed local and regional plans and zoning. </span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                 <asp:TextBox ID="txtConformancePlans" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">2. Whenever possible, VHCB encourages applicants to bring leverage (ie, match) to the table in the form of landowner bargain sales and/or
                                <br />
                                local fundraising (ie, town conservation fund, land trust fundraising).  If this project does not include any leverage, please describe why it is not possible and what fundraising possibilities (if any) were explored. </span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                 <asp:TextBox ID="txtNoLeverage" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">3. VHCB requires applicants to inform towns and Regional Planning Commissions in writing about proposed conservation projects prior to submitting an application to VHCB. </span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                 <asp:TextBox ID="txtInformTowns" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table>
                                    <tr>
                                        <td style="width: 40%"><span class="labelClass" style="margin-left: 10px">Please confirm that a letter has been sent to: </span></td>
                                        <td style="width: 60%">
                                            <asp:CheckBoxList ID="cblPlanCommisionsInformed" runat="server" RepeatDirection="Horizontal" CssClass="cblPlanCommisionsInformedStyle">
                                                <asp:ListItem Value="Municipal officials">Municipal officials</asp:ListItem>
                                                <asp:ListItem Value="Regional Planning Commission">Regional Planning Commission</asp:ListItem>
                                                <asp:ListItem Value="Other">Other</asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                    </tr>
                                </table>

                            </td>


                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">4. Describe any endorsements or other indications of community support for this project, if applicable </span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;
                                 <asp:TextBox ID="txtEndorsements" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-decoration: underline; margin-left: 10px"><strong>L. ADDITIONAL INFORMATION</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">1. Whenever possible, VHCB endeavors to support dual goal projects (projects that support both affordable housing and conservation).  If applicable, describe how this project supports affordable housing  </span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtDualGoals" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">2. Extra space – if needed, use this space to add anything you wish to clarify about your proposed projects</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtClarification" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="6" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px; margin-left: 10px">&nbsp;&nbsp;&nbsp;&nbsp; <a href="#" target="_blank" runat="server" id="UploadLink"><strong><span style="font-size: large">ATTACHMENTS TO UPLOAD</span></strong></a>
                            </td>
                        </tr>
                    </table>

                    <table>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="margin-left: 10px">&nbsp; &nbsp;<asp:Button ID="btnPrevious" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="btnPrevious_Click" />
                                &nbsp; &nbsp;
                                <asp:Button ID="btnNext" runat="server" Text="Submit" class="btn btn-info" OnClick="btnNext_Click" />
                                  &nbsp; &nbsp; 
                                                    <asp:Label runat="server" ID="Label1" class="labelClass" Text ="Go To"></asp:Label>
                                 <asp:DropDownList ID="ddlGoto" CssClass="clsDropDown" runat="server" Height="23px" Width="185px" AutoPostBack="true" OnSelectedIndexChanged="ddlGoto_SelectedIndexChanged">
                                     <asp:ListItem Text="Select" Value="" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="FirstPage" Value="FirstPage.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Farm Conservation Application" Value="SecondPage.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Project Summary" Value="ThirdPage.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Land Resources" Value="Page4.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Farm Management" Value="FarmManagement.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Water Management" Value="WaterManagement.aspx"></asp:ListItem>
                                                       

                                                    </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
    </div>

    <script language="javascript">

        $(document).ready(function () {
            $('#<%= cbBldgComplexChk.ClientID%>').click(function () {
                if ($(this).is(':checked'))
                    $('#<%=txtBldgComplex.ClientID %>').removeAttr("disabled");
                else
                    $('#<%= txtBldgComplex.ClientID%>').val("").attr("disabled", "disabled");
            }).change();

            $('#<%= cbSoleDiscretionChk.ClientID%>').click(function () {
                if ($(this).is(':checked'))
                    $('#<%=txtSoleDiscretion.ClientID %>').removeAttr("disabled");
                else
                    $('#<%= txtSoleDiscretion.ClientID%>').val("").attr("disabled", "disabled");
            }).change();

            $('#<%= cbFarmLaborChk.ClientID%>').click(function () {
                if ($(this).is(':checked'))
                    $('#<%=txtFarmLabor.ClientID %>').removeAttr("disabled");
                else
                    $('#<%= txtFarmLabor.ClientID%>').val("").attr("disabled", "disabled");
            }).change();

            $('#<%= cbSubdivisionChk.ClientID%>').click(function () {
                if ($(this).is(':checked'))
                    $('#<%=txtSubdivision.ClientID %>').removeAttr("disabled");
                else
                    $('#<%= txtSubdivision.ClientID%>').val("").attr("disabled", "disabled");
            }).change();

            $('#<%= cbCampRightChk.ClientID%>').click(function () {
                if ($(this).is(':checked'))
                    $('#<%=txtCampRight.ClientID %>').removeAttr("disabled");
                else
                    $('#<%= txtCampRight.ClientID%>').val("").attr("disabled", "disabled");
            }).change();

            $('#<%= cbEasementTermsOtherChk.ClientID%>').click(function () {
                if ($(this).is(':checked'))
                    $('#<%=txtEasementTermsOther.ClientID %>').removeAttr("disabled");
                else
                    $('#<%= txtEasementTermsOther.ClientID%>').val("").attr("disabled", "disabled");
            }).change();

            $('#<%= cbEcoZoneChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtEcoZoneAcres.ClientID %>').removeAttr("disabled");
                    $('#<%=txtEcoZone.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtEcoZoneAcres.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtEcoZone.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbWetlandZoneChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtWetlandZoneAcres.ClientID %>').removeAttr("disabled");
                    $('#<%=txtWetlandZone.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtWetlandZoneAcres.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtWetlandZone.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbRiparianZoneChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtRiparianZoneAcres.ClientID %>').removeAttr("disabled");
                    $('#<%=txtRiparianZone.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtRiparianZoneAcres.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtRiparianZone.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbArcheoZoneChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtArcheoZoneAcres.ClientID %>').removeAttr("disabled");
                    $('#<%=txtArcheoZone.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtArcheoZoneAcres.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtArcheoZone.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbRiverEasementChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtRiverEasementAcres.ClientID %>').removeAttr("disabled");
                    $('#<%=txtRiverEasement.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtRiverEasementAcres.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtRiverEasement.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbHistoricProvisionChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtHistoricProvisionAcres.ClientID %>').removeAttr("disabled");
                    $('#<%=txtHistoricProvision.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtHistoricProvisionAcres.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtHistoricProvision.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbPublicAccessChk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtPublicAccess.ClientID %>').removeAttr("disabled");
                    $('#<%=txtPublicAccessDesc.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtPublicAccess.ClientID%>').val("").attr("disabled", "disabled");
                    $('#<%= txtPublicAccessDesc.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();

            $('#<%= cbEasementTermsOther2Chk.ClientID%>').click(function () {
                if ($(this).is(':checked')) {
                    $('#<%=txtEasementTermsOther2.ClientID %>').removeAttr("disabled");
                }
                else {
                    $('#<%= txtEasementTermsOther2.ClientID%>').val("").attr("disabled", "disabled");
                }
            }).change();
        });

    </script>
</asp:Content>




