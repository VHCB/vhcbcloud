<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Commitments.aspx.cs" Inherits="vhcbcloud.Commitments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">Board Financial Transactions</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <asp:RadioButtonList ID="rdBtnFinancial" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4" onclick="needToConfirm = true;"
                        RepeatDirection="Horizontal"
                        OnSelectedIndexChanged="rdBtnFinancial_SelectedIndexChanged">
                        <asp:ListItem Selected="true"> Commitment &nbsp;</asp:ListItem>
                        <asp:ListItem> DeCommitment &nbsp;</asp:ListItem>
                        <asp:ListItem> Reallocation &nbsp;</asp:ListItem>
                        <asp:ListItem> Cash Refund &nbsp;</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlHide" runat="server" Visible="true">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">Select Project</div>
                    <div class="panel-body">

                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;"
                                        OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                                <td style="width: 10%; float: left"><span class="labelClass">Grantee :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlGrantee" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                </td>
                                <td style="width: 10%; float: left"></td>
                                <td style="width: 30%; float: right">
                                    <asp:LinkButton ID="lbAwardSummary" Visible="false" runat="server" Text="Award Summary" OnClick="lbAwardSummary_Click"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 8px"></td>
                            </tr>
                            <tr>
                                <td style="width: 10%; float: left">
                                    <asp:Label ID="lblProjNameText" class="labelClass" Visible="false" Text="Project Name :" runat="server"></asp:Label>
                                    <%-- <span class="labelClass">Project Name :</span>--%>

                                </td>
                                <td style="width: 20%; float: left">
                                    <asp:Label ID="lblProjName" class="labelClass" Text=" " runat="server"></asp:Label></td>
                                <td style="width: 10%; float: left">&nbsp;</td>
                                <td style="width: 20%; float: left">&nbsp;</td>
                                <td style="width: 10%; float: left">&nbsp;</td>
                                <td style="width: 30%; float: left"></td>
                            </tr>

                        </table>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div id="divPtransEntry" runat="server">
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 10%; float: left"><span class="labelClass">Trans Date :</span></td>
                                    <td style="width: 20%; float: left">
                                        <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="aceTransDate" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                    </td>
                                    <td style="width: 10%; float: left"><span class="labelClass">Total Amount  $ :</span></td>
                                    <td style="width: 20%; float: left">
                                        <asp:TextBox ID="txtTotAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                    <td style="width: 10%; float: left"></td>
                                    <td style="width: 30%; float: left">
                                        <asp:DropDownList ID="ddlStatus" Visible="false" CssClass="clsDropDown" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <%--   <asp:LinkButton ID="btnTransSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnTransSubmit_Click" 
                                OnClientClick="needToConfirm = false;" />--%>
                            <asp:Button ID="btnTransactionSubmit" runat="server" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;" OnClick="btnTransactionSubmit_Click" />
                            <br />
                        </div>
                        <br />

                        <asp:GridView ID="gvPTrans" runat="server" AutoGenerateColumns="False"
                            Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="Trans Date" SortExpression="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTransDate" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Date", "{0:MM-dd-yyyy}") %>'></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="acebdt" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trans Amount" SortExpression="TransAmt">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt", "{0:C2}") %>' />
                                        <asp:HiddenField ID="HiddenField2" runat="server" Value='<%#Eval("TransAmt")%>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTransAmt" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("TransAmt") %>'></asp:TextBox>

                                    </EditItemTemplate>
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
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                        <p class="lblErrMsg">
                            <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <asp:Panel ID="pnlTranDetails" runat="server" Visible="false">
                <div class="container">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:Label runat="server" ID="lblTransDetHeader" Text="Transaction Detail"></asp:Label>
                        </div>
                        <div class="panel-body">
                            <div id="divTransDetailEntry" runat="server">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 10%; float: left">
                                            <span class="labelClass">Fund # :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:DropDownList ID="ddlAcctNum" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlAcctNum_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Trans Type :</span></td>
                                        <td style="width: 20%; float: left">
                                            <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10%; float: left"><span class="labelClass">Fund Name :</span></td>
                                        <td style="width: 30%; float: left">
                                            <asp:Label ID="lblFundName" class="labelClass" Text=" " runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 4px" colspan="6" />
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                        <td style="width: 90%; float: left" colspan="5">
                                            <asp:TextBox ID="txtAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>
                                    </tr>
                                </table>
                                <br />
                                <%--  <asp:LinkButton ID="btnDecommitSubmit" runat="server" visible="false" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;"
                                OnClick="btnSubmit_Click" />--%>
                                <br />
                                <asp:Button ID="btnDecommitmentSubmit" runat="server" Enabled="true" Text="Submit" class="btn btn-info" OnClick="btnDecommitmentSubmit_Click" />
                            </div>
                            <br />
                            <asp:GridView ID="gvBCommit" runat="server" AutoGenerateColumns="False"
                                Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                GridLines="None" EnableTheming="True" AllowPaging="false"
                                AllowSorting="true" ShowFooter="True" OnRowCancelingEdit="gvBCommit_RowCancelingEdit"
                                OnRowEditing="gvBCommit_RowEditing" OnRowUpdating="gvBCommit_RowUpdating" OnRowDataBound="gvBCommit_RowDataBound">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <FooterStyle CssClass="footerStyleTotals" />
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdBtnSelectTransDetail" class="show" runat="server" onclick="RadioCheck1(this);" AutoPostBack="true"
                                                OnCheckedChanged="rdBtnSelectTransDetail_CheckedChanged" />
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("detailid")%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fund #" SortExpression="Account">
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
                                        <%-- <EditItemTemplate>
                                    <asp:TextBox ID="txtFundName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Name") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
                                        <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterAmount" Text=""></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                            <asp:TextBox ID="txtTransType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lktranstype") %>' Visible="false"></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            Balance Amount :
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("Amount", "{0:C2}") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label runat="server" ID="lblFooterBalance" Text=""></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="Fund Id" SortExpression="FundID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="Detail Id" SortExpression="detailid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDetId" runat="Server" Text='<%# Eval("detailid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" />
                                </Columns>
                                <FooterStyle CssClass="footerStyle" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </asp:Panel>
        <asp:HiddenField ID="hfTransId" runat="server" />
        <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
        <asp:HiddenField ID="hfTransAmt" runat="server" Value="0" />
    </div>

    <script type="text/javascript">
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            var balAmt = document.getElementById("<%=hfBalAmt.ClientID%>").value;
            //var traAmt = document.getElementById("<%=hfTransAmt.ClientID%>").value;

            if (needToConfirm && balAmt > 0)
                return "You have attempted to leave this page.  Please make sure balance amount is 0 for each transaction, otherwise the transaction can't be used for board financial transactions.  Are you sure you want to exit this page?";
        }
    </script>
</asp:Content>
