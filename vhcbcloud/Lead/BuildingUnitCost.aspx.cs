using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Lead;

namespace vhcbcloud.Lead
{
    public partial class BuildingUnitCost : System.Web.UI.Page
    {
        string Pagename = "BuildingUnitCost";
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
            //GetRoleAuth();
        }
        private void BindGrids()
        {
            BindCRInfoGrid();
        }
        private void BindCRInfoGrid()
        {
            dvNewCost.Visible = false;
            try
            {
                DataTable dt = ProjectLeadBuildingsData.GetProjectMasterLeadCostsList(DataUtils.GetInt(hfProjectId.Value));

                if (dt.Rows.Count > 0)
                {
                    dvCRInfoGrid.Visible = true;
                    gvCRInfo.DataSource = dt;
                    gvCRInfo.DataBind();
                }
                else
                {
                    dvCRInfoGrid.Visible = false;
                    gvCRInfo.DataSource = null;
                    gvCRInfo.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCRInfoGrid", "", ex.Message);
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
                if (dr["URL"].ToString().Contains("BuildingUnitCost.aspx"))
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
            BindCRInfo();
            BindBuildingNumbers();
        }

        private void BindCRInfo()
        {
            try
            {
                ddlCheckRequest.Items.Clear();
                ddlCheckRequest.DataSource = ProjectLeadBuildingsData.GetCheckrequestInfoByProjectID(DataUtils.GetInt(hfProjectId.Value));
                ddlCheckRequest.DataValueField = "ProjectCheckReqID";
                ddlCheckRequest.DataTextField = "Detail";
                ddlCheckRequest.DataBind();
                ddlCheckRequest.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCRInfo", "Control ID:", ex.Message);
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

        protected void gvCRInfo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void rdBtnSelectCRInfo_CheckedChanged(object sender, EventArgs e)
        {
            SelectedUnitInfo objSelectedUnitInfo = GetProjectMasterLeadCostsID(gvCRInfo);

            hfProjectMasterLeadCostsID.Value = objSelectedUnitInfo.LeadUnitID.ToString();
            hfCRAmount.Value = objSelectedUnitInfo.Amount.ToString();

            dvNewCost.Visible = true;
            BindCostGrid();
        }

        private SelectedUnitInfo GetProjectMasterLeadCostsID(GridView gvCrInfo)
        {
            SelectedUnitInfo objSelectedUnitInfo = new SelectedUnitInfo();

            for (int i = 0; i < gvCrInfo.Rows.Count; i++)
            {
                RadioButton rbUnitInfo = (RadioButton)gvCrInfo.Rows[i].Cells[0].FindControl("rdBtnSelectCRInfo");
                if (rbUnitInfo != null)
                {
                    if (rbUnitInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvCrInfo.Rows[i].Cells[0].FindControl("HiddenProjectMasterLeadCostsID");
                        Label lblAmount = (Label)gvCrInfo.Rows[i].Cells[1].FindControl("lblAmount");

                        if (hf != null)
                        {
                            objSelectedUnitInfo.LeadUnitID = DataUtils.GetInt(hf.Value);
                            objSelectedUnitInfo.Amount = DataUtils.GetDecimal(Regex.Replace(lblAmount.Text, "[^0-9a-zA-Z.]+", ""));
                        }
                        break;
                    }
                }
            }
            return objSelectedUnitInfo;
        }

        protected void btnAddCRInfo_Click(object sender, EventArgs e)
        {
            if (ddlCheckRequest.SelectedIndex == 0)
            {
                LogMessage("Select Check Request Date");
                ddlCheckRequest.Focus();
                return;
            }

            LeadBuildResult objLeadBuildResult = ProjectLeadBuildingsData.AddProjectMasterLeadCosts(
                DataUtils.GetInt(ddlCheckRequest.SelectedValue.ToString()));

            ddlCheckRequest.SelectedIndex = -1;
            BindCRInfoGrid();
            cbAddCheckRequestInfo.Checked = false;

            if (objLeadBuildResult.IsDuplicate && !objLeadBuildResult.IsActive)
                LogMessage("Check Request already exist as in-active");
            else if (objLeadBuildResult.IsDuplicate)
                LogMessage("Check Request already exist");
            else
                LogMessage("Check Request Added Successfully");
        }

        private void BindBuildingNumbers()
        {
            try
            {
                ddlBldgNumber.Items.Clear();
                DataTable dt = new DataTable();
                dt = ProjectLeadOccupantsData.GetBuildingNumbers(DataUtils.GetInt(hfProjectId.Value));
                ddlBldgNumber.DataSource = dt;
                ddlBldgNumber.DataValueField = "LeadBldgID";
                ddlBldgNumber.DataTextField = "Building";
                ddlBldgNumber.DataBind();

                if (dt.Rows.Count > 1)
                {
                    ddlBldgNumber.Items.Insert(0, new ListItem("Select", "NA"));
                    //Unit Number Drop Down
                    ddlUnitNumber.Items.Clear();
                    ddlUnitNumber.Items.Insert(0, new ListItem("Select", "NA"));
                }
              else
                {
                    BindBuildingUnitNumbers(DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()));
                }
                
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildingNumbers", "", ex.Message);
            }
        }

        protected void ddlBldgNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBuildingUnitNumbers(DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()));
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

        protected void btnCostSubmit_Click(object sender, EventArgs e)
        {
            if (ddlBldgNumber.Items.Count > 1 && 
                ddlBldgNumber.SelectedIndex == 0)
            {
                LogMessage("Select Building Number");
                ddlBldgNumber.Focus();
                return;
            }
            else if (ddlUnitNumber.SelectedIndex == 0)
            {
                LogMessage("Select Unit Number");
                ddlUnitNumber.Focus();
                return;
            }

            if (btnCostSubmit.Text == "Submit")
            {
                LeadBuildResult objLeadBuildResult = ProjectLeadBuildingsData.AddProjectLeadCosts(
                DataUtils.GetInt(hfProjectMasterLeadCostsID.Value),
                DataUtils.GetInt(ddlUnitNumber.SelectedValue.ToString()),
                DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()),
                DataUtils.GetDecimal(Regex.Replace(txtCost.Text, "[^0-9a-zA-Z.]+", "")), txtNotes.Text);
               
                ddlBldgNumber.SelectedIndex = -1;
                ddlUnitNumber.SelectedIndex = -1;
                txtCost.Text = "";
                txtNotes.Text = "";

                BindCostGrid();
                cbAddCost.Checked = false;

                if (objLeadBuildResult.IsDuplicate && !objLeadBuildResult.IsActive)
                    LogMessage("Cost already exist as in-active");
                else if (objLeadBuildResult.IsDuplicate)
                    LogMessage("Cost already exist");
                else
                    LogMessage("Cost Added Successfully");
            }
            else
            {
                ProjectLeadBuildingsData.UpdateProjectLeadCost(DataUtils.GetInt(hfLeadCostsID.Value),  
                    DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlUnitNumber.SelectedValue.ToString()),
                    DataUtils.GetDecimal(Regex.Replace(txtCost.Text, "[^0-9a-zA-Z.]+", "")), txtNotes.Text, chkCostActive.Checked);

                gvCost.EditIndex = -1;
                BindCostGrid();
                hfLeadCostsID.Value = "";
                cbAddCost.Checked = false;
                txtNotes.Text = "";
                txtCost.Text = "";
                chkCostActive.Checked = true;
                chkCostActive.Enabled = false;
                
                ddlBldgNumber.SelectedIndex = -1;
                ddlUnitNumber.SelectedIndex = -1;

                btnCostSubmit.Text = "Submit";

                LogMessage("Cost Updated Successfully");
            }
        }

