using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;


namespace vhcbcloud.Housing
{
    public partial class HOPWAManagement : System.Web.UI.Page
    {
        string Pagename = "HOPWAManagement";
      

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            string ProjectId = null;

            if (Request.QueryString["ProjectId"] != null)
                ProjectId = Request.QueryString["ProjectId"];

            hfProjectId.Value = ProjectId;

            GenerateTabs(ProjectId);

            ShowWarnings();

            if (!IsPostBack)
            {
                BindControls();
                BindLabels();
                DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(DataUtils.GetInt(ProjectId));
                spnPrimaryASO.InnerHtml = drProjectDetails["AppName"].ToString();
                hfAppNameId.Value = drProjectDetails["AppNameId"].ToString();
                BindHOPWAanMasterGrid();
            }
        }

        private void BindLabels()
        {
            lblYr1.InnerHtml = HOPWAMaintenanceData.GetHOPWAYearLabel(119);
            lblYr2.InnerHtml = HOPWAMaintenanceData.GetHOPWAYearLabel(120);
            lblYr3.InnerHtml = HOPWAMaintenanceData.GetHOPWAYearLabel(121);
        }

        private void GenerateTabs(string ProjectId)
        {
            string ProgramId = null;
           

            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

            

            //Active Tab
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + ProjectId);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            //DataTable dtTabs = TabsData.GetProgramTabs(DataUtils.GetInt(ProgramId));

