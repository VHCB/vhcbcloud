using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using System.Data;

namespace vhcbcloud
{
    public partial class BoardCommitment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
                BindLkStatus();
            }
        }

        protected void BindProjects()
        {
            try
            {
                ddlProjFilter.DataSource = Project.GetProjects("GetProjects");
                ddlProjFilter.DataValueField = "projectId";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindLkStatus()
        {
            try
            {
                ddlStatus.DataSource = FinancialTransactions.GetLKStatus();
                ddlStatus.DataValueField = "LookupType";
                ddlStatus.DataTextField = "Description";
                ddlStatus.DataBind();
                ddlStatus.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlProjFilter.SelectedIndex != 0)
                {
                    DataTable dt = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
                    lblProjName.Text = dt.Columns["Description"].ToString();
                    txtGrantee.Text = dt.Columns["Applicantname"].ToString();
                    txtTransDate.Text = dt.Columns["Date"].ToString();
                    txtTotAmt.Text = dt.Columns["TransAmt"].ToString();
                    ddlStatus.SelectedValue = dt.Columns["lkStatus"].ToString();
                }
                else
                {
                    lblErrorMsg.Text = "Select a project to proceed";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void gvBCommit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvBCommit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gvBCommit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvBCommit_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvBCommit_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvBCommit_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {

        }
    }
}