<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EntitySearch.aspx.cs" Inherits="vhcbcloud.EntitySearch" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
     
    <div class="jumbotron">

        <table style="width: 100%;">
            <tr>
                <td>
                   <p class="lead">Entity (Organization / Individual) </p>
                </td>
            </tr>
        </table>

        <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes1"
            CancelControlID="btnClose" BackgroundCssClass="MEBackground">
        </ajaxToolkit:ModalPopupExtender>

        <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
            <iframe style="width: 750px; height: 550px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
            <br />
            <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
        </asp:Panel>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                             <td>
                                <asp:RadioButtonList ID="rdBtnAction1" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="rdBtnAction1_SelectedIndexChanged">
                                    <asp:ListItem Enabled="false">New</asp:ListItem>
                                    <asp:ListItem Selected="True">Existing</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="btnProjectNotes1" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;
                               
                                <asp:ImageButton ID="btnNewProject1" runat="server" ImageUrl="~/Images/NewProject.png" ToolTip="New Project"
                                    Text="New Project" Style="border: none; vertical-align: middle;" OnClientClick="window.location.href='ProjectMaintenance.aspx?type=new'; return false;" />
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="dvMessage" runat="server" visible="false">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div id="dvEntityRole" runat="server">
                    <table>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 100px"><span class="labelClass">Entity Role</span></td>
                            <td style="width: 170px">
                                <asp:DropDownList ID="ddlEntityRole" CssClass="clsDropDown" runat="server" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 100px"><span class="labelClass">Entity Name</span></td>
                            <td style="width: 170px">
                                <asp:TextBox ID="txtEntityName" CssClass="clsTextBoxBlue1" runat="server" Width="150px" Height="22px"></asp:TextBox>
                            </td>
                            <td style="width: 222px">
                                <asp:Button ID="btnEntitySearch" runat="server" Text="Search" class="btn btn-info" OnClick="btnEntitySearch_Click" />
                                &nbsp;&nbsp;<asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-info" OnClick="btnClear_Click" />
                            </td>
                            <td>
                                <asp:CheckBox ID="cbEntityActiveOnly" runat="server" Text="Active Only" Enabled="true" Checked="true" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>

                <div class="panel-body" id="dvOrgSearchResultsGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel9" Width="100%" Height="500px" ScrollBars="Vertical">
                        <asp:GridView ID="gvOrgSearchresults" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="false" OnRowCommand="gvOrgSearchresults_RowCommand">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="ApplicantId" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApplicantId" runat="Server" Text='<%# Eval("ApplicantId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntityRole" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntityRole" runat="Server" Text='<%# Eval("EntityRole") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Organization Name" SortExpression="ApplicantName" ItemStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApplicantName" runat="Server" Text='<%# Eval("ApplicantName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Name" SortExpression="Lastname" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLastname" runat="Server" Text='<%# Eval("Lastname") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="First Name" SortExpression="Firstname" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFirstname" runat="Server" Text='<%# Eval("Firstname") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Legal Structure" SortExpression="LegalStructure">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLegalStructure" runat="Server" Text='<%# Eval("LegalStructure") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Default Role" SortExpression="DefaultRole">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDefaultRole" runat="Server" Text='<%# Eval("DefaultRole") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Default Physical Address" SortExpression="PhysicalAddress">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAdress" runat="Server" ToolTip='<%# Eval("PhysicalAddress") %>' Text='<%# Eval("PhysicalAddress") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="AddButton" runat="server"
                                            CommandName="SelectProject"
                                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            Text="Select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                 <div class="panel-body" id="dvIndiSearchResultsGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel1" Width="100%" Height="500px" ScrollBars="Vertical">
                        <asp:GridView ID="gvIndSearchresults" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="false" OnRowCommand="gvIndSearchresults_RowCommand">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="ApplicantId" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApplicantId" runat="Server" Text='<%# Eval("ApplicantId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntityRole" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntityRole" runat="Server" Text='<%# Eval("EntityRole") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Acct #" SortExpression="AccountNo" ItemStyle-Width="50px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAccountNo" runat="Server" Text='<%# Eval("AccountNo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Name" SortExpression="Lastname" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLastname" runat="Server" Text='<%# Eval("Lastname") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="First Name" SortExpression="Firstname" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFirstname" runat="Server" Text='<%# Eval("Firstname") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Role" SortExpression="Role" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRole" runat="Server" Text='<%# Eval("Role") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Email" SortExpression="Email" ItemStyle-Width="200px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="Server" Text='<%# Eval("Email") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cell  Phone" SortExpression="CellPhone" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCellPhone" runat="Server" Text='<%# Eval("CellPhone") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Default Mailing Address" SortExpression="MailingAddress">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAdress" runat="Server" ToolTip='<%# Eval("MailingAddress") %>' Text='<%# Eval("MailingAddress") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="AddButton" runat="server"
                                            CommandName="SelectProject"
                                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            Text="Select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
