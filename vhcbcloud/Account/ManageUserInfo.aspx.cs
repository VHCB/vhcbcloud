using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud.Account
{
    public partial class ManageUserInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserInfo();
            }
        }

        protected void BindUserInfo()
        {
            try
            {
                if (Session["SortExp"] == null)
                {
                    gvUserInfo.DataSource = AccountData.GetUserInfo();
                    gvUserInfo.DataBind();
                }
                else
                {
                    DataTable table = AccountData.GetUserInfo();
                    DataView view = table.DefaultView;
                    view.Sort = Session["SortExp"].ToString();
                    gvUserInfo.DataSource = view.ToTable();
                    gvUserInfo.DataBind();
                }
            }
            catch (Exception ex)
            {
                //lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnUserInfoSubmit_Click(object sender, EventArgs e)
        {
            AccountData.AddUserInfo(txtFname.Text, txtLname.Text, txtPassword.Text, txt1Email.Text);
            BindUserInfo();
        }

        protected void gvUserInfo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUserInfo.EditIndex = -1;
            BindUserInfo();
        }

        protected void gvUserInfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gvUserInfo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUserInfo.EditIndex = e.NewEditIndex;
            BindUserInfo();
        }

        protected void gvUserInfo_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int UserlId = Convert.ToInt32(((Label)gvUserInfo.Rows[rowIndex].FindControl("lblUserId")).Text);

            string strFirstName = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtFirstName")).Text.Trim();
            string strLastName = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtLastName")).Text.Trim();
            string strEmail = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtEmail")).Text.Trim();
            string strPassword = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtPassword")).Text.Trim();

            AccountData.UpdateUserInfo(UserlId, strFirstName, strLastName, strPassword, strEmail);

            gvUserInfo.EditIndex = -1;
            BindUserInfo();
        }

        protected void gvUserInfo_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;
            gvUserInfo.DataSource = SortDataTable(AccountData.GetUserInfo(), false);
            gvUserInfo.DataBind();
            gvUserInfo.PageIndex = pageIndex;
        }

        protected void gvUserInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
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
    }
}