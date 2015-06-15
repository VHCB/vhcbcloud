<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LookupMaintenance.aspx.cs" Inherits="vhcbcloud.LookupMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Lookup Maintenance</p>
        <p>
            <span class="labelClass">Lookup Table :</span>
            <asp:DropDownList ID="ddlLkLookup" CssClass="clsDropDownLong" runat="server" >
            </asp:DropDownList>
            &nbsp;<span class="labelClass">Description :</span>
            <asp:TextBox ID="txtDescription" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="Description is required" CssClass="lblErrMsg" ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
        </p>

        <p>
            <asp:GridView ID="gvLookup" runat="server" AutoGenerateColumns="False"
                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvLookup_RowCancelingEdit"
                OnRowEditing="gvLookup_RowEditing" OnRowUpdating="gvLookup_RowUpdating"
                OnPageIndexChanging="gvLookup_PageIndexChanging">
                <AlternatingRowStyle CssClass="alternativeRowStyleLeft" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyleLeft" />
                <Columns>
                    <asp:TemplateField  HeaderText="Lookup Table">
                        <ItemTemplate>
                            <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("Tablename") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label ID="lbldesc" runat="Server" Text='<%# Eval("description") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("description") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField Visible="false" HeaderText="Record ID">
                        <ItemTemplate>
                            <asp:Label ID="lblFundId" runat="Server" Text='<%# Eval("recordId") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
            </asp:GridView>
        </p>
    </div>
</asp:Content>
