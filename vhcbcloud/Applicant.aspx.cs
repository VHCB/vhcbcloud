using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

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
                bool isPayee = rdBtnPayee.SelectedItem.Text == "Yes" ? true : false;
                bool isIndividual = rdBtnIndividual.SelectedItem.Text == "Yes" ? true : false;
                if (isIndividual)
                    ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, txtLName.Text + ", " + txtFName.Text, isPayee, isIndividual);
                else
                    ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, txtApplicantName.Text, isPayee, isIndividual);
                BindApplicants();
                lblErrorMsg.Text = "Applicant added successfully";
                txtApplicantName.Text = "";
                txtFName.Text = "";
                txtLName.Text = "";
                pnlappl.Visible = false;
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
            gvApplicant.PageIndex = e.NewPageIndex;
        }
    }
}