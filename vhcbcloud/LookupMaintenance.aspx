<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="LookupMaintenance.aspx.cs" Inherits="vhcbcloud.LookupMaintenance" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="jumbotron">
    <p class="lead">Lookup Maintenance</p>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 80px"><span class="labelClass">View name :</span></td>
                        <td style="width: 233px">
                            <asp:DropDownList ID="ddlLkLookupViewname" CssClass="clsDropDownLong" runat="server"
                                OnSelectedIndexChanged="ddlLkLookupViewname_SelectedIndexChanged" AutoPostBack="true" Style="margin-left: 0">
                            </asp:DropDownList></td>
                        <td style="width: 120px"><span class="labelClass">New description :</span></td>
                        <td style="width: 150px">
                            <asp:TextBox ID="txtDescription" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox></td>
                        <td style="text-align: right">
                            <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                        </td>
                    </tr>
                </table>

                <%--&nbsp;<asp:ImageButton ID="imgSearch" runat="server" Height="25px" ImageUrl="~/Images/image004.png" Width="25px" OnClick="imgSearch_Click" />--%>
                <div class="panel-body">
                    <p>
                        <br />
                        <asp:GridView ID="gvLkDescription" runat="server" AutoGenerateColumns="False"
                            Width="90%" CssClass="gridView"
                            GridLines="None" EnableTheming="True" OnRowCancelingEdit="gvLkDescription_RowCancelingEdit"
                            OnRowEditing="gvLkDescription_RowEditing" OnRowUpdating="gvLkDescription_RowUpdating">
                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                            <HeaderStyle CssClass="headerStyle" />
                            <RowStyle CssClass="rowStyle" />
                            <Columns>
                                <asp:TemplateField HeaderText="RecordID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRecordId" runat="Server" Text='<%# Eval("RecordID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lbllkDesc" runat="Server" Text='<%# Eval("LKDescription") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtlkDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("LKDescription") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tiered" SortExpression="tiered">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkStandard" Enabled="false" runat="server" Checked='<%# Eval("tiered") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkStandardEdit" runat="server" Checked='<%# Eval("tiered") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Active" SortExpression="RowIsActive">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" />
                            </Columns>
                        </asp:GridView>
                        <%--<asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="Description is required" CssClass="lblErrMsg" ControlToValidate="txtDescription"></asp:RequiredFieldValidator>--%>
                        <br />
                        <%--<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />--%>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                    </p>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
                    </p>
                </div>
            </div>
            <div class="panel-body">
                <asp:Panel ID="Panel1" runat="server" Height="350px" ScrollBars="Vertical" Width="100%">
                    <asp:GridView ID="gvLookup" runat="server" AllowPaging="false" AllowSorting="true" AutoGenerateColumns="False" CssClass="gridView" EnableTheming="True" GridLines="None" OnPageIndexChanging="gvLookup_PageIndexChanging" OnRowCancelingEdit="gvLookup_RowCancelingEdit" OnRowDataBound="gvLookup_RowDataBound" OnRowEditing="gvLookup_RowEditing" OnRowUpdating="gvLookup_RowUpdating" OnSorting="gvLookup_Sorting" PagerSettings-Mode="NextPreviousFirstLast" PageSize="50" Width="90%">
                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                        <HeaderStyle CssClass="headerStyle" />
                        <PagerSettings FirstPageText="&amp;lt;" LastPageText="&amp;gt;" Mode="NumericFirstLast" PageButtonCount="5" />
                        <RowStyle CssClass="rowStyle" />
                        <Columns>
                            <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" OnCheckedChanged="rdBtnSelect_CheckedChanged" onclick="RadioCheck(this);" />
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("typeid")%>' />
                                    <asp:HiddenField ID="hfTier1Desc" runat="server" Value='<%#Eval("description")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type ID" SortExpression="typeid">
                                <ItemTemplate>
                                    <asp:Label ID="lbltypeid" runat="Server" Text='<%# Eval("typeid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View name" SortExpression="Viewname">
                                <ItemTemplate>
                                    <asp:Label ID="lblViewname" runat="Server" Text='<%# Eval("Viewname") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" SortExpression="description">
                                <ItemTemplate>
                                    <asp:Label ID="lbldesc" runat="Server" Text='<%# Eval("description") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("description") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Active" SortExpression="RowIsActive">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' Enabled="false" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Record ID" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecordId" runat="Server" Text='<%# Eval("recordId") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
            <div class="panel-heading">
                <asp:Panel ID="pnlAddSubTier" Visible="false" runat="server">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 136px"><span class="labelClass">Tier1 Description :</span></td>
                            <td style="width: 233px">
                                <asp:TextBox ID="txtTier1Desc" CssClass="clsTextBoxBlueSMDL" runat="server" Enabled="False"></asp:TextBox></td>
                            <td style="width: 120px"><span class="labelClass">New description :</span></td>
                            <td style="width: 150px">
                                <asp:TextBox ID="txtTier2Desc" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
                    <asp:Button ID="btnAddSubTier" runat="server" Text="Submit" class="btn btn-info" OnClick="btnAddSubTier_Click" />
                    <div class="panel-body">
                        <asp:Panel runat="server" ID="Panel2" Width="100%" Height="350px" ScrollBars="Vertical">
                            <asp:GridView ID="gvTier" runat="server" AutoGenerateColumns="False"
                                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" OnRowDeleting="gvTier_RowDeleting">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>

                                    <asp:TemplateField HeaderText="Sub Type ID" SortExpression="subtypeid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubtypeid" runat="Server" Text='<%# Eval("subtypeid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type ID" SortExpression="typeid">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltypeid" runat="Server" Text='<%# Eval("typeid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tier1 Description" SortExpression="description">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldesc" runat="Server" Text='<%# Eval("description") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("description") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tier2 Description" SortExpression="subdescription">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubdesc" runat="Server" Text='<%# Eval("subdescription") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSubDesc" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("subdescription") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Active" SortExpression="RowIsActive">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chkActiveEdit" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:CommandField ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </div>
                    <p>
                    </p>
                    <p>
                    </p>
                    
                </asp:Panel>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfLkpId" runat="server" />
    <asp:HiddenField ID="hfTier1Desc" runat="server" />
</div>

<script type="text/javascript">

    function RadioCheck(rb) {
        var gv = document.getElementById("<%=gvLookup.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
</script>
</asp:Content>
