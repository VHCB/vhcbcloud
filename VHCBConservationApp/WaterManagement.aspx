<%@ Page Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WaterManagement.aspx.cs" Inherits="VHCBConservationApp.WaterManagement"   MaintainScrollPositionOnPostback="true" EnableEventValidation="false"%>


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
            width: 202px;
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
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-decoration: underline; margin-left: 10px"><strong>I. WATER RESOURCES & MANAGEMENT</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">1. How many acres of wetlands are on the property?</span></td>
                            <td>
                                <asp:TextBox ID="txtWetlands" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">2. How many acres of pond(s) on the property?</span></td>
                            <td>
                                <asp:TextBox ID="txtPonds" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">3. How many acres of floodplain are on the property?</span></td>
                            <td>
                                <asp:TextBox ID="txtFloodplain" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">4. How many linear feet along perennial streams/rivers are on the property?</span></td>
                            <td>
                                <asp:TextBox ID="txtStreamfeet" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">5. How many linear feet of pond and/or lake frontage does the property have? </span></td>
                            <td>
                                <asp:TextBox ID="txtPondFeet" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">6. What are the names of the water bodies on the property? </span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtWaterBodies" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">7. What watershed is the project located in?</span></td>
                            <td>
                                <asp:DropDownList ID="ddlWatershed" CssClass="clsDropDown" runat="server" Height="23px" Width="185px" OnSelectedIndexChanged="ddlWatershed_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">8. What subwatershed is the project located in? (to locate the subwatershed, visit <a href="https://geodata.vermont.gov/datasets/vt-subwatershed-boundaries-huc12/explore?location">this website</a>.)</span></td>
                            <td>
                                <asp:DropDownList ID="ddlSubWatershed" CssClass="clsDropDown" runat="server" Height="23px" Width="185px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Secondary Watershed</span></td>
                            <td>
                                <asp:DropDownList ID="ddlSecWatershed" CssClass="clsDropDown" runat="server" Height="23px" Width="185px" OnSelectedIndexChanged="ddlSecWatershed_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Secondary subwatershed</span></td>
                            <td>
                                <asp:DropDownList ID="ddlSecSubWatershed" CssClass="clsDropDown" runat="server" Height="23px" Width="185px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">9. What tactical basin is the projected located in [pull-down menu] (to locate the tactical basin, visit <a href="https://geodata.vermont.gov/datasets/VTANR::tactical-basin-planning/explore?location">this website</a>.) </span></td>
                            <td>
                                <asp:TextBox ID="txtTacticalBasin" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">10. Are there drainage ditches installed on the property?  </span></td>
                            <td>
                                <asp:DropDownList ID="ddlDrainageDitches" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>N/A</asp:ListItem>
                                    <asp:ListItem>Unsure</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">11. Are there drainage tiles installed on the property? </span></td>
                            <td>
                                <asp:DropDownList ID="ddlDrainageTiles" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>N/A</asp:ListItem>
                                    <asp:ListItem>Unsure</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">12. Any other types of waste or water management infrastructure to note?</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtWasteInfrastucture" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">13. Describe any management practices used to protect water quality, if applicable.</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtProtectWater" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">14. Has the landowner ever participated in the VHCB water quality grants program and/or other water quality focused state or federal programs including, 
                                
                                but not limited to,
                                <br />
                                the Conservation Reserve Enhancement Program (CREP), the Capital Equipment Assistance Program (CEAP), Best Management Practices (BMP) program,
                                <br />
                                the Environmental Quality Incentives Program (EQIP)?</span>
                            </td>
                               <td>
                                 <asp:RadioButtonList ID="rdbtParticipateWaterGrant" runat="server" CellPadding="2" CellSpacing="4"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes &nbsp;</asp:ListItem>
                                    <asp:ListItem> No &nbsp;</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>

                        </tr>
                       
                         <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px"> If so, please briefly describe how the funds were used to support water quality improvements.</span></td>
                        </tr>
                         <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtParticipateWaterGrant" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="4" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">15. Are livestock excluded from all surface waters? </span></td>
                            <td>
                                <asp:DropDownList ID="ddlLivestockExcluded" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>N/A</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">16. Briefly describe any known water quality or other resource-related concerns on the property.</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtWaterQualityConcerns" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="4" runat="server" Width="971px" />
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
                                <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" />

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


        });

    </script>
</asp:Content>




