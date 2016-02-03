<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckRequestDates.aspx.cs" Inherits="vhcbcloud.CheckRequestDates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">Check Request Dates</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <p>                        
                        <span class="labelClass">Date :</span>
                        <asp:TextBox ID="txtVoucherDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender runat="server" ID="aceVoucherDate" TargetControlID="txtVoucherDate"></ajaxToolkit:CalendarExtender>
                        <br />
                        <br />
                        <asp:LinkButton ID="btnSubmit" runat="server" class="btn btn-info" Text="Add check request date" TabIndex="3" OnClick="btnSubmit_Click" />
                    </p>
                    <p >
                       <span class="lblErrMsg"> <asp:Label runat="server" ID="lblErrorMsg"></asp:Label></span>
                    </p>
                </div>
                <div class="panel-body">
                    <p>
                        <asp:Panel runat="server" ID="Panel1" Width="100%" Height="350px" ScrollBars="Vertical">
                            <asp:GridView ID="gvCheckReq" runat="server" AutoGenerateColumns="False"
                                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast" AllowSorting="true"
                                GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvCheckReq_RowCancelingEdit" OnRowEditing="gvCheckReq_RowEditing" OnRowUpdating="gvCheckReq_RowUpdating"
                                OnPageIndexChanging="gvCheckReq_PageIndexChanging" OnRowDataBound="gvCheckReq_RowDataBound" OnSorting="gvCheckReq_Sorting">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>                                    

                                    <asp:TemplateField HeaderText="Check request date" SortExpression="CRDate">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVDate" runat="Server" Text='<%# Eval("CRDate", "{0:MM-dd-yyyy}") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtVouDate" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("InitDate", "{0:MM-dd-yyyy}") %>'></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="aceVDate" TargetControlID="txtVouDate"></ajaxToolkit:CalendarExtender>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCRDateId" runat="Server" Text='<%# Eval("CRDateID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:CommandField ShowEditButton="True" />--%>
                                </Columns>
                                <FooterStyle CssClass="footerStyle" />
                            </asp:GridView>
                        </asp:Panel>
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
