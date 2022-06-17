using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class DefaultSecurityValues : System.Web.UI.Page
    {
        private int SECURITY_PAGE = 193;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDLPage();
                BindLookUP(ddlSecFunctions, 246);
                BindUserPageSecurity();
                pnlHide.Visible = true;
                BindUserFxnSecurity();
                pnlSecFunctions.Visible = true;

            }
        }

        protected void BindDDLPage()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetPageSecurityBySelection(SECURITY_PAGE);
                ddlPage.DataValueField = "typeid";
                ddlPage.DataTextField = "description";
                ddlPage.DataSource = dt;
                ddlPage.DataBind();
                ddlPage.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnPageSecurity_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlPage.SelectedIndex <= 0)
                {
                    lblErrorMsg.Text = "Please select page to add an action";
                    return;
                }

                UserSecurityData.AddDefaultPageSecurity(Convert.ToInt32(ddlPage.SelectedValue.ToString()));
                BindUserPageSecurity();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnSecFunctions_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlSecFunctions.SelectedIndex <= 0)
                {
                    lblErrorMsg.Text = "Please select security function to add an action";
                    return;
                }

                UserSecurityData.AddDefaultFxnSecurity(Convert.ToInt32(ddlSecFunctions.SelectedValue.ToString()));
                BindUserFxnSecurity();
                ddlSecFunctions.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvPageSecurity_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;

            DataTable dt = UserSecurityData.GetuserPageSecurity(Convert.ToInt32(hfUserId.Value));

            gvPageSecurity.DataSource = SortDataTable(dt, false);
            gvPageSecurity.DataBind();
            gvPageSecurity.PageIndex = pageIndex;
        }

        protected void gvPageSecurity_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblDefPageTypeID = (Label)gvPageSecurity.Rows[rowIndex].FindControl("lblDefPageTypeID");
                if (lblDefPageTypeID != null)
                {
                    UserSecurityData.DeleteDefaultPageSecurity(Convert.ToInt32(lblDefPageTypeID.Text));
                    lblErrorMsg.Text = "User Page Security was deleted successfully";
                    BindUserPageSecurity();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvSecFunctions_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;

            DataTable dt = UserSecurityData.GetuserPageSecurity(Convert.ToInt32(hfUserId.Value));

            gvPageSecurity.DataSource = SortDataTable(dt, false);
            gvPageSecurity.DataBind();
            gvPageSecurity.PageIndex = pageIndex;
        }

        protected void gvSecFunctions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblUserFxnSecurityId = (Label)gvSecFunctions.Rows[rowIndex].FindControl("lblUserFxnSecurityId");
                if (lblUserFxnSecurityId != null)
                {
                    UserSecurityData.DeleteDefaultFxnSecurity(Convert.ToInt32(lblUserFxnSecurityId.Text));
                    lblErrorMsg.Text = "User Security Function was deleted successfully";
                    BindUserFxnSecurity();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
        private void BindUserPageSecurity()
        {

                DataTable dt = new DataTable();
                dt = UserSecurityData.GetDefaultUserPageSecurity();
                gvPageSecurity.DataSource = dt;
                gvPageSecurity.DataBind();
        }

        private void BindUserFxnSecurity()
        {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetDefaultUserFxnSecurity();
                gvSecFunctions.DataSource = dt;
                gvSecFunctions.DataBind();

        }

        private string GridViewSortExpression
        {
            get { return ViewState["SortExpression"] as string ?? string.Empty; }
            set { ViewState["SortExpression"] = value; }
        }

        private string GetSortDirection()
        {
            switch (GridViewSortDirection)
            {
                case "ASC":
                    GridViewSortDirection = "DESC";
                    break;

                case "DESC":
                    GridViewSortDirection = "ASC";
                    break;
            }

            return GridViewSortDirection;
        }

        private string GridViewSortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected DataView SortDataTable(DataTable dataTable, bool isPageIndexChanging)
        {

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (GridViewSortExpression != string.Empty)
                {
                    if (isPageIndexChanging)
                    {
                        Session["SortExp"] = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
                        dataView.Sort = Session["SortExp"].ToString();
                    }
                    else
                    {
                        Session["SortExp"] = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());
                        dataView.Sort = Session["SortExp"].ToString();
                    }
                }
                return dataView;
            }
            else
            {
                return new DataView();
            }
        } //eof SortDataTable
    }
}