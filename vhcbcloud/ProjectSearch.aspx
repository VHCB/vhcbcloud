<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProjectSearch.aspx.cs" Inherits="vhcbcloud.ProjectSearch" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
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
    </style>

    <div class="jumbotron">
        <p class="lead">Project Search</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Search Options
                </div>

                <div id="dvMessage" runat="server" visible="false">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <asp:Button ID="Button1" runat="server" Text="Project Notes" />
                <ajaxToolkit:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="Button1" CancelControlID="Button2" BackgroundCssClass="Background">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                    <iframe style="width: 700px; height: 550px;" id="irm1" src="ProjectNotes.aspx?ProjectId=<%=ProjectId%>" runat="server"></iframe>
                    <br />
                    <asp:Button ID="Button2" runat="server" Text="Close" />
                </asp:Panel>


                <div class="panel-body">
                    <asp:Panel runat="server" ID="pnlProjectInfo">
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
                                <td colspan="6" style="height: 5px"></td>
                            </tr>
                            <tr>
                                <td colspan="6" style="height: 5px">
                                    <asp:Button ID="btnProjectSearch" runat="server" Text="Search" class="btn btn-info" OnClick="btnProjectSearch_Click" />
                                </td>
                            </tr>
                        </table>

                    </asp:Panel>

                    <br />

                    <div class="panel panel-default" runat="server" id="dvSearchResults">
                        <div class="panel-heading ">
                            <h3 class="panel-title">Search Results</h3>
                        </div>
                        <div class="panel-body" id="dvSearchResultsGrid" runat="server">
                            <asp:Panel runat="server" ID="Panel9" Width="100%" Height="500px" ScrollBars="Vertical">
                                <asp:GridView ID="gvSearchresults" runat="server" AutoGenerateColumns="False"
                                    Width="100%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                    GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" OnRowCommand="gvSearchresults_RowCommand">
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
                                        <asp:TemplateField HeaderText="Project#">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectNum" runat="Server" Text='<%# Eval("Proj_num") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectName" runat="Server" Text='<%# Eval("ProjectName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Program">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProgramName" runat="Server" Text='<%# Eval("programname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Applicant Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApplicantname" runat="Server" Text='<%# Eval("Applicantname") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
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
</asp:Content>
