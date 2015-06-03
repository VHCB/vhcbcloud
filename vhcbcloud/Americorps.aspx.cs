using System;
using System.Collections.Generic;
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

                Americorpsmembers.AddACContact(txtFName.Text, txtLName.Text);
                BindACContacts();
            }
            catch (Exception ex)
            {

                lblErrorMsg.Text = ex.Message ;
            }
        }


    }
}