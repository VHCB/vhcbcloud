<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardCommitment.aspx.cs" Inherits="vhcbcloud.BoardCommitment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">Board Commitment</p>
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
                                <asp:Label ID="lblProjName" class="labelClass" Text="" runat="server"></asp:Label>
                            </td>
                            <td>&nbsp;</td>
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
                    <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif"  OnClick="btnSubmit_Click" />
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

        <%--<ajaxToolkit:TabContainer runat="server" ID="FinancialTrans"  Height="40px" CssClass="CustomTabStyle">
            <ajaxToolkit:TabPanel ID="tabCommitment" HeaderText="Board Commitment" runat="server">
                <ContentTemplate>

                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="tabDecommitment" HeaderText="Board Decommitment" runat="server" >
                <ContentTemplate>

                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="tabReallocation" HeaderText="Board Reallocation" runat="server" >
                <ContentTemplate>

                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="tabDisbursement" HeaderText="Board Disbursement" runat="server" >
                <ContentTemplate>

                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="tabRefund" HeaderText="Board Refund" runat="server" >
                <ContentTemplate>

                </ContentTemplate>
            </ajaxToolkit:TabPanel>

        </ajaxToolkit:TabContainer>--%>
    </div>
</asp:Content>
