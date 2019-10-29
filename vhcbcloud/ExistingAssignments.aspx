<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true"
    CodeBehind="ExistingAssignments.aspx.cs" Inherits="vhcbcloud.ExistingAssignments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix" id="vhcb">

        <p class="lead">Board Reallocations</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <asp:RadioButtonList ID="rdBtnFinancial" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4" onclick="needToConfirm = true;"
                        RepeatDirection="Horizontal"
                        OnSelectedIndexChanged="rdBtnFinancial_SelectedIndexChanged">
                        <asp:ListItem> Commitment &nbsp;</asp:ListItem>
                        <asp:ListItem> DeCommitment &nbsp;</asp:ListItem>
                        <asp:ListItem> Reallocation &nbsp;</asp:ListItem>
                        <asp:ListItem Selected="true"> Assignments &nbsp;</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlReallocations" runat="server" Visible="true">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="rdBtnSelection" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal" onclick="needToConfirm = true;"
                                        OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                        <asp:ListItem>New    </asp:ListItem>
                                        <asp:ListItem Selected="True">Existing</asp:ListItem>
                                    </asp:RadioButtonList></td>
                                <td style="text-align: right">
                                    <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" Style="border: none;" runat="server" Text="Project Search" Visible="true"
                                        OnClientClick="PopupProjectSearch(); return false;"></asp:ImageButton>
                                    &nbsp;
                                        <asp:ImageButton ID="imgNewAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="true"
                                            OnClientClick="PopupNewAwardSummary(); return false;"></asp:ImageButton>
                                    <asp:ImageButton ID="imgExistingAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="false"
                                        OnClientClick="PopupExistingAwardSummary(); return false;"></asp:ImageButton>
                                    &nbsp;
                                <asp:ImageButton ID="btnProjectNotes" ImageUrl="~/Images/notes.png" ToolTip="Notes" runat="server" Text="Project Notes" Style="border: none;"></asp:ImageButton>
                                    &nbsp;
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                                </td>
                            </tr>
                        </table>
                    </div>

                    <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes" CancelControlID="btnClose"
                        BackgroundCssClass="MEBackground">
                    </ajaxToolkit:ModalPopupExtender>

                    <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                        <iframe style="width: 750px; height: 600px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                        <br />
                        <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />

                    </asp:Panel>

                    <div class="panel-heading">Assignments</div>

                    <div class="panel-body" id="pnlReallocateFrom" runat="server">
                        <table style="width: 100%" class="">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:TextBox ID="txtFromProjectNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="aceCommitAuto" runat="server" TargetControlID="txtFromProjectNum" MinimumPrefixLength="1"
                                        EnableCaching="false" CompletionSetCount="1"
                                        OnClientItemSelected="OnRelocationProjectSelected" CompletionInterval="100" ServiceMethod="GetAssignmentProjectslist">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td style="width: 10%; float: left">&nbsp;</td>
                                <td style="width: 20%; float: left">
                                    <asp:Label ID="lblProjName" runat="server" class="labelClass" Text=" "></asp:Label>
                                </td>
                                <td style="width: 20%; float: left">
                                    <asp:Label ID="lblGrantee" runat="server" class="labelClass" Text=" "></asp:Label>
                                </td>
                                <td style="width: 30%; float: left"></td>
                            </tr>
                            <tr>
                                <td style="height: 4px" colspan="6" />
                            </tr>
                        </table>
                        <br />
                          <div class="panel-body" id="dvAssignmentsGrid" runat="server" visible="false">
                            <asp:Panel runat="server" ID="Panel8" Width="100%" Height="200px" ScrollBars="Vertical">
                        <asp:GridView ID="gvAssignments" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvAssignments_RowCancelingEdit"
                            OnRowUpdating="gvAssignments_RowUpdating" OnRowDeleting="gvAssignments_RowDeleting" OnSelectedIndexChanged="gvAssignments_SelectedIndexChanged"
                            OnRowCreated="gvAssignments_RowCreated" TabIndex="7">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("transid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trans Date" SortExpression="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>'></asp:Label>
                                        <asp:TextBox ID="txtTransDate" Visible="false" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>'></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="acebdt" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Name" SortExpression="FromFundName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FromFundName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction Type" SortExpression="FromFundtransType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("FromFundtransType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--  <asp:TemplateField HeaderText="Landuse Permit ID" SortExpression="FromLandusePermitId">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLandusePermitID" runat="Server" Text='<%# Eval("FromLandusePermitId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Trans Amount" SortExpression="TransAmt" ItemStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                        <asp:HiddenField ID="HiddenField2" runat="server" Value='<%#Eval("TransAmt")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" />
                                    <FooterStyle Width="50px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trans Status" SortExpression="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransStatus" runat="Server" Text='<%# Eval("Description") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" Visible="false" runat="server"></asp:DropDownList>
                                        <asp:Label ID="lblTransStatusView" runat="Server" Text='<%# Eval("Description") %>' />
                                        <asp:TextBox ID="txtTransStatus" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lkStatus") %>' Visible="false"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ProjectID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProjId" runat="Server" Text='<%# Eval("projectid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TransId" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransId" runat="Server" Text='<%# Eval("transid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        &nbsp;
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="delete" OnClientClick="return confirm('Are you sure you want to delete this transaction?');"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" UpdateText="Activate" Visible="false" />
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                                </asp:Panel>
                              </div>
                        <br />
                        <p class="lblErrMsg">
                            <asp:Label runat="server" ID="lblRErrorMsg" Font-Size="Small"></asp:Label>
                        </p>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlTranDetails" runat="server" Visible="false">
            <div class="container">
                <div class="panel-width">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:Label runat="server" ID="lblTransDetHeader" Text="Transaction Detail"></asp:Label>
                        </div>
                        <div class="panel-body">
                            <div id="dvToAssignmentsForm" runat="server" visible="false">
                                <table style="width: 100%" id="tblToAssignment" runat="server">
                                    <tr>
                                        <td style="width: 10%; float: left">
                                            <span class="labelClass">Project # :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:TextBox ID="txtToProjNum" runat="server" Visible="true" CssClass="clsTextBoxBlueSm" Width="120px" TabIndex="1" onkeyup="SetContextKey()"></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtToProjNum" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                                                 UseContextKey="true" OnClientItemSelected="OnToProjectSelected" CompletionInterval="100" ServiceMethod="GetAssignmentProjectslistByFilter">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <%-- <td style="width: 10%; float: left"><span class="labelClass">Fund # :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:Label ID="lblFromFundNumber" class="labelClass" Text=" " runat="server"></asp:Label>
                                        </td>--%>
                                        <td style="width: 10%; float: left"><span class="labelClass">Fund Name :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:Label ID="lblFromFundName" class="labelClass" Text=" " runat="server"></asp:Label>
                                        </td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Trans Type :</span></td>
                                        <td style="width: 30%; float: left">
                                            <asp:Label ID="lblFromTransType" class="labelClass" Text=" " runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 4px" colspan="6" />
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:TextBox ID="txtToAmt" CssClass="clsTextBoxMoney" runat="server" TabIndex="10" Width="120px"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%; float: left">
                                            <span class="labelClass"></span>
                                        </td>
                                        <td style="width: 20%; float: left"></td>
                                        <td style="width: 10%; float: left">
                                            <asp:Label ID="lblUsePermit" class="labelClass" runat="server" Visible="false" Text="Use Permit:"></asp:Label>
                                        </td>
                                        <td style="width: 30%; float: left">
                                            <asp:DropDownList ID="ddlUsePermit" CssClass="clsDropDown" runat="server" Visible="false" TabIndex="10">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Button ID="btnToAssignmentDetailSubmit" runat="server" Enabled="true" Text="Submit" class="btn btn-info" OnClick="btnAssignmentDetailSubmit_Click" TabIndex="11" />
                            </div>
                            <br />
                            <div class="panel-body" id="dvToAssignmentsGrid" runat="server" visible="false">
                            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="200px" ScrollBars="Vertical">
                            <asp:GridView ID="gvToAssignments" runat="server" AllowPaging="false" AllowSorting="true" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True"
                                GridLines="None"
                                PagerSettings-Mode="NextPreviousFirstLast" ShowFooter="True" Width="100%" OnRowCancelingEdit="gvToAssignments_RowCancelingEdit"
                                OnRowEditing="gvToAssignments_RowEditing" OnRowDeleting="gvToAssignments_RowDeleting" OnRowDataBound="gvToAssignments_RowDataBound">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings FirstPageText="&amp;lt;" LastPageText="&amp;gt;" Mode="NumericFirstLast" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <FooterStyle CssClass="footerStyleTotals" />
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("transid")%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Project #" SortExpression="proj_num">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRProjNum" runat="Server" Text='<%# Eval("proj_num") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Account Number" SortExpression="Account">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            Running Total :
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fund Name" SortExpression="Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("Name") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooterAmount" runat="server" Text=""></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            Balance Amount :
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" SortExpression="Amount" ItemStyle-HorizontalAlign="Right"
                                        FooterStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                        </ItemTemplate>
                                        <%-- <EditItemTemplate>
                                                <asp:TextBox ID="txtAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount", "{0:0.00}") %>'></asp:TextBox>
                                            </EditItemTemplate>--%>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooterBalance" runat="server" Text=""></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" />
                                        <FooterStyle Width="200px" />
                                        <HeaderStyle Width="200px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Guid" SortExpression="projguid" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProjGuid" runat="Server" Text='<%# Eval("projguid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fund Id" SortExpression="FundID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Detail Id" SortExpression="detailid" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDetId" runat="Server" Text='<%# Eval("detailid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LnkBtnEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible="false"></asp:LinkButton>
                                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete the detail?');"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStyle" />
                            </asp:GridView>
                                </asp:Panel>
                                </div>
                        </div>
                        <%--&nbsp;&nbsp;<asp:Button ID="btnNewTransaction" runat="server" class="btn btn-info" Enabled="true" OnClick="btnNewTransaction_Click" TabIndex="11" Text="Add New Assignment" Visible="False" />--%>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
        <asp:HiddenField ID="hfProjId" runat="server" />
        <asp:HiddenField ID="hfTransId" runat="server" />
        <asp:HiddenField ID="hfTransAmt" runat="server" />
        <asp:HiddenField ID="hdnAssignmentProjValue" OnValueChanged="hdnAssignmentProjValue_ValueChanged" runat="server" />
        <asp:HiddenField ID="hdnAssignmentToProjectValue" OnValueChanged="hdnAssignmentToProjectValue_ValueChanged" runat="server" />
        <asp:HiddenField ID="hfToProjId" runat="server" />
        <asp:HiddenField ID="hfFromAccountNumber" runat="server" />
        <asp:HiddenField ID="hfFromFundName" runat="server" />
        <asp:HiddenField ID="hfFromTransType" runat="server" />
        <asp:HiddenField ID="hfDetailId" runat="server" />
        
    </div>
    <script type="text/javascript">
         $(document).ready(function () {
           toCurrencyControl($('#<%= txtToAmt.ClientID%>').val(), $('#<%= txtToAmt.ClientID%>'));
                    $('#<%= txtToAmt.ClientID%>').keyup(function () {
                        toCurrencyControl($('#<%= txtToAmt.ClientID%>').val(), $('#<%= txtToAmt.ClientID%>'));
                     });
        });
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            var balAmt = document.getElementById("<%=hfBalAmt.ClientID%>").value;

            if (needToConfirm && balAmt != 0)
                return "You have attempted to leave this page.  Please make sure balance amount is 0 for each transaction, otherwise the transaction can't be used for board financial transactions.  Are you sure you want to exit this page?";
        }


        function PopupNewAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function PopupExistingAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };
        function PopupProjectSearch() {
            window.open('./projectsearch.aspx')
        };
        function OnRelocationProjectSelected(source, eventArgs) {

            var hdnCommitedProjValueID = "<%= hdnAssignmentProjValue.ClientID %>";

                        //document.getElementById("<%=hdnAssignmentProjValue.ClientID%>").value = eventArgs.get_value();

                        document.getElementById(hdnCommitedProjValueID).value = eventArgs.get_value();
                        __doPostBack(hdnCommitedProjValueID, "");
                        $('#totMoney').focus();
                    }
                    function OnToProjectSelected(source, eventArgs) {

                        var hdnValueID = "<%= hdnAssignmentToProjectValue.ClientID %>";

            document.getElementById(hdnValueID).value = eventArgs.get_value();
            __doPostBack(hdnValueID, "");
        }

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvAssignments.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }

        function SetContextKey() {            
            $find('<%=AutoCompleteExtender2.ClientID%>').set_contextKey($('#<%= txtFromProjectNum.ClientID%>').val());
        }
    </script>
</asp:Content>
