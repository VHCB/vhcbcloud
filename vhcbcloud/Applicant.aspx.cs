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
    public partial class Applicant : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindApplicants();
            }
        }

        protected void rdBtnIndividual_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlappl.Visible=true;
            if (rdBtnIndividual.SelectedItem.Text == "Yes")
            {
                tblIndividual.Visible = true;
                tblCorporate.Visible = false;
            }
            else
            {
                tblIndividual.Visible = false;
                tblCorporate.Visible = true;
            }
        }

        protected void BindApplicants()
        {
            try
            {
                gvApplicant.DataSource = ApplicantData.GetApplicants();
                gvApplicant.DataBind();
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
                if (rdBtnPayee.SelectedIndex<0)
                {
                    lblErrorMsg.Text = "Select payee or not.";
                    rdBtnPayee.Focus();
                    return;
                }
                if(rdBtnIndividual.SelectedIndex<0)
                {
                    lblErrorMsg.Text = "Select individual or not.";
                    rdBtnIndividual.Focus();
                    return;
                }

                bool isPayee = rdBtnPayee.SelectedItem.Text == "Yes" ? true : false;
                bool isIndividual = rdBtnIndividual.SelectedItem.Text == "Yes" ? true : false;
                if (isIndividual)
                    ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, txtLName.Text + ", " + txtFName.Text, isPayee, isIndividual);
                else
                    ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, txtApplicantName.Text, isPayee, isIndividual);
                
                lblErrorMsg.Text = "Applicant added successfully";
                txtApplicantName.Text = "";
                txtFName.Text = "";
                txtLName.Text = "";
                pnlappl.Visible = false;
                gvApplicant.PageIndex = 0;
                BindApplicants();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvApplicant_RowEditing(object sender, GridViewEditEventArgs e)
        {          
            gvApplicant.EditIndex = e.NewEditIndex;
            BindApplicants();
        }

        protected void gvApplicant_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvApplicant.EditIndex = -1;
            BindApplicants();
        }

        protected void gvApplicant_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int ApplId = Convert.ToInt32(((Label)gvApplicant.Rows[rowIndex].FindControl("lblApplId")).Text);
                string applName = ((TextBox)gvApplicant.Rows[rowIndex].FindControl("txtApplName")).Text;
                ApplicantData.UpdateApplicantName(ApplId, applName);
                gvApplicant.EditIndex = -1;
                BindApplicants();
                lblErrorMsg.Text = "Applicant updated successfully";
                txtApplicantName.Text = "";
                txtFName.Text = "";
                txtLName.Text = "";
                pnlappl.Visible = false;
            }
            catch (Exception)
            {
                lblErrorMsg.Text = "Error updating the project name";
                lblErrorMsg.Visible = true;
            }
        }

        protected void gvApplicant_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvApplicant.EditIndex != -1)
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
                gvApplicant.PageIndex = e.NewPageIndex;
                BindGridWithSort();
            }
        }

        protected void BindGridWithSort ()
        {
           DataTable dt = ApplicantData.GetApplicants();
           SortDireaction = CommonHelper.GridSorting(gvApplicant, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);
        }

        protected void gvApplicant_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        protected void gvApplicant_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = ApplicantData.GetApplicants();
            SortDireaction=CommonHelper.GridSorting(gvApplicant, dt, SortExpression, SortDireaction);
        }

        public string SortDireaction
        {
            get
            {
                if (ViewState["SortDireaction"] == null)
                    return string.Empty;
                else                    
                    return
                         ViewState["SortDireaction"].ToString() == "ASC" ? "DESC" : "ASC";
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