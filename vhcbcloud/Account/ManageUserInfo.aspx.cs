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
                BindVHCBProgram();
                BindSecurityGroups();
            }
        }

        protected void BindVHCBProgram()
        {
            try
            {
                DataTable table = AccountData.GetVHCBProgram();
                ddlVHCBProgram.DataSource = table;
                ddlVHCBProgram.DataValueField = "typeid";
                ddlVHCBProgram.DataTextField = "Description";
                ddlVHCBProgram.DataBind();
                ddlVHCBProgram.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ClearFields()
        {
            txtFname.Text = "";
            txtLname.Text = "";
            txtPassword.Text = "";
            txtCPassword.Text = "";
            txt1Email.Text = "";
        }

        protected void btnUserInfoSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int dfltPrg = 0, dfltSecGrp = 0;
                if (ddlVHCBProgram.SelectedIndex != 0)
                    dfltPrg = Convert.ToInt32(ddlVHCBProgram.SelectedValue.ToString());
                if (ddlSecurityGroup.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Please select security group";
                    return;
                }
                dfltSecGrp = Convert.ToInt32(ddlSecurityGroup.SelectedValue.ToString());
                AccountData.AddUserInfo(txtFname.Text, txtLname.Text, txtPassword.Text, txt1Email.Text, dfltPrg, dfltSecGrp);
                BindUserInfo();
                ClearFields();
                lblErrorMsg.Text = "User Information added successfully";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

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
            try
            {


                int rowIndex = e.RowIndex;

                int UserlId = Convert.ToInt32(((Label)gvUserInfo.Rows[rowIndex].FindControl("lblUserId")).Text);

                string strFirstName = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtFirstName")).Text.Trim();
                string strLastName = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtLastName")).Text.Trim();
                string strEmail = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtEmail")).Text.Trim();
                string strPassword = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtPassword")).Text.Trim();
                int dfltPgr = ((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditVhcbPrg")).SelectedIndex != 0 ? Convert.ToInt32(((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditVhcbPrg")).SelectedValue.ToString()) : 0;

                int dflSecGrp = ((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditSecGroup")).SelectedIndex != 0 ? Convert.ToInt32(((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditSecGroup")).SelectedValue.ToString()) : 0;
                AccountData.UpdateUserInfo(UserlId, strFirstName, strLastName, strPassword, strEmail, dfltPgr, dflSecGrp);

                gvUserInfo.EditIndex = -1;
                BindUserInfo();
                lblErrorMsg.Text = "User information updated successfully.";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
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
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit) CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlPrg = (e.Row.FindControl("ddlEditVhcbPrg") as DropDownList);
                   
                    TextBox txtPrg = (e.Row.FindControl("txtDfltPrg") as TextBox);
                    if (ddlPrg != null)
                    {
                        DataTable dtable = AccountData.GetVHCBProgram();
                        ddlPrg.DataSource = dtable;
                        ddlPrg.DataValueField = "typeid";
                        ddlPrg.DataTextField = "Description";
                        ddlPrg.DataBind();
                        ddlPrg.Items.Insert(0, new ListItem("Select", "NA"));
                        string itemToCompare = string.Empty;
                        if (txtPrg != null)
                            foreach (ListItem item in ddlPrg.Items)
                            {
                                itemToCompare = item.Text;
                                if (txtPrg.Text.ToLower() == itemToCompare.ToLower())
                                {
                                    ddlPrg.ClearSelection();
                                    item.Selected = true;
                                }
                            }
                    }

                    DropDownList ddlSecGrp = (e.Row.FindControl("ddlEditSecGroup") as DropDownList);
                    TextBox txtSecName = (e.Row.FindControl("txtDfltSecGroup") as TextBox);
                    if (ddlSecGrp != null)
                    {
                        DataTable dt = new DataTable();
                        dt = UserSecurityData.GetData("GetUserSecurityGroup");
                        ddlSecGrp.DataSource = dt;
                        ddlSecGrp.DataValueField = "usergroupid";
                        ddlSecGrp.DataTextField = "userGroupName";
                        ddlSecGrp.DataBind();
                        ddlSecGrp.Items.Insert(0, new ListItem("Select", "NA"));
                        string itemToCompare = string.Empty;
                        if (txtSecName != null)
                            foreach (ListItem item in ddlSecGrp.Items)
                            {
                                itemToCompare = item.Text;
                                if (txtSecName.Text.ToLower() == itemToCompare.ToLower())
                                {
                                    ddlSecGrp.ClearSelection();
                                    item.Selected = true;
                                }
                            }
                    }
                }
            }
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

        private void BindSecurityGroups()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetData("GetUserSecurityGroup");
                ddlSecurityGroup.DataSource = dt;
                ddlSecurityGroup.DataValueField = "usergroupid";
                ddlSecurityGroup.DataTextField = "userGroupName";
                ddlSecurityGroup.DataBind();
                ddlSecurityGroup.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void ddlSecurityGroup_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}