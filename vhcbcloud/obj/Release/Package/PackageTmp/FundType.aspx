<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FundType.aspx.cs" Inherits="vhcbcloud.FundType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Fund Type</p>
        <p>
            <span class="labelClass">New Fund Type:</span>
            <asp:TextBox ID="txtDescription" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox>
            &nbsp;
            <span class="labelClass">Source :</span>
            <asp:DropDownList ID="ddlLkLookupViewname" CssClass="clsDropDownLong" runat="server">
            </asp:DropDownList>
            <br />
            <asp:Label runat="server" class="lblErrMsg" ID="lblErrorMsg"></asp:Label>
            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
            <asp:GridView ID="gvLkDescription" runat="server" AutoGenerateColumns="False" AllowSorting="true" AllowPaging="true"
                Width="90%" CssClass="gridView"
                GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvLkDescription_RowCancelingEdit"
                OnRowEditing="gvLkDescription_RowEditing" OnRowUpdating="gvLkDescription_RowUpdating" OnSorting="gvLkDescription_Sorting" OnPageIndexChanging="gvLkDescription_PageIndexChanging" PageSize="50">
                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <RowStyle CssClass="rowStyle" />
                <Columns>
                    <asp:TemplateField HeaderText="typeId" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lbltypeid" runat="Server" Text='<%# Eval("typeid") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description" SortExpression="description">
                        <ItemTemplate>
                            <asp:Label ID="lblDesc" runat="Server" Text='<%# Eval("description") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("description") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Source" SortExpression="source">
                        <ItemTemplate>
                            <asp:Label ID="lblSource" runat="Server" Text='<%# Eval("source") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Active" SortExpression="RowIsActive">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
            </asp:GridView>
            <%--<asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="Description is required" CssClass="lblErrMsg" ControlToValidate="txtDescription"></asp:RequiredFieldValidator>--%>
            <br />
        </p>
    </div>
</asp:Content>
