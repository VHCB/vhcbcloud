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
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetApplicant();
                BindSelectedProjects();
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
        
        private void BindSelectedProjects()
        {
            try
            {
                gvProject.DataSource = Project.GetProjects("GetAllProjects");
                gvProject.DataBind();

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSelectedProjects();
        }

        protected void gvProject_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProject.EditIndex = -1;
            BindSelectedProjects();
        }

        protected void gvProject_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
               // int nameId = Convert.ToInt32(gvProject.Rows[rowIndex].Cells[2].Text == "" ? "0" : gvProject.Rows[rowIndex].Cells[2].Text);
                int nameId = Convert.ToInt32(((Label)gvProject.Rows[rowIndex].FindControl("lblNameId")).Text);
                string projName = ((TextBox)gvProject.Rows[rowIndex].FindControl("txtProjName")).Text;
                Project.UpdateProjectName(projName, nameId);
                gvProject.EditIndex = -1;
                BindSelectedProjects();
                lblErrorMsg.Text = "Project updated successfully";
                txtPName.Text = "";
                txtProjNum.Text = "";
            }
            catch (Exception)
            {
                lblErrorMsg.Text = "Error updating the project name";
                lblErrorMsg.Visible = true;
            }
        }

        protected void gvProject_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProject.EditIndex = e.NewEditIndex;
            BindSelectedProjects();
        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                Project.AddNewProject(txtPName.Text, txtProjNum.Text, Convert.ToInt32(ddlApplicantName.SelectedValue.ToString()));
                BindSelectedProjects();
                lblErrorMsg.Text = "Project saved successfully";
                txtPName.Text = "";
                txtProjNum.Text = "";

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        [System.Web.Script.Services.ScriptMethod]        
        [System.Web.Services.WebMethod]
        public static List<string> GetProjectName(string prefixText)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjectName(prefixText);
            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add(dt.Rows[i][1].ToString());
            }
            return ProjNames;
        }
    }
}