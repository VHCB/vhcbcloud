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
    public partial class UserSecurity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindVHCBUsers();
                BindSecurityGroups();
                BindUserSecurityGroups();
            }
        }

        protected void BindVHCBUsers()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetData("GetVHCBUser");
                ddlUserName.DataValueField = "userid";
                ddlUserName.DataTextField = "name";
                ddlUserName.DataSource = dt;
                ddlUserName.DataBind();
                ddlUserName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                throw ex;
            }
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

        private void BindUserSecurityGroups()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetData("GetUsersUserSecurityGroup");
                gvUserSec.DataSource = dt;
                gvUserSec.DataBind();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void ddlUserName_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlSecurityGroup_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvUserSec_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gvUserSec_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblUserId = (Label)gvUserSec.Rows[rowIndex].FindControl("lbluserid");
                if (lblUserId != null)
                {
                    UserSecurityData.DeleteUsersUserSecurityGroup(Convert.ToInt32(lblUserId.Text));
                    lblErrorMsg.Text = "User Security was deleted successfully";
                    BindUserSecurityGroups();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvUserSec_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvUserSec_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvUserSec_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvUserSec_RowCreated(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btnTransactionSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlSecurityGroup.SelectedIndex <= 0)
                {
                    lblErrorMsg.Text = "Please select security group.";
                    ddlSecurityGroup.Focus();
                    return;
                }
                if (ddlUserName.SelectedIndex <= 0)
                {
                    lblErrorMsg.Text = "Please select user name.";
                    ddlUserName.Focus();
                    return;
                }

                UserSecurityData.AddUsersToSecurityGroup(Convert.ToInt32(ddlUserName.SelectedValue.ToString()), Convert.ToInt32(ddlSecurityGroup.SelectedValue.ToString()));
                lblErrorMsg.Text = "User Security was added successfully";
                BindUserSecurityGroups();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void rdBtnSelectDetail_CheckedChanged(object sender, EventArgs e)
        {
            pnlHide.Visible = true;
        }

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}