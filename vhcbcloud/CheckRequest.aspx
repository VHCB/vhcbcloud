<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckRequest.aspx.cs" Inherits="vhcbcloud.CheckRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">Check Request</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <p>
                        <span class="labelClass">Project # : </span><asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDownLong" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp;<span class="labelClass">Applicant Name :</span>
                        <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDownLong" AutoPostBack="true" runat="server">
                        </asp:DropDownList>
                        &nbsp;
                        <span class="labelClass">Initiation Date :</span>
                        <asp:TextBox ID="txtVoucherDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender runat="server" ID="aceVoucherDate" TargetControlID="txtVoucherDate"></ajaxToolkit:CalendarExtender>
                        <br />
                        <br />
                        <asp:LinkButton ID="btnSubmit" runat="server" class="btn btn-info" Text="Add new check request" TabIndex="3" OnClick="btnSubmit_Click" />
                    </p>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>

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
                                    <asp:BoundField DataField="Applicantname" HeaderText="Applicant Name" ReadOnly="True" SortExpression="Applicantname" />
                                     <asp:BoundField DataField="proj_num" HeaderText="Project #" ReadOnly="True" SortExpression="proj_num" />

                                    <%--<asp:TemplateField HeaderText="Amount" SortExpression="Transamt">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("TransAmt", "{0:c2}") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTrAmount" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("TransAmt") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Initiation Date" SortExpression="VoucherDate">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVDate" runat="Server" Text='<%# Eval("InitDate", "{0:M-dd-yyyy}") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtVouDate" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("InitDate", "{0:M-dd-yyyy}") %>'></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="aceVDate" TargetControlID="txtVouDate"></ajaxToolkit:CalendarExtender>

                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="proj_name" HeaderText="Name" SortExpression="proj_name" />--%>
                                    <asp:TemplateField Visible="false" HeaderText="Proj Appl Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProjapplId" runat="Server" Text='<%# Eval("ProjectApplicantID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" />
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
