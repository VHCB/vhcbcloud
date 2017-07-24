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
using VHCBCommon.DataAccessLayer.Viability;

namespace vhcbcloud.Viability
{
    public partial class EnterpriseServiceProviders : System.Web.UI.Page
    {
        string Pagename = "EnterpriseServiceProviders";

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
                BindEntProvDataGrid();
            }
        }

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                this.MasterPageFile = "SiteNonAdmin.Master";
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

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void BindControls()
        {

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

            DataTable dtTabs = TabsData.GetProgramTabsForViability(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ProgramId));

            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString().Contains("EnterpriseServiceProviders.aspx"))
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
            BindEntProvDataGrid();
        }

        protected void btnAddServiceProviders_Click(object sender, EventArgs e)
        {
            try
            {
                int ProjectId = DataUtils.GetInt(hfProjectId.Value);

                if (IsFormDataValid())
                {
                    if (btnAddServiceProviders.Text.ToLower() == "update")
                    {
                        int EnterpriseMasterServiceProvID = DataUtils.GetInt(hfEnterpriseMasterServiceProvID.Value);
                        EnterpriseServiceProvidersData.UpdateEnterpriseServProviderData(EnterpriseMasterServiceProvID,
                            txtBusPlans.Text, DataUtils.GetDecimal(Regex.Replace(txtBusPlanProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtCashFlows.Text, DataUtils.GetDecimal(Regex.Replace(txtCashFlowProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtYr2Followup.Text, DataUtils.GetDecimal(Regex.Replace(txtYr2FollowUpProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtAddEnrollees.Text, DataUtils.GetDecimal(Regex.Replace(txtAddEnrolleeProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtWorkshopsEvents.Text, DataUtils.GetDecimal(Regex.Replace(txtWorkShopEventProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtNotes.Text, txtSplProjects.Text,

                            txtBusPlans1.Text, DataUtils.GetDecimal(Regex.Replace(txtBusPlanProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtCashFlows1.Text, DataUtils.GetDecimal(Regex.Replace(txtCashFlowProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtYr2Followup1.Text, DataUtils.GetDecimal(Regex.Replace(txtYr2FollowUpProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtAddEnrollees1.Text, DataUtils.GetDecimal(Regex.Replace(txtAddEnrolleeProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtWorkshopsEvents1.Text, DataUtils.GetDecimal(Regex.Replace(txtWorkShopEventProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtSplProjects1.Text, txtNotes1.Text, 
                            chkActive.Checked);

                        gvEntProvData.EditIndex = -1;

                        LogMessage("Enterprise Service Provider Data updated successfully");
                    }
                    else //add
                    {
                        ViabilityMaintResult objViabilityMaintResult = EnterpriseServiceProvidersData.AddEnterpriseServProviderData(ProjectId,
                            txtYear.Text, txtBusPlans.Text, DataUtils.GetDecimal(Regex.Replace(txtBusPlanProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtCashFlows.Text, DataUtils.GetDecimal(Regex.Replace(txtCashFlowProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtYr2Followup.Text, DataUtils.GetDecimal(Regex.Replace(txtYr2FollowUpProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtAddEnrollees.Text, DataUtils.GetDecimal(Regex.Replace(txtAddEnrolleeProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtWorkshopsEvents.Text, DataUtils.GetDecimal(Regex.Replace(txtWorkShopEventProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                            txtSplProjects.Text, txtNotes.Text,
                            txtBusPlans1.Text, DataUtils.GetDecimal(Regex.Replace(txtBusPlanProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtCashFlows1.Text, DataUtils.GetDecimal(Regex.Replace(txtCashFlowProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtYr2Followup1.Text, DataUtils.GetDecimal(Regex.Replace(txtYr2FollowUpProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtAddEnrollees1.Text, DataUtils.GetDecimal(Regex.Replace(txtAddEnrolleeProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtWorkshopsEvents1.Text, DataUtils.GetDecimal(Regex.Replace(txtWorkShopEventProjCost1.Text, "[^0-9a-zA-Z.]+", "")),
                            txtSplProjects1.Text, txtNotes1.Text);


                        if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                            LogMessage("Enterprise Service Provider Data already exist as in-active");
                        else if (objViabilityMaintResult.IsDuplicate)
                            LogMessage("Enterprise Service Provider Data already exist");
                        else
                            LogMessage("Enterprise Service Provider Data added successfully");
                    }
                    ClearEntProvDataForm();
                    BindEntProvDataGrid();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddServiceProviders_Click", "", ex.Message);
            }
        }

        private bool IsFormDataValid()
        {
            if (txtYear.Text.Trim() == "")
            {
                LogMessage("Enter Year");
                txtYear.Focus();
                return false;
            }

            return true;
        }

        private void BindEntProvDataGrid()
        {
            try
            {
                DataTable dt = EnterpriseServiceProvidersData.GetEnterpriseServProviderDataList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvEntProvDataGrid.Visible = true;
                    gvEntProvData.DataSource = dt;
                    gvEntProvData.DataBind();
                }
                else
                {
                    dvEntProvDataGrid.Visible = false;
                    gvEntProvData.DataSource = null;
                    gvEntProvData.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindEntProvDataGrid", "", ex.Message);
            }
        }

        protected void gvEntProvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddServiceProviders.Text = "Update";
                    cbAddYear.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[2].Controls[0].Visible = false;

                        Label lblEnterpriseMasterServiceProvID = e.Row.FindControl("lblEnterpriseMasterServiceProvID") as Label;
                        DataTable dt = EnterpriseServiceProvidersData.GetEnterpriseServProviderDataById(DataUtils.GetInt(lblEnterpriseMasterServiceProvID.Text));

                        hfEnterpriseMasterServiceProvID.Value = lblEnterpriseMasterServiceProvID.Text;

                        if (dt.Rows.Count == 2)
                        {
                            DataRow dr = dt.Rows[0];
                            txtYear.Text = dr["Year"].ToString() ?? "";

                            txtBusPlans.Text = dr["BusPlans"].ToString() ?? "";
                            txtBusPlanProjCost.Text = dr["BusPlanProjCost"].ToString() ?? "";
                            var bTotal = DataUtils.GetInt(txtBusPlans.Text) * DataUtils.GetDecimal(txtBusPlanProjCost.Text);
                            spnBusPlanTotal.InnerText = " $ " + bTotal.ToString();

                            txtCashFlows.Text = dr["CashFlows"].ToString() ?? "";
                            txtCashFlowProjCost.Text = dr["CashFlowProjCost"].ToString() ?? "";
                            var cTotal = DataUtils.GetInt(txtCashFlows.Text) * DataUtils.GetDecimal(txtCashFlowProjCost.Text);
                            spnCashFlowTotal.InnerText = " $ " + cTotal.ToString();

                            txtYr2Followup.Text = dr["Yr2Followup"].ToString() ?? "";
                            txtYr2FollowUpProjCost.Text = dr["Yr2FollowUpProjCost"].ToString() ?? "";
                            var yTotal = DataUtils.GetInt(txtYr2Followup.Text) * DataUtils.GetDecimal(txtYr2FollowUpProjCost.Text);
                            spnYest2FollowupsTotal.InnerText = " $ " + yTotal.ToString();

                            txtAddEnrollees.Text = dr["AddEnrollees"].ToString() ?? "";
                            txtAddEnrolleeProjCost.Text = dr["AddEnrolleeProjCost"].ToString() ?? "";
                            var aTotal = DataUtils.GetInt(txtAddEnrollees.Text) * DataUtils.GetDecimal(txtAddEnrolleeProjCost.Text);
                            spnAddEnrolleeProjTotal.InnerText = " $ " + aTotal.ToString();

                            txtWorkshopsEvents.Text = dr["WorkshopsEvents"].ToString() ?? "";
                            txtWorkShopEventProjCost.Text = dr["WorkShopEventProjCost"].ToString() ?? "";
                            var wTotal = DataUtils.GetInt(txtWorkshopsEvents.Text) * DataUtils.GetDecimal(txtWorkShopEventProjCost.Text);
                            spnWorkshopsTotal.InnerText = " $ " + wTotal.ToString();

                            txtNotes.Text = dr["Notes"].ToString() ?? "";
                            txtSplProjects.Text = dr["SpecialProj"].ToString() ?? "";

                            spnGrandTotal.InnerText = " $ " + (bTotal + cTotal + yTotal + aTotal + wTotal).ToString();

                            DataRow dr1 = dt.Rows[1];

                            txtBusPlans1.Text = dr1["BusPlans"].ToString() ?? "";
                            txtBusPlanProjCost1.Text = dr1["BusPlanProjCost"].ToString() ?? "";
                            var bTotal1 = DataUtils.GetInt(txtBusPlans1.Text) * DataUtils.GetDecimal(txtBusPlanProjCost1.Text);
                            spnBusPlanTotal1.InnerText = " $ " + bTotal1.ToString();

                            txtCashFlows1.Text = dr1["CashFlows"].ToString() ?? "";
                            txtCashFlowProjCost1.Text = dr1["CashFlowProjCost"].ToString() ?? "";
                            var cTotal1 = DataUtils.GetInt(txtCashFlows1.Text) * DataUtils.GetDecimal(txtCashFlowProjCost1.Text);
                            spnCashFlowTotal1.InnerText = " $ " + cTotal1.ToString();

                            txtYr2Followup1.Text = dr1["Yr2Followup"].ToString() ?? "";
                            txtYr2FollowUpProjCost1.Text = dr1["Yr2FollowUpProjCost"].ToString() ?? "";
                            var yTotal1 = DataUtils.GetInt(txtYr2Followup1.Text) * DataUtils.GetDecimal(txtYr2FollowUpProjCost1.Text);
                            spnYest2FollowupsTotal1.InnerText = " $ " + yTotal1.ToString();

                            txtAddEnrollees1.Text = dr1["AddEnrollees"].ToString() ?? "";
                            txtAddEnrolleeProjCost1.Text = dr1["AddEnrolleeProjCost"].ToString() ?? "";
                            var aTotal1 = DataUtils.GetInt(txtAddEnrollees1.Text) * DataUtils.GetDecimal(txtAddEnrolleeProjCost1.Text);
                            spnAddEnrolleeProjTotal1.InnerText = " $ " + aTotal1.ToString();

                            txtWorkshopsEvents1.Text = dr1["WorkshopsEvents"].ToString() ?? "";
                            txtWorkShopEventProjCost1.Text = dr1["WorkShopEventProjCost"].ToString() ?? "";
                            var wTotal1 = DataUtils.GetInt(txtWorkshopsEvents1.Text) * DataUtils.GetDecimal(txtWorkShopEventProjCost1.Text);
                            spnWorkshopsTotal1.InnerText = " $ " + wTotal1.ToString();

                            spnGrandTotal1.InnerText = " $ " + (bTotal1 + cTotal1 + yTotal1 + aTotal1 + wTotal1).ToString();

                            txtNotes1.Text = dr1["Notes"].ToString() ?? "";
                            txtSplProjects1.Text = dr1["SpecialProj"].ToString() ?? "";

                            //chkActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                            //chkActive.Enabled = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvEntProvData_RowDataBound", "", ex.Message);
            }
        }

        protected void gvEntProvData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEntProvData.EditIndex = -1;
            BindEntProvDataGrid();
            ClearEntProvDataForm();
            btnAddServiceProviders.Text = "Submit";
        }

        private void ClearEntProvDataForm()
        {
            txtYear.Text = "";
            txtBusPlans.Text = "";
            txtBusPlanProjCost.Text = "";
            txtCashFlows.Text = "";
            txtCashFlowProjCost.Text = "";
            txtYr2Followup.Text = "";
            txtYr2FollowUpProjCost.Text = "";
            txtAddEnrollees.Text = "";
            txtAddEnrolleeProjCost.Text = "";
            txtWorkshopsEvents.Text = "";
            txtWorkShopEventProjCost.Text = "";
            txtNotes.Text = "";
            txtSplProjects.Text = "";

            txtBusPlans1.Text = "";
            txtBusPlanProjCost1.Text = "";
            txtCashFlows1.Text = "";
            txtCashFlowProjCost1.Text = "";
            txtYr2Followup1.Text = "";
            txtYr2FollowUpProjCost1.Text = "";
            txtAddEnrollees1.Text = "";
            txtAddEnrolleeProjCost1.Text = "";
            txtWorkshopsEvents1.Text = "";
            txtWorkShopEventProjCost1.Text = "";
            txtNotes1.Text = "";
            txtSplProjects1
                .Text = "";
            cbAddYear.Checked = false;
            chkActive.Enabled = false;

        }

        protected void gvEntProvData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEntProvData.EditIndex = e.NewEditIndex;
            BindEntProvDataGrid();
        }
    }
}