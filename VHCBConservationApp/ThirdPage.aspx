<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThirdPage.aspx.cs" Inherits="VHCBConservationApp.ThirdPage" %>


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
        .auto-style8 {
            width: 636px;
        }
        .auto-style9 {
            width: 567px;
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
                            <td colspan="2" style="text-decoration: underline;" class="auto-style7"><strong>E. PROJECT SUMMARY</strong>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">Executive Summary:  Briefly describe (in 3-4 paragraphs) the project and its goals. Summarize the following:  1) project configuration, 2) why it is important to conserve the land at this time; 3) how conservation will support the operation of the farm (i.e., facilitate a transfer, invest in infrastructure or equipment, reduce debt, etc.); and 4) how keeping this land in agriculture will protect or enhance other natural, cultural, or community resources. Also describe any aspects of the project that have changed since the pre-application. </span></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="margin-left: 10px">
                                &nbsp;&nbsp;<asp:TextBox ID="txtExecSummary" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="6" runat="server" Width="971px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-decoration: underline;" class="auto-style7"><strong>F.  FARM TRANSFER</strong>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td class="auto-style9"><span class="labelClass" style="margin-left: 10px">1 Are there plans to sell or convey all or part of the farm to new landowners?  </span></td>
                            <td colspan="2">
                                <asp:RadioButtonList ID="rdBtnSellorConvey" runat="server" CellPadding="2" CellSpacing="4"
                                    RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnSellorConvey_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem>Yes &nbsp;</asp:ListItem>
                                    <asp:ListItem> No &nbsp;</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                    </table>
                    <table runat="server" id="part2" visible="false">
                        <tr>
                            <td class="auto-style8"><span class="labelClass" style="margin-left: 10px">2 Is this farm transfer a: [check all that apply]: family transfer, new buyer, farm access program</span></td>
                            <td colspan="2">
                                <asp:CheckBoxList ID="cblFarmerTransfer" runat="server">
                                    <asp:ListItem Value="Family Transfer">Family Transfer</asp:ListItem>
                                    <asp:ListItem Value="New Buyer">New Buyer</asp:ListItem>
                                    <asp:ListItem Value="Farm access program">Farm access program</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><span class="labelClass" style="margin-left: 10px">Incoming farmer(s) plans:  Briefly describe the incoming farmer(s)’ operation and their plans for this property.  Summarize the incoming farmer(s)’ experience with farming and any support services, such as business planning support, they are receiving. (Specifically note if the farmers are enrolled in VHCB’s Farm and Forest Viability program.) How will acquiring this parcel impact their farm operation?</span></td>

                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="margin-left: 10px">&nbsp;&nbsp;
                                <asp:TextBox ID="txtFarmerPlans" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="6" runat="server" Width="974px" />
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
            $("#<%=rdBtnSellorConvey.ClientID%>").change(function(){
                var rbvalue = $("input[name='<%=rdBtnSellorConvey.UniqueID%>']:radio:checked").val();
                //alert(rbvalue);
                if (rbvalue === "Yes")
                  //  alert("Yes");
                    //alert($("#<%=part2.ClientID%>"));
            });
        });

    </script>
</asp:Content>


