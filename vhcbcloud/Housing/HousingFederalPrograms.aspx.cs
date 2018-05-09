using DataAccessLayer;
using System;
using Microsoft.AspNet.Identity;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Housing;
using VHCBCommon.DataAccessLayer.Lead;
using System.IO;

namespace vhcbcloud.Housing
{
    public partial class HousingFederalPrograms : System.Web.UI.Page
    {
        string Pagename = "HousingFederalPrograms";

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
        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
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
            btnSubmitHomeForm.Visible = false;

            cbAddFedProgram.Enabled = true;
            cbAddHomeAff.Enabled = true;
            cbAddNewInspections.Enabled = true;
            cbAddRentalAffordability.Enabled = true;
            cbAddUnitOccupancy.Enabled = true;
            cbDeficiency.Enabled = true;
        }

        protected void RoleViewOnly()
        {
            btnAddHomeAff.Visible = false;
            btnAddInspection.Visible = false;
            btnAddRentalAffordability.Visible = false;
            btnAddUnitType.Visible = false;
            btnSubmitHomeForm.Visible = false;

            cbAddFedProgram.Enabled = false;
            cbAddHomeAff.Enabled = false;
            cbAddNewInspections.Enabled = false;
            cbAddRentalAffordability.Enabled = false;
            cbAddUnitOccupancy.Enabled = false;
            cbDeficiency.Enabled = false;
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
                if (dr["URL"].ToString().Contains("HousingFederalPrograms.aspx"))
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

            int TotalHousingUnits = HousingFederalProgramsData.GetTotalHousingUnits(DataUtils.GetInt(hfProjectId.Value));
            TotalUnits.InnerText = TotalHousingUnits.ToString();
        }

        private void BindControls()
        {
            BindLookUP(ddlRecreationMonth, 172);
            BindLookUP(ddlCHRDoRecert, 172);

            BindLookUP(ddlFederalProgram, 105);
            BindLookUP(ddlAffPeriod, 2);
            BindStaff(ddlCompletedBy);
            BindStaff(ddlFundedDateCompleteBy);
            BindStaff(ddlIDISCompletionDateCompletedBy);
            //BindStaff(ddlStaff);
            //BindLookUP(ddlStaff, 117);
            PopulateInspectorDropDown(ddlStaff, "Home Inspector");
            //BindLookUP(ddlUnitType, 168);
            BindLookUP(ddlUnitOccupancyUnitType, 166);
            //BindLookUP(ddlMedianIncome, 167);
            
        }

        private void PopulateInspectorDropDown(DropDownList ddList, string Role)
        {
            try
            {
                DataTable dtProjectEntity = ProjectMaintenanceData.GetProjectApplicantList(DataUtils.GetInt(hfProjectId.Value), true);
                ddList.Items.Clear();
                ddList.DataSource = dtProjectEntity;
                ddList.DataValueField = "ApplicantId";
                ddList.DataTextField = "applicantname";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));

                foreach (DataRow dr in dtProjectEntity.Rows)
                {
                    if (dr["ApplicantRoleDescription"].ToString().ToLower() == Role.ToLower())
                    {
                        ListItem selectedListItem = ddList.Items.FindByValue(dr["ApplicantId"].ToString());
                        if (selectedListItem != null)
                        {
                            selectedListItem.Selected = true;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "PopulateOwnerDropDown", "", ex.Message);
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

        protected void BindStaff(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.GetManagers();
                ddList.DataValueField = "UserId";
                ddList.DataTextField = "Name";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindStaff", "", ex.Message);
            }
        }

        private void BindGrids()
        {
            BindFederalProgramsGrid();
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

        protected void AddFederalProgram_Click(object sender, EventArgs e)
        {
            HousingFederalProgramsResult objHousingFederalProgramsResult = 
                HousingFederalProgramsData.AddProjectFederal(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlFederalProgram.SelectedValue.ToString()), DataUtils.GetInt(txtTotFedProgUnits.Text));

            BindGrids();
            ClearFederalProgramsForm();

            if (objHousingFederalProgramsResult.IsDuplicate && !objHousingFederalProgramsResult.IsActive)
                LogMessage("Program Setup already exist as in-active");
            else if (objHousingFederalProgramsResult.IsDuplicate)
                LogMessage("Program Setup already exist");
            else
                LogMessage("Program Setup added successfully");
        }

        protected void gvFedProgram_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFedProgram.EditIndex = e.NewEditIndex;
            BindFederalProgramsGrid();
        }

