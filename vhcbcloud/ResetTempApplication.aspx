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
                                <td style="height: 30px; width: 70px;">
                                    <span class="labelClass">Project #:</span>
                                </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px">
                                    <span class="labelClass"></span>
                                </td>
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
