<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HousingFederalPrograms.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Housing.HousingFederalPrograms" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <!-- Tabs -->
        <div id="dvTabs" runat="server">
            <div id="page-inner">
                <div id="VehicleDetail">
                    <ul class="vdp-tabs" runat="server" id="Tabs"></ul>
                </div>
            </div>
        </div>
        <!-- Tabs -->
        <div class="container">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 171px"><span class="labelClass">Project #</span></td>
                            <td style="width: 192px">
                                <span class="labelClass" id="ProjectNum" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Name:</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="ProjName" runat="server"></span>
                            </td>
                            <td><span class="labelClass">Total Units:</span></td>
                            <td style="text-align: left">
                                <span class="labelClass" id="TotalUnits" runat="server"></span>
                            </td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="ibAwardSummary" runat="server" ImageUrl="~/Images/$$.png" Text="Award Summary"
                                    Style="border: none; vertical-align: middle;"
                                    OnClientClick="PopupAwardSummary(); return false;"></asp:ImageButton>
                                <asp:ImageButton ID="btnProjectNotes" runat="server" ImageUrl="~/Images/notes.png" Text="Project Notes"
                                    Style="border: none; vertical-align: middle;" />
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true"
                                    OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                    </table>
                </div>

                <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes" CancelControlID="btnClose"
                    BackgroundCssClass="MEBackground">
                </ajaxToolkit:ModalPopupExtender>

                <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                    <iframe style="width: 750px; height: 600px;" id="ifProjectNotes" src="../ProjectNotes.aspx" runat="server"></iframe>
                    <br />
                    <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
                </asp:Panel>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvNewProgramSetup">
                    <div class="panel panel-default" style="margin-bottom: 2px;">
                        <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Program Setup</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddFedProgram" runat="server" Text="Add New Federal Program" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvProgramSetupForm">
                            <asp:Panel runat="server" ID="Panel8">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 140px"><span class="labelClass">Federal Program</span></td>
                                        <td style="width: 215px">
                                            <asp:DropDownList ID="ddlFederalProgram" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 140px"><span class="labelClass">Number of Units</span></td>
                                        <td style="width: 215px">
                                            <asp:TextBox ID="txtTotFedProgUnits" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 100px"></td>
                                        <td style="width: 180px">
                                            <asp:Button ID="AddFederalProgram" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="AddFederalProgram_Click" />
                                        </td>
                                        <td style="width: 170px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvFedProgramGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel3" Width="100%" Height="130px" ScrollBars="Vertical">
                                <asp:GridView ID="gvFedProgram" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvFedProgram_RowEditing" OnRowCancelingEdit="gvFedProgram_RowCancelingEdit"
                                    OnRowUpdating="gvFedProgram_RowUpdating">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectFederalID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectFederalID" runat="Server" Text='<%# Eval("ProjectFederalID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectFederalProgram" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectFederalProgram_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenProjectFederalID" runat="server" Value='<%#Eval("ProjectFederalID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Federal Program">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFedProgram" runat="Server" Text='<%# Eval("FedProgram") %>' />
                                                <asp:HiddenField ID="HiddenFedProgram" runat="server" Value='<%#Eval("FedProgram")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number of units">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumUnits" runat="Server" Text='<%# Eval("NumUnits") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNumUnits" CssClass="clsTextBoxBlueSm" runat="server"
                                                    Text='<%# Eval("NumUnits") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActive" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("RowIsActive") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowEditButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" style="padding: 2px 15px 0px 2px" runat="server" id="dvFedProgramHome" visible="false">
                            <div class="panel panel-default" style="margin-bottom: 2px;">
                                <div class="panel-heading" style="padding: 5px 5px 1px 5px">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <h3 class="panel-title">Home</h3>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="panel-body" style="padding: 10px 15px 0px 15px" runat="server" id="dvFedProgramHomeForm">
                                    <asp:Panel runat="server" ID="Panel1">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 140px"><span class="labelClass">Recertification Month</span></td>
                                                <td style="width: 215px">
                                                    <asp:TextBox ID="txtRecreationMonth" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 140px"><span class="labelClass">Number of Units</span></td>
                                                <td style="width: 215px">
                                                    <asp:TextBox ID="TextBox1" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px"></td>
                                                <td style="width: 180px">
                                                    <asp:Button ID="Button1" runat="server" Text="Add" class="btn btn-info"
                                                        OnClick="AddFederalProgram_Click" />
                                                </td>
                                                <td style="width: 170px"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="height: 5px"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfProjectFederalID" runat="server" />
    <asp:HiddenField ID="hfProjectFedProgram" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvProgramSetupForm.ClientID%>').toggle($('#<%= cbAddFedProgram.ClientID%>').is(':checked'));
            $('#<%= cbAddFedProgram.ClientID%>').click(function () {
                $('#<%= dvProgramSetupForm.ClientID%>').toggle(this.checked);
            }).change();
        });
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvFedProgram.ClientID%>");
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
