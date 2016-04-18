using DataAccessLayer;
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
    public partial class ProjectSearch : System.Web.UI.Page
    {
        string Pagename = "ProjectSearch";
        public string ProjectId = "9999";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            if (!IsPostBack)
            {
                dvSearchResults.Visible = false;
                BindControls();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlProgram, 34);
            BindLookUP(ddlProjectType, 119);
            BindPrimaryApplicants();
            BindProjectTowns();
            BindCounties();
        }

        private void BindLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
        }

        private void BindPrimaryApplicants()
        {
            try
            {
                ddlPrimaryApplicant.Items.Clear();
                
                if (cbPrimaryApplicant.Checked)
                    ddlPrimaryApplicant.DataSource = EntityData.GetApplicants("GetApplicant");
                else
                    ddlPrimaryApplicant.DataSource = EntityData.GetApplicants("GetPrimaryApplicants");

                ddlPrimaryApplicant.DataValueField = "appnameid";
                ddlPrimaryApplicant.DataTextField = "Applicantname";
                ddlPrimaryApplicant.DataBind();
                ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
            }
        }

        private void BindProjectTowns()
        {
            try
            {
                ddlTown.Items.Clear();
                ddlTown.DataSource = Project.GetProjectTowns();
                ddlTown.DataValueField = "Town";
                ddlTown.DataTextField = "Town";
                ddlTown.DataBind();
                ddlTown.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectTowns", "", ex.Message);
            }
        }

        private void BindCounties()
        {
            try
            {
                ddlCounty.Items.Clear();
                ddlCounty.DataSource = Project.GetCounties();
                ddlCounty.DataValueField = "county";
                ddlCounty.DataTextField = "county";
                ddlCounty.DataBind();
                ddlCounty.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounties", "", ex.Message);
            }
        }

        private void LogError(string pagename, string method, string message, string error)
        {
            dvMessage.Visible = true;
            if (message == "")
            {
                lblErrorMsg.Text = Pagename + ": " + method + ": Error Message: " + error;
            }
            else
                lblErrorMsg.Text = Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error;
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }
        
        protected void gvSearchresults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectProject")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                string ProjectId = ((Label)gvSearchresults.Rows[index].FindControl("lblProjectId")).Text;
                Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + ProjectId);
            }
        }

        protected void cbPrimaryApplicant_CheckedChanged(object sender, EventArgs e)
        {
            BindPrimaryApplicants();
        }

        protected void btnProjectSearch_Click(object sender, EventArgs e)
        {
            dvSearchResults.Visible = true;
            DataTable dt = ProjectSearchData.ProjectSearch(txtProjNum.Text, txtProjectName.Text, ddlPrimaryApplicant.SelectedValue.ToString(),
                ddlProgram.SelectedValue.ToString(), ddlProjectType.SelectedValue.ToString(), ddlTown.SelectedValue.ToString(),
                ddlCounty.SelectedValue.ToString());

            gvSearchresults.DataSource = dt;
            gvSearchresults.DataBind();
        }
    }
}