<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardFinancialTransactions.aspx.cs" Inherits="vhcbcloud.BoardFinancialTransactions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">Board Financial Transactions</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <asp:RadioButtonList ID="rdBtnFinancial" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4" onclick="needToConfirm = true;" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnFinancial_SelectedIndexChanged">
                        <asp:ListItem> Commitment &nbsp;</asp:ListItem>
                        <asp:ListItem> DeCommitment &nbsp;</asp:ListItem>
                        <asp:ListItem> Reallocation &nbsp;</asp:ListItem>
                    </asp:RadioButtonList>

                </div>

            </div>
        </div>
        <asp:Panel ID="pnlHide" runat="server" Visible="false">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">Select Project</div>
                    <div class="panel-body">

                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                                <td style="width: 10%; float: left"><span class="labelClass">Grantee :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlGrantee" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    <%--<asp:TextBox ID="txtGrantee" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>--%>
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
                                <td style="width: 10%; float: left"><span class="labelClass">Project Name :</span></td>
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
                                    <td style="width: 10%; float: left">
                                        <%--<span class="labelClass">Status :</span>--%>
                                    </td>
                                    <td style="width: 30%; float: left">
                                        <asp:DropDownList ID="ddlStatus" Visible="false" CssClass="clsDropDown" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:LinkButton ID="btnTransSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnTransSubmit_Click" OnClientClick="needToConfirm = false;" />
                            <%--<input id="btnTransSubmit" type="button" runat="server" value="Submit" class="btn btn-info btn-sm" onclick="btnTransSubmit_Click" onclientclick="needToConfirm = false;" />--%>
                            <%--<asp:ImageButton ID="btnTransSubmit" runat="server" class="btn btn-info btn-sm" OnClick="btnTransSubmit_Click" OnClientClick="needToConfirm = false;" />--%>
                            <br />
                        </div>
                        <br />

                        <asp:GridView ID="gvPTrans" runat="server" AutoGenerateColumns="False"
                            Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvPTrans_RowCancelingEdit"
                            OnRowEditing="gvPTrans_RowEditing" OnRowUpdating="gvPTrans_RowUpdating" OnPageIndexChanging="gvPTrans_PageIndexChanging" AllowSorting="true"
                            OnSorting="gvPTrans_Sorting" OnRowDataBound="gvPTrans_RowDataBound" OnSelectedIndexChanged="gvPTrans_SelectedIndexChanged" OnSelectedIndexChanging="gvPTrans_SelectedIndexChanging" OnRowDeleting="gvPTrans_RowDeleting">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdBtnSelect" runat="server" onclick="RadioCheck(this); needToConfirm = false;" AutoPostBack="true" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("transid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
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
                                <asp:CommandField ShowEditButton="True" />
                                <asp:CommandField ShowDeleteButton="True" DeleteText="Inactivate" />
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>

                        <p class="lblErrMsg">
                            <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                        </p>
                    </div>
                </div>
            </div>

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
                            <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;" OnClick="btnSubmit_Click" />
                            <br />
                        </div>
                        <br />
                        <asp:GridView ID="gvBCommit" runat="server" AutoGenerateColumns="False"
                            Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvBCommit_RowCancelingEdit"
                            OnRowEditing="gvBCommit_RowEditing" OnRowUpdating="gvBCommit_RowUpdating" OnPageIndexChanging="gvBCommit_PageIndexChanging" AllowSorting="true"
                            OnSorting="gvBCommit_Sorting" OnRowDataBound="gvBCommit_RowDataBound" ShowFooter="True">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdBtnSelectTransDetail" class="show" runat="server" onclick="RadioCheck1(this);" AutoPostBack="true" OnCheckedChanged="rdBtnSelectTransDetail_CheckedChanged" />
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("detailid")%>' />
                                    </ItemTemplate>

                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund #" SortExpression="Account">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                    </ItemTemplate>
                                    <%--<EditItemTemplate>
                                    <asp:TextBox ID="txtAcctNum" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Account") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
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
                        <asp:HiddenField ID="hfTransAmt" runat="server" />
                        <asp:HiddenField ID="hfBalAmt" runat="server" />
                        <asp:HiddenField ID="hfTransId" runat="server" />
                        <asp:HiddenField ID="hfRFromTransId" runat="server" />
                    </div>
                    <div id="divReallocate" runat="server" visible="false" class="panel-body">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Reallocate Date :</span></td>
                                <td style="width: 20%; float: left">&nbsp;</td>

                                <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                <td style="width: 60%; float: left" colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 8px"></td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                        </table>

                    </div>
                </div>
            </div>

        </asp:Panel>
        <asp:Panel ID="pnlReallocations" runat="server" Visible="false">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">Reallocate from</div>
                    <div class="panel-body">

                        <table style="width: 100%" class="">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlRFromProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlRFromProj_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                                <td style="width: 10%; float: left"><span class="labelClass">Date :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:TextBox ID="txtRfromDate" runat="server" CssClass="clsTextBoxBlue1"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtRfromDate">
                                    </ajaxToolkit:CalendarExtender>
                                </td>
                                <td style="width: 10%; float: left">
                                    <span class="labelClass">Fund :</span>
                                </td>
                                <td style="width: 30%; float: left">
                                    <asp:DropDownList ID="ddlRFromFund" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRFromFund_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>

                            </tr>
                            <tr>
                                <td style="height: 4px" colspan="6" />
                            </tr>
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Type :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlRFromFundType" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;">
                                    </asp:DropDownList></td>
                                <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                <td style="width: 20%; float: left" >
                                    <asp:TextBox ID="txtRfromAmt" runat="server" CssClass="clsTextBoxBlueSm"></asp:TextBox>
                                </td>
                                <td style="width: 10%; float: left">

                                </td >
                                <td style="width: 30%; float: left">
                                    <asp:LinkButton ID="lbtnFromAwdSummary" Visible="false" runat="server" Text="Award Summary" OnClick="lbAwardSummary_Click"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <p class="lblErrMsg">
                            <asp:Label runat="server" ID="lblRErrorMsg" Font-Size="Small"></asp:Label>
                        </p>

                    </div>
                </div>
            </div>
            <div class="container" id="divReallocateTo" runat="server" visible="false">
                <div class="panel panel-default">
                    <div class="panel-heading">Reallocate To</div>
                    <div class="panel-body">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Project# :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlRToProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;" OnSelectedIndexChanged="ddlRToProj_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                                <td style="width: 10%; float: left"><span class="labelClass">Fund :</span></td>
                                <td style="width: 60%; float: left" colspan="3">
                                    <asp:DropDownList ID="ddlRToFund" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRToFund_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td style="height: 4px" colspan="6" />
                            </tr>
                            <tr>
                                <td style="width: 10%; float: left"><span class="labelClass">Type :</span></td>
                                <td style="width: 20%; float: left">
                                    <asp:DropDownList ID="ddlRtoFundType" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 10%; float: left"><span class="labelClass">Amount :</span></td>
                                <td style="width: 60%; float: left" colspan="3">
                                    <asp:TextBox ID="txtRToAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox></td>

                            </tr>

                        </table>
                        <br />
                        <asp:LinkButton ID="imgBtnReallocate" runat="server" Text="Submit" class="btn btn-info" OnClientClick="needToConfirm = false;" OnClick="imgBtnReallocate_Click" />
                        <br />
                        <br />

                        <asp:GridView ID="gvReallocate" runat="server" AllowPaging="false" AllowSorting="true" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                            PagerSettings-Mode="NextPreviousFirstLast" ShowFooter="True" Width="90%" OnPageIndexChanging="gvReallocate_PageIndexChanging"
                            OnRowCancelingEdit="gvReallocate_RowCancelingEdit" OnRowDataBound="gvReallocate_RowDataBound" OnRowEditing="gvReallocate_RowEditing" OnRowUpdating="gvReallocate_RowUpdating">
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
                                    <%--<EditItemTemplate>
                                    <asp:TextBox ID="txtAcctNum" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Account") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
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
                                        <asp:Label ID="lblFooterAmount" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction Type" SortExpression="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransType" runat="Server" Text='<%# Eval("Description") %>' />
                                    </ItemTemplate>
                                    <%--<EditItemTemplate>
                                        <asp:DropDownList ID="ddlTransType" runat="server" CssClass="clsDropDown">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtTransType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lktranstype") %>' Visible="false"></asp:TextBox>
                                    </EditItemTemplate>--%>
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
                                        <asp:Label ID="lblFooterBalance" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
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
                                <asp:CommandField ShowEditButton="True" />
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>

                        <br />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvPTrans.ClientID%>");
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

        function RadioCheck1(rb) {
            var gv = document.getElementById("<%=gvBCommit.ClientID%>");
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

        window.onbeforeunload = confirmExit;
        function confirmExit() {
            var gv = document.getElementById("<%=hfBalAmt.ClientID%>").value;
            if (needToConfirm)
                return "You have attempted to leave this page.  Please make sure balance amount is 0 for each transaction, otherwise the transaction can't be used for board financial transactions.  Are you sure you want to exit this page?";
        }

    </script>
</asp:Content>
