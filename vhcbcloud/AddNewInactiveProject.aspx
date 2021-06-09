<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddNewInactiveProject.aspx.cs" Inherits="vhcbcloud.AddNewInactiveProject" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">New Inactive project</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">
                        
                        <table style="width: 60%;">
                            <tr>
                                <td style="height: 30px">
                                    <span class="labelClass">Project Number</span>
                                </td>
                                <td style="height: 30px"><span class="labelClass"><strong>9999-001-</strong></span>
                                    <asp:TextBox ID="txtprojectNumber" CssClass="clsTextBoxBlue1" runat="server" Width="72px" MaxLength="3"></asp:TextBox>
                                </td>
                                <td style="height: 30px"><span class="labelClass">Project Name</span></td>
                                <td style="height: 30px">
                                    <span class="labelClass"><strong>Viability Project</strong></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Login Name</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtLoginName" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px"></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Password</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtPassword" CssClass="clsTextBoxBlue1" runat="server" Width="132px"></asp:TextBox></td>
                                <td style="height: 30px">&nbsp;</td>
                                <td style="height: 30px">&nbsp;</td>
                            </tr>
                           <%-- <tr>
                                <td style="height: 30px"><span class="labelClass">Active</span></td>
                                <td style="height: 30px">
                                    <asp:CheckBox ID="cbActive" runat="server" Text="" Checked="false" Enabled="false" Visible="true" />
                                    &nbsp;</td>
                                <td style="height: 30px">&nbsp;</td>
                                <td style="height: 30px">&nbsp;</td>
                            </tr>--%>
                            <tr>
                                <td colspan="4" style="height: 50px">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                                &nbsp;&nbsp;
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-info" OnClick="btnClear_Click" /></td>
                            </tr>
                        </table>

                        &nbsp;&nbsp;&nbsp;
                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
