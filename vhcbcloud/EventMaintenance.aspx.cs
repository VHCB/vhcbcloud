using DataAccessLayer;
using Microsoft.AspNet.Identity;
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
    public partial class EventMaintenance : System.Web.UI.Page
    {
        string Pagename = "ProjectMaintenance";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                BindControls();
               
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlEventProgram, 34);
            BindProjects(ddlEventProject);

            //BindLookUP(ddlProgram, 34);
            
            //BindLookUP(ddlProjectType, 119);
            //BindManagers();
            //BindPrimaryApplicants();
            //BindProjects(ddlProject);
            
            //BindApplicants(ddlApplicantName);
            BindLookUP(ddlEventSubCategory, 163);
            //BindLookUP(ddlApplicantRole, 56);
            //ddlApplicantRole.Items.Remove(ddlApplicantRole.Items.FindByValue("358"));
            //BindLookUP(ddlAddressType, 1);
        }

        protected void BindProjects(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddList.DataValueField = "projectid";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
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

        private void BindApplicantsForCurrentProject(DropDownList ddlEventEntity)
        {
            try
            {
                //ddlEventEntity.Items.Clear();
                //ddlEventEntity.DataSource = ProjectMaintenanceData.GetCurrentProjectApplicants(DataUtils.GetInt(hfProjectId.Value));
                //ddlEventEntity.DataValueField = "appnameid";
                //ddlEventEntity.DataTextField = "applicantname";
                //ddlEventEntity.DataBind();
                //ddlEventEntity.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicantsForCurrentProject", "", ex.Message);
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

        protected void btnAddProjectName_Click(object sender, EventArgs e)
        {

        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {

        }

        protected void ddlEventProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            EventProgramSelection();
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void EventProgramSelection()
        {
            if (ddlEventProgram.SelectedItem.ToString() == "Admin")
                BindLookUP(ddlEvent, 157);
            else if (ddlEventProgram.SelectedItem.ToString() == "Housing")
                BindLookUP(ddlEvent, 160);
            else if (ddlEventProgram.SelectedItem.ToString() == "Conservation")
                BindLookUP(ddlEvent, 159);
            else if (ddlEventProgram.SelectedItem.ToString() == "Lead")
                BindLookUP(ddlEvent, 158);
            else if (ddlEventProgram.SelectedItem.ToString() == "Americorps")
                BindLookUP(ddlEvent, 161);
            else if (ddlEventProgram.SelectedItem.ToString() == "Viability")
                BindLookUP(ddlEvent, 162);
            //else if (ddlEventProgram.SelectedItem.ToString() == "Healthy Homes")
            //    BindLookUP(ddlEvent, 159);
            else
            {
                ddlEvent.Items.Clear();
                ddlEvent.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        private void ClearProjectEventForm()
        {
            cbAddProjectEvent.Checked = false;

            //SetEventProjectandProgram();
            ddlEventEntity.SelectedIndex = -1;
            ddlEvent.SelectedIndex = -1;
            ddlEventSubCategory.SelectedIndex = -1;
            txtEventDate.Text = "";
            txtNotes.Text = "";
            ddlEventProgram.Enabled = true;
            ddlEventProject.Enabled = true;
            chkProjectEventActive.Enabled = false;
        }

        //private void BindPrjectEventGrid()
        //{
        //    try
        //    {
        //        DataTable dtProjectEvents = ProjectMaintenanceData.GetProjectEventList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

        //        if (dtProjectEvents.Rows.Count > 0)
        //        {
        //            dvProjectEventGrid.Visible = true;
        //            gvProjectEvent.DataSource = dtProjectEvents;
        //            gvProjectEvent.DataBind();
        //        }
        //        else
        //        {
        //            dvProjectEventGrid.Visible = false;
        //            gvProjectEvent.DataSource = null;
        //            gvProjectEvent.DataBind();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindPrjectEventGrid", "", ex.Message);
        //    }
        //}

        private bool IsProjectEventFormValid()
        {
            if (ddlEventProgram.Items.Count > 1 && ddlEventProgram.SelectedIndex == 0)
            {
                LogMessage("Select Event Program");
                ddlEventProgram.Focus();
                return false;
            }

            if (ddlEventProject.Items.Count > 1 && ddlEventProject.SelectedIndex == 0)
            {
                LogMessage("Select Event Project");
                ddlEventProject.Focus();
                return false;
            }

            if (txtEventDate.Text.Trim() == "")
            {
                LogMessage("Enter Event Date");
                txtEventDate.Focus();
                return false;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtEventDate.Text.Trim()))
                {
                    LogMessage("Enter valid Event Date");
                    txtEventDate.Focus();
                    return false;
                }
            }
            return true;
        }

        protected int GetUserId()
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetUserByUserName(Context.User.Identity.GetUserName());
                return dtUser != null ? Convert.ToInt32(dtUser.Rows[0][0].ToString()) : 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}