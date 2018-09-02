using DataAccessLayer;
using System;
using System.Data;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Lead;


namespace vhcbcloud.Lead
{
    public partial class ProjectLeadMilestones : System.Web.UI.Page
    {
        string Pagename = "ProjectLeadMilestones";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();

                BindControls();
                GetRoleAccess();
                BindGrids();
            }
            //GetRoleAuth();
        }

        protected bool GetIsVisibleBasedOnRole()
        {
            return DataUtils.GetBool(hfIsVisibleBasedOnRole.Value);
        }

        protected void GetRoleAccess()
        {

            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(DataUtils.GetInt(hfProjectId.Value));

            if (dr != null)
            {
                if (dr["usergroupid"].ToString() == "0") // Admin Only
                {
                    hfIsVisibleBasedOnRole.Value = "true";
                }
                else if (dr["usergroupid"].ToString() == "1") // Program Admin Only
                {
                    if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        hfIsVisibleBasedOnRole.Value = "true";
                    }
                }
                else if (dr["usergroupid"].ToString() == "2") //2. Program Staff  
                {
                    if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        if (Convert.ToBoolean(drProjectDetails["verified"].ToString()))
                        {
                            RoleViewOnlyExceptAddNewItem();
                            hfIsVisibleBasedOnRole.Value = "false";
                        }
                        else
                        {
                            hfIsVisibleBasedOnRole.Value = "true";
                        }
                    }
                }
                else if (dr["usergroupid"].ToString() == "3") // View Only
                {
                    RoleViewOnly();
                    hfIsVisibleBasedOnRole.Value = "false";
                }
            }
        }

        protected void RoleViewOnlyExceptAddNewItem()
        {
        }

        protected void RoleViewOnly()
        {
            btnSubmit.Visible = false;
        }

        //protected bool GetRoleAuth()
        //{
        //    bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
        //    if (!checkAuth)
        //        RoleReadOnly();
        //    return checkAuth;
        //}

        private void ProjectNotesSetUp()
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));

            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"] +
                    "&PageId=" + PageId;
                if (ProjectNotesData.IsNotesExist(PageId, DataUtils.GetInt(hfProjectId.Value)))
                    btnProjectNotes.ImageUrl = "~/Images/currentpagenotes.png";
            }
        }

        private void GenerateTabs()
        {
            string ProgramId = null;

            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

            //Active Tab
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + hfProjectId.Value);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabs(DataUtils.GetInt(ProgramId));

            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString().Contains("ProjectLeadMilestones.aspx"))
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                else
                    li1.Attributes.Add("class", "RoundedCornerTop");

                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", "../" + dr["URL"].ToString() + "?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                anchor1.InnerText = dr["TabName"].ToString();
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                li1.Controls.Add(anchor1);
            }
        }

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void BindControls()
        {
            BindLookUP(ddlMilestone, 154);
            BindBuildingNumbers();
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

        private void BindBuildingNumbers()
        {
            try
            {
                ddlBldgNumber.Items.Clear();
                ddlBldgNumber.DataSource = ProjectLeadOccupantsData.GetBuildingNumbers(DataUtils.GetInt(hfProjectId.Value));
                ddlBldgNumber.DataValueField = "LeadBldgID";
                ddlBldgNumber.DataTextField = "Building";
                ddlBldgNumber.DataBind();
                ddlBldgNumber.Items.Insert(0, new ListItem("Select", "NA"));

                //Unit Number Drop Down
                ddlUnitNumber.Items.Clear();
                ddlUnitNumber.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildingNumbers", "", ex.Message);
            }
        }

        private void BindBuildingUnitNumbers(int BuildingNo)
        {
            try
            {
                DataTable dt = ProjectLeadOccupantsData.GetBuildingUnitNumbers(BuildingNo);
                if (dt.Rows.Count > 0)
                {
                    ddlUnitNumber.Items.Clear();
                    ddlUnitNumber.DataSource = dt;
                    ddlUnitNumber.DataValueField = "LeadUnitID";
                    ddlUnitNumber.DataTextField = "Unit";
                    ddlUnitNumber.DataBind();
                    ddlUnitNumber.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else
                {
                    ddlUnitNumber.Items.Clear();
                    ddlUnitNumber.Items.Insert(0, new ListItem("No Units Found", "NA"));
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildingNumbers", "", ex.Message);
            }
        }
        
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddlMilestone.SelectedIndex == 0)
            {
                LogMessage("Select Milestone");
                ddlMilestone.Focus();
                return;
            }
            if (ddlBldgNumber.SelectedIndex == 0)
            {
                LogMessage("Select Building #");
                ddlBldgNumber.Focus();
                return;
            }
            if (string.IsNullOrWhiteSpace(txtDate.Text.ToString()) == true)
            {
                LogMessage("Enter Date");
                txtDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Date");
                    txtDate.Focus();
                    return;
                }
            }

            string URL = txtURL.Text;

            if (URL != "")
            {
                if (!URL.Contains("http"))
                    URL = "http://" + URL;
            }

            if (btnSubmit.Text == "Submit")
            {
                LeadMilestoneResult objLeadMilestoneResult = ProjectLeadMilestonesData.AddProjectLeadMilestone((DataUtils.GetInt(hfProjectId.Value)),
                    DataUtils.GetInt(ddlMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlUnitNumber.SelectedValue.ToString()), DataUtils.GetDate(txtDate.Text), URL);

                ClearMilestonesForm();
                BindGrids();

                if (objLeadMilestoneResult.IsDuplicate && !objLeadMilestoneResult.IsActive)
                    LogMessage("Milestone already exist for tihs XXXXX and XXXXX as in-active");
                else if (objLeadMilestoneResult.IsDuplicate)
                    LogMessage("Milestone already exist for tihs Bldg# and Unit#");
                else
                    LogMessage("Milestone Added Successfully");
            }
            else
            {
                ProjectLeadMilestonesData.UpdateProjectLeadMilestone(DataUtils.GetInt(hfLeadMilestoneID.Value), DataUtils.GetInt(ddlMilestone.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()), DataUtils.GetInt(ddlUnitNumber.SelectedValue.ToString()), DataUtils.GetDate(txtDate.Text),
                    URL, chkMilestoneActive.Checked);

                gvMilestone.EditIndex = -1;
                BindGrids();
                hfLeadMilestoneID.Value = "";
                ClearMilestonesForm();
                btnSubmit.Text = "Submit";

                LogMessage("Milestone Updated Successfully");
            }
        }

        #region Logs
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
        #endregion Logs

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        private void BindGrids()
        {
            BindMilestonesGrid();
        }

        protected void ddlBldgNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBuildingUnitNumbers(DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()));
        }

        protected void gvMilestone_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMilestone.EditIndex = e.NewEditIndex;
            BindMilestonesGrid();
        }

        protected void gvMilestone_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMilestone.EditIndex = -1;
            BindMilestonesGrid();
            ClearMilestonesForm();
            hfLeadMilestoneID.Value = "";
            btnSubmit.Text = "Submit";
            btnSubmit.Visible = true;
        }

        protected void gvMilestone_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnSubmit.Text = "Update";

                    if (DataUtils.GetBool(hfIsVisibleBasedOnRole.Value))
                        btnSubmit.Visible = true;
                    else
                        btnSubmit.Visible = false;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[7].Controls[1].Visible = false;

                        Label lblLeadMilestoneID = e.Row.FindControl("lblLeadMilestoneID") as Label;
                        DataRow dr = ProjectLeadMilestonesData.GetProjectLeadMilestoneById(DataUtils.GetInt(lblLeadMilestoneID.Text));

                        hfLeadMilestoneID.Value = lblLeadMilestoneID.Text;
                        PopulateDropDown(ddlMilestone, dr["LKMilestone"].ToString());
                        PopulateDropDown(ddlBldgNumber, dr["LeadBldgID"].ToString());
                        BindBuildingUnitNumbers(DataUtils.GetInt(dr["LeadBldgID"].ToString()));
                        PopulateDropDown(ddlUnitNumber, dr["LeadUnitID"].ToString());
                        txtDate.Text = dr["MSDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MSDate"].ToString()).ToShortDateString();
                        txtURL.Text = dr["URL"].ToString() ?? "";
                        chkMilestoneActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        chkMilestoneActive.Enabled = true;
                        //ddlBldgNumber.Enabled = false;
                        //ddlUnitNumber.Enabled = false;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvMilestone_RowDataBound", "", ex.Message);
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
        private void BindMilestonesGrid()
        {
            try
            {
                DataTable dt = ProjectLeadMilestonesData.GetProjectLeadMilestoneList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvMilestoneGrid.Visible = true;
                    gvMilestone.DataSource = dt;
                    gvMilestone.DataBind();
                    Session["dtMilestonesList"] = dt;
                }
                else
                {
                    dvMilestoneGrid.Visible = false;
                    gvMilestone.DataSource = null;
                    gvMilestone.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMilestonesGrid", "", ex.Message);
            }
        }

        private void ClearMilestonesForm()
        {
            ddlBldgNumber.SelectedIndex = -1;
            ddlUnitNumber.Items.Clear();
            //ddlUnitNumber.SelectedIndex = -1;
            ddlMilestone.SelectedIndex = -1;
            txtDate.Text = "";
            txtURL.Text = "";
            //ddlBldgNumber.Enabled = true;
            //ddlUnitNumber.Enabled = true;

            chkMilestoneActive.Checked = true;
            chkMilestoneActive.Enabled = false;
        }

        protected void ImgMilestoneReport_Click1(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                    "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Lead Milestones"));
        }
    }
}