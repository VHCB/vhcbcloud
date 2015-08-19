<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardCommitment.aspx.cs" Inherits="vhcbcloud.BoardCommitment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">Board Commitment</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">Select Project</div>
                <div class="panel-body">

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 10%; float: left"><span class="labelClass">Project # :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                </asp:DropDownList></td>
                            <td style="width: 10%; float: left">
                                <span class="labelClass">Project Name :</span>
                            </td>
                            <td style="width: 20%; float: left">
                                <asp:Label ID="lblProjName" class="labelClass" Text="" runat="server"></asp:Label>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Grantee :</span></td>
                            <td style="width: 30%; float: left">
                                <asp:DropDownList ID="ddlGrantee" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                <%--<asp:TextBox ID="txtGrantee" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>--%>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Trans Date :</span></td>
                            <td>
                                <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="aceTransDate" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                            </td>
                            <td><span class="labelClass">Total Amount  $ :</span></td>
                            <td>
                                <asp:TextBox ID="txtTotAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                            <td><span class="labelClass">Status :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                    <br />
                    <asp:ImageButton ID="btnTransSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" OnClick="btnTransSubmit_Click" />
                    <br />
                    <br />
                    <asp:GridView ID="gvPTrans" runat="server" AutoGenerateColumns="False"
                        Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                        GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvPTrans_RowCancelingEdit"
                        OnRowEditing="gvPTrans_RowEditing" OnRowUpdating="gvPTrans_RowUpdating" OnPageIndexChanging="gvPTrans_PageIndexChanging" AllowSorting="true"
                        OnSorting="gvPTrans_Sorting" OnRowDataBound="gvPTrans_RowDataBound" OnSelectedIndexChanged="gvPTrans_SelectedIndexChanged" OnSelectedIndexChanging="gvPTrans_SelectedIndexChanging" OnRowDeleting="gvPTrans_RowDeleting">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center"  HeaderText="Select">
                                <ItemTemplate>
                                    <asp:RadioButton ID="rdBtnSelect"  runat="server" onclick="RadioCheck(this);" />
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("transid")%>' />
                                </ItemTemplate>
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
                                    <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    <asp:TextBox ID="txtTransStatus" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lkStatus") %>' Visible="false"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ProjectID" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblProjId" runat="Server" Text='<%# Eval("projectid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" />
                            <asp:CommandField ShowDeleteButton="true" />
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
                <div class="panel-heading">Commitment Detail</div>
                <div class="panel-body">
                    <span class="labelClass">Account # :</span>
                    <asp:TextBox ID="txtAcctNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                    &nbsp;<span class="labelClass">Fund Name :</span>
                    <asp:TextBox ID="txtFundName" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                    &nbsp;<span class="labelClass">Transaction Type :</span>
                    <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server">
                    </asp:DropDownList>
                    &nbsp;<span class="labelClass">Amount :</span>
                    <asp:TextBox ID="txtAmt" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" OnClick="btnSubmit_Click" />
                    <br />
                    <br />
                    <asp:GridView ID="gvBCommit" runat="server" AutoGenerateColumns="False"
                        Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                        GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvBCommit_RowCancelingEdit"
                        OnRowEditing="gvBCommit_RowEditing" OnRowUpdating="gvBCommit_RowUpdating" OnPageIndexChanging="gvBCommit_PageIndexChanging" AllowSorting="true"
                        OnSorting="gvBCommit_Sorting" OnRowDataBound="gvBCommit_RowDataBound">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:TemplateField HeaderText="Account Number" SortExpression="Account">
                                <ItemTemplate>
                                    <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAcctNum" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Account") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fund Name" SortExpression="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("Name") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFundName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fund Type" SortExpression="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("Description") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlFundsType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    <asp:TextBox ID="txtFundType" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lktranstype") %>' Visible="false"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account Number" SortExpression="Account">
                                <ItemTemplate>
                                    <asp:Label ID="lblAcctNum" runat="Server" Text='<%# Eval("Account") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAcctNum" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Account") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField Visible="false" HeaderText="Fund Id" SortExpression="FundID">
                                <ItemTemplate>
                                    <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                        <FooterStyle CssClass="footerStyle" />
                    </asp:GridView>
                </div>
            </div>
        </div>
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
    </script>
</asp:Content>
