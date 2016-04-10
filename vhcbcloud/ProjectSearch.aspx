<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProjectSearch.aspx.cs" Inherits="vhcbcloud.ProjectSearch" %>

<asp:Content ID="EventContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <p class="lead">Project Search</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Search Options
                </div>

                <div id="dvMessage" runat="server">
                    <p class="lblErrMsg">&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
                </div>

                <div class="panel-body">
                    <asp:Panel runat="server" ID="pnlProjectInfo">
                        <table style="width: 100%">
                            <tr>
                                <td><span class="labelClass">Number</span></td>
                                <td>
                                    <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
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
                                <td><span class="labelClass">Applicant</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlPrimaryApplicant" CssClass="clsDropDown" runat="server">
                                    </asp:DropDownList>
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
                                    <asp:Button ID="btnProjectUpdate" runat="server" Text="Search" class="btn btn-info" />
                                </td>
                            </tr>

                        </table>

                    </asp:Panel>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
