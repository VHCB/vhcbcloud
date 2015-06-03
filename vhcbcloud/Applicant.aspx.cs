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
            if(!IsPostBack)
            {
                BindApplicants();
            }
        }

        protected void rdBtnIndividual_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnSubmit.Visible = true;
            if (rdBtnIndividual.SelectedItem.Text=="Yes")
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
                gvApplicant.DataSource= ApplicantData.GetApplicants();
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
                bool isPayee = rdBtnPayee.SelectedItem.Text =="Yes" ? true : false;
                bool isIndividual = rdBtnIndividual.SelectedItem.Text =="Yes" ? true : false;
                ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, isPayee, isIndividual);
                BindApplicants();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text= ex.Message;
            }
        }
    }
}