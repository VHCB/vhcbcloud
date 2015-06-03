<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Americorps.aspx.cs" Inherits="vhcbcloud.Americorps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Americorps Members</p>
        <p>
            <span class="labelClass">Last Name :</span>
            <asp:TextBox ID="txtLName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLname" runat="server" ErrorMessage="Last name required" CssClass="lblErrMsg" ControlToValidate="txtLName"></asp:RequiredFieldValidator>
            <br />
            <span class="labelClass">First Name :</span>
            <asp:TextBox ID="txtFName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="First name required" CssClass="lblErrMsg" ControlToValidate="txtFName"></asp:RequiredFieldValidator>
            <br />
            <span class="labelClass">Applicant :</span>
            <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDownLong" runat="server">
            </asp:DropDownList>
            <br />
            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg"><asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
        
        <p>
            <asp:GridView ID="gvAmeriCorps" runat="server" AutoGenerateColumns="False" DataKeyNames="ContactId"
                Width="90%" CssClass="gridView" PageSize="15" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True" >
                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyle" />
                <Columns>
                    <asp:BoundField DataField="ContactId" HeaderText="Contact ID" ReadOnly="True" Visible="false" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" ReadOnly="True" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" ReadOnly="True" />
                </Columns>
                <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
        </p>
    </div>
</asp:Content>