        protected void gvFedProgram_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFedProgram.EditIndex = -1;
            BindFederalProgramsGrid();
            ClearFederalProgramsForm();
        }

        private void ClearFederalProgramsForm()
        {
            cbAddFedProgram.Checked = false;
            ddlFederalProgram.SelectedIndex = -1;
            txtTotFedProgUnits.Text = "";
        }

        protected void rdBtnSelectFederalProgram_CheckedChanged(object sender, EventArgs e)
        {
            hfProjectFedProgram.Value = "";
            hfProjectFederalID.Value = "";
            hfHousingID.Value = "";
            dvFedProgramHome.Visible = false;
            dvNewHomeAff.Visible = false;

            hfProjectFederalID.Value = GetFederalProgramSelectedRecordID(gvFedProgram);

            DataRow drHousing = HousingUnitsServicesData.GetHousingDetailsById(DataUtils.GetInt(hfProjectId.Value));

            if (drHousing != null)
            {
                hfHousingID.Value = drHousing["HousingID"].ToString();
            }

            if (hfProjectFedProgram.Value.ToLower() == "home" || hfProjectFedProgram.Value.ToLower() == "nsp")
            {
                string labelText = "";
                if(hfProjectFedProgram.Value.ToLower() == "home")
                    labelText = "HOME";
                else
                    labelText = "NSP";

                spnFormTitle.InnerText = labelText;
                cbAddHomeAff.Text = "Add New " + labelText + " Income Restriction";
                cbAddRentalAffordability.Text = "Add New " + labelText + " Rent Restriction";
                cbAddUnitOccupancy.Text = "Add New " + labelText + " Unit Sizes";
                spnUnitSizes.InnerText = labelText + " Unit Sizes";
                spnRentRest.InnerText = labelText + " Rent Restrictions";
                spnIncomeRest.InnerText = labelText + " Income Restrictions";
                spnIncomeRestrictionsLabel.InnerText = labelText;

                spnCHDORequest.Visible = true;
                chkCHDO.Visible = spnCHDORequest.Visible = true;
                spnCHDORecertMonth.Visible = true;
                ddlCHRDoRecert.Visible = true;
                txtAffPeriod.Visible = false;
                ddlAffPeriod.Visible = true;
                spnUARegulations.Visible = true;
                chkUARegulation.Visible = true;

                BindLookUP(ddlHomeAff, 173);
                BindLookUP(ddlUnitType, 168);
            }
            else if (hfProjectFedProgram.Value.ToLower() == "htf")
            {
                spnFormTitle.InnerText = "HTF";
                cbAddHomeAff.Text = "Add New HTF Income Restriction";
                cbAddRentalAffordability.Text = "Add New HTF Rent Restriction";
                cbAddUnitOccupancy.Text = "Add New HTF Unit Sizes";
                spnUnitSizes.InnerText = "HTF Unit Sizes";
                spnRentRest.InnerText = "HTF Rent Restrictions";
                spnIncomeRest.InnerText = "HTF Income Restrictions";
                spnIncomeRestrictionsLabel.InnerText = "HTF";

                spnCHDORequest.Visible = false;
                chkCHDO.Visible = false;
                spnCHDORecertMonth.Visible = false;
                ddlCHRDoRecert.Visible = false;
                txtAffPeriod.Visible = true;
                ddlAffPeriod.Visible = false;
                spnUARegulations.Visible = false;
                chkUARegulation.Visible = false;

                BindLookUP(ddlHomeAff, 174);
                BindLookUP(ddlUnitType, 175);
            }

            dvFedProgramHome.Visible = true;
            ClearDetailForm();
            PopulateDetailsForm();

            dvNewInspections.Visible = true;
            BindInspectionsGrid();

            dvNewHomeAff.Visible = true;
            BindHomeAffordGrid();

            dvRentalAffordability.Visible = true;
            BindRentalAffordabilityGrid();

            dvUnitOccupancy.Visible = true;
            BindUnitOccupancyGrid();

            //dvMedianIncome.Visible = true;
            //BindMedianIncomeGrid();
        }

        private void PopulateDetailsForm()
        {
            btnSubmitHomeForm.Text = "Submit";

            DataRow dr = HousingFederalProgramsData.GetProjectFederalProgramDetailById(DataUtils.GetInt(hfProjectFederalID.Value));
            if (dr != null)
            {
                btnSubmitHomeForm.Text = "Update";
                hfProjectFederalProgramDetailID.Value = dr["ProjectFederalProgramDetailID"].ToString();

                //txtRecreationMonth.Text = dr["Recert"].ToString() == "0" ? "" : dr["Recert"].ToString();
                PopulateDropDown(ddlRecreationMonth, dr["Recert"].ToString());
                //chkCopyOwner.Checked = DataUtils.GetBool(dr["Copyowner"].ToString());
                PopulateDropDown(ddlAffPeriod, dr["LKAffrdPer"].ToString());
                txtAffrdStartDate.Text = dr["AffrdStart"].ToString() == "" ? "" : Convert.ToDateTime(dr["AffrdStart"].ToString()).ToShortDateString();
                txtAffrdEndDate.Text = dr["AffrdEnd"].ToString() == "" ? "" : Convert.ToDateTime(dr["AffrdEnd"].ToString()).ToShortDateString();
                chkCHDO.Checked = DataUtils.GetBool(dr["CHDO"].ToString());
                chkUARegulation.Checked = DataUtils.GetBool(dr["IsUARegulation"].ToString());
                //txtCHDORecert.Text = dr["CHDORecert"].ToString() == "0" ? "" : dr["CHDORecert"].ToString();
                PopulateDropDown(ddlCHRDoRecert, dr["CHDORecert"].ToString());

                txtFreq.Text = dr["freq"].ToString() == "0" ? "" : dr["freq"].ToString();
                //txtLastInspect.Text = dr["LastInspect"].ToString() == "" ? "" : Convert.ToDateTime(dr["LastInspect"].ToString()).ToShortDateString();
                //txtNextInspect.Text = dr["NextInspect"].ToString();
                //PopulateDropDown(ddlStaff, dr["Staff"].ToString());
                //txtInspectDate.Text = dr["InspectDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["InspectDate"].ToString()).ToShortDateString();
                //txtInspectLetter.Text = dr["InspectLetter"].ToString() == "" ? "" : Convert.ToDateTime(dr["InspectLetter"].ToString()).ToShortDateString();
                //txtRespDate.Text = dr["RespDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["RespDate"].ToString()).ToShortDateString();

                txtIDSNum.Text = dr["IDISNum"].ToString();
                txtSetupDate.Text = dr["Setup"].ToString() == "" ? "" : Convert.ToDateTime(dr["Setup"].ToString()).ToShortDateString();
                PopulateDropDown(ddlCompletedBy, dr["CompleteBy"].ToString());
                txtFundedDate.Text = dr["FundedDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["FundedDate"].ToString()).ToShortDateString();
                txtCloseDate.Text = dr["IDISClose"].ToString() == "" ? "" : Convert.ToDateTime(dr["IDISClose"].ToString()).ToShortDateString();

                PopulateDropDown(ddlIDISCompletionDateCompletedBy, dr["IDISCompleteBy"].ToString());
                PopulateDropDown(ddlFundedDateCompleteBy, dr["FundCompleteBy"].ToString());

                if (txtAffrdStartDate.Text == "")
                {
                    txtAffrdStartDate.Text = txtCloseDate.Text;
                }
                //if (txtCloseDate.Text == "")
                //{
                //    txtCloseDate.Text = txtAffrdStartDate.Text;
                //}

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

        private void ClearDetailForm()
        {
            ddlRecreationMonth.SelectedIndex = -1;
            ddlAffPeriod.SelectedIndex = -1;
            txtAffPeriod.Text = "30";
            txtAffrdStartDate.Text = "";
            chkCHDO.Checked = false;
            ddlCHRDoRecert.SelectedIndex = -1;
            txtAffrdEndDate.Text = "";
            txtFreq.Text = "";
            txtIDSNum.Text = "";
            txtSetupDate.Text = "";
            ddlCompletedBy.SelectedIndex = -1;
            txtFundedDate.Text = "";
            txtCloseDate.Text = "";
            ddlIDISCompletionDateCompletedBy.SelectedIndex = -1;
            ddlFundedDateCompleteBy.SelectedIndex = -1;
        }

        private string GetFederalProgramSelectedRecordID(GridView gvFedProgram)
        {
            string ProjectFederalID = null;

            for (int i = 0; i < gvFedProgram.Rows.Count; i++)
            {
                RadioButton rdBtnFederalProgram = (RadioButton)gvFedProgram.Rows[i].Cells[0].FindControl("rdBtnSelectFederalProgram");
                if (rdBtnFederalProgram != null)
                {
                    if (rdBtnFederalProgram.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFedProgram.Rows[i].Cells[0].FindControl("HiddenProjectFederalID");
                        HiddenField hfFedProgram = (HiddenField)gvFedProgram.Rows[i].Cells[0].FindControl("HiddenFedProgram");
                        HiddenField hfFedProgramNumUnits = (HiddenField)gvFedProgram.Rows[i].Cells[0].FindControl("HiddenFedProgramNumUnits");

                        if (hf != null)
                        {
                            ProjectFederalID = hf.Value;
                            hfProjectFedProgram.Value = hfFedProgram.Value;
                            hfTotalProgramUnits.Value = hfFedProgramNumUnits.Value;
                        }
                        break;
                    }
                }
            }
            return ProjectFederalID;
        }

        protected void gvFedProgram_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectFederalID = DataUtils.GetInt(((Label)gvFedProgram.Rows[rowIndex].FindControl("lblProjectFederalID")).Text);
            int NumUnits = DataUtils.GetInt(((TextBox)gvFedProgram.Rows[rowIndex].FindControl("txtNumUnits")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvFedProgram.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingFederalProgramsData.UpdateProjectFederal(ProjectFederalID, NumUnits, RowIsActive);

            gvFedProgram.EditIndex = -1;

            BindFederalProgramsGrid();

            LogMessage("Program Setup updated successfully");
        }

        private void BindFederalProgramsGrid()
        {
            dvFedProgramHome.Visible = false;
            dvNewHomeAff.Visible = false;
            dvRentalAffordability.Visible = false;
            dvUnitOccupancy.Visible = false;
            dvNewInspections.Visible = false;

            try
            {
                DataTable dt = HousingFederalProgramsData.GetProjectFederalList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvFedProgramGrid.Visible = true;
                    gvFedProgram.DataSource = dt;
                    gvFedProgram.DataBind();
                }
                else
                {
                    dvFedProgramGrid.Visible = false;
                    gvFedProgram.DataSource = null;
                    gvFedProgram.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindFederalProgramsGrid", "", ex.Message);
            }
        }

        protected void btnSubmitHomeForm_Click(object sender, EventArgs e)
        {
            try
            {

                if (IsDetailFormValid())
                {
                    if (btnSubmitHomeForm.Text.ToLower() == "submit")
                    {
                        HousingFederalProgramsData.AddProjectFederalProgramDetail(DataUtils.GetInt(hfProjectFederalID.Value), DataUtils.GetInt(ddlRecreationMonth.SelectedValue.ToString()),
                            DataUtils.GetInt(ddlAffPeriod.SelectedValue.ToString()), DataUtils.GetInt(txtAffPeriod.Text),  DataUtils.GetDate(txtAffrdStartDate.Text), DataUtils.GetDate(txtAffrdEndDate.Text), chkCHDO.Checked,
                            DataUtils.GetInt(ddlCHRDoRecert.SelectedValue.ToString()), DataUtils.GetInt(txtFreq.Text),
                            txtIDSNum.Text, DataUtils.GetDate(txtSetupDate.Text), DataUtils.GetInt(ddlCompletedBy.SelectedValue.ToString()),
                            DataUtils.GetDate(txtFundedDate.Text), DataUtils.GetInt(ddlFundedDateCompleteBy.SelectedValue.ToString()),
                            DataUtils.GetDate(txtCloseDate.Text), DataUtils.GetInt(ddlIDISCompletionDateCompletedBy.SelectedValue.ToString()), 
                            chkUARegulation.Checked);
                        ClearDetailForm();
                        PopulateDetailsForm();
                        LogMessage("Project " + hfProjectFedProgram.Value +" details added successfully");
                        btnSubmitHomeForm.Text = "Update";
                    }
                    else
                    {
                        HousingFederalProgramsData.UpdateProjectFederalProgramDetail(DataUtils.GetInt(hfProjectFederalProgramDetailID.Value), DataUtils.GetInt(ddlRecreationMonth.SelectedValue.ToString()),
                            DataUtils.GetInt(ddlAffPeriod.SelectedValue.ToString()), DataUtils.GetInt(txtAffPeriod.Text), DataUtils.GetDate(txtAffrdStartDate.Text), DataUtils.GetDate(txtAffrdEndDate.Text), chkCHDO.Checked,
                            DataUtils.GetInt(ddlCHRDoRecert.SelectedValue.ToString()), DataUtils.GetInt(txtFreq.Text), txtIDSNum.Text, DataUtils.GetDate(txtSetupDate.Text), DataUtils.GetInt(ddlCompletedBy.SelectedValue.ToString()),
                            DataUtils.GetDate(txtFundedDate.Text), DataUtils.GetInt(ddlFundedDateCompleteBy.SelectedValue.ToString()),
                            DataUtils.GetDate(txtCloseDate.Text), DataUtils.GetInt(ddlIDISCompletionDateCompletedBy.SelectedValue.ToString()), 
                            chkUARegulation.Checked);

                        ClearDetailForm();
                        PopulateDetailsForm();
                        LogMessage("Project "+ hfProjectFedProgram.Value +" details updated successfully");
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "", ex.Message);
            }
        }

        private bool IsDetailFormValid()
        {
            if (chkCHDO.Checked)
            {
                if (ddlCHRDoRecert.Items.Count > 1 && ddlCHRDoRecert.SelectedIndex == 0)
                {
                    LogMessage("Select CHDO Recertification Month");
                    ddlCHRDoRecert.Focus();
                    return false;
                }
            }
            return true;
        }

        protected void btnAddRentalAffordability_Click(object sender, EventArgs e)
        {
            if (ddlUnitType.SelectedIndex == 0)
            {
                LogMessage("Select Rental Affordability Unit Type");
                ddlUnitType.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtUnitTypeUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Number of Units");
                txtUnitTypeUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtUnitTypeUnits.Text) <= 0)
            {
                LogMessage("Enter Valid Number of Units");
                txtUnitTypeUnits.Focus();
                return;
            }

            HousingFederalProgramsResult objHousingFederalProgramsResult = HousingFederalProgramsData.AddHousingFederalAfford(DataUtils.GetInt(hfProjectFederalID.Value),
                DataUtils.GetInt(ddlUnitType.SelectedValue.ToString()), DataUtils.GetInt(txtUnitTypeUnits.Text));

            ddlUnitType.SelectedIndex = -1;
            txtUnitTypeUnits.Text = "";
            cbAddRentalAffordability.Checked = false;

            BindRentalAffordabilityGrid();

            if (objHousingFederalProgramsResult.IsDuplicate && !objHousingFederalProgramsResult.IsActive)
                LogMessage("Rental Affordability Unit Type already exist as in-active");
            else if (objHousingFederalProgramsResult.IsDuplicate)
                LogMessage("Rental Affordability Unit Type already exist");
            else
                LogMessage("New Rental Affordability Unit Type added successfully");
        }

        private void BindRentalAffordabilityGrid()
        {
            try
            {
                DataTable dt = HousingFederalProgramsData.GetHousingFederalAffordList(DataUtils.GetInt(hfProjectFederalID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvRentalAffordabilityGrid.Visible = true;
                    gvRentalAffordability.DataSource = dt;
                    gvRentalAffordability.DataBind();

                    Label lblFooterTotalUnits = (Label)gvRentalAffordability.FooterRow.FindControl("lblFooterTotalUnits");
                    int totUnitTypeUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totUnitTypeUnits += DataUtils.GetInt(dt.Rows[i]["NumUnits"].ToString());
                    }

                    lblFooterTotalUnits.Text = totUnitTypeUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalProgramUnits.Value);

                    hfSubTypeWarning.Value = "0";
                    if (TotalUnits - totUnitTypeUnits != 0)
                    {
                        hfSubTypeWarning.Value = "1";
                        WarningMessage(dvRentalAffordabilityWarning, lblSubTypeWarning,
                            "The Rental Affordability Units must be equal to Total Program Units " + hfTotalProgramUnits.Value);
                    }
                    else
                    {
                        dvRentalAffordabilityWarning.Visible = false;
                        lblSubTypeWarning.Text = "";
                    }
                }
                else
                {
                    dvRentalAffordabilityGrid.Visible = false;
                    gvRentalAffordability.DataSource = null;
                    gvRentalAffordability.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindRentalAffordabilityGrid", "", ex.Message);
            }
        }

        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }

        private void ShowWarnings()
        {
            if (hfSubTypeWarning.Value != "1")
            {
                dvRentalAffordabilityWarning.Visible = false;
                lblErrorMsg.Text = "";
            }
            if (hfUnitOccupancyWarning.Value != "1")
            {
                dvUnitOccupanyWarning.Visible = false;
                lblErrorMsg.Text = "";
            }
            //if (hfMedianIncomeWarning.Value != "1")
            //{
            //    dvMedianIncomeWarning.Visible = false;
            //    lblErrorMsg.Text = "";
            //}
            if (hfHomeAffWarning.Value != "1")
            {
                dvHomeAffWarning.Visible = false;
                lblErrorMsg.Text = "";
            }
        }

        protected void gvRentalAffordability_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRentalAffordability.EditIndex = e.NewEditIndex;
            BindRentalAffordabilityGrid();
        }

        protected void gvRentalAffordability_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvRentalAffordability.Rows[rowIndex].FindControl("txtUnits")).Text;

            if (string.IsNullOrWhiteSpace(strUnits) == true)
            {
                LogMessage("Enter Number of Units");
                return;
            }
            if (DataUtils.GetDecimal(strUnits) <= 0)
            {
                LogMessage("Enter valid Number of Units");
                return;
            }

            int FederalAffordID = DataUtils.GetInt(((Label)gvRentalAffordability.Rows[rowIndex].FindControl("lblFederalAffordID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvRentalAffordability.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingFederalProgramsData.UpdateHousingFederalAfford(FederalAffordID, Units, RowIsActive);
            gvRentalAffordability.EditIndex = -1;

            LogMessage("Rental Affordability Unit Type updated successfully");

            BindRentalAffordabilityGrid();
        }

        protected void gvRentalAffordability_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRentalAffordability.EditIndex = -1;
            BindRentalAffordabilityGrid();
        }

        protected void btnAddUnitType_Click(object sender, EventArgs e)
        {
            if (ddlUnitOccupancyUnitType.SelectedIndex == 0)
            {
                LogMessage("Select Unit Occupany Unit Type");
                ddlUnitOccupancyUnitType.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtUnitOccupancyNumUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Unit Occupany Number of Units");
                txtUnitOccupancyNumUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtUnitOccupancyNumUnits.Text) <= 0)
            {
                LogMessage("Enter Valid Unit Occupany Number of Units");
                txtUnitOccupancyNumUnits.Focus();
                return;
            }

            HousingFederalProgramsResult objHousingFederalProgramsResult = HousingFederalProgramsData.AddHousingFederalUnit(DataUtils.GetInt(hfProjectFederalID.Value),
                DataUtils.GetInt(ddlUnitOccupancyUnitType.SelectedValue.ToString()), DataUtils.GetInt(txtUnitOccupancyNumUnits.Text));

            ddlUnitOccupancyUnitType.SelectedIndex = -1;
            txtUnitOccupancyNumUnits.Text = "";
            cbAddUnitOccupancy.Checked = false;

            BindUnitOccupancyGrid();

            if (objHousingFederalProgramsResult.IsDuplicate && !objHousingFederalProgramsResult.IsActive)
                LogMessage("Unit Occupancy Unit Type already exist as in-active");
            else if (objHousingFederalProgramsResult.IsDuplicate)
                LogMessage("Unit Occupancy Unit Type already exist");
            else
                LogMessage("New Unit Occupancy Unit Type added successfully");
        }

        private void BindUnitOccupancyGrid()
        {
            try
            {
                DataTable dt = HousingFederalProgramsData.GetFederalUnitList(DataUtils.GetInt(hfProjectFederalID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvUnitOccupanyGrid.Visible = true;
                    gvUnitOccupany.DataSource = dt;
                    gvUnitOccupany.DataBind();

                    Label lblFooterTotalUnits = (Label)gvUnitOccupany.FooterRow.FindControl("lblFooterTotalUnits");
                    int totUnitTypeUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totUnitTypeUnits += DataUtils.GetInt(dt.Rows[i]["NumUnits"].ToString());
                    }

                    lblFooterTotalUnits.Text = totUnitTypeUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalProgramUnits.Value);

                    hfUnitOccupancyWarning.Value = "0";
                    if (TotalUnits - totUnitTypeUnits != 0)
                    {
                        hfUnitOccupancyWarning.Value = "1";
                        WarningMessage(dvUnitOccupanyWarning, lblUnitOccupanyWarning,
                            "The Unit Occupancy Units must be equal to Total Program Units " + hfTotalProgramUnits.Value);
                    }
                    else
                    {
                        dvUnitOccupanyWarning.Visible = false;
                        lblUnitOccupanyWarning.Text = "";
                    }
                }
                else
                {
                    dvUnitOccupanyGrid.Visible = false;
                    gvUnitOccupany.DataSource = null;
                    gvUnitOccupany.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindUnitOccupancyGrid", "", ex.Message);
            }
        }

        protected void gvUnitOccupany_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUnitOccupany.EditIndex = e.NewEditIndex;
            BindUnitOccupancyGrid();
        }

        protected void gvUnitOccupany_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUnitOccupany.EditIndex = -1;
            BindUnitOccupancyGrid();
        }

        protected void gvUnitOccupany_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvUnitOccupany.Rows[rowIndex].FindControl("txtUnits")).Text;

            if (string.IsNullOrWhiteSpace(strUnits) == true)
            {
                LogMessage("Enter Number of Units");
                return;
            }
            if (DataUtils.GetDecimal(strUnits) <= 0)
            {
                LogMessage("Enter valid Number of Units");
                return;
            }

            int FederalUnitID = DataUtils.GetInt(((Label)gvUnitOccupany.Rows[rowIndex].FindControl("lblFederalUnitID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvUnitOccupany.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingFederalProgramsData.UpdateHousingFederalUnit(FederalUnitID, Units, RowIsActive);
            gvUnitOccupany.EditIndex = -1;

            LogMessage("Unit Occupancy Unit Type updated successfully");

            BindUnitOccupancyGrid();
        }

        //protected void btnAddMedianIncome_Click(object sender, EventArgs e)
        //{
        //    if (ddlMedianIncome.SelectedIndex == 0)
        //    {
        //        LogMessage("Select Median Income");
        //        ddlMedianIncome.Focus();
        //        return;
        //    }

        //    if (string.IsNullOrWhiteSpace(txtMedianIncomeUnits.Text.ToString()) == true)
        //    {
        //        LogMessage("Enter Medain Income Number of Units");
        //        txtMedianIncomeUnits.Focus();
        //        return;
        //    }
        //    if (DataUtils.GetDecimal(txtMedianIncomeUnits.Text) <= 0)
        //    {
        //        LogMessage("Enter Valid median Income Number of Units");
        //        txtMedianIncomeUnits.Focus();
        //        return;
        //    }

        //    HousingFederalProgramsResult objHousingFederalProgramsResult = HousingFederalProgramsData.AddFederalMedIncome(DataUtils.GetInt(hfProjectFederalID.Value),
        //        DataUtils.GetInt(ddlMedianIncome.SelectedValue.ToString()), DataUtils.GetInt(txtMedianIncomeUnits.Text));

        //    ddlMedianIncome.SelectedIndex = -1;
        //    txtMedianIncomeUnits.Text = "";
        //    cbAddMedianIncome.Checked = false;

        //    BindMedianIncomeGrid();

        //    if (objHousingFederalProgramsResult.IsDuplicate && !objHousingFederalProgramsResult.IsActive)
        //        LogMessage("Medain Income already exist as in-active");
        //    else if (objHousingFederalProgramsResult.IsDuplicate)
        //        LogMessage("Medain Income already exist");
        //    else
        //        LogMessage("New Medain Income added successfully");
        //}

        //private void BindMedianIncomeGrid()
        //{
        //    try
        //    {
        //        DataTable dt = HousingFederalProgramsData.GetFederalMedIncomeList(DataUtils.GetInt(hfProjectFederalID.Value), cbActiveOnly.Checked);

        //        if (dt.Rows.Count > 0)
        //        {
        //            dvMedianIncomeGrid.Visible = true;
        //            gvMedianIncome.DataSource = dt;
        //            gvMedianIncome.DataBind();

        //            Label lblFooterTotalUnits = (Label)gvMedianIncome.FooterRow.FindControl("lblFooterTotalUnits");
        //            int totUnitTypeUnits = 0;

        //            for (int i = 0; i < dt.Rows.Count; i++)
        //            {
        //                if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
        //                    totUnitTypeUnits += DataUtils.GetInt(dt.Rows[i]["NumUnits"].ToString());
        //            }

        //            lblFooterTotalUnits.Text = totUnitTypeUnits.ToString();

        //            int TotalUnits = DataUtils.GetInt(hfTotalProgramUnits.Value);

        //            hfMedianIncomeWarning.Value = "0";
        //            if (TotalUnits - totUnitTypeUnits != 0)
        //            {
        //                hfMedianIncomeWarning.Value = "1";
        //                WarningMessage(dvMedianIncomeWarning, lblMedianIncomeWarning,
        //                    "The Median Income Units must be equal to Total Program Units " + hfTotalProgramUnits.Value);
        //            }
        //            else
        //            {
        //                dvMedianIncomeWarning.Visible = false;
        //                lblMedianIncomeWarning.Text = "";
        //            }
        //        }
        //        else
        //        {
        //            dvMedianIncomeGrid.Visible = false;
        //            gvMedianIncome.DataSource = null;
        //            gvMedianIncome.DataBind();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindMedianIncomeGrid", "", ex.Message);
        //    }
        //}

        //protected void gvMedianIncome_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvMedianIncome.EditIndex = e.NewEditIndex;
        //    BindMedianIncomeGrid();
        //}

        //protected void gvMedianIncome_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvMedianIncome.EditIndex = -1;
        //    BindMedianIncomeGrid();
        //}

        //protected void gvMedianIncome_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int rowIndex = e.RowIndex;
        //    string strUnits = ((TextBox)gvMedianIncome.Rows[rowIndex].FindControl("txtUnits")).Text;

        //    if (string.IsNullOrWhiteSpace(strUnits) == true)
        //    {
        //        LogMessage("Enter Number of Units");
        //        return;
        //    }
        //    if (DataUtils.GetDecimal(strUnits) <= 0)
        //    {
        //        LogMessage("Enter valid Number of Units");
        //        return;
        //    }

        //    int FederalMedIncomeID = DataUtils.GetInt(((Label)gvMedianIncome.Rows[rowIndex].FindControl("lblFederalMedIncomeID")).Text);
        //    int Units = DataUtils.GetInt(strUnits);
        //    bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMedianIncome.Rows[rowIndex].FindControl("chkActive")).Checked); ;

        //    HousingFederalProgramsData.UpdateFederalMedIncome(FederalMedIncomeID, Units, RowIsActive);
        //    gvMedianIncome.EditIndex = -1;

        //    LogMessage("Median Income updated successfully");

        //    BindMedianIncomeGrid();
        //}

        protected void btnAddHomeAff_Click(object sender, EventArgs e)
        {
            string label = hfProjectFedProgram.Value;

            if (ddlHomeAff.SelectedIndex == 0)
            {
                LogMessage("Select " + label);
                ddlHomeAff.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtHomeUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtHomeUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtHomeUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtHomeUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddProjectFederalIncomeRest(DataUtils.GetInt(hfProjectFederalID.Value),
                DataUtils.GetInt(ddlHomeAff.SelectedValue.ToString()), DataUtils.GetInt(txtHomeUnits.Text));
            ddlHomeAff.SelectedIndex = -1;
            txtHomeUnits.Text = "";
            cbAddHomeAff.Checked = false;

            BindHomeAffordGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage(label + " Affordability Units already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage(label + "Affordability Units already exist");
            else
                LogMessage("New " + label +" Affordability Units added successfully");
        }

        private void BindHomeAffordGrid()
        {
            string label = hfProjectFedProgram.Value;
            try
            {
                DataTable dt = HousingUnitsServicesData.GetProjectFederalIncomeRestList(DataUtils.GetInt(hfProjectFederalID.Value), 
                    cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHomeAffGrid.Visible = true;
                    gvNewHomeAff.DataSource = dt;
                    gvNewHomeAff.DataBind();

                    Label lblFooterHomeTotalUnits = (Label)gvNewHomeAff.FooterRow.FindControl("lblFooterHomeTotalUnits");
                    int totHomeUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totHomeUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterHomeTotalUnits.Text = totHomeUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalProgramUnits.Value);

                    hfMedianIncomeWarning.Value = "0";
                    if (TotalUnits - totHomeUnits != 0)
                    {
                        hfHomeAffWarning.Value = "1";
                        WarningMessage(dvHomeAffWarning, lblHomeAffWarning,
                            "The "+label+" Affordability Units must be equal to Total Program Units " + hfTotalProgramUnits.Value);
                    }
                    else
                    {
                        dvHomeAffWarning.Visible = false;
                        lblHomeAffWarning.Text = "";
                    }
                }
                else
                {
                    dvHomeAffGrid.Visible = false;
                    gvNewHomeAff.DataSource = null;
                    gvNewHomeAff.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHomeAffordGrid", "", ex.Message);
            }
        }

        protected void gvNewHomeAff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvNewHomeAff.EditIndex = e.NewEditIndex;
            BindHomeAffordGrid();
        }

        protected void gvNewHomeAff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvNewHomeAff.EditIndex = -1;
            BindHomeAffordGrid();
        }

        protected void gvNewHomeAff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string label = hfProjectFedProgram.Value;

            int rowIndex = e.RowIndex;

            string strUnits = ((TextBox)gvNewHomeAff.Rows[rowIndex].FindControl("txtHomeNumunits")).Text;

            if (string.IsNullOrWhiteSpace(strUnits) == true)
            {
                LogMessage("Enter Units");
                return;
            }
            if (DataUtils.GetDecimal(strUnits) <= 0)
            {
                LogMessage("Enter valid Units");
                return;
            }

            int ProjectFederalIncomeRestID = DataUtils.GetInt(((Label)gvNewHomeAff.Rows[rowIndex].FindControl("lblProjectFederalIncomeRestID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvNewHomeAff.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateProjectFederalIncomeRest(ProjectFederalIncomeRestID, Units, RowIsActive);
            gvNewHomeAff.EditIndex = -1;

            LogMessage(label + " Affordability Units updated successfully");

            BindHomeAffordGrid();
        }

        protected void btnAddInspection_Click(object sender, EventArgs e)
        {
            if (btnAddInspection.Text.ToLower() == "add")
            {
                HousingFederalProgramsData.AddFederalProjectInspection(DataUtils.GetInt(hfProjectFederalID.Value),
                           DataUtils.GetDate(txtInspectDate.Text), txtNextInspect.Text, DataUtils.GetInt(ddlStaff.SelectedValue.ToString()),
                           DataUtils.GetDate(txtInspectLetter.Text), DataUtils.GetDate(txtRespDate.Text), cbDeficiency.Checked,
                           DataUtils.GetDate(txtNextInspDeadLine.Text));
                cbAddNewInspections.Checked = false;

                BindInspectionsGrid();
                ClearInspectionsForm();
                LogMessage("New Inspection details added successfully");
            }
            else
            {
                HousingFederalProgramsData.UpdateFederalProjectInspection(DataUtils.GetInt(hfFederalProjectInspectionID.Value),
                          DataUtils.GetDate(txtInspectDate.Text), txtNextInspect.Text, DataUtils.GetInt(ddlStaff.SelectedValue.ToString()),
                          DataUtils.GetDate(txtInspectLetter.Text), DataUtils.GetDate(txtRespDate.Text), cbDeficiency.Checked,
                          DataUtils.GetDate(txtNextInspDeadLine.Text), chkInspectionActive.Checked);

                gvInspection.EditIndex = -1;
                BindInspectionsGrid();
                ClearInspectionsForm();
                LogMessage("Inspection details updated successfully");
                btnAddInspection.Text = "Add";
                chkInspectionActive.Checked = true;
            }
        }

        protected void gvInspection_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvInspection.EditIndex = e.NewEditIndex;
            BindInspectionsGrid();
        }

        protected void gvInspection_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvInspection.EditIndex = -1;
            BindInspectionsGrid();
            ClearInspectionsForm();
            hfFederalProjectInspectionID.Value = "";
            btnAddInspection.Text = "Add";
            cbAddNewInspections.Checked = false;
            chkInspectionActive.Checked = true;
        }

        private void ClearInspectionsForm()
        {
            txtNextInspect.Text = "";
            ddlStaff.SelectedIndex = -1;
            PopulateInspectorDropDown(ddlStaff, "Home Inspector");
            txtInspectDate.Text = "";
            txtInspectLetter.Text = "";
            txtRespDate.Text = "";
            cbDeficiency.Checked = false;
            txtNextInspDeadLine.Text = "";
            chkInspectionActive.Enabled = false;
            cbAddNewInspections.Checked = false;
        }

        private void BindInspectionsGrid()
        {
            try
            {
                DataTable dt = HousingFederalProgramsData.GetFederalProjectInspectionList(DataUtils.GetInt(hfProjectFederalID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvInspectionGrid.Visible = true;
                    gvInspection.DataSource = dt;
                    gvInspection.DataBind();
                }
                else
                {
                    dvInspectionGrid.Visible = false;
                    gvInspection.DataSource = null;
                    gvInspection.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindInspectionsGrid", "", ex.Message);
            }
        }

        protected void gvInspection_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddInspection.Text = "Update";
                    cbAddNewInspections.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;

                        Label lblFederalProjectInspectionID = e.Row.FindControl("lblFederalProjectInspectionID") as Label;
                        DataRow dr = HousingFederalProgramsData.GetFederalProjectInspectionById(DataUtils.GetInt(lblFederalProjectInspectionID.Text));

                        hfFederalProjectInspectionID.Value = lblFederalProjectInspectionID.Text;

                        txtInspectDate.Text = dr["InspectDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["InspectDate"].ToString()).ToShortDateString();
                        PopulateDropDown(ddlStaff, dr["InspectStaff"].ToString());
                        txtNextInspect.Text = dr["NextInspect"].ToString();
                        txtInspectLetter.Text = dr["InspectLetter"].ToString() == "" ? "" : Convert.ToDateTime(dr["InspectLetter"].ToString()).ToShortDateString();

                        txtRespDate.Text = dr["RespDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["RespDate"].ToString()).ToShortDateString();
                        txtNextInspDeadLine.Text = dr["InspectDeadline"].ToString() == "" ? "" : Convert.ToDateTime(dr["InspectDeadline"].ToString()).ToShortDateString();
                        cbDeficiency.Checked = DataUtils.GetBool(dr["Deficiency"].ToString());
                        chkInspectionActive.Enabled = true;
                        chkInspectionActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvInspection_RowDataBound", "", ex.Message);
            }
        }

        protected void ImgFrderalData_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
              "script", Helper.GetExagoURL(hfProjectId.Value, "Housing Federal Data"));
        }

        protected void ImgIncomeRes_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
              "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Federal Income Restricted Units"));
        }

        protected void ImgRentalAff_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
             "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Federal Rental Affordability Units"));
        }

        protected void ImgrentalUnitSize_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
             "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Federal Rental Unit Size"));
        }

        protected void ImgHousingInspections_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
             "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Federal Inspections"));
        }
    }
}