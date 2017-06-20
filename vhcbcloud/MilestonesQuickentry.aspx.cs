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
    public partial class MilestonesQuickentry : System.Web.UI.Page
    {
        string Pagename = "MilestonesQuickentry";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);

            if (!IsPostBack)
            {
                BindControls();
                DisplayControlsbasedOnSelection();
                BindMilestoneGrid();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtProjectNumDDL, "OnBlur");
            txtProjectNumDDL.Attributes.Add("onblur", onBlurScript);

            var onBlurScript1 = Page.ClientScript.GetPostBackEventReference(txtEntityDDL, "OnBlur");
            txtEntityDDL.Attributes.Add("onblur", onBlurScript1);
        }

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtProjectNumDDL.UniqueID && args == "OnBlur")
            {
                ProjectSelectionChanged();
            }
            if (ctrlName == txtEntityDDL.UniqueID && args == "OnBlur")
            {
                EntitySelectionChanged();
            }
        }

        private void EntitySelectionChanged()
        {
            try
            {
                if (txtEntityDDL.Text != "")
                {
                    BindEntityMilestoneGrid();
                }
                else
                {

                    BindEntityMilestoneGrid();
                }

            }
            catch (Exception ex)
            {
                LogError(Pagename, "EntitySelectionChanged", "", ex.Message);
            }
        }

        private void ProjectSelectionChanged()
        {
            try
            {
                //ClearForm();
                //hfProjectId.Value = "";

                if (txtProjectNumDDL.Text != "")
                {
                    hfProjectId.Value = GetProjectID(txtProjectNumDDL.Text).ToString();
                    DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(DataUtils.GetInt(hfProjectId.Value));
                    hfProgramId.Value = drProjectDetails["LkProgram"].ToString();
                    spnProgram.InnerText = drProjectDetails["program"].ToString();
                    spnProjectName.InnerText = drProjectDetails["projectName"].ToString();
                    hfProjectProgram.Value = drProjectDetails["program"].ToString();
                    EventProgramSelection();
                    BindMilestoneGrid();
                }
                else
                {
                    hfProjectId.Value = "";
                    hfProgramId.Value = "";
                    spnProgram.InnerText = "";
                    spnProjectName.InnerText = "";
                    hfProjectProgram.Value = "";
                    EventProgramSelection();
                    BindMilestoneGrid();
                }

            }
            catch (Exception ex)
            {
                LogError(Pagename, "ProjectSelectionChanged", "", ex.Message);
            }
        }

        private void ClearForm()
        {
            txtProjectNumDDL.Text = "";
            hfProjectId.Value = "";
            hfProjectProgram.Value = "";
            hfProgramId.Value = "";
            spnProgram.InnerText = "";
            spnProjectName.InnerText = "";
            txtEntityDDL.Text = "";
            ClearEntityAndCommonForm();
        }

        private void ClearEntityAndCommonForm()
        {
            ddlEntityMilestone.SelectedIndex = -1;
            ddlEntitySubMilestone.SelectedIndex = -1;
            ddlAdminMilestone.SelectedIndex = -1;
            ddlAdminSubMilestone.SelectedIndex = -1;
            ddlProgramMilestone.SelectedIndex = -1;
            ddlProgramSubMilestone.SelectedIndex = -1;
            txtEventDate.Text = "";
            txtURL.Text = "";
            txtNotes.Text = "";

            AdminMilestoneChanged();
            ProgramMilestoneChanged();
            EntityMilestoneChanged();
        }

        private int GetProjectID(string ProjectNum)
        {
            return ProjectMaintenanceData.GetProjectId(ProjectNum);
        }

        private void BindControls()
        {
            BindLookUP(ddlAdminMilestone, 163);
            BindLookUP(ddlEntityMilestone, 206);

            EventProgramSelection();
        }

        private void EventProgramSelection()
        {
            ddlProgramMilestone.Items.Clear();

            if (hfProjectProgram.Value == "Admin")
                BindLookUP(ddlProgramMilestone, 157);
            else if (hfProjectProgram.Value == "Housing")
                BindLookUP(ddlProgramMilestone, 160);
            else if (hfProjectProgram.Value == "Conservation")
                BindLookUP(ddlProgramMilestone, 159);
            else if (hfProjectProgram.Value == "Lead")
                BindLookUP(ddlProgramMilestone, 158);
            else if (hfProjectProgram.Value == "Americorps")
                BindLookUP(ddlProgramMilestone, 161);
            else if (hfProjectProgram.Value == "Viability")
                BindLookUP(ddlProgramMilestone, 162);
            //else if (ddlEventProgram.SelectedItem.ToString() == "Healthy Homes")
            //    BindLookUP(ddlEvent, 159);
            else
            {
                ddlProgramMilestone.Items.Clear();
                ddlProgramMilestone.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        private void BindSubLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.GetSubLookupValues(LookupType);
                ddList.DataValueField = "SubTypeID";
                ddList.DataTextField = "SubDescription";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindMilestoneGrid();
            BindEntityMilestoneGrid();
        }

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButtonSelectionChanged();
        }

        private void RadioButtonSelectionChanged()
        {
            txtProjectNumDDL.Text = "";
            hfProjectId.Value = "";
            hfProjectId.Value = "";
            hfProjectProgram.Value = "";
            txtEntityDDL.Text = "";
            DisplayControlsbasedOnSelection();
        }

        private void DisplayControlsbasedOnSelection()
        {
            ClearForm();

            if (rdBtnSelection.SelectedValue.ToLower().Trim() == "project")
            {
                dvEventMilestone.Visible = false;
                dvProjectMilestone.Visible = true;
            }
            else
            {
                dvEventMilestone.Visible = true;
                dvProjectMilestone.Visible = false;
            }
            rdGrid.SelectedIndex = 0;
            dvPMFilter.Visible = false;
            dvMilestoneGrid.Visible = false;
            dvEntityMilestoneGrid.Visible = false;
        }

        protected void ddlAdminMilestone_SelectedIndexChanged(object sender, EventArgs e)
        {
            AdminMilestoneChanged();
        }

        private void AdminMilestoneChanged()
        {
            if (ddlAdminMilestone.SelectedIndex != 0)
            {
                dvProgram.Visible = false;
                dvAdmin.Visible = true;

                BindSubLookUP(ddlAdminSubMilestone, DataUtils.GetInt(ddlAdminMilestone.SelectedValue.ToString()));

                if (ddlAdminSubMilestone.Items.Count > 1)
                    dvSubAdmin.Visible = true;
                else
                    dvSubAdmin.Visible = false;
            }
            if (ddlAdminMilestone.SelectedIndex == 0 && ddlProgramMilestone.SelectedIndex == 0)
            {
                dvProgram.Visible = true;
                dvAdmin.Visible = true;
                dvSubAdmin.Visible = false;
                dvSubProgram.Visible = false;
            }
        }

        protected void ddlProgramMilestone_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProgramMilestoneChanged();
        }

        private void ProgramMilestoneChanged()
        {
            if (ddlProgramMilestone.SelectedIndex != 0)
            {
                dvProgram.Visible = true;
                dvAdmin.Visible = false;

                BindSubLookUP(ddlProgramSubMilestone, DataUtils.GetInt(ddlProgramMilestone.SelectedValue.ToString()));

                if (ddlProgramSubMilestone.Items.Count > 1)
                    dvSubProgram.Visible = true;
                else
                    dvSubProgram.Visible = false;
            }
            if (ddlAdminMilestone.SelectedIndex == 0 && ddlProgramMilestone.SelectedIndex == 0)
            {
                dvProgram.Visible = true;
                dvAdmin.Visible = true;
                dvSubAdmin.Visible = false;
                dvSubProgram.Visible = false;
            }
        }

        protected void btnAddMilestone_Click(object sender, EventArgs e)
        {
            string URL = txtURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            MilestoneData.MilestoneResult obMilestoneResult = MilestoneData.AddMilestone(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(hfProgramId.Value),
                txtEntityDDL.Text,
                DataUtils.GetInt(ddlAdminMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlAdminSubMilestone.SelectedValue.ToString()),
                DataUtils.GetInt(ddlProgramMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlProgramSubMilestone.SelectedValue.ToString()),
                DataUtils.GetInt(ddlEntityMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlEntitySubMilestone.SelectedValue.ToString()),
                DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, URL, GetUserId());

            //ClearForm();
            ClearEntityAndCommonForm();
            //cbAddMilestone.Checked = false;

            if (rdBtnSelection.SelectedValue.ToLower().Trim() == "project")
                BindMilestoneGrid();
            else
                BindEntityMilestoneGrid();

            if (obMilestoneResult.IsDuplicate && !obMilestoneResult.IsActive)
                LogMessage("Milestone Event already exist as in-active");
            else if (obMilestoneResult.IsDuplicate)
                LogMessage("Milestone already exist");
            else
                LogMessage("New milestone added successfully");
        }

        private void BindMilestoneGrid()
        {
            try
            {
                DataTable dtMilestones = null;
                int RecCount = 0;
                dvPMFilter.Visible = false;

                if (DataUtils.GetInt(hfProjectId.Value) != 0)
                {
                    if (rdGrid.SelectedValue.ToLower().Trim() == "admin")
                        dtMilestones = MilestoneData.GetProgramMilestonesList(DataUtils.GetInt(hfProjectId.Value), false, true, false, cbActiveOnly.Checked);
                    else if (rdGrid.SelectedValue.ToLower().Trim() == "program")
                        dtMilestones = MilestoneData.GetProgramMilestonesList(DataUtils.GetInt(hfProjectId.Value), false, false, true, cbActiveOnly.Checked);
                    else
                        dtMilestones = MilestoneData.GetProgramMilestonesList(DataUtils.GetInt(hfProjectId.Value), true, false, false, cbActiveOnly.Checked);

                    RecCount = dtMilestones.Rows.Count;
                    dvPMFilter.Visible = true;
                }

                if (RecCount > 0)
                {
                    //dvPMFilter.Visible = true;
                    dvMilestoneGrid.Visible = true;
                    gvMilestone.DataSource = dtMilestones;
                    gvMilestone.DataBind();
                }
                else
                {
                    //dvPMFilter.Visible = false;
                    dvMilestoneGrid.Visible = false;
                    gvMilestone.DataSource = null;
                    gvMilestone.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMilestoneGrid", "", ex.Message);
            }
        }

        private void BindEntityMilestoneGrid()
        {
            try
            {
                DataTable dtMilestones = null;

                dtMilestones = MilestoneData.GetEventMilestonesList(txtEntityDDL.Text, cbActiveOnly.Checked);


                if (dtMilestones.Rows.Count > 0)
                {
                    dvEntityMilestoneGrid.Visible = true;
                    gvEntityMilestone.DataSource = dtMilestones;
                    gvEntityMilestone.DataBind();
                }
                else
                {
                    dvEntityMilestoneGrid.Visible = false;
                    gvEntityMilestone.DataSource = null;
                    gvEntityMilestone.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindEntityMilestoneGrid", "", ex.Message);
            }
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumbersWithName(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbersWithNameAndProjectType(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dt.Rows[i]["proj_num"].ToString(),
                    dt.Rows[i]["program_projectname"].ToString());
                ProjNumbers.Add(str);
                //ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbers(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetPrimaryApplicant(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ApplicantData.GetSortedApplicants(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        protected void ddlEntityMilestone_SelectedIndexChanged(object sender, EventArgs e)
        {
            EntityMilestoneChanged();
        }

        private void EntityMilestoneChanged()
        {
            ddlEntitySubMilestone.Items.Clear();

            if (ddlEntityMilestone.SelectedIndex != 0)
            {

                BindSubLookUP(ddlEntitySubMilestone, DataUtils.GetInt(ddlEntityMilestone.SelectedValue.ToString()));

                if (ddlEntitySubMilestone.Items.Count > 1)
                    dvSubEntityMilestone.Visible = true;
                else
                    dvSubEntityMilestone.Visible = false;
            }
            else
            {
                dvSubEntityMilestone.Visible = false;
            }
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

        protected void gvMilestone_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMilestone.EditIndex = -1;
            BindMilestoneGrid();
        }

        protected void gvMilestone_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMilestone.EditIndex = e.NewEditIndex;
            BindMilestoneGrid();
        }

        protected void rdGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMilestoneGrid();
        }

        protected void gvMilestone_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int ProjectEventID = Convert.ToInt32(((Label)gvMilestone.Rows[e.RowIndex].FindControl("lblProjectEventID")).Text);
                MilestoneData.DeleteMilestone(ProjectEventID);
                BindMilestoneGrid();
                LogMessage("Milestone Event deleted scuccessfully");
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvEntityMilestone_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int ProjectEventID = Convert.ToInt32(((Label)gvEntityMilestone.Rows[e.RowIndex].FindControl("lblProjectEventID")).Text);
                MilestoneData.DeleteMilestone(ProjectEventID);
                BindEntityMilestoneGrid();
                LogMessage("Milestone Event deleted scuccessfully");
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvMilestone_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectEventID = DataUtils.GetInt(((Label)gvMilestone.Rows[rowIndex].FindControl("lblProjectEventID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMilestone.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            MilestoneData.UpdateMilestone(ProjectEventID, RowIsActive);
            gvMilestone.EditIndex = -1;

            BindMilestoneGrid();

            LogMessage("Milestone updated successfully");
        }

        protected void gvEntityMilestone_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEntityMilestone.EditIndex = e.NewEditIndex;
            BindEntityMilestoneGrid();
        }

        protected void gvEntityMilestone_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEntityMilestone.EditIndex = -1;
            BindEntityMilestoneGrid();
        }

        protected void gvEntityMilestone_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectEventID = DataUtils.GetInt(((Label)gvEntityMilestone.Rows[rowIndex].FindControl("lblProjectEventID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvEntityMilestone.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            MilestoneData.UpdateMilestone(ProjectEventID, RowIsActive);
            gvEntityMilestone.EditIndex = -1;

            BindEntityMilestoneGrid();

            LogMessage("Milestone updated successfully");
        }
    }
}