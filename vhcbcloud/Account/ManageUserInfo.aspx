<%@ Page Title="Manage User Info" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ManageUserInfo.aspx.cs" Inherits="vhcbcloud.Account.ManageUserInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Manage User Info</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <b>User Info</b>
                </div>
                <div class="panel-body">
                    <table style="width: 90%">
                        <tr>
                            <td style="width: 22%; float: left"><span class="labelClass">First Name </span></td>
                            <td style="width: 45%; float: left">
                                <asp:TextBox ID="txtFname" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFname"
                                    CssClass="text-danger" ErrorMessage="The First Name field is required." />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="2" />
                        </tr>
                        <tr>
                            <td style="width: 22%; float: left"><span class="labelClass">Last Name </span></td>
                            <td style="width: 45%; float: left">
                                <asp:TextBox ID="txtLname" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLname"
                                    CssClass="text-danger" ErrorMessage="The Last Name field is required." />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="2" />
                        </tr>
                        <tr>
                            <td style="width: 22%; float: left"><span class="labelClass">Email </span></td>
                            <td style="width: 55%; float: left">
                                <asp:TextBox runat="server" ID="txt1Email" CssClass="clsTextBoxBlue1" /><%--TextMode="Email"--%>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txt1Email" CssClass="text-danger" ErrorMessage="The email field is required." />
                                <asp:RegularExpressionValidator ID="validateEmail"
                                    runat="server" ErrorMessage="The email field is invalid." CssClass="text-danger"
                                    ControlToValidate="txt1Email"
                                    ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="2" />
                        </tr>
                        <tr>
                            <td style="width: 22%; float: left"><span class="labelClass">Password </span></td>
                            <td style="width: 45%; float: left">
                                <asp:TextBox ID="txtPassword" CssClass="clsTextBoxBlue1" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                                    CssClass="text-danger" ErrorMessage="The password field is required." />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="2" />
                        </tr>
                        <tr>
                            <td style="width: 22%; float: left"><span class="labelClass">Confirm Password </span></td>
                            <td style="width: 65%; float: left">
                                <asp:TextBox ID="txtCPassword" CssClass="clsTextBoxBlue1" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                                <asp:CompareValidator runat="server" ControlToCompare="txtPassword" ControlToValidate="txtCPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="2" />
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="btnUserInfoSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnUserInfoSubmit_Click" />
                    <br />
                    <br />
                    <asp:ValidationSummary runat="server" CssClass="text-danger" ValidationGroup="EditValidationControls" />
                    <asp:Panel runat="server" ID="pnlFund" Width="100%" Height="300px" ScrollBars="Vertical">
                        <asp:GridView ID="gvUserInfo" runat="server" AutoGenerateColumns="False"
                            Width="95%" CssClass="gridView" AllowSorting="true"
                            GridLines="None" EnableTheming="True"
                            OnRowCancelingEdit="gvUserInfo_RowCancelingEdit"
                            OnRowEditing="gvUserInfo_RowEditing"
                            OnRowUpdating="gvUserInfo_RowUpdating"
                            OnSorting="gvUserInfo_Sorting"
                            OnRowDataBound="gvUserInfo_RowDataBound"
                            OnRowDeleting="gvUserInfo_RowDeleting">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField Visible="false" HeaderText="User Id">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserId" runat="Server" Text='<%# Eval("userid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="First Name" SortExpression="Fname">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFName" runat="Server" Text='<%# Eval("Fname") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFirstName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Fname") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName"
                                            CssClass="text-danger" ErrorMessage="The First Name field is required." ValidationGroup="EditValidationControls" Display="None" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Name" SortExpression="Lname">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLName" runat="Server" Text='<%# Eval("Lname") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtLastName" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("Lname") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName"
                                            CssClass="text-danger" ErrorMessage="The Last Name field is required." ValidationGroup="EditValidationControls" Display="None" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email" SortExpression="email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="Server" Text='<%# Eval("email") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtEmail" CssClass="clsTextBoxBlueSm" TextMode="Email" Text='<%# Eval("email") %>' />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                            CssClass="text-danger" ErrorMessage="The email field is required." ValidationGroup="EditValidationControls" Display="None" />
                                        <asp:RegularExpressionValidator ID="validateEmail"
                                            runat="server" ErrorMessage="The email field is invalid."
                                            ControlToValidate="txtEmail"
                                            ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ValidationGroup="EditValidationControls" Display="None" />

                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Password" SortExpression="password">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPassword" runat="Server" Text='<%# Eval("password") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPassword" runat="Server" CssClass="clsTextBoxBlueSm" Text='<%# Eval("password") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                                            CssClass="text-danger" ErrorMessage="The password field is required." ValidationGroup="EditValidationControls" Display="None" />
                                        <%-- <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                            CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />--%>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" ValidationGroup="EditValidationControls" />
                            </Columns>
                            <FooterStyle CssClass="footerStyle" />
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
