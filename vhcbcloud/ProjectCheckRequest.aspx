﻿<%@ Page Title="Project Check Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectCheckRequest.aspx.cs" Inherits="vhcbcloud.ProjectCheckRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Check Request</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">Check Request</div>
                <div class="panel-body">
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                        <asp:Label runat="server" ID="lblMessage" Font-Size="Small"></asp:Label>
                    </p>
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Project # :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                </asp:DropDownList></td>
                            <td>
                                <span class="labelClass">Project Name :</span>
                            </td>
                            <td>
                                <asp:Label ID="lblProjName" class="labelClass" Text="--" runat="server"></asp:Label>
                            </td>
                            <td><span class="labelClass">Date :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlDate" CssClass="clsDropDown" runat="server" Visible="false">
                                </asp:DropDownList>
                                <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="aceTransDate" TargetControlID="txtTransDate"></ajaxToolkit:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Applicant :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDown" runat="server" Height="21px" Width="174px">
                                </asp:DropDownList>

                            </td>
                            <td>
                                <span class="labelClass">Payee :</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPayee" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td><span class="labelClass">Program:</span></td>
                            <td>
                                <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Closing/Legal Review :</span></td>
                            <td>
                                <asp:CheckBox ID="chkLegalReview" runat="server" Text="Yes" OnCheckedChanged="chkLegalReview_CheckedChanged" AutoPostBack="True"></asp:CheckBox>

                            </td>

                            <td><span class="labelClass">LCB :</span></td>
                            <td>
                                <asp:CheckBox ID="chkLCB" runat="server" Text="Yes"></asp:CheckBox>
                            </td>
                            <td>
                                <span class="labelClass">Status :</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labelClass" id="lblAmtEligibleForMatch" runat="server">Amount Eligible For Match $ :</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEligibleAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass" id="lblMatchingGrant" runat="server">Matching Grant :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlMatchingGrant" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Notes :</span></td>
                            <td colspan="3">
                                <asp:TextBox ID="txtNotes" TextMode="multiline" Columns="50" Rows="2" runat="server" />
                            </td>
                            <td><span class="labelClass">Disbursement $:</span></td>
                            <td>
                                <asp:TextBox ID="txtDisbursementAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px">
                                <asp:Button ID="btnCRSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnCRSubmit_Click" /></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <br />
                                <asp:Panel runat="server" ID="pnlPCRData" Width="100%" Height="300px" ScrollBars="Vertical">
                                    <asp:GridView ID="gvPCRData" runat="server" AutoGenerateColumns="False"
                                        Width="100%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                        GridLines="None"
                                        EnableTheming="True"
                                        AllowSorting="true"
                                        OnRowDataBound="gvPCRData_RowDataBound"
                                        OnRowEditing="gvPCRData_RowEditing"
                                        OnRowCancelingEdit="gvPCRData_RowCancelingEdit"
                                        OnSelectedIndexChanged="gvPCRData_SelectedIndexChanged">
                                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                        <HeaderStyle CssClass="headerStyle" />
                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                        <RowStyle CssClass="rowStyle" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                                    <asp:HiddenField ID="hfIDs" runat="server" Value='<%# string.Concat(Eval("ProjectCheckReqId"), "|", Eval("transid"), "|", Eval("TransAmt"))%>' />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Check Req Id" Visible="false" SortExpression="ProjectCheckReqId">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectCheckReqId" runat="Server" Text='<%# Eval("ProjectCheckReqId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Name" SortExpression="project_name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("project_name") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Legal Review" SortExpression="LegalReview">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegalReview" runat="Server" Text='<%# Eval("LegalReview") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Disbursement" SortExpression="TransAmt">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTransAmt" runat="Server" Text='<%# Eval("TransAmt") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Payee" SortExpression="Payee">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApplicantname" runat="Server" Text='<%# Eval("Payee") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowEditButton="True" UpdateText="" />
                                            <%-- <asp:CommandField ShowDeleteButton="true" DeleteText="Inactivate" />--%>
                                        </Columns>
                                        <FooterStyle CssClass="footerStyle" />
                                    </asp:GridView>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Disbursements</div>
                <div class="panel-body">
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Source (Based on Commitments)</span></td>
                            <td>
                                <asp:DropDownList ID="ddlFundTypeCommitments" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList></td>
                            <td>
                                <span class="labelClass">Grant/Loan/Contract :</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Amount $:</span></td>
                            <td>
                                <asp:TextBox ID="txtTransDetailAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">State/VHCB #s:</span></td>
                            <td>
                                <asp:DropDownList ID="ddlStateVHCBS" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px">
                                <asp:Button ID="btnPCRTransDetails" runat="server" Text="Add" Enabled="true" class="btn btn-info" OnClick="btnPCRTransDetails_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5"></td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <br />
                                <asp:GridView ID="gvPTransDetails" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    AllowSorting="true" ShowFooter="True" OnRowCancelingEdit="gvPTransDetails_RowCancelingEdit" OnRowDataBound="gvPTransDetails_RowDataBound" OnRowEditing="gvPTransDetails_RowEditing" OnRowUpdating="gvPTransDetails_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <FooterStyle CssClass="footerStyleTotals" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                            <ItemTemplate>
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
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Nature of Disbursements</div>
                <div class="panel-body">
                    <table style="width: 50%">
                        <tr>
                            <td><span class="labelClass">Nature of Disbursements :</span></td>
                            <td>
                                <asp:ListBox runat="server" SelectionMode="Multiple" ID="lbNOD">
                                    <%--<asp:ListItem Text="test1 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test2 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test3 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test1 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test2 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test3 Nature of Disbursements"></asp:ListItem>--%>
                                </asp:ListBox></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">Approvals</div>
                <div class="panel-body">
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Question :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlPCRQuestions" CssClass="clsDropDown" runat="server" Width="231px">
                                </asp:DropDownList></td>
                            <td>
                                <span class="labelClass">Approved By :</span>
                            </td>
                            <td>
                                <b><span class="labelClass"><%: Context.User.Identity.GetUserName()  %></span></b>
                            </td>
                            <td>
                                <span class="labelClass">Date :</span>
                            </td>
                            <td>
                                <span class="labelClass"><%:DateTime.Now.ToString() %></span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" /></td>
                        </tr>
                        <tr>
                            <td colspan="6"></td>
                        </tr>
                        <tr>
                            <td colspan="6"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfTransId" runat="server" />
        <asp:HiddenField ID="hfTransAmt" runat="server" Value="0" />
        <asp:HiddenField ID="hfBalAmt" runat="server" Value="0" />
        <asp:HiddenField ID="hfPCRId" runat="server" />
        <asp:HiddenField ID="hfEditPCRId" runat="server" />

        <%--<asp:HiddenField ID="hfPCRIDTransID" runat="server" />--%>
    </div>

    <script type="text/javascript">
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvPCRData.ClientID%>");
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
