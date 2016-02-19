<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="vhcbcloud._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">

        <p class="lead">VHCB Projects</p>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <p>
                        <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDownLong" AutoPostBack="true" Visible="false" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                        </asp:DropDownList>

                    </p>
                    <p>
                        <span class="labelClass">New Project # :</span>
                        <asp:TextBox ID="txtProjNum" CssClass="clsTextBoxBlueSm" runat="server"></asp:TextBox>
                        <ajaxToolkit:MaskedEditExtender runat="server" ID="ameProjNum" Mask="9999-999-999" ClearMaskOnLostFocus="false"
                            MaskType="Number" TargetControlID="txtProjNum">
                        </ajaxToolkit:MaskedEditExtender>

                        &nbsp;<span class="labelClass">Name :</span>
                        <asp:TextBox ID="txtPName" CssClass="clsTextBoxBlueSMDL" Width ="500px" Height="22px" runat="server"></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtPName" MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1"
                            CompletionInterval="100" ServiceMethod="GetProjectName">
                        </ajaxToolkit:AutoCompleteExtender>
                        <br />
                        <span class="labelClass">Applicant :</span>
                        <asp:DropDownList ID="ddlApplicantName" CssClass="clsApplicantBlue" runat="server">
                        </asp:DropDownList>
                        <br />
                        <br />
                        <asp:LinkButton ID="btnSubmit" runat="server" class="btn btn-info" Text="Add new applicant" TabIndex="3" OnClick="btnSubmit_Click" />
                        <br />
                        <%--<ajaxToolkit:MaskedEditValidator ID="mevProjNum" runat="server" ControlExtender="ameProjNum"
                ControlToValidate="txtProjNum" Display="Dynamic" EmptyValueMessage="Project number is required"
                ErrorMessage="Project number is required" InvalidValueMessage="Invalid project number" 
                IsValidEmpty="false" CssClass="lblErrMsg"></ajaxToolkit:MaskedEditValidator>--%>
                        <%--<br />
            <asp:RequiredFieldValidator ID="rfvLname" runat="server" ErrorMessage="Project name required" CssClass="lblErrMsg" ControlToValidate="txtPName"></asp:RequiredFieldValidator>--%>
                    </p>
                    <p class="lblErrMsg">
                        <asp:Label runat="server" ID="lblErrorMsg"></asp:Label>
                    </p>
                </div>
                <div class="panel-body">
                    <p>
                        <asp:Panel runat="server" ID="Panel1" Width="100%" Height="350px" ScrollBars="Vertical">
                            <asp:GridView ID="gvProject" runat="server" AutoGenerateColumns="False" DataKeyNames="typeid"
                                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvProject_RowCancelingEdit"
                                OnRowEditing="gvProject_RowEditing" OnRowUpdating="gvProject_RowUpdating" OnPageIndexChanging="gvProject_PageIndexChanging" AllowSorting="true"
                                OnSorting="gvProject_Sorting" OnRowDataBound="gvProject_RowDataBound">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>
                                    <asp:BoundField DataField="proj_num" HeaderText="Number" ReadOnly="True" SortExpression="proj_num" />
                                    <asp:TemplateField HeaderText="Project Name" SortExpression="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProjName" runat="Server" Text='<%# Eval("Description") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtProjName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("Description") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Applicantname" HeaderText="Applicant Name" ReadOnly="True" SortExpression="Applicantname" />

                                    <%--<asp:BoundField DataField="proj_name" HeaderText="Name" SortExpression="proj_name" />--%>
                                    <asp:TemplateField Visible="false" HeaderText="Name Id" SortExpression="TypeID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNameId" runat="Server" Text='<%# Eval("TypeID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TypeID" HeaderText="Name ID" ReadOnly="True" Visible="false" SortExpression="TypeID" />
                                    <asp:CommandField ShowEditButton="True" />
                                </Columns>
                                <FooterStyle CssClass="footerStyle" />
                            </asp:GridView>
                        </asp:Panel>
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
