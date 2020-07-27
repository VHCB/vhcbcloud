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
using VHCBCommon.DataAccessLayer.Conservation;
using VHCBCommon.DataAccessLayer.Viability;

namespace vhcbcloud.Viability
{
    public partial class EnterpriseImpGrant : System.Web.UI.Page
    {
        string Pagename = "EnterpriseImpGrant";

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
                LoadForm();

                BindGrantMatchGrid();
                BindAttributeGrid();
                BindFinJobsGrid();
                BindGrantMatchGrid();
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
            cbAddAttribute.Enabled = true;
            cbAddGrantmatch.Enabled = true;

            btnAddGrantApplication.Visible = false;
            btnUpdateGrantAward.Visible = false;
        }

        protected void RoleViewOnly()
        {
            btnAddAttribute.Visible = false;
            btnAddGrantApplication.Visible = false;
            btnAddMatchDesc.Visible = false;
            btnUpdateGrantAward.Visible = false;

            cbAddAttribute.Enabled = false;
            cbAddGrantmatch.Enabled = false;
        }

        //protected bool GetRoleAuth()
        //{
        //    bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
        //    if (!checkAuth)
        //        RoleReadOnly();
        //    return checkAuth;
        //}

        private void LoadForm()
        {
            DataRow drEntImpGrant = EnterpriseImpGrantData.GetEnterpriseImpGrantsById(DataUtils.GetInt(hfProjectId.Value));
            if (drEntImpGrant != null)
            {
                hfEnterImpGrantID.Value = drEntImpGrant["EnterImpGrantID"].ToString();
                PopulateDropDown(ddlFYGrantRound, drEntImpGrant["FYGrantRound"].ToString());
                txtProjectTitle.Text = drEntImpGrant["ProjTitle"].ToString();
                txtProjectDesc.Text = drEntImpGrant["ProjDesc"].ToString();
                txtProjCost.Text = drEntImpGrant["ProjCost"].ToString();
                txtAmountReq.Text = drEntImpGrant["Request"].ToString();
                txtAwardAmount.Text = drEntImpGrant["AwardAmt"].ToString();
                txtAwardDescription.Text = drEntImpGrant["AwardDesc"].ToString();
                spnLevFunds.InnerHtml = (DataUtils.GetDecimal(drEntImpGrant["ProjCost"].ToString()) - DataUtils.GetDecimal(drEntImpGrant["AwardAmt"].ToString())).ToString();
                txtComments.Text = drEntImpGrant["Comments"].ToString();
                txtOtherNames.Text = drEntImpGrant["OtherNames"].ToString();

                btnAddGrantApplication.Text = "Update";
                dvGrantAward.Visible = true;
            }
            else
            {
                btnAddGrantApplication.Text = "Add";
                dvGrantAward.Visible = false;
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

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void BindControls()
        {
            BindLookUP(ddlMilestone, 247);
            BindLookUP(ddlMatchDescription, 214);//214
            BindLookUP(ddlFYGrantRound, 220);
            BindLookUP(ddlAttribute, 228);
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
                if (dr["URL"].ToString().Contains("EnterpriseImpGrant.aspx"))
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
            BindGrantMatchGrid();
            BindAttributeGrid();
        }

        protected void btnAddGrantApplication_Click(object sender, EventArgs e)
        {
            UpdateForm();
        }

        private void UpdateForm()
        {
            try
            {
                int ProjectId = DataUtils.GetInt(hfProjectId.Value);

                if (btnAddGrantApplication.Text.ToLower() == "update" || btnUpdateGrantAward.Text.ToUpper() == "update")
                {
                    int EnterImpGrantID = DataUtils.GetInt(hfEnterImpGrantID.Value);
                    EnterpriseImpGrantData.UpdateEnterpriseImpGrants(EnterImpGrantID, txtOtherNames.Text,
                        DataUtils.GetInt(ddlFYGrantRound.SelectedValue.ToString()),
                        txtProjectTitle.Text, txtProjectDesc.Text, DataUtils.GetDecimal(Regex.Replace(txtProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDecimal(Regex.Replace(txtAmountReq.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDecimal(Regex.Replace(txtAwardAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        txtAwardDescription.Text,
                        DataUtils.GetDecimal(Regex.Replace(txtProjCost.Text, "[^0-9a-zA-Z.]+", "")) - DataUtils.GetDecimal(Regex.Replace(txtAwardAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        txtComments.Text, true);

                    LogMessage("Grant Application updated successfully");
                }
                else //add
                {
                    ViabilityMaintResult objViabilityMaintResult = EnterpriseImpGrantData.AddEnterpriseImpGrants(ProjectId, txtOtherNames.Text,
                        DataUtils.GetInt(ddlFYGrantRound.SelectedValue.ToString()),
                        txtProjectTitle.Text, txtProjectDesc.Text, DataUtils.GetDecimal(Regex.Replace(txtProjCost.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDecimal(Regex.Replace(txtAmountReq.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDecimal(Regex.Replace(txtAwardAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        txtAwardDescription.Text,
                        DataUtils.GetDecimal(Regex.Replace(txtProjCost.Text, "[^0-9a-zA-Z.]+", "")) - DataUtils.GetDecimal(Regex.Replace(txtAwardAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        txtComments.Text);

                    if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                        LogMessage("Grant Application already exist as in-active");
                    else if (objViabilityMaintResult.IsDuplicate)
                        LogMessage("Grant Application already exist");
                    else
                        LogMessage("Grant Application added successfully");
                }
                LoadForm();
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddGrantApplication_Click", "", ex.Message);
            }
        }

        protected void btnUpdateGrantAward_Click(object sender, EventArgs e)
        {
            UpdateForm();
        }

        protected void btnAddMatchDesc_Click(object sender, EventArgs e)
        {
            if (ddlMatchDescription.SelectedIndex == 0)
            {
                LogMessage("Select Match");
                ddlMatchDescription.Focus();
                return;
            }

            ViabilityMaintResult objViabilityMaintResult = EnterpriseImpGrantData.AddEnterpriseGrantMatch(DataUtils.GetInt(hfEnterImpGrantID.Value),
                DataUtils.GetInt(ddlMatchDescription.SelectedValue.ToString()), DataUtils.GetDecimal(Regex.Replace(txtGrantAmt.Text, "[^0-9a-zA-Z.]+", "")));

            ddlMatchDescription.SelectedIndex = -1;
            txtGrantAmt.Text = "";
            cbAddGrantmatch.Checked = false;

            BindGrantMatchGrid();

            if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                LogMessage("Grant Match already exist as in-active");
            else if (objViabilityMaintResult.IsDuplicate)
                LogMessage("Grant Match already exist");
            else
                LogMessage("New Grant Match added successfully");
        }

        private void BindGrantMatchGrid()
        {
            try
            {
                DataTable dt = EnterpriseImpGrantData.GetEnterpriseGrantMatchList(DataUtils.GetInt(hfEnterImpGrantID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvGrantMatchGrid.Visible = true;
                    gvGrantMatch.DataSource = dt;
                    gvGrantMatch.DataBind();

                    decimal totAmt = 0;

                    Label lblTotAmt = (Label)gvGrantMatch.FooterRow.FindControl("lblFooterAmount");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (Convert.ToDecimal(dt.Rows[i]["GrantAmt"].ToString()) > 0)
                            totAmt += Convert.ToDecimal(dt.Rows[i]["GrantAmt"].ToString());
                    }
                    lblTotAmt.Text = CommonHelper.myDollarFormat(totAmt);
                }
                else
                {
                    dvGrantMatchGrid.Visible = false;
                    gvGrantMatch.DataSource = null;
                    gvGrantMatch.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindGrantMatchGrid", "", ex.Message);
            }
        }

        protected void gvGrantMatch_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvGrantMatch.EditIndex = e.NewEditIndex;
            BindGrantMatchGrid();
        }

        protected void gvGrantMatch_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvGrantMatch.EditIndex = -1;
            BindGrantMatchGrid();
            ddlMatchDescription.SelectedIndex = -1;
            txtGrantAmt.Text = "";
        }

        protected void gvGrantMatch_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int EnterpriseGrantMatchID = DataUtils.GetInt(((Label)gvGrantMatch.Rows[rowIndex].FindControl("lblEnterpriseGrantMatchID")).Text);
            decimal GrantAmt = DataUtils.GetDecimal(((TextBox)gvGrantMatch.Rows[rowIndex].FindControl("txtGrantAmt")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvGrantMatch.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            EnterpriseImpGrantData.UpdateEnterpriseGrantMatch(EnterpriseGrantMatchID, GrantAmt, RowIsActive);
            gvGrantMatch.EditIndex = -1;

            BindGrantMatchGrid();

            LogMessage("Grant Match updated successfully");
        }

        protected void btnAddAttribute_Click(object sender, EventArgs e)
        {
            if (ddlAttribute.SelectedIndex == 0)
            {
                LogMessage("Select Attribute");
                ddlAttribute.Focus();
                return;
            }

            int EnterImpGrantID = DataUtils.GetInt(hfEnterImpGrantID.Value);

            AttributeResult obAttributeResult = EnterpriseImpGrantData.AddEnterpriseGrantAttributes(EnterImpGrantID,
               DataUtils.GetInt(ddlAttribute.SelectedValue.ToString()));
            ddlAttribute.SelectedIndex = -1;
            cbAddAttribute.Checked = false;

            BindAttributeGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Attribute already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Attribute already exist");
            else
                LogMessage("New Attribute added successfully");
        }

        private void BindAttributeGrid()
        {
            try
            {
                DataTable dt = EnterpriseImpGrantData.GetEnterpriseGrantAttributesList(DataUtils.GetInt(hfEnterImpGrantID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAttributeGrid.Visible = true;
                    gvAttribute.DataSource = dt;
                    gvAttribute.DataBind();
                }
                else
                {
                    dvAttributeGrid.Visible = false;
                    gvAttribute.DataSource = null;
                    gvAttribute.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAttributeGrid", "", ex.Message);
            }
        }

        protected void gvAttribute_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAttribute.EditIndex = e.NewEditIndex;
            BindAttributeGrid();
        }

        protected void gvAttribute_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAttribute.EditIndex = -1;
            BindAttributeGrid();
        }

        protected void gvAttribute_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int EnterImpAttributeID = DataUtils.GetInt(((Label)gvAttribute.Rows[rowIndex].FindControl("lblEnterImpAttributeID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAttribute.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            EnterpriseImpGrantData.UpdateEnterpriseGrantAttributes(EnterImpAttributeID, RowIsActive);
            gvAttribute.EditIndex = -1;

            BindAttributeGrid();

            LogMessage("Attribute updated successfully");
        }

        protected void gvFiniceJobs_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFiniceJobs.EditIndex = e.NewEditIndex;
            BindFinJobsGrid();
        }

        protected void gvFiniceJobs_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFiniceJobs.EditIndex = -1;
            BindFinJobsGrid();
            ClearFinJobsForm();

            btnAddMilestone.Visible = true;
            btnAddMilestone.Text = "Submit";
        }

        protected void gvFiniceJobs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddMilestone.Text = "Update";
                    cbAddMilestone.Checked = true;

                    if (DataUtils.GetBool(hfIsVisibleBasedOnRole.Value))
                        btnAddMilestone.Visible = true;
                    else
                        btnAddMilestone.Visible = false;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[1].Visible = false;

                        Label lblEnterFinancialJobsID = e.Row.FindControl("lblEnterFinancialJobsID") as Label;
                        DataRow dr = EnterpriseFundamentalsData.GetEnterpriseFinancialJobsById(DataUtils.GetInt(lblEnterFinancialJobsID.Text));

                        hfEnterFinancialJobsID.Value = lblEnterFinancialJobsID.Text;

                        PopulateDropDown(ddlMilestone, dr["StatusPt"].ToString());

                        //cbVHFAInv.Checked = DataUtils.GetBool(dr["vhfa"].ToString()); ;
                        //cbRDLoan.Checked = DataUtils.GetBool(dr["RDLoan"].ToString()); ;

                        txtMSDate.Text = dr["MSDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MSDate"].ToString()).ToShortDateString();
                        //txtYear.Text = dr["Year"].ToString() ?? "";
                        txtGrossSales.Text = dr["GrossSales"].ToString() ?? "";
                        txtNetIncome.Text = dr["Netincome"].ToString() ?? "";
                        txtGrossPayroll.Text = dr["GrossPayroll"].ToString() ?? "";
                        txtFamilyFTEmp.Text = dr["FamilyFTE"].ToString() ?? "";
                        txtNonFamilyFTEmp.Text = dr["NonFamilyFTE"].ToString() ?? "";
                        txtNetworth.Text = dr["Networth"].ToString() ?? "";
                        txtAccessFTE.Text = dr["AccessFTE"].ToString() ?? "";
                        spnTotalFulltime.InnerText = (DataUtils.GetDecimal(dr["FamilyFTE"].ToString()) + DataUtils.GetDecimal(dr["NonFamilyFTE"].ToString())).ToString();

                        chkActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        chkActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvFiniceJobs_RowDataBound", "", ex.Message);
            }
        }

        protected void btnAddMilestone_Click(object sender, EventArgs e)
        {
            try
            {
                int ProjectId = DataUtils.GetInt(hfProjectId.Value);

                if (btnAddMilestone.Text.ToLower() == "update")
                {
                    int EnterFinancialJobsID = DataUtils.GetInt(hfEnterFinancialJobsID.Value);
                    EnterpriseFundamentalsData.UpdateEnterpriseFinancialJobs(EnterFinancialJobsID,
                        DataUtils.GetInt(ddlMilestone.SelectedValue.ToString()), DataUtils.GetDate(txtMSDate.Text),
                        "", //txtYear.Text, 
                        DataUtils.GetDecimal(txtGrossSales.Text.Replace("$", "")),
                        DataUtils.GetDecimal(txtNetIncome.Text.Replace("$", "")),
                        DataUtils.GetDecimal(txtGrossPayroll.Text.Replace("$", "")),
                        DataUtils.GetDecimal(txtFamilyFTEmp.Text), 
                        DataUtils.GetDecimal(txtNonFamilyFTEmp.Text),
                        DataUtils.GetDecimal(txtNetworth.Text.Replace("$", "")), 
                        DataUtils.GetDecimal(txtAccessFTE.Text),
                        chkActive.Checked);

                    gvFiniceJobs.EditIndex = -1;

                    LogMessage("Finalcial Job updated successfully");
                }
                else //add
                {
                    ViabilityMaintResult objViabilityMaintResult = EnterpriseFundamentalsData.AddEnterpriseFinancialJobs(ProjectId,
                        DataUtils.GetInt(ddlMilestone.SelectedValue.ToString()), DataUtils.GetDate(txtMSDate.Text),
                        "",//txtYear.Text, 
                        DataUtils.GetDecimal(txtGrossSales.Text.Replace("$", "")),
                        DataUtils.GetDecimal(txtNetIncome.Text.Replace("$", "")),
                        DataUtils.GetDecimal(txtGrossPayroll.Text.Replace("$", "")),
                        DataUtils.GetDecimal(txtFamilyFTEmp.Text), 
                        DataUtils.GetDecimal(txtNonFamilyFTEmp.Text),
                        DataUtils.GetDecimal(txtNetworth.Text.Replace("$", "")), 
                        DataUtils.GetDecimal(txtAccessFTE.Text));


                    if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                        LogMessage("Financial Job already exist as in-active");
                    else if (objViabilityMaintResult.IsDuplicate)
                        LogMessage("Financial Job already exist");
                    else
                        LogMessage("Financial Job added successfully");
                }
                ClearFinJobsForm();
                BindFinJobsGrid();
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddMilestone_Click", "", ex.Message);
            }
        }

        private void ClearFinJobsForm()
        {
            btnAddMilestone.Text = "Add";
            cbAddMilestone.Checked = false;
            ddlMilestone.SelectedIndex = -1;
            txtMSDate.Text = "";
            //txtYear.Text = "";
            txtGrossSales.Text = "";
            txtNetIncome.Text = "";
            txtGrossPayroll.Text = "";
            txtNetworth.Text = "";
            txtFamilyFTEmp.Text = "";
            txtNonFamilyFTEmp.Text = "";
            txtAccessFTE.Text = "";
            chkActive.Enabled = false;
            spnTotalFulltime.InnerHtml = "";
        }

        private void BindFinJobsGrid()
        {
            try
            {
                DataTable dt = EnterpriseFundamentalsData.GetEnterpriseFinancialJobsList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvFiniceJobsGrid.Visible = true;
                    gvFiniceJobs.DataSource = dt;
                    gvFiniceJobs.DataBind();
                }
                else
                {
                    dvFiniceJobsGrid.Visible = false;
                    gvFiniceJobs.DataSource = null;
                    gvFiniceJobs.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindFinJobsGrid", "", ex.Message);
            }
        }
    }
}