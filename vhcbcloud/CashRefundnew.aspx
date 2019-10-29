<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"
    MaintainScrollPositionOnPostback="true" CodeBehind="CashRefundnew.aspx.cs" Inherits="vhcbcloud.CashRefundnew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix" id="vhcb">
        <p class="lead">Cash Void</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td></td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" Style="border: none;" runat="server" Text="Project Search" Visible="true"
                                    OnClientClick="PopupProjectSearch(); return false;"></asp:ImageButton>
                                &nbsp;<asp:ImageButton ID="imgNewAwardSummary" runat="server" ImageUrl="~/Images/$$.png" OnClientClick="PopupNewAwardSummary(); return false;" Style="border: none;" Text="Award Summary" ToolTip="Award summary" Visible="true" />
                                <asp:ImageButton ID="imgExistingAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="false" OnClientClick="PopupExistingAwardSummary(); return false;" />
                                &nbsp;<asp:ImageButton ID="btnProjectNotes" ImageUrl="~/Images/notes.png" ToolTip="Notes" runat="server" Text="Project Notes" Style="border: none;" />
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

                <div class="panel panel-default">
                    <div class="panel-body">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 7%; float: left"><span class="labelClass">Project # :</span></td>
                                <td style="width: 14%; float: left">
                                    <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" Width="120px" runat="server"
                                        ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProjNum" MinimumPrefixLength="1"
                                        EnableCaching="true" CompletionSetCount="1"
                                        CompletionInterval="100" ServiceMethod="GetProjectsByFilter">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td style="width: 40%; float: left">
                                    <span class="labelClass">Project Name : </span>
                                    <asp:Label ID="lblProjName" class="labelClass" Text=" " runat="server"></asp:Label>
                                </td>
                                <td style="float: left"></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 5px"></td>
                            </tr>
                            <tr>
                                <td style="width: 7%; float: left">&nbsp;</td>
                                <td style="width: 14%; float: left">&nbsp;</td>
                                <td style="width: 40%; float: left">&nbsp;</td>
                                <td style="float: left">&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvFinalizedTrans" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-body" id="dvFinalizedTransGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvFinalizedTrans" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="false">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="TransId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransId" runat="Server" Text='<%# Eval("TransId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectFinalizedTrans" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectFinalizedTrans_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenTransId" runat="server" Value='<%#Eval("TransId")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voucher#">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVoucherNumber" runat="Server" Text='<%# Eval("VoucherNumber") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Trans Amt">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Check Request Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCRDate" runat="Server" Text='<%# Eval("CRDate", "{0:MM-dd-yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voucher Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInitDate" runat="Server" Text='<%# Eval("Paiddate", "{0:MM-dd-yyyy}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePS" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField ShowHeader="False">
                                            <%--<EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>--%>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="panel-width" runat="server" id="dvTransDetails" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-body" id="Div2" runat="server">
                            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvTransDetails" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="false">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" Visible="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("detailid")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund #" SortExpression="Account">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fund Name" SortExpression="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="State/VHCB #s">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStateVHCBNos" runat="Server" Text='<%# Eval("StateVHCBNos") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>


                <div class="panel panel-default" runat="server" id="dvVoidSubmit" visible="false">
                    <div class="panel-body">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Trans Date :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlueSm" runat="server" TabIndex="3"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender runat="server" ID="aceTransDate" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                </td>
                                <td style="width: 10%; float: left"><span class="labelClass"></span></td>
                                <td style="width: 20%; float: left">
                                    <asp:Button ID="btnSubmitVoid" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmitVoid_Click"
                                         OnClientClick="return confirm('Are you sure you want to activate this transaction? All detail records will be reversed by adding corresponding entries of a positive value.  Are you sure you wish to continue?');" />
                                </td>
                                <td style="width: 20%; float: left">&nbsp;</td>
                                <td style="width: 20%; float: left">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 5px"></td>
                            </tr>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <asp:HiddenField ID="hfProjId" runat="server" />
        <asp:HiddenField ID="hfTransId" runat="server" />
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= btnSubmitVoid.ClientID %>').attr("disabled", "true");

            $('#<%= txtTransDate.ClientID %>').blur(function () {
                console.log($('#<%= txtTransDate.ClientID %>').val());
                if ($('#<%= txtTransDate.ClientID %>').val() != "") {
                    $('#<%= btnSubmitVoid.ClientID %>').removeAttr("disabled");
                } else {
                    $('#<%= btnSubmitVoid.ClientID %>').attr("disabled", "true");
                }
            });

            if ($('#<%= txtTransDate.ClientID %>').val() != "") {
                $('#<%= btnSubmitVoid.ClientID %>').removeAttr("disabled");
             } else {
                 $('#<%= btnSubmitVoid.ClientID %>').attr("disabled", "true");
             }
        });

         function PopupNewAwardSummary() {
             window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function PopupProjectSearch() {
            window.open('./projectsearch.aspx')
        };

        function PopupExistingAwardSummary() {
            window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
        };

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvFinalizedTrans.ClientID%>");
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
    </script>
</asp:Content>
