<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardCommitment.aspx.cs" Inherits="vhcbcloud.BoardCommitment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">

        <p class="lead">VHCB Projects</p>
        <p>
            <span class="labelClass">Project # :</span>
            <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDownLong" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
            </asp:DropDownList>
            &nbsp;
            <asp:Label ID="lblProjNum" class="labelClass" Text="" runat="server"></asp:Label>
            &nbsp;
            <span class="labelClass">Grantee :</span>
            <asp:TextBox ID="txtGrantee" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox>
            <br />
            <span class="labelClass">Trans Date :</span>
            <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox>
            &nbsp;
             <span class="labelClass">Total Amount  $ :</span>
            <asp:TextBox ID="txtTotAmt" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox>
            &nbsp;
             <span class="labelClass">Status :</span>
            <asp:DropDownList ID="ddlStatus" CssClass="clsDropDownLong" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
            </asp:DropDownList>
        </p>
    </div>
</asp:Content>
