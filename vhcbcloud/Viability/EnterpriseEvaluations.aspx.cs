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
    public partial class EnterpriseEvaluations : System.Web.UI.Page
    { 
        string Pagename = "EnterpriseEvaluations";

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
            BindLookUP(ddlMilestone, 162);
            BindLookUP(ddlQuoteUse, 212);
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
                if (dr["URL"].ToString().Contains("EnterpriseEvaluations.aspx"))
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
            BindGrids();
        }

        private void BindGrids()
        {
            BindMilestonesGrid();
        }

        protected void btnAddEntMilestone_Click(object sender, EventArgs e)
        {
            if (ddlMilestone.SelectedIndex == -1)
            {
                LogMessage("Select Milestone");
                ddlMilestone.Focus();
                return;
            }

            bool PlanProcess = false;

            if (rdBtnPlanProcess.SelectedItem != null)
                PlanProcess = rdBtnPlanProcess.SelectedItem.Text == "Yes" ? true : false;

            if (btnAddEntMilestone.Text == "Submit")
            {
                ViabilityMaintResult objViabilityMaintResult = EnterpriseEvaluationsData.AddEnterpriseEvalMilestones(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlMilestone.SelectedValue.ToString()), DataUtils.GetDate(txtDate.Text),
                    txtComments.Text, txtLeadPlanAdvisorExp.Text, PlanProcess,
                    DataUtils.GetDecimal(Regex.Replace(txtLoanReq.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtLoanRec.Text, "[^0-9a-zA-Z.]+", "")),
                    cbLoanPending.Checked,
                    DataUtils.GetDecimal(Regex.Replace(txtGrantsReq.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtGrantsRec.Text, "[^0-9a-zA-Z.]+", "")),
                    cbGrantsPending.Checked,
                    DataUtils.GetDecimal(Regex.Replace(txtOtherReq.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtOtherRec.Text, "[^0-9a-zA-Z.]+", "")),
                    cbOtherPending.Checked,
                    txtSharedOutcome.Text, DataUtils.GetInt(ddlQuoteUse.SelectedValue.ToString()), ddlQuoteUse.SelectedItem.ToString());

                BindGrids();
                ClearEntMilestoneForm();

                if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                    LogMessage("Milestone already exist as in-active");
                else if (objViabilityMaintResult.IsDuplicate)
                    LogMessage("Milestone Info already exist");
                else
                    LogMessage("Milestone Info added successfully");
            }
            else
            {
                EnterpriseEvaluationsData.UpdateEnterpriseEvalMilestones(DataUtils.GetInt(hfEnterpriseEvalID.Value),
                    DataUtils.GetInt(ddlMilestone.SelectedValue.ToString()), DataUtils.GetDate(txtDate.Text),
                    txtComments.Text, txtLeadPlanAdvisorExp.Text, PlanProcess,
                    DataUtils.GetDecimal(Regex.Replace(txtLoanReq.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtLoanRec.Text, "[^0-9a-zA-Z.]+", "")),
                    cbLoanPending.Checked,
                    DataUtils.GetDecimal(Regex.Replace(txtGrantsReq.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtGrantsRec.Text, "[^0-9a-zA-Z.]+", "")),
                    cbGrantsPending.Checked,
                    DataUtils.GetDecimal(Regex.Replace(txtOtherReq.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtOtherRec.Text, "[^0-9a-zA-Z.]+", "")),
                    cbOtherPending.Checked,
                    txtSharedOutcome.Text, DataUtils.GetInt(ddlQuoteUse.SelectedValue.ToString()), ddlQuoteUse.SelectedItem.ToString(),
                    chkMilestoneActive.Checked);

                gvEntMilestoneGrid.EditIndex = -1;
                ClearEntMilestoneForm();
                BindGrids();
                btnAddEntMilestone.Text = "Submit";
                LogMessage("Milestone Info Updated Successfully");
            }
        }

        private void ClearEntMilestoneForm()
        {
            cbAddMilestone.Checked = false;
            ddlMilestone.SelectedIndex = -1;
            txtDate.Text = "";
            txtComments.Text = "";
            txtLeadPlanAdvisorExp.Text = "";
            rdBtnPlanProcess.ClearSelection();
            txtLoanReq.Text = "";
            txtLoanRec.Text = "";
            cbLoanPending.Checked = false;
            txtGrantsReq.Text = "";
            txtGrantsRec.Text = "";
            cbGrantsPending.Checked = false;
            txtOtherReq.Text = "";
            txtOtherRec.Text = "";
            cbOtherPending.Checked = false;
            txtSharedOutcome.Text = "";
            ddlQuoteUse.SelectedIndex = -1;
            chkMilestoneActive.Enabled = false;
            btnAddEntMilestone.Text = "Submit";
        }

        private void BindMilestonesGrid()
        {
            //dvNewDeveloperPayments.Visible = false;
            //dvNewlandUsePermitFinancials.Visible = false;
            //dvNewVHCBProjects.Visible = false;

            try
            {
                DataTable dt = EnterpriseEvaluationsData.GetEnterpriseEvalMilestonesList(DataUtils.GetInt(hfProjectId.Value), 
                    cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvEntMilestoneGrid.Visible = true;
                    gvEntMilestoneGrid.DataSource = dt;
                    gvEntMilestoneGrid.DataBind();
                }
                else
                {
                    dvEntMilestoneGrid.Visible = false;
                    gvEntMilestoneGrid.DataSource = null;
                    gvEntMilestoneGrid.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMilestonesGrid", "", ex.Message);
            }
        }

        protected void gvEntMilestoneGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEntMilestoneGrid.EditIndex = e.NewEditIndex;
            BindMilestonesGrid();
        }

        protected void gvEntMilestoneGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEntMilestoneGrid.EditIndex = -1;
            BindMilestonesGrid();
            ClearEntMilestoneForm();
            hfEnterpriseEvalID.Value = "";
            btnAddEntMilestone.Text = "Submit";
        }

        protected void gvEntMilestoneGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddEntMilestone.Text = "Update";
                    cbAddMilestone.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[0].Visible = false;
                        //e.Row.Cells[7].Controls[0].Visible = false;

                        Label lblEnterpriseEvalID = e.Row.FindControl("lblEnterpriseEvalID") as Label;
                        hfEnterpriseEvalID.Value = lblEnterpriseEvalID.Text;
                        PopulateEntMilestoneForm(DataUtils.GetInt(lblEnterpriseEvalID.Text));
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvEntMilestoneGrid_RowDataBound", "", ex.Message);
            }
        }

        protected void rdBtnSelectEntMilestone_CheckedChanged(object sender, EventArgs e)
        {
            //Set hfEnterpriseEvalID value based on radio button seletion
            GetEnterpriseEvalID(gvEntMilestoneGrid);

            btnAddEntMilestone.Text = "Update";
            cbAddMilestone.Checked = true;
            PopulateEntMilestoneForm(DataUtils.GetInt(hfEnterpriseEvalID.Value));
            ////////////////////////

            //dvNewDeveloperPayments.Visible = true;
            //BindDeveloperPaymentsGrid();

            //BindLandUsePermitFinancialsGrid();

            //dvNewVHCBProjects.Visible = true;
            //BindVHCBProjectsGrid();

        }

        private void PopulateEntMilestoneForm(int EnterpriseEvalID)
        {
            DataRow dr = EnterpriseEvaluationsData.GetEnterpriseEvalMilestonesById(EnterpriseEvalID);
            
            PopulateDropDown(ddlMilestone, dr["Milestone"].ToString());
            txtDate.Text = dr["MSDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MSDate"].ToString()).ToShortDateString();
            txtComments.Text = dr["Comment"].ToString();
            txtLeadPlanAdvisorExp.Text = dr["LeadPlanAdvisorExp"].ToString();
            rdBtnPlanProcess.SelectedIndex = dr["PlanProcess"].ToString() == "0" ? 0 : 1;
            txtLoanReq.Text = dr["LoanReq"].ToString();
            txtLoanRec.Text = dr["LoanRec"].ToString();
            cbLoanPending.Checked = DataUtils.GetBool(dr["LoanPend"].ToString()); 
            txtGrantsReq.Text = dr["GrantReq"].ToString();
            txtGrantsRec.Text = dr["GrantRec"].ToString();
            cbGrantsPending.Checked = DataUtils.GetBool(dr["GrantPend"].ToString()); 
            txtOtherReq.Text = dr["OtherReq"].ToString();
            txtOtherRec.Text = dr["OtherRec"].ToString();
            cbOtherPending.Checked = DataUtils.GetBool(dr["OtherPend"].ToString());
            txtSharedOutcome.Text = dr["SharedOutcome"].ToString();
            PopulateDropDown(ddlQuoteUse, dr["QuoteUse"].ToString());
            chkMilestoneActive.Enabled = true;
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

        private void GetEnterpriseEvalID(GridView gvEntMilestoneGrid)
        {
            hfEnterpriseEvalID.Value = null;

            for (int i = 0; i < gvEntMilestoneGrid.Rows.Count; i++)
            {
                RadioButton rbAct250Info = (RadioButton)gvEntMilestoneGrid.Rows[i].Cells[0].FindControl("rdBtnSelectEntMilestone");
                if (rbAct250Info != null)
                {
                    if (rbAct250Info.Checked)
                    {
                        HiddenField hf = (HiddenField)gvEntMilestoneGrid.Rows[i].Cells[0].FindControl("HiddenEnterpriseEvalID");

                        if (hf != null)
                        {
                            hfEnterpriseEvalID.Value = hf.Value;
                        }
                        break;
                    }
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearEntMilestoneForm();
        }
    }
}