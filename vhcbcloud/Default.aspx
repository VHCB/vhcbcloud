<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="vhcbcloud._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        
        <p class="lead">VHCB Projects</p>
        <p>
            <asp:DropDownList ID="ddlProjFilter" CssClass="clsDropDownLong" AutoPostBack="true" Visible="false" runat="server" OnSelectedIndexChanged="ddlProjFilter_SelectedIndexChanged">
                                        </asp:DropDownList>
            
        </p>
        <p class="lblErrMsg"><asp:Label runat="server" ID="lblErrorMsg"></asp:Label></p>
        <p>
            <asp:GridView ID="gvProject" runat="server" AutoGenerateColumns="False" DataKeyNames="nameId"
                                Width="90%" CssClass="gridView" PageSize="15" PagerSettings-Mode="NextPreviousFirstLast"
                                GridLines="None" EnableTheming="True" AllowPaging="True" OnRowCancelingEdit="gvProject_RowCancelingEdit" OnRowEditing="gvProject_RowEditing" OnRowUpdating="gvProject_RowUpdating">
                                <AlternatingRowStyle CssClass="alternativeRowStyle" />
                                <PagerStyle CssClass="pagerStyle" ForeColor="#F78B0E" />
                                <HeaderStyle CssClass="headerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;" LastPageText="&amp;gt;" PageButtonCount="5" />
                                <RowStyle CssClass="rowStyle" />
                                <Columns>
                                    <asp:BoundField DataField="proj_num" HeaderText="Number" ReadOnly="True" SortExpression="proj_num" />
                                     <asp:TemplateField HeaderText="Project Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProjName" runat="Server" Text='<%# Eval("proj_name") %>' />
                                        </ItemTemplate>
                                         <EditItemTemplate>
                                             <asp:TextBox ID="txtProjName" runat="Server" CssClass="clsTextBoxBlueSMDL" Text='<%# Eval("proj_name") %>'></asp:TextBox>
                                         </EditItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="proj_name" HeaderText="Name" SortExpression="proj_name" />--%>
                                    <asp:BoundField DataField="nameid" HeaderText="Name ID" ReadOnly="True" SortExpression="nameid" />
                                    <asp:CommandField ShowEditButton="True" />
                                </Columns>
                                <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
        </p>
    </div>

    </asp:Content>
