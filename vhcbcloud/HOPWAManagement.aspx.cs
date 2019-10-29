using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class HOPWAManagement : System.Web.UI.Page
    {
        string Pagename = "HOPWAManagement";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                BindControls();
                BindHOPWAanMasterGrid();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlPrimaryASO, 232);
            BindLookUP(ddlEthnicity, 149);
            BindLookUP(ddlRace, 10);
            BindLookUP(ddlGMI, 242);
            BindLookUP(ddlAMI, 243);
            BindLookUP(ddlHOPWARace, 10);
            BindLookUP(ddlHOPWAEthnicity, 149);
            BindLookUP(ddlAgeGender, 231);

            BindLookUP(ddlProgram, 244);
            BindLookUP(ddlLivingSituation, 234);
            BindLookUP(ddlPHPuse, 233);
            LoadFundNames();
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
                ddlFund.DataSource = FundMaintenanceData.GetFundName(cbActiveOnly.Checked);
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
                HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAMaster(txtUUID.Text, txtHHIncludes.Text, DataUtils.GetInt(ddlPrimaryASO.SelectedValue.ToString()), DataUtils.GetInt(txtWithHIV.Text),
                    DataUtils.GetInt(txtInHouseHold.Text), DataUtils.GetInt(txtMinors.Text), DataUtils.GetInt(txtGender.Text), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()), 
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), DataUtils.GetInt(ddlGMI.SelectedValue.ToString()), DataUtils.GetInt(ddlAMI.SelectedValue.ToString()), DataUtils.GetInt(txtBeds.Text), txtNotes.Text);

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
                HOPWAMaintenanceData.UpdateHOPWAMaster(DataUtils.GetInt(hfHOPWAId.Value), txtHHIncludes.Text, DataUtils.GetInt(ddlPrimaryASO.SelectedValue.ToString()), DataUtils.GetInt(txtWithHIV.Text),
                    DataUtils.GetInt(txtInHouseHold.Text), DataUtils.GetInt(txtMinors.Text), DataUtils.GetInt(txtGender.Text), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), DataUtils.GetInt(ddlGMI.SelectedValue.ToString()), DataUtils.GetInt(ddlAMI.SelectedValue.ToString()), DataUtils.GetInt(txtBeds.Text), txtNotes.Text, 
                    cbHOPWAMaster.Checked);

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
                DataTable dtLoanMasterDetails = HOPWAMaintenanceData.GetHOPWAMasterList(cbActiveOnly.Checked);

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
            ddlPrimaryASO.SelectedIndex = -1;
            txtWithHIV.Text = "";
            txtInHouseHold.Text = "";
            txtMinors.Text = "";
            txtGender.Text = "";
            txtAge.Text = "";
            ddlEthnicity.SelectedIndex = -1;
            ddlRace.SelectedIndex = -1;
            ddlGMI.SelectedIndex = -1;
            ddlAMI.SelectedIndex = -1;
            txtBeds.Text = "";
            txtNotes.Text = "";
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
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblHOPWAID = e.Row.FindControl("lblHOPWAID") as Label;
                        DataRow drHOPWAMasterDetails = HOPWAMaintenanceData.GetHOPWAMasterDetailsByHOPWAID(Convert.ToInt32(lblHOPWAID.Text));

                        hfHOPWAId.Value = lblHOPWAID.Text;
                        txtUUID.Text = drHOPWAMasterDetails["UUID"].ToString();
                        PopulateDropDown(ddlPrimaryASO, drHOPWAMasterDetails["PrimaryASO"].ToString());
                        txtHHIncludes.Text = drHOPWAMasterDetails["HHincludes"].ToString();
                        txtWithHIV.Text = drHOPWAMasterDetails["WithHIV"].ToString();
                        txtInHouseHold.Text = drHOPWAMasterDetails["InHousehold"].ToString();
                        txtMinors.Text = drHOPWAMasterDetails["Minors"].ToString();
                        txtGender.Text = drHOPWAMasterDetails["Gender"].ToString();
                        txtAge.Text =  drHOPWAMasterDetails["Age"].ToString();
                        PopulateDropDown(ddlRace, drHOPWAMasterDetails["Race"].ToString());
                        PopulateDropDown(ddlEthnicity, drHOPWAMasterDetails["Ethnic"].ToString());
                        PopulateDropDown(ddlGMI, drHOPWAMasterDetails["GMI"].ToString());
                        PopulateDropDown(ddlAMI, drHOPWAMasterDetails["AMI"].ToString());
                        txtBeds.Text = drHOPWAMasterDetails["Beds"].ToString();
                        txtNotes.Text = drHOPWAMasterDetails["Notes"].ToString();
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
                        //Label lblNoteAmt = (Label)gvHOPWAMaster.Rows[i].Cells[1].FindControl("lblNoteAmt");

                        if (hf != null)
                        {
                            objSelectedHOPWAMasterInfo.HOPWAId = DataUtils.GetInt(hf.Value);
                            //objSelectedHOPWAMasterInfo.NoteAmt = lblNoteAmt.Text;
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
                    DataUtils.GetInt(ddlLivingSituation.SelectedValue.ToString()),
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
                    DataUtils.GetInt(ddlLivingSituation.SelectedValue.ToString()),
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
            ddlLivingSituation.SelectedIndex = -1;
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
                        PopulateDropDown(ddlLivingSituation, drHOPWAMasterDetails["LivingSituationId"].ToString());
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
            hfProgramName.Value =  objSelectedProgramInfo.ProgramName;

            cbAddExpense.Checked = false;

            tblPHP.Visible = false;
            tblSTRMU.Visible = false;

            if (objSelectedProgramInfo.ProgramName.ToString().ToUpper() == "PHP")
            {
                tblPHP.Visible = true;
            }
            else if (objSelectedProgramInfo.ProgramName.ToString().ToUpper() == "STRMU")
            {
                tblSTRMU.Visible = true;
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
                    DataUtils.GetInt(ddlPHPuse.SelectedValue.ToString()), DataUtils.GetDate(txtExpensesDate.Text), DataUtils.GetInt(txtDisRecord.Text));

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
                    DataUtils.GetInt(ddlPHPuse.SelectedValue.ToString()), DataUtils.GetDate(txtExpensesDate.Text), DataUtils.GetInt(txtDisRecord.Text), cbExpensesActive.Checked);

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
            txtDisRecord.Text = "";
            txtExpensesDate.Text = "";
            cbRent.Checked = false;
            cbMortgage.Checked = false;
            cbUtilities.Checked = false;
            ddlPHPuse.SelectedIndex = -1;
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
                        txtExpensesDate.Text = drHOPWAMasterDetails["Date"].ToString();
                        PopulateDropDown(ddlPHPuse, drHOPWAMasterDetails["PHPUse"].ToString());
                        txtDisRecord.Text = drHOPWAMasterDetails["DisbursementRecord"].ToString();
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
    }

    public class SelectedHOPWAMasterInfo
    {
        public int HOPWAId { set; get; }
    }

    public class SelectedProgramInfo
    {
        public int ProgramId { set; get; }
        public string ProgramName { set; get; }
    }
}