        protected void gvCost_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCost.EditIndex = e.NewEditIndex;
            BindCostGrid();
        }

        protected void gvCost_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCost.EditIndex = -1;
            BindCostGrid();
            cbAddCost.Checked = false;
            txtNotes.Text = "";
            txtCost.Text = "";
            chkCostActive.Checked = true;
            chkCostActive.Enabled = false;
            btnCostSubmit.Text = "Submit";
            ddlBldgNumber.SelectedIndex = -1;
            ddlUnitNumber.SelectedIndex = -1;
        }

        protected void gvCost_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnCostSubmit.Text = "Update";
                    
                    //if (DataUtils.GetBool(hfIsVisibleBasedOnRole.Value))
                    //    btnSubmit.Visible = true;
                    //else
                    //    btnSubmit.Visible = false;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        cbAddCost.Checked = true;

                        e.Row.Cells[7].Controls[1].Visible = false;

                        Label lblLeadCostsID = e.Row.FindControl("lblLeadCostsID") as Label;
                        DataRow dr = ProjectLeadBuildingsData.GetProjectLeadCostById(DataUtils.GetInt(lblLeadCostsID.Text));

                        hfLeadCostsID.Value = lblLeadCostsID.Text;

                        PopulateDropDown(ddlBldgNumber, dr["LeadBldgID"].ToString());
                        BindBuildingUnitNumbers(DataUtils.GetInt(dr["LeadBldgID"].ToString()));
                        PopulateDropDown(ddlUnitNumber, dr["LeadUnitID"].ToString());
                        
                        txtCost.Text = dr["Amount"].ToString();
                        txtNotes.Text = dr["Note"].ToString();

                        chkCostActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());

                        //ddlBldgNumber.Enabled = false;
                        //ddlUnitNumber.Enabled = false;
                        chkCostActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvCost_RowDataBound", "", ex.Message);
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

        private void BindCostGrid()
        {
            try
            {
                DataTable dt = ProjectLeadBuildingsData.GetProjectLeadCostsList(DataUtils.GetInt(hfProjectMasterLeadCostsID.Value), cbActiveOnly.Checked);
                decimal totAmt = 0;
                //hfBalAmt.Value = "";

                if (dt.Rows.Count > 0)
                {
                    dvCostGrid.Visible = true;
                    gvCost.DataSource = dt;
                    gvCost.DataBind();

                    Label lblTotAmt = (Label)gvCost.FooterRow.FindControl("lblFooterAmount");
                    Label lblBalAmt = (Label)gvCost.FooterRow.FindControl("lblFooterBalance");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (Convert.ToDecimal(dt.Rows[i]["Amount"].ToString()) > 0)
                            totAmt += Convert.ToDecimal(dt.Rows[i]["Amount"].ToString());
                    }
                    lblTotAmt.Text = CommonHelper.myDollarFormat(totAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(hfCRAmount.Value) - totAmt);

                    if (Convert.ToDecimal(hfCRAmount.Value) - totAmt != 0)
                    {
                        hfCostWarning.Value = "1";
                        WarningMessage(dvCostWarning, lblCostWarning,
                            "Cost must be equal to Check Request Info Amount " + CommonHelper.myDollarFormat(hfCRAmount.Value));
                    }
                    else
                    {
                        dvCostWarning.Visible = false;
                        lblCostWarning.Text = "";
                    }
                }
                else
                {
                    dvCostGrid.Visible = false;
                    gvCost.DataSource = null;
                    gvCost.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCostGrid", "", ex.Message);
            }

        }
        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }
    }
}