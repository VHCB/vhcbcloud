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
                ddlApplicantName.DataSource = ApplicantData.GetSortedApplicants();
                ddlApplicantName.DataValueField = "appnameid";
                ddlApplicantName.DataTextField = "Applicantname";
                ddlApplicantName.DataBind();
                ddlApplicantName.Items.Insert(0, new ListItem("Select", "NA"));
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

        protected void gvProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvProject.EditIndex != -1)
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
                gvProject.PageIndex = e.NewPageIndex;
                BindGridWithSort();
            }
        }

      
        protected void gvProject_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = Project.GetProjects("GetAllProjects");
            SortDireaction = CommonHelper.GridSorting(gvProject, dt, SortExpression, SortDireaction);
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
        protected void BindGridWithSort()
        {
            DataTable dt = Project.GetProjects("GetAllProjects");
            SortDireaction = CommonHelper.GridSorting(gvProject, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);

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

        protected void gvProject_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string isDuplicate = Project.AddNewProject(txtPName.Text, txtProjNum.Text, Convert.ToInt32(ddlApplicantName.SelectedValue.ToString()));
                lblErrorMsg.Text = isDuplicate.ToLower() == "true" ? "Project already exist" : "Project saved successfully";
                txtPName.Text = "";
                txtProjNum.Text = "";
                gvProject.PageIndex = 0;
                BindSelectedProjects();
                ddlApplicantName.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectName(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjectName(prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add(dt.Rows[i][0].ToString());
            }
            return ProjNames.ToArray();
        }
    }
}