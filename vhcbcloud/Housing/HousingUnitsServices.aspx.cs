using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Housing;

namespace vhcbcloud.Housing
{ 
    public partial class HousingUnitsServices : System.Web.UI.Page
    {
        string Pagename = "HousingUnitsServices";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            ShowWarnings();

            hfProjectId.Value = "0";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                hfHousingID.Value = HousingSourcesUsesData.GetHousingID(DataUtils.GetInt(hfProjectId.Value)).ToString();

                PopulateProjectDetails();
                BindControls();
                GetRoleAccess();
                BindHousingUnitsForm();
            }
            //GetRoleAuth();
        }

        protected bool GetIsVisibleBasedOnRole()
        {
            return DataUtils.GetBool(hfIsVisibleBasedOnRole.Value);
        }

        //protected bool GetRoleAuth()
        //{
        //    bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
        //    if (!checkAuth)
        //        RoleReadOnly();
        //    return checkAuth;
        //}

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
            btnSubmit.Visible = false;

            cbAddHousingSubType.Enabled = true;
            cbAddAgeRes.Enabled = true;
            cbAddMultiUnit.Enabled = true;
            cbAddSecService.Enabled = true;
            cbAddSingleUnit.Enabled = true;
            cbAddSuppService.Enabled = true;
            cbAddVHCBAff.Enabled = true;
        }

        protected void RoleViewOnly()
        {
            cbAddHousingSubType.Enabled = false;
            cbAddAgeRes.Enabled = false;
            cbAddMultiUnit.Enabled = false;
            cbAddSecService.Enabled = false;
            cbAddSingleUnit.Enabled = false;
            cbAddSuppService.Enabled = false;
            cbAddVHCBAff.Enabled = false;
            btnAddAgeRest.Visible = false;
            btnAddHousingSubType.Visible = false;
            btnAddMultiUnitCharacteristic.Visible = false;
            btnAddSecServices.Visible = false;
            btnAddSingleUnitCharacteristic.Visible = false;
            btnAddSuppServices.Visible = false;
            btnAddVHCBAff.Visible = false;
            btnSubmit.Visible = false;
        }

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }
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

        private void ShowWarnings()
        {
            if (hfSubTypeWarning.Value != "1")
            {
                dvSubTypeWarning.Visible = false;
                lblSubTypeWarning.Text = "";
            }

            if (hfSingleUnitWarning.Value != "1")
            {
                dvSingleUnitWarning.Visible = false;
                lblSingleUnitWarning.Text = "";
            }

            if (hfVHCBUnitWarning.Value != "1")
            {
                dvVHCBUnitWarning.Visible = false;
                lblVHCBUnitWarning.Text = "";
            }

            if (hfPrimaryServiceWarning.Value != "1")
            {
                dvPrimaryServiceWarning.Visible = false;
                lblPrimaryServiceWarning.Text = "";
            }

            if (hfAgeRestrWarning.Value != "1")
            {
                dvAgeRestrWarning.Visible = false;
                lblAgeRestrWarning.Text = "";
            }

            if (hfTargetEffWarning.Value != "1")
            {
                dvTargetEffWarning.Visible = false;
                lblTargetEffWarning.Text = "";
            }

            if (hfAffordableToWarning.Value != "1")
            {
                dvAffordableToWarning.Visible = false;
                lblAffordableToWarning.Text = "";
            }
        }

        private void BindHousingUnitsForm()
        {

            DataRow drHousing = HousingUnitsServicesData.GetHousingDetailsById(DataUtils.GetInt(hfProjectId.Value));
            hfHousingID.Value = "";

            if (drHousing != null)
            {
                hfHousingID.Value = drHousing["HousingID"].ToString();
                PopulateDropDown(ddlHousingType, drHousing["LkHouseCat"].ToString());
                HousingTypeModified();
                spnTotalUnits.InnerText = drHousing["TotalUnits"].ToString();
                //txtTotalUnits.Text = drHousing["TotalUnits"].ToString();
                hfTotalUnitsFromDB.Value = drHousing["TotalUnits"].ToString();
                txtGrossLivingSpace.Text = drHousing["Hsqft"].ToString();
                txtUnitsFromPreProject.Text = drHousing["Previous"].ToString();
                txtNetNewUnits.Text = drHousing["NewUnits"].ToString();
                txtUnitsRemoved.Text = drHousing["UnitsRemoved"].ToString();
                //txtUnitsRelFromCov.Text = drHousing["RelCovenant"].ToString();
                //txtRestrictionsReleaseDate.Text = drHousing["ResRelease"].ToString() == "" ? "" : Convert.ToDateTime(drHousing["ResRelease"].ToString()).ToShortDateString();
                chkSash.Checked = DataUtils.GetBool(drHousing["SASH"].ToString());
                //chkVermod.Checked = DataUtils.GetBool(drHousing["Vermod"].ToString());
                txtMHIP.Text = drHousing["Vermod"].ToString();
                txtSSUnits.Text = drHousing["ServSuppUnits"].ToString();
                txtBuildings.Text = drHousing["Bldgs"].ToString();

                spnVHCBAffUnits.InnerText = (DataUtils.GetInt(drHousing["TotalUnits"].ToString()) - DataUtils.GetInt(hfNotInCovenantCount.Value)).ToString();

                if (ddlHousingType.SelectedIndex == 0)
                {
                    dvNewHousingSubType.Visible = false;
                    dvNewSingle.Visible = false;
                    dvNewMultiple.Visible = false;
                    dvNewSuppServices.Visible = false;
                    dvNewVHCBAff.Visible = false;
                    dvNewSecServices.Visible = false;
                    dvNewAgeRestrictions.Visible = false;
                    //dvNewHomeAff.Visible = false;

                }
                else
                {
                    btnSubmit.Text = "Update";

                    dvNewHousingSubType.Visible = true;
                    dvNewSingle.Visible = true;
                    dvNewMultiple.Visible = true;
                    dvNewSuppServices.Visible = true;
                    dvNewVHCBAff.Visible = true;
                    dvNewSecServices.Visible = true;
                    dvNewAgeRestrictions.Visible = true;
                    //dvNewHomeAff.Visible = true;
                }

                BindGrids();
            }
        }

        private void BindGrids()
        {
            BindSubTypeGrid();
            BindSingleUnitGrid();
            BindMultiUnitGrid();
            BindSuppServiceGrid();
            BindVHCBAffordGrid();
            BindSecServiceGrid();
            BindAgeRestrictionGrid();
            //BindHomeAffordGrid();
            BindTargetBestEffortGrid();
            BindAffordableToGrid();
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

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
            if(HousingUnitsServicesData.GetTotalFederalProgramUnits(DataUtils.GetInt(hfProjectId.Value)) > 0)
                snFederalProgramUnits.InnerText = "Yes";
            else
                snFederalProgramUnits.InnerText = "No";
        }

        private void GenerateTabs()
        {
            string ProgramId = null;
            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

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
                if (dr["URL"].ToString().Contains("HousingUnitsServices.aspx"))
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

        private void BindControls()
        {
            BindLookUP(ddlHousingType, 9);
            BindLookUP(ddlSingleUnitCharacteristic, 145);
            BindLookUP(ddlMultipleUnitCharacteristic, 96);
            BindLookUP(ddlSuppService, 87);
            BindLookUP(ddlSecService, 188);//188
            BindLookUP(ddlAgeRest, 189); //189
            BindLookUP(ddlVHCBAff, 109);
            BindLookUP(ddlTargetEff, 250);
            BindLookUP(ddlAffordableTo, 251);
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected void ddlHousingType_SelectedIndexChanged(object sender, EventArgs e)
        {
            HousingTypeModified();
        }

        private void HousingTypeModified()
        {
            if (ddlHousingType.SelectedIndex == 0)
            {
                ddlHousingSubType.Items.Clear();
                ddlHousingSubType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            else
            {
                if (ddlHousingType.SelectedValue.ToString() == "42")
                    BindLookUP(ddlHousingSubType, 127);

                if (ddlHousingType.SelectedValue.ToString() == "43")
                    BindLookUP(ddlHousingSubType, 128);
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

        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }

        protected void btnAddHousingSubType_Click(object sender, EventArgs e)
        {
            if (ddlHousingSubType.SelectedIndex == 0)
            {
                LogMessage("Select Housing SubType");
                ddlHousingSubType.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtHousingSubTypeUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtHousingSubTypeUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtHousingSubTypeUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtHousingSubTypeUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHousingSubType(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlHousingSubType.SelectedValue.ToString()), DataUtils.GetInt(txtHousingSubTypeUnits.Text));
            ddlHousingSubType.SelectedIndex = -1;
            txtHousingSubTypeUnits.Text = "";
            cbAddHousingSubType.Checked = false;

            BindSubTypeGrid();
            BindSingleUnitGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Housing SubType already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Housing SubType already exist");
            else
                LogMessage("New Housing SubType added successfully");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddlHousingType.SelectedIndex == 0)
            {
                LogMessage("Select Housing Type");
                ddlHousingType.Focus();
                return;
            }

            //if(DataUtils.GetInt(spnTotalUnits.InnerText) <= 0)
            //{
            //    LogMessage("Total Units should not be less than or equal to zero");
            //    return;
            //}

            if (txtSSUnits.Text != "")
            {
                int TotalUnits = DataUtils.GetInt(txtUnitsFromPreProject.Text) + DataUtils.GetInt(txtNetNewUnits.Text) -DataUtils.GetInt(txtUnitsRemoved.Text);

                if (DataUtils.GetInt(txtSSUnits.Text) > TotalUnits)
                {
                    LogMessage("Service Supported Units not greater than Total Units");
                    spnTotalUnits.InnerText = TotalUnits.ToString();
                    txtSSUnits.Focus();
                    return;
                }
            }

            //if (string.IsNullOrWhiteSpace(txtTotalUnits.Text.ToString()) == true)
            //{
            //    LogMessage("Enter Total Units");
            //    txtTotalUnits.Focus();
            //    return;
            //}
            //if (DataUtils.GetDecimal(txtTotalUnits.Text) <= 0)
            //{
            //    LogMessage("Enter valid Total Units");
            //    txtTotalUnits.Focus();
            //    return;
            //}

            HousingUnitsServicesData.SubmitHousingUnits(DataUtils.GetInt(hfHousingID.Value), 
                DataUtils.GetInt(ddlHousingType.SelectedValue.ToString()), 
                DataUtils.GetInt(txtGrossLivingSpace.Text), DataUtils.GetInt(txtUnitsFromPreProject.Text),
                DataUtils.GetInt(txtNetNewUnits.Text), DataUtils.GetInt(txtUnitsRemoved.Text), DataUtils.GetInt(txtMHIP.Text), 
                chkSash.Checked, DataUtils.GetInt(txtSSUnits.Text), DataUtils.GetInt(txtBuildings.Text));

            BindHousingUnitsForm();

            if (btnSubmit.Text.ToLower() == "update")
                LogMessage("Housing Units updated successfully");
            else
                LogMessage("Housing Units added successfully");

            BindGrids();
        }

        private void BindSubTypeGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHousingSubTypeList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHousingSubTypeGrid.Visible = true;
                    gvHousingSubType.DataSource = dt;
                    gvHousingSubType.DataBind();

                    Label lblFooterTotalUnits = (Label)gvHousingSubType.FooterRow.FindControl("lblFooterTotalUnits");
                    int totSubTypeUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totSubTypeUnits += DataUtils.GetInt(dt.Rows[i]["Units"].ToString());
                    }

                    lblFooterTotalUnits.Text = totSubTypeUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfSubTypeWarning.Value = "0";
                    if (TotalUnits - totSubTypeUnits != 0)
                    {
                        hfSubTypeWarning.Value = "1";
                        WarningMessage(dvSubTypeWarning, lblSubTypeWarning, "The Housing SubType Units must be equal to Total Units.");
                    }
                    else
                    {
                        dvSubTypeWarning.Visible = false;
                        lblSubTypeWarning.Text = "";
                    }
                }
                else
                {
                    dvHousingSubTypeGrid.Visible = false;
                    gvHousingSubType.DataSource = null;
                    gvHousingSubType.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSubTypeGrid", "", ex.Message);
            }
        }

        protected void gvHousingSubType_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHousingSubType.EditIndex = e.NewEditIndex;
            BindSubTypeGrid();
        }

        protected void gvHousingSubType_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHousingSubType.EditIndex = -1;
            BindSubTypeGrid();
        }

        protected void gvHousingSubType_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvHousingSubType.Rows[rowIndex].FindControl("txtUnits")).Text;

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

            int HousingTypeID = DataUtils.GetInt(((Label)gvHousingSubType.Rows[rowIndex].FindControl("lblHousingTypeID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvHousingSubType.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHousingSubType(HousingTypeID, Units, RowIsActive);
            gvHousingSubType.EditIndex = -1;

            LogMessage("Housing SubType updated successfully");

            BindSubTypeGrid();
        }

        private void BindSingleUnitGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHouseSingleCountList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvSingleGrid.Visible = true;
                    gvSingle.DataSource = dt;
                    gvSingle.DataBind();

                    Label lblFooterSingleUnitTotalUnits = (Label)gvSingle.FooterRow.FindControl("lblFooterSingleUnitTotalUnits");
                    int totSingleUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totSingleUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterSingleUnitTotalUnits.Text = totSingleUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfSingleUnitWarning.Value = "0";
                    if (TotalUnits - totSingleUnits != 0)
                    {
                        hfSingleUnitWarning.Value = "1";
                        WarningMessage(dvSingleUnitWarning, lblSingleUnitWarning, "The New Construction/Reuse/Rehab Units must be equal to Total Units.");
                    }
                    else
                    {
                        dvSingleUnitWarning.Visible = false;
                        lblSingleUnitWarning.Text = "";
                    }
                }
                else
                {
                    dvSingleGrid.Visible = false;
                    gvSingle.DataSource = null;
                    gvSingle.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSingleUnitGrid", "", ex.Message);
            }
        }

        protected void btnAddSingleUnitCharacteristic_Click(object sender, EventArgs e)
        {
            if (ddlSingleUnitCharacteristic.SelectedIndex == 0)
            {
                LogMessage("Select Characteristic");
                ddlSingleUnitCharacteristic.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtSingleUnitNumUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtSingleUnitNumUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtSingleUnitNumUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtSingleUnitNumUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHouseSingleCount(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlSingleUnitCharacteristic.SelectedValue.ToString()), DataUtils.GetInt(txtSingleUnitNumUnits.Text));
            ddlSingleUnitCharacteristic.SelectedIndex = -1;
            txtSingleUnitNumUnits.Text = "";
            cbAddSingleUnit.Checked = false;

            BindSingleUnitGrid();
            BindSubTypeGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("New Construction/Reuse/Rehab Characteristic already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("New Construction/Reuse/Rehab Characteristic already exist");
            else
                LogMessage("New Construction/Reuse/Rehab Characteristic added successfully");
        }

        protected void gvSingle_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSingle.EditIndex = e.NewEditIndex;
            BindSingleUnitGrid();
        }

        protected void gvSingle_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSingle.EditIndex = -1;
            BindSingleUnitGrid();
        }

        protected void gvSingle_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvSingle.Rows[rowIndex].FindControl("txtNumunits")).Text;

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

            int ProjectSingleCountID = DataUtils.GetInt(((Label)gvSingle.Rows[rowIndex].FindControl("lblProjectSingleCountID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvSingle.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHouseSingleCount(ProjectSingleCountID, Units, RowIsActive);
            gvSingle.EditIndex = -1;

            LogMessage("New Construction/Reuse/Rehab Characteristic updated successfully");

            BindSingleUnitGrid();
        }

        protected void btnAddMultiUnitCharacteristic_Click(object sender, EventArgs e)
        {
            if (ddlMultipleUnitCharacteristic.SelectedIndex == 0)
            {
                LogMessage("Select Characteristic");
                ddlMultipleUnitCharacteristic.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtMultiUnitNumUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtMultiUnitNumUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtMultiUnitNumUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtMultiUnitNumUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHouseMultiCount(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlMultipleUnitCharacteristic.SelectedValue.ToString()), DataUtils.GetInt(txtMultiUnitNumUnits.Text));
            ddlMultipleUnitCharacteristic.SelectedIndex = -1;
            txtMultiUnitNumUnits.Text = "";
            cbAddMultiUnit.Checked = false;

            BindMultiUnitGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Accessible/Adaptable Characteristic already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Accessible/Adaptable Characteristic already exist");
            else
                LogMessage("New Accessible/Adaptable Characteristic added successfully");
        }

        private void BindMultiUnitGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHouseMultiCountList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvMultipleGrid.Visible = true;
                    gvMultiple.DataSource = dt;
                    gvMultiple.DataBind();

                    //Label lblFooterMultiUnitTotalUnits = (Label)gvMultiple.FooterRow.FindControl("lblFooterMultiUnitTotalUnits");
                    //int totMultiUnits = 0;

                    //for (int i = 0; i < dt.Rows.Count; i++)
                    //{
                    //    if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                    //        totMultiUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    //}

                    //lblFooterMultiUnitTotalUnits.Text = totMultiUnits.ToString();
                }
                else
                {
                    dvMultipleGrid.Visible = false;
                    gvMultiple.DataSource = null;
                    gvMultiple.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMultiUnitGrid", "", ex.Message);
            }
        }

        protected void gvMultiple_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMultiple.EditIndex = e.NewEditIndex;
            BindMultiUnitGrid();
        }

        protected void gvMultiple_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMultiple.EditIndex = -1;
            BindMultiUnitGrid();
        }

        protected void gvMultiple_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            string strUnits = ((TextBox)gvMultiple.Rows[rowIndex].FindControl("txtNumunits")).Text;

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

            int ProjectMultiCountID = DataUtils.GetInt(((Label)gvMultiple.Rows[rowIndex].FindControl("lblProjectMultiCountID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMultiple.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHouseMultiCount(ProjectMultiCountID, Units, RowIsActive);
            gvMultiple.EditIndex = -1;

            LogMessage("Accessible/Adaptable Characteristic updated successfully");

            BindMultiUnitGrid();
        }

        protected void btnAddSuppServices_Click(object sender, EventArgs e)
        {
            if (ddlSuppService.SelectedIndex == 0)
            {
                LogMessage("Select Service");
                ddlSuppService.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtSuppServiceUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtSuppServiceUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtSuppServiceUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtSuppServiceUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHousingSuppServ(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlSuppService.SelectedValue.ToString()), DataUtils.GetInt(txtSuppServiceUnits.Text));
            ddlSuppService.SelectedIndex = -1;
            txtSuppServiceUnits.Text = "";
            cbAddSuppService.Checked = false;

            BindSuppServiceGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Supplemental Service already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Supplemental Service already exist");
            else
                LogMessage("New Supplemental Service added successfully");
        }

        private void BindSuppServiceGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHousingSuppServList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvSuppServiceGrid.Visible = true;
                    gvSuppService.DataSource = dt;
                    gvSuppService.DataBind();

                    Label lblFooterSuppServiceTotalUnits = (Label)gvSuppService.FooterRow.FindControl("lblFooterSuppServiceTotalUnits");
                    int totSuppServiceUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totSuppServiceUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterSuppServiceTotalUnits.Text = totSuppServiceUnits.ToString();
                    int TotalServSuppUnits = DataUtils.GetInt(txtSSUnits.Text);

                    hfPrimaryServiceWarning.Value = "0";
                    if (TotalServSuppUnits - totSuppServiceUnits != 0)
                    {
                        hfPrimaryServiceWarning.Value = "1";
                        WarningMessage(dvPrimaryServiceWarning, lblPrimaryServiceWarning, "The Primary Service Units must be equal to Service Supported Units.");
                    }
                    else
                    {
                        dvPrimaryServiceWarning.Visible = false;
                        lblPrimaryServiceWarning.Text = "";
                    }
                }
                else
                {
                    dvSuppServiceGrid.Visible = false;
                    gvSuppService.DataSource = null;
                    gvSuppService.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSuppServiceGrid", "", ex.Message);
            }
        }

        protected void gvSuppService_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSuppService.EditIndex = e.NewEditIndex;
            BindSuppServiceGrid();
        }

        protected void gvSuppService_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSuppService.EditIndex = -1;
            BindSuppServiceGrid();
        }

        protected void gvSuppService_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvSuppService.Rows[rowIndex].FindControl("txtSuppServiceNumunits")).Text;
            
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
            int ProjectSuppServID = DataUtils.GetInt(((Label)gvSuppService.Rows[rowIndex].FindControl("lblProjectSuppServID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvSuppService.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHousingSuppServ(ProjectSuppServID, Units, RowIsActive);
            gvSuppService.EditIndex = -1;

            LogMessage("Supplemental Service updated successfully");

            BindSuppServiceGrid();
        }

        protected void btnAddVHCBAff_Click(object sender, EventArgs e)
        {
            if (ddlVHCBAff.SelectedIndex == 0)
            {
                LogMessage("Select VHCB");
                ddlVHCBAff.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtVHCBUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtVHCBUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtVHCBUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtVHCBUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHousingVHCBAffordUnits(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlVHCBAff.SelectedValue.ToString()), DataUtils.GetInt(txtVHCBUnits.Text));
            ddlVHCBAff.SelectedIndex = -1;
            txtVHCBUnits.Text = "";
            cbAddVHCBAff.Checked = false;

            BindVHCBAffordGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("VHCB Affordability Units already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("VHCB Affordability Units already exist");
            else
                LogMessage("New VHCB Affordability Units added successfully");
        }

        private void BindVHCBAffordGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHousingVHCBAffordUnitsList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvVHCBAffGrid.Visible = true;
                    gvVHCBAff.DataSource = dt;
                    gvVHCBAff.DataBind();

                    Label lblFooterVHCBTotalUnits = (Label)gvVHCBAff.FooterRow.FindControl("lblFooterVHCBTotalUnits");
                    int totVHCBUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                        {
                            totVHCBUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());

                            if (dt.Rows[i]["VHCB"].ToString() == "Not in Covenant")
                                hfNotInCovenantCount.Value = dt.Rows[i]["numunits"].ToString();
                        }
                    }

                    spnVHCBAffUnits.InnerText = (DataUtils.GetInt(hfTotalUnitsFromDB.Value) - DataUtils.GetInt(hfNotInCovenantCount.Value)).ToString();

                    lblFooterVHCBTotalUnits.Text = totVHCBUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfVHCBUnitWarning.Value = "0";
                    if (TotalUnits - totVHCBUnits != 0)
                    {
                        hfVHCBUnitWarning.Value = "1";
                        WarningMessage(dvVHCBUnitWarning, lblVHCBUnitWarning, "VHCB Covenant Affordability Units must be equal to Total Units.");
                    }
                    else
                    {
                        dvVHCBUnitWarning.Visible = false;
                        lblVHCBUnitWarning.Text = "";
                    }
                }
                else
                {
                    dvVHCBAffGrid.Visible = false;
                    gvVHCBAff.DataSource = null;
                    gvVHCBAff.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindVHCBAffordGrid", "", ex.Message);
            }
        }

        protected void gvVHCBAff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvVHCBAff.EditIndex = e.NewEditIndex;
            BindVHCBAffordGrid();
        }

        protected void gvVHCBAff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvVHCBAff.EditIndex = -1;
            BindVHCBAffordGrid();
        }

        protected void gvVHCBAff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            string strUnits = ((TextBox)gvVHCBAff.Rows[rowIndex].FindControl("txtVHCBNumunits")).Text;

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

            int ProjectVHCBAffordUnitsID = DataUtils.GetInt(((Label)gvVHCBAff.Rows[rowIndex].FindControl("lblProjectVHCBAffordUnitsID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvVHCBAff.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHousingVHCBAffordUnits(ProjectVHCBAffordUnitsID, Units, RowIsActive);
            gvVHCBAff.EditIndex = -1;

            LogMessage("VHCB Affordability Units updated successfully");

            BindVHCBAffordGrid();
        }

        protected void btnAddSecServices_Click(object sender, EventArgs e)
        {
            if (ddlSecService.SelectedIndex == 0)
            {
                LogMessage("Select Service");
                ddlSecService.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtSecServiceUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtSecServiceUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtSecServiceUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtSecServiceUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHousingSecServ(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlSecService.SelectedValue.ToString()), DataUtils.GetInt(txtSecServiceUnits.Text));

            ddlSecService.SelectedIndex = -1;
            txtSecServiceUnits.Text = "";
            cbAddSecService.Checked = false;

            BindSecServiceGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Secondary Support Service already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Secondary Support Service already exist");
            else
                LogMessage("New Secondary Support Service added successfully");
        }

        private void BindSecServiceGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHousingSecServList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvSecServiceGrid.Visible = true;
                    gvSecService.DataSource = dt;
                    gvSecService.DataBind();

                    Label lblFooterSecServiceTotalUnits = (Label)gvSecService.FooterRow.FindControl("lblFooterSecServiceTotalUnits");
                    int totSecServiceUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totSecServiceUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterSecServiceTotalUnits.Text = totSecServiceUnits.ToString();
                }
                else
                {
                    dvSecServiceGrid.Visible = false;
                    gvSecService.DataSource = null;
                    gvSecService.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSecServiceGrid", "", ex.Message);
            }
        }

        protected void gvSecService_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSecService.EditIndex = e.NewEditIndex;
            BindSecServiceGrid();
        }

        protected void gvSecService_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSecService.EditIndex = -1;
            BindSecServiceGrid();
        }

        protected void gvSecService_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvSecService.Rows[rowIndex].FindControl("txtSecServiceNumunits")).Text;

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
            int ProjectSecSuppServID = DataUtils.GetInt(((Label)gvSecService.Rows[rowIndex].FindControl("lblProjectSecSuppServID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvSecService.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHousingSecServ(ProjectSecSuppServID, Units, RowIsActive);
            gvSecService.EditIndex = -1;

            LogMessage("Secondary Support Service updated successfully");

            BindSecServiceGrid();
        }

        protected void btnAddAgeRest_Click(object sender, EventArgs e)
        {
            if (ddlAgeRest.SelectedIndex == 0)
            {
                LogMessage("Select Age Restriction");
                ddlAgeRest.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtAgeRestUnits.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtAgeRestUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtAgeRestUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtAgeRestUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddProjectAgeRestrict(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlAgeRest.SelectedValue.ToString()), DataUtils.GetInt(txtAgeRestUnits.Text));

            ddlAgeRest.SelectedIndex = -1;
            txtAgeRestUnits.Text = "";
            cbAddAgeRes.Checked = false;

            BindAgeRestrictionGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Age restriction already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Age Restriction already exist");
            else
                LogMessage("Age Restriction added successfully");
        }

        private void BindAgeRestrictionGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetProjectAgeRestrictList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAgeRestrGrid.Visible = true;
                    gvAgeRestr.DataSource = dt;
                    gvAgeRestr.DataBind();

                    Label lblFooterAgeRestrTotalUnits = (Label)gvAgeRestr.FooterRow.FindControl("lblFooterAgeRestrTotalUnits");
                    int totAgeRestrUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totAgeRestrUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterAgeRestrTotalUnits.Text = totAgeRestrUnits.ToString();
                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfAgeRestrWarning.Value = "0";
                    //if (TotalUnits - totAgeRestrUnits != 0)
                    //{
                    //    hfAgeRestrWarning.Value = "1";
                    //    WarningMessage(dvAgeRestrWarning, lblAgeRestrWarning, "Age restrictions Units must be equal to Total Units.");
                    //}
                    //else
                    //{
                        dvAgeRestrWarning.Visible = false;
                        lblAgeRestrWarning.Text = "";
                    //}
                }
                else
                {
                    dvAgeRestrGrid.Visible = false;
                    gvAgeRestr.DataSource = null;
                    gvAgeRestr.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSecServiceGrid", "", ex.Message);
            }
        }

        protected void gvAgeRestr_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAgeRestr.EditIndex = e.NewEditIndex;
            BindAgeRestrictionGrid();
        }

        protected void gvAgeRestr_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAgeRestr.EditIndex = -1;
            BindAgeRestrictionGrid();
        }

        protected void gvAgeRestr_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string strUnits = ((TextBox)gvAgeRestr.Rows[rowIndex].FindControl("txtAgeRestrNumunits")).Text;

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
            int ProjectAgeRestrictID = DataUtils.GetInt(((Label)gvAgeRestr.Rows[rowIndex].FindControl("lblProjectAgeRestrictID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAgeRestr.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateProjectAgeRestrict(ProjectAgeRestrictID, Units, RowIsActive);
            gvAgeRestr.EditIndex = -1;

            LogMessage("Age restrictions updated successfully");

            BindAgeRestrictionGrid();
        }

        protected void ImgHousingSubType_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                 "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing SubType Units"));
        }

        protected void ImgNewConst_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Construction Rehab Units"));
        }

        protected void ImgAccessible_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Accessible Adaptable Units"));
        }

        protected void ImgPrimary_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Primary Services Support Units"));
        }

        protected void ImgSecondary_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Secondary Services Support Units"));
        }

        protected void ImgAge_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
               "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing Age Restricted Units"));
        }

        protected void ImgVHCBAff_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
               "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing VHCB Affordable Units"));
        }

        protected void ImgTargetEff_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
               "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing VHCB Target Effect Units"));
        }

        protected void btnAddTargetEff_Click(object sender, EventArgs e)
        {
            if (ddlTargetEff.SelectedIndex == 0)
            {
                LogMessage("Select Target Best Effort");
                ddlTargetEff.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtTargetUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtTargetUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtTargetUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtTargetUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddProjectHouseTargetUnits(
                DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlTargetEff.SelectedValue.ToString()), 
                DataUtils.GetInt(txtTargetUnits.Text));

            ddlTargetEff.SelectedIndex = -1;
            txtTargetUnits.Text = "";
            cbAddTargetEff.Checked = false;

            BindTargetBestEffortGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Target Best Effort Units already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Target Best Effort Units already exist");
            else
                LogMessage("New Target Best Effort Units added successfully");
        }

        private void BindTargetBestEffortGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetProjectHouseTargetUnitsList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvTargetEffGrid.Visible = true;
                    gvTargetEff.DataSource = dt;
                    gvTargetEff.DataBind();

                    Label lblFooterTargetTotalUnits = (Label)gvTargetEff.FooterRow.FindControl("lblFooterTargetTotalUnits");
                    int totTargetUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                        {
                            totTargetUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());

                            //if (dt.Rows[i]["VHCB"].ToString() == "Not in Covenant")
                            //    hfNotInCovenantCount.Value = dt.Rows[i]["numunits"].ToString();
                        }
                    }

                    //spnVHCBAffUnits.InnerText = (DataUtils.GetInt(hfTotalUnitsFromDB.Value) - DataUtils.GetInt(hfNotInCovenantCount.Value)).ToString();

                    lblFooterTargetTotalUnits.Text = totTargetUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfTargetEffWarning.Value = "0";
                    if (TotalUnits - totTargetUnits != 0)
                    {
                        hfTargetEffWarning.Value = "1";
                        WarningMessage(dvTargetEffWarning, lblTargetEffWarning, "Target Best Effort Units must be equal to Total Units.");
                    }
                    else
                    {
                        dvTargetEffWarning.Visible = false;
                        lblTargetEffWarning.Text = "";
                    }
                }
                else
                {
                    dvTargetEffGrid.Visible = false;
                    gvTargetEff.DataSource = null;
                    gvTargetEff.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindVHCBAffordGrid", "", ex.Message);
            }
        }

        protected void gvTargetEff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTargetEff.EditIndex = e.NewEditIndex;
            BindTargetBestEffortGrid();
        }

        protected void gvTargetEff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTargetEff.EditIndex = -1;
            BindTargetBestEffortGrid();
        }

        protected void gvTargetEff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            string strUnits = ((TextBox)gvTargetEff.Rows[rowIndex].FindControl("txtTargetUnits")).Text;

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

            int lblProjectHouseTargetID = DataUtils.GetInt(((Label)gvTargetEff.Rows[rowIndex].FindControl("lblProjectHouseTargetID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvTargetEff.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateProjectHouseTargetUnits(lblProjectHouseTargetID, Units, RowIsActive);
            gvTargetEff.EditIndex = -1;

            LogMessage("Target Best Effort Units updated successfully");

            BindTargetBestEffortGrid();
        }

        protected void ImgAffordableTo_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
               "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Housing VHCB AffordableTo Units"));
        }

        protected void gvAffordableTo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAffordableTo.EditIndex = e.NewEditIndex;
            BindAffordableToGrid();
        }

        protected void gvAffordableTo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAffordableTo.EditIndex = -1;
            BindAffordableToGrid();
        }

        protected void gvAffordableTo_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            string strUnits = ((TextBox)gvAffordableTo.Rows[rowIndex].FindControl("txtAffordToUnits")).Text;

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

            int ProjectHouseAffordToID = DataUtils.GetInt(((Label)gvAffordableTo.Rows[rowIndex].FindControl("lblProjectHouseAffordToID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAffordableTo.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateProjectHouseAffordTOUnits(ProjectHouseAffordToID, Units, RowIsActive);
            gvAffordableTo.EditIndex = -1;

            LogMessage("Affordable To Units updated successfully");

            BindAffordableToGrid();
        }

        private void BindAffordableToGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetProjectHouseAffordToUnitsList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAffordableToGrid.Visible = true;
                    gvAffordableTo.DataSource = dt;
                    gvAffordableTo.DataBind();

                    Label lblFooterAffordToTotalUnits = (Label)gvAffordableTo.FooterRow.FindControl("lblFooterAffordToTotalUnits");
                    int totAffordToUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                        {
                            totAffordToUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());

                            //if (dt.Rows[i]["VHCB"].ToString() == "Not in Covenant")
                            //    hfNotInCovenantCount.Value = dt.Rows[i]["numunits"].ToString();
                        }
                    }

                    //spnVHCBAffUnits.InnerText = (DataUtils.GetInt(hfTotalUnitsFromDB.Value) - DataUtils.GetInt(hfNotInCovenantCount.Value)).ToString();

                    lblFooterAffordToTotalUnits.Text = totAffordToUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfAffordableToWarning.Value = "0";
                    if (TotalUnits - totAffordToUnits != 0)
                    {
                        hfAffordableToWarning.Value = "1";
                        WarningMessage(dvAffordableToWarning, lblAffordableToWarning, "Affordable To Units must be equal to Total Units.");
                    }
                    else
                    {
                        dvAffordableToWarning.Visible = false;
                        lblAffordableToWarning.Text = "";
                    }
                }
                else
                {
                    dvAffordableToGrid.Visible = false;
                    gvAffordableTo.DataSource = null;
                    gvAffordableTo.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAffordableToGrid", "", ex.Message);
            }
        }

        protected void btnAddAffordableTo_Click(object sender, EventArgs e)
        {
            if (ddlAffordableTo.SelectedIndex == 0)
            {
                LogMessage("Select Affordable To");
                ddlAffordableTo.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtAffordableToUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Units");
                txtAffordableToUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtAffordableToUnits.Text) <= 0)
            {
                LogMessage("Enter valid Units");
                txtAffordableToUnits.Focus();
                return;
            }

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddProjectHouseAffordTOUnits(
                DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlAffordableTo.SelectedValue.ToString()),
                DataUtils.GetInt(txtAffordableToUnits.Text));

            ddlAffordableTo.SelectedIndex = -1;
            txtAffordableToUnits.Text = "";
            cbAddAffordableTo.Checked = false;

            BindAffordableToGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Affordable To Units already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Affordable To Units already exist");
            else
                LogMessage("New Affordable To Units added successfully");
        }

        //protected void btnAddHomeAff_Click(object sender, EventArgs e)
        //{
        //    if (ddlHomeAff.SelectedIndex == 0)
        //    {
        //        LogMessage("Select Home");
        //        ddlHomeAff.Focus();
        //        return;
        //    }

        //    if (string.IsNullOrWhiteSpace(txtHomeUnits.Text.ToString()) == true)
        //    {
        //        LogMessage("Enter Units");
        //        txtHomeUnits.Focus();
        //        return;
        //    }
        //    if (DataUtils.GetDecimal(txtHomeUnits.Text) <= 0)
        //    {
        //        LogMessage("Enter valid Units");
        //        txtHomeUnits.Focus();
        //        return;
        //    }

        //    HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHousingHomeAffordUnits(DataUtils.GetInt(hfHousingID.Value),
        //        DataUtils.GetInt(ddlHomeAff.SelectedValue.ToString()), DataUtils.GetInt(txtHomeUnits.Text));
        //    ddlHomeAff.SelectedIndex = -1;
        //    txtHomeUnits.Text = "";
        //    cbAddHomeAff.Checked = false;

        //    BindHomeAffordGrid();

        //    if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
        //        LogMessage("Home Affordability Units already exist as in-active");
        //    else if (objHousingUnitseResult.IsDuplicate)
        //        LogMessage("Home Affordability Units already exist");
        //    else
        //        LogMessage("New Home Affordability Units added successfully");
        //}

        //protected void gvNewHomeAff_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvNewHomeAff.EditIndex = e.NewEditIndex;
        //    BindHomeAffordGrid();
        //}

        //protected void gvNewHomeAff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvNewHomeAff.EditIndex = -1;
        //    BindHomeAffordGrid();
        //}

        //protected void gvNewHomeAff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int rowIndex = e.RowIndex;

        //    string strUnits = ((TextBox)gvNewHomeAff.Rows[rowIndex].FindControl("txtHomeNumunits")).Text;

        //    if (string.IsNullOrWhiteSpace(strUnits) == true)
        //    {
        //        LogMessage("Enter Units");
        //        return;
        //    }
        //    if (DataUtils.GetDecimal(strUnits) <= 0)
        //    {
        //        LogMessage("Enter valid Units");
        //        return;
        //    }

        //    int ProjectHomeAffordUnitsID = DataUtils.GetInt(((Label)gvNewHomeAff.Rows[rowIndex].FindControl("lblProjectHomeAffordUnitsID")).Text);
        //    int Units = DataUtils.GetInt(strUnits);
        //    bool RowIsActive = Convert.ToBoolean(((CheckBox)gvNewHomeAff.Rows[rowIndex].FindControl("chkActive")).Checked); ;

        //    HousingUnitsServicesData.UpdateHousingHomeAffordUnits(ProjectHomeAffordUnitsID, Units, RowIsActive);
        //    gvNewHomeAff.EditIndex = -1;

        //    LogMessage("Home Affordability Units updated successfully");

        //    BindHomeAffordGrid();
        //}

        //private void BindHomeAffordGrid()
        //{
        //    try
        //    {
        //        DataTable dt = HousingUnitsServicesData.GetHousingHomeAffordUnitsList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

        //        if (dt.Rows.Count > 0)
        //        {
        //            dvHomeAffGrid.Visible = true;
        //            gvNewHomeAff.DataSource = dt;
        //            gvNewHomeAff.DataBind();

        //            Label lblFooterHomeTotalUnits = (Label)gvNewHomeAff.FooterRow.FindControl("lblFooterHomeTotalUnits");
        //            int totHomeUnits = 0;

        //            for (int i = 0; i < dt.Rows.Count; i++)
        //            {
        //                if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
        //                    totHomeUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
        //            }

        //            lblFooterHomeTotalUnits.Text = totHomeUnits.ToString();
        //        }
        //        else
        //        {
        //            dvHomeAffGrid.Visible = false;
        //            gvNewHomeAff.DataSource = null;
        //            gvNewHomeAff.DataBind();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindHomeAffordGrid", "", ex.Message);
        //    }
        //}
    }
}