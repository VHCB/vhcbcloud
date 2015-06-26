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
    public partial class Americorps : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindACContacts();
                GetApplicant();
            }
        }

        protected void BindACContacts()
        {
            try
            {
                gvAmeriCorps.DataSource = Americorpsmembers.GetAmericorps();
                gvAmeriCorps.DataBind();

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
        private void GetApplicant()
        {
            try
            {
                ddlApplicantName.DataSource = ApplicantData.GetApplicants();
                ddlApplicantName.DataValueField = "ApplicantID";
                ddlApplicantName.DataTextField = "Applicantname";
                ddlApplicantName.DataBind();
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
                Americorpsmembers.AddACContact(txtFName.Text, txtLName.Text, Convert.ToInt32(ddlApplicantName.SelectedValue.ToString() != "0" ? ddlApplicantName.SelectedValue.ToString() : "0"));
                lblErrorMsg.Text = "AC Contact added successfully";
                txtFName.Text = "";
                txtLName.Text = "";
                gvAmeriCorps.PageIndex = 0;
                BindACContacts();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvAmeriCorps_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAmeriCorps.EditIndex = -1;
            BindACContacts();
        }

        protected void gvAmeriCorps_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAmeriCorps.EditIndex = e.NewEditIndex;
            BindACContacts();
        }

        protected void gvAmeriCorps_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int contId = Convert.ToInt32(((Label)gvAmeriCorps.Rows[rowIndex].FindControl("lblcontId")).Text);
                string fName = ((TextBox)gvAmeriCorps.Rows[rowIndex].FindControl("txtFName")).Text;
                string LName = ((TextBox)gvAmeriCorps.Rows[rowIndex].FindControl("txtLName")).Text;
                Americorpsmembers.UpdateACContact(fName,LName,contId);
                gvAmeriCorps.EditIndex = -1;
                BindACContacts();
                lblErrorMsg.Text = "AC Contact updated successfully";
                txtFName.Text = "";
                txtLName.Text = "";
            }
            catch (Exception)
            {
                lblErrorMsg.Text = "Error updating the AC contact";
                lblErrorMsg.Visible = true;
            }
        }

        protected void gvAmeriCorps_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvAmeriCorps.EditIndex != -1)
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
                gvAmeriCorps.PageIndex = e.NewPageIndex;
                BindACContacts();
            }
        }

        protected void gvAmeriCorps_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = Americorpsmembers.GetAmericorps();
            SortDireaction = CommonHelper.GridSorting(gvAmeriCorps, dt, SortExpression, SortDireaction);
        }

        protected void gvAmeriCorps_RowDataBound(object sender, GridViewRowEventArgs e)
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
    }
}