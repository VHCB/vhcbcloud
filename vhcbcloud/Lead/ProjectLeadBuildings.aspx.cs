using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Lead;

namespace vhcbcloud.Lead
{
    public partial class ProjectLeadBuildings : System.Web.UI.Page
    {
        string Pagename = "ProjectLeadBuildings";
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
                BindGrids();
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
                if (dr["URL"].ToString().Contains("ProjectLeadBuildings.aspx"))
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
            BindAddresses();
            BindLookUP(ddlType, 22);
            BindLookUP(ddlverifiedBy, 150);
            BindLookUP(ddlHistoricStatus, 151);
            BindLookUP(ddlAppendixA, 152);
            BindLookUP(ddlEBlStatus, 153);
            BindLookUP(ddlIncomeStatus, 155);
        }

        private void BindAddresses()
        {
            try
            {
                ddlAddress.Items.Clear();
                ddlAddress.DataSource = ProjectLeadBuildingsData.GetProjectAddressListByProjectID(DataUtils.GetInt(hfProjectId.Value));
                ddlAddress.DataValueField = "AddressId";
                ddlAddress.DataTextField = "Address";
                ddlAddress.DataBind();
                ddlAddress.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAddresses", "Control ID:" + ddlAddress.ID, ex.Message);
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

        private void BindGrids()
        {
            BindBuildingsGrid();
            BindUnitsGrid();
        }

        private void BindBuildingsGrid()
        {
            dvNewUnitInfo.Visible = false;

            try
            {
                DataTable dt = ProjectLeadBuildingsData.GetProjectLeadBldgList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvBldgInfoGrid.Visible = true;
                    gvBldgInfo.DataSource = dt;
                    gvBldgInfo.DataBind();
                }
                else
                {
                    dvBldgInfoGrid.Visible = false;
                    gvBldgInfo.DataSource = null;
                    gvBldgInfo.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildings", "", ex.Message);
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

        protected void btnAddBldgInfoSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtBldgnumber.Text.ToString()) == true)
            {
                LogMessage("Enter Bldg #");
                txtBldgnumber.Focus();
                return;
            }
            if (ddlAddress.SelectedIndex == 0)
            {
                LogMessage("Select Address");
                ddlAddress.Focus();
                return;
            }
            if (ddlType.SelectedIndex == 0)
            {
                LogMessage("Select Type");
                ddlType.Focus();
                return;
            }

            if (btnAddBldgInfoSubmit.Text == "Submit")
            {
                LeadBuildResult objLeadBuildResult = ProjectLeadBuildingsData.AddProjectLeadBldg((DataUtils.GetInt(hfProjectId.Value)), DataUtils.GetInt(txtBldgnumber.Text), 
                    DataUtils.GetInt(ddlAddress.SelectedValue.ToString()), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlType.SelectedValue.ToString()), 
                    DataUtils.GetInt(txtLHCUnits.Text), cbFloodHazardArea.Checked, cbFloodInsurance.Checked, DataUtils.GetInt(ddlverifiedBy.SelectedValue.ToString()), 
                    txtInsuredby.Text, DataUtils.GetInt(ddlHistoricStatus.SelectedValue.ToString()), DataUtils.GetInt(ddlAppendixA.SelectedValue.ToString()));

                ClearBldgInfoForm();
                BindGrids();

                if (objLeadBuildResult.IsDuplicate && !objLeadBuildResult.IsActive)
                    LogMessage("Building Info already exist as in-active");
                else if (objLeadBuildResult.IsDuplicate)
                    LogMessage("Building Info already exist");
                else
                    LogMessage("Building Info Added Successfully");
            }
            else
            {
                ProjectLeadBuildingsData.UpdateProjectLeadBldg((DataUtils.GetInt(hfLeadBldgID.Value)), DataUtils.GetInt(txtBldgnumber.Text), DataUtils.GetInt(ddlAddress.SelectedValue.ToString()),
                  DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlType.SelectedValue.ToString()), DataUtils.GetInt(txtLHCUnits.Text), cbFloodHazardArea.Checked, cbFloodInsurance.Checked,
                  DataUtils.GetInt(ddlverifiedBy.SelectedValue.ToString()), txtInsuredby.Text, DataUtils.GetInt(ddlHistoricStatus.SelectedValue.ToString()), 
                  DataUtils.GetInt(ddlAppendixA.SelectedValue.ToString()), chkBldgActive.Checked);

                gvBldgInfo.EditIndex = -1;
                BindGrids();
                hfLeadBldgID.Value = "";
                ClearBldgInfoForm();
                btnAddBldgInfoSubmit.Text = "Submit";
                
                LogMessage("Building Info Updated Successfully");
            }
        }

        private void ClearBldgInfoForm()
        {
            cbAddBldgInfo.Checked = false;

            txtBldgnumber.Text = "";
            ddlAddress.SelectedIndex = -1;
            txtAge.Text = "";
            ddlType.SelectedIndex = -1;
            txtLHCUnits.Text = "";
            cbFloodHazardArea.Checked = false;
            cbFloodInsurance.Checked = false;
            ddlverifiedBy.SelectedIndex = -1;
            txtInsuredby.Text = "";
            ddlHistoricStatus.SelectedIndex = -1;
            ddlAppendixA.SelectedIndex = -1;
           
            txtBldgnumber.Enabled = true;
            chkBldgActive.Enabled = false;
        }

        protected void gvBldgInfo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBldgInfo.EditIndex = e.NewEditIndex;
            BindBuildingsGrid();
        }

        protected void gvBldgInfo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBldgInfo.EditIndex = -1;
            BindBuildingsGrid();
            ClearBldgInfoForm();
            hfLeadBldgID.Value = "";
            btnAddBldgInfoSubmit.Text = "Submit";
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

        protected void gvBldgInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddBldgInfoSubmit.Text = "Update";
                    cbAddBldgInfo.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;

                        Label lblLeadBldgID = e.Row.FindControl("lblLeadBldgID") as Label;
                        DataRow dr = ProjectLeadBuildingsData.GetProjectLeadBldgById(DataUtils.GetInt(lblLeadBldgID.Text));

                        hfLeadBldgID.Value = lblLeadBldgID.Text;

                        txtBldgnumber.Text = dr["Building"].ToString();
                        PopulateDropDown(ddlAddress, dr["AddressID"].ToString());
                        txtAge.Text = dr["Age"].ToString();
                        PopulateDropDown(ddlType, dr["Type"].ToString());
                        txtLHCUnits.Text = dr["LHCUnits"].ToString();
                        cbFloodHazardArea.Checked = DataUtils.GetBool(dr["FloodHazard"].ToString());
                        cbFloodInsurance.Checked = DataUtils.GetBool(dr["FloodIns"].ToString());
                        PopulateDropDown(ddlverifiedBy, dr["VerifiedBy"].ToString());
                        txtInsuredby.Text = dr["InsuredBy"].ToString();
                        PopulateDropDown(ddlHistoricStatus, dr["HistStatus"].ToString());
                        PopulateDropDown(ddlAppendixA, dr["AppendA"].ToString());

                        txtBldgnumber.Enabled = false;
                        chkBldgActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvBldgInfo_RowDataBound", "", ex.Message);
            }
        }

        protected void gvBldgInfo_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetBldgInfoSelectedRecordID(gvBldgInfo);
        }

        protected void rdBtnSelectBldgInfo_CheckedChanged(object sender, EventArgs e)
        {
            SelectedBldInfo objSelectedBldInfo = GetBldgInfoSelectedRecordID(gvBldgInfo);

            hfLeadBldgID.Value = objSelectedBldInfo.LeadBldgID.ToString();
            hfSelectedBuilding.Value = objSelectedBldInfo.Building.ToString();
            dvNewUnitInfo.Visible = true;
            BindUnitsGrid();
        }

        private SelectedBldInfo GetBldgInfoSelectedRecordID(GridView gvBldgInfo)
        {
            SelectedBldInfo objSelectedBldInfo = new SelectedBldInfo();

            for (int i = 0; i < gvBldgInfo.Rows.Count; i++)
            {
                RadioButton rbBldgInfo = (RadioButton)gvBldgInfo.Rows[i].Cells[0].FindControl("rdBtnSelectBldgInfo");
                if (rbBldgInfo != null)
                {
                    if (rbBldgInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvBldgInfo.Rows[i].Cells[0].FindControl("HiddenLeadBldgID");
                        Label lblBuilding = (Label)gvBldgInfo.Rows[i].Cells[1].FindControl("lblBuilding");

                        if (hf != null)
                        {
                            objSelectedBldInfo.LeadBldgID =  DataUtils.GetInt(hf.Value);
                            objSelectedBldInfo.Building = DataUtils.GetInt(lblBuilding.Text);
                        }
                        break;
                    }
                }
            }
            return objSelectedBldInfo;
        }

        private void BindUnitsGrid()
        {
            try
            {
                DataTable dt = ProjectLeadBuildingsData.GetProjectLeadUnitList(DataUtils.GetInt(hfLeadBldgID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvUnitInfoGrid.Visible = true;
                    gvUnitInfo.DataSource = dt;
                    gvUnitInfo.DataBind();
                }
                else
                {
                    dvUnitInfoGrid.Visible = false;
                    gvUnitInfo.DataSource = null;
                    gvUnitInfo.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindUnitsGrid", "", ex.Message);
            }
        }

        protected void btnAddUnitInfo_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUnitNumber.Text.ToString()) == true)
            {
                LogMessage("Enter Unit #");
                txtUnitNumber.Focus();
                return;
            }

            if (btnAddUnitInfo.Text == "Submit")
            {
                LeadBuildResult objLeadBuildResult =  ProjectLeadBuildingsData.AddProjectLeadUnit((DataUtils.GetInt(hfLeadBldgID.Value)), DataUtils.GetInt(txtUnitNumber.Text),
                    DataUtils.GetInt(ddlEBlStatus.SelectedValue.ToString()), DataUtils.GetInt(txtHouseholdCount.Text), DataUtils.GetInt(txtRooms.Text), 
                    DataUtils.GetDecimal(txtHouseholdIncome.Text), cbThirdPartyVerified.Checked, DataUtils.GetInt(ddlIncomeStatus.SelectedValue.ToString()), 
                    DataUtils.GetDecimal(txtMatchingFund.Text), DataUtils.GetDate(txtClearanceDate.Text), DataUtils.GetDate(txtCertifiedBy.Text), DataUtils.GetDate(txtCertifiedBy.Text));

                ClearUnitInfoForm();
                BindUnitsGrid();

                if (objLeadBuildResult.IsDuplicate && !objLeadBuildResult.IsActive)
                    LogMessage("Unit Info already exist as in-active");
                else if (objLeadBuildResult.IsDuplicate)
                    LogMessage("Unit Info already exist");
                else
                    LogMessage("Unit Info Added Successfully");
            }
            else
            {
                ProjectLeadBuildingsData.UpdateProjectLeadUnit((DataUtils.GetInt(hfLeadUnitID.Value)), DataUtils.GetInt(ddlEBlStatus.SelectedValue.ToString()),
                  DataUtils.GetInt(txtHouseholdCount.Text), DataUtils.GetInt(txtRooms.Text), DataUtils.GetDecimal(txtHouseholdIncome.Text), cbThirdPartyVerified.Checked, 
                  DataUtils.GetInt(ddlIncomeStatus.SelectedValue.ToString()), DataUtils.GetDecimal(txtMatchingFund.Text), DataUtils.GetDate(txtClearanceDate.Text), 
                  DataUtils.GetDate(txtCertifiedBy.Text), DataUtils.GetDate(txtCertifiedBy.Text), chkUnitActive.Checked);

                ClearUnitInfoForm();
                BindUnitsGrid();

                gvUnitInfo.EditIndex = -1;
                BindUnitsGrid();
                hfLeadUnitID.Value = "";
                ClearUnitInfoForm();
                btnAddUnitInfo.Text = "Submit";

                LogMessage("Unit Info Updated Successfully");
            }
        }

        private void ClearUnitInfoForm()
        {
            cbAddUnitInfo.Checked = false;

            txtUnitNumber.Text = "";
            ddlEBlStatus.SelectedIndex = -1;
            txtHouseholdCount.Text = "";
            txtRooms.Text = "";
            txtHouseholdIncome.Text = "";
            cbThirdPartyVerified.Checked = false;
            ddlIncomeStatus.SelectedIndex = -1;
            txtMatchingFund.Text = "";
            txtClearanceDate.Text = "";
            txtCertifiedBy.Text = "";
            //txtRectDate.Text = "";
            labelRectDate.InnerText = "";

            txtUnitNumber.Enabled = true;
            chkUnitActive.Enabled = false;

        }

        protected void gvUnitInfo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUnitInfo.EditIndex = e.NewEditIndex;
            BindUnitsGrid();
        }

        protected void gvUnitInfo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUnitInfo.EditIndex = -1;
            BindUnitsGrid();
            ClearUnitInfoForm();
            hfLeadUnitID.Value = "";
            btnAddUnitInfo.Text = "Submit";
        }

        protected void gvUnitInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddUnitInfo.Text = "Update";
                    cbAddUnitInfo.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[0].Visible = false;

                        Label lblLeadUnitID = e.Row.FindControl("lblLeadUnitID") as Label;
                        DataRow dr = ProjectLeadBuildingsData.GetProjectLeadUnitById(DataUtils.GetInt(lblLeadUnitID.Text));

                        hfLeadUnitID.Value = lblLeadUnitID.Text;


                        txtUnitNumber.Text = dr["Unit"].ToString();
                        PopulateDropDown(ddlEBlStatus, dr["EBLStatus"].ToString());
