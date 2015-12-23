<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LookupMaintenance.aspx.cs" Inherits="vhcbcloud.LookupMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Lookup Maintenance</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <p>
                        <span class="labelClass">View name :</span>
                        <asp:DropDownList ID="ddlLkLookupViewname" CssClass="clsDropDownLong" runat="server" OnSelectedIndexChanged="ddlLkLookupViewname_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                        &nbsp;<span class="labelClass">New description :</span>
                        <asp:TextBox ID="txtDescription" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox>
                        <%--&nbsp;<asp:ImageButton ID="imgSearch" runat="server" Height="25px" ImageUrl="~/Images/image004.png" Width="25px" OnClick="imgSearch_Click" />--%>
                        <br />
                        <asp:GridView ID="gvLkDescription" runat="server" AutoGenerateColumns="False"
                            Width="90%" CssClass="gridView"
                            GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvLkDescription_RowCancelingEdit"
                            OnRowEditing="gvLkDescription_RowEditing" OnRowUpdating="gvLkDescription_RowUpdating">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="RecordID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRecordId" runat="Server" Text='<%# Eval("RecordID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lbllkDesc" runat="Server" Text='<%# Eval("LKDescription") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtlkDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("LKDescription") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" />
                            </Columns>
                        </asp:GridView>
                        <%--<asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="Description is required" CssClass="lblErrMsg" ControlToValidate="txtDescription"></asp:RequiredFieldValidator>--%>
                        <br />
                        <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
                    </p>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
                    </p>
                </div>
                <div class="panel-body">
                    <p>
                        <asp:Panel runat="server" ID="Panel1" Width="100%" Height="350px" ScrollBars="Vertical">
                            <asp:GridView ID="gvLookup" runat="server" AutoGenerateColumns="False"
                                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvLookup_RowCancelingEdit"
                                OnRowEditing="gvLookup_RowEditing" OnRowUpdating="gvLookup_RowUpdating" AllowSorting="true"
                                OnPageIndexChanging="gvLookup_PageIndexChanging" OnRowDataBound="gvLookup_RowDataBound" OnSorting="gvLookup_Sorting">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Type ID" SortExpression="typeid">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltypeid" runat="Server" Text='<%# Eval("typeid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View name" SortExpression="Viewname">
                                        <ItemTemplate>
                                            <asp:Label ID="lblViewname" runat="Server" Text='<%# Eval("Viewname") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Description" SortExpression="description">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldesc" runat="Server" Text='<%# Eval("description") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("description") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <%-- <asp:TemplateField HeaderText="Standard" SortExpression="standard">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkStandard" Enabled="false" runat="server" Checked='<%# Eval("standard") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkStandardEdit" runat="server" Checked='<%# Eval("standard") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Active" SortExpression="RowIsActive">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="Record ID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblrecordId" runat="Server" Text='<%# Eval("recordId") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" />
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
