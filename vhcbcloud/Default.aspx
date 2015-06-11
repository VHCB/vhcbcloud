<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="vhcbcloud._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">

        <p class="lead">VHCB Projects</p>
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

            <asp:TextBox ID="txtPName" CssClass="clsTextBoxBlueSMDL" runat="server"></asp:TextBox>
            <ajaxToolkit:AutoCompleteExtender ID="aaceProjName" runat="server" TargetControlID="txtPName" MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1"
                CompletionInterval="1000" ServiceMethod="GetProjectName">
            </ajaxToolkit:AutoCompleteExtender>

            &nbsp;<span class="labelClass">Applicant :</span>
            <asp:DropDownList ID="ddlApplicantName" CssClass="clsDropDownLong" runat="server">
            </asp:DropDownList>
            <br />
            <br />
            <asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="~/Images/BtnSubmit.gif" TabIndex="3" OnClick="btnSubmit_Click" />
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

        <p>
            <asp:GridView ID="gvProject" runat="server" AutoGenerateColumns="False" DataKeyNames="nameId"
                Width="90%" CssClass="gridView" PageSize="50" PagerSettings-Mode="NextPreviousFirstLast"
                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvProject_RowCancelingEdit" OnRowEditing="gvProject_RowEditing" OnRowUpdating="gvProject_RowUpdating" OnPageIndexChanging="gvProject_PageIndexChanging">
                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                <HeaderStyle CssClass="headerStyle" />
                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                <RowStyle CssClass="rowStyle" />
                <Columns>
                    <asp:BoundField DataField="proj_num" HeaderText="Number" ReadOnly="True" SortExpression="proj_num" />
                     <asp:BoundField DataField="Applicantname" HeaderText="Applicant Name" ReadOnly="True" SortExpression="Applicantname" />
                    <asp:TemplateField HeaderText="Project Name">
                        <ItemTemplate>
                            <asp:Label ID="lblProjName" runat="Server" Text='<%# Eval("proj_name") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtProjName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("proj_name") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="proj_name" HeaderText="Name" SortExpression="proj_name" />--%>
                    <asp:TemplateField Visible="false" HeaderText="Name Id">
                        <ItemTemplate>
                            <asp:Label ID="lblNameId" runat="Server" Text='<%# Eval("nameid") %>' />
                        </ItemTemplate>
                        </asp:TemplateField>
                    <asp:BoundField DataField="nameid" HeaderText="Name ID" ReadOnly="True" Visible="false" SortExpression="nameid" />
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
                <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
        </p>
    </div>
</asp:Content>
