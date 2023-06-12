<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetTempApplication.aspx.cs" Inherits="vhcbcloud.ResetTempApplication" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" language="javascript">
      
    </script>
    <div class="jumbotron">
        <p class="lead">Reset Temp Application in TempUser</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">
                        
                        <table style="width: 60%;">
                            <tr>
                                <td style="height: 30px; width: 105px;">
                                    <span class="labelClass">Project #:</span>
                                </td>
                                <td style="height: 30px">
                                    <%--<asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>--%>
                                     <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"
                                                ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px">
                                    <span class="labelClass"></span>
                                </td>
                            </tr>
                            <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td style="width: 105px"><span class="labelClass">Year</span></td>
                            <td>
                                <asp:DropDownList ID="ddlyear" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlyear_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="3" style="height: 5px"></td>
                        </tr>
                          <tr>
                            <td style="width: 105px"><span class="labelClass">Portfolio Type</span>&nbsp;</td>
                            <td>
                                 <asp:DropDownList ID="ddlPortfolioType" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                       
                        <tr>
                            <td colspan="2" style="height: 5px"></td>
                        </tr>
                        </table>
                      
                        &nbsp;&nbsp;&nbsp;
                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>
                         <br />
                        &nbsp;&nbsp;&nbsp;<asp:Button ID="btnSubmit" runat="server" class="btn btn-info" OnClick="btnSubmit_Click" Text="Submit"  />
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
