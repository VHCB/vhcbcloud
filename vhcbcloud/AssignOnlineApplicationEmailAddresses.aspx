<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignOnlineApplicationEmailAddresses.aspx.cs" Inherits="vhcbcloud.AssignOnlineApplicationEmailAddresses" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
     

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">


                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>

                        <div class="panel-width" runat="server" id="dvNewEmail">
                            <div class="panel panel-default ">
                                <div class="panel-heading ">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Assign Online Application Email Addresses</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:CheckBox ID="cbAddEmail" runat="server" Text="Add New Email Address" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" runat="server" id="dvEmailForm">
                                    <asp:Panel runat="server" ID="Panel2">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="height: 30px; width: 112px;">
                                                    <span class="labelClass">VHCB Program</span>
                                                </td>
                                                <td style="height: 30px" colspan="3">
                                                    <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                        Style="margin-left: 0">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 30px; width: 112px;"><span class="labelClass">Application ID</span></td>
                                                <td style="height: 30px" colspan="3">
                                                    <asp:DropDownList ID="ddlApplicationType" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                                        Style="margin-left: 0">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 30px; width: 112px;"><span class="labelClass">Project Number</span></td>
                                                <td style="height: 30px" colspan="3">
                                                    <asp:TextBox ID="txtProjectNumber" CssClass="clsTextBoxBlue1" runat="server"  Width="133px" Height="22px"></asp:TextBox>
                                                    
                                    <ajaxToolkit:AutoCompleteExtender ID="ae_txtProjNum" runat="server" TargetControlID="txtProjectNumber"
                                        MinimumPrefixLength="1" UseContextKey="true"
                                        EnableCaching="true" CompletionSetCount="1"
                                        CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                    </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 30px; width: 112px;"><span class="labelClass">Name</span></td>
                                                <td style="height: 30px">
                                                    <asp:TextBox ID="txtName1" CssClass="clsTextBoxBlue1" runat="server" Width="133px" Height="22px"></asp:TextBox></td>
                                                <td style="height: 30px"><span class="labelClass"></span></td>
                                                <td style="height: 30px">
                                                   
                                            </tr>
                                             <tr>
                                                <td style="height: 30px; width: 112px;"><span class="labelClass">Email</span></td>
                                                <td style="height: 30px">
                                                    <asp:TextBox ID="txtEmail1" CssClass="clsTextBoxBlue1" runat="server" Width="133px" Height="22px"></asp:TextBox></td>
                                                <td style="height: 30px"></td>
                                                <td style="height: 30px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 30px; width: 112px;"><span class="labelClass">Active</span></td>
                                                <td style="height: 30px">
                                                    <asp:CheckBox ID="chkEmailActive" Enabled="false" runat="server" Checked="true" />

                                                </td>
                                                <td style="height: 30px"></td>
                                                <td style="height: 30px"></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 30px; width: 112px;"></td>
                                                <td colspan="3">

                                                    <asp:Button ID="btnSubmit" runat="server" class="btn btn-info" OnClick="btnSubmit_Click" Visible="true"
                                                        Text="Submit" />&nbsp;&nbsp;&nbsp;
                          <asp:Button ID="btnClear" runat="server" class="btn btn-info" OnClick="btnClear_Click" Visible="true"
                              Text="Clear" />
                                                </td>



                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                                <div class="panel-body" id="dvEmailGrid" runat="server">
                                    <asp:Panel runat="server" ID="Panel3" Width="100%" Height="200px" ScrollBars="Vertical">
                                        <asp:GridView ID="gvEmail" runat="server" AutoGenerateColumns="False"
                                            Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                            GridLines="None" EnableTheming="True" AllowPaging="false"
                                            OnRowEditing="gvEmail_RowEditing" OnRowCancelingEdit="gvEmail_RowCancelingEdit" OnRowDataBound="gvEmail_RowDataBound"
                                            OnSelectedIndexChanged="gvEmail_SelectedIndexChanged">
                                            <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                            <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                            <HeaderStyle CssClass="headerStyle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                            <RowStyle CssClass="rowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Email_AddressID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmail_AddressID" runat="Server" Text='<%# Eval("Email_AddressID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                              
                                                <asp:TemplateField HeaderText="Program">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProgramDesc" runat="Server" Text='<%# Eval("ProgramDesc") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Application ID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblApplicationDesc" runat="Server" Text='<%# Eval("ApplicationDesc") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                  <asp:TemplateField HeaderText="Project Number">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProj_num" runat="Server" Text='<%# Eval("Proj_num") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="Server" Text='<%# Eval("Name") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Email Address">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmailAddress" runat="Server" Text='<%# Eval("Email_Address") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Active">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
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

                        <asp:HiddenField ID="hfEmailAddressID" runat="server" />
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script language="javascript">
        $(document).ready(function () {


            $('#<%= dvEmailForm.ClientID%>').toggle($('#<%= cbAddEmail.ClientID%>').is(':checked'));
            $('#<%= cbAddEmail.ClientID%>').click(function () {
                $('#<%= dvEmailForm.ClientID%>').toggle(this.checked);
            }).change();

        });
    </script>
</asp:Content>
