<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SetTemporaryProjectToActive.aspx.cs" Inherits="vhcbcloud.SetTemporaryProjectToActive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" language="javascript">
        function CheckAllEmp(Checkbox) {
            var GridVwHeaderChckbox = document.getElementById("<%=gvProjects.ClientID %>");
            for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                GridVwHeaderChckbox.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
            }
        }
    </script>
    <div class="jumbotron">
        <p class="lead">Set Temporary Project To Active</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">
                        
                        <table style="width: 60%;">
                            <tr>
                                <td style="height: 30px; width: 139px;">
                                    <span class="labelClass">Select Program</span>
                                </td>
                                <td style="height: 30px">
                                     <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged" style="margin-left: 0">
                                            </asp:DropDownList>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px">
                                    <span class="labelClass"></span>
                                </td>
                            </tr>
                           
                          
                        </table>
                        <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="false" Width="50%" CssClass="gridView"
                            DataKeyNames="TempUserID" OnRowDataBound="gvProjects_RowDataBound">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <FooterStyle CssClass="footerStyleTotals" />
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="5px">
                                    <HeaderTemplate>
                                        &nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkboxSelectAll" runat="server" onclick="CheckAllEmp(this);" />
                                    </HeaderTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkTrans" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="80px" DataField="ProjectNumber" HeaderText="Project #" />
                            </Columns>
                        </asp:GridView>
                        &nbsp;&nbsp;&nbsp;
                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>
                         <br />
                        &nbsp;&nbsp;&nbsp;<asp:Button ID="btnTranSubmit" runat="server" class="btn btn-info" OnClick="btnTranSubmit_Click" Visible="false" OnClientClick="needToConfirm = false;"
                            Text="Submit" ValidationGroup="Date" />
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>