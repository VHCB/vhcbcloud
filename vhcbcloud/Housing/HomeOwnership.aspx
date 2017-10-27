<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeOwnership.aspx.cs" MasterPageFile="~/Site.Master"
    Inherits="vhcbcloud.Housing.HomeOwnership" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <! -- Tabs -->
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
                            <td style="text-align: right">
                                <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search"
                                    Style="border: none; vertical-align: middle;" runat="server" Text="Project Search"
                                    OnClientClick="window.location.href='../ProjectSearch.aspx'; return false;"></asp:ImageButton>
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

                <div class="panel-width" runat="server" id="dvNewAddress">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Add New Address</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddAddress" runat="server" Text="Add New Address" />
                                        <asp:ImageButton ID="ImgHomeOwnership" ImageUrl="~/Images/print.png" ToolTip="Housing HomeOwnership Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="ImgHomeOwnership_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvNewAddressForm">
                            <asp:Panel runat="server" ID="Panel2">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 67px"><span class="labelClass">Address:</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlAddress" CssClass="clsDropDownLong" runat="server" Style="margin-left: 0px"></asp:DropDownList>
                                        </td>
                                        <td colspan="6">
                                            <asp:RadioButton ID="rdbMobile" runat="server" Text="Manufactured/Mobile Home" GroupName="HomeType" />&nbsp;&nbsp;
                                            <asp:RadioButton ID="rdbSingle" runat="server" Text="Single Family Detached" GroupName="HomeType" />&nbsp;&nbsp;
                                            <asp:RadioButton ID="rdbCondo" runat="server" Text="Condo" GroupName="HomeType" />

                                           <%-- <asp:RadioButtonList ID="rdBtnHome" runat="server" RepeatDirection="Horizontal" Height="16px" Width="551px">
                                                <asp:ListItem>Manufactured/Mobile Home</asp:ListItem>
                                                <asp:ListItem>Single Family Detached</asp:ListItem>
                                                <asp:ListItem>Condo</asp:ListItem>
                                            </asp:RadioButtonList>--%>

                                            <%--<span class="labelClass">Manufactured/Mobile Home:</span>--%>
                                        </td>
                                        <%--<td style="width: 78px">
                                            <asp:CheckBox ID="cbMH" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td style="width: 144px"><span class="labelClass">Single Family Detached:</span></td>
                                        <td style="width: 97px">
                                            <asp:CheckBox ID="cbSFD" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td style="width: 47px"><span class="labelClass">Condo:</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbCondo" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>--%>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td><span class="labelClass">Active:</span></td>
                                        <td>
                                            <asp:CheckBox ID="chkAddressActive" Enabled="false" runat="server" Checked="true" /></td>
                                        <td colspan="6"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 67px">
                                            <asp:Button ID="btnAddAddress" runat="server" Text="Add" class="btn btn-info" OnClick="btnAddAddress_Click" />
                                        </td>
                                        <td style="width: 250px"></td>
                                        <td style="width: 164px"></td>
                                        <td style="width: 78px"></td>
                                        <td style="width: 144px"></td>
                                        <td style="width: 97px"></td>
                                        <td style="width: 47px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvHOAddressGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel11" Width="100%" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="gvHOAddress" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="false"
                                    OnRowEditing="gvHOAddress_RowEditing" OnRowCancelingEdit="gvHOAddress_RowCancelingEdit"
                                    OnRowDataBound="gvHOAddress_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="HomeOwnershipID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHomeOwnershipID" runat="Server" Text='<%# Eval("HomeOwnershipID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdBtnSelectAddress" runat="server" AutoPostBack="true" onclick="RadioCheck(this);"
                                                    OnCheckedChanged="rdBtnSelectAddress_CheckedChanged" />
                                                <asp:HiddenField ID="HiddenHomeOwnershipID" runat="server" Value='<%#Eval("HomeOwnershipID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress" runat="Server" Text='<%# Eval("Address") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Manufactured/Mobile Home">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMH" runat="Server" Text='<%# Eval("MH") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Single Family Detached">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSFD" runat="Server" Text='<%# Eval("SFD") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Condo">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCondo" runat="Server" Text='<%# Eval("Condo") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Active">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkActivePS" Enabled="false" runat="server" Checked='<%# Eval("RowIsActive") %>' />
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

                <div class="panel-width" runat="server" id="dvNewHomeOwnerInfo" visible="false">
                    <div class="panel panel-default ">
                        <div class="panel-heading ">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title">Home Owner</h3>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:CheckBox ID="cbAddOwner" runat="server" Text="Add New Owner" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-body" runat="server" id="dvOwnerForm">
                            <asp:Panel runat="server" ID="Panel1">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 390px"><span class="labelClass">Owner</span></td>
                                        <td style="width: 250px">
                                            <asp:DropDownList ID="ddlOwner" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 300px">
                                            <span class="labelClass">Lender</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:DropDownList ID="ddlLender" CssClass="clsDropDown" runat="server"></asp:DropDownList>
                                        </td>
                                        <td style="width: 406px"><span class="labelClass">VHFA Involved?</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbVHFAInv" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 390px"><span class="labelClass">RD Loan?</span></td>
                                        <td>
                                            <asp:CheckBox ID="cbRDLoan" CssClass="ChkBox" runat="server" Text="Yes" Checked="false" />
                                        </td>
                                        <td style="width: 300px"><span class="labelClass">VHCB's Grant</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtVHCBGrant" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 406px">
                                            <span class="labelClass">Owner's Appreciation at Resale</span>
                                        </td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtOwnerAppAtResale" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 390px"><span class="labelClass">Capital Improvements at Resale</span></td>
                                        <td>
                                            <asp:TextBox ID="txtCapitalImpAtResale" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 300px"><span class="labelClass">Fee at Purchase</span></td>
                                        <td>
                                            <asp:TextBox ID="txtFeeAtPurchase" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 406px"><span class="labelClass">Fee at Resale</span>
                                        </td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtFeeAtResale" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 390px">
                                            <span class="labelClass">Stewardship Fund Contribution</span></td>
                                        <td style="width: 270px">
                                            <asp:TextBox ID="txtStewardCont" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 300px"><span class="labelClass">Single Family Assistance Loan</span></td>
                                        <td>
                                            <asp:TextBox ID="txtVHCBAsstLoan" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="width: 406px"><span class="labelClass">VHCB Rehab Loan</span></td>
                                        <td>
                                            <asp:TextBox ID="txtVHCBRehabLoan" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 390px"><span class="labelClass">Purchase Date</span></td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtPurchaseDate" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender runat="server" ID="ce_txtEventDate" TargetControlID="txtPurchaseDate">
                                            </ajaxToolkit:CalendarExtender>
                                        </td>
                                        <td style="width: 300px"><span class="labelClass">Active</span></td>
                                        <td>
                                            <asp:CheckBox ID="chkOwnerActive" Enabled="false" runat="server" Checked="true" />
                                        </td>

                                        <td colspan="2" style="height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 390px">
                                            <asp:Button ID="btnAddOwner" runat="server" Text="Submit" class="btn btn-info" OnClick="btnAddOwner_Click" />
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td style="width: 406px"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="height: 5px"></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <div class="panel-body" id="dvOwnerGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel4" Width="100%" Height="250px" ScrollBars="Vertical">
                                <asp:GridView ID="gvOwner" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false"
                                    OnRowEditing="gvOwner_RowEditing" OnRowCancelingEdit="gvOwner_RowCancelingEdit" OnRowDataBound="gvOwner_RowDataBound">
                                    <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                    <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                    <HeaderStyle CssClass="headerStyle" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                    <RowStyle CssClass="rowStyle" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ProjectHomeOwnershipID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectHomeOwnershipID" runat="Server" Text='<%# Eval("ProjectHomeOwnershipID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Owner's Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblOwnerName" runat="Server" Text='<%# Eval("OwnerName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lender Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLenderName" runat="Server" Text='<%# Eval("LenderName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VHCB Grant Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVHCBGrant" runat="Server" Text='<%# Eval("VHCBGrant", "{0:C2}") %>' />
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
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfProjectId" runat="server" />
    <asp:HiddenField ID="hfHomeOwnershipID" runat="server" />
    <asp:HiddenField ID="hfProjectHomeOwnershipID" runat="server" />
    <asp:HiddenField ID="hfIsVisibleBasedOnRole" runat="server" />

    <script language="javascript">
        $(document).ready(function () {
            $('#<%= dvNewAddressForm.ClientID%>').toggle($('#<%= cbAddAddress.ClientID%>').is(':checked'));
            $('#<%= cbAddAddress.ClientID%>').click(function () {
                $('#<%= dvNewAddressForm.ClientID%>').toggle(this.checked);
            }).change();

            $('#<%= dvOwnerForm.ClientID%>').toggle($('#<%= cbAddOwner.ClientID%>').is(':checked'));
            $('#<%= cbAddOwner.ClientID%>').click(function () {
                $('#<%= dvOwnerForm.ClientID%>').toggle(this.checked);
            }).change();

        });
        function PopupAwardSummary() {
            window.open('../awardsummary.aspx?projectid=' + $('#<%=hfProjectId.ClientID%>').val());
        };

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvHOAddress.ClientID%>");
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

