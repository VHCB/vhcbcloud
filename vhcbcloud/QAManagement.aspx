<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="QAManagement.aspx.cs" Inherits="vhcbcloud.QAManagement" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <div class="panel-width" runat="server" id="dvNewYrQrtr">
            <div class="panel panel-default ">
                <div class="panel-heading ">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <h3 class="panel-title">Year/Quarter Settings 
                                </h3>
                            </td>
                            <td style="text-align: right">
                                <asp:CheckBox ID="cbAddNew" runat="server" Text="Add New" Checked="false" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="panel-body" runat="server" id="dvNewYrQrtrForm">
                    <asp:Panel ID="pnlAddNew" runat="server">
                        <div runat="server" id="dvAddNew">
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 70px">
                                    <span class="labelClass">Year</span></td>
                                <td>
                                    <asp:TextBox ID="txtYear" CssClass="clsTextBoxBlue1" runat="server" Width="50px" MaxLength="4"></asp:TextBox></td>
                                <td style="width: 70px">
                                    <span class="labelClass">Quarter</span></td>
                                <td style="width: 150px">
                                    <asp:DropDownList ID="ddlQuarter" CssClass="clsDropDown" runat="server">
                                        <asp:ListItem Text="Quarter1" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Quarter2" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Quarter3" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Quarter4" Value="4"></asp:ListItem>
                                    </asp:DropDownList></td>
                                <td>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" class="btn btn-info" /></td>
                            </tr>
                        </table>
                            </div>
                    </asp:Panel>
                </div>

                <div class="panel-body" id="dvProjectNamesGrid" runat="server">
                    <table style="width: 100%">
                        <tr>
                            <td style="height: 5px">
                                <asp:Label runat="server" class="lblErrMsg" ID="lblErrorMsg"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlYrQrtrDetails" runat="server" Visible="false" Width="100%" Height="180px" ScrollBars="Vertical">
                                    <asp:GridView ID="gvYrQrtrDetails" runat="server" AutoGenerateColumns="False"
                                        Width="100%" CssClass="gridView" PagerSettings-Mode="NextPreviousFirstLast"
                                        GridLines="None" EnableTheming="True" OnRowDeleting="gvYrQrtrDetails_RowDeleting" >
                                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                        <HeaderStyle CssClass="headerStyle" />
                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                        <RowStyle CssClass="rowStyle" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdBtnSelect" runat="server" AutoPostBack="true" onclick="RadioCheck(this);" OnCheckedChanged="rdBtnSelect_CheckedChanged" />
                                                    <asp:HiddenField ID="hdnYrQrtrId" runat="server" Value='<%#Eval("ACYrQtrID")%>' />
                                                </ItemTemplate>

                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Year" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblYear" runat="Server" Text='<%# Eval("Year") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quarter" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuarter" runat="Server" Text='<%# Eval("Qtr") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    &nbsp;
                           <asp:LinkButton ID="lbRemove" runat="server" CausesValidation="False" CommandName="Delete" Text="Remove" OnClientClick="return confirm('Are you sure you want to delete this Year/Quarter detail?');"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="panel-width" runat="server" id="dvDataSetUp" visible="false">
            <div class="panel panel-default ">
                <div class="panel-heading ">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <h3 class="panel-title">Data Setup
                                </h3>
                            </td>
                            <td style="text-align: right">
                                <asp:CheckBox ID="cbActive" runat="server" Text="Active Only" Checked="true" Enabled="false" OnCheckedChanged="cbActive_CheckedChanged" AutoPostBack="true"   /> 
                                <asp:CheckBox ID="cbAddNewQuestion" runat="server" Text="Add New" Checked="false" AutoPostBack="true" OnCheckedChanged="cbAddNewQuestion_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="panel-body" runat="server" id="dvDataSetupForm">
                    <asp:Panel ID="pnlDataSetupForm" runat="server" Visible="false">
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 70px">
                                    <span class="labelClass">Import Data</span></td>
                                <td style="width: 150px">
                                    <asp:DropDownList ID="ddlYearQrtr" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList></td>
                                <td>
                                    <asp:Button ID="btnImport" runat="server" Text="Import" class="btn btn-info" OnClick="btnImport_Click" /></td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>

                <div class="panel-body" runat="server" id="dvQAManagementForm">
                    <asp:Panel runat="server" ID="pnlAQManagementForm" Visible="false">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 150px"><span class="labelClass">Question #</span></td>
                                <td style="width: 250px">
                                    <asp:TextBox ID="txtQuestionNum" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="true" Width="50px" MaxLength="4"></asp:TextBox>
                                </td>
                                <td style="width: 100px"><span class="labelClass">Result Type</span></td>
                                <td style="width: 270px">
                                    <asp:DropDownList ID="ddlResultType" CssClass="clsDropDown" runat="server">
                                        <asp:ListItem Text="Text" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Digits" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 100px"><span class="labelClass">Active</span></td>
                                <td style="width: 270px">
                                    <asp:CheckBox ID="chkFormActive" runat="server"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 5px"></td>
                            </tr>
                            <tr>
                                <td style="width: 14%"><span class="labelClass">Question</span></td>
                                <td style="width: 100%" colspan="5">
                                    <asp:TextBox ID="txtQuestionDesc" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                </td>
                            </tr>

                            <tr>
                                <td colspan="6" style="float: right;">
                                    <asp:Button ID="btnQuestionDetails" runat="server" Text="Update" class="btn btn-info" OnClick="btnQuestionDetails_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>

                <div class="panel-body" id="dvQuestionAnswerGrid" runat="server">
                    <table style="width: 100%">
                        <tr>
                            <td style="height: 5px">
                                <asp:Label runat="server" class="lblErrMsg" ID="lblQuestionErrorMsg"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel runat="server" ID="pnlQuestionAnswerGrid" Width="100%" Height="325px" ScrollBars="Vertical" Visible="false">
                                    <asp:GridView ID="gvQuestionAnswer" runat="server" AutoGenerateColumns="False"
                                        Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                        GridLines="None" EnableTheming="True" AllowPaging="false" OnRowCancelingEdit="gvQuestionAnswer_RowCancelingEdit1" OnRowDataBound="gvQuestionAnswer_RowDataBound"
                                        OnRowEditing="gvQuestionAnswer_RowEditing1">
                                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                        <HeaderStyle CssClass="headerStyle" />
                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                        <RowStyle CssClass="rowStyle" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="PerformanceMasterId" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPerformanceMasterId" runat="Server" Text='<%# Eval("ACPerformanceMasterID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Question #">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuestionNum" runat="Server" Text='<%# Eval("QuestionNum") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Question">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLabelDefinition" runat="Server" Text='<%# Eval("LabelDefinition") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ResultType">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblResulType" runat="Server" Text='<%# Eval("ResultType") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Active">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowEditButton="True" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:HiddenField ID="hfQuestionId" runat="server" />
            </div>
        </div>
    </div>

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= txtYear.ClientID%>').keyup(function () {
                toNumericControl($('#<%= txtYear.ClientID%>').val(), $('#<%= txtYear.ClientID%>'));
            });
            $('#<%= dvNewYrQrtrForm.ClientID%>').toggle($('#<%= cbAddNew.ClientID%>').is(':checked'));


            $('#<%= cbAddNew.ClientID%>').click(function () {
                $('#<%= dvNewYrQrtrForm.ClientID%>').toggle(this.checked);
            }).change();
        });
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvYrQrtrDetails.ClientID%>");
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
