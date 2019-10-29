<%@ Page Title="Loan Summary" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
    CodeBehind="LoanSummaryTemp.aspx.cs" Inherits="vhcbcloud.LoanSummaryTemp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron clearfix">

        <p class="lead">Loan Summary</p>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                   <%-- <span class="labelClass">Current Award Status for project: <b>
                        <asp:Label runat="server" ID="lblProjId"></asp:Label></b></span>--%>
                </div>
                <div class="panel-body">
                    <p class="labelClass">
                       <%-- <span class="labelClass">Project # :</span>--%>
                        <asp:DropDownList ID="ddlLoanDetails" CssClass="clsDropDown" AutoPostBack="true" runat="server" 
                            ></asp:DropDownList>
                        <asp:ImageButton ID="LoanSummaryReport" ImageUrl="~/Images/print.png" ToolTip="Loan Summary Report"
                                            Style="border: none; vertical-align: middle;" runat="server" OnClick="LoanSummaryReport_Click" />
                    </p>
                    <%--<iframe src="loansummary.aspx?projectid=13859&loanid=1215"></iframe>--%>
                </div>
               
            </div>
        </div>
    </div>
</asp:Content>