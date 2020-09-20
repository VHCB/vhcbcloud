<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnterpriseGrantEvaluations.aspx.cs"
    Inherits="vhcbcloud.Viability.EnterpriseGrantEvaluations" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .scroll_checkboxes {
            height: 100px;
            padding: 1px;
            overflow: auto;
            border: 1px solid #ccc;
        }

        .FormText {
            FONT-SIZE: 11px;
            FONT-FAMILY: tahoma,sans-serif;
        }

        .checkboxlist_nowrap label {
            white-space: nowrap;
            display: inline-block;
        }

        .auto-style1 {
            border: 1px solid #678FC2;
            background-color: #edeeee;
            margin-left: 0px;
            margin-bottom: 0px;
            font-size: 8pt;
            font-family: helvetica, sans-serif;
        }
    </style>
    <div class="jumbotron" id="vhcb">
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs"></ul>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">

                    <div id="dvMessage" runat="server">
                        <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                    </div>

                    <div id="dvWaterQualityGrants" runat="server" visible="false">
                        <div class="panel-width" runat="server" id="dvNewWatershed">
                            <div class="panel panel-default ">
                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Grant Questions</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:CheckBox ID="cbAddWhatAreaImprove" runat="server" Text="Add New What Area Improve" />

                                            </td>
                                        </tr>
                                    </table>
                                </div>


                                <div class="panel-body" runat="server" id="dvNewWhatAreaImproveForm">
                                    <asp:Panel runat="server" ID="Panel6">
                                        <table style="width: 100%">

                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px">
                                                    <span class="labelClass">In what areas did this project improve your business in a significant way?</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>

                                            <tr>
                                                <td colspan="6">
                                                    <div class="scroll_checkboxes">
                                                        <asp:CheckBoxList Width="180px" ID="cblWhatAreaImprove" runat="server" RepeatDirection="Vertical" RepeatColumns="1" BorderWidth="0"
                                                            Datafield="description" DataValueField="value" CssClass="checkboxlist_nowrap">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnWhatAreaImprove" runat="server" Text="Add" class="btn btn-info" OnClick="btnWhatAreaImprove_Click" />
                                                </td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-body" id="dvAddWhatAreaImproveGrid" runat="server">
                                    <asp:Panel runat="server" ID="Panel7" Width="100%" Height="100px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvAddWhatAreaImprove" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="EnterpriseWaterShedID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEnterpriseWaterShedID" runat="Server" Text='<%# Eval("EnterpriseGrantImprovedBus") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Improve Business">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblwatershed" runat="Server" Text='<%# Eval("ImprovedBusDesc") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                        <div class="panel-width" runat="server" id="dvGrantFundedProjectImpacted">
                            <div class="panel panel-default ">
                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">1. How has the grant-funded project impacted your…:</h3>
                                            </td>
                                            <td style="text-align: right"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" runat="server" id="Div1">
                                    <asp:Panel runat="server" ID="Panel1">
                                        <table style="width: 100%">

                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">a.	Farm viability? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtFarmViability" CssClass="auto-style1" runat="server" TextMode="multiline" Columns="50" Rows="3" Width="100%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">b.	Nutrient Management?</span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtNutrientManagement" CssClass="auto-style1" runat="server" TextMode="multiline" Columns="50" Rows="3" Width="100%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">c.	Compliance with regulations? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtCompliance" CssClass="auto-style1" runat="server" TextMode="multiline" Columns="50" Rows="3" Width="100%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">d.	Operational efficiency? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtOperationalEfficiency" CssClass="auto-style1" runat="server" TextMode="multiline" Columns="50" Rows="3" Width="100%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">e.	Quality of life? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtQualityofLife" CssClass="auto-style1" runat="server" TextMode="multiline" Columns="50" Rows="3" Width="100%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">2. If you received a grant for an equipment purchase:</h3>
                                            </td>
                                            <td style="text-align: right"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" runat="server" id="Div2">
                                    <asp:Panel runat="server" ID="Panel2">
                                        <table style="width: 100%">

                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">a.	How many hours per year are you using the equipment? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtEquipmentHrs" CssClass="auto-style1" runat="server" Width="100px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">b.	On how many acres are you using the equipment?</span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:TextBox ID="txtAcres" CssClass="auto-style1" runat="server" Width="100px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">3. After completing this grant-funded project, how satisfied are you with:</h3>
                                            </td>
                                            <td style="text-align: right"></td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" runat="server" id="Div3">
                                    <asp:Panel runat="server" ID="Panel3">
                                        <table style="width: 100%">

                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">a.	Your farm’s environmental stewardship?</span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlStewardship" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">b.	Your farm’s soil health?</span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlSoil" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">c.	Your farm’s manure management? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlManure" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">d.	Your farm’s crop production?</span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlCrop" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">e.	The quality of your farm’s milk? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlMilk" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">f.	Your herd’s overall health? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlHealth" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">g.	The farm’s efficiency? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlEfficiency" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">h.	The safety of the work environment? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlWorkEnvironment" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">i.	Your farm’s financial viability? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlFinancial" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">j.	Your ability to generate income for your family? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlIncome" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px">
                                                    <span class="labelClass">k.	Your work/life balance? </span>
                                                </td>
                                                <td colspan="5">
                                                    <asp:DropDownList ID="ddlBalance" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="height: 5px">
                                                <h3 class="panel-title">Do we have your permission to quote your narrative comments as part of our reporting to our funders or to help promote the Viability Program?</h3>
                                                <asp:CheckBox ID="cbPermission" runat="server" Text="Yes" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 5px"></td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnQuestionsAdd" runat="server" Text="Add" class="btn btn-info" OnClick="btnQuestionsAdd_Click" />
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 5px"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfEnterImpGrantID" runat="server" />
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvNewWhatAreaImproveForm.ClientID%>').toggle($('#<%= cbAddWhatAreaImprove.ClientID%>').is(':checked'));

            $('#<%= cbAddWhatAreaImprove.ClientID%>').click(function () {
                $('#<%= dvNewWhatAreaImproveForm.ClientID%>').toggle(this.checked);
            }).change();


        });
    </script>
</asp:Content>
