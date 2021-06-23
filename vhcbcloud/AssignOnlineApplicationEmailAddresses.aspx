<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignOnlineApplicationEmailAddresses.aspx.cs" Inherits="vhcbcloud.AssignOnlineApplicationEmailAddresses" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Assign Online Application Email Addresses</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">

                        <table style="width: 60%;">
                            <tr>
                                <td style="height: 30px">
                                    <span class="labelClass">VHCB Program</span>
                                </td>
                                <td style="height: 30px" colspan="3">
                                    <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged"
                                        Style="margin-left: 0">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Application Type</span></td>
                                <td style="height: 30px" colspan="3">
                                    <asp:DropDownList ID="ddlApplicationType" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged ="ddlApplicationType_SelectedIndexChanged"
                                        Style="margin-left: 0">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Name 1</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtName1" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass">Email</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtEmail1" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Name 2</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtName2" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass">Email</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtEmail2" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Name 3</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtName3" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass">Email</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtEmail3" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Name 4</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtName4" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass">Email</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtEmail4" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Name 5</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtName5" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass">Email</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtEmail5" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Name 6</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtName6" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass">Email</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtEmail6" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                            </tr>
                        </table>
                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>
                        <br />
                       <asp:Button ID="btnSubmit" runat="server" class="btn btn-info" OnClick="btnSubmit_Click" Visible="true"
                            Text="Submit" />&nbsp;&nbsp;&nbsp;
                          <asp:Button ID="btnClear" runat="server" class="btn btn-info" OnClick="btnClear_Click" Visible="true"
                            Text="Clear" />
                    </div>
                </div>

            </div>
        </div>
    </div>
    </div>
</asp:Content>
