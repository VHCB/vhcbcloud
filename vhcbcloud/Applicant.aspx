<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Applicant.aspx.cs" Inherits="vhcbcloud.Applicant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Applicant</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <table>
                        <tr style="float: left">
                            <td><span class="labelClass">Individual: </span></td>
                            <td>
                                <asp:RadioButtonList ID="rdBtnIndividual" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdBtnIndividual_SelectedIndexChanged">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnlappl" runat="server" Visible="false">
                        <table>
                            <tr>
                                <td>
                                    <span class="labelClass">&nbsp;Payee? </span>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="rdBtnPayee" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem>Yes</asp:ListItem>
                                        <asp:ListItem>No</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                        <table id="tblCorporate" runat="server" visible="false">
                            <tr style="float: left">
                                <td><span class="labelClass">Applicant Name: </span></td>
                                <td>
                                    <asp:TextBox ID="txtApplicantName" CssClass="clsApplicantBlue" runat="server"></asp:TextBox></td>
                            </tr>
                        </table>
                        <table id="tblIndividual" runat="server" visible="false">
                            <tr style="float: left">
                                <td><span class="labelClass">First Name: </span></td>
                                <td>
                                    <asp:TextBox ID="txtFName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                                <%-- <td><span class="labelClass">&nbsp;MI: </span></td>
                    <td>
                        <asp:TextBox ID="txtMiddle" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>--%>
                                <td><span class="labelClass">&nbsp;Last Name: </span></td>
                                <td>
                                    <asp:TextBox ID="txtLName" CssClass="clsTextBoxBlue1" runat="server"></asp:TextBox></td>
                            </tr>
                        </table>
                        <br />
                        <p>
                            <asp:LinkButton ID="btnSubmit" runat="server" class="btn btn-info" Text="Add new applicant" TabIndex="3" OnClick="btnSubmit_Click" />

                        </p>
                    </asp:Panel>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
                    </p>
                </div>
                <div class="panel-body">
                    <p>
                        <asp:Panel runat="server" ID="Panel1" Width="100%" Height="350px" ScrollBars="Vertical">
                            <asp:GridView ID="gvApplicant" runat="server" AutoGenerateColumns="False"
                                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                GridLines="None" EnableTheming="True" AllowPaging="false" AllowSorting="true" OnRowCancelingEdit="gvApplicant_RowCancelingEdit" OnRowEditing="gvApplicant_RowEditing" OnRowUpdating="gvApplicant_RowUpdating"
                                OnRowDataBound="gvApplicant_RowDataBound" OnSorting="gvApplicant_Sorting">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Applicant Name" SortExpression="applicantname">
                                        <ItemTemplate>
                                            <asp:Label ID="lblapplName" runat="Server" Text='<%# Eval("applicantname") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtApplName" runat="Server" CssClass="clsApplicantBlue" Text='<%# Eval("applicantname") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="Applicant Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblApplId" runat="Server" Text='<%# Eval("appnameid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" />
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
