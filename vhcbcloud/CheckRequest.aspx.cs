using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class CheckRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
                BindCheckRequests();
            }
        }

        protected void BindProjects()
        {
            try
            {
                ddlProjFilter.DataSource = Project.GetProjects("GetAllProjects");
                ddlProjFilter.DataValueField = "projectId";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindAssociatedApplicants(int projectID)
        {
            try
            {
                ddlApplicantName.DataSource = CheckRequestData.GetApplicantByProjId(projectID);
                ddlApplicantName.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindCheckRequests()
        {
            try
            {
                gvCheckReq.DataSource = CheckRequestData.GetAllCheckRequests();
                gvCheckReq.DataBind();
            }
            catch (Exception ex)
            {
                 lblErrorMsg.Text = ex.Message;
            }
        }
        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                CheckRequestData.AddNewCheckRequest(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), Convert.ToInt32(ddlApplicantName.SelectedValue.ToString()), Convert.ToDecimal(txtAmt.Text), Convert.ToDateTime(txtVoucherDate.Text));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindAssociatedApplicants(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
        }

        protected void gvCheckReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCheckReq.PageIndex = e.NewPageIndex;
        }

        protected void gvCheckReq_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCheckReq.EditIndex = -1;
            BindCheckRequests();
        }

        protected void gvCheckReq_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCheckReq.EditIndex = e.NewEditIndex;
            BindCheckRequests();
        }

        protected void gvCheckReq_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int projectApplicantID = Convert.ToInt32(((Label)gvCheckReq.Rows[rowIndex].FindControl("lblProjapplId")).Text);
                decimal transAmt = Convert.ToDecimal(((TextBox)gvCheckReq.Rows[rowIndex].FindControl("txtTrAmount")).Text);
                DateTime dtVoucherDate = Convert.ToDateTime(((TextBox)gvCheckReq.Rows[rowIndex].FindControl("txtVouDate")).Text);

                CheckRequestData.UpdateCheckRequest(projectApplicantID, transAmt, dtVoucherDate);
                gvCheckReq.EditIndex = -1;
                BindCheckRequests();
                lblErrorMsg.Text = "Check request updated successfully";
                txtVoucherDate.Text = "";
                txtAmt.Text = "";
            }
            catch (Exception)
            {
                lblErrorMsg.Text = "Error updating the project name";
                lblErrorMsg.Visible = true;
            }
        }
    }
}