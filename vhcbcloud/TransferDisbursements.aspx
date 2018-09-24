<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TransferDisbursements.aspx.cs" Inherits="vhcbcloud.TransferDisbursements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <script type="text/javascript" language="javascript">
        function CheckAllEmp(Checkbox) {
            var GridVwHeaderChckbox = document.getElementById("<%=gvTransactions.ClientID %>");
            for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                GridVwHeaderChckbox.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
            }
        }
    </script>

    <style>
        .myheaderStyle  {
        text-align: Right;
    }
    .myheaderStyle th {
        text-align: center;
    }
</style>
    <div class="jumbotron clearfix">
        <p class="lead">Disbursement Transactions</p>
        <asp:Panel ID="pnlTransaction" runat="server" Visible="true">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">Select Project</div>
                    <div class="panel-body">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 20%; float: left"><span class="labelClass">Project # :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlProjFilter" Visible="false" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;"
                                        OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged" Width="111px">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtFromCommitedProjNum" runat="server" CssClass="clsTextBoxBlueSm" Width="120px">All</asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="aceCommitAuto" runat="server" CompletionInterval="100" CompletionSetCount="1" EnableCaching="false" MinimumPrefixLength="1"
                                        OnClientItemSelected="OnContactSelected" ServiceMethod="GetProjectsByFilter" TargetControlID="txtFromCommitedProjNum">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td style="width: 10%; float: left">
                                    <asp:Label ID="lblProjNameText" class="labelClass" Visible="false" Text="Project Name :" runat="server"></asp:Label>
                                </td>
                                <td style="float: left" colspan="2">
                                    <asp:Label ID="lblProjName" class="labelClass" Text=" " runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="height: 8px;" colspan="5"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%; float: left;">
                                    <span class="labelClass">Trans From Date :</span></td>

                                <td style="width: 20%; float: left">
                                    <asp:TextBox ID="txtTransDateFrom" runat="server" CssClass="clsTextBoxBlue1" Width="110px"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="txtTransDateFrom_CalendarExtender" runat="server" TargetControlID="txtTransDateFrom">
                                    </ajaxToolkit:CalendarExtender>
                                </td>
                                <td style="width: 10%; float: left"><span class="labelClass">Trans End Date :</span></td>
                                <td style="width: 15%; float: left">
                                    <asp:TextBox ID="txtTransDateTo" runat="server" CssClass="clsTextBoxBlue1" Width="110px"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="txtTransDateTo_CalendarExtender" runat="server" TargetControlID="txtTransDateTo">
                                    </ajaxToolkit:CalendarExtender>
                                </td>
                                <td style="width: 30%; float: left"></td>
                            </tr>
                            <tr>
                                <td colspan="5" style="width: 15%; float: left; height: 56px;">
                                    <br />
                                    <asp:Button ID="btnSubmit" runat="server" class="btn btn-info" OnClick="btnSubmit_Click" OnClientClick="needToConfirm = false;" Text="Submit" ValidationGroup="Date" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <p class="lblErrMsg">
                                        <asp:Label ID="lblErrorMsg" runat="server" Font-Size="Small"></asp:Label>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                 <asp:Panel ID="pnlTranDetails" runat="server" Visible="false">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:Label runat="server" ID="lblTransDetHeader" Text="Transaction Detail"></asp:Label>
                        </div>
                        <br />
                        &nbsp;&nbsp;&nbsp;<asp:GridView ID="gvTransactions" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="gridView"
                            DataKeyNames="LoanImportID" OnRowDataBound="gvTransactions_RowDataBound">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="40px">
                                    <HeaderTemplate>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkboxSelectAll" runat="server" onclick="CheckAllEmp(this);" />
                                    </HeaderTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkTrans" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="80px" DataField="ProjectNumber" HeaderText="Project #" />
                                <asp:BoundField ItemStyle-Width="120px" DataField="ProjectName" HeaderText="Project Name" />
                                <asp:BoundField ItemStyle-Width="120px" DataField="FundName" HeaderText="Fund Name" />

                                <asp:TemplateField HeaderText="Date" ItemStyle-Width="70px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("FinalizedDate", "{0:MM-dd-yyyy}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                        &nbsp;&nbsp;&nbsp;<asp:Button ID="btnTranSubmit" runat="server" class="btn btn-info" OnClick="btnTranSubmit_Click" OnClientClick="needToConfirm = false;"
                            Text="Submit" ValidationGroup="Date" />
                        <br />
                    </div>
                </asp:Panel>
                <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
                <asp:HiddenField ID="hfProjId" runat="server" />
            </div>
        </asp:Panel>
    </div>
    <script type="text/javascript">
        function OnContactSelected(source, eventArgs) {

            var hdnValueID = "<%= hdnValue.ClientID %>";

             document.getElementById(hdnValueID).value = eventArgs.get_value();
             __doPostBack(hdnValueID, "");
         }
    </script>
</asp:Content>
