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
    public partial class CheckRequestDates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCheckRequests();
            }
        }

        protected void BindCheckRequests()
        {
            try
            {
                gvCheckReq.DataSource = CheckRequestData.GetAllCheckRequestDates();
                gvCheckReq.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                this.MasterPageFile = "SiteNonAdmin.Master";
            }
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
                BindGridWithSort();
            }
        }
        protected void BindGridWithSort()
        {
            DataTable dt = CheckRequestData.GetAllCheckRequestDates();
            SortDireaction = CommonHelper.GridSorting(gvCheckReq, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);

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
                DateTime dtVoucherDate = Convert.ToDateTime(((TextBox)gvCheckReq.Rows[rowIndex].FindControl("txtVouDate")).Text);

                CheckRequestData.UpdateCheckRequest(projectApplicantID, dtVoucherDate);
                gvCheckReq.EditIndex = -1;
                BindCheckRequests();
                lblErrorMsg.Text = "Check request updated successfully";
                txtVoucherDate.Text = "";
            }
            catch (Exception)
            {
                lblErrorMsg.Text = "Error updating the check request";
                lblErrorMsg.Visible = true;
            }
        }

        protected void gvCheckReq_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = CheckRequestData.GetAllCheckRequestDates();
            SortDireaction = CommonHelper.GridSorting(gvCheckReq, dt, SortExpression, SortDireaction);
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
                    return ViewState["SortDireaction"].ToString() == "ASC" ? "DESC" : "ASC";
            }
            set
            {
                ViewState["SortDireaction"] = value;
            }
        }

        public string SortExpression
        {
            get
            {
                if (ViewState["SortExpression"] == null)
                    return string.Empty;
                else
                    return ViewState["SortExpression"].ToString();
            }
            set
            {
                ViewState["SortExpression"] = value;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            try
            {
                CheckRequestData.AddNewCheckRequestDate(Convert.ToDateTime(txtVoucherDate.Text));
                lblErrorMsg.Text = "Check request was saved successfully" ;
                gvCheckReq.PageIndex = 0;
                BindCheckRequests();
                txtVoucherDate.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}