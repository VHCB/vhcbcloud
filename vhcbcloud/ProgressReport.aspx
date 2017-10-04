<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProgressReport.aspx.cs" Inherits="vhcbcloud.ProgressReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" id="vhcb">
        <div class="panel-width" runat="server" id="dvProgressReport">
            <div class="panel panel-default ">
                <div class="panel-heading ">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <h3 class="panel-title">Americorps Progress Report
                                </h3>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="panel-body" runat="server" id="dvProgressReportUserDetails">
                    <asp:Panel ID="pnlUserDetails" runat="server">
                        <table style="width: 100%;">
                            <tr>
                            <td colspan="4" style="height: 5px">
                                <asp:Label runat="server" class="lblErrMsg" ID="lblQuestionAnswerErrorMsg2"></asp:Label></td>
                        </tr>
                            <tr>
                                <td style="width: 20%">
                                    <span class="labelClass">Reporting Quarter:</span></td>
                                <td colspan="3" style="width: 150px">
                                    <asp:DropDownList ID="ddlYearQrtr" CssClass="clsDropDown" runat="server" Width="100px" OnSelectedIndexChanged="ddlYearQrtr_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                    <span class="labelClass">First Name:</span></td>
                                <td style="width: 20%">
                                    <asp:TextBox ID="txtFirstName" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="true"></asp:TextBox></td>
                                <td style="width: 70px">
                                    <span class="labelClass">Last Name:</span></td>
                                <td>
                                    <asp:TextBox ID="txtLastName" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="true"></asp:TextBox></td>

                            </tr>
                            <tr>
                                <td colspan="4" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                    <span class="labelClass">Email:</span></td>
                                <td style="width: 20%">
                                    <asp:TextBox ID="txtEmail" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="true"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                    <span class="labelClass">Project #:</span></td>
                                <td style="width: 20%">
                                    <asp:TextBox ID="txtProjectNumber" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="true"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                    <span class="labelClass">Host Site:</span></td>
                                <td style="width: 20%">
                                    <asp:TextBox ID="txtHostSite" CssClass="clsTextBoxBlue1" runat="server" ReadOnly="true"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td style="width: 100%" colspan="4">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <span class="labelClass">List other VHCB Americorps Members Covered by this report.</span></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtOtherUsers" TextMode="multiline" CssClass="clsTextBoxBlue1" Columns="50" Rows="2" runat="server" Width="100%" Height="80px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="height: 15px"></td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:Button ID="btnNextPage" runat="server" Text="Nextpage" class="btn btn-info" OnClick="btnNextPage_Click"  />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
                <div class="panel-body" runat="server" id="Div1">
                    <asp:Panel ID="pnlQuestions" runat="server" Visible="false">
                        <table style="width: 100%;">
                            <tr style="text-align: right">
                                <td>
                                    <asp:DataPager ID="QuestionsListNumeric" runat="server" PagedControlID="lstVwQuestions"
                                        PageSize="10">
                                        <Fields>
                                            <asp:NumericPagerField ButtonCount="7" ButtonType="Button" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                            <tr>
                            <td style="height: 5px">&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label runat="server" class="lblErrMsg" ID="lblQuestionAnswerErrorMsg"></asp:Label></td>
                        </tr>
                            <tr>
                                <td>
                                    <asp:ListView ID="lstVwQuestions" runat="server" OnPagePropertiesChanging="lstVwQuestions_PagePropertiesChanging" OnItemDataBound="lstVwQuestions_ItemDataBound">
                                        <LayoutTemplate>
                                            <h1><span class="labelClass">
                                                <asp:Label ID="lblPageNum" runat="Server" /></span></h1>
                                            <blockquote style="border-left:none;">
                                                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                            </blockquote>
                                        </LayoutTemplate>
                                        <ItemSeparatorTemplate>
                                            <hr />
                                        </ItemSeparatorTemplate>

                                        <ItemTemplate>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 100%"><span class="labelClass">
                                                        <asp:Label ID="lblQuestion" runat="Server" Text='<%# Eval("Question") %>' /></span></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%">
                                                        <asp:TextBox ID="txtAnswer" CssClass="clsTextBoxBlue1" runat="server" Text='<%# Eval("Response") %>'></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%">
                                                        <asp:HiddenField ID="hdnACPerformanceMasterID" runat="server" Value='<%#Eval("ACPerformanceMasterID")%>' />
                                                        <asp:HiddenField ID="hdnIsCompleted" runat="server" Value='<%#Eval("IsCompleted")%>' />
                                                        <asp:HiddenField ID="hdnResultType" runat="server" Value='<%#Eval("ResultType")%>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>

                                    </asp:ListView>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-info" Visible="false" OnClick="btnBack_Click" />&nbsp;&nbsp;
                                    <asp:DataPager ID="QuestionsListNextPrevious" runat="server"
                                        PagedControlID="lstVwQuestions" PageSize="10">
                                        <Fields>
                                            <asp:NextPreviousPagerField PreviousPageText="Previous Page" ShowLastPageButton="False"
                                                ShowNextPageButton="False" ShowPreviousPageButton="True" ShowFirstPageButton="false" ButtonType="Button" ButtonCssClass="btn btn-info" />
                                            <asp:NextPreviousPagerField NextPageText="Next Page" ShowFirstPageButton="False"
                                                ShowNextPageButton="True" ShowPreviousPageButton="False" ShowLastPageButton="false" ButtonType="Button" ButtonCssClass="btn btn-info" />

                                        </Fields>
                                    </asp:DataPager>&nbsp;&nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" Visible="false" OnClick="btnSubmit_Click"/>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:HiddenField ID="hfUserId" runat="server" />
                    <asp:HiddenField ID="hdnAllIsCompleted" runat="server" />
                </div>
            </div>
        </div>
    </div>
      <script language="javascript">
          function toQuestionNumericControl(clientid) {
              toNumericControl($("#" + clientid).val(), $("#" + clientid));
            }
      </script>
</asp:Content>
