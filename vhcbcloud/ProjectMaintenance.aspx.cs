using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ProjectMaintenance : System.Web.UI.Page
    {
        string Pagename = "ProjectMaintenance";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);

            if (!IsPostBack)
            {
                ce_txtEventDate.SelectedDate = DateTime.Today;
                if (Request.QueryString["Type"] == "new")
                {
                    rdBtnSelection.SelectedIndex = 0;
                    RadioButtonSelectionChanged();
                }


                BindControls();
                DisplayControlsbasedOnSelection();
                if (Request.QueryString["ProjectId"] != null)
                {
                    //ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"];
                    ifProjectDesc.Src = "ProjectDesc.aspx?ProjectId=" + Request.QueryString["ProjectId"];
                    ProjectNotesSetUp(Request.QueryString["ProjectId"]);

                    PopulateForm(DataUtils.GetInt(Request.QueryString["ProjectId"]));
                }
                //BindApplicantsForCurrentProject(ddlEventEntity);
            }

            if (DataUtils.GetInt(hfProjectId.Value) != 0)
                GenerateTabs(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(hfProgramId.Value));

            GetRoleAuth();
            DataTable dtMgr = UserSecurityData.GetManagerByProjId(DataUtils.GetInt(Request.QueryString["ProjectId"]));
            if (dtMgr != null)

                if (dtMgr.Rows.Count > 0 && (dtMgr.Rows[0]["manager"].ToString() != "0") && ddlManager.SelectedIndex > 0)
                {
                    if ((DataUtils.GetInt(dtMgr.Rows[0]["manager"].ToString())) == DataUtils.GetInt(ddlManager.SelectedValue.ToString()))
                        divApproval.Visible = true;
                }
                else
                    divApproval.Visible = false;

        }

        protected void RoleReadOnly()
        {
            cbAddAddress.Enabled = false;
            cbAddProjectEvent.Enabled = false;
            cbAddTBDAddress.Enabled = false;
            cbAttachNewEntity.Enabled = false;
            cbDefaultAddress.Enabled = false;
            cbAddProjectName.Enabled = false;
            cbRelatedProjects.Enabled = false;
            rdBtnSelection.Enabled = false;
            btnAddMilestone.Visible = false;
            btnAddAddress.Visible = false;
            btnAddEntity.Visible = false;
            btnAddProjectName.Visible = false;
            btnAddRelatedProject.Visible = false;
            btnProjectSubmit.Visible = false;
            btnProjectUpdate.Visible = false;
            divApproval.Visible = false;
            
        }
        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }

        protected bool GetRoleAuth()
        {

            DataTable dtPrg = new DataTable();
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt != null)
            {
                DataTable dtGetUserSec = UserSecurityData.GetUserSecurityByUserId(DataUtils.GetInt(dt.Rows[0]["userid"].ToString()));

                if (dt.Rows.Count > 0)
                    if (dtGetUserSec.Rows.Count > 0)
                        if (dtGetUserSec.Rows[0]["usergroupid"].ToString() == "3")
                        {
                            RoleReadOnly();
                        }
                        else if (dtGetUserSec.Rows[0]["usergroupid"].ToString() == "1")
                        {
                            if (dtGetUserSec.Rows[0]["dfltprg"].ToString() != "")
                            {
                                dtPrg = UserSecurityData.GetProjectsByProgram(DataUtils.GetInt(dtGetUserSec.Rows[0]["dfltprg"].ToString()), DataUtils.GetInt(Request.QueryString["ProjectId"]));
                            }
                            if (dtPrg.Rows.Count <= 0)
                            {
                                RoleReadOnly();
                                return false;
                            }
                        }
            }
            return true;
        }


        private void ProjectNotesSetUp(string ProjectId)
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));
            ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + ProjectId + "&PageId=" + PageId;
            if (ProjectNotesData.IsNotesExist(PageId, DataUtils.GetInt(ProjectId)))
                btnProjectNotes1.ImageUrl = "~/Images/currentpagenotes.png";
            else
                btnProjectNotes1.ImageUrl = "~/Images/notes.png";
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
                ddlApplicantRole.ClearSelection();
                int ApplicantId = ProjectMaintenanceData.GetApplicantId(txtEntityDDL.Text);
                PopulateDropDown(ddlApplicantRole, ProjectMaintenanceData.GetApplicantAppRole(ApplicantId));
            }
        }

        #region Bind Controls
        private void BindControls()
        {
            BindLookUP(ddlProgram, 34);
            //BindLookUP(ddlEventProgram, 34);
            BindLookUP(ddlProjectType, 119);
            BindManagers();
            //BindPrimaryApplicants();
            //BindProjects(ddlProject);
            //BindProjects(ddlEventProject);
            //BindApplicants(ddlApplicantName);
            //BindLookUP(ddlEventSubCategory, 163);
            BindLookUP(ddlAdminMilestone, 163);
            EventProgramSelection();
            BindLookUP(ddlApplicantRole, 56);
            ddlApplicantRole.Items.Remove(ddlApplicantRole.Items.FindByValue("358"));
            //BindLookUP(ddlAddressType, 1);
            BindLookUP(ddlProjectGoal, 201);
            BindLookUP(ddlEntityRole, 170);
        }

        private void EventProgramSelection()
        {
            ddlProgramMilestone.Items.Clear();

            if (ddlProgram.SelectedItem.ToString() == "Admin")
                BindLookUP(ddlProgramMilestone, 157);
            else if (ddlProgram.SelectedItem.ToString() == "Housing")
                BindLookUP(ddlProgramMilestone, 160);
            else if (ddlProgram.SelectedItem.ToString() == "Conservation")
                BindLookUP(ddlProgramMilestone, 159);
            else if (ddlProgram.SelectedItem.ToString() == "Lead")
                BindLookUP(ddlProgramMilestone, 158);
            else if (ddlProgram.SelectedItem.ToString() == "Americorps")
                BindLookUP(ddlProgramMilestone, 161);
            else if (ddlProgram.SelectedItem.ToString() == "Viability")
                BindLookUP(ddlProgramMilestone, 162);
            //else if (ddlEventProgram.SelectedItem.ToString() == "Healthy Homes")
            //    BindLookUP(ddlEvent, 159);
            else
            {
                ddlProgramMilestone.Items.Clear();
                ddlProgramMilestone.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        private void BindApplicantsForCurrentProject(DropDownList ddlEventEntity)
        {
            try
            {
                ddlEventEntity.Items.Clear();
                ddlEventEntity.DataSource = ProjectMaintenanceData.GetCurrentProjectApplicants(DataUtils.GetInt(hfProjectId.Value));
                ddlEventEntity.DataValueField = "appnameid";
                ddlEventEntity.DataTextField = "applicantname";
                ddlEventEntity.DataBind();
                ddlEventEntity.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicantsForCurrentProject", "", ex.Message);
            }
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

        protected void BindRelatedProjects(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddList.DataValueField = "project_id_name";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        //private void BindPrimaryApplicants()
        //{
        //    try
        //    {
        //        ddlPrimaryApplicant.Items.Clear();
        //        ddlPrimaryApplicant.DataSource = ApplicantData.GetSortedApplicants();
        //        ddlPrimaryApplicant.DataValueField = "appnameid";
        //        ddlPrimaryApplicant.DataTextField = "Applicantname";
        //        ddlPrimaryApplicant.DataBind();
        //        ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
        //    }
        //}

        protected void BindManagers()
        {
            try
            {
                ddlManager.Items.Clear();
                ddlManager.DataSource = LookupValuesData.GetManagers();
                ddlManager.DataValueField = "UserId";
                ddlManager.DataTextField = "Name";
                ddlManager.DataBind();
                ddlManager.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindManagers", "", ex.Message);
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

        protected void BindApplicants(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ApplicantData.GetSortedApplicants();
                ddList.DataValueField = "appnameid";
                ddList.DataTextField = "Applicantname";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
            }
        }
        #endregion

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

        private void ClearForm()
        {
            Tabs.Controls.Clear();

            txtProjNum.Text = "";
            ddlProjectType.SelectedIndex = -1;
            ddlProgram.SelectedIndex = -1;
            //ddlAppStatus.SelectedIndex = -1;
            ddlManager.SelectedIndex = -1;
            //txtClosingDate.Text = "";
            //cbVerified.Checked = false;
            //ddlPrimaryApplicant.SelectedIndex = -1;
            txtPrimaryApplicant.Text = "";
            txtProjectName.Text = "";
            ddlProjectGoal.SelectedIndex = -1;
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProjectSelectionChanged();
        }

        private void ProjectSelectionChanged()
        {
            try
            {
                ClearForm();
                hfProjectId.Value = "";
                //if (ddlProject.SelectedIndex != 0)
                if (txtProjectNumDDL.Text != "")
                {
                    ibAwardSummary.Visible = true;
                    btnProjectNotes1.Visible = true;
                    ImgPreviousProject.Visible = true;
                    ImgNextProject.Visible = true;

                    dvTabs.Visible = true;
                    dvUpdate.Visible = true;
                    //string[] tokens = ddlProject.SelectedValue.ToString().Split('|');
                    //txtProjectName.Text = tokens[1];
                    hfProjectId.Value = GetProjectID(txtProjectNumDDL.Text).ToString();
                    //ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + ddlProject.SelectedValue.ToString();
                    ProjectNotesSetUp(hfProjectId.Value);
                    BindProjectInfoForm(DataUtils.GetInt(hfProjectId.Value));

                    //ProjectNames
                    dvNewProjectName.Visible = true;
                    //dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = true;
                    BindProjectNamesGrid();
                    cbAddProjectName.Checked = false;

                    //Address
                    dvNewAddress.Visible = true;
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = true;
                    BindAddressGrid();
                    cbAddAddress.Checked = false;

                    //Entity
                    dvNewEntity.Visible = true;
                    //dvEntity.Visible = false;
                    dvEntityGrid.Visible = true;
                    BindProjectEntityGrid();
                    cbAttachNewEntity.Checked = false;

                    //RelatedProjects
                    dvNewRelatedProjects.Visible = true;
                    //dvRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = true;
                    // BindRelatedProjects(ddlRelatedProjects);
                    BindRelatedProjectsGrid();
                    cbRelatedProjects.Checked = false;

                    //ProjectEvent
                    dvNewProjectEvent.Visible = true;
                    //dvProjectEventGrid.Visible = true;
                    //BindPrjectEventGrid();
                    dvMilestoneGrid.Visible = true;
                    BindMilestoneGrid();
                    cbAddProjectEvent.Checked = false;
                }
                else
                {
                    ibAwardSummary.Visible = false;
                    btnProjectNotes1.Visible = false;
                    ImgPreviousProject.Visible = false;
                    ImgNextProject.Visible = false;

                    dvTabs.Visible = false;
                    dvUpdate.Visible = false;

                    //ProjectNames
                    dvNewProjectName.Visible = false;
                    //dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = false;

                    //Address
                    dvNewAddress.Visible = false;
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = false;

                    //Entity
                    dvNewEntity.Visible = false;
                    // dvEntity.Visible = false;
                    dvEntityGrid.Visible = false;

                    //RelatedProjects
                    dvNewRelatedProjects.Visible = false;
                    //dvRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = false;

                    //ProjectEvent
                    dvNewProjectEvent.Visible = false;
                    //dvProjectEventGrid.Visible = false;
                    dvMilestoneGrid.Visible = false;
                }

            }
            catch (Exception ex)
            {
                LogError(Pagename, "ProjectSelectionChanged", "", ex.Message);
            }
        }

        private int GetProjectID(string ProjectNum)
        {
            return ProjectMaintenanceData.GetProjectId(ProjectNum);
        }

        private void BindProjectNamesGrid()
        {
            try
            {
                DataTable dtProjectNames = ProjectMaintenanceData.GetProjectNames(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtProjectNames.Rows.Count > 0)
                {
                    dvProjectNamesGrid.Visible = true;
                    gvProjectNames.DataSource = dtProjectNames;
                    gvProjectNames.DataBind();
                }
                else
                {
                    dvProjectNamesGrid.Visible = false;
                    gvProjectNames.DataSource = null;
                    gvProjectNames.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectNamesGrid", "", ex.Message);
            }
        }

        private void BindAddressGrid()
        {
            try
            {
                DataTable dtAddress = ProjectMaintenanceData.GetProjectAddressList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtAddress.Rows.Count > 0)
                {
                    dvAddressGrid.Visible = true;
                    gvAddress.DataSource = dtAddress;
                    gvAddress.DataBind();
                }
                else
                {
                    dvAddressGrid.Visible = false;
                    gvAddress.DataSource = null;
                    gvAddress.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAddressGrid", "", ex.Message);
            }
        }

        private void BindProjectInfoForm(int ProjectId)
        {
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(ProjectId);
            PopulateDropDown(ddlProgram, drProjectDetails["LkProgram"].ToString());
            //ddlProgram.Enabled = false;
            hfProgramId.Value = drProjectDetails["LkProgram"].ToString();
            GenerateTabs(ProjectId, DataUtils.GetInt(drProjectDetails["LkProgram"].ToString()));
            //PopulateDropDown(ddlAppStatus, drProjectDetails["LkAppStatus"].ToString());
            PopulateDropDown(ddlManager, drProjectDetails["Manager"].ToString());
            txtPrimaryApplicant.Text = drProjectDetails["AppName"].ToString();
            //PopulateDropDown(ddlPrimaryApplicant, drProjectDetails["AppNameId"].ToString());
            PopulateDropDown(ddlProjectType, drProjectDetails["LkProjectType"].ToString());
            chkApprove.Checked = Convert.ToBoolean(drProjectDetails["verified"].ToString());
            dtApprove.Text = drProjectDetails["VerifiedDate"].ToString();
            txtProjectName.Text = drProjectDetails["projectName"].ToString();
            txtProjectName.Enabled = false;
            //txtClosingDate.Text = drProjectDetails["ClosingDate"].ToString() == "" ? "" : Convert.ToDateTime(drProjectDetails["ClosingDate"].ToString()).ToShortDateString();
            //cbVerified.Checked = DataUtils.GetBool(drProjectDetails["verified"].ToString());

            PopulateDropDown(ddlProjectGoal, drProjectDetails["Goal"].ToString());
            ShowConservationOnly();
            //Event Form
            SetEventProjectandProgram();
        }

        private void GenerateTabs(int ProjectId, int ProgramId)
        {
            Tabs.Controls.Clear();
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop selected");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "ProjectMaintenance.aspx");
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabsForViability(DataUtils.GetInt(hfProjectId.Value), ProgramId);
            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                li1.Attributes.Add("class", "RoundedCornerTop");
                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", dr["URL"].ToString() + "?ProjectId=" + ProjectId + "&ProgramId=" + ProgramId);
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                anchor1.InnerText = dr["TabName"].ToString();
                li1.Controls.Add(anchor1);
            }
        }

        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue == item.Value.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButtonSelectionChanged();
        }

        private void RadioButtonSelectionChanged()
        {
            //ddlProject.SelectedIndex = -1;
            txtProjectNumDDL.Text = "";
            DisplayControlsbasedOnSelection();

            dvUpdate.Visible = false;
            divApproval.Visible = false;
            //ProjectNames
            dvNewProjectName.Visible = false;
            //dvProjectName.Visible = false;
            dvProjectNamesGrid.Visible = false;

            //Address
            dvNewAddress.Visible = false;
            //dvAddress.Visible = false;
            dvAddressGrid.Visible = false;

            //Entity
            dvNewEntity.Visible = false;
            //dvEntity.Visible = false;
            dvEntityGrid.Visible = false;

            //RelatedProjects
            dvNewRelatedProjects.Visible = false;
            //dvRelatedProjects.Visible = false;
            dvRelatedProjectsGrid.Visible = false;

            //ProjectEvent
            dvNewProjectEvent.Visible = false;
            //dvProjectEventGrid.Visible = false;
            dvMilestoneGrid.Visible = false;
        }

        private void DisplayControlsbasedOnSelection()
        {
            ClearForm();
            ShowConservationOnly();
            if (rdBtnSelection.SelectedValue.ToLower().Trim() == "new")
            {
                cbAddTBDAddress.Visible = true;
                ibAwardSummary.Visible = false;
                btnProjectNotes1.Visible = false;
                ImgPreviousProject.Visible = false;
                ImgNextProject.Visible = false;

                txtProjNum.Visible = true;
                //ddlProject.Visible = false;
                txtProjectNumDDL.Visible = false;
                ddlProgram.Enabled = true;
                txtProjectName.Enabled = true;
                btnProjectUpdate.Visible = false;
                dvSubmit.Visible = true;
                cbActiveOnly.Visible = false;
            }
            else
            {
                cbAddTBDAddress.Visible = false;

                txtProjNum.Visible = false;
                //ddlProject.Visible = true;
                txtProjectNumDDL.Visible = true;
                btnProjectUpdate.Visible = true;
                dvSubmit.Visible = false;
                cbActiveOnly.Visible = true;
                cbActiveOnly.Checked = true;

                //ProjectNames
                dvNewProjectName.Visible = false;
                // dvProjectName.Visible = false;
                dvProjectNamesGrid.Visible = false;

                //Address
                dvNewAddress.Visible = false;
                //dvAddress.Visible = false;
                dvAddressGrid.Visible = false;

                //Entity
                dvNewEntity.Visible = false;
                //dvEntity.Visible = false;
                dvEntityGrid.Visible = false;

                //RelatedProjects
                dvNewRelatedProjects.Visible = false;
                //dvRelatedProjects.Visible = false;
                dvRelatedProjectsGrid.Visible = false;

                //ProjectEvent
                dvNewProjectEvent.Visible = false;
                //dvProjectEventGrid.Visible = false;
                dvMilestoneGrid.Visible = false;
            }
        }

        protected void btnProjectSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsProjectInfoFormValid(false))
                {
                    AddProject ap = ProjectMaintenanceData.AddProject(txtProjNum.Text, DataUtils.GetInt(ddlProjectType.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlProgram.SelectedValue.ToString()), DataUtils.GetInt(ddlManager.SelectedValue.ToString()),
                        txtPrimaryApplicant.Text, txtProjectName.Text, DataUtils.GetInt(ddlProjectGoal.SelectedValue.ToString()),
                        cbAddTBDAddress.Checked);

                    if (ap.IsDuplicate)
                        LogMessage("Project already exist");
                    else
                    {
                        LogMessage("Project added successfully");
                        PopulateForm(ap.ProjectId);
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnProjectSubmit_Click", "", ex.Message);
            }
        }

        private void PopulateForm(int ProjectId)
        {
            ClearForm();
            //BindProjects(ddlProject);
            //BindProjects(ddlEventProject);
            rdBtnSelection.SelectedIndex = 1;
            RadioButtonSelectionChanged();
            //ddlProject.SelectedValue = ProjectId.ToString();
            txtProjectNumDDL.Text = GetProjectNumber(ProjectId);
            ProjectSelectionChanged();
        }

        private string GetProjectNumber(int ProjectId)
        {
            return ProjectMaintenanceData.GetProjectNum(ProjectId);
        }

        protected void btnProjectUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsProjectInfoFormValid(true))
                {
                    ProjectMaintenanceData.UpdateProject((DataUtils.GetInt(hfProjectId.Value)), DataUtils.GetInt(ddlProjectType.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlProgram.SelectedValue.ToString()), DataUtils.GetInt(ddlManager.SelectedValue.ToString()),
                        txtPrimaryApplicant.Text, txtProjectName.Text, DataUtils.GetInt(ddlProjectGoal.SelectedValue.ToString()), chkApprove.Checked);

                    this.BindProjectEntityGrid();

                    LogMessage("Project updated successfully");

                    GenerateTabs(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(hfProgramId.Value));

                    //ClearForm();
                    //ddlProject.SelectedIndex = -1;

                    //dvUpdate.Visible = false;

                    ////ProjectNames
                    //dvNewProjectName.Visible = false;
                    ////dvProjectName.Visible = false;
                    //dvProjectNamesGrid.Visible = false;

                    ////Address
                    //dvNewAddress.Visible = false;
                    ////dvAddress.Visible = false;
                    //dvAddressGrid.Visible = false;

                    ////Entity
                    //dvNewEntity.Visible = false;
                    //// dvEntity.Visible = false;
                    //dvEntityGrid.Visible = false;

                    ////RelatedProjects
                    //dvNewRelatedProjects.Visible = false;
                    ////dvRelatedProjects.Visible = false;
                    //dvRelatedProjectsGrid.Visible = false;
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnProjectUpdate_Click", "", ex.Message);
            }
        }

        protected void btnAddProjectName_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsProjectNameFormValid())
                {
                    ProjectMaintenanceData.AddProjectName(DataUtils.GetInt(hfProjectId.Value), txtProject_Name.Text, cbDefName.Checked);

                    ClearProjectNameForm();
                    // dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = true;
                    cbAddProjectName.Checked = false;
                    BindProjectNamesGrid();
                    BindProjectInfoForm(DataUtils.GetInt(hfProjectId.Value));
                    LogMessage("Project name added successfully");
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        private bool IsProjectNameFormValid()
        {
            if (txtProject_Name.Text.Trim() == "")
            {
                LogMessage("Enter Project Name");
                txtProject_Name.Focus();
                return false;
            }

            return true;
        }

        private void ClearProjectNameForm()
        {
            txtProject_Name.Text = "";
            cbDefName.Checked = true;
        }

        //protected void cbProjectName_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbAddProjectName.Checked)
        //        dvProjectName.Visible = true;
        //    else
        //        dvProjectName.Visible = false;
        //}

        #region gvProjectNames
        protected void gvProjectNames_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectNames.EditIndex = e.NewEditIndex;
            BindProjectNamesGrid();
        }

        protected void gvProjectNames_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string projectName = ((TextBox)gvProjectNames.Rows[rowIndex].FindControl("txtDescription")).Text;
            int typeid = Convert.ToInt32(((Label)gvProjectNames.Rows[rowIndex].FindControl("lblTypeId")).Text);
            bool isDefName = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkDefNamePN")).Checked);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkActiveEditPN")).Checked); ;

            ProjectMaintenanceData.UpdateProjectname(DataUtils.GetInt(hfProjectId.Value), typeid, projectName, isDefName, RowIsActive);
            gvProjectNames.EditIndex = -1;

            BindProjectNamesGrid();
            BindProjectInfoForm(DataUtils.GetInt(hfProjectId.Value));
            LogMessage("Project Name updated successfully");
        }

        protected void gvProjectNames_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProjectNames.EditIndex = -1;
            BindProjectNamesGrid();
        }

        protected void gvProjectNames_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkDefNamePN = e.Row.FindControl("chkDefNamePN") as CheckBox;
                        CheckBox chkActiveEditPN = e.Row.FindControl("chkActiveEditPN") as CheckBox;

                        if (chkDefNamePN.Checked)
                        {
                            chkDefNamePN.Enabled = false;
                            chkActiveEditPN.Enabled = false;
                        }
                        else
                        {
                            chkDefNamePN.Enabled = true;
                            chkActiveEditPN.Enabled = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectNames_RowDataBound", "", ex.Message);
            }
        }

        #endregion

        //protected void cbAddAddress_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbAddAddress.Checked)
        //        dvAddress.Visible = true;
        //    else
        //        dvAddress.Visible = false;
        //}

        //protected void gvAddress_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvAddress.EditIndex = -1;
        //    BindAddressGrid();
        //}

        //protected void gvAddress_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvAddress.EditIndex = e.NewEditIndex;
        //    BindAddressGrid();
        //}

        //protected void gvAddress_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int rowIndex = e.RowIndex;
        //    string projectName = ((TextBox)gvProjectNames.Rows[rowIndex].FindControl("txtDescription")).Text;
        //    int typeid = Convert.ToInt32(((Label)gvProjectNames.Rows[rowIndex].FindControl("lblTypeId")).Text);
        //    bool isDefName = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkDefName")).Checked);

        //    gvAddress.EditIndex = -1;
        //    BindAddressGrid();
        //    LogMessage("Address updated successfully");
        //}

        protected void btnAddAddress_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsAddressValid())
                {
                    int ProjectId = DataUtils.GetInt(hfProjectId.Value);
                    string Village = this.hfVillage.Value;
                    var value = HttpContext.Current.Request.Form["ctl00$MainContent$ddlVillages"];

                    if (btnAddAddress.Text.ToLower() == "update")
                    {
                        int addressId = Convert.ToInt32(hfAddressId.Value);

                        ProjectMaintenanceData.UpdateProjectAddress(ProjectId, addressId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, txtVillage.Text,
                            txtState.Text, txtZip.Text, txtCounty.Text, DataUtils.GetDecimal(txtLattitude.Text), DataUtils.GetDecimal(txtLongitude.Text),
                            cbActive.Checked, cbDefaultAddress.Checked, 26241 ); // int.Parse(ddlAddressType.SelectedValue.ToString()));

                        hfAddressId.Value = "";
                        btnAddAddress.Text = "Add";
                        LogMessage("Address updated successfully");
                    }
                    else //add
                    {
                        ProjectMaintResult objProjectMaintResult = ProjectMaintenanceData.AddProjectAddress(ProjectId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, txtVillage.Text,
                            txtState.Text, txtZip.Text, txtCounty.Text, DataUtils.GetDecimal(txtLattitude.Text), DataUtils.GetDecimal(txtLongitude.Text), cbDefaultAddress.Checked,
                            26241);// int.Parse(ddlAddressType.SelectedValue.ToString()));

                        btnAddAddress.Text = "Add";

                        if (objProjectMaintResult.IsDuplicate && !objProjectMaintResult.IsActive)
                            LogMessage("Address already exist as in-active");
                        else if (objProjectMaintResult.IsDuplicate)
                            LogMessage("Address already exist");
                        else
                            LogMessage("New Address added successfully");

                    }

                    gvAddress.EditIndex = -1;
                    BindAddressGrid();
                    ClearAddressForm();
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = true;
                    cbAddAddress.Checked = false;
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddAddress_Click", "", ex.Message);
            }
        }

        private void ClearAddressForm()
        {
            //ddlAddressType.SelectedIndex = -1;
            txtStreetNo.Text = "";
            txtAddress1.Text = "";
            txtAddress2.Text = "";
            txtTown.Text = "";
            txtState.Text = "";
            txtZip.Text = "";
            txtCounty.Text = "";
            txtLattitude.Text = "";
            txtLongitude.Text = "";
            cbActive.Checked = true;
            cbActive.Enabled = true;
            cbDefaultAddress.Checked = true;
            cbDefaultAddress.Enabled = true;
            ddlVillages.Items.Clear();
            txtVillage.Text = "";
        }

        protected void gvAddress_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            //gvAddress.EditIndex = -1;
            //BindAddressGrid();
            cbAddAddress.Checked = false;

            ClearAddressForm();
            btnAddAddress.Text = "Add";
            //dvAddress.Visible = false;
            gvAddress.EditIndex = -1;
            BindAddressGrid();
        }

        protected void gvAddress_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            gvAddress.EditIndex = e.NewEditIndex;
            BindAddressGrid();
        }

        protected void gvAddress_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvAddress_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddAddress.Text = "Update";
                    //dvAddress.Visible = true;
                    cbAddAddress.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[10].Controls[0].Visible = false;
                        Label lblAddressId = e.Row.FindControl("lblAddressId") as Label;
                        DataRow dr = ProjectMaintenanceData.GetProjectAddressDetailsById(DataUtils.GetInt(hfProjectId.Value), Convert.ToInt32(lblAddressId.Text));

                        hfAddressId.Value = lblAddressId.Text;

                        //PopulateDropDown(ddlAddressType, dr["LkAddressType"].ToString());
                        txtStreetNo.Text = dr["Street#"].ToString();
                        txtAddress1.Text = dr["Address1"].ToString();
                        txtAddress2.Text = dr["Address2"].ToString();
                        txtTown.Text = dr["Town"].ToString(); ;
                        txtState.Text = dr["State"].ToString();
                        txtZip.Text = dr["Zip"].ToString();
                        txtCounty.Text = dr["County"].ToString();
                        txtLattitude.Text = dr["latitude"].ToString();
                        txtLongitude.Text = dr["longitude"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbDefaultAddress.Checked = DataUtils.GetBool(dr["PrimaryAdd"].ToString());

                        if (dr["State"].ToString().ToLower() != "va")
                            txtVillage.Enabled = false;
                        else
                            txtVillage.Enabled = true;

                        txtVillage.Text = dr["village"].ToString();

                        ddlVillages.Items.Clear();
                        ddlVillages.DataSource = ProjectMaintenanceData.GetVillages(DataUtils.GetInt(dr["Zip"].ToString()));
                        ddlVillages.DataValueField = "village";
                        ddlVillages.DataTextField = "village";
                        ddlVillages.DataBind();
                        ddlVillages.Items.Insert(0, new ListItem("Select", ""));
                        PopulateDropDown(ddlVillages, dr["village"].ToString());

                        //ddlVillages.Items.Insert(0, dr["village"].ToString());
                        //this.hfVillage.Value = dr["village"].ToString();

                        if (cbDefaultAddress.Checked)
                        {
                            cbDefaultAddress.Enabled = false;
                            cbActive.Enabled = false;
                        }
                        else
                        {
                            cbDefaultAddress.Enabled = true;
                            cbActive.Enabled = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAddress_RowDataBound", "", ex.Message);
            }
        }

        protected void btnAddEntity_Click(object sender, EventArgs e)
        {
            if (IsProjectEntityFormValid())
            {
                bool isApplicant = false;

                if (ddlApplicantRole.SelectedItem.ToString() == "Primary Applicant" || ddlApplicantRole.SelectedItem.ToString() == "Secondary Applicant")
                    isApplicant = true;

                int ApplicantId = ProjectMaintenanceData.GetApplicantId(txtEntityDDL.Text);

                ProjectMaintenanceData.AddProjectApplicant(DataUtils.GetInt(hfProjectId.Value),
                    ApplicantId,
                    DataUtils.GetInt(ddlApplicantRole.SelectedValue.ToString()), isApplicant);

                //ddlApplicantName.SelectedIndex = -1;
                txtEntityDDL.Text = "";
                txtEntityDDL.Text = "";
                ddlEntityRole.SelectedIndex = -1;
                ddlApplicantRole.SelectedIndex = -1;

                LogMessage("Entity Attached Successfully");

                gvEntity.EditIndex = -1;
                BindProjectEntityGrid();
                // dvEntity.Visible = false;
                dvEntityGrid.Visible = true;
                cbAttachNewEntity.Checked = false;
            }
        }

        private bool IsProjectEntityFormValid()
        {
            //if (ddlApplicantName.Items.Count > 1 && ddlApplicantName.SelectedIndex == 0)
            if (txtEntityDDL.Text == "")
            {
                LogMessage("Select Entity Applicant Name");
                //ddlApplicantName.Focus();
                txtEntityDDL.Text = "";
                return false;
            }

            if (ddlApplicantRole.Items.Count > 1 && ddlApplicantRole.SelectedIndex == 0)
            {
                LogMessage("Select Applicant Role");
                ddlApplicantRole.Focus();
                return false;
            }
            return true;
        }

        private void BindProjectEntityGrid()
        {
            try
            {
                //BindApplicantsForCurrentProject(ddlEventEntity);

                DataTable dtProjectEntity = ProjectMaintenanceData.GetProjectApplicantList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtProjectEntity.Rows.Count > 0)
                {
                    dvEntityGrid.Visible = true;
                    gvEntity.DataSource = dtProjectEntity;
                    gvEntity.DataBind();
                }
                else
                {
                    dvEntityGrid.Visible = false;
                    gvEntity.DataSource = null;
                    gvEntity.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectEntityGrid", "", ex.Message);
            }
        }

        //protected void cbAttachNewEntity_CheckedChanged(object sender, EventArgs e)
        //{
        //    BindLookUP(ddlApplicantRole, 56);
        //    if (cbAttachNewEntity.Checked)
        //        dvEntity.Visible = true;
        //    else
        //        dvEntity.Visible = false;
        //}

        protected bool IsProjectInfoFormValid(bool isUpdate)
        {
            if (isUpdate)
            {
                //if (ddlProject.SelectedIndex == 0)
                if (txtProjectNumDDL.Text == "")
                {
                    LogMessage("Select Project Number");
                    txtProjectNumDDL.Focus();
                    //ddlProject.Focus();
                    return false;
                }
            }
            else
            {
                if (txtProjNum.Text.Trim() == "____-___-___")
                {
                    LogMessage("Enter Project Number");
                    txtProjNum.Focus();
                    return false;
                }
                else
                {
                    string ProjectNumber = new string(txtProjNum.Text.Where(c => char.IsDigit(c)).ToArray());
                    if (ProjectNumber.Length != 10)
                    {
                        LogMessage("Enter Valid Project Number");
                        txtProjNum.Focus();
                        return false;
                    }
                }
            }
            if (txtProjectName.Text.Trim() == "")
            {
                LogMessage("Enter Project Name");
                txtProjectName.Focus();
                return false;
            }

            if (txtPrimaryApplicant.Text == "")
            {
                LogMessage("Select Primary Applicant");
                txtPrimaryApplicant.Focus();
                return false;
            }

            if (ddlProgram.Items.Count > 1 && ddlProgram.SelectedIndex == 0)
            {
                LogMessage("Select Program");
                ddlProgram.Focus();
                return false;
            }

            if (ddlProjectType.Items.Count > 1 && ddlProjectType.SelectedIndex == 0)
            {
                LogMessage("Select Type");
                ddlProjectType.Focus();
                return false;
            }

            //if (txtClosingDate.Text.Trim() != "")
            //{
            //    if (!DataUtils.IsDateTime(txtClosingDate.Text.Trim()))
            //    {
            //        LogMessage("Enter valid Closing Date");
            //        txtClosingDate.Focus();
            //        return false;
            //    }
            //}
            return true;
        }

        protected void gvEntity_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEntity.EditIndex = -1;
            BindProjectEntityGrid();
        }

        protected void gvEntity_RowEditing(object sender, GridViewEditEventArgs e)
        {

            gvEntity.EditIndex = e.NewEditIndex;
            BindProjectEntityGrid();
        }

        protected void gvEntity_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectApplicantId = DataUtils.GetInt(((Label)gvEntity.Rows[rowIndex].FindControl("lblProjectApplicantID")).Text);
            bool isApplicant = Convert.ToBoolean(((CheckBox)gvEntity.Rows[rowIndex].FindControl("chkIsApplicant")).Checked);
            bool isFinLegal = Convert.ToBoolean(((CheckBox)gvEntity.Rows[rowIndex].FindControl("chkFinLegal")).Checked);
            int LkApplicantRole = DataUtils.GetInt(((DropDownList)gvEntity.Rows[rowIndex].FindControl("ddlLkApplicantRoleEntity")).SelectedValue.ToString());
            string LkApplicantRoleText = ((DropDownList)gvEntity.Rows[rowIndex].FindControl("ddlLkApplicantRoleEntity")).SelectedItem.ToString();
            bool isRowIsActive = Convert.ToBoolean(((CheckBox)gvEntity.Rows[rowIndex].FindControl("chkActiveEditEntity")).Checked);

            if (LkApplicantRoleText == "Primary Applicant" || LkApplicantRoleText == "Secondary Applicant")
                isApplicant = true;

            ProjectMaintenanceData.UpdateProjectApplicant(ProjectApplicantId, isApplicant, isFinLegal, LkApplicantRole, isRowIsActive);
            gvEntity.EditIndex = -1;

            BindProjectEntityGrid();

            LogMessage("Entity updated successfully");
        }

        protected void gvEntity_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlLkApplicantRoleEntity = (e.Row.FindControl("ddlLkApplicantRoleEntity") as DropDownList);
                    TextBox txtLkApplicantRoleEntity = (e.Row.FindControl("txtLkApplicantRoleEntity") as TextBox);
                    CheckBox chkIsApplicantEntity = e.Row.FindControl("chkIsApplicant") as CheckBox;
                    CheckBox chkActiveEditEntity = e.Row.FindControl("chkActiveEditEntity") as CheckBox;

                    if (txtLkApplicantRoleEntity != null)
                    {
                        BindLookUP(ddlLkApplicantRoleEntity, 56);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlLkApplicantRoleEntity.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkApplicantRoleEntity.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlLkApplicantRoleEntity.ClearSelection();
                                item.Selected = true;
                            }
                        }

                        if (txtLkApplicantRoleEntity.Text.ToLower() == "358")
                        {
                            ddlLkApplicantRoleEntity.Enabled = false;
                            chkIsApplicantEntity.Enabled = false;
                            chkActiveEditEntity.Enabled = false;
                        }
                        else
                        {
                            ddlLkApplicantRoleEntity.Enabled = true;
                            chkIsApplicantEntity.Enabled = true;
                            chkActiveEditEntity.Enabled = true;
                            ddlLkApplicantRoleEntity.Items.Remove(ddlLkApplicantRoleEntity.Items.FindByValue("358"));
                        }
                    }
                }
            }
        }

        protected void btnAddRelatedProject_Click(object sender, EventArgs e)
        {
            if (IsRelatedProjectFormValid())
            {
                //string[] tokens = ddlRelatedProjects.SelectedValue.ToString().Split('|');
                //txtProjectName.Text = tokens[1];
                int RelProjectId = ProjectMaintenanceData.GetProjectId(txtRelatedProjects.Text);

                if (RelProjectId == 0)
                {
                    LogMessage("Project doesn’t exist");
                    return;
                }
                if (hfProjectId.Value == RelProjectId.ToString())
                {
                    LogMessage("Related Project can't be same Project");
                    return;
                }

                ProjectMaintResult obProjectMaintResult = ProjectMaintenanceData.AddRelatedProject(DataUtils.GetInt(hfProjectId.Value), RelProjectId);

                if (obProjectMaintResult.IsDuplicate && !obProjectMaintResult.IsActive)
                    LogMessage("Related Project already exist as in-active");
                else if (obProjectMaintResult.IsDuplicate)
                    LogMessage("Related Project already exist");
                else
                    LogMessage("New Related Project added successfully");

                gvRelatedProjects.EditIndex = -1;
                BindRelatedProjectsGrid();
                ClearRelatedProjectsForm();
                // dvRelatedProjects.Visible = false;
                dvRelatedProjectsGrid.Visible = true;
                cbRelatedProjects.Checked = false;
            }
        }

        private bool IsRelatedProjectFormValid()
        {
            //if (ddlRelatedProjects.Items.Count > 1 && ddlRelatedProjects.SelectedIndex == 0)
            if (txtRelatedProjects.Text == "")
            {
                LogMessage("Select Related Project");
                txtRelatedProjects.Focus();
                return false;
            }
            return true;
        }

        private void BindRelatedProjectsGrid()
        {
            try
            {
                DataTable dtRelatedProjects = ProjectMaintenanceData.GetRelatedProjectList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtRelatedProjects.Rows.Count > 0)
                {
                    dvRelatedProjectsGrid.Visible = true;
                    gvRelatedProjects.DataSource = dtRelatedProjects;
                    gvRelatedProjects.DataBind();
                }
                else
                {
                    dvRelatedProjectsGrid.Visible = false;
                    gvRelatedProjects.DataSource = null;
                    gvRelatedProjects.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindRelatedProjectsGrid", "", ex.Message);
            }
        }

        private void ClearRelatedProjectsForm()
        {
            //ddlRelatedProjects.SelectedIndex = -1;
            txtRelatedProjects.Text = "";
            txtRelatedProjectName.Text = "";
        }

        //protected void cbRelatedProjects_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbRelatedProjects.Checked)
        //        dvRelatedProjects.Visible = true;
        //    else
        //        dvRelatedProjects.Visible = false;
        //}

        //protected void ddlRelatedProjects_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    txtRelatedProjectName.Text = "";
        //    DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(ddlRelatedProjects.SelectedValue.ToString()));
        //    txtRelatedProjectName.Text = dr["ProjectName"].ToString();
        //}

        //protected void cbAddProjectStatus_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbAddProjectStatus.Checked)
        //        dvProjectStatus.Visible = true;
        //    else
        //        dvProjectStatus.Visible = false;
        //}

        protected bool IsAddressValid()
        {
            //if (ddlAddressType.SelectedIndex == 0)
            //{
            //    LogMessage("Select Address Type");
            //    ddlAddressType.Focus();
            //    return false;
            //}

            if (txtStreetNo.Text.Trim() == "" && cbReqStreetNo.Checked)
            {
                LogMessage("Enter Street#");
                txtStreetNo.Focus();
                return false;
            }
            if (txtAddress1.Text.Trim() == "")
            {
                LogMessage("Enter Address1");
                txtAddress1.Focus();
                return false;
            }
            if (txtZip.Text.Trim() == "")
            {
                LogMessage("Enter Zip");
                txtZip.Focus();
                return false;
            }
            if (txtTown.Text.Trim() == "")
            {
                LogMessage("Enter Town");
                txtTown.Focus();
                return false;
            }
            if (txtState.Text.Trim() == "")
            {
                LogMessage("Enter State");
                txtState.Focus();
                return false;
            }
            return true;
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

        //[System.Web.Services.WebMethod()]
        //[System.Web.Script.Services.ScriptMethod()]
        //public static string[] GetAddress1(string prefixText, int count, string contextKey)
        //{
        //    DataTable dt = new DataTable();
        //    dt = ProjectMaintenanceData.GetAddress1(contextKey, prefixText);

        //    List<string> ProjNames = new List<string>();
        //    List<string> items = new List<string>(count);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        string str = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dt.Rows[i][0].ToString(), dt.Rows[i]["Address2"].ToString() 
        //            + '~' + dt.Rows[i]["State"].ToString() 
        //            + '~' + dt.Rows[i]["Zip"].ToString());
        //        items.Add(str);
        //        //ProjNames.Add(dt.Rows[i][0].ToString());
        //    }
        //    //return ProjNames.ToArray();
        //    return items.ToArray();
        //}

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAddress1(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectMaintenanceData.GetAddressDetails(prefixText);

            //List<string> ProjNames = new List<string>();
            List<string> items = new List<string>(count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dt.Rows[i]["Street#"].ToString()
                    + ' ' + dt.Rows[i]["Address1"].ToString() + ' ' + dt.Rows[i]["Town"].ToString(),
                    dt.Rows[i]["Street#"].ToString()
                    + '~' + dt.Rows[i]["Address1"].ToString()
                    + '~' + dt.Rows[i]["Address2"].ToString()
                    + '~' + dt.Rows[i]["State"].ToString()
                    + '~' + dt.Rows[i]["Zip"].ToString()
                    + '~' + dt.Rows[i]["Town"].ToString()
                    + '~' + dt.Rows[i]["County"].ToString()
                    + '~' + dt.Rows[i]["latitude"].ToString()
                    + '~' + dt.Rows[i]["longitude"].ToString()
                    + '~' + dt.Rows[i]["Village"].ToString()
                    );
                items.Add(str);
                //ProjNames.Add(dt.Rows[i][0].ToString());
            }
            //return ProjNames.ToArray();
            return items.ToArray();
        }

        [WebMethod]
        public static bool LookupProduct()
        {
            return true;
        }

        [WebMethod]
        public static string BindDropdownlist(string zip)
        {
            DataTable dt = ProjectMaintenanceData.GetVillages(DataUtils.GetInt(zip));

            List<KeyVal> listVillages = new List<KeyVal>();

            KeyVal objKeyVal0 = new KeyVal();
            objKeyVal0.ID = "";
            objKeyVal0.Name = "Select";
            listVillages.Insert(0, objKeyVal0);

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    KeyVal objKeyVal = new KeyVal();
                    objKeyVal.ID = dt.Rows[i]["village"].ToString();
                    objKeyVal.Name = dt.Rows[i]["village"].ToString();
                    listVillages.Insert(i + 1, objKeyVal);

                    //liststudent.Add(dt.Rows[i]["village"].ToString());
                    //liststudent.Add("Ramakrishna");
                }

            }
            JavaScriptSerializer jscript = new JavaScriptSerializer();
            return jscript.Serialize(listVillages);
        }

        protected void gvRelatedProjects_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRelatedProjects.EditIndex = -1;
            BindRelatedProjectsGrid();
        }

        protected void gvRelatedProjects_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                int RelProjectId = DataUtils.GetInt(((Label)gvRelatedProjects.Rows[rowIndex].FindControl("lblRelProjectId")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvRelatedProjects.Rows[rowIndex].FindControl("chkActiveEditPR")).Checked);

                ProjectMaintenanceData.UpdateRelatedProject(DataUtils.GetInt(hfProjectId.Value), RelProjectId, isActive);

                gvRelatedProjects.EditIndex = -1;

                BindRelatedProjectsGrid();

                LogMessage("Related Projects updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvRelatedProjects_RowUpdating", "", ex.Message);
            }

        }

        protected void gvRelatedProjects_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRelatedProjects.EditIndex = e.NewEditIndex;
            BindRelatedProjectsGrid();
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            if (hfProjectId.Value == "") return;

            this.BindProjectNamesGrid();
            this.BindAddressGrid();
            this.BindProjectEntityGrid();
            this.BindRelatedProjectsGrid();
            //this.BindPrjectEventGrid();
            this.BindMilestoneGrid();
        }

        [WebMethod]
        public static bool IsProjectNumberExist(string ProjectNumber)
        {
            bool isExist = ProjectMaintenanceData.IsProjectNumberExist(ProjectNumber);

            return isExist;
        }

        //protected void gvProjectEvent_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvProjectEvent.EditIndex = e.NewEditIndex;
        //    BindPrjectEventGrid();
        //}

        //protected void gvProjectEvent_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvProjectEvent.EditIndex = -1;
        //    BindPrjectEventGrid();
        //    ClearProjectEventForm();
        //    hfProjectEventID.Value = "";
        //    btnAddEvent.Text = "Add";
        //    cbAddProjectEvent.Checked = false;
        //}

        //protected void gvProjectEvent_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    try
        //    {
        //        if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
        //        {
        //            CommonHelper.GridViewSetFocus(e.Row);
        //            btnAddEvent.Text = "Update";
        //            cbAddProjectEvent.Checked = true;

        //            //Checking whether the Row is Data Row
        //            if (e.Row.RowType == DataControlRowType.DataRow)
        //            {
        //                e.Row.Cells[7].Controls[0].Visible = false;

        //                Label lblProjectEventID = e.Row.FindControl("lblProjectEventID") as Label;
        //                DataRow dr = ProjectMaintenanceData.GetProjectEventById(DataUtils.GetInt(lblProjectEventID.Text));

        //                hfProjectEventID.Value = lblProjectEventID.Text;
        //                //txtEventProjNum.Text = txtProjectNumDDL.Text; // ddlProject.SelectedItem.ToString(); // dr["ProjectID"].ToString();
        //                //PopulateDropDown(ddlEventProject, dr["ProjectID"].ToString());
        //                //PopulateDropDown(ddlEventProgram, dr["Prog"].ToString());
        //                //PopulateDropDown(ddlEventEntity, dr["ApplicantID"].ToString());
        //                PopulateDropDown(ddlEvent, dr["EventID"].ToString());
        //                PopulateDropDown(ddlEventSubCategory, dr["SubEventID"].ToString());
        //                txtEventDate.Text = dr["Date"].ToString() == "" ? "" : Convert.ToDateTime(dr["Date"].ToString()).ToShortDateString();
        //                txtNotes.Text = dr["Note"].ToString();
        //                chkProjectEventActive.Enabled = true;

        //                //ddlEventProgram.Enabled = false;
        //                //ddlEventProject.Enabled = false;
        //                //txtEventProjNum.Enabled = false;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "gvAppraisalInfo_RowDataBound", "", ex.Message);
        //    }
        //}

        //protected void btnAddEvent_Click(object sender, EventArgs e)
        //{
        //    if (IsProjectEventFormValid())
        //    {
        //        if (btnAddEvent.Text == "Add")
        //        {
        //            ProjectMaintResult obProjectMaintResult = ProjectMaintenanceData.AddProjectMilestone(txtProjectNumDDL.Text,
        //                DataUtils.GetInt(ddlProgram.SelectedValue.ToString()), 0,
        //                DataUtils.GetInt(ddlEvent.SelectedValue.ToString()), DataUtils.GetInt(ddlEventSubCategory.SelectedValue.ToString()),
        //                DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, GetUserId());

        //            ClearProjectEventForm();
        //            cbAddProjectEvent.Checked = false;

        //            BindPrjectEventGrid();

        //            if (obProjectMaintResult.IsDuplicate && !obProjectMaintResult.IsActive)
        //                LogMessage("Project Event already exist as in-active");
        //            else if (obProjectMaintResult.IsDuplicate)
        //                LogMessage("Project Event already exist");
        //            else
        //                LogMessage("New Project Event added successfully");
        //        }
        //        else
        //        {
        //            ProjectMaintenanceData.UpdateProjectMilestone(DataUtils.GetInt(hfProjectEventID.Value), 0,
        //              DataUtils.GetInt(ddlEvent.SelectedValue.ToString()), DataUtils.GetInt(ddlEventSubCategory.SelectedValue.ToString()),
        //              DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, GetUserId(), chkProjectEventActive.Checked);

        //            gvProjectEvent.EditIndex = -1;
        //            BindPrjectEventGrid();
        //            ClearProjectEventForm();
        //            btnAddEvent.Text = "Add";
        //            LogMessage("Project Event Updated Successfully");
        //        }
        //    }
        //}

        //private void ClearProjectEventForm()
        //{
        //    cbAddProjectEvent.Checked = false;

        //    SetEventProjectandProgram();
        //    //ddlEventEntity.SelectedIndex = -1;
        //    ddlEvent.SelectedIndex = -1;
        //    ddlEventSubCategory.SelectedIndex = -1;
        //    txtEventDate.Text = "";
        //    txtNotes.Text = "";
        //    //ddlEventProgram.Enabled = true;
        //    //ddlEventProject.Enabled = true;
        //    //txtEventProjNum.Enabled = true;
        //    chkProjectEventActive.Enabled = false;
        //}

        private void SetEventProjectandProgram()
        {
            //ddlEventProject.SelectedIndex = -1;
            //txtEventProjNum.Text = "";
            //ddlEventProgram.SelectedIndex = -1;
            //ddlEventProject.SelectedValue = hfProjectId.Value;
            //txtEventProjNum.Text = txtProjectNumDDL.Text; // ddlProject.SelectedItem.ToString();
            //PopulateDropDown(ddlEventProgram, hfProgramId.Value);
            EventProgramSelection();
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

        //private bool IsProjectEventFormValid()
        //{
        //    //if (ddlEventProgram.Items.Count > 1 && ddlEventProgram.SelectedIndex == 0)
        //    //{
        //    //    LogMessage("Select Event Program");
        //    //    ddlEventProgram.Focus();
        //    //    return false;
        //    //}

        //    ////if (ddlEventProject.Items.Count > 1 && ddlEventProject.SelectedIndex == 0)
        //    //if (txtEventProjNum.Text == "") 
        //    //{
        //    //    LogMessage("Select Event Project");
        //    //    txtEventProjNum.Focus();
        //    //    //ddlEventProject.Focus();
        //    //    return false;
        //    //}

        //    if (txtEventDate.Text.Trim() == "")
        //    {
        //        LogMessage("Enter Event Date");
        //        txtEventDate.Focus();
        //        return false;
        //    }
        //    else
        //    {
        //        if (!DataUtils.IsDateTime(txtEventDate.Text.Trim()))
        //        {
        //            LogMessage("Enter valid Event Date");
        //            txtEventDate.Focus();
        //            return false;
        //        }
        //    }
        //    return true;
        //}

        //protected void ddlEventProgram_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    EventProgramSelection();
        //}

        //private void EventProgramSelection()
        //{
        //    if (ddlProgram.SelectedItem.ToString() == "Admin")
        //        BindLookUP(ddlEvent, 157);
        //    else if (ddlProgram.SelectedItem.ToString() == "Housing")
        //        BindLookUP(ddlEvent, 160);
        //    else if (ddlProgram.SelectedItem.ToString() == "Conservation")
        //        BindLookUP(ddlEvent, 159);
        //    else if (ddlProgram.SelectedItem.ToString() == "Lead")
        //        BindLookUP(ddlEvent, 158);
        //    else if (ddlProgram.SelectedItem.ToString() == "Americorps")
        //        BindLookUP(ddlEvent, 161);
        //    else if (ddlProgram.SelectedItem.ToString() == "Viability")
        //        BindLookUP(ddlEvent, 162);
        //    //else if (ddlEventProgram.SelectedItem.ToString() == "Healthy Homes")
        //    //    BindLookUP(ddlEvent, 159);
        //    else
        //    {
        //        ddlEvent.Items.Clear();
        //        ddlEvent.Items.Insert(0, new ListItem("Select", "NA"));
        //    }
        //}

        //private void BindProjectEvent()
        //{
        //    try
        //    {
        //        ddlEvent.Items.Clear();
        //        ddlEvent.DataSource = ApplicantData.GetSortedApplicants();
        //        ddlEvent.DataValueField = "appnameid";
        //        ddlEvent.DataTextField = "Applicantname";
        //        ddlEvent.DataBind();
        //        ddlEvent.Items.Insert(0, new ListItem("Select", "NA"));
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindProjectEvent", "", ex.Message);
        //    }
        //}

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

        protected void ddlApplicantName_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlApplicantRole.ClearSelection();
            int ApplicantId = ProjectMaintenanceData.GetApplicantId(txtEntityDDL.Text);
            PopulateDropDown(ddlApplicantRole, ProjectMaintenanceData.GetApplicantAppRole(ApplicantId));
        }

        protected void ImgNextProject_Click(object sender, ImageClickEventArgs e)
        {
            int nextIndex;
            List<int> lstProjectId = Session["lstSearchResultProjectId"] as List<int>;

            if (lstProjectId != null)
            {
                int index = lstProjectId.FindIndex(a => a == DataUtils.GetInt(hfProjectId.Value));

                if (index == -1)
                    nextIndex = 0;
                if (index == lstProjectId.Count - 1)
                    nextIndex = index;
                else
                    nextIndex = index + 1;
                Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + lstProjectId[nextIndex]);
            }
            //Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + ProjectMaintenanceData.GetNextProjectId(txtProjectNumDDL.Text, 1));
        }

        protected void ImgPreviousProject_Click(object sender, ImageClickEventArgs e)
        {
            int nextIndex;
            List<int> lstProjectId = Session["lstSearchResultProjectId"] as List<int>;

            if (lstProjectId != null)
            {
                int index = lstProjectId.FindIndex(a => a == DataUtils.GetInt(hfProjectId.Value));

                if (index == -1)
                    nextIndex = 0;
                else if (index == 0)
                    nextIndex = index;
                else
                    nextIndex = index - 1;
                Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + lstProjectId[nextIndex]);
            }

            //Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + ProjectMaintenanceData.GetNextProjectId(txtProjectNumDDL.Text, 2));
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbers(prefixText);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumbersWithName(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbersWithName(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dt.Rows[i]["proj_num"].ToString(),
                    dt.Rows[i]["project_name"].ToString());
                ProjNumbers.Add(str);
                //ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
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

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetEntitiesByRole(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();
            dt = ApplicantData.GetSortedApplicants(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i][1].ToString() == contextKey)
                    ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAllVillages(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectMaintenanceData.GetAllVillages(prefixText); //.Replace("_","").Replace("-", ""));

            List<string> Villages = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Villages.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return Villages.ToArray();
        }

        protected void ddlProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfProgramId.Value = ddlProgram.SelectedValue.ToString();
            ShowConservationOnly();
        }

        private void ShowConservationOnly()
        {
            if (ddlProgram.SelectedItem != null)
            {
                if (ddlProgram.SelectedItem.Text.ToLower() == "conservation")
                    dvConserOnly.Visible = true;
                else
                    dvConserOnly.Visible = false;
            }
        }

        protected void ImgButtonAddressReport_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                    "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Project Address"));
        }

        protected void ImgMilestoneReport_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                    "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Project Milestone"));
        }

        protected void ImgNames_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Project Names"));
        }

        protected void ImgEntity_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Project Entities"));
        }

        protected void ImgRelatedProjests_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                  "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Project Related"));
        }

        //protected void ddlEvent_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlEvent.SelectedIndex > 0)
        //        ddlEventSubCategory.Enabled = false;
        //    else
        //        ddlEventSubCategory.Enabled = true;
        //}

        //protected void ddlEventSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlEventSubCategory.SelectedIndex > 0)
        //        ddlEvent.Enabled = false;
        //    else
        //        ddlEvent.Enabled = true;
        //}

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

        protected void gvMilestone_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void rdGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMilestoneGrid();
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

        protected void btnAddMilestone_Click(object sender, EventArgs e)
        {
            string URL = txtURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            MilestoneData.MilestoneResult obMilestoneResult = MilestoneData.AddMilestone(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(hfProgramId.Value),
                null,
                DataUtils.GetInt(ddlAdminMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlAdminSubMilestone.SelectedValue.ToString()),
                DataUtils.GetInt(ddlProgramMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlProgramSubMilestone.SelectedValue.ToString()),
                0, 0,
                DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, URL, GetUserId());

            ClearEntityAndCommonForm();
            cbAddProjectEvent.Checked = false;
            BindMilestoneGrid();

            if (obMilestoneResult.IsDuplicate && !obMilestoneResult.IsActive)
                LogMessage("Milestone Event already exist as in-active");
            else if (obMilestoneResult.IsDuplicate)
                LogMessage("Milestone already exist");
            else
                LogMessage("New milestone added successfully");
        }

        private void ClearEntityAndCommonForm()
        {
            ddlAdminMilestone.SelectedIndex = -1;
            ddlAdminSubMilestone.SelectedIndex = -1;
            ddlProgramMilestone.SelectedIndex = -1;
            ddlProgramSubMilestone.SelectedIndex = -1;
            txtEventDate.Text = "";
            txtURL.Text = "";
            txtNotes.Text = "";

            AdminMilestoneChanged();
            ProgramMilestoneChanged();
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

        protected void ddlAdminMilestone_SelectedIndexChanged(object sender, EventArgs e)
        {
            AdminMilestoneChanged();
        }

        protected void ddlProgramMilestone_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProgramMilestoneChanged();
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
    }

    public class KeyVal
    {
        public string ID { get; set; }
        public string Name { get; set; }

    }
}