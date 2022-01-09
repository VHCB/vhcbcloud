<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Page4.aspx.cs" Inherits="VHCBConservationApp.Page4" MaintainScrollPositionOnPostback="true" %>


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
                            <td colspan="2" style="text-decoration: underline; margin-left: 10px" class="auto-style7"><strong>G. LAND RESOURCES</strong>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">1. How is the land being used?  (Check all that apply and include relevant information for each:)</span></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Hay</strong></span></td>
                            <td style="height: 10px"><span>Acres avg yield/year </span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtHay" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"></span></td>
                            <td style="height: 10px"><span>Round Bales:</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtRoundBales" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"></span></td>
                            <td style="height: 10px"><span>Square bales:</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtSquareBales" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"></span></td>
                            <td style="height: 10px"><span>Tons per acre per year:</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtTonsperacreperYear" CssClass="clsTextBoxBlue1" runat="server" MaxLength="4" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Pasture</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtPasture" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Vegetables</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtVegetables" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong></strong></span></td>
                            <td style="height: 10px"><span>Types grown</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtVegetableTypes" CssClass="clsTextBoxBlue1" runat="server" MaxLength="75" Width="300px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Fruit</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtFruit" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>

                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong></strong></span></td>
                            <td style="height: 10px"><span>Types grown</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtFruitTypes" CssClass="clsTextBoxBlue1" runat="server" MaxLength="75" Width="300px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Livestock</strong></span></td>
                            <td style="height: 10px"><span>Types</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtLivestockTypes" CssClass="clsTextBoxBlue1" runat="server" MaxLength="50" Width="300px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong></strong></span></td>
                            <td style="height: 10px"><span># of Head</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtLivestock" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Christmas trees</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtChristmasTrees" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Nursery stock</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtNurseryStock" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Organic</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtOrganic" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="3">
                                <span>what areas of the operation are organic (all farm enterprises or just 1-2 specific areas?):</span></td>
                        </tr>

                        <tr>
                            <td colspan="3" style="height: 10px">
                                <asp:TextBox ID="txtOrganicAreas" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Active sugarbush</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtSugarbush" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Managed timber</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtManagedTimber" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong></strong></span></td>
                            <td style="height: 10px"><span>Is there existing forest management plan?</span></td>
                            <td style="height: 10px">
                                <asp:RadioButtonList ID="rdbtnManagementPlan" runat="server"
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
                            <td style="height: 10px"><span class="labelClass" style="margin-left: 10px"><strong>Other forestland (not managed timber or sugarbush)</strong></span></td>
                            <td style="height: 10px"><span>Acres</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtOtherForest" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>Other agricultural land (Acres)</strong></span></td>

                            <td style="height: 10px">
                                <asp:TextBox ID="txtOtherAgriculture" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="3"><span class="labelClass" style="margin-left: 10px"><strong>Other Agricultural Land (production info, as relevant)</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">

                                <asp:TextBox ID="txtOtherAgricultureProduction" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>Unmanaged/incidental land: Acres</strong></span></td>

                            <td style="height: 10px">
                                <asp:TextBox ID="txtUnmanaged" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="3"><span class="labelClass" style="margin-left: 10px"><strong>Agritourism ventures</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">

                                <asp:TextBox ID="txtAgritourism" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>Existing recreational trails: Open to the public: </strong></span></td>

                            <td style="height: 10px">
                                <asp:RadioButtonList ID="rdbTrails" runat="server"
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
                            <td style="height: 10px" colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>Linear feet of trail</strong></span></td>

                            <td style="height: 10px">
                                <asp:TextBox ID="txtTrailfeet" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                      <%--  <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="2"><span class="labelClass" style="margin-left: 10px"><strong>Trail name:</strong></span></td>

                            <td style="height: 10px">
                                <asp:CheckBoxList Width="300px" ID="cblTrailName" runat="server" RepeatDirection="Vertical" RepeatColumns="1" BorderWidth="0"
                                    Datafield="description" DataValueField="value" CssClass="checkboxlist_nowrap">
                                   
                                </asp:CheckBoxList>

                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">2. What are the total acres of tillable land?</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtTillable" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">3. What are the acreages of agricultural soils on the property? Enter Below (For more information on soils data, please see USDA’s Web Soil Survey or contact your local Natural Resources Conservation Service) </span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">
                                <!--<asp:TextBox ID="txtAgsoils" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10" Width="60px"></asp:TextBox>--></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                            <td style="height: 10px">
                                <span class="labelClass" style="margin-left: 10px"><strong>Acres</strong></span>
                                <span class="labelClass" style="margin-left: 45px"><strong>%</strong></span>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Prime agricultural soils (non-footnoted)</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtPrimeNonFootnoted" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                                <span class="labelClass" style="margin-left: 10px"></span>
                                <asp:TextBox ID="txtPrimeNonNotedPCent" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Prime agricultural soils (footnoted)</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtPrimeNoted" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                                <span class="labelClass" style="margin-left: 10px"></span>
                                <asp:TextBox ID="txtPrimeNotedPCent" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Statewide agricultural soils (non-footnoted)</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtStatewideNonNoted" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                                <span class="labelClass" style="margin-left: 10px"></span>
                                <asp:TextBox ID="txtStatewideNonNotedPCent" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Statewide agricultural soils (footnoted)</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtStatewideNoted" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                                <span class="labelClass" style="margin-left: 10px"></span>
                                <asp:TextBox ID="txtStatewideNotedPCent" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Other (non-agricultural) soils</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtOtherNonAgSoils" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                                <span class="labelClass" style="margin-left: 10px"></span>
                                <asp:TextBox ID="txtOtherNonAgSoilsPCent" CssClass="clsTextBoxBlue1" runat="server" MaxLength="10" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span class="labelClass" style="margin-left: 10px">Total soils</span></td>
                            <td style="height: 10px">
                                <asp:TextBox ID="txtTotal" CssClass="clsTextBoxBlue1" runat="server" MaxLength="20" Width="60px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="panel-width" runat="server" id="dvNewTrail">
                                    <div class="panel panel-default ">
                                        <div class="panel-heading ">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <h3 class="panel-title">Trail Mileage</h3>
                                                    </td>
                                                    <td style="text-align: right">
                                                        <asp:CheckBox ID="cbAddTrail" runat="server" Text="Add New Trail" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="panel-body" runat="server" id="dvTrailForm">
                                            <asp:Panel runat="server" ID="Panel8">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 87px"><span class="labelClass">Trail name</span></td>
                                                        <td style="width: 215px">
                                                            <asp:DropDownList ID="ddlTrailName" CssClass="clsDropDownLong" runat="server" Style="margin-left: 0">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 70px">
                                                            <span class="labelClass">Miles
                                                            </span>
                                                        </td>
                                                        <td style="width: 180px">
                                                            <asp:TextBox ID="txtTrailMiles" CssClass="clsTextBoxBlue1" Style="width: 100px" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 170px">
                                                            <asp:Button ID="btnTrails" runat="server" Text="Add" class="btn btn-info" OnClick="btnTrails_Click" /></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" style="height: 5px"></td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </div>

                                        <div class="panel-body" id="dvTrailMileageGrid" runat="server">
                                            <asp:Panel runat="server" ID="Panel10" Width="100%" Height="100px" ScrollBars="Vertical">
                                                <asp:GridView ID="gvTrailMileage" runat="server" AutoGenerateColumns="False"
                                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" ShowFooter="false"
                                                    OnRowEditing="gvTrailMileage_RowEditing"
                                                    OnRowCancelingEdit="gvTrailMileage_RowCancelingEdit"
                                                    OnRowUpdating="gvTrailMileage_RowUpdating">
                                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                                    <HeaderStyle CssClass="headerStyle" />
                                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                                    <RowStyle CssClass="rowStyle" />
                                                    <FooterStyle CssClass="footerStyleTotals" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Conserve Trails" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblConserveTrailsID" runat="Server" Text='<%# Eval("ConserveTrailsID") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Trail">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTrailDescription" runat="Server" Text='<%# Eval("Description") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Miles">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMiles" runat="Server" Text='<%# Eval("Miles") %>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtMiles" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Miles") %>'>
                                                                </asp:TextBox>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Active">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible="true"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>

                    <table>
                         <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="3"><span class="labelClass" style="margin-left: 10px"><strong>Other Trail</strong></span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px">

                                <asp:TextBox ID="txtOtherTrail" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
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
                    <asp:HiddenField ID="hfConserveId" runat="server" />
                </div>
            </div>
        </div>
    </div>

    <script language="javascript">

        $(document).ready(function () {
            $('#<%= dvTrailForm.ClientID%>').toggle($('#<%= cbAddTrail.ClientID%>').is(':checked'));

            $('#<%= cbAddTrail.ClientID%>').click(function () {
                $('#<%= dvTrailForm.ClientID%>').toggle(this.checked);
            }).change();

            var txtboxs = $('#<%= txtPrimeNonFootnoted.ClientID%>,#<%= txtPrimeNoted.ClientID%>,#<%= txtStatewideNonNoted.ClientID%>,#<%= txtStatewideNoted.ClientID%>,#<%= txtOtherNonAgSoils.ClientID%>');
            $.each(txtboxs, function () {
                $(this).blur(function () {

                    CalculatePercentages();
                });
            });

            function CalculatePercentages() {

                var primeNonNoted = (isNaN(parseFloat($('#<%=txtPrimeNonFootnoted.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtPrimeNonFootnoted.ClientID%>').val(), 10));
                var primeNoted = (isNaN(parseFloat($('#<%=txtPrimeNoted.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtPrimeNoted.ClientID%>').val(), 10));
                var statewideNonNoted = (isNaN(parseFloat($('#<%=txtStatewideNonNoted.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtStatewideNonNoted.ClientID%>').val(), 10));
                var statewideNoted = (isNaN(parseFloat($('#<%=txtStatewideNoted.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtStatewideNoted.ClientID%>').val(), 10));
                var otherNonAgSoils = (isNaN(parseFloat($('#<%=txtOtherNonAgSoils.ClientID%>').val(), 10)) ? 0 : parseFloat($('#<%=txtOtherNonAgSoils.ClientID%>').val(), 10));

                var Total = primeNonNoted + primeNoted + statewideNonNoted + statewideNoted + otherNonAgSoils;
                console.log('Total:' + Total.toFixed(2));

                $('#<%=txtTotal.ClientID%>').val(Total.toFixed(2));


                if (Total != 0) {
                    console.log('In Total:' + Total.toFixed(2));
                    var primeNonNotedPCT = $('#<%=txtPrimeNonFootnoted.ClientID%>').val() * 100 / Total;
                    var primeNotedPCT = $('#<%=txtPrimeNoted.ClientID%>').val() * 100 / Total;
                    var statewideNonNotedPCT = $('#<%=txtStatewideNonNoted.ClientID%>').val() * 100 / Total;
                    var statewideNotedPCT = $('#<%=txtStatewideNoted.ClientID%>').val() * 100 / Total;
                    var otherNonAgSoilsPCT = $('#<%=txtOtherNonAgSoils.ClientID%>').val() * 100 / Total;

                    console.log('In primeNonNotedPCT:' + primeNonNotedPCT.toFixed(2));

                    $('#<%=txtPrimeNonNotedPCent.ClientID%>').val(primeNonNotedPCT.toFixed(2));
                    $('#<%=txtPrimeNotedPCent.ClientID%>').val(primeNotedPCT.toFixed(2));
                    $('#<%=txtStatewideNonNotedPCent.ClientID%>').val(statewideNonNotedPCT.toFixed(2));
                    $('#<%=txtStatewideNotedPCent.ClientID%>').val(statewideNotedPCT.toFixed(2));
                    $('#<%=txtOtherNonAgSoilsPCent.ClientID%>').val(otherNonAgSoilsPCT.toFixed(2));

                }

            };
        });

    </script>
</asp:Content>



