<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Boarddates.aspx.cs" Inherits="vhcbcloud.Boarddates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Board Dates</p>
        <p>
            <span class="labelClass">Board Date :</span>
            <asp:TextBox ID="txtBDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <ajaxToolkit:CalendarExtender runat="server" ID="aceBoardDate" TargetControlID="txtBdate"></ajaxToolkit:CalendarExtender>
            <span class="labelClass">Meeting Type :</span>
            <asp:TextBox ID="txtMType" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
            <br />
            <%--<asp:RequiredFieldValidator ID="rfvBDate" runat="server" ErrorMessage="Board Date required" CssClass="lblErrMsg" ControlToValidate="txtBDate"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvMType" runat="server" ErrorMessage="Meeting type required" CssClass="lblErrMsg" ControlToValidate="txtMType"></asp:RequiredFieldValidator>--%>

            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
        </p>
        <p class="lblErrMsg">
            <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
        </p>

        <p>
            <asp:GridView ID="gvBoardDates" runat="server" AutoGenerateColumns="False" DataKeyNames="TypeId"
                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvBoardDates_RowCancelingEdit" AllowSorting="true"
                 OnRowEditing="gvBoardDates_RowEditing" OnRowUpdating="gvBoardDates_RowUpdating" OnRowDataBound="gvBoardDates_RowDataBound" OnSorting="gvBoardDates_Sorting" OnPageIndexChanging="gvBoardDates_PageIndexChanging">
                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyle" />
                <Columns>
                    <asp:TemplateField HeaderText="Board Date" SortExpression="Boarddate">
                        <ItemTemplate>
                            <asp:Label ID="lblBDate" runat="Server" Text='<%# Eval("Boarddate", "{0:M-dd-yyyy}") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtBoardDate" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("Boarddate", "{0:MM-dd-yyyy}") %>'></asp:TextBox>
                            <ajaxToolkit:CalendarExtender runat="server" ID="acebdt" TargetControlID="txtBoardDate"></ajaxToolkit:CalendarExtender>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Meeting Type" SortExpression="meetingtype">
                        <ItemTemplate>
                            <asp:Label ID="lblMeettype" runat="Server" Text='<%# Eval("MeetingType") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMeetType" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("MeetingType") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type ID" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblTypeId" runat="Server" Text='<%# Eval("TypeId") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="typeId" HeaderText="type ID" ReadOnly="True" Visible="false" SortExpression="typeid" />
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
                <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
        </p>
    </div>
</asp:Content>
