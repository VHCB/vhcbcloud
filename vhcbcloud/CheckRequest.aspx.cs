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
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
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
                ddlApplicantName.DataValueField = "ApplicantId";
                ddlApplicantName.DataTextField = "ApplicantName";
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
                lblErrorMsg.Text = "View name details saved successfully";
                gvCheckReq.PageIndex = 0;
                BindCheckRequests();
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
            if (gvCheckReq.EditIndex != -1)
            {
                // Use the Cancel property to cancel the paging operation.
                e.Cancel = true;

                // Display an error message.
                int newPageNumber = e.NewPageIndex + 1;
                lblErrorMsg.Text = "Please update the record before moving to page " +
                  newPageNumber.ToString() + ".";
            }
            else
            {
                // Clear the error message.
                lblErrorMsg.Text = "";
                gvCheckReq.PageIndex = e.NewPageIndex;
                BindCheckRequests();
            }
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

        protected void gvCheckReq_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = LookupMaintenanceData.GetLkLookupDetails();
            SortDireaction = CommonHelper.GridSorting(gvCheckReq, dt, e, SortDireaction);
        }

        protected void gvCheckReq_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        public string SortDireaction
        {
            get
            {
                if (ViewState["SortDireaction"] == null)
                    return string.Empty;
                else
                    return ViewState["SortDireaction"].ToString();
            }
            set
            {
                ViewState["SortDireaction"] = value;
            }
        }
    }
}