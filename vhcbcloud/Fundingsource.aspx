<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Fundingsource.aspx.cs" Inherits="vhcbcloud.Fundingsource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Funding Source</p>
        <p>

            <span class="labelClass">Name :</span>
            <asp:TextBox ID="txtFName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>

            <br />
            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="funding name required" CssClass="lblErrMsg" ControlToValidate="txtFName"></asp:RequiredFieldValidator>

            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
        </p>

        <p>
            <asp:GridView ID="gvFSource" runat="server" AutoGenerateColumns="False" DataKeyNames="fundid"
                Width="90%" CssClass="gridView" PageSize="15" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvFSource_RowCancelingEdit"
                OnRowEditing="gvFSource_RowEditing" OnRowUpdating="gvFSource_RowUpdating"
                OnPageIndexChanging="gvFSource_PageIndexChanging">
                <AlternatingRowStyle CssClass="alternativeRowStyleLeft" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyleLeft" />
                <Columns>
                    <asp:TemplateField HeaderText="Funding Source Name">
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="Server" Text='<%# Eval("name") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("name") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField Visible="false" HeaderText="Fund Id">
                        <ItemTemplate>
                            <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("fundid") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
            </asp:GridView>
        </p>
    </div>
</asp:Content>
