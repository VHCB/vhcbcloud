<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Americorps.aspx.cs" Inherits="vhcbcloud.Americorps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Americorps Members</p>
        <p>
            <span class="labelClass">Last Name :</span>
            <asp:TextBox ID="txtLName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <%--<asp:RequiredFieldValidator ID="rfvLname" runat="server" ErrorMessage="Last name required" CssClass="lblErrMsg" ControlToValidate="txtLName"></asp:RequiredFieldValidator>--%>
            <br />
            <span class="labelClass">First Name :</span>
            <asp:TextBox ID="txtFName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <%--<asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="First name required" CssClass="lblErrMsg" ControlToValidate="txtFName"></asp:RequiredFieldValidator>--%>
            <br />
            <span class="labelClass">Applicant :</span>
            <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDownLong" runat="server">
            </asp:DropDownList>
            <br />
            <br />
            <asp:LinkButton ID="btnSubmit" runat="server" class="btn btn-info" Text="Add new americorps member" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
        </p>

        <p>
            <asp:Panel runat="server" ID="Panel1" Width="100%" Height="350px" ScrollBars="Vertical">
                <asp:GridView ID="gvAmeriCorps" runat="server" AutoGenerateColumns="False" DataKeyNames="ContactId"
                    Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast" AllowSorting="true"
                    GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvAmeriCorps_RowCancelingEdit" OnRowEditing="gvAmeriCorps_RowEditing" OnRowUpdating="gvAmeriCorps_RowUpdating" OnPageIndexChanging="gvAmeriCorps_PageIndexChanging" OnRowDataBound="gvAmeriCorps_RowDataBound" OnSorting="gvAmeriCorps_Sorting">
                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                    <HeaderStyle CssClass="headerStyle" />
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                    <RowStyle CssClass="rowStyle" />
                    <Columns>
                        <asp:TemplateField HeaderText="First Name" SortExpression="firstname">
                            <ItemTemplate>
                                <asp:Label ID="lblFName" runat="Server" Text='<%# Eval("FirstName") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("FirstName") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Name" SortExpression="lastname">
                            <ItemTemplate>
                                <asp:Label ID="lbllName" runat="Server" Text='<%# Eval("LastName") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("LastName") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Applicant Name" SortExpression="applicantname">
                            <ItemTemplate>
                                <asp:Label ID="lblapplName" runat="Server" Text='<%# Eval("Applicantname") %>' />
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact ID" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblcontId" runat="Server" Text='<%# Eval("ContactId") %>' />
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" />
                    </Columns>
                    <FooterStyle CssClass="footerStyle" />
                </asp:GridView>
            </asp:Panel>
        </p>
    </div>
</asp:Content>
