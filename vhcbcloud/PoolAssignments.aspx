<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PoolAssignments.aspx.cs" Inherits="vhcbcloud.PoolAssignments"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>


<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Pool Assignments</p>
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
                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div id="dvProject" runat="server">
                    <table>
                        <tr>
                            <td colspan="6" style="height: 10px"></td>
                        </tr>
                        <tr>
                            <td style="width: 10px"></td>
                            <td style="width: 60px"><span class="labelClass">Project #</span></td>
                            <td style="width: 150px">
                                <asp:TextBox ID="txtProjectNumDDL" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"
                                    ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProjectNumDDL" MinimumPrefixLength="1"
                                    EnableCaching="true" CompletionSetCount="1"
                                    CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                            <td style="width: 80px"><span class="labelClass" runat="server" id="lblProjName" visible="false">Project Name:</span></td>
                            <td style="width: 270px">
                                <span class="labelClass" id="txtProjName" runat="server" visible="false"></span>
                            </td>
                            <td style="width: 50px">
                                <asp:CheckBox ID="cbPooled" runat="server" Text="Pool" Checked="true" Enabled="false" Visible="false" />
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="Add" class="btn btn-info" Visible="false"
                                    OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>
                <div class="panel-body" id="dvPoolsGrid" runat="server">
                    <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                        <asp:GridView ID="gvPool" runat="server" AutoGenerateColumns="False"
                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                            GridLines="None" EnableTheming="True" AllowPaging="false"
                            OnRowEditing="gvPool_RowEditing"
                            OnRowCancelingEdit="gvPool_RowCancelingEdit"
                             OnRowDeleting="gvPool_RowDeleting">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                 <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" HeaderText="ProjectId">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprojectid" runat="Server" Text='<%# Eval("projectid") %>' />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Project#" Visible="true">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProjectNumber" runat="Server" Text='<%# Eval("proj_num") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Project Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNoteAmt" runat="Server" Text='<%# Eval("project_name") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDelete" runat="server" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </div>
            <asp:HiddenField ID="hfProjectId" runat="server" />
        </div>
    </div>
</asp:Content>
