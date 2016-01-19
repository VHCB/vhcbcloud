<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FundGrantMaintenance.aspx.cs" Inherits="vhcbcloud.FundGrantMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        table.ex1 {
            border-collapse: separate;
            border-spacing: 10px;
            width: 90%;
        }
    </style>
    <div class="jumbotron">

        <p class="lead">Fund/Grant Maintenance</p>        
        <div class="container"> 
            <div class="panel panel-default">
                <div class="panel-heading">Fund Information</div> 
                <div class="panel-body">
                    <table style="width: 90%">
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Name :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtFname" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <br />
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Abbreviation :</span> </td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtFAbbr" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>

                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Type :</span></td>
                            <td style="width: 25%; float: left">
                                <asp:DropDownList ID="ddlFundType" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Account # :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtAcctNumber" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">VHCB Code :</span> </td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtVHCBCode" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Acct Method :</span></td>
                            <td style="width: 25%; float: left">
                                <asp:DropDownList ID="ddlAcctMethod" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Dept. ID :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtDeptId" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">DrawDown :</span> </td>
                            <td style="width: 20%; float: left">
                                <asp:RadioButtonList ID="rdBtnDrawDown" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="width: 10%; float: left"></td>
                            <td style="width: 25%; float: left"></td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdUpdateMode" Value="false" runat="server" />
                    <asp:HiddenField ID="hfFundId" runat="server" />
                    <br />
                    <asp:ImageButton ID="btnFundSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" OnClick="btnFundSubmit_Click" />
                    <br />
                    <br />
                    <asp:Panel runat="server" ID="pnlFund" Width="100%" Height="300px" ScrollBars="Vertical">
                        <asp:GridView ID="gvFund" runat="server" AutoGenerateColumns="False"
                            Width="95%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvFund_RowCancelingEdit"
                            OnRowEditing="gvFund_RowEditing" OnRowUpdating="gvFund_RowUpdating" OnPageIndexChanging="gvFund_PageIndexChanging" AllowSorting="true"
                            OnSorting="gvFund_Sorting" OnRowDataBound="gvFund_RowDataBound" OnRowDeleting="gvFund_RowDeleting" OnSelectedIndexChanged="gvFund_SelectedIndexChanged">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("fundId")%>' />
                                    </ItemTemplate>

                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund ID" Visible="false" SortExpression="fundId">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("fundId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Account" SortExpression="account">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAccount" runat="Server" Text='<%# Eval("account") %>' />
                                    </ItemTemplate>
                                    <%--<EditItemTemplate>
                                    <asp:TextBox ID="txtAccount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("account") %>'>
                                    </asp:TextBox>
                                </EditItemTemplate>--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" SortExpression="name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfName" runat="Server" Text='<%# Eval("name") %>' />
                                    </ItemTemplate>
                                    <%--<EditItemTemplate>
                                    <asp:TextBox ID="txtFName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("name") %>'>
                                    </asp:TextBox>
                                </EditItemTemplate>--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Abbreviation" SortExpression="abbrv">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfAbbrv" runat="Server" Text='<%# Eval("abbrv") %>' />
                                    </ItemTemplate>
                                    <%--  <EditItemTemplate>
                                    <asp:TextBox ID="txtfAbbrv" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("abbrv") %>'>
                                    </asp:TextBox>
                                </EditItemTemplate>--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Type" SortExpression="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransStatus" runat="Server" Text='<%# Eval("Description") %>' />
                                    </ItemTemplate>
                                    <%--<EditItemTemplate>
                                    <asp:DropDownList ID="ddlFundsType" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    <asp:TextBox ID="txtFtype" runat="Server" Visible="false" CssClass="clsTextBoxBlueSm" Text='<%# Eval("description") %>'></asp:TextBox>

                                </EditItemTemplate>--%>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" UpdateText="" />
                                <asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                    </asp:Panel>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
        <div class="container" id="divGrantInfo">
            <div class="panel panel-default">
                <div class="panel-heading">Grant Information</div>
                <div class="panel-body">
                    <table style="width: 90%">
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Name :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtGrantName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">VHCB Name :</span> </td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtVHCBGrantName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 15%; float: left"><span class="labelClass">Award # :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtAwardNum" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Grantor :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlGrantor" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Award Amount :</span> </td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtAwdAmt" CssClass="clsTextBoxBlue1" runat="server" onkeypress="return isNumber(event)"></asp:TextBox>

                            </td>
                            <td style="width: 15%; float: left"><span class="labelClass">Source of Grant :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlGrantSource" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Begin Date :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtBeginDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtBeginDate" TargetControlID="txtBeginDate">
                                </ajaxToolkit:CalendarExtender>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">End Date :</span> </td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtEndDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEndDate" TargetControlID="txtEnddate">
                                </ajaxToolkit:CalendarExtender>
                            </td>
                            <td style="width: 15%; float: left"><span class="labelClass">Staff :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlStaff" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Contact : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlContact" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">CFDA # : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:TextBox ID="txtCGDANum" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 15%; float: left"><span class="labelClass">Signed Grant Agreement : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:RadioButtonList ID="rdbtnSignedGrant" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Federal Funds : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:RadioButtonList ID="rdBtnFedFunds" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Admin : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:RadioButtonList ID="rdBtnAdmin" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="width: 15%; float: left"><span class="labelClass">Match ? </span></td>
                            <td style="width: 20%; float: left">
                                <asp:RadioButtonList ID="rdBtnMatch" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                        <tr>
                            <td style="width: 15%; float: left"><span class="labelClass">Funds Received/Available : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:RadioButtonList ID="rdBtnFundsRec" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="width: 10%; float: left"><span class="labelClass">Active : </span></td>
                            <td style="width: 20%; float: left">
                                <asp:CheckBox ID="chkActive" Checked="true" runat="server" />
                            </td>
                            <td style="width: 15%; float: left">&nbsp;</td>
                            <td style="width: 20%; float: left">&nbsp;</td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hfGIUpdateMode" runat="server" Value="false" />
                    <asp:HiddenField ID="hfGInfoId" runat="server" />
                    <br />
                    <br />
                    <asp:ImageButton ID="btnGrantSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" OnClick="btnGrantSubmit_Click" />
                    <br />
                    <br />
                    <asp:GridView ID="gvGranInfo" runat="server" AutoGenerateColumns="False"
                        Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                        GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvGranInfo_RowCancelingEdit"
                        OnRowEditing="gvGranInfo_RowEditing" OnRowUpdating="gvGranInfo_RowUpdating" OnPageIndexChanging="gvGranInfo_PageIndexChanging" AllowSorting="true"
                        OnSorting="gvGranInfo_Sorting" OnRowDataBound="gvGranInfo_RowDataBound" OnRowDeleting="gvGranInfo_RowDeleting" OnSelectedIndexChanged="gvGranInfo_SelectedIndexChanged">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                <ItemTemplate>
                                    <asp:RadioButton ID="rdBtnSelectGrantInfo" class="show" runat="server" onclick="RadioCheck1(this);" AutoPostBack="true" OnCheckedChanged="rdBtnSelectGrantInfo_CheckedChanged" />
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("grantinfoid")%>' />
                                </ItemTemplate>

                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Grant Info ID" Visible="false" SortExpression="grantinfoid">
                                <ItemTemplate>
                                    <asp:Label ID="lblGIId" runat="Server" Text='<%# Eval("grantinfoid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="VHCBName" SortExpression="VHCBName">
                                <ItemTemplate>
                                    <asp:Label ID="lblvhcbName" runat="Server" Text='<%# Eval("VHCBName") %>' />
                                </ItemTemplate>
                                <%-- <EditItemTemplate>
                                    <asp:TextBox ID="txtvhcbName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("VHCBName") %>'>
                                    </asp:TextBox>
                                </EditItemTemplate>--%>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" SortExpression="GrantName">
                                <ItemTemplate>
                                    <asp:Label ID="lblgiName" runat="Server" Text='<%# Eval("GrantName") %>' />
                                </ItemTemplate>
                                <%--<EditItemTemplate>
                                    <asp:TextBox ID="txtgiName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("name") %>'>
                                    </asp:TextBox>
                                </EditItemTemplate>--%>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Grantor" SortExpression="description">
                                <ItemTemplate>
                                    <asp:Label ID="lblGrantor" runat="Server" Text='<%# Eval("description") %>' />
                                </ItemTemplate>
                                <%--<EditItemTemplate>
                                    <asp:DropDownList ID="ddlGrantor" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    <asp:TextBox ID="txtGrantor" runat="Server" Visible="false" CssClass="clsTextBoxBlueSm" Text='<%# Eval("description") %>'></asp:TextBox>
                                </EditItemTemplate>--%>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True"/>
                            <asp:CommandField ShowDeleteButton="true"  DeleteText="Inactivate"   />
                        </Columns>
                        <FooterStyle CssClass="footerStyle" />
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="container" id="divFiscalYrAmt">
            <div class="panel panel-default">
                <div class="panel-heading">Fiscal Year Amount</div>
                <div class="panel-body">
                    <table style="width: 90%">
                        <tr>
                            <%--<td style="width: 10%; float: left"><span class="labelClass">Grant Info :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlGrantInfoDet" AutoPostBack="true" CssClass="clsDropDown" runat="server" OnSelectedIndexChanged="ddlGrantInfoDet_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>--%>
                            <td style="width: 10%; float: left"><span class="labelClass">Fiscal Year :</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlFiscalYr" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 15%; float: left"><span class="labelClass">Amount :</span></td>
                            <td style="width: 25%; float: left">
                                <asp:TextBox ID="txtAmount" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" Enabled="True" DisplayMoney="left" InputDirection="LeftToRight"
                                    Mask="99999999.99" MaskType="Number" TargetControlID="txtAmount">
                                </ajaxToolkit:MaskedEditExtender>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:ImageButton ID="btnFisYrAmt" runat="server" ImageUrl="~/Images/BtnSubmit.gif" OnClick="btnFisYrAmt_Click" />
                    <br />
                    <br />
                    <asp:GridView ID="gvFrantInfoFy" runat="server" AutoGenerateColumns="False"
                        Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                        GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvFrantInfoFy_RowCancelingEdit"
                        OnRowEditing="gvFrantInfoFy_RowEditing" OnRowUpdating="gvFrantInfoFy_RowUpdating" OnPageIndexChanging="gvFrantInfoFy_PageIndexChanging" AllowSorting="true"
                        OnSorting="gvFrantInfoFy_Sorting" OnRowDataBound="gvFrantInfoFy_RowDataBound" OnRowDeleting="gvFrantInfoFy_RowDeleting">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:TemplateField HeaderText="GrantInfoFy" Visible="false" SortExpression="GrantInfoFy">
                                <ItemTemplate>
                                    <asp:Label ID="lblGrantInfoFY" runat="Server" Text='<%# Eval("GrantInfoFy") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fiscal Year" SortExpression="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lblFiscYr" runat="Server" Text='<%# Eval("Description") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlFiscalYr" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                    <asp:HiddenField ID="hfYear" runat="server" Value='<%# Eval("LkYear") %>' />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblAmount" runat="Server" Text='<%# String.Format("{0:C}", Eval("Amount"))%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAmount" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Amount") %>' onkeypress="return isNumber(event)"> </asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" />
                            <asp:CommandField ShowDeleteButton="true" />
                        </Columns>
                        <FooterStyle CssClass="footerStyle" />
                    </asp:GridView>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="Label1" Font-Size="Small"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function () {
            $("divGrantInfo").hide();
            $("divFiscalYrAmt").hide();
        });

        $(document).on("pageload", function () {
            $("divGrantInfo").hide();
            $("divFiscalYrAmt").hide();

            $("#hide").click(function () {
                $("p").hide();
            });
            $("#show").click(function () {
                $("divGrantInfo").show();
            });
        });

        $(document).ready(function () {
            $("divGrantInfo").hide();
            $("divFiscalYrAmt").hide();

            $("#hide").click(function () {
                $("p").hide();
            });
            $("#show").click(function () {
                $("divGrantInfo").show();
            });
        });



        function RadioCheck(rb) {            
            var gv = document.getElementById("<%=gvFund.ClientID%>");
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
            var gv = document.getElementById("<%=gvGranInfo.ClientID%>");
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

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
