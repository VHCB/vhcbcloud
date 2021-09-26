<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"  CodeBehind="GetAddressFromGoogleAPI.aspx.cs" Inherits="vhcbcloud.GetAddressFromGoogleAPI" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="jumbotron clearfix" id="vhcb">
                <p class="lead">Update Lat Long</p>
                 <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
                <div class="panel-body" id="pnlReallocateFrom" runat="server">
                    <table style="width: 100%" class="">
                        <tr>
                            <td style="width: 17%; float: left"><span class="labelClass"></span></td>
                            <td style="width: 20%; float: left">
                              
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                       
                        <tr>
                            <td style="width: 17%; float: left">&nbsp;</td>
                            <td style="width: 20%; float: left">
                              
                            </td>
                        </tr>
                    </table>
                    <br />
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblRErrorMsg" Font-Size="Small"></asp:Label>
                    </p>

                </div>
                <asp:HiddenField ID="hfUserId" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

