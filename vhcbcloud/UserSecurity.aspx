<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserSecurity.aspx.cs" Inherits="vhcbcloud.UserSecurity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="jumbotron clearfix" id="vhcb">
                <p class="lead">User Security </p>
                <div class="container">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rdBtnSelection" class="mySelect" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal" onclick="needToConfirm = true;"
                                            OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                            <asp:ListItem Selected="True">New&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    </asp:ListItem>
                                            <asp:ListItem>Existing</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="panel-width">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 10%; float: left"><span class="labelClass">User Name :</span></td>
                                        <td style="width: 30%; float: left">
                                            <asp:DropDownList ID="ddlUserName" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;"
                                                OnSelectedIndexChanged="ddlUserName_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                        <td style="width: 20%; float: left"><span class="labelClass">Default Security Group :</span></td>
                                        <td style="float: left">
                                            <asp:DropDownList ID="ddlSecurityGroup" CssClass="clsDropDown" AutoPostBack="true" runat="server" onclick="needToConfirm = false;"
                                                OnSelectedIndexChanged="ddlSecurityGroup_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td style="float: left" colspan="2">&nbsp;&nbsp;</td>
                                        <td style="width: 20%; float: left">&nbsp;</td>
                                        <td style="float: left">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="float: left" colspan="2">
                                            <asp:Button ID="btnTransactionSubmit" runat="server" class="btn btn-info" OnClick="btnTransactionSubmit_Click" OnClientClick="needToConfirm = false;" TabIndex="6" Text="Submit" />
                                        </td>
                                        <td style="width: 10%; float: left">&nbsp;</td>
                                        <td style="float: left">&nbsp;</td>
                                    </tr>

                                </table>

                                <br />

                                <p class="lblErrMsg">
                                    <asp:Label runat="server" ID="lblErrorMsg" Font-Size="Small"></asp:Label>
                                </p>
                                <asp:GridView ID="gvUserSec" runat="server" AutoGenerateColumns="False"
                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvUserSec_RowCancelingEdit" OnRowEditing="gvUserSec_RowEditing"
                                    OnRowUpdating="gvUserSec_RowUpdating" OnRowDeleting="gvUserSec_RowDeleting" OnSelectedIndexChanged="gvUserSec_SelectedIndexChanged" OnRowCreated="gvUserSec_RowCreated" TabIndex="7">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select" >
                                            <ItemTemplate >
                                                <asp:RadioButton ID="rdBtnSelectDetail" class="show" runat="server" onclick="RadioCheck(this);" AutoPostBack="true"
                                                    OnCheckedChanged="rdBtnSelectDetail_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("userid")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UserId" SortExpression="UserId" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lbluserid" runat="Server" Text='<%# Eval("userid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="usergroupid" SortExpression="usergroupid" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblusergroupid" runat="Server" Text='<%# Eval("usergroupid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="User Name" SortExpression="name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUserName" runat="Server" Text='<%# Eval("name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="User Group Name" SortExpression="usergroupname">
                                            <ItemTemplate>
                                                <asp:Label ID="lblusergroupname" runat="Server" Text='<%# Eval("usergroupname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowDeleteButton="True" />
                                    </Columns>
                                </asp:GridView>
                                <br />

                                <asp:Panel ID="pnlHide" runat="server" Visible="false">
                                    <div class="panel-width">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <asp:Label runat="server" ID="lblTransDetHeader" Text="Page Security"></asp:Label>
                                            </div>
                                            <div class="panel-body">
                                                <table style="width: 90%">
                                                    <tr>
                                                        <td style="width: 10%; float: left"><span class="labelClass">Page :</span></td>
                                                        <td style="width: 20%; float: left">
                                                            <asp:DropDownList ID="ddlPage" runat="server" AutoPostBack="true" CssClass="clsDropDown" onclick="needToConfirm = false;">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 10%; float: left"><span style="visibility:hidden" class="labelClass">Field :</span></td>
                                                        <td style="width: 20%; float: left">
                                                            <asp:DropDownList ID="ddlField" runat="server" AutoPostBack="true" CssClass="clsDropDown" onclick="needToConfirm = false;" Visible="False">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 10%; float: left"><span class="labelClass">Action :</span></td>
                                                        <td style="width: 20%; float: left">
                                                            <asp:DropDownList ID="ddlAction" runat="server" AutoPostBack="true" CssClass="clsDropDown" onclick="needToConfirm = false;">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" style="float: left">&nbsp;&nbsp;</td>
                                                        <td style="width: 20%; float: left">&nbsp;</td>
                                                        <td style="float: left">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" style="float: left">
                                                            <asp:Button ID="btnPageSecurity" runat="server" class="btn btn-info" TabIndex="6" Text="Submit" OnClick="btnPageSecurity_Click" />
                                                        </td>
                                                        <td style="width: 10%; float: left">&nbsp;</td>
                                                        <td style="float: left">&nbsp;</td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <asp:GridView ID="gvPageSecurity" runat="server" AutoGenerateColumns="False"
                                                    Width="90%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                                    GridLines="None" EnableTheming="True" OnRowDeleting="gvPageSecurity_RowDeleting" TabIndex="7">
                                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                                    <HeaderStyle CssClass="headerStyle" />
                                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                                    <RowStyle CssClass="rowStyle" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="pagesecurityid" SortExpression="pagesecurityid" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblpagesecurityid" runat="Server" Text='<%# Eval("pagesecurityid") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="UserId" SortExpression="userid" Visible="false">
                                                             <ItemTemplate>
                                                                <asp:Label ID="lbluserid" runat="Server" Text='<%# Eval("userid") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="User Name" SortExpression="username">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUser" runat="Server" Text='<%# Eval("username") %>' />
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
                            </div>
                        </div>
                    </div>

                </div>
            </div>
             <asp:HiddenField ID="hfUserId" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvUserSec.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
    </script>
</asp:Content>
