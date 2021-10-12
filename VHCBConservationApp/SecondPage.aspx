<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SecondPage.aspx.cs" Inherits="VHCBConservationApp.SecondPage" %>


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
                            <td><span class="labelClass" style="margin-left: 10px">1. Within what zoning district(s) is the farm located?</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtZoningDistrict" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">2. What are the allowed minimum lot sizes?</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtMinLotSize" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">3. How many feet of public road frontage is along the area to be conserved?  (note: if property straddles a road, count frontage on both sides)</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtFrontageFeet" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">4. Is the area serviced by a public water supply?</span></td>
                            <td colspan="2">
                                <asp:CheckBox ID="cbPublicWater" runat="server" Text="Yes" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">5. Is the area serviced by a public sewer system:</span></td>
                            <td colspan="2">
                                <asp:CheckBox ID="cbPublicSewer" runat="server" Text="Yes" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">6. Is the farm enrolled in Vermont use value appraisal program? </span></td>
                            <td colspan="2">
                                <asp:CheckBox ID="cbEnrolledUseValue" runat="server" Text="Yes" />

                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">7. Total acreage to be excluded:</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtAcresExcluded" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">8. How is the acreage derived? </span></td>
                            <td colspan="2">
                                <asp:DropDownList runat="Server" ID="ddlAcresDerived">
                                    <asp:ListItem Text="Select One" Value="NA"></asp:ListItem>
                                    <asp:ListItem Text="Deed" Value="Deed"></asp:ListItem>
                                    <asp:ListItem Text="Survey" Value="Survey"></asp:ListItem>
                                    <asp:ListItem Text="GIS" Value="GIS"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">9. If land is to be excluded, please describe why the land will not be conserved.</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtExcludedLand" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">10. Does the deed match the mapped acreage?</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtDeedMatch" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">11. Will a survey be required by NRCS*?</span></td>
                            <td colspan="2">
                                <asp:DropDownList runat="Server" ID="ddlSurveyRequired">
                                    <asp:ListItem Text="Select One" Value="NA"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                    <asp:ListItem Text="Unsure " Value="Unsure "></asp:ListItem>
                                </asp:DropDownList>
                                <span class="labelClass">*if, yes, VHCB can pay up to $3,000 towards a survey.  Please include in a budget. </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>


                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">12. To the best knowledge of the landowner, are there any deed restrictions, such as restrictive covenants or mineral rights, which encumber use of the property?  If yes, describe.  A full title search will be required prior to disbursement of VHCB funds.</span></td>
                            <td colspan="2">
                                <asp:TextBox ID="txtDeedRestrictions" CssClass="clsTextBoxBlue1" runat="server" Width="253px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                        <tr>
                            <td colspan="6" style="margin-left: 10px">
                                 &nbsp; &nbsp;<asp:Button ID="btnPrevious" runat="server" Text="Previous Page/Save" class="btn btn-info" OnClick="btnPrevious_Click"/>
                               &nbsp; &nbsp; <asp:Button ID="btnNext" runat="server" Text="Next Page/Save" class="btn btn-info" OnClick="btnNext_Click" />
                                &nbsp; &nbsp;<asp:Button ID="btnPrint" runat="server" Text="Print Application PDF" class="btn btn-info" OnClick="btnPrint_Click" />
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

