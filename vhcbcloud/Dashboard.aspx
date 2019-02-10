<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" 
    CodeBehind="Dashboard.aspx.cs" Inherits="vhcbcloud.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="jumbotron clearfix" id="vhcb">
                <p class="lead">Dashboard</p>
                 <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
                <div class="panel-body" id="pnlReallocateFrom" runat="server">
                    <table style="width: 100%" class="">
                        <tr>
                            <td style="width: 17%; float: left"><span class="labelClass">Dashboard Name</span></td>
                            <td style="width: 20%; float: left">
                                <asp:DropDownList ID="ddlDashBoard" CssClass="clsDropDown" runat="server" Width="251px" >
                                        </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px" colspan="6" />
                        </tr>
                       
                        <tr>
                            <td style="width: 17%; float: left">&nbsp;</td>
                            <td style="width: 20%; float: left">
                               <asp:Button ID="btnSubmit" runat="server" Enabled="true" Text="Submit" 
                                   class="btn btn-info" OnClick="btnSubmit_Click" />
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
