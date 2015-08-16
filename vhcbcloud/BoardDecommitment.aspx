<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardDecommitment.aspx.cs" Inherits="vhcbcloud.BoardDecommitment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">Board Decommitment</p>
        <div class="container">
            <div class="panel panel-default">

                <div class="panel-body">
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
                                <asp:Label ID="lblProjName" class="labelClass" Text="" runat="server"></asp:Label></td>
                            <td><span class="labelClass">Grantee :</span></td>
                            <td>
                                <asp:TextBox ID="txtGrantee" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                        </tr>
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
                    <asp:GridView ID="gvPTrans" runat="server" AutoGenerateColumns="False"
                        Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                        GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvPTrans_RowCancelingEdit"
                        OnRowEditing="gvPTrans_RowEditing" OnRowUpdating="gvPTrans_RowUpdating" OnPageIndexChanging="gvPTrans_PageIndexChanging" AllowSorting="true"
                        OnSorting="gvPTrans_Sorting" OnRowDataBound="gvPTrans_RowDataBound">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:BoundField DataField="proj_num" HeaderText="Number" ReadOnly="True" Visible="false" SortExpression="proj_num" />
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
                                     <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" data runat="server"></asp:DropDownList>
                                    <asp:TextBox ID="txtTransStatus" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("lkStatus") %>' Visible="false"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ProjectID" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblProjId" runat="Server" Text='<%# Eval("projectid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                        <FooterStyle CssClass="footerStyle" />
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">Detail</div>
                <div class="panel-body">
                    <span class="labelClass">New Account # :</span>
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
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
                    </p>
                    <br />
                    <asp:GridView ID="gvBCommit" runat="server" AutoGenerateColumns="False"
                        Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                        GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvBCommit_RowCancelingEdit"
                        OnRowEditing="gvBCommit_RowEditing" OnRowUpdating="gvBCommit_RowUpdating" OnPageIndexChanging="gvBCommit_PageIndexChanging" AllowSorting="true"
                        OnSorting="gvBCommit_Sorting" OnRowDataBound="gvBCommit_RowDataBound">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:BoundField DataField="proj_num" HeaderText="Number" ReadOnly="True" SortExpression="proj_num" />
                            <asp:TemplateField HeaderText="Project Name" SortExpression="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lblProjName" runat="Server" Text='<%# Eval("Description") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtProjName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Applicantname" HeaderText="Applicant Name" ReadOnly="True" SortExpression="Applicantname" />

                            <%--<asp:BoundField DataField="proj_name" HeaderText="Name" SortExpression="proj_name" />--%>
                            <asp:TemplateField Visible="false" HeaderText="Name Id" SortExpression="TypeID">
                                <ItemTemplate>
                                    <asp:Label ID="lblNameId" runat="Server" Text='<%# Eval("TypeID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TypeID" HeaderText="Name ID" ReadOnly="True" Visible="false" SortExpression="TypeID" />
                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                        <FooterStyle CssClass="footerStyle" />
                    </asp:GridView>
                </div>
            </div>
        </div>       
    </div>
</asp:Content>
