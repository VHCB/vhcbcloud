<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddNewInactiveProject.aspx.cs" Inherits="vhcbcloud.AddNewInactiveProject" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">New Inactive project</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-body">




                        <table style="width: 60%;">
                            <tr>
                                <td style="height: 30px">
                                    <span class="labelClass">Program</span>
                                </td>
                                <td style="height: 30px">
                                    <asp:DropDownList ID="ddlProgram" CssClass="clsDropDown" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged" Style="margin-left: 0">
                                    </asp:DropDownList>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px"></td>
                            </tr>
                            <tr>
                                <td style="height: 30px">
                                    <span class="labelClass">Project Number</span>
                                </td>
                                <td style="height: 30px"><span class="labelClass" runat="server" visible="false" id="spnViabilityProjectPrefix"><strong>9999-001-</strong></span>
                                    <asp:TextBox ID="txtprojectNumber" CssClass="clsTextBoxBlue1" runat="server" Width="100px" Height="22px"  ClientIDMode="Static" onblur="__doPostBack('tbOnBlur','OnBlur');"></asp:TextBox>
                                       <ajaxToolkit:AutoCompleteExtender ID="ae_txtProjNum" runat="server" TargetControlID="txtprojectNumber"
                                        MinimumPrefixLength="1" UseContextKey="true"
                                        EnableCaching="true" CompletionSetCount="1"
                                        CompletionInterval="100" ServiceMethod="GetProjectNumber">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td style="height: 30px"><span class="labelClass">Project Name</span></td>
                                <td style="height: 30px">
                                    <span class="labelClass" runat="server" id="spnProjectName"></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Email Address - Login Name</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtLoginName" CssClass="clsTextBoxBlue1" runat="server" Width="133px"></asp:TextBox></td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px"></td>
                            </tr>
                            <tr>
                                <td style="height: 30px"><span class="labelClass">Password</span></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="txtPassword" CssClass="clsTextBoxBlue1" runat="server" Width="132px"></asp:TextBox></td>
                                <td style="height: 30px">&nbsp;</td>
                                <td style="height: 30px">&nbsp;</td>
                            </tr>
                             <tr>
                                <td style="height: 30px">
                                    <span class="labelClass">Application ID</span>
                                </td>
                                <td style="height: 30px">
                                    <asp:DropDownList ID="ddlApplication" CssClass="clsDropDown" runat="server" Style="margin-left: 0" AutoPostBack="true" OnSelectedIndexChanged="ddlApplication_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px"></td>
                            </tr>
                             <tr>
                                <td style="height: 30px">
                                    <span class="labelClass" id="spnPortfolioType" runat="server" visible="false">Portfolio Type</span>
                                </td>
                                <td style="height: 30px">
                                    <asp:DropDownList ID="ddlPortfolio" CssClass="clsDropDown" runat="server" Style="margin-left: 0" visible="false">
                                    </asp:DropDownList>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px"></td>
                            </tr>
                             <tr>
                                <td style="height: 30px">
                                    <span class="labelClass" id="spnYear" runat="server" visible="false">Year</span>
                                </td>
                                <td style="height: 30px">
                                    <asp:DropDownList ID="ddlYear" CssClass="clsDropDown" runat="server" Style="margin-left: 0" Visible="false">
                                    </asp:DropDownList>
                                </td>
                                <td style="height: 30px"></td>
                                <td style="height: 30px"></td>
                            </tr>
                            <%-- <tr>
                                <td style="height: 30px"><span class="labelClass">Active</span></td>
                                <td style="height: 30px">
                                    <asp:CheckBox ID="cbActive" runat="server" Text="" Checked="false" Enabled="false" Visible="true" />
                                    &nbsp;</td>
                                <td style="height: 30px">&nbsp;</td>
                                <td style="height: 30px">&nbsp;</td>
                            </tr>--%>
                            <tr>
                                <td colspan="4" style="height: 50px">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-info" OnClick="btnSubmit_Click" />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-info" OnClick="btnClear_Click" /></td>
                            </tr>
                        </table>

                        &nbsp;&nbsp;&nbsp;
                        <div id="dvMessage" runat="server">
                            <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
