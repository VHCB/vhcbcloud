<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="MilestonesQuickentry.aspx.cs" Inherits="vhcbcloud.MilestonesQuickentry"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs">
                    </ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdBtnSelection" runat="server" Width="150px" AutoPostBack="True" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="rdBtnSelection_SelectedIndexChanged">
                                    <asp:ListItem>New    </asp:ListItem>
                                    <asp:ListItem Selected="True">Existing</asp:ListItem>
                                </asp:RadioButtonList></td>
                            <td style="text-align: right;">
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script language="javascript">
    </script>
</asp:Content>
