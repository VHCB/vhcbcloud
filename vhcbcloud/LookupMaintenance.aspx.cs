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
    public partial class LookupMaintenance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLookupMaintenance();
                BindViewName();
            }
        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                LookupMaintenanceData.AddLookups(Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString()), txtDescription.Text);
                lblErrorMsg.Text = "View name details saved successfully";
                gvLookup.PageIndex = 0;
                BindLookupMaintenance();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindLookupMaintenance()
        {
            try
            {
                gvLookup.DataSource = LookupMaintenanceData.GetLkLookupDetails();
                gvLookup.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvLookup_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLookup.EditIndex = -1;
            BindLookupMaintenance();
        }

        protected void gvLookup_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLookup.EditIndex = e.NewEditIndex;
            BindLookupMaintenance();
        }

        protected void gvLookup_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int recordId = Convert.ToInt32(((Label)gvLookup.Rows[rowIndex].FindControl("lbltypeid")).Text);
                string lkDescription = ((TextBox)gvLookup.Rows[rowIndex].FindControl("txtDesc")).Text;
                LookupMaintenanceData.UpdateLookups(recordId, lkDescription);
                gvLookup.EditIndex = -1;
                BindLookupMaintenance();
                lblErrorMsg.Text = "Description updated successfully";
                txtDescription.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindViewName()
        {
            try
            {
                ddlLkLookupViewname.DataSource = LookupMaintenanceData.GetLookupsViewName();
                ddlLkLookupViewname.DataValueField = "RecordId";
                ddlLkLookupViewname.DataTextField = "Viewname";
                ddlLkLookupViewname.DataBind();
                ddlLkLookupViewname.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
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

        protected void gvLookup_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = LookupMaintenanceData.GetLkLookupDetails();
            SortDireaction = CommonHelper.GridSorting(gvLookup, dt, e, SortDireaction);
        }

        protected void gvLookup_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvLookup.EditIndex != -1)
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
                gvLookup.PageIndex = e.NewPageIndex;
                BindLookupMaintenance();
            }
        }

        protected void gvLookup_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }
    }
}