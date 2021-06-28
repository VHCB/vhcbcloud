<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateLeadSpecCosts.aspx.cs" Inherits="vhcbcloud.UpdateLeadSpecCosts" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Update Lead Spec Cost</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">

                        <table style="width: 60%;">
                            <tr>
                                <td style="height: 30px">
                                    <span class="labelClass">SpecTitles</span>
                                </td>
                                <td style="height: 30px" colspan="3">
                                    <asp:DropDownList ID="ddlSpecTitles" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSpecTitles_SelectedIndexChanged"
                                        Style="margin-left: 0">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 4px" colspan="6" />
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Spec Id</span></td>
                                <td style="height: 30px" colspan="3">
                                    <asp:Label ID="lblSpecId" class="labelClass" Text=" " runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 4px" colspan="6" />
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Unit Cost</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtCost" CssClass="clsTextBoxBlue1" runat="server" Width="80px"></asp:TextBox></td>
                                <td style="height: 30px"><span class="labelClass"></span></td>
                                <td style="height: 30px"></td>
                            </tr>
                            <tr>
                                <td style="height: 4px" colspan="6" />
                            </tr>

                        </table>
                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>
                        <br />
                        <asp:Button ID="btnUpdate" runat="server" class="btn btn-info" OnClick="btnUpdate_Click" Visible="true"
                            Text="Update" />&nbsp;&nbsp;&nbsp;
                          <asp:Button ID="btnClear" runat="server" class="btn btn-info" OnClick="btnClear_Click" Visible="true"
                              Text="Clear" />
                    </div>
                </div>

            </div>
        </div>
    </div>

     <script language="javascript">
        $(document).ready(function () {
           
             toCurrencyControl($('#<%= txtCost.ClientID%>').val(), $('#<%= txtCost.ClientID%>'));
             $('#<%= txtCost.ClientID%>').keyup(function () {
                toCurrencyControl($('#<%= txtCost.ClientID%>').val(), $('#<%= txtCost.ClientID%>'));
             });
        });
     </script>
</asp:Content>

