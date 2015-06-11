<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckRequest.aspx.cs" Inherits="vhcbcloud.CheckRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">Check Request</p>
        <p>
            <span class="labelClass">Project # :</span><asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDownLong" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
            </asp:DropDownList>
            &nbsp;<span class="labelClass">Applicant Name :</span>
            <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDownLong" AutoPostBack="true" runat="server">
            </asp:DropDownList>
            <br />
            <span class="labelClass">Amount :</span>
            <asp:TextBox ID="txtAmt" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            &nbsp;<span class="labelClass">Voucher Date :</span>
            <asp:TextBox ID="txtVoucherDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <ajaxToolkit:CalendarExtender runat="server" ID="aceVoucherDate" TargetControlID="txtVoucherDate"></ajaxToolkit:CalendarExtender>
            <br />
            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
        </p>
        <p>
            <asp:GridView ID="gvCheckReq" runat="server" AutoGenerateColumns="False" 
                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvCheckReq_RowCancelingEdit" OnRowEditing="gvCheckReq_RowEditing" OnRowUpdating="gvCheckReq_RowUpdating" 
                OnPageIndexChanging="gvCheckReq_PageIndexChanging">
                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyle" />
                <Columns>
                    <asp:BoundField DataField="Applicantname" HeaderText="Applicant Name" ReadOnly="True"  SortExpression="Applicantname" />
                    
                    <asp:TemplateField HeaderText="Amount">
                        <ItemTemplate>
                            <asp:Label ID="lblAmount" runat="Server" Text='<%# Eval("TransAmt") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTrAmount" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("TransAmt") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Voucher Date">
                        <ItemTemplate>
                            <asp:Label ID="lblVDate" runat="Server" Text='<%# Eval("VoucherDate") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtVouDate" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("VoucherDate") %>'></asp:TextBox>
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
        </p>

    </div>
</asp:Content>
