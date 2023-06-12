<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FarmManagement.aspx.cs" Inherits="VHCBConservationApp.Page5" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>


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
                            <td colspan="3" style="text-decoration: underline; margin-left: 10px"><strong>H. FARM MANAGEMENT AND INFRASTRUCTURE</strong>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">1. How is the farm classified by the Vermont Agency of Agriculture?</span></td>
                            <td>
                                <asp:DropDownList ID="ddlFarmSize" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">2. Is the farm in compliance with VT Required Agricultural Practices (RAPs)?</span> </td>
                            <td>
                                <asp:DropDownList ID="ddlRAPCompliance" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Unsure</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">3. Acres of land rented from others that is part of the same operation and relates to the land being conserved</span></td>
                            <td>
                                <asp:TextBox ID="txtRentedLand" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass" style="margin-left: 10px">4. Total employees (including family members + self)</span></td>
                            <td class="auto-style7">
                                <span class="labelClass" style="margin-left: 10px">Full-Time Year-Round</span>&nbsp; &nbsp;
                                <asp:TextBox ID="txtFullTime" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                            <td>
                                <span class="labelClass" style="margin-left: 10px">Part-Time Year-Round</span>&nbsp; &nbsp;
                                <asp:TextBox ID="txtPartTime" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                         <tr>
                            <td><span class="labelClass" style="margin-left: 10px"></span></td>
                            <td class="auto-style7">
                                <span class="labelClass" style="margin-left: 10px">Full-Time Seasonal</span>&nbsp; &nbsp;&nbsp; &nbsp;
                                <asp:TextBox ID="txtFullTimeSeasonal" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                            <td>
                                <span class="labelClass" style="margin-left: 10px">Part-Time Seasonal</span>&nbsp; &nbsp;&nbsp; &nbsp;
                                <asp:TextBox ID="txtPartTimeSeasonal" CssClass="clsTextBoxBlue1" runat="server" Width="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">5. Annual gross income from farming </span></td>
                            <td>
                                <asp:TextBox ID="txtGrossIncome" CssClass="clsTextBoxBlue1" runat="server" Width="80px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Describe whether this is the AGI for the farmland owner or farmer using the land (if applicable)</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtGrossIncomeDescription" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">6. If the parcel is rented, is there a written lease?</span></td>
                            <td>
                                <asp:RadioButtonList ID="rdbtWrittenLease" runat="server" CellPadding="2" CellSpacing="4"
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
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">7. Has the farmer worked with the VHCB Farm and Forest Viability Program on business planning or other support services?</span></td>
                            <td>&nbsp;<asp:RadioButtonList ID="rdbtCompletedBusinessPlan" runat="server" CellPadding="2" CellSpacing="4" OnSelectedIndexChanged="rdbtCompletedBusinessPlan_SelectedIndexChanged" AutoPostBack="true"
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
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">If so, are the farmers willing to share the business plan, if it is still applicable? </span></td>
                            <td>&nbsp;&nbsp;&nbsp;
                                <asp:RadioButtonList ID="rdbtShareBusinessPlan" runat="server" CellPadding="2" CellSpacing="4"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes &nbsp;</asp:ListItem>
                                    <asp:ListItem> No &nbsp;</asp:ListItem>
                                </asp:RadioButtonList>

                            </td>
                        </tr>
                    </table>
                    <table runat="server" id="tblOptinalQuestions" visible="false">
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Have they worked with other business planning technical advisors? </span></td>
                            <td>
                                <asp:RadioButtonList ID="rdbtOtherTechnicalAdvisors" runat="server" CellPadding="2" CellSpacing="4"
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
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Does the farmer have a current business plan? </span></td>
                            <td>
                                <asp:RadioButtonList ID="rdbtnCurrentBusinessPlan" runat="server" CellPadding="2" CellSpacing="4"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes &nbsp;</asp:ListItem>
                                    <asp:ListItem> No &nbsp;</asp:ListItem>
                                </asp:RadioButtonList>

                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">8. Describe any aspects of the farm's operation that help to mitigate and/or adapt to climate change (i.e. new crops/rotations 
                                to manage risk of extreme weather events, renewable energy projects, hoop houses, etc.)</span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtMitigateClimate" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">9. Does the farm have Highly Erodible Land (HEL), as defined by NRCS? </span></td>
                            <td>
                                <asp:DropDownList ID="ddlHEL" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Unsure</asp:ListItem>
                                </asp:DropDownList>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">10. Does the farm have a nutrient management plan up to NRCS standards? </span></td>
                            <td>
                                <asp:DropDownList ID="ddlNutrientPlan" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Unsure</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">11. Are there are any dumps/significant trash piles on the property? </span></td>
                            <td>
                                <asp:DropDownList ID="ddlDumps" CssClass="clsDropDown" runat="server" Height="23px" Width="95px">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Unsure</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">12. Is there existing farm infrastructure (which could include housing) within the project area? </span></td>
                            <td>
                                <asp:RadioButtonList ID="rdbExistingInfrastructure" runat="server" CellPadding="2" CellSpacing="4"
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
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">If yes, please describe</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtInfrastructureDescription" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">13. Which of the following conservation measures are being used on the property?</span></td>
                            <td>
                                <asp:CheckBoxList ID="cblConservationMeasures" runat="server">
                                    <asp:ListItem Value="Crop rotation">Crop rotation</asp:ListItem>
                                    <asp:ListItem Value="Cover crops">Cover crops</asp:ListItem>
                                    <asp:ListItem Value="No-till methods">No-till methods</asp:ListItem>
                                    <asp:ListItem Value="Manure injection">Manure injection</asp:ListItem>
                                    <asp:ListItem Value="Nutrient management (crops)">Nutrient management (crops)</asp:ListItem>
                                    <asp:ListItem Value="Nutrient management (livestock)">Nutrient management (livestock)</asp:ListItem>
                                    <asp:ListItem Value="Composted bedding system">Composted bedding system</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Other</span></td>
                            <td>
                                <asp:TextBox ID="txtOtherConservationMeasures" CssClass="clsTextBoxBlue1" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">14. Describe anything else about the farm operation and its management that you have not addressed elsewhere:</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtFarmOperation" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
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
                                 &nbsp; &nbsp; 
                                                    <asp:Label runat="server" ID="Label1" class="labelClass" Text ="Go To"></asp:Label>
                                 <asp:DropDownList ID="ddlGoto" CssClass="clsDropDown" runat="server" Height="23px" Width="185px" AutoPostBack="true" OnSelectedIndexChanged="ddlGoto_SelectedIndexChanged">
                                     <asp:ListItem Text="Select" Value="" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="FirstPage" Value="FirstPage.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Farm Conservation Application" Value="SecondPage.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Project Summary" Value="ThirdPage.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Land Resources" Value="Page4.aspx"></asp:ListItem>
                                                        
                                                        <asp:ListItem Text="Water Management" Value="WaterManagement.aspx"></asp:ListItem>
                                                        <asp:ListItem Text="Easement Config" Value="EasementConfig.aspx"></asp:ListItem>

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
            toCurrencyControl($('#<%= txtGrossIncome.ClientID%>').val(), $('#<%= txtGrossIncome.ClientID%>'));

            $('#<%= txtGrossIncome.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtGrossIncome.ClientID%>').val(), $('#<%= txtGrossIncome.ClientID%>'));
            });

        });

    </script>
</asp:Content>




