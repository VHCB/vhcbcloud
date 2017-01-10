<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SiteWithoutHeader.Master" CodeBehind="ProjectNotes.aspx.cs"
    Inherits="vhcbcloud.ProjectNotes" %>


<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">

                <table style="width: 100%;">
                    <tr>
                        <td><b>Project Notes</b></td>
                        <td style="text-align: right">
                            <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                        </td>
                    </tr>
                </table>
            </div>

            <div id="dvMessage" runat="server">
                <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg1"></asp:Label></p>
            </div>
            <div class="panel-body">
                <asp:Panel runat="server" ID="pnlProjectInfo">
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Number</span></td>
                            <td>
                                <%--<asp:DropDownList ID="ddlProject" CssClass="clsDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged">
                                </asp:DropDownList>--%>
                                <asp:TextBox ID="txtProjectDDL" CssClass="clsTextBoxBlueSm" Width="100px" Height="22px" runat="server"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProjectDDL" MinimumPrefixLength="1"
                                    EnableCaching="true" CompletionSetCount="1"
                                    CompletionInterval="100" ServiceMethod="GetProjectNumbersWithName" OnClientItemSelected="GetProjectName">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                            <td>
                                <span class="labelClass">Name</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProjectName" CssClass="clsTextBoxBlue1" runat="server" Width="229px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Category</span></td>
                            <td>

                                <asp:DropDownList ID="ddlCategory" CssClass="clsDropDown" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <span class="labelClass">Date</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProjectNotesDate" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtProjectNotesDate" TargetControlID="txtProjectNotesDate">
                                </ajaxToolkit:CalendarExtender>
                                &nbsp;<span class="labelClass">Active</span>
                                <asp:CheckBox ID="cbActive" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Notes</span></td>
                            <td colspan="3">
                                <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="480px" Height="80px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">URL</span></td>
                            <td colspan="3">
                                <asp:TextBox ID="txtURL" CssClass="clsTextBoxBlue1" runat="server" Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 5px"></td>
                        </tr>

                        <tr>
                            <td><span id="spnPCR" runat="server" class="labelClass">Project Check Request</span></td>
                            <td colspan="3">
                                <asp:CheckBox ID="chkPCR" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" /></td>
                        </tr>

                        <tr>
                            <td colspan="4" style="height: 5px">
                                <br />
                                <asp:Button ID="btnSubmitNotes" runat="server" class="btn btn-info" OnClick="btnSubmitNotes_Click" Text="Submit" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div class="panel-body" id="dvProjectNotesGrid" runat="server">
                                    <br />
                                    <asp:Panel runat="server" ID="Panel9" Width="100%" Height="200px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvProjectNotes" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true"
                                            OnRowCancelingEdit="gvProjectNotes_RowCancelingEdit" OnRowEditing="gvProjectNotes_RowEditing"
                                            OnRowDataBound="gvProjectNotes_RowDataBound" OnRowUpdating="gvProjectNotes_RowUpdating">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Project Notes ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProjectNotesID" runat="Server" Text='<%# Eval("ProjectNotesID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Page ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPageID" runat="Server" Text='<%# Eval("PageID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="Server" Text='<%# Eval("Date") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Category">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCategory" runat="Server" Text='<%# Eval("description") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="User Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbluserName" runat="Server" Text='<%# Eval("username") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Notes">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNotes" runat="Server" ToolTip='<%# Eval("FullNotes") %>' Text='<%# Eval("Notes") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="URL">
                                                    <ItemTemplate>
                                                        <%--<asp:Label ID="lblURL" runat="Server" Text='<%# Eval("URL") %>' />--%>
                                                        <%--<asp:HyperLink ID="hlURL" runat="server"   NavigateUrl ='<%# Eval("URL").ToString() %>' Text="Link" />--%>
                                                        <a href='<%# Eval("URL") %>' runat="server" id="hlurl" target="_blank"><%# Eval("URLText") %></a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Active">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Edit" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%-- <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Update" Text="Update" />--%>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Cancel" Text="Cancel" />
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:Panel>
                                    <asp:HiddenField ID="hfProjectNotesId" runat="server" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>
    <script language="javascript">
        function GetProjectName(source, eventArgs) {
            $('#<%=txtProjectName.ClientID%>').val(eventArgs.get_value());
        }
    </script>
</asp:Content>
