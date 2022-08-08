<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PortfolioData.aspx.cs" Inherits="Portfolio.PortfolioData" MaintainScrollPositionOnPostback="true" %>



<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
   
     <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <div class="jumbotron" id="vhcb">
        <!--  Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs"></ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 25%;">
                        <tr>
                             <td><span class="labelClass">Project #</span></td>
                            <td>
                                <span class="labelClass" id="ProjectNum" runat="server"></span>
                            </td>
                        </tr>
                   
                    </table>
                 
                </div>
             
               
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
                <div style="padding-left:20px">
                   <table>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Year</span></td>
                            <td>
                                <span class="labelClass" runat="server" id="spnYear"></span>
                               
                            </td>
                        </tr>
                         <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                         <tr>
                            <td><span class="labelClass">Portfolio Type</span>&nbsp;</td>
                            <td>
                                  <span class="labelClass" runat="server" id="spnPortfolioType"></span>
                            </td>
                        </tr>
                       
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Total Units</span></td>
                            <td>
                                <asp:TextBox ID="txtTotalUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                    </table>
                    <table style="width: 100%">
                        <tr>
                            <td style="vertical-align: top; width: 50%">
                                <table>

                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Gender</h3>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Male</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMGender" CssClass="clsTextBoxBlueSm" runat="server" MaxLength="3"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnMale" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Female</span></td>
                                        <td>
                                            <asp:TextBox ID="txtFGender" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnFeMale" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Other/Unknown</span></td>
                                        <td>
                                            <asp:TextBox ID="txtUGender" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnUgender" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Race</h3>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">White</span></td>
                                        <td>
                                            <asp:TextBox ID="txtWhite" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnWhite" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Black/African American</span></td>
                                        <td>
                                            <asp:TextBox ID="txtBlack" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnBlack" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Asian</span></td>
                                        <td>
                                            <asp:TextBox ID="txtAsian" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnAsian" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">American Indian/Alaska Natice</span></td>
                                        <td>
                                            <asp:TextBox ID="txtIndian" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnIndian" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Native Hawaiian/Other Pacific Islander</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtHawaiian" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnHawaiian" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Unknown</span></td>
                                        <td>
                                            <asp:TextBox ID="txtUnknownRace" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnUnknownRace" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Ethnicity</h3>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Hispanic</span></td>
                                        <td>
                                            <asp:TextBox ID="txtHispanic" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnHispanic" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Non-Hispanic</span></td>
                                        <td>
                                            <asp:TextBox ID="txtNonHisp" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnNonHisp" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">UnKnown</span></td>
                                        <td>
                                            <asp:TextBox ID="txtUnknownEthnicity" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnUnknownEthnicity" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>

                                </table>
                            </td>
                            <td style="vertical-align: top; width: 50%">
                                <table>
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Homeless</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Homeless</span></td>
                                        <td>
                                            <asp:TextBox ID="txtHomeless" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnHomeless" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Income</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Market Rate</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMarketRate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spntMarketRate" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">At or below 100%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI100" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI100" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">At or below 80%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI80" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI80" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">At or below 75%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI75" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI75" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">At or below 60%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI60" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI60" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>

                                    <tr>
                                        <td><span class="labelClass">At or below 50%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI50" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI50" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <%-- <tr>
                                        <td><span class="labelClass">At or below 40%</span></td>
                                        <td>
                                            <asp:TextBox ID="TextBox4" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI40" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>--%>
                                    <tr>
                                        <td><span class="labelClass">At or below 30%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI30" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;<span class="labelClass" id="spnI30" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">At or below 20%</span>&nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtI20" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td><span class="labelClass" id="spnI20" runat="server"></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-info" OnClick="btnSave_Click" />&nbsp;
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" /></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                    </table>
                    </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />
    <asp:HiddenField ID="hfProjectPortfolioID" runat="server" />
     <asp:HiddenField ID="hfPortfolioType" runat="server" />
     <asp:HiddenField ID="hfYear" runat="server" />
    <script language="javascript">
        $(document).ready(function () {

           

            $(':text').blur(function () {
                CalculateTotalUnits();
            });
        });

        function CalculateTotalUnits() {
            var TotalUnits = parseInt($('#<%=txtTotalUnits.ClientID%>').val(), 10);
            console.log("TotalUnits" + TotalUnits);

            var MaleCount = parseInt($('#<%=txtMGender.ClientID%>').val(), 10);
            var FeMaleCount = parseInt($('#<%=txtFGender.ClientID%>').val(), 10);
            var UGender = parseInt($('#<%=txtUGender.ClientID%>').val(), 10);
            var White = parseInt($('#<%=txtWhite.ClientID%>').val(), 10);
            var Black = parseInt($('#<%=txtBlack.ClientID%>').val(), 10);
            var Asian = parseInt($('#<%=txtAsian.ClientID%>').val(), 10);
            var Indian = parseInt($('#<%=txtIndian.ClientID%>').val(), 10);
            var Hawaiian = parseInt($('#<%=txtHawaiian.ClientID%>').val(), 10);
            var UnknownRace = parseInt($('#<%=txtUnknownRace.ClientID%>').val(), 10);
            var Hispanic = parseInt($('#<%=txtHispanic.ClientID%>').val(), 10);
            var NonHisp = parseInt($('#<%=txtNonHisp.ClientID%>').val(), 10);
            var UnknownEthnicity = parseInt($('#<%=txtUnknownEthnicity.ClientID%>').val(), 10);
            var Homeless = parseInt($('#<%=txtHomeless.ClientID%>').val(), 10);

            var MarketRate = parseInt($('#<%=txtMarketRate.ClientID%>').val(), 10);
            var I100 = parseInt($('#<%=txtI100.ClientID%>').val(), 10);
            var I80 = parseInt($('#<%=txtI80.ClientID%>').val(), 10);
            var I75 = parseInt($('#<%=txtI75.ClientID%>').val(), 10);
            var I60 = parseInt($('#<%=txtI60.ClientID%>').val(), 10);
            var I50 = parseInt($('#<%=txtI50.ClientID%>').val(), 10);
            var I30 = parseInt($('#<%=txtI30.ClientID%>').val(), 10);
            var I20 = parseInt($('#<%=txtI20.ClientID%>').val(), 10);


            $('#<%= spnMale.ClientID%>').text(parseFloat((MaleCount / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnFeMale.ClientID%>').text(parseFloat((FeMaleCount / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnUgender.ClientID%>').text(parseFloat((UGender / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnWhite.ClientID%>').text(parseFloat((White / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnBlack.ClientID%>').text(parseFloat((Black / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnAsian.ClientID%>').text(parseFloat((Asian / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnIndian.ClientID%>').text(parseFloat((Indian / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnHawaiian.ClientID%>').text(parseFloat((Hawaiian / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnUnknownRace.ClientID%>').text(parseFloat((UnknownRace / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnHispanic.ClientID%>').text(parseFloat((Hispanic / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnNonHisp.ClientID%>').text(parseFloat((NonHisp / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnUnknownEthnicity.ClientID%>').text(parseFloat((UnknownEthnicity / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnHomeless.ClientID%>').text(parseFloat((Homeless / TotalUnits) * 100).toFixed(2) + ' %');

            $('#<%= spntMarketRate.ClientID%>').text(parseFloat((MarketRate / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI100.ClientID%>').text(parseFloat((I100 / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI80.ClientID%>').text(parseFloat((I80 / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI75.ClientID%>').text(parseFloat((I75 / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI60.ClientID%>').text(parseFloat((I60 / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI50.ClientID%>').text(parseFloat((I50 / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI30.ClientID%>').text(parseFloat((I30 / TotalUnits) * 100).toFixed(2) + ' %');
            $('#<%= spnI20.ClientID%>').text(parseFloat((I20 / TotalUnits) * 100).toFixed(2) + ' %');


        };

        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
    </script>
</asp:Content>

