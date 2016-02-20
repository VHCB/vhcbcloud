<%@ Page Title="Project Check Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectCheckRequest.aspx.cs" Inherits="vhcbcloud.ProjectCheckRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Check Request</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">Check Request</div>
                <div class="panel-body">

                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Project # :</span></td>
                            <td>
                                <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDown" AutoPostBack="true" runat="server">
                                </asp:DropDownList></td>
                            <td>
                                <span class="labelClass">Project Name :</span>
                            </td>
                            <td>
                                <asp:Label ID="lblProjName" class="labelClass" Text="Hello Project Name" runat="server"></asp:Label>
                            </td>
                            <td><span class="labelClass">Date :</span></td>
                            <td>
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
                                <asp:Label ID="lblApplicantName" class="labelClass" Text="Hello Applicant Name" runat="server"></asp:Label>

                            </td>
                            <td>
                                <span class="labelClass">Payee :</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList1" CssClass="clsDropDown" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td><span class="labelClass">Disbursement $:</span></td>
                            <td>
                                <asp:TextBox ID="txtDisbursementAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Closing/Legal Review :</span></td>
                            <td>
                                <asp:CheckBox ID="chkLegalReview" runat="server" Text="Yes"></asp:CheckBox>

                            </td>
                            <td>
                                <span class="labelClass">Status :</span>
                            </td>
                            <td>
                                <span class="labelClass">Pending</span>
                            </td>
                            <td><span class="labelClass">Final Payment :</span></td>
                            <td>
                                <asp:CheckBox ID="chkFinalPayment" runat="server"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Check Request Finalized :</span></td>
                            <td>
                                <asp:CheckBox ID="chkReqFinalized" runat="server" Text="Yes"></asp:CheckBox>

                            </td>
                            <td>
                                <span class="labelClass">Amount Eligible For Match :</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEligibleAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">Matching Grant :</span></td>
                            <td>
                                <asp:DropDownList ID="DropDownList2" CssClass="clsDropDown" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Notes :</span></td>
                            <td colspan="5">
                                <asp:TextBox ID="TextBox3" TextMode="multiline" Columns="50" Rows="2" runat="server" />
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Disbursements</div>
                <div class="panel-body">
                    <table style="width: 70%">
                        <tr>
                            <td><span class="labelClass">Source (Based on Commitments)</span></td>
                            <td>
                                <asp:DropDownList ID="DropDownList3" CssClass="clsDropDown" AutoPostBack="true" runat="server">
                                </asp:DropDownList></td>
                            <td>
                                <span class="labelClass">Grant/Loan/Contract :</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList4" CssClass="clsDropDown" AutoPostBack="true" runat="server">
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
                                <asp:TextBox ID="TextBox1" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                            </td>
                            <td><span class="labelClass">State/VHCB #s:</span></td>
                            <td>
                                <asp:DropDownList ID="DropDownList5" CssClass="clsDropDown" AutoPostBack="true" runat="server">
                                </asp:DropDownList></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px">
                                <asp:Button ID="Button1" runat="server" Text="Submit" class="btn btn-info" /></td>
                        </tr>
                        <tr>
                            <td colspan="5"></td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <asp:GridView ID="gvPTrans" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <%-- <asp:TemplateField HeaderText="Trans Date" SortExpression="Date">
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
                                        </asp:TemplateField>--%>
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
                                <asp:ListBox runat="server" SelectionMode="Multiple">
                                    <asp:ListItem Text="test1 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test2 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test3 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test1 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test2 Nature of Disbursements"></asp:ListItem>
                                    <asp:ListItem Text="test3 Nature of Disbursements"></asp:ListItem>
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
                    <table style="width: 70%">
                        <tr>
                            <td><span class="labelClass">Question :</span></td>
                            <td>
                                <asp:DropDownList ID="DropDownList6" CssClass="clsDropDown" AutoPostBack="true" runat="server">
                                </asp:DropDownList></td>
                            <td>
                                <span class="labelClass">Approved By :</span>
                            </td>
                            <td>
                                <span class="labelClass">Default Login Name</span>
                            </td>
                            <td>
                                <span class="labelClass">Date :</span>
                            </td>
                            <td>
                                <span class="labelClass">Default Todays Date</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td colspan="6" style="height: 5px">
                                <asp:Button ID="Button2" runat="server" Text="Submit" class="btn btn-info" /></td>
                        </tr>
                        <tr>
                            <td colspan="6"></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                    </Columns>
                                    <FooterStyle CssClass="footerStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
