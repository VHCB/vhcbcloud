<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="HUC12.aspx.cs" Inherits="vhcbcloud.HUC12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">HUC12 Maintenance</p>

        <div class="container">
            <div class="panel panel-default">
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
                <div class="panel-width" runat="server" id="dvNewHUC12">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">HUC12 </h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHUC12" runat="server" Text="Add New HUC12" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvNewHUC12Form">
                            <asp:Panel runat="server" ID="Panel5">
                                <table style="width: 60%">
                                    <tr>
                                        <td><span class="labelClass">HUC12</span></td>
                                        <td>
                                            <asp:TextBox ID="txtHUC12" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <span class="labelClass">Name</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Button ID="btnAddHUC12" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddHUC12_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                </table>
                            </asp:Panel>
                        </div>

                         <div class="panel-body" id="dvHUC12Grid" runat="server">
                            <asp:Panel runat="server" ID="Panel6" Width="100%" Height="500px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHUC12" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                    OnRowEditing="gvHUC12_RowEditing" 
                                    OnRowUpdating="gvHUC12_RowUpdating"
                                    OnRowCancelingEdit="gvHUC12_RowCancelingEdit">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HUCID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHUCID" runat="Server" Text='<%# Eval("HUCID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:TemplateField HeaderText="HUC12">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHUC12" runat="Server" Text='<%# Eval("HUC12") %>' />
                                            </ItemTemplate>
                                             <EditItemTemplate>
                                                  <asp:TextBox ID="txtHUC12" runat="Server" CssClass="clsTextBoxBlue1" Text='<%# Eval("HUC12") %>'>
                                                </asp:TextBox>
                                                 </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="Server" Text='<%# Eval("Name") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtName" runat="Server" CssClass="clsTextBoxBlue1" Text='<%# Eval("Name") %>'>
                                                </asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="HUC12Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHUC12Name" runat="Server" Text='<%# Eval("HUC12Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script language="javascript">
        $(document).ready(function () {

            $('#<%= dvNewHUC12Form.ClientID%>').toggle($('#<%= cbAddHUC12.ClientID%>').is(':checked'));

            $('#<%= cbAddHUC12.ClientID%>').click(function () {
                $('#<%= dvNewHUC12Form.ClientID%>').toggle(this.checked);
            }).change();
        });
    </script>
</asp:Content>
