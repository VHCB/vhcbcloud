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
                Americorpsmembers.AddACContact(txtFName.Text, txtLName.Text, Convert.ToInt32(ddlApplicantName.SelectedValue.ToString() != "0" ? ddlApplicantName.SelectedValue.ToString() : "0"));
                BindACContacts();
                lblErrorMsg.Text = "AC Contact added successfully";
                txtFName.Text = "";
                txtLName.Text = "";
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


    }
}