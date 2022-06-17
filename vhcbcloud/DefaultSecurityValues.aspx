<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="DefaultSecurityValues.aspx.cs" Inherits="vhcbcloud.DefaultSecurityValues"  MaintainScrollPositionOnPostback="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Manage User Info</p>
        <div class="container">

            <p>
                <asp:Label ID="lblErrorMsg" class="lblErrMsg" runat="server"></asp:Label>
            </p>

            <asp:Panel ID="pnlHide" runat="server" Visible="false">
                <div class="panel-width">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:Label ID="lblTransDetHeader" runat="server" Text="Page Security (Removing Access)"></asp:Label>
                        </div>
                        <div class="panel-body">
                            <table style="width: 90%">
                                <tr>
                                    <td style="width: 10%; float: left"><span class="labelClass">Page :</span></td>
                                    <td style="width: 20%; float: left">
                                        <asp:DropDownList ID="ddlPage" runat="server" CssClass="clsDropDown">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="float: left" colspan="3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="float: left">&nbsp;&nbsp;</td>
                                    <td style="width: 20%; float: left">&nbsp;</td>
                                    <td style="float: left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="float: left">
                                        <asp:Button ID="btnPageSecurity" runat="server" class="btn btn-info" OnClick="btnPageSecurity_Click" TabIndex="6" Text="Submit" CausesValidation="False" />
                                    </td>
                                    <td style="width: 10%; float: left">&nbsp;</td>
                                    <td style="float: left">&nbsp;</td>
                                </tr>
                            </table>
                            <br />
                            <asp:GridView ID="gvPageSecurity" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True"
                                GridLines="None" OnRowDeleting="gvPageSecurity_RowDeleting" PagerSettings-Mode="NextPreviousFirstLast" TabIndex="7" Width="100%" AllowSorting="true" 
                                OnSorting="gvPageSecurity_Sorting">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings FirstPageText="&amp;lt;" LastPageText="&amp;gt;" Mode="NumericFirstLast" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="DefPageTypeID" SortExpression="PageId" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDefPageTypeID" runat="Server" Text='<%# Eval("DefPageTypeID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                  
                                  
                                    <asp:TemplateField HeaderText="Page" SortExpression="PageDesc">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPage" runat="Server" Text='<%# Eval("pagedesc") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                            <br />
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <br />
            <asp:Panel ID="pnlSecFunctions" runat="server" Visible="false">
                <div class="panel-width">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:Label ID="Label1" runat="server" Text="Security Functions  (Allowing Access)"></asp:Label>
                        </div>
                        <div class="panel-body">
                            <table style="width: 90%">
                                <tr>
                                    <td style="width: 12%; float: left"><span class="labelClass">Security Function :</span></td>
                                    <td style="width: 20%; float: left">
                                        <asp:DropDownList ID="ddlSecFunctions" runat="server" CssClass="clsDropDown" onclick="needToConfirm = false;" Style="margin-left: 12">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="float: left" colspan="3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="float: left">&nbsp;&nbsp;</td>
                                    <td style="width: 20%; float: left">&nbsp;</td>
                                    <td style="float: left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="float: left">
                                        <asp:Button ID="btnSecFunctions" runat="server" class="btn btn-info" OnClick="btnSecFunctions_Click" TabIndex="6" Text="Submit" CausesValidation="False" />
                                    </td>
                                    <td style="width: 10%; float: left">&nbsp;</td>
                                    <td style="float: left">&nbsp;</td>
                                </tr>
                            </table>
                            <br />
                            <asp:GridView ID="gvSecFunctions" runat="server" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True"
                                GridLines="None" OnRowDeleting="gvSecFunctions_RowDeleting" PagerSettings-Mode="NextPreviousFirstLast" TabIndex="7" Width="100%" 
                                OnSorting="gvSecFunctions_Sorting" AllowSorting="true">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings FirstPageText="&amp;lt;" LastPageText="&amp;gt;" Mode="NumericFirstLast" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="UserFxnSecurityId" SortExpression="UserFxnSecurityId" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUserFxnSecurityId" runat="Server" Text='<%# Eval("UserFxnSecurityId") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   
                                   
                                    <asp:TemplateField HeaderText="Security Function" SortExpression="FxnSecurity">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFxnSecurity" runat="Server" Text='<%# Eval("FxnSecurity") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                            <br />
                        </div>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </div>
    <asp:HiddenField ID="hfUserId" runat="server" />

    <script type="text/javascript">
        $(document).ready(function () {
           
        });
    </script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/gridviewScroll.min.js"></script>

    <script language="javascript">
        $(document).ready(function () {
            
        });

       

        function gridviewScroll(gridId) {
            $(gridId).gridviewScroll({
                width: 981,
                height: 270
            });
        }
    </script>
</asp:Content>

