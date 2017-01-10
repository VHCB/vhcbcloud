<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="LoanMaintenance.aspx.cs" Inherits="vhcbcloud.LoanMaintenance"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Loan Maintenance </p>
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs">
                    </ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td></td>
                            <td style="text-align: right;">
                                <%--<asp:ImageButton ID="btnProjectNotes1" Visible="false" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;--%>
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvProjectInfoForm">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                            <h3 class="panel-title"><span id="CommonFormHeader" runat="server">Project Info</span> </h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="pnlProjectInfo">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Project #</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtProjectNumDDL" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"
                                                ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProjectNumDDL" MinimumPrefixLength="1"
                                                EnableCaching="true" CompletionSetCount="1"
                                                CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Name</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtProjectName" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Descriptor</span></td>
                                        <td>
                                            <asp:TextBox ID="txtDescriptor" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Applicant</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtApplicant" CssClass="clsTextBoxBlueSm" runat="server" Width="200px"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass">Fund</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlFund" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Tax Credit Partnership</span></td>
                                        <td>
                                            <asp:TextBox ID="txtTaxCreditPartner" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Owner of Note</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtNoteOwner" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px">
                                            <span class="labelClass"></span>
                                        </td>
                                        <td style="width: 270px"></td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <div id="dvUpdate" runat="server" visible="false">
                                    <table>
                                        <tr>
                                            <td style="height: 1px">&nbsp;&nbsp;</td>
                                            <td style="height: 1px">
                                                <asp:Button ID="btnLoanUpdate" runat="server" Text="Update" class="btn btn-info"
                                                    OnClick="btnLoanUpdate_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 1px" colspan="2"></td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="Div2">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 7px 5px 7px 5px">
                            <h3 class="panel-title"><span id="Span1" runat="server">Loan Details </span></h3>
                        </div>
                        <div class="panel-body">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Loan Category</span></td>
                                        <td style="width: 242px">
                                            <asp:DropDownList ID="ddlLoanCat" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 163px">
                                            <span class="labelClass">Original Date of Note</span>
                                        </td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtOriginalDateOfNote" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtProjectNotesDate" TargetControlID="txtOriginalDateOfNote">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 183px"><span class="labelClass">Final Maturity Date of Note</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMaturityDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtMaturityDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Note Amount $</span></td>
                                        <td style="width: 242px">
                                            <asp:TextBox ID="txtNoteAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 163px">
                                            <span class="labelClass">Interest Rate</span>
                                        </td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtIntrestDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 183px"><span class="labelClass">Compounded</span></td>
                                        <td>
                                            <asp:DropDownList ID="ddlCompounded" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Payment Frequency</span></td>
                                        <td style="width: 242px">
                                            <asp:DropDownList ID="ddlPaymentFreq" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 163px">
                                            <span class="labelClass">Payment Type</span>
                                        </td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlPaymentType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList></td>
                                        <td style="width: 183px"><span class="labelClass">Watch Date</span></td>
                                        <td>
                                            <asp:TextBox ID="txtWatchDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender2" TargetControlID="txtWatchDate">
                                            </ajaxToolkit:CalendarExtender>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                                <div id="Div1" runat="server" visible="true">
                                    <table>
                                        <tr>
                                            <td style="height: 1px">&nbsp;&nbsp;</td>
                                            <td style="height: 1px">
                                                <asp:Button ID="Button1" runat="server" Text="Update" class="btn btn-info"
                                                    OnClick="btnLoanUpdate_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 1px" colspan="2"></td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNewEvent">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Events, etc.</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddEvent" runat="server" Text="Add New Loan Event" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvEventForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 100px"><span class="labelClass">Description</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtEventDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server" style="margin-left: 0px"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 100px">
                                            <asp:Button ID="AddEvent" runat="server" Text="Add" class="btn btn-info" OnClick="AddEvent_Click" />
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <!-- Grid Here -->
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvTransaction">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Transactions</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddTransaction" runat="server" Text="Add New Loan Transaction" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvTransactiontForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Trans Type</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                 OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 234px"><span class="labelClass" runat="server" id="spanTransactionDate">Transaction Date</span></td>
                                        <td style="width: 336px">
                                            <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender3" TargetControlID="txtTransDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 354px"><span class="labelClass" runat="server" id="spanIntrestRate">Interest Rate</span></td>
                                        <td><asp:TextBox ID="txtTransIntrestRate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass" runat="server" id="spanCompounding">Compounding</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlTransCompounding" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 234px"><span class="labelClass" runat="server" id="spanPaymentFreq">Payment Frequency</span></td>
                                        <td style="width: 336px">
                                             <asp:DropDownList ID="ddlTransPaymentFreq" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 354px"><span class="labelClass" runat="server" id="spanPaymentType">Payment Type</span></td>
                                        <td> <asp:DropDownList ID="ddlTransPaymentType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass" runat="server" id="spanMaturityDate">Maturity Date</span></td>
                                        <td style="width: 215px">
                                           <asp:TextBox ID="txtTransMaturityDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender4" TargetControlID="txtTransMaturityDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 234px"><span class="labelClass" runat="server" id="spanStartDate">Start Date</span></td>
                                        <td style="width: 336px">
                                             <asp:TextBox ID="txtTransStartDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender5" TargetControlID="txtTransStartDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 354px"><span class="labelClass" runat="server" id="spanAmount">Amount</span></td>
                                        <td> 
                                            <asp:TextBox ID="txtTransAmount" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass" runat="server" id="spanStopDate">Stop Date</span></td>
                                        <td style="width: 215px">
                                           <asp:TextBox ID="txtTransStopDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="CalendarExtender6" TargetControlID="txtTransStopDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 234px"><span class="labelClass" runat="server" id="spanPrinciple">Principle</span></td>
                                        <td style="width: 336px">
                                             <asp:TextBox ID="txtTransPrinciple" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 354px"><span class="labelClass" runat="server" id="spanIntrest">Interest</span></td>
                                        <td> 
                                            <asp:TextBox ID="txtTransIntrest" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass" runat="server" id="spanDescription">Description</span></td>
                                        <td style="width: 215px">
                                           <asp:TextBox ID="txtTransDescription" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 234px"><span class="labelClass" runat="server" id="spanProjTranf">Project Transferred To</span></td>
                                        <td style="width: 336px"><asp:TextBox ID="txtTransProjTransfered" CssClass="clsTextBoxBlueSm"  runat="server"></asp:TextBox>
                                             
                                        </td>
                                        <td style="width: 354px"><span class="labelClass" runat="server" id="spanConverted">Project Converted From</span></td>
                                        <td> 
                                            <asp:TextBox ID="txtTransProjConverted" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"><asp:Button ID="btnAddTransaction" runat="server" Text="Add" class="btn btn-info" 
                                            OnClick="btnAddTransaction_Click" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <!-- Grid Here -->
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvNotes">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Notes</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddNotes" runat="server" Text="Add New Loan Notes" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvNotesForm">
                            <asp:Panel runat="server" ID="Panel3">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 5px"><span class="labelClass">Fund</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlNotesFund" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                 OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5px"><span class="labelClass">Notes</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="480px" Height="80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5px"><span class="labelClass">FileHold Link</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="TextBox9" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                            &nbsp;&nbsp;<asp:Button ID="btnAddNotes" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddNotes_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <!-- Grid Here -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvEventForm.ClientID%>').toggle($('#<%= cbAddEvent.ClientID%>').is(':checked'));

            $('#<%= cbAddEvent.ClientID%>').click(function () {
                $('#<%= dvEventForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvTransactiontForm.ClientID%>').toggle($('#<%= cbAddTransaction.ClientID%>').is(':checked'));

            $('#<%= cbAddTransaction.ClientID%>').click(function () {
                $('#<%= dvTransactiontForm.ClientID%>').toggle(this.checked);
            }).change();


            $('#<%= dvNotesForm.ClientID%>').toggle($('#<%= cbAddNotes.ClientID%>').is(':checked'));

            $('#<%= cbAddNotes.ClientID%>').click(function () {
                $('#<%= dvNotesForm.ClientID%>').toggle(this.checked);
            }).change();
        });
    </script>
</asp:Content>
