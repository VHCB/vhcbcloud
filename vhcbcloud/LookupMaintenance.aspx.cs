﻿using System;
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
        private int _recordId = 0;
        public int recordId { get { return _recordId; } set { _recordId = value; } }

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
                recordId = Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString() == "" || ddlLkLookupViewname.SelectedValue.ToString() == "NA" ? "0" : ddlLkLookupViewname.SelectedValue.ToString());
                if (ddlLkLookupViewname.SelectedIndex == 0 || recordId == 0)
                    gvLookup.DataSource = LookupMaintenanceData.GetLkLookupDetails(0);
                else
                    gvLookup.DataSource = LookupMaintenanceData.GetLkLookupDetails(recordId);

                gvLookup.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindLKDescription()
        {
            try
            {
                recordId = Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString() == "" || ddlLkLookupViewname.SelectedValue.ToString() == "NA" ? "0" : ddlLkLookupViewname.SelectedValue.ToString());
                if (recordId == 0)
                    gvLkDescription.DataSource = null;
                else
                    gvLkDescription.DataSource = LookupMaintenanceData.GetLookupsById(recordId);
                gvLkDescription.DataBind();
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
                int typeId = Convert.ToInt32(((Label)gvLookup.Rows[rowIndex].FindControl("lbltypeid")).Text);
                string lkDescription = ((TextBox)gvLookup.Rows[rowIndex].FindControl("txtDesc")).Text;
                int recordId = Convert.ToInt32(((Label)gvLookup.Rows[rowIndex].FindControl("lblrecordId")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvLookup.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);

                LookupMaintenanceData.UpdateLookups(typeId, lkDescription, recordId, isActive);
                gvLookup.EditIndex = -1;
                BindLookupMaintenance();
                lblErrorMsg.Text = "Lookup details updated successfully";
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

        protected void BindGridWithSort()
        {
            recordId = Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString() == "" || ddlLkLookupViewname.SelectedValue.ToString() == "NA" ? "0" : ddlLkLookupViewname.SelectedValue.ToString());
               
            DataTable dt = new DataTable();
            if (ddlLkLookupViewname.SelectedIndex == 0)
                dt = LookupMaintenanceData.GetLkLookupDetails(0);
            else
                dt = LookupMaintenanceData.GetLkLookupDetails(recordId);

            SortDireaction = CommonHelper.GridSorting(gvLookup, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);
        }

        protected void gvLookup_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            BindGridWithSort();
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
                BindGridWithSort();
            }
        }

        protected void gvLookup_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        protected void gvLkDescription_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLkDescription.EditIndex = -1;
            BindLKDescription();

        }

        protected void gvLkDescription_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLkDescription.EditIndex = e.NewEditIndex;
            BindLKDescription();
        }

        protected void gvLkDescription_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string lkDescription = ((TextBox)gvLkDescription.Rows[rowIndex].FindControl("txtlkDesc")).Text;
            int recordId = Convert.ToInt32(((Label)gvLkDescription.Rows[rowIndex].FindControl("lblRecordId")).Text);
            LookupMaintenanceData.UpdateLkDescription(recordId, lkDescription);
            gvLkDescription.EditIndex = -1;
            BindLookupMaintenance();
            BindLKDescription();
            lblErrorMsg.Text = "Lookup description updated successfully";
            txtDescription.Text = "";
        }

        protected void ddlLkLookupViewname_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            BindLookupMaintenance();
            BindLKDescription();
        }
    }
}