<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Boarddates.aspx.cs" Inherits="vhcbcloud.Boarddates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Board Dates</p>
        <p>
            <span class="labelClass">Board Date :</span>
            <asp:TextBox ID="txtBDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <ajaxToolkit:CalendarExtender runat="server" ID="aceBoardDate" TargetControlID ="txtBdate"></ajaxToolkit:CalendarExtender>
            <span class="labelClass">Meeting Type :</span>
            <asp:TextBox ID="txtMType" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="rfvLname" runat="server" ErrorMessage="Board Date required" CssClass="lblErrMsg" ControlToValidate="txtLName"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="Meeting type required" CssClass="lblErrMsg" ControlToValidate="txtFName"></asp:RequiredFieldValidator>

            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>

        <p>
            <asp:GridView ID="gvBoardDates" runat="server" AutoGenerateColumns="False" DataKeyNames="TypeId"
                Width="90%" CssClass="gridView" PageSize="15" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True">
                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyle" />
                <Columns>
                    <asp:BoundField DataField="TypeId" HeaderText="Type ID" ReadOnly="True" Visible="false" />
                    <asp:BoundField DataField="Boarddate" HeaderText="Board Date" ReadOnly="True" />
                    <asp:BoundField DataField="MeetingType" HeaderText="Meeting Type" ReadOnly="True" />
                </Columns>
                <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
        </p>
    </div>
</asp:Content>
