<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="awardsummary.aspx.cs" Inherits="vhcbcloud.awardsummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">Award Summary</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading"><span class="labelClass">Current Award Status for project: </span> <b><asp:Label runat="server" ID="lblProjId"></asp:Label></b></div>

                <div class="panel-body">
                    <p>
                        Project # :
                        <asp:DropDownList ID="ddlProj" CssClass="clsDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProj_SelectedIndexChanged"></asp:DropDownList>
                    </p>
                    <asp:Panel runat="server" ID="Panel1" Width="100%" Height="200px" ScrollBars="Vertical">
                        <asp:GridView ID="gvCurrentAwdStatus" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                             OnRowCreated="gvCurrentAwdStatus_RowCreated"
                            ShowFooter="True" Width="90%">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>
                                
                                 <asp:TemplateField HeaderText="Reallocate To">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReallocateTo" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        Totals :
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("fundid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund" SortExpression="FundName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundName" runat="Server" Text='<%# Eval("FundName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Grant/Loan/Contract" SortExpression="FundType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("FundType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Commit" SortExpression="CommitmentAmount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommitAmt" runat="Server" Text='<%# Eval("commitmentamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblCommit" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pending" SortExpression="pendingamount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPendingAmt" runat="Server" Text='<%# Eval("pendingamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblPending" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Expend" SortExpression="expendedamount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpendAmd" runat="Server" Text='<%# Eval("expendedamount", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblExpend" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Balance" SortExpression="balance">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAmt" runat="Server" Text='<%# Eval("balance", "{0:C2}") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblBalance" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Id" SortExpression="FundID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("FundID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                    </asp:Panel>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                    </p>
                </div>
                <div class="panel-heading">Transaction Detail</div>
                <div class="panel-body">
                    <asp:Panel runat="server" ID="pnlTransDet" Width="100%" Height="350px" ScrollBars="Vertical">
                        <asp:GridView ID="gvTransDetail" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None"
                            AllowPaging="false" Width="90%">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("fundid")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date" SortExpression="TransDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransDate" runat="Server" Text='<%# Eval("TransDate", "{0:M-dd-yyyy}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fund Name" SortExpression="name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfundName" runat="Server" Text='<%# Eval("name") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Grant/Loan/Contract" SortExpression="FundType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFundType" runat="Server" Text='<%# Eval("FundType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction" SortExpression="Transaction">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransaction" runat="Server" Text='<%# Eval("Transaction") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Detail" SortExpression="detail">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDetail" runat="Server" Text='<%# Eval("detail", "{0:C2}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status" SortExpression="lkstatus">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="Server" Text='<%# Eval("lkstatus") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

