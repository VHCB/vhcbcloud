<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="vhcbcloud.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your contact page.</h3>
    <address>
        58 East State Street<br />
        Montpelier, VT 05602<br />
        <abbr title="Phone">Phone:</abbr>
        802.828.3250<br />
        <abbr title="Email">Email:</abbr>
        <a href="mailto:Support@example.com">info@vhcb.org</a>
    </address>

    <address>
        <strong>Support:</strong>   <a href="mailto:Support@example.com">Support@example.com</a><br />
    </address>
</asp:Content>