            //foreach (DataRow dr in dtTabs.Rows)
            //{
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                //if (dr["URL"].ToString().Contains("HOPWAManagement.aspx"))
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                //else
                //    li1.Attributes.Add("class", "RoundedCornerTop");

                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", "#");
                anchor1.InnerText = "HOPWA";
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                li1.Controls.Add(anchor1);
            //}
        }

        private void BindControls()
        {
            //BindLookUP(ddlPrimaryASO, 232);
            BindLookUP(ddlEthnicity, 149);
            BindLookUP(ddlRace, 10);
            BindLookUP(ddlGMI, 242);
            BindLookUP(ddlAMI, 243);
            BindLookUP(ddlHOPWARace, 10);
            BindLookUP(ddlHOPWAEthnicity, 149);
            BindLookUP(ddlAgeGender, 231);
            BindLookUP(ddlGender, 267);// 231);
            BindLookUP(ddlSpecialNeeds, 245);
            BindLookUP(ddlLivingSituation, 234);
            //BindLookUP(ddlTransactionType, 51);
            BindLookUP(ddlProgram, 244);
            
            BindLookUP(ddlPHPuse, 233);
            LoadFundNames();
            LoadExpenseDates();
            LoadHOPWATransType();
        }

        private void LoadHOPWATransType()
        {
            try
            {
                ddlTransactionType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwaWithException");
                ddlTransactionType.DataValueField = "typeid";
                ddlTransactionType.DataTextField = "Description";
                ddlTransactionType.DataBind();
                ddlTransactionType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void LoadExpenseDates()
        {
            try
            {
                ddlExpensesDate.DataSource = HOPWAMaintenanceData.GetProjectCheckReqDates(DataUtils.GetInt(hfProjectId.Value));
                ddlExpensesDate.DataValueField = "ProjectCheckReqID";
                ddlExpensesDate.DataTextField = "CRDate";
                ddlExpensesDate.DataBind();
                ddlExpensesDate.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void ShowWarnings()
        {
            if (hfHOPWARaceWarning.Value != "1")
            {
                dvHOPWARaceWarning.Visible = false;
                lblHOPWARaceWarning.Text = "";
            }

            if (hfHOPWAEthnicityWarning.Value != "1")
            {
                dvHOPWAEthnicityWarning.Visible = false;
                lblHOPWAEthnicityWarning.Text = "";
            }

            if (hfHOPWAAgeWarning.Value != "1")
            {
                dvHOPWAAgeWarning.Visible = false;
                lblHOPWAAgeWarning.Text = "";
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

        private void LoadFundNames()
        {
            try
            {
                ddlFund.DataSource = HOPWAMaintenanceData.GetHOPWAFundName(cbActiveOnly.Checked);
                ddlFund.DataValueField = "fundid";
                ddlFund.DataTextField = "name";
                ddlFund.DataBind();
                ddlFund.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindHOPWAanMasterGrid();
        }

        protected void btnHOPWAMaster_Click(object sender, EventArgs e)
        {
            if (btnHOPWAMaster.Text == "Add")
            {
                HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAMaster(txtUUID.Text, txtHHIncludes.Text, DataUtils.GetInt(ddlSpecialNeeds.SelectedValue.ToString()), DataUtils.GetInt(txtWithHIV.Text),
                    DataUtils.GetInt(txtInHouseHold.Text), DataUtils.GetInt(txtMinors.Text), DataUtils.GetInt(ddlGender.Text), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), DataUtils.GetInt(ddlGMI.SelectedValue.ToString()), DataUtils.GetInt(ddlAMI.SelectedValue.ToString()), DataUtils.GetInt(txtBeds.Text), txtNotes.Text, 
                    DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlLivingSituation.SelectedValue.ToString()), 
                    DataUtils.GetInt(hfAppNameId.Value), DataUtils.GetInt(txtPreviosId.Text));

                if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                    LogMessage("HOPWA UUID already exist as in-active");
                else if (objHOPWAmainttResult.IsDuplicate)
                    LogMessage("HOPWA UUID already exist");
                else
                    LogMessage("HOPWA UUID added successfully");

                gvHOPWAMaster.EditIndex = -1;

                cbAddHOPWAMaster.Checked = false;
            }
            else
            {
                HOPWAMaintenanceData.UpdateHOPWAMaster(DataUtils.GetInt(hfHOPWAId.Value), txtHHIncludes.Text, DataUtils.GetInt(ddlSpecialNeeds.SelectedValue.ToString()), DataUtils.GetInt(txtWithHIV.Text),
                    DataUtils.GetInt(txtInHouseHold.Text), DataUtils.GetInt(txtMinors.Text), DataUtils.GetInt(ddlGender.Text), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), DataUtils.GetInt(ddlGMI.SelectedValue.ToString()), DataUtils.GetInt(ddlAMI.SelectedValue.ToString()), DataUtils.GetInt(txtBeds.Text), txtNotes.Text,
                    cbHOPWAMaster.Checked, DataUtils.GetInt(ddlLivingSituation.SelectedValue.ToString()), DataUtils.GetInt(txtPreviosId.Text)); ;

                LogMessage("HOPWA Master updated successfully");

                hfHOPWAId.Value = "";
                btnHOPWAMaster.Text = "Add";

                cbAddHOPWAMaster.Checked = false;
                gvHOPWAMaster.EditIndex = -1;
            }
            ClearHOPWAMasterForm();
            BindHOPWAanMasterGrid();
        }

        private void BindHOPWAanMasterGrid()
        {
            dvNewHOPWARace.Visible = false;
            dvNewHOPWAEthnicity.Visible = false;
            dvNewHOPWAAge.Visible = false;
            dvNewHOPWAProgram.Visible = false;
            dvNewExpenses.Visible = false;

            try
            {
                DataTable dtLoanMasterDetails = HOPWAMaintenanceData.GetHOPWAMasterList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtLoanMasterDetails.Rows.Count > 0)
                {
                    dvHOPWAMasterGrid.Visible = true;
                    gvHOPWAMaster.DataSource = dtLoanMasterDetails;
                    gvHOPWAMaster.DataBind();
                }
                else
                {
                    dvHOPWAMasterGrid.Visible = false;
                    gvHOPWAMaster.DataSource = null;
                    gvHOPWAMaster.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWAanMasterGrid", "", ex.Message);
            }
        }

        private void ClearHOPWAMasterForm()
        {
            txtUUID.Text = "";
            txtHHIncludes.Text = "";
            //ddlPrimaryASO.SelectedIndex = -1;
            txtWithHIV.Text = "";
            txtInHouseHold.Text = "";
            txtMinors.Text = "";
            //txtGender.Text = "";
            ddlGender.SelectedIndex = -1;
            txtAge.Text = "";
            ddlEthnicity.SelectedIndex = -1;
            ddlRace.SelectedIndex = -1;
            ddlGMI.SelectedIndex = -1;
            ddlAMI.SelectedIndex = -1;
            txtBeds.Text = "";
            txtNotes.Text = "";
            ddlSpecialNeeds.SelectedIndex = -1;
            ddlLivingSituation.SelectedIndex = -1;

            cbHOPWAMaster.Checked = true;
            cbHOPWAMaster.Enabled = false;
        }

        protected void gvHOPWAMaster_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHOPWAMaster.EditIndex = e.NewEditIndex;
            BindHOPWAanMasterGrid();
        }

        protected void gvHOPWAMaster_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbAddHOPWAMaster.Checked = false;
            ClearHOPWAMasterForm();
            btnHOPWAMaster.Text = "Add";
            gvHOPWAMaster.EditIndex = -1;
            BindHOPWAanMasterGrid();
        }

        protected void gvHOPWAMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnHOPWAMaster.Text = "Update";
                    cbAddHOPWAMaster.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[1].Visible = false;
                        Label lblHOPWAID = e.Row.FindControl("lblHOPWAID") as Label;
                        DataRow drHOPWAMasterDetails = HOPWAMaintenanceData.GetHOPWAMasterDetailsByHOPWAID(Convert.ToInt32(lblHOPWAID.Text));

                        hfHOPWAId.Value = lblHOPWAID.Text;
                        txtUUID.Text = drHOPWAMasterDetails["UUID"].ToString();
                        PopulateDropDown(ddlSpecialNeeds, drHOPWAMasterDetails["SpecNeeds"].ToString());
                        txtHHIncludes.Text = drHOPWAMasterDetails["HHincludes"].ToString();
                        txtWithHIV.Text = drHOPWAMasterDetails["WithHIV"].ToString();
                        txtInHouseHold.Text = drHOPWAMasterDetails["InHousehold"].ToString();
                        txtMinors.Text = drHOPWAMasterDetails["Minors"].ToString();
                        PopulateDropDown(ddlGender, drHOPWAMasterDetails["Gender"].ToString());
                        txtAge.Text = drHOPWAMasterDetails["Age"].ToString();
                        PopulateDropDown(ddlRace, drHOPWAMasterDetails["Race"].ToString());
                        PopulateDropDown(ddlEthnicity, drHOPWAMasterDetails["Ethnic"].ToString());
                        PopulateDropDown(ddlGMI, drHOPWAMasterDetails["GMI"].ToString());
                        PopulateDropDown(ddlAMI, drHOPWAMasterDetails["AMI"].ToString());
                        PopulateDropDown(ddlLivingSituation, drHOPWAMasterDetails["LivingSituationId"].ToString());
                        txtBeds.Text = drHOPWAMasterDetails["Beds"].ToString();
                        txtNotes.Text = drHOPWAMasterDetails["Notes"].ToString();
                        txtPreviosId.Text = drHOPWAMasterDetails["PrevHOPWAID"].ToString();
                        btnHOPWAMaster.Text = "Update";

                        cbHOPWAMaster.Checked = DataUtils.GetBool(drHOPWAMasterDetails["RowIsActive"].ToString()); ;
                        cbHOPWAMaster.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvLoanMaster_RowDataBound", "", ex.Message);
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

        protected void btnAddRace_Click(object sender, EventArgs e)
        {
            if (ddlHOPWARace.SelectedIndex == 0)
            {
                LogMessage("Select Race");
                ddlHOPWARace.Focus();
                return;
            }

            HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWARace(DataUtils.GetInt(hfHOPWAId.Value),
                DataUtils.GetInt(ddlHOPWARace.SelectedValue.ToString()), DataUtils.GetInt(txtHOPWAHousehold.Text));

            ddlHOPWARace.SelectedIndex = -1;
            txtHOPWAHousehold.Text = "";

            cbAddHOPWARace.Checked = false;

            BindHOPWARaceGrid();

            if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                LogMessage("HOPWA Race already exists as in-active");
            else if (objHOPWAmainttResult.IsDuplicate)
                LogMessage("HOPWA Race already exists");
            else
                LogMessage("New HOPWA Race added successfully");
        }

        private void BindHOPWARaceGrid()
        {
            try
            {
                DataTable dt = HOPWAMaintenanceData.GetHOPWARaceList(DataUtils.GetInt(hfHOPWAId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHOPWARaceGrid.Visible = true;
                    gvHOPWARace.DataSource = dt;
                    gvHOPWARace.DataBind();

                    Label lblFooterTotal = (Label)gvHOPWARace.FooterRow.FindControl("lblFooterTotal");
                    int totHousehold = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totHousehold += DataUtils.GetInt(dt.Rows[i]["HouseholdNum"].ToString());
                    }

                    lblFooterTotal.Text = totHousehold.ToString();

                    int TotalUnits = DataUtils.GetInt(hfHouseHold.Value);

                    hfHOPWARaceWarning.Value = "0";
                    if (TotalUnits - 1 - totHousehold != 0)
                    {
                        hfHOPWARaceWarning.Value = "1";
                        WarningMessage(dvHOPWARaceWarning, lblHOPWARaceWarning, "The number of HouseHold Members Race must be equal to number of Household " + (TotalUnits - 1));
                    }
                    else
                    {
                        dvHOPWARaceWarning.Visible = false;
                        lblHOPWARaceWarning.Text = "";
                    }
                }
                else
                {
                    dvHOPWARaceGrid.Visible = false;
                    gvHOPWARace.DataSource = null;
                    gvHOPWARace.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWARaceGrid", "", ex.Message);
            }
        }

        protected void gvHOPWARace_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHOPWARace.EditIndex = e.NewEditIndex;
            BindHOPWARaceGrid();
        }

        protected void gvHOPWARace_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHOPWARace.EditIndex = -1;
            BindHOPWARaceGrid();
        }

        protected void gvHOPWARace_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int HOPWARaceID = DataUtils.GetInt(((Label)gvHOPWARace.Rows[rowIndex].FindControl("lblHOPWARaceID")).Text);
            int RaceId = DataUtils.GetInt(((DropDownList)gvHOPWARace.Rows[rowIndex].FindControl("ddlHOPWARace1")).SelectedValue.ToString());
            int HouseholdNum = DataUtils.GetInt(((TextBox)gvHOPWARace.Rows[rowIndex].FindControl("txtHouseHold1")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvHOPWARace.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HOPWAMaintenanceData.UpdateHOPWARace(HOPWARaceID, RaceId, HouseholdNum, RowIsActive);
            gvHOPWARace.EditIndex = -1;

            BindHOPWARaceGrid();

            LogMessage("HOPWA Race updated successfully");
        }

        protected void rdBtnSelectHOPWAMaster_CheckedChanged(object sender, EventArgs e)
        {
            SelectedHOPWAMasterInfo objSelectedHOPWAMasterInfo = GetHOPWAMasterSelectedRecordID(gvHOPWAMaster);

            hfHOPWAId.Value = objSelectedHOPWAMasterInfo.HOPWAId.ToString();
            hfHouseHold.Value = objSelectedHOPWAMasterInfo.HouseholdNum.ToString();

            dvNewHOPWARace.Visible = true;
            BindHOPWARaceGrid();
            dvNewHOPWAProgram.Visible = true;
            BindHOPWAProgramGrid();
            dvNewHOPWAEthnicity.Visible = true;
            BindHOPWAEthnicityGrid();
            dvNewHOPWAAge.Visible = true;
            BindHOPWAAgeGrid();

        }

        private SelectedHOPWAMasterInfo GetHOPWAMasterSelectedRecordID(GridView gvHOPWAMaster)
        {
            SelectedHOPWAMasterInfo objSelectedHOPWAMasterInfo = new SelectedHOPWAMasterInfo();

            for (int i = 0; i < gvHOPWAMaster.Rows.Count; i++)
            {
                RadioButton rbLoanMasterInfo = (RadioButton)gvHOPWAMaster.Rows[i].Cells[0].FindControl("rdBtnSelectHOPWAMaster");
                if (rbLoanMasterInfo != null)
                {
                    if (rbLoanMasterInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvHOPWAMaster.Rows[i].Cells[0].FindControl("HiddenHOPWAID");
                        Label lblHousehold = (Label)gvHOPWAMaster.Rows[i].Cells[4].FindControl("lblHouseHoldNum");

                        if (hf != null)
                        {
                            objSelectedHOPWAMasterInfo.HOPWAId = DataUtils.GetInt(hf.Value);
                            objSelectedHOPWAMasterInfo.HouseholdNum = DataUtils.GetInt(lblHousehold.Text);
                        }
                        break;
                    }
                }
            }
            return objSelectedHOPWAMasterInfo;
        }

        protected void gvHOPWARace_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlHOPWARace1 = (e.Row.FindControl("ddlHOPWARace1") as DropDownList);
                    TextBox txtRaceId = (e.Row.FindControl("txtRaceId") as TextBox);

                    if (txtRaceId != null)
                    {
                        BindLookUP(ddlHOPWARace1, 10);
                        PopulateDropDown(ddlHOPWARace1, txtRaceId.Text);
                    }
                }
            }
        }

        protected void btnAddEthnicity_Click(object sender, EventArgs e)
        {
            if (ddlHOPWAEthnicity.SelectedIndex == 0)
            {
                LogMessage("Select Ethnicity");
                ddlHOPWAEthnicity.Focus();
                return;
            }

            HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAEthnicity(DataUtils.GetInt(hfHOPWAId.Value),
                DataUtils.GetInt(ddlHOPWAEthnicity.SelectedValue.ToString()), DataUtils.GetInt(txtHOPWAEthnicityHH.Text));

            ddlHOPWAEthnicity.SelectedIndex = -1;
            txtHOPWAEthnicityHH.Text = "";

            cbAddHOPWAEthnicity.Checked = false;

            BindHOPWAEthnicityGrid();

            if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                LogMessage("HOPWA Ethnicity already exists as in-active");
            else if (objHOPWAmainttResult.IsDuplicate)
                LogMessage("HOPWA Ethnicity already exists");
            else
                LogMessage("New Ethnicity added successfully");
        }

        private void BindHOPWAEthnicityGrid()
        {
            try
            {
                DataTable dt = HOPWAMaintenanceData.GetHOPWAEthnicityList(DataUtils.GetInt(hfHOPWAId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHOPWAEthnicityGrid.Visible = true;
                    gvHOPWAEthnicity.DataSource = dt;
                    gvHOPWAEthnicity.DataBind();

                    Label lblFooterTotal = (Label)gvHOPWAEthnicity.FooterRow.FindControl("lblFooterTotal");
                    int totHousehold = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totHousehold += DataUtils.GetInt(dt.Rows[i]["EthnicNum"].ToString());
                    }

                    lblFooterTotal.Text = totHousehold.ToString();

                    int TotalUnits = DataUtils.GetInt(hfHouseHold.Value);

                    hfHOPWAEthnicityWarning.Value = "0";
                    if (TotalUnits - 1 - totHousehold != 0)
                    {
                        hfHOPWAEthnicityWarning.Value = "1";
                        WarningMessage(dvHOPWAEthnicityWarning, lblHOPWAEthnicityWarning, "The number of HouseHold Members Ethnicity must be equal to number of Household " + (TotalUnits - 1));
                    }
                    else
                    {
                        dvHOPWAEthnicityWarning.Visible = false;
                        lblHOPWAEthnicityWarning.Text = "";
                    }
                }
                else
                {
                    dvHOPWAEthnicityGrid.Visible = false;
                    gvHOPWAEthnicity.DataSource = null;
                    gvHOPWAEthnicity.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWAEthnicityGrid", "", ex.Message);
            }
        }

        protected void gvHOPWAEthnicity_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHOPWAEthnicity.EditIndex = e.NewEditIndex;
            BindHOPWAEthnicityGrid();
        }

        protected void gvHOPWAEthnicity_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHOPWAEthnicity.EditIndex = -1;
            BindHOPWAEthnicityGrid();
        }

        protected void gvHOPWAEthnicity_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlHOPWAEthnicity1 = (e.Row.FindControl("ddlHOPWAEthnicity1") as DropDownList);
                    TextBox txtEthnicId = (e.Row.FindControl("txtEthnicId") as TextBox);

                    if (txtEthnicId != null)
                    {
                        BindLookUP(ddlHOPWAEthnicity1, 149);
                        PopulateDropDown(ddlHOPWAEthnicity1, txtEthnicId.Text);
                    }
                }
            }
        }

        protected void gvHOPWAEthnicity_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int HOPWAEthnicID = DataUtils.GetInt(((Label)gvHOPWAEthnicity.Rows[rowIndex].FindControl("lblHOPWAEthnicID")).Text);
            int EthnicId = DataUtils.GetInt(((DropDownList)gvHOPWAEthnicity.Rows[rowIndex].FindControl("ddlHOPWAEthnicity1")).SelectedValue.ToString());
            int HouseholdNum = DataUtils.GetInt(((TextBox)gvHOPWAEthnicity.Rows[rowIndex].FindControl("txtEthnicHH1")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvHOPWAEthnicity.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HOPWAMaintenanceData.UpdateHOPWAEthnicity(HOPWAEthnicID, EthnicId, HouseholdNum, RowIsActive);
            gvHOPWAEthnicity.EditIndex = -1;

            BindHOPWAEthnicityGrid();

            LogMessage("HOPWA Ethnicity updated successfully");
        }

        protected void btnAddAge_Click(object sender, EventArgs e)
        {
            if (ddlAgeGender.SelectedIndex == 0)
            {
                LogMessage("Select Age Gender");
                ddlAgeGender.Focus();
                return;
            }

            HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAAge(DataUtils.GetInt(hfHOPWAId.Value),
                DataUtils.GetInt(ddlAgeGender.SelectedValue.ToString()), DataUtils.GetInt(txtAgeNum.Text));

            ddlAgeGender.SelectedIndex = -1;
            txtAgeNum.Text = "";

            cbAddHOPWAAge.Checked = false;

            BindHOPWAAgeGrid();

            if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                LogMessage("HOPWA Age/Gender already exists as in-active");
            else if (objHOPWAmainttResult.IsDuplicate)
                LogMessage("HOPWA Age/Gender already exists");
            else
                LogMessage("New HOPWA Age/Gender added successfully");
        }

        protected void gvHOPWAAge_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHOPWAAge.EditIndex = e.NewEditIndex;
            BindHOPWAAgeGrid();
        }

        protected void gvHOPWAAge_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHOPWAAge.EditIndex = -1;
            BindHOPWAAgeGrid();
        }

        protected void gvHOPWAAge_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlHOPWAAgeGender1 = (e.Row.FindControl("ddlHOPWAAgeGender1") as DropDownList);
                    TextBox txtAgeGenderId = (e.Row.FindControl("txtAgeGenderId") as TextBox);

                    if (txtAgeGenderId != null)
                    {
                        BindLookUP(ddlHOPWAAgeGender1, 231);
                        PopulateDropDown(ddlHOPWAAgeGender1, txtAgeGenderId.Text);
                    }
                }
            }
        }

        protected void gvHOPWAAge_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int HOPWAAgeId = DataUtils.GetInt(((Label)gvHOPWAAge.Rows[rowIndex].FindControl("lblHOPWAAgeId")).Text);
            int AgeGenderId = DataUtils.GetInt(((DropDownList)gvHOPWAAge.Rows[rowIndex].FindControl("ddlHOPWAAgeGender1")).SelectedValue.ToString());
            int AgeNum = DataUtils.GetInt(((TextBox)gvHOPWAAge.Rows[rowIndex].FindControl("txtAgeNum1")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvHOPWAAge.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HOPWAMaintenanceData.UpdateHOPWAAge(HOPWAAgeId, AgeGenderId, AgeNum, RowIsActive);
            gvHOPWAAge.EditIndex = -1;

            BindHOPWAAgeGrid();

            LogMessage("HOPWA Age/Gender updated successfully");
        }
        private void BindHOPWAAgeGrid()
        {
            try
            {
                DataTable dt = HOPWAMaintenanceData.GetHOPWAAgeList(DataUtils.GetInt(hfHOPWAId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHOPWAAgeGrid.Visible = true;
                    gvHOPWAAge.DataSource = dt;
                    gvHOPWAAge.DataBind();

                    Label lblFooterTotal = (Label)gvHOPWAAge.FooterRow.FindControl("lblFooterTotal");
                    int totHousehold = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totHousehold += DataUtils.GetInt(dt.Rows[i]["GANum"].ToString());
                    }

                    lblFooterTotal.Text = totHousehold.ToString();

                    int TotalUnits = DataUtils.GetInt(hfHouseHold.Value);

                    hfHOPWAAgeWarning.Value = "0";
                    if (TotalUnits - 1 - totHousehold != 0)
                    {
                        hfHOPWAAgeWarning.Value = "1";
                        WarningMessage(dvHOPWAAgeWarning, lblHOPWAAgeWarning, "The total number of Gender by Age must be equal to number of Household " + (TotalUnits - 1));
                    }
                    else
                    {
                        dvHOPWAAgeWarning.Visible = false;
                        lblHOPWAAgeWarning.Text = "";
                    }
                }
                else
                {
                    dvHOPWAAgeGrid.Visible = false;
                    gvHOPWAAge.DataSource = null;
                    gvHOPWAAge.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWAAgeGrid", "", ex.Message);
            }
        }

        protected void btnProgram_Click(object sender, EventArgs e)
        {
            if (btnProgram.Text == "Add")
            {
                HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAProgram(DataUtils.GetInt(hfHOPWAId.Value), DataUtils.GetInt(ddlProgram.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlFund.SelectedValue.ToString()),
                    cbYear1.Checked, cbYear2.Checked, cbYear3.Checked,
                    DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text),
                    txtProgramNotes.Text);

                if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                    LogMessage("HOPWA Program already exist as in-active");
                else if (objHOPWAmainttResult.IsDuplicate)
                    LogMessage("HOPWA Program already exist");
                else
                    LogMessage("HOPWA Program added successfully");

                gvHOPWAProgram.EditIndex = -1;

                cbAddProgram.Checked = false;
            }
            else
            {
                HOPWAMaintenanceData.UpdateHOPWAProgram(DataUtils.GetInt(hfProgramId.Value), DataUtils.GetInt(ddlProgram.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlFund.SelectedValue.ToString()),
                    cbYear1.Checked, cbYear2.Checked, cbYear3.Checked,
                    DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text),
                    txtProgramNotes.Text, cbProgramActive.Checked);

                LogMessage("HOPWA Program updated successfully");

                hfProgramId.Value = "";
                btnProgram.Text = "Add";

                cbAddProgram.Checked = false;
                gvHOPWAProgram.EditIndex = -1;
            }
            ClearProgramForm();
            BindHOPWAProgramGrid();
        }

        private void ClearProgramForm()
        {
            ddlProgram.SelectedIndex = -1;
            ddlFund.SelectedIndex = -1;
            cbYear1.Checked = false;
            cbYear2.Checked = false;
            cbYear3.Checked = false;
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            //ddlLivingSituation.SelectedIndex = -1;
            txtProgramNotes.Text = "";
            cbProgramActive.Checked = true;
            cbProgramActive.Enabled = false;
            cbAddProgram.Checked = false;
        }

        protected void gvHOPWAProgram_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHOPWAProgram.EditIndex = e.NewEditIndex;
            BindHOPWAProgramGrid();
        }

        protected void gvHOPWAProgram_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHOPWAProgram.EditIndex = -1;
            ClearProgramForm();
            BindHOPWAProgramGrid();
            btnProgram.Text = "Add";
            hfProgramId.Value = "";
        }

        protected void gvHOPWAProgram_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    e.Row.Cells[6].Text = HOPWAMaintenanceData.GetHOPWAYearLabel(119);
                    e.Row.Cells[7].Text = HOPWAMaintenanceData.GetHOPWAYearLabel(120);
                    e.Row.Cells[8].Text = HOPWAMaintenanceData.GetHOPWAYearLabel(121);
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnProgram.Text = "Update";
                    cbAddProgram.Checked = true;
                    //Checking whether the Row is Data Row

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[10].Controls[0].Visible = false;
                        Label lblHOPWAProgramID = e.Row.FindControl("lblHOPWAProgramID") as Label;
                        DataRow drHOPWAMasterDetails = HOPWAMaintenanceData.GetHOPWAProgramById(Convert.ToInt32(lblHOPWAProgramID.Text));

                        hfProgramId.Value = lblHOPWAProgramID.Text;

                        PopulateDropDown(ddlProgram, drHOPWAMasterDetails["Program"].ToString());
                        PopulateDropDown(ddlFund, drHOPWAMasterDetails["Fund"].ToString());
                        cbYear1.Checked = DataUtils.GetBool(drHOPWAMasterDetails["Yr1"].ToString());
                        cbYear2.Checked = DataUtils.GetBool(drHOPWAMasterDetails["Yr2"].ToString());
                        cbYear3.Checked = DataUtils.GetBool(drHOPWAMasterDetails["yr3"].ToString());
                        txtStartDate.Text = drHOPWAMasterDetails["StartDate"].ToString();
                        txtEndDate.Text = drHOPWAMasterDetails["EndDate"].ToString();
                        
                        cbProgramActive.Checked = DataUtils.GetBool(drHOPWAMasterDetails["RowIsActive"].ToString());
                        cbProgramActive.Enabled = true;
                        txtProgramNotes.Text = drHOPWAMasterDetails["Notes"].ToString();
                        btnProgram.Text = "Update";
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvLoanMaster_RowDataBound", "", ex.Message);
            }
        }

        protected void rdBtnSelectProgram_CheckedChanged(object sender, EventArgs e)
        {
            SelectedProgramInfo objSelectedProgramInfo = GetSelectedProgramId(gvHOPWAProgram);

            hfProgramId.Value = objSelectedProgramInfo.ProgramId.ToString();
            hfProgramName.Value = objSelectedProgramInfo.ProgramName;

            cbAddExpense.Checked = false;

            tblPHP.Visible = false;
            tblSTRMU.Visible = false;
            PopulateDropDown(ddlTransactionType, "6344");

            if (objSelectedProgramInfo.ProgramName.ToString().ToUpper() == "PHP")
            {
                tblPHP.Visible = true;
                PopulateDropDown(ddlTransactionType, "6348");
            }
            else if (objSelectedProgramInfo.ProgramName.ToString().ToUpper() == "STRMU")
            {
                tblSTRMU.Visible = true;
                PopulateDropDown(ddlTransactionType, "6347");
            }

            dvNewExpenses.Visible = true;
            BindExpensesGrid();
        }

        private void BindHOPWAProgramGrid()
        {
            dvNewExpenses.Visible = false;
            try
            {
                DataTable dt = HOPWAMaintenanceData.GetHOPWAProgramList(DataUtils.GetInt(hfHOPWAId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHOPWAProgramGrid.Visible = true;
                    gvHOPWAProgram.DataSource = dt;
                    gvHOPWAProgram.DataBind();
                }
                else
                {
                    dvHOPWAProgramGrid.Visible = false;
                    gvHOPWAProgram.DataSource = null;
                    gvHOPWAProgram.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWAProgramGrid", "", ex.Message);
            }
        }

        private SelectedProgramInfo GetSelectedProgramId(GridView gvHOPWAProgram)
        {
            SelectedProgramInfo objSelectedProgramInfo = new SelectedProgramInfo();

            for (int i = 0; i < gvHOPWAMaster.Rows.Count; i++)
            {
                RadioButton rbLoanMasterInfo = (RadioButton)gvHOPWAProgram.Rows[i].Cells[0].FindControl("rdBtnSelectProgram");
                if (rbLoanMasterInfo != null)
                {
                    if (rbLoanMasterInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvHOPWAProgram.Rows[i].Cells[0].FindControl("HiddenProgramId");
                        Label lblProgram = (Label)gvHOPWAProgram.Rows[i].Cells[1].FindControl("lblProgram");

                        if (hf != null)
                        {
                            objSelectedProgramInfo.ProgramId = DataUtils.GetInt(hf.Value);
                            objSelectedProgramInfo.ProgramName = lblProgram.Text;
                        }
                        break;
                    }
                }
            }
            return objSelectedProgramInfo;
        }

        protected void btnAddExpense_Click(object sender, EventArgs e)
        {
            decimal amount = DataUtils.GetDecimal(Regex.Replace(txtAmount.Text, "[^0-9a-zA-Z.]+", ""));

            if (btnAddExpense.Text == "Add")
            {
                HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAExp(DataUtils.GetInt(hfProgramId.Value), amount, cbRent.Checked, cbMortgage.Checked, cbUtilities.Checked,
                    DataUtils.GetInt(ddlPHPuse.SelectedValue.ToString()), DataUtils.GetDate(ddlExpensesDate.SelectedItem.Text), DataUtils.GetInt(ddlExpensesDate.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlTransactionType.SelectedValue.ToString()));

                if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                    LogMessage("Program Expenses already exist as in-active");
                else if (objHOPWAmainttResult.IsDuplicate)
                    LogMessage("Program Expenses already exist");
                else
                    LogMessage("Program Expenses added successfully");

                gvExpenses.EditIndex = -1;

                cbAddExpense.Checked = false;
            }
            else
            {
                HOPWAMaintenanceData.UpdateHOPWAExp(DataUtils.GetInt(hfExpId.Value), amount, cbRent.Checked, cbMortgage.Checked, cbUtilities.Checked,
                    DataUtils.GetInt(ddlPHPuse.SelectedValue.ToString()), DataUtils.GetDate(ddlExpensesDate.SelectedItem.Text), DataUtils.GetInt(ddlExpensesDate.SelectedValue.ToString()), cbExpensesActive.Checked,
                    DataUtils.GetInt(ddlTransactionType.SelectedValue.ToString()));

                LogMessage("Program Expenses updated successfully");

                hfExpId.Value = "";
                btnAddExpense.Text = "Add";

                cbAddExpense.Checked = false;
                gvExpenses.EditIndex = -1;
            }
            ClearExpensesForm();
            BindExpensesGrid();
        }

        private void ClearExpensesForm()
        {
            txtAmount.Text = "";
            //txtDisRecord.Text = "";
            spnDisRecord.InnerHtml = "";
            ddlExpensesDate.SelectedIndex = -1;
            cbRent.Checked = false;
            cbMortgage.Checked = false;
            cbUtilities.Checked = false;
            ddlPHPuse.SelectedIndex = -1;
            ddlTransactionType.SelectedIndex = -1;

            

            if (hfProgramName.Value.ToUpper() == "PHP")
            {
                PopulateDropDown(ddlTransactionType, "6348");
            }
            else if (hfProgramName.Value.ToUpper() == "STRMU")
            {
                PopulateDropDown(ddlTransactionType, "6347");
            }
            else if(hfProgramName.Value.ToUpper() == "RA")
            {
                PopulateDropDown(ddlTransactionType, "6344");
            }
        }

        protected void gvExpenses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvExpenses.EditIndex = e.NewEditIndex;
            BindExpensesGrid();
        }

        protected void gvExpenses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvExpenses.EditIndex = -1;
            ClearExpensesForm();
            cbAddExpense.Checked = false;
            BindExpensesGrid();
        }

        protected void gvExpenses_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddExpense.Text = "Update";
                    cbAddExpense.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[0].Visible = false;
                        Label lblHOPWAExpID = e.Row.FindControl("lblHOPWAExpID") as Label;
                        DataRow drHOPWAMasterDetails = HOPWAMaintenanceData.GetHOPWAExpById(Convert.ToInt32(lblHOPWAExpID.Text));

                        hfExpId.Value = lblHOPWAExpID.Text;

                        txtAmount.Text = drHOPWAMasterDetails["Amount"].ToString();
                        //txtExpensesDate.Text = drHOPWAMasterDetails["Date"].ToString();
                        PopulateDropDown(ddlExpensesDate, drHOPWAMasterDetails["DisbursementRecord"].ToString());
                        PopulateDropDown(ddlPHPuse, drHOPWAMasterDetails["PHPUse"].ToString());
                        PopulateDropDown(ddlTransactionType, drHOPWAMasterDetails["TransType"].ToString());

                        //txtDisRecord.Text = drHOPWAMasterDetails["DisbursementRecord"].ToString();
                        spnDisRecord.InnerHtml = drHOPWAMasterDetails["DisbursementRecord"].ToString();
                        cbMortgage.Checked = DataUtils.GetBool(drHOPWAMasterDetails["Mortgage"].ToString());
                        cbRent.Checked = DataUtils.GetBool(drHOPWAMasterDetails["Rent"].ToString());
                        cbUtilities.Checked = DataUtils.GetBool(drHOPWAMasterDetails["Utilities"].ToString());
                        cbExpensesActive.Checked = DataUtils.GetBool(drHOPWAMasterDetails["RowIsActive"].ToString()); ;
                        cbExpensesActive.Enabled = true;

                        btnAddExpense.Text = "Update";
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvLoanMaster_RowDataBound", "", ex.Message);
            }
        }

        private void BindExpensesGrid()
        {
            try
            {
                DataTable dt = HOPWAMaintenanceData.GetHOPWAExpList(DataUtils.GetInt(hfProgramId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvExpensesGrid.Visible = true;
                    gvExpenses.DataSource = dt;
                    gvExpenses.DataBind();

                    decimal totAmt = 0;

                    Label lblTotAmt = (Label)gvExpenses.FooterRow.FindControl("lblFooterAmount");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (Convert.ToDecimal(dt.Rows[i]["Amount"].ToString()) > 0)
                            totAmt += Convert.ToDecimal(dt.Rows[i]["Amount"].ToString());
                    }
                    lblTotAmt.Text = CommonHelper.myDollarFormat(totAmt);
                }
                else
                {
                    dvExpensesGrid.Visible = false;
                    gvExpenses.DataSource = null;
                    gvExpenses.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindExpensesGrid", "", ex.Message);
            }
        }

        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }
    }

    public class SelectedHOPWAMasterInfo
    {
        public int HOPWAId { set; get; }
        public int HouseholdNum { set; get; }
    }

    public class SelectedProgramInfo
    {
        public int ProgramId { set; get; }
        public string ProgramName { set; get; }
    }
}