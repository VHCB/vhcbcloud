<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Fundingsource.aspx.cs" Inherits="vhcbcloud.Fundingsource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Funding Source</p>
        <p>

            <span class="labelClass">Name :</span>
            <asp:TextBox ID="txtFName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>

            <span class="labelClass">Abbreviation :</span>
            <asp:TextBox ID="txtAbbr" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="funding name required" CssClass="lblErrMsg" ControlToValidate="txtFName"></asp:RequiredFieldValidator>

            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
        </p>

        <p>
           
        </p>
    </div>
</asp:Content>
