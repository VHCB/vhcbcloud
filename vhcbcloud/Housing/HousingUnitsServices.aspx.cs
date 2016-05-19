using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
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
            if (Request.QueryString["ProjectId"] != null)
                hfProjectId.Value = Request.QueryString["ProjectId"];

            GenerateTabs();
            if (!IsPostBack)
            {
                hfHousingID.Value = HousingSourcesUsesData.GetHousingID(DataUtils.GetInt(hfProjectId.Value)).ToString();

                PopulateProjectDetails();
                BindControls();
                BindHousingUnitsForm();
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
                txtTotalUnits.Text = drHousing["TotalUnits"].ToString();
                hfTotalUnitsFromDB.Value = drHousing["TotalUnits"].ToString();
                txtGrossLivingSpace.Text = drHousing["Hsqft"].ToString();
                txtUnitsFromPreProject.Text = drHousing["Previous"].ToString();
                txtNetNewUnits.Text = drHousing["NewUnits"].ToString();
                txtUnitsRelFromCov.Text = drHousing["RelCovenant"].ToString();
                txtRestrictionsReleaseDate.Text = drHousing["ResRelease"].ToString() == "" ? "" : Convert.ToDateTime(drHousing["ResRelease"].ToString()).ToShortDateString();

                if(ddlHousingType.SelectedIndex == 0)
                {
                    dvNewHousingSubType.Visible = false;
                    dvNewSingle.Visible = false;
                    dvNewMultiple.Visible = false;
                    dvNewSuppServices.Visible = false;
                    dvNewVHCBAff.Visible = false;
                    dvNewHomeAff.Visible = false;

                }
                else
                {
                    btnSubmit.Text = "Update";

                    dvNewHousingSubType.Visible = true;
                    dvNewSingle.Visible = true;
                    dvNewMultiple.Visible = true;
                    dvNewSuppServices.Visible = true;
                    dvNewVHCBAff.Visible = true;
                    dvNewHomeAff.Visible = true;
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
            BindHomeAffordGrid();
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
            BindLookUP(ddlVHCBAff, 109);
            BindLookUP(ddlHomeAff, 109);
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

            if (string.IsNullOrWhiteSpace(txtTotalUnits.Text.ToString()) == true)
            {
                LogMessage("Enter Total Units");
                txtTotalUnits.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtTotalUnits.Text) <= 0)
            {
                LogMessage("Enter valid Total Units");
                txtTotalUnits.Focus();
                return;
            }

            HousingUnitsServicesData.SubmitHousingUnits(DataUtils.GetInt(hfHousingID.Value), DataUtils.GetInt(ddlHousingType.SelectedValue.ToString()), DataUtils.GetInt(txtTotalUnits.Text),
                DataUtils.GetInt(txtGrossLivingSpace.Text), DataUtils.GetInt(txtUnitsFromPreProject.Text),
                DataUtils.GetInt(txtNetNewUnits.Text), DataUtils.GetInt(txtUnitsRelFromCov.Text), DataUtils.GetDate(txtRestrictionsReleaseDate.Text));

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
                        WarningMessage(dvSingleUnitWarning, lblSingleUnitWarning, "The Housing Single Units must be equal to Total Units.");
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
                LogMessage("Housing Single Unit Characteristic already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Housing Single Unit Characteristic already exist");
            else
                LogMessage("New Housing Single Unit Characteristic added successfully");
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

            LogMessage("Housing Single Unit Characteristic updated successfully");

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
                LogMessage("Housing Multiple Unit Characteristic already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Housing Multiple Unit Characteristic already exist");
            else
                LogMessage("New Housing Multiple Unit Characteristic added successfully");
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

                    Label lblFooterMultiUnitTotalUnits = (Label)gvMultiple.FooterRow.FindControl("lblFooterMultiUnitTotalUnits");
                    int totMultiUnits = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totMultiUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterMultiUnitTotalUnits.Text = totMultiUnits.ToString();

                    //int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);
                    //if (TotalUnits - totMultiUnits != 0)
                    //{
                    //    WarningMessage(dvSingleUnitWarning, lblSingleUnitWarning, "The Housing Single Units must be equal to Total Units.");
                    //}
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

            LogMessage("Housing Multiple Unit Characteristic updated successfully");

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
                            totVHCBUnits += DataUtils.GetInt(dt.Rows[i]["Numunits"].ToString());
                    }

                    lblFooterVHCBTotalUnits.Text = totVHCBUnits.ToString();

                    int TotalUnits = DataUtils.GetInt(hfTotalUnitsFromDB.Value);

                    hfVHCBUnitWarning.Value = "0";
                    if (TotalUnits - totVHCBUnits != 0)
                    {
                        hfVHCBUnitWarning.Value = "1";
                        WarningMessage(dvVHCBUnitWarning, lblVHCBUnitWarning, "VHCB Affordability Units must be equal to Total Units.");
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

        protected void btnAddHomeAff_Click(object sender, EventArgs e)
        {
            if (ddlHomeAff.SelectedIndex == 0)
            {
                LogMessage("Select Home");
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

            HousingUnitseResult objHousingUnitseResult = HousingUnitsServicesData.AddHousingHomeAffordUnits(DataUtils.GetInt(hfHousingID.Value),
                DataUtils.GetInt(ddlHomeAff.SelectedValue.ToString()), DataUtils.GetInt(txtHomeUnits.Text));
            ddlHomeAff.SelectedIndex = -1;
            txtHomeUnits.Text = "";
            cbAddHomeAff.Checked = false;

            BindHomeAffordGrid();

            if (objHousingUnitseResult.IsDuplicate && !objHousingUnitseResult.IsActive)
                LogMessage("Home Affordability Units already exist as in-active");
            else if (objHousingUnitseResult.IsDuplicate)
                LogMessage("Home Affordability Units already exist");
            else
                LogMessage("New Home Affordability Units added successfully");
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

            int ProjectHomeAffordUnitsID = DataUtils.GetInt(((Label)gvNewHomeAff.Rows[rowIndex].FindControl("lblProjectHomeAffordUnitsID")).Text);
            int Units = DataUtils.GetInt(strUnits);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvNewHomeAff.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingUnitsServicesData.UpdateHousingHomeAffordUnits(ProjectHomeAffordUnitsID, Units, RowIsActive);
            gvNewHomeAff.EditIndex = -1;

            LogMessage("Home Affordability Units updated successfully");

            BindHomeAffordGrid();
        }

        private void BindHomeAffordGrid()
        {
            try
            {
                DataTable dt = HousingUnitsServicesData.GetHousingHomeAffordUnitsList(DataUtils.GetInt(hfHousingID.Value), cbActiveOnly.Checked);

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
    }
}