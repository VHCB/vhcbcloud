<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProjectSearch.aspx.cs"
    Inherits="vhcbcloud.ProjectSearch" EnableEventValidation="false" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--    <style type="text/css">
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 0px;
            border-style: solid;
            border-color: black;
            padding-top: 0px;
            padding-left: 0px;
            width: 700px;
            height: 550px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>--%>

    <div class="jumbotron">

        <table style="width: 100%;">
            <tr>
                <td>
                    <p class="lead">Project Search</p>
                </td>
               <%-- <td style="text-align: right; padding-right: 14px">
                    <asp:Button ID="btnNewProject" runat="server" Text="New Project" class="btn btn-info"
                        OnClientClick="window.location.href='ProjectMaintenance.aspx?type=new'; return false;" />
                    &nbsp;
                </td>--%>
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

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: left">Search Options</td>
                            <td style="text-align: right">
                                <asp:ImageButton ID="btnProjectNotes1" runat="server" ImageUrl="~/Images/notes.png" ToolTip="Project Notes" Text="Project Notes" Style="border: none; vertical-align: middle;" />
                                &nbsp;
                                <asp:ImageButton ID="btnNewProject1" runat="server" ImageUrl="~/Images/NewProject.png" ToolTip="New Project" 
                                    Text="New Project" Style="border: none; vertical-align: middle;" OnClientClick="window.location.href='ProjectMaintenance.aspx?type=new'; return false;" />
                            </td>
                        </tr>
                        </table>
                </div>

                <div id="dvMessage" runat="server" visible="false">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>
                <div class="panel-body">
                    <asp:Panel runat="server" ID="pnlProjectInfo" DefaultButton="btnProjectSearch">
                        <table style="width: 100%">
                            <tr>
                                <td><span class="labelClass">Number</span></td>
                                <td>
                                    <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" runat="server" ToolTip="Enter first 7 digits of Number"></asp:TextBox>
                                    <ajaxToolkit:MaskedEditExtender runat="server" ID="ameProjNum" Mask="9999-999" ClearMaskOnLostFocus="false"
                                        MaskType="Number" TargetControlID="txtProjNum">
                                    </ajaxToolkit:MaskedEditExtender>
                                </td>
                                <td>
                                    <span class="labelClass">Name</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtProjectName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox>
                                </td>
                                <td><span class="labelClass">Entity</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlPrimaryApplicant" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
                                    &nbsp;&nbsp;<asp:CheckBox ID="cbPrimaryApplicant" Text="Primary" Checked="true" runat="server" AutoPostBack="true" OnCheckedChanged="cbPrimaryApplicant_CheckedChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 5px"></td>
                            </tr>
                            <tr>
                                <td><span class="labelClass">Program</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <span class="labelClass">Town</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTown" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td><span class="labelClass">County</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlCounty" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 5px"></td>
                            </tr>
                            <tr>
                                <td><span class="labelClass">Project Type</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlProjectType" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 10px"></td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 5px">
                                    <asp:Button ID="btnProjectSearch" runat="server" Text="Search" class="btn btn-info" OnClick="btnProjectSearch_Click" />
                                    &nbsp;&nbsp;<asp:Button ID="btnProjectClear" runat="server" Text="Clear" class="btn btn-info" OnClick="btnProjectClear_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <div runat="server" id="dvSearchResults">
                        <br />
                        <div class="panel panel-default">
                            <div class="panel-heading">

                                <table>
                                    <tr>
                                        <td>
                                            <h3 class="panel-title">Search Results: <asp:Label runat="server" ID="lblSearcresultsCount"></asp:Label></h3>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" id="dvSearchResultsGrid" runat="server">
                                <asp:Panel runat="server" ID="Panel9" Width="100%" Height="500px" ScrollBars="Vertical">
                                    <asp:GridView ID="gvSearchresults" runat="server" AutoGenerateColumns="False"
                                        Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                        GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" OnRowCommand="gvSearchresults_RowCommand"
                                        OnSorting="gvSearchresults_Sorting">
                                        <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                        <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                        <HeaderStyle CssClass="headerStyle" />
                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                        <RowStyle CssClass="rowStyle" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Project ID" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectId" runat="Server" Text='<%# Eval("ProjectId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project#" SortExpression="Proj_num" ItemStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectNum" runat="Server" Text='<%# Eval("Proj_num") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Name" SortExpression="ProjectName">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Program" SortExpression="programname" ItemStyle-Width="80px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProgramName" runat="Server" Text='<%# Eval("programname") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Applicant Name" SortExpression="Applicantname">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApplicantname" runat="Server" Text='<%# Eval("Applicantname") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAdress" runat="Server" ToolTip='<%# Eval("FullAddress") %>' Text='<%# Eval("Address") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="AddButton" runat="server"
                                                        CommandName="SelectProject"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                        Text="Select" />
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
    </div>
</asp:Content>
