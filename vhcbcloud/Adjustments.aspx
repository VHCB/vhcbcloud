<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Adjustments.aspx.cs"
    MaintainScrollPositionOnPostback="true" Inherits="vhcbcloud.Adjustments" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix" id="vhcb">
        <p class="lead">Adjustments</p>
        <div class="container">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdBtnSelect" runat="server" AutoPostBack="true" CellPadding="2" CellSpacing="4"
                                    RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnSelect_SelectedIndexChanged">
                                    <asp:ListItem Selected="true"> New &nbsp;</asp:ListItem>
                                    <asp:ListItem> Existing &nbsp;</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="imgSearch" ImageUrl="~/Images/search.png" ToolTip="Project Search" Style="border: none;" runat="server" Text="Project Search" Visible="true"
                                    OnClientClick="PopupProjectSearch(); return false;"></asp:ImageButton>
                                &nbsp;<asp:ImageButton ID="imgNewAwardSummary" runat="server" ImageUrl="~/Images/$$.png" OnClientClick="PopupNewAwardSummary(); return false;" Style="border: none;" Text="Award Summary" ToolTip="Award summary" Visible="true" />
                                <asp:ImageButton ID="imgExistingAwardSummary" ImageUrl="~/Images/$$.png" ToolTip="Award summary" Style="border: none;" runat="server" Text="Award Summary" Visible="false" OnClientClick="PopupExistingAwardSummary(); return false;" />
                                &nbsp;<asp:ImageButton ID="btnProjectNotes" ImageUrl="~/Images/notes.png" ToolTip="Notes" runat="server" Text="Project Notes" Style="border: none;" />
                            </td>
                        </tr>
                    </table>
                </div>

                <ajaxToolkit:ModalPopupExtender ID="mpExtender" runat="server" PopupControlID="pnlProjectNotes" TargetControlID="btnProjectNotes" CancelControlID="btnClose"
                    BackgroundCssClass="MEBackground">
                </ajaxToolkit:ModalPopupExtender>

                <asp:Panel ID="pnlProjectNotes" runat="server" CssClass="MEPopup" align="center" Style="display: none">
                    <iframe style="width: 750px; height: 600px;" id="ifProjectNotes" src="ProjectNotes.aspx" runat="server"></iframe>
                    <br />
                    <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-info" />

                </asp:Panel>


                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-body">
                    <table style="width: 100%">
                        <tr>
                            <td><span class="labelClass">Board/Cash Transaction</span></td>
                            <td>
                                <asp:DropDownList ID="ddlTransaction" CssClass="clsDropDown" runat="server" Visible="true" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlTransaction_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <span class="labelClass">Type (Lktransaction)</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLKTransaction" CssClass="clsDropDown" runat="server" Visible="true" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlLKTransaction_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td>&nbsp;
                            </td>
                            <td>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Project # :</span></td>
                            <td>
                                <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" Width="120px" runat="server"
                                    ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtProjNum" MinimumPrefixLength="1"
                                    EnableCaching="true" CompletionSetCount="1"
                                    CompletionInterval="100" ServiceMethod="GetProjectsByFilter">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                            <td>
                                <span class="labelClass">Project Name :</span>
                            </td>
                            <td>
                                <asp:Label ID="lblProjName" class="labelClass" Text="--" runat="server"></asp:Label>
                            </td>
                            <td><span class="labelClass">Date :</span></td>
                            <td>
                                <asp:TextBox ID="txtTransDate" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td><span class="labelClass">Fund #</span></td>
                            <td>
                                <asp:DropDownList ID="ddlFundNum" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;"
                                    OnSelectedIndexChanged="ddlFundNum_SelectedIndexChanged" AutoPostBack="True" TabIndex="8">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <span class="labelClass">Fund Name</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFundName" CssClass="clsDropDown" runat="server" onclick="needToConfirm = false;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlFundName_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:Label ID="lblFundName" class="labelClass" Text=" " runat="server" Visible="false"></asp:Label>
                            </td>
                            <td><span class="labelClass">Type</span></td>
                            <td>
                                <asp:DropDownList ID="ddlTransType" CssClass="clsDropDown" runat="server" TabIndex="9">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                             <td><span class="labelClass">Amount $</span></td>
                            <td>
                                <asp:TextBox ID="txtAmt" CssClass="clsTextBoxMoney" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblUsePermit" class="labelClass" runat="server" Visible="false" Text="Use Permit:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlUsePermit" CssClass="clsDropDown" runat="server" Visible="false" TabIndex="10" AutoPostBack="true" OnSelectedIndexChanged="ddlUsePermit_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labelClass">Comments</span>
                            </td>
                            <td colspan="5">
                                <asp:TextBox ID="txtComments" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
            </div>
            <asp:HiddenField ID="hfProjId" runat="server" />
            <asp:HiddenField ID="hfTransId" runat="server" />
            <asp:HiddenField ID="hfDetailId" runat="server" />
        </div>
        <script type="text/javascript">
            function PopupNewAwardSummary() {
                window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
            };

            function PopupProjectSearch() {
                window.open('./projectsearch.aspx')
            };

            function PopupExistingAwardSummary() {
                window.open('./awardsummary.aspx?projectid=' + $("#<%= hfProjId.ClientID%>").val())
            };
        </script>
</asp:Content>



