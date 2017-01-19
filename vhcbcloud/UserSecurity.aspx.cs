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
        private int SECURITY_PAGE = 193;
        private int SECURITY_FIELD = 194;
        private int SECURITY_ACTION = 195;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindVHCBUsers();
                BindSecurityGroups();
                BindUserSecurityGroups();
                BindUserPageSecuritySelections();
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

        private void BindUserPageSecurity()
        {
            if (hfUserId.Value != null)
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetuserPageSecurity(Convert.ToInt32(hfUserId.Value));
                gvPageSecurity.DataSource = dt;
                gvPageSecurity.DataBind();
            }
            else
            {
                gvPageSecurity.DataSource = null;
                gvPageSecurity.DataBind();
                lblErrorMsg.Text = "Select User to view the user page security permissions";
            }
        }

        private void BindUserPageSecuritySelections()
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

                dt = new DataTable();
                dt = UserSecurityData.GetPageSecurityBySelection(SECURITY_FIELD);
                ddlField.DataValueField = "typeid";
                ddlField.DataTextField = "description";
                ddlField.DataSource = dt;
                ddlField.DataBind();
                ddlField.Items.Insert(0, new ListItem("Select", "0"));

                dt = new DataTable();
                dt = UserSecurityData.GetPageSecurityBySelection(SECURITY_ACTION);
                ddlAction.DataValueField = "typeid";
                ddlAction.DataTextField = "description";
                ddlAction.DataSource = dt;
                ddlAction.DataBind();
                ddlAction.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        private void GetSelectedUserId(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rbGInfo = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelectDetail");
                if (rbGInfo != null)
                {
                    if (rbGInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedTransId"] = hf.Value;
                            hfUserId.Value = hf.Value;
                        }                        
                        break;
                    }
                }
            }
        }

        protected void rdBtnSelectDetail_CheckedChanged(object sender, EventArgs e)
        {
            GetSelectedUserId(gvUserSec);
            BindUserPageSecurity();
            pnlHide.Visible = true;
        }

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvPageSecurity_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblpagesecurityid = (Label)gvPageSecurity.Rows[rowIndex].FindControl("lblpagesecurityid");
                if (lblpagesecurityid != null)
                {
                    UserSecurityData.DeletePageSecurity(Convert.ToInt32(lblpagesecurityid.Text));
                    lblErrorMsg.Text = "User Page Security was deleted successfully";
                    BindUserPageSecurity();
                }
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
                if(ddlPage.SelectedIndex<=0)
                {
                    lblErrorMsg.Text = "Please select page to add an action";
                    return;
                }
                if(ddlAction.SelectedIndex<=0)
                {
                    lblErrorMsg.Text = "Please select Action to the selected page";
                    return;
                }
                UserSecurityData.AddUserPageSecurity(Convert.ToInt32(hfUserId.Value), Convert.ToInt32(ddlPage.SelectedValue.ToString()), Convert.ToInt32(ddlField.SelectedValue.ToString()), Convert.ToInt32(ddlAction.SelectedValue.ToString()));
                BindUserPageSecurity();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}