;
                        txtHouseholdCount.Text = dr["HHCount"].ToString();
                        txtRooms.Text = dr["Rooms"].ToString();
                        txtHouseholdIncome.Text = Decimal.Parse(dr["HHIncome"].ToString()).ToString("#.00");
                        cbThirdPartyVerified.Checked = DataUtils.GetBool(dr["PartyVerified"].ToString());
                        PopulateDropDown(ddlIncomeStatus, dr["IncomeStatus"].ToString());

                        txtMatchingFund.Text = Decimal.Parse(dr["MatchFunds"].ToString()).ToString("#.00");
                        txtClearanceDate.Text = dr["ClearDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["ClearDate"].ToString()).ToShortDateString();
                        txtCertifiedBy.Text = dr["CertDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["CertDate"].ToString()).ToShortDateString();

                        if (dr["CertDate"].ToString() != "")
                            labelRectDate.InnerText = Get6MonthsPlusDate(dr["CertDate"].ToString());
                        else
                            labelRectDate.InnerText = "";

                        txtUnitNumber.Enabled = false;
                        chkUnitActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvBldgInfo_RowDataBound", "", ex.Message);
            }
        }

        private static string Get6MonthsPlusDate(string date1)
        {
            if (date1 != "")
            {
                DateTime dt = Convert.ToDateTime(date1);
                dt = dt.AddMonths(6);
                return dt.ToShortDateString();
            }
            return "";
        }

        [WebMethod]
        public static string GetRecertifyDate(string CertifiedDate)
        {
            return Get6MonthsPlusDate(CertifiedDate);
        }
    }

    public class SelectedBldInfo
    {
        public int LeadBldgID { set; get; }
        public int Building { set; get; }
    }
}