<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="VHCBConservationApp.Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
   
    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Use a local account to log in.</h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="UserId" CssClass="col-md-4 control-label">Enter Your Email Address</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="UserId" CssClass="form-control"  AutoPostBack="true" OnTextChanged="UserId_TextChanged"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="UserId"
                                CssClass="text-danger" ErrorMessage="The User Id field is required." />
                        </div>
                    </div>
                      <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlProjectNumber" CssClass="col-md-4 control-label">Enter Project Number</asp:Label>
                        <div class="col-md-6">
                              <asp:DropDownList ID="ddlProjectNumber" CssClass="form-select" runat="server" Height="23px" Width="185px"></asp:DropDownList>
                            <%--<asp:TextBox runat="server" ID="ProjectNumber" CssClass="form-control" />--%>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlProjectNumber"
                                CssClass="text-danger" ErrorMessage="The Project Number field is required." />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-4 control-label">Enter Your Password</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                  
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" ID="btnLogin" Text="Submit" CssClass="btn btn-info" OnClick="btnLogin_Click" />
                        </div>
                    </div>
                </div>
               <%-- <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p><p>
                     Enable this once you have account confirmation enabled for password reset functionality
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                   
                </p> --%>
            </section>
        </div>

        <%--<div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
            </section>
        </div>--%>
    </div>
</asp:Content>


