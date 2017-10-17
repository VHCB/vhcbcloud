<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HOPWAManagement.aspx.cs"
    Inherits="vhcbcloud.HOPWAManagement" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <p class="lead">Loan Maintenance </p>
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
                            <td style="text-align: right;">
                                <asp:ImageButton ID="btnProjectNotes1" Visible="false" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;
                                <asp:CheckBox ID="cbActiveOnly" runat="server" Text="Active Only" Checked="true" AutoPostBack="true" OnCheckedChanged="cbActiveOnly_CheckedChanged" />
                            </td>
                        </tr>
                    </table>

                    <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes1"
                        CancelControlID="btnClose" BackgroundCssClass="MEBackground">
                    </ajaxToolkit:ModalPopupExtender>

                    <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                        <iframe style="width: 750px; height: 550px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                        <br />
                        <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />
                    </asp:Panel>
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-width" runat="server" id="dvHOPWAMaster" visible="true">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Loan Master</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddHOPWAMaster" runat="server" Text="Add New UUID" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvHOPWAMasterForm">
                            <asp:Panel runat="server" ID="pnlHOPWAMaster">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">UUID</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtUUID" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Primary ASO</span>
                                        </td>
                                        <td style="width: 270px">
                                             <asp:DropDownList ID="ddlPrimaryASO" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">HH Includes</span></td>
                                        <td>
                                           <asp:TextBox ID="txtHHIncludes" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass"># with HIV</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtWithHIV" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass"># in Household</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtInHouseHold" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"># of Minors (<18)</span></td>
                                        <td>
                                            <asp:TextBox ID="txtMinors" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td style="width: 150px"><span class="labelClass">Gender</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtGender" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Age</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtAge" CssClass="clsTextBoxBlueSm" Width="200px" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">Ethnicity</span></td>
                                        <td>
                                             <asp:DropDownList ID="ddlEthnicity" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                     <tr>
                                        <td style="width: 150px"><span class="labelClass">Race</span></td>
                                        <td style="width: 250px">
                                             <asp:DropDownList ID="ddlRace" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">GMI</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlGMI" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 170px"><span class="labelClass">% AMI</span></td>
                                        <td>
                                             <asp:DropDownList ID="ddlAMI" CssClass="clsDropDown" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass"># Beds</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtBeds" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 107px">
                                            <span class="labelClass">Active</span>
                                        </td>
                                        <td style="width: 270px">
                                           <asp:CheckBox ID="cbHOPWAMaster" CssClass="ChkBox" runat="server" Text="Yes" Checked="true" Enabled="false" />
                                        </td>
                                        <td style="width: 170px"><span class="labelClass"></span></td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px"><span class="labelClass">Notes</span></td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txtNotes" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Button ID="btnHOPWAMaster" runat="server" Text="Add" class="btn btn-info"
                                                OnClick="btnHOPWAMaster_Click" /></td>
                                        <td colspan="5" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHOPWAMasterGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOPWAMaster" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvHOPWAMaster_RowEditing" OnRowCancelingEdit="gvHOPWAMaster_RowCancelingEdit"
                                    OnRowDataBound="gvHOPWAMaster_RowDataBound"
                                    OnSelectedIndexChanged="gvHOPWAMaster_SelectedIndexChanged">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HOPWAID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHOPWAID" runat="Server" Text='<%# Eval("HOPWAID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectHOPWA" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectHOPWA_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenHOPWAID" runat="server" Value='<%#Eval("HOPWAID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UUID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUUID" runat="Server" Text='<%# Eval("UUID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Primary ASO">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrimaryASO" runat="Server" Text='<%# Eval("PrimaryASOST") %>' />
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
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <asp:HiddenField ID="hfHOPWAId" runat="server" />
    </div>
    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvHOPWAMasterForm.ClientID%>').toggle($('#<%= cbAddHOPWAMaster.ClientID%>').is(':checked'));

                $('#<%= cbAddHOPWAMaster.ClientID%>').click(function () {
                    $('#<%= dvHOPWAMasterForm.ClientID%>').toggle(this.checked);
            }).change();

        });

         function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvHOPWAMaster.ClientID%>");
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

