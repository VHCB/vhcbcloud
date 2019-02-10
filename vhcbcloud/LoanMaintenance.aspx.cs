using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class LoanMaintenance : System.Web.UI.Page
    {
        string Pagename = "LoanMaintenance";

        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtProjectNumDDL, "OnBlur");
            txtProjectNumDDL.Attributes.Add("onblur", onBlurScript);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);

            if (!IsPostBack)
            {
                BindControls();
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
        private void BindControls()
        {
            BindLookUP(ddlLoanCat, 179);
            BindLookUP(ddlCompounded, 190);
            BindLookUP(ddlPaymentFreq, 191);
            BindLookUP(ddlPaymentType, 192);
            BindLookUP(ddlTransType, 178);
            BindLookUP(ddlLegalDocs, 268);
            BindLookUP(ad_ddlTransCompounding, 190);
            BindLookUP(ad_ddlTransPaymentFreq, 191);
            BindLookUP(ad_ddlTransPaymentType, 192);

            BindLookUP(nm_ddlTransCompounding, 190);
            BindLookUP(nm_ddlTransPaymentFreq, 191);
            BindLookUP(nm_ddlTransPaymentType, 192);

            //BindLookUP(cap_ddlTransPaymentType, 192);
            //BindLookUP(cr_ddlTransPaymentType, 192);

            //BindLookUP(cv_ddlTransCompounding, 190);
            //BindLookUP(cv_ddlTransPaymentFreq, 191);
            //BindLookUP(cv_ddlTransPaymentType, 192);
            BindTaxCreditPartner();
            BindNoteOwner();
            //BindFund(ddlFund);
            BindFundType(ddlFund);
            //BindFund(ddlNotesFund);
        }

        private void BindPrimaryApplicants()
        {
            try
            {
                ddlPrimaryApplicant.Items.Clear();
                ddlPrimaryApplicant.DataSource = ProjectCheckRequestData.GetProjectApplicant(DataUtils.GetInt(hfProjectId.Value));
                    //ApplicantData.GetSortedApplicants();
                ddlPrimaryApplicant.DataValueField = "ApplicantId";
                ddlPrimaryApplicant.DataTextField = "Applicantname";
                ddlPrimaryApplicant.DataBind();
                ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
            }
        }

        private void BindNoteOwner()
        {
            try
            {
                ddlNoteOwner.Items.Clear();
                ddlNoteOwner.DataSource = LoanMaintenanceData.GetAllEntities();
                ddlNoteOwner.DataValueField = "ApplicantId";
                ddlNoteOwner.DataTextField = "Applicantname";
                ddlNoteOwner.DataBind();
                ddlNoteOwner.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindNoteOwner", "", ex.Message);
            }
        }

        private void BindTaxCreditPartner()
        {
            try
            {
                ddltaxCreditPartner.Items.Clear();
                ddltaxCreditPartner.DataSource = LoanMaintenanceData.GetAllEntities();
                ddltaxCreditPartner.DataValueField = "ApplicantId";
                ddltaxCreditPartner.DataTextField = "Applicantname";
                ddltaxCreditPartner.DataBind();
                ddltaxCreditPartner.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindTaxCreditPartner", "", ex.Message);
            }
        }

        private void BindFund(DropDownList ddList)
        {
            try
            {
                ddList.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
                ddList.DataValueField = "fundid";
                ddList.DataTextField = "name";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
            }
        }

        private void BindFundType(DropDownList ddList)
        {
            try
            {
                ddList.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFundTypes");
                ddList.DataValueField = "TypeId";
                ddList.DataTextField = "FundType";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
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

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtProjectNumDDL.UniqueID && args == "OnBlur")
            {
                ProjectSelectionChanged();
            }
        }

        private void ProjectSelectionChanged()
        {
            ClearLoanMasterForm();
            hfProjectId.Value = "";
            txtProjName.InnerHtml = "";

            dvNewProjectInfo.Visible = false;
            dvNewLoanDetailInfo.Visible = false;
            dvNewEvent.Visible = false;
            dvTransaction.Visible = false;
            dvNotes.Visible = false;
            cbAddLoanMaster.Checked = false;

            if (txtProjectNumDDL.Text != "")
            {
                //dvDetails.Visible = true;
                lblProjName.Visible = true;
                txtProjName.Visible = true;
                hfProjectId.Value = GetProjectID(txtProjectNumDDL.Text).ToString();
                DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
                txtProjName.InnerText = dr["ProjectName"].ToString();
                dvNewProjectInfo.Visible = true;
                BindProjectLoanMasterGrid();
                BindPrimaryApplicants();
                BindRelatedProjectsGrid();
                DataRow drPrimaryApplicant = ProjectMaintenanceData.GetPrimaryApplicantbyProjectId(DataUtils.GetInt(hfProjectId.Value));

                if (drPrimaryApplicant != null)
                    PopulateDropDown(ddlPrimaryApplicant, drPrimaryApplicant["ApplicantId"].ToString());
            }
            else
            {
                //dvDetails.Visible = false;
                lblProjName.Visible = false;
                txtProjName.Visible = false;
            }
        }

        private void BindRelatedProjectsGrid()
        {
            try
            {
                DataTable dtRelatedProjects = ProjectMaintenanceData.GetRelatedProjectList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtRelatedProjects.Rows.Count > 0)
                {
                    dvNewRelatedProjects.Visible = true;
                    dvRelatedProjectsGrid.Visible = true;
                    gvRelatedProjects.DataSource = dtRelatedProjects;
                    gvRelatedProjects.DataBind();
                }
                else
                {
                    dvNewRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = false;
                    gvRelatedProjects.DataSource = null;
                    gvRelatedProjects.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindRelatedProjectsGrid", "", ex.Message);
            }
        }

        private void ClearLoanMasterForm()
        {
            spnLoanId.InnerText = "";
            ddltaxCreditPartner.SelectedIndex = -1;
            ddlNoteOwner.SelectedIndex = -1;
            txtNoteAmount.Text = "";
            txtBalanceForward.Text = "";
            ddlPrimaryApplicant.SelectedIndex = -1;
            //txtPrimaryApplicant.Text = "";
            cbLoanMasterActive.Checked = true;
            cbLoanMasterActive.Enabled = false;
        }

        private void BindProjectInfoForm(int ProjectId)
        {
            //hfLoanId.Value = "";
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(ProjectId);
            txtProjName.InnerText = dr["ProjectName"].ToString();
            btnLoanMaster.Text = "Add";

            DataRow drLoanMasterDetails = LoanMaintenanceData.GetProjectLoanMasterDetails(ProjectId);
            if (drLoanMasterDetails != null)
            {
                //hfLoanId.Value = drLoanMasterDetails["LoanID"].ToString();
                //txtDescriptor.Text = drLoanMasterDetails["Descriptor"].ToString();
                PopulateDropDown(ddltaxCreditPartner, drLoanMasterDetails["TaxCreditPartner"].ToString());
                PopulateDropDown(ddlNoteOwner, drLoanMasterDetails["NoteOwner"].ToString());
                //txtTaxCreditPartner.Text = drLoanMasterDetails["TaxCreditPartner"].ToString();
                //txtNoteOwner.Text = drLoanMasterDetails["NoteOwner"].ToString();
                //txtPrimaryApplicant.Text = drLoanMasterDetails["ApplicantID"].ToString();
                PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
                //PopulateDropDown(ddlFund, drLoanMasterDetails["FundID"].ToString());
                btnLoanMaster.Text = "Update";
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
        private int GetProjectID(string ProjectNum)
        {
            return ProjectMaintenanceData.GetProjectId(ProjectNum);
        }
        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindProjectLoanMasterGrid();
        }

        protected void btnLoanUpdate_Click(object sender, EventArgs e)
        {

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

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbers(prefixText);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }
        
        private bool AddLoanTransactions(int LoanId, int TransType, DateTime? TransDate, decimal? IntRate,
            int? Compound, int? Freq, int? PayType, DateTime? MatDate, DateTime? StartDate, decimal? Amount, DateTime? StopDate,
            decimal? Principal, decimal? Interest, string Description, int? TransferTo, int? ConvertFrom, 
            DateTime? EffectiveDate)
        {
            DateTime TransDate1 = TransDate ?? DateTime.MinValue;
            DateTime MatDate1 = MatDate ?? DateTime.MinValue;
            DateTime StartDate1 = StartDate ?? DateTime.MinValue;
            DateTime StopDate1 = StopDate ?? DateTime.MinValue;
            DateTime EffectiveDate1 = EffectiveDate ?? DateTime.MinValue;

            LoanMaintenanceData.AddLoanTransactions(LoanId, TransType, TransDate1, IntRate, Compound, Freq, PayType, MatDate1, StartDate1,
                Amount, StopDate1, Principal, Interest, Description, TransferTo, ConvertFrom, EffectiveDate1);

            return true;
        }

        private bool UpdateLoanTransactions(int LoanTransId, int TransType, DateTime? TransDate, decimal? IntRate,
            int? Compound, int? Freq, int? PayType, DateTime? MatDate, DateTime? StartDate, decimal? Amount, DateTime? StopDate,
            decimal? Principal, decimal? Interest, string Description, int? TransferTo, int? ConvertFrom,
            DateTime? EffectiveDate, bool RowIsActive)
        {
            DateTime TransDate1 = TransDate ?? DateTime.MinValue;
            DateTime MatDate1 = MatDate ?? DateTime.MinValue;
            DateTime StartDate1 = StartDate ?? DateTime.MinValue;
            DateTime StopDate1 = StopDate ?? DateTime.MinValue;
            DateTime EffectiveDate1 = EffectiveDate ?? DateTime.MinValue;

            LoanMaintenanceData.UpdateLoanTransactions(LoanTransId, TransType, TransDate1, IntRate, Compound, Freq, PayType, MatDate1, StartDate1,
                Amount, StopDate1, Principal, Interest, Description, TransferTo, ConvertFrom, EffectiveDate1, RowIsActive);

            return true;
        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {
            try
            {
                LoanResult objLoanResult = LoanMaintenanceData.AddLoanEvent(DataUtils.GetInt(hfLoanId.Value), txtEventDescription.Text);

                if (objLoanResult.IsDuplicate && !objLoanResult.IsActive)
                    LogMessage("Loan Event already exist as in-active");
                else if (objLoanResult.IsDuplicate)
                    LogMessage("Loan Event already exist");
                else
                    LogMessage("New Loan Event added successfully");

                BindLoanEventsGrid();
                txtEventDescription.Text = "";
                cbAddEvent.Checked = false;
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        protected void btnLoanMaster_Click(object sender, EventArgs e)
        {
            if (DataUtils.GetDecimal(Regex.Replace(txtNoteAmount.Text, "[^0-9a-zA-Z.]+", "")) == 0)
            {
                LogMessage("Enter Note Amount");
                txtNoteAmount.Focus();
                return;
            }

            if (btnLoanMaster.Text == "Add")
            {
                LoanMaintenanceData.AddLoanMaster(DataUtils.GetInt(hfProjectId.Value), 
                    DataUtils.GetInt(ddltaxCreditPartner.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlNoteOwner.SelectedValue.ToString()),
                    DataUtils.GetDecimal(Regex.Replace(txtNoteAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtBalanceForward.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()));
            }
            else
            {
                LoanMaintenanceData.UpdateLoanMaster(DataUtils.GetInt(hfLoanId.Value),
                    DataUtils.GetInt(ddltaxCreditPartner.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlNoteOwner.SelectedValue.ToString()),
                    DataUtils.GetDecimal(Regex.Replace(txtNoteAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtBalanceForward.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()), cbLoanMasterActive.Checked);

                LogMessage("Loan Master updated successfully");

                hfLoanId.Value = "";
                btnLoanMaster.Text = "Add";
                cbAddLoanMaster.Checked = false;
                gvLoanMaster.EditIndex = -1;
            }
            ClearLoanMasterForm();
            BindProjectLoanMasterGrid();
        }
        private void BindLoanMasterDetailsGrid()
        {
            try
            {
                DataTable dtLoanDetails = LoanMaintenanceData.GetLoanDetailListByLoanId(DataUtils.GetInt(hfLoanId.Value), cbActiveOnly.Checked);

                if (dtLoanDetails.Rows.Count > 0)
                {
                    dvProjectLoanDetailsGrid.Visible = true;
                    gvProjectLoanDetails.DataSource = dtLoanDetails;
                    gvProjectLoanDetails.DataBind();
                }
                else
                {
                    dvProjectLoanDetailsGrid.Visible = false;
                    gvProjectLoanDetails.DataSource = null;
                    gvProjectLoanDetails.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectLoanDetailsGrid", "", ex.Message);
            }
        }

        protected void gvProjectLoanDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbAddNewLoanDetails.Checked = false;
            ClearLoanDetailsForm();
            btnAddLoanDetails.Text = "Add";
            gvProjectLoanDetails.EditIndex = -1;
            BindLoanMasterDetailsGrid();
        }

        private void ClearLoanDetailsForm()
        {
            ddlLoanCat.SelectedIndex = -1;
            txtOriginalDateOfNote.Text = "";
            txtMaturityDate.Text = "";
            txtIntrestRate.Text = "";
            ddlCompounded.SelectedIndex = -1;
            ddlPaymentFreq.SelectedIndex = -1;
            ddlPaymentType.SelectedIndex = -1;
            txtWatchDate.Text = "";
            cbLoanDetailActive.Checked = true;
            cbLoanDetailActive.Enabled = false;
            ddlLegalDocs.SelectedIndex = -1;
            txtFileURL.Text = "";
            txtEffectiveDate.Text = "";
        }

        protected void gvProjectLoanDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string URL = "";
                    HtmlAnchor anchorDocument = e.Row.FindControl("hlurl") as HtmlAnchor;
                    string DocumentId = anchorDocument.InnerHtml;

                    if (CommonHelper.IsVPNConnected() && DocumentId != "")
                    {
                        URL = "fda://document/" + DocumentId;
                        anchorDocument.InnerHtml = "Click";
                        anchorDocument.HRef = URL;
                    }
                    else if (DocumentId != "")
                    {
                        URL = "http://581720-APP1/FH/FileHold/WebClient/LibraryForm.aspx?docId=" + DocumentId;
                        anchorDocument.InnerHtml = "Click";
                        anchorDocument.HRef = URL;
                    }
                    else
                    {
                        anchorDocument.InnerHtml = "";
                    }
                        
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddLoanDetails.Text = "Update";
                    btnAddLoanDetails.Visible = true;
                    cbAddNewLoanDetails.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[9].Controls[0].Visible = false;

                        Label lblLoanDetailID = e.Row.FindControl("lblLoanDetailID") as Label;
                        DataRow dr = LoanMaintenanceData.GetLoanDetailsByLoanDetailId(Convert.ToInt32(lblLoanDetailID.Text));

                        hfLoanDetailID.Value = lblLoanDetailID.Text;
                        //Populate Edit Form

                        PopulateDropDown(ddlLoanCat, dr["LoanCat"].ToString());

                        txtOriginalDateOfNote.Text = dr["NoteDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["NoteDate"].ToString()).ToShortDateString();
                        txtMaturityDate.Text = dr["MaturityDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MaturityDate"].ToString()).ToShortDateString();
                        txtIntrestRate.Text = dr["IntRate"].ToString();
                        PopulateDropDown(ddlCompounded, dr["Compound"].ToString());
                        PopulateDropDown(ddlPaymentFreq, dr["Frequency"].ToString());
                        PopulateDropDown(ddlPaymentType, dr["PaymentType"].ToString());
                        PopulateDropDown(ddlLegalDocs, dr["LegalDoc"].ToString());
                        txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();
                        txtFileURL.Text = dr["URL"].ToString();
                        txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                        txtBoardApprovalDate.Text = dr["BoardApproveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["BoardApproveDate"].ToString()).ToShortDateString();
                        cbLoanDetailActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
                        cbLoanDetailActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAddress_RowDataBound", "", ex.Message);
            }
        }

        protected void gvProjectLoanDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectLoanDetails.EditIndex = e.NewEditIndex;
            BindLoanMasterDetailsGrid();
        }

        protected void btnAddLoanDetails_Click(object sender, EventArgs e)
        {
            if (IsLoanDetailFormValid())
            {
                string URL = txtFileURL.Text;

                if(URL != "")
                    URL = URL.Split('/').Last();

                if (btnAddLoanDetails.Text == "Add")
                {
                    LoanMaintenanceData.AddLoanDetail(DataUtils.GetInt(hfLoanId.Value),
                        DataUtils.GetInt(ddlLegalDocs.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlLoanCat.SelectedValue.ToString()),
                        DataUtils.GetDate(txtOriginalDateOfNote.Text), DataUtils.GetDate(txtMaturityDate.Text),
                        DataUtils.GetDecimal(txtIntrestRate.Text),
                        DataUtils.GetInt(ddlCompounded.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentFreq.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentType.SelectedValue.ToString()),
                        DataUtils.GetDate(txtWatchDate.Text),
                        URL, DataUtils.GetDate(txtEffectiveDate.Text), 
                        DataUtils.GetDate(txtBoardApprovalDate.Text));
                    LogMessage("Loan details added successfully");
                }
                else
                {
                    LoanMaintenanceData.UpdateLoanDetail(DataUtils.GetInt(hfLoanDetailID.Value),
                        DataUtils.GetInt(ddlLegalDocs.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlLoanCat.SelectedValue.ToString()),
                        DataUtils.GetDate(txtOriginalDateOfNote.Text), DataUtils.GetDate(txtMaturityDate.Text),
                        DataUtils.GetDecimal(txtIntrestRate.Text),
                        DataUtils.GetInt(ddlCompounded.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentFreq.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentType.SelectedValue.ToString()),
                        DataUtils.GetDate(txtWatchDate.Text),
                        URL, DataUtils.GetDate(txtEffectiveDate.Text),
                        DataUtils.GetDate(txtBoardApprovalDate.Text),
                        cbLoanDetailActive.Checked);

                    LogMessage("Loan details updated successfully");
                    hfLoanDetailID.Value = "";
                    btnAddLoanDetails.Text = "Add";
                    gvProjectLoanDetails.EditIndex = -1;
                }
                cbAddNewLoanDetails.Checked = false;
                ClearLoanDetailsForm();
                BindLoanMasterDetailsGrid();
            }
        }

        protected bool IsLoanDetailFormValid()
        {
            if (ddlLegalDocs.SelectedIndex == 0)
            {
                LogMessage("Select Legal Docs");
                ddlLegalDocs.Focus();
                return false;
            }
            else if (txtBoardApprovalDate.Text.Trim() == "")
            {
                if (!DataUtils.IsDateTime(txtBoardApprovalDate.Text.Trim()))
                {
                    LogMessage("Enter valid Board Approval Date");
                    txtBoardApprovalDate.Focus();
                    return false;
                }
            }
            //else if (txtOriginalDateOfNote.Text.Trim() == "")
            //{
            //    if (!DataUtils.IsDateTime(txtOriginalDateOfNote.Text.Trim()))
            //    {
            //        LogMessage("Enter valid Original Date of Note");
            //        txtOriginalDateOfNote.Focus();
            //        return false;
            //    }
            //}
            //if (txtMaturityDate.Text.Trim() == "")
            //{
            //    if (!DataUtils.IsDateTime(txtMaturityDate.Text.Trim()))
            //    {
            //        LogMessage("Enter valid Final Maturity Date of Note");
            //        txtMaturityDate.Focus();
            //        return false;
            //    }
            //}
            return true;
        }

        private void BindProjectLoanMasterGrid()
        {
            dvNewLoanDetailInfo.Visible = false;
            dvNewEvent.Visible = false;
            dvTransaction.Visible = false;
            dvNotes.Visible = false;
            dvNewFundInfo.Visible = false;

            try
            {
                DataTable dtLoanMasterDetails = LoanMaintenanceData.GetLoanMasterListByProject(DataUtils.GetInt(hfProjectId.Value),
                    cbActiveOnly.Checked);

                if (dtLoanMasterDetails.Rows.Count > 0)
                {
                    dvLoanMasterGrid.Visible = true;
                    gvLoanMaster.DataSource = dtLoanMasterDetails;
                    gvLoanMaster.DataBind();
                }
                else
                {
                    dvLoanMasterGrid.Visible = false;
                    gvLoanMaster.DataSource = null;
                    gvLoanMaster.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectLoanDetailsGrid", "", ex.Message);
            }
        }

        protected void gvLoanMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnLoanMaster.Text = "Update";
                    cbAddLoanMaster.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblLoanID = e.Row.FindControl("lblLoanID") as Label;
                        DataRow drLoanMasterDetails = LoanMaintenanceData.GetLoanMasterDetailsByLoanID(Convert.ToInt32(lblLoanID.Text));

                        hfLoanId.Value = lblLoanID.Text;
                        spnLoanId.InnerText = lblLoanID.Text;
                        //txtDescriptor.Text = drLoanMasterDetails["Descriptor"].ToString();
                        PopulateDropDown(ddltaxCreditPartner, drLoanMasterDetails["TaxCreditPartner"].ToString());
                        PopulateDropDown(ddlNoteOwner, drLoanMasterDetails["NoteOwner"].ToString());
                        txtNoteAmount.Text = drLoanMasterDetails["NoteAmt"].ToString();
                        txtBalanceForward.Text = drLoanMasterDetails["BalForward"].ToString();

                        //txtPrimaryApplicant.Text = drLoanMasterDetails["Applicantname"].ToString();
                        PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
                        //PopulateDropDown(ddlFund, drLoanMasterDetails["FundID"].ToString());
                        btnLoanMaster.Text = "Update";

                        cbLoanMasterActive.Checked = DataUtils.GetBool(drLoanMasterDetails["RowIsActive"].ToString()); ;
                        cbLoanMasterActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvLoanMaster_RowDataBound", "", ex.Message);
            }
        }

        protected void gvLoanMaster_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbAddLoanMaster.Checked = false;
            ClearLoanMasterForm();
            btnLoanMaster.Text = "Add";
            gvLoanMaster.EditIndex = -1;
            BindProjectLoanMasterGrid();
        }

        protected void gvLoanMaster_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLoanMaster.EditIndex = e.NewEditIndex;
            BindProjectLoanMasterGrid();
        }

        protected void gvLoanMaster_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void rdBtnSelectLoan_CheckedChanged(object sender, EventArgs e)
        {
            SelectedLoanMasterInfo objSelectedLoanMasterInfo = GetLoanMasterSelectedRecordID(gvLoanMaster);

            hfLoanId.Value = objSelectedLoanMasterInfo.LoanID.ToString();
            spnNoteAmt.InnerText = objSelectedLoanMasterInfo.NoteAmt.ToString();
            hfSelectedNoteAmt.Value = objSelectedLoanMasterInfo.NoteAmt.ToString();

            dvNewLoanDetailInfo.Visible = true;
            dvNewEvent.Visible = true;
            dvTransaction.Visible = true;
            dvNotes.Visible = true;
            dvNewFundInfo.Visible = true;

            ibLoanSummary.Visible = true;

            BindLoanMasterDetailsGrid();
            BindLoanEventsGrid();
            BindLoanNotesGrid();
            BindLoanTransGrid();
            BindFundDetailsGrid();
        }

        private SelectedLoanMasterInfo GetLoanMasterSelectedRecordID(GridView gvBldgInfo)
        {
            SelectedLoanMasterInfo objSelectedLoanMasterInfo = new SelectedLoanMasterInfo();

            for (int i = 0; i < gvBldgInfo.Rows.Count; i++)
            {
                RadioButton rbLoanMasterInfo = (RadioButton)gvBldgInfo.Rows[i].Cells[0].FindControl("rdBtnSelectLoan");
                if (rbLoanMasterInfo != null)
                {
                    if (rbLoanMasterInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvBldgInfo.Rows[i].Cells[0].FindControl("HiddenLoanID");
                        Label lblNoteAmt = (Label)gvBldgInfo.Rows[i].Cells[1].FindControl("lblNoteAmt");

                        if (hf != null)
                        {
                            objSelectedLoanMasterInfo.LoanID = DataUtils.GetInt(hf.Value);
                            objSelectedLoanMasterInfo.NoteAmt = lblNoteAmt.Text;
                        }
                        break;
                    }
                }
            }
            return objSelectedLoanMasterInfo;
        }

        public class SelectedLoanMasterInfo
        {
            public int LoanID { set; get; }
            public string NoteAmt { set; get; }
        }

        private void BindLoanEventsGrid()
        {
            try
            {
                DataTable dtLoanEvents = LoanMaintenanceData.GetLoanEventsListByLoanID(DataUtils.GetInt(hfLoanId.Value),
                    cbActiveOnly.Checked);

                if (dtLoanEvents.Rows.Count > 0)
                {
                    dvLoanEventsGrid.Visible = true;
                    gvLoanEvents.DataSource = dtLoanEvents;
                    gvLoanEvents.DataBind();
                }
                else
                {
                    dvLoanEventsGrid.Visible = false;
                    gvLoanEvents.DataSource = null;
                    gvLoanEvents.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLoanEvents", "", ex.Message);
            }
        }

        protected void gvLoanEvents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLoanEvents.EditIndex = e.NewEditIndex;
            BindLoanEventsGrid();
        }

        protected void gvLoanEvents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string Description = ((TextBox)gvLoanEvents.Rows[rowIndex].FindControl("txtDescription")).Text;
            int LoanEventID = DataUtils.GetInt(((Label)gvLoanEvents.Rows[rowIndex].FindControl("lblLoanEventID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvLoanEvents.Rows[rowIndex].FindControl("chkActiveEditEvent")).Checked); ;

            LoanMaintenanceData.UpdateLoanEvent(LoanEventID, Description, RowIsActive);
            gvLoanEvents.EditIndex = -1;

            BindLoanEventsGrid();
            LogMessage("Loan event updated successfully");
        }

        protected void gvLoanEvents_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkActiveEditEvent = e.Row.FindControl("chkActiveEditEvent") as CheckBox;
                        chkActiveEditEvent.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvLoanEvents_RowDataBound", "", ex.Message);
            }
        }

        protected void gvLoanEvents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLoanEvents.EditIndex = -1;
            BindLoanEventsGrid();
        }

        private void BindLoanNotesGrid()
        {
            try
            {
                DataTable dtLoanNotes = LoanMaintenanceData.GetLoanNotesListByLoanID(DataUtils.GetInt(hfLoanId.Value),
                    cbActiveOnly.Checked);

                if (dtLoanNotes.Rows.Count > 0)
                {
                    dvProjectLoanNotesGrid.Visible = true;
                    gvProjectLoanNotes.DataSource = dtLoanNotes;
                    gvProjectLoanNotes.DataBind();
                }
                else
                {
                    dvProjectLoanNotesGrid.Visible = false;
                    gvProjectLoanNotes.DataSource = null;
                    gvProjectLoanNotes.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLoanEvents", "", ex.Message);
            }
        }

        protected void gvProjectLoanNotes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbAddNotes.Checked = false;
            txtFHL.Text = "";
            txtNotes.Text = "";
            btnAddNotes.Text = "Add";
            gvProjectLoanNotes.EditIndex = -1;
            BindLoanNotesGrid();
            cbLoanNoteActive.Checked = true;
            cbLoanNoteActive.Enabled = false;
        }

        protected void gvProjectLoanNotes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string URL = "";
                    HtmlAnchor anchorDocument = e.Row.FindControl("hlurl") as HtmlAnchor;
                    string DocumentId = anchorDocument.InnerHtml;

                    if (CommonHelper.IsVPNConnected() && DocumentId != "")
                    {
                        URL = "fda://document/" + DocumentId;
                        anchorDocument.InnerHtml = "Click";
                        anchorDocument.HRef = URL;
                    }
                    else if (DocumentId != "")
                    {
                        URL = "http://581720-APP1/FH/FileHold/WebClient/LibraryForm.aspx?docId=" + DocumentId;
                        anchorDocument.InnerHtml = "Click";
                        anchorDocument.HRef = URL;
                    }
                    else
                    {
                        anchorDocument.InnerHtml = "";
                    }
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddNotes.Text = "Update";
                    cbAddNotes.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[4].Controls[0].Visible = false;
                        Label lblLoanNoteID = e.Row.FindControl("lblLoanNoteID") as Label;
                        DataRow dr = LoanMaintenanceData.GetLoanNotesByLoanID(Convert.ToInt32(lblLoanNoteID.Text));

                        hfLoanNoteID.Value = lblLoanNoteID.Text;
                        //Populate Edit Form

                        //PopulateDropDown(ddlLoanCat, dr["LoanCat"].ToString());

                        txtNotes.Text = dr["LoanNote"].ToString();
                        txtFHL.Text = dr["FHLink"].ToString();

                        cbLoanNoteActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
                        cbLoanNoteActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectLoanNotes_RowDataBound", "", ex.Message);
            }
        }

        protected void gvProjectLoanNotes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectLoanNotes.EditIndex = e.NewEditIndex;
            BindLoanNotesGrid();
        }

        protected void btnAddNotes_Click(object sender, EventArgs e)
        {
            string URL = txtFHL.Text;

            if (URL != "")
                URL = URL.Split('/').Last();

            if (btnAddNotes.Text == "Add")
            {
                LoanMaintenanceData.AddLoanNotes(DataUtils.GetInt(hfLoanId.Value), txtNotes.Text, URL);
                LogMessage("Loan Notes added successfully");
            }
            else
            {
                LoanMaintenanceData.UpdateLoanNotes(DataUtils.GetInt(hfLoanNoteID.Value), txtNotes.Text, URL,
                    cbLoanNoteActive.Checked);
                LogMessage("Loan Notes updated successfully");
                hfLoanNoteID.Value = "";
                btnAddNotes.Text = "Add";
                gvProjectLoanNotes.EditIndex = -1;
            }
            cbAddNotes.Checked = false;
            txtNotes.Text = "";
            txtFHL.Text = "";
            cbLoanNoteActive.Checked = true;
            cbLoanNoteActive.Enabled = false;
            BindLoanNotesGrid();
        }

        private void BindLoanTransGrid()
        {
            try
            {
                DataTable dtTrans = LoanMaintenanceData.GetLoanTransactionsList(DataUtils.GetInt(hfLoanId.Value),
                    cbActiveOnly.Checked);

                if (dtTrans.Rows.Count > 0)
                {
                    dvLoanTransGrid.Visible = true;
                    gvLoanTrans.DataSource = dtTrans;
                    gvLoanTrans.DataBind();
                }
                else
                {
                    dvLoanTransGrid.Visible = false;
                    gvLoanTrans.DataSource = null;
                    gvLoanTrans.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLoanTransGrid", "", ex.Message);
            }
        }

        protected void gvLoanTrans_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbAddTransaction.Checked = false;
            gvLoanTrans.EditIndex = -1;
            BindLoanTransGrid();
            ClearLoanTransForm();
            //cbLoanNoteActive.Checked = true;
            //cbLoanNoteActive.Enabled = false;
        }

        private void ClearLoanTransForm()
        {
            ddlTransType.SelectedIndex = -1;
            TransactionTypeChanged();

            //Capitalizing
            cap_txtTransDate.Text = "";
            //cap_ddlTransPaymentType.SelectedIndex = -1;
            cap_txtTransAmount.Text = "";
            //cap_txtTransPrinciple.Text = "";
            cap_txtTransDescription.Text = "";
        }

        protected void gvLoanTrans_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    //btnAddNotes.Text = "Update";
                    cbAddTransaction.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[8].Controls[0].Visible = false;
                        Label lblLoanTransID = e.Row.FindControl("lblLoanTransID") as Label;
                        DataRow dr = LoanMaintenanceData.GetLoanTransByLoanID(Convert.ToInt32(lblLoanTransID.Text));

                        hfLoanTransID.Value = lblLoanTransID.Text;
                        //Populate Edit Form
                        PopulateLoanTransEditForm(dr);
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectLoanNotes_RowDataBound", "", ex.Message);
            }
        }

        private void PopulateLoanTransEditForm(DataRow dr)
        {
            PopulateDropDown(ddlTransType, dr["TransType"].ToString());
            TransactionTypeChanged();
            btnAddTransaction.Text = "Update";

            if (ddlTransType.SelectedIndex != 0)
            {
                switch (ddlTransType.SelectedItem.ToString().ToLower())
                {
                    case "capitalizing":
                        PopulateCapitalizingForm(dr);
                        break;
                    case "adjustment":
                        PopulateAdjustmentForm(dr);
                        break;
                    case "cash receipt":
                        PopulateCashReceiptForm(dr);
                        break;
                    case "conversion":
                        PopulateConversionForm(dr);
                        break;
                    case "disbursement":
                        PopulateDisbursementForm(dr);
                        break;
                    case "forgiveness":
                        PopulateForgivenessForm(dr);
                        break;
                    case "note modification":
                        PopulateNoteModificationForm(dr);
                        break;
                    case "transfer":
                        PopulateTransferForm(dr);
                        break;
                }
            }
        }

        private void PopulateTransferForm(DataRow dr)
        {
            tr_txtTransDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            tr_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            tr_txtTransAmount.Text = dr["Amount"].ToString();
            tr_txtTransDescription.Text = dr["Description"].ToString();
            tr_txtTransProjTransfered.Text = dr["TransferTo"].ToString();
            tr_txtTransProjConverted.Text = dr["ConvertFrom"].ToString();

            tr_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            tr_cbLoanTransActive.Enabled = true;
        }

        private void PopulateNoteModificationForm(DataRow dr)
        {
            nm_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            PopulateDropDown(nm_ddlTransCompounding, dr["Compound"].ToString());
            PopulateDropDown(nm_ddlTransPaymentType, dr["PayType"].ToString());
            PopulateDropDown(nm_ddlTransPaymentFreq, dr["Freq"].ToString());

            nm_txtTransIntrestRate.Text = dr["IntRate"].ToString();
            nm_txtTransMaturityDate.Text = dr["MatDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MatDate"].ToString()).ToShortDateString();
            nm_txtTransStartDate.Text = dr["StartDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StartDate"].ToString()).ToShortDateString();
            nm_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            nm_txtTransIntrest.Text = dr["Interest"].ToString();
            nm_txtTransAmount.Text = dr["Amount"].ToString();
            nm_txtTransStopDate.Text = dr["StopDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StopDate"].ToString()).ToShortDateString();
            nm_txtTransDescription.Text = dr["Description"].ToString();

            nm_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            nm_cbLoanTransActive.Enabled = true;
        }

        private void PopulateForgivenessForm(DataRow dr)
        {
            //fg_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            //fg_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            fg_txtTransAmount.Text = dr["Amount"].ToString();
            fg_txtTransDescription.Text = dr["Description"].ToString();
            fg_txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            fg_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            fg_cbLoanTransActive.Enabled = true;
        }

        private void PopulateDisbursementForm(DataRow dr)
        {
            //dis_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            dis_txtTransAmount.Text = dr["Amount"].ToString();
            dis_txtTransDescription.Text = dr["Description"].ToString();
            dis_txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            dis_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            dis_cbLoanTransActive.Enabled = true;
        }

        private void PopulateConversionForm(DataRow dr)
        {
            cv_txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            cv_txtTransAmount.Text = dr["Amount"].ToString();
            cv_txtTransDescription.Text = dr["Description"].ToString();

            //cv_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            //cv_txtTransIntrestRate.Text = dr["IntRate"].ToString(); ;
            //PopulateDropDown(cv_ddlTransCompounding, dr["Compound"].ToString());
            //PopulateDropDown(cv_ddlTransPaymentType, dr["PayType"].ToString());
            //PopulateDropDown(cv_ddlTransPaymentFreq, dr["Freq"].ToString());
            //cv_txtTransStartDate.Text = dr["StartDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StartDate"].ToString()).ToShortDateString();

            //cv_txtTransStopDate.Text = dr["StopDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StopDate"].ToString()).ToShortDateString();
            //cv_txtTransPrinciple.Text = dr["Principal"].ToString();
            //cv_txtTransIntrest.Text = dr["Interest"].ToString();

            //cv_txtTransProjConverted.Text = dr["ConvertFrom"].ToString();
            cv_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            cv_cbLoanTransActive.Enabled = true;
        }

        private void PopulateCashReceiptForm(DataRow dr)
        {
            //cr_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            //PopulateDropDown(cr_ddlTransPaymentType, dr["PayType"].ToString());
            cr_txtTransAmount.Text = dr["Amount"].ToString();
            cr_txtTransPrinciple.Text = dr["Principal"].ToString();
            cr_txtTransIntrest.Text = dr["Interest"].ToString();
            cr_txtTransDescription.Text = dr["Description"].ToString();
            cr_txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            cr_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            cr_cbLoanTransActive.Enabled = true;
        }

        private void PopulateAdjustmentForm(DataRow dr)
        {
            ad_txtTransDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            PopulateDropDown(ad_ddlTransCompounding, dr["Compound"].ToString());
            PopulateDropDown(ad_ddlTransPaymentType, dr["PayType"].ToString());
            PopulateDropDown(ad_ddlTransPaymentFreq, dr["Freq"].ToString());

            ad_txtTransIntrestRate.Text = dr["IntRate"].ToString();
            ad_txtTransMaturityDate.Text = dr["MatDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MatDate"].ToString()).ToShortDateString();
            ad_txtTransStartDate.Text = dr["StartDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StartDate"].ToString()).ToShortDateString();
            ad_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            ad_txtTransIntrest.Text = dr["Interest"].ToString();
            ad_txtTransAmount.Text = dr["Amount"].ToString();
            ad_txtTransStopDate.Text = dr["StopDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StopDate"].ToString()).ToShortDateString();
            ad_txtTransDescription.Text = dr["Description"].ToString();
            ad_txtTransProjTransfered.Text = dr["TransferTo"].ToString();
            ad_txtTransProjConverted.Text = dr["ConvertFrom"].ToString();

            ad_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            ad_cbLoanTransActive.Enabled = true;
        }

        private void PopulateCapitalizingForm(DataRow dr)
        {
            cap_txtTransDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            //PopulateDropDown(cap_ddlTransPaymentType, dr["PayType"].ToString());
            cap_txtTransAmount.Text = dr["Amount"].ToString();
            //cap_txtTransPrinciple.Text = dr["Principal"].ToString();
            cap_txtTransDescription.Text = dr["Description"].ToString();
            cap_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            cap_cbLoanTransActive.Enabled = true;
        }

        protected void gvLoanTrans_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLoanTrans.EditIndex = e.NewEditIndex;
            BindLoanTransGrid();
        }

        protected void btnAddTransaction_Click(object sender, EventArgs e)
        {
            bool IsValid = true;

            if (ddlTransType.SelectedItem.Text.ToLower() == "adjustment")
            {
                if (ad_txtTransDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    ad_txtTransDate.Focus();
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
            {
                if (cap_txtTransDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    cap_txtTransDate.Focus();
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "cash receipt")
            {
                if (cr_txtEffectiveDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    cr_txtEffectiveDate.Focus();
                    IsValid = false;
                }
                else if (DataUtils.GetDecimal(cr_txtTransAmount.Text.Replace("$", "")) > 0 ||
                    DataUtils.GetDecimal(cr_txtTransPrinciple.Text.Replace("$", "")) > 0 ||
                        DataUtils.GetDecimal(cr_txtTransIntrest.Text.Replace("$", "")) > 0)
                {
                    LogMessage("Cash Receipt Amount, Principal and Interest must be negative");
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "conversion")
            {
                if (cv_txtEffectiveDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    cv_txtEffectiveDate.Focus();
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
            {
                if (dis_txtEffectiveDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    dis_txtEffectiveDate.Focus();
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "forgiveness")
            {
                if (fg_txtEffectiveDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    fg_txtEffectiveDate.Focus();
                    IsValid = false;
                }
                else if (DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")) > 0)
                {
                    LogMessage("Forgiveness Amount must be negative");
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "transfer")
            {
                if (tr_txtTransDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    tr_txtTransDate.Focus();
                    IsValid = false;
                }
            }
            if (IsValid)
            {
                if (btnAddTransaction.Text == "Add")
                {
                    AddLoanTransaction();
                }
                else
                {
                    UpdateTransaction();
                }
            }
        }

        private void UpdateTransaction()
        {
            if (ddlTransType.SelectedItem.Text.ToLower() == "adjustment")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, DataUtils.GetDecimal(ad_txtTransIntrestRate.Text), DataUtils.GetInt(ad_ddlTransCompounding.SelectedValue),
                    DataUtils.GetInt(ad_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(ad_ddlTransPaymentType.SelectedValue),
                    DataUtils.GetDate(ad_txtTransMaturityDate.Text), DataUtils.GetDate(ad_txtTransStartDate.Text),
                    DataUtils.GetDecimal(ad_txtTransAmount.Text.Replace("$", "")),
                    DataUtils.GetDate(ad_txtTransStopDate.Text),
                    DataUtils.GetDecimal(Regex.Replace(ad_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(ad_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                    ad_txtTransDescription.Text, DataUtils.GetInt(ad_txtTransProjTransfered.Text), 
                    DataUtils.GetInt(ad_txtTransProjConverted.Text), 
                    DataUtils.GetDate(ad_txtTransDate.Text),
                    ad_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null, 
                    //DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                    null,
                    null, null,
                    DataUtils.GetDecimal(Regex.Replace(cap_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    //DataUtils.GetDecimal(Regex.Replace(cap_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    null,
                    cap_txtTransDescription.Text, null, null, 
                    DataUtils.GetDate(cap_txtTransDate.Text), 
                    cap_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "cash receipt")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null,//DataUtils.GetDate(cr_txtTransDate.Text), 
                    null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(cr_txtTransAmount.Text.Replace("$", "")),
                    null,
                    DataUtils.GetDecimal(cr_txtTransPrinciple.Text.Replace("$", "")),
                    DataUtils.GetDecimal(cr_txtTransIntrest.Text.Replace("$", "")),
                    cr_txtTransDescription.Text, null, null, DataUtils.GetDate(cr_txtEffectiveDate.Text), cr_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "conversion")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value),
                    DataUtils.GetInt(ddlTransType.SelectedValue),
                    null,//DataUtils.GetDate(cv_txtTransDate.Text), 
                    null,//DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), 
                    null,//DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                    null,//DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), 
                    null,//DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                    null,
                    null,//DataUtils.GetDate(cv_txtTransStartDate.Text),
                    DataUtils.GetDecimal(Regex.Replace(cv_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,//DataUtils.GetDate(cv_txtTransStopDate.Text),
                    null,//DataUtils.GetDecimal(Regex.Replace(cv_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    null,//DataUtils.GetDecimal(Regex.Replace(cv_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                    cv_txtTransDescription.Text,
                    null,
                    null,//DataUtils.GetInt(cv_txtTransProjConverted.Text), 
                    DataUtils.GetDate(cv_txtEffectiveDate.Text),
                    cv_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(Regex.Replace(dis_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    //DataUtils.GetDecimal(Regex.Replace(dis_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    null,
                    dis_txtTransDescription.Text, null, null,
                    DataUtils.GetDate(dis_txtEffectiveDate.Text), 
                    dis_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "forgiveness")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null,//DataUtils.GetDate(fg_txtTransDate.Text), 
                    null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")),
                    null,
                    null,//DataUtils.GetDecimal(Regex.Replace(fg_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    fg_txtTransDescription.Text, null, null,
                    DataUtils.GetDate(fg_txtEffectiveDate.Text),
                    fg_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "transfer")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(Regex.Replace(tr_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    DataUtils.GetDecimal(Regex.Replace(tr_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    tr_txtTransDescription.Text, DataUtils.GetInt(tr_txtTransProjTransfered.Text), 
                    DataUtils.GetInt(tr_txtTransProjConverted.Text),
                    DataUtils.GetDate(tr_txtTransDate.Text), tr_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "note modification")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(nm_txtTransDate.Text), DataUtils.GetDecimal(nm_txtTransIntrestRate.Text), DataUtils.GetInt(nm_ddlTransCompounding.SelectedValue),
                    DataUtils.GetInt(nm_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(nm_ddlTransPaymentType.SelectedValue),
                    DataUtils.GetDate(nm_txtTransMaturityDate.Text), DataUtils.GetDate(nm_txtTransStartDate.Text),
                    DataUtils.GetDecimal(Regex.Replace(nm_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDate(nm_txtTransStopDate.Text),
                    DataUtils.GetDecimal(Regex.Replace(nm_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(nm_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                    nm_txtTransDescription.Text, null, null, null, nm_cbLoanTransActive.Checked);
            }
            LogMessage("Transaction updated successfully");

            ddlTransType.SelectedIndex = -1;
            TransactionTypeChanged();
            ClearTransForm();
            hfLoanTransID.Value = "";
            btnAddTransaction.Text = "Add";
            gvLoanTrans.EditIndex = -1;

            cbAddTransaction.Checked = false;
            BindLoanTransGrid();
        }

        private void AddLoanTransaction()
        {
            bool IsSuccess = false;

            if (ddlTransType.SelectedIndex != 0)
            {
                if (ddlTransType.SelectedItem.Text.ToLower() == "adjustment")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, DataUtils.GetDecimal(ad_txtTransIntrestRate.Text), DataUtils.GetInt(ad_ddlTransCompounding.SelectedValue),
                        DataUtils.GetInt(ad_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(ad_ddlTransPaymentType.SelectedValue),
                        DataUtils.GetDate(ad_txtTransMaturityDate.Text), DataUtils.GetDate(ad_txtTransStartDate.Text),
                        DataUtils.GetDecimal(ad_txtTransAmount.Text.Replace("$", "")),
                        DataUtils.GetDate(ad_txtTransStopDate.Text),
                        DataUtils.GetDecimal(Regex.Replace(ad_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDecimal(Regex.Replace(ad_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                        ad_txtTransDescription.Text, DataUtils.GetInt(ad_txtTransProjTransfered.Text), 
                        DataUtils.GetInt(ad_txtTransProjConverted.Text), 
                        DataUtils.GetDate(ad_txtTransDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), 
                        DataUtils.GetInt(ddlTransType.SelectedValue), 
                        null, null, null,
                        null, 
                        //DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                        null,
                        null, null,
                        DataUtils.GetDecimal(Regex.Replace(cap_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        //DataUtils.GetDecimal(Regex.Replace(cap_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        null,
                        cap_txtTransDescription.Text, null, null, 
                        DataUtils.GetDate(cap_txtTransDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "cash receipt")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null,//DataUtils.GetDate(cr_txtTransDate.Text), 
                        null, null,
                        null, null,
                        null, null,
                        DataUtils.GetDecimal(cr_txtTransAmount.Text.Replace("$", "")),
                        null,
                        DataUtils.GetDecimal(cr_txtTransPrinciple.Text.Replace("$", "")),
                        DataUtils.GetDecimal(cr_txtTransIntrest.Text.Replace("$", "")),
                        cr_txtTransDescription.Text, null, null, DataUtils.GetDate(cr_txtEffectiveDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "conversion")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), 
                        DataUtils.GetInt(ddlTransType.SelectedValue),
                        null,//DataUtils.GetDate(cv_txtTransDate.Text), 
                        null,//DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), 
                        null,//DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                        null,//DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), 
                        null,//DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                        null,
                        null,//DataUtils.GetDate(cv_txtTransStartDate.Text),
                        DataUtils.GetDecimal(Regex.Replace(cv_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,//DataUtils.GetDate(cv_txtTransStopDate.Text),
                        null,//DataUtils.GetDecimal(Regex.Replace(cv_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        null,//DataUtils.GetDecimal(Regex.Replace(cv_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                        cv_txtTransDescription.Text, 
                        null,
                        null,//DataUtils.GetInt(cv_txtTransProjConverted.Text), 
                        DataUtils.GetDate(cv_txtEffectiveDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, null, null,
                        null, null,
                        null, null,
                        DataUtils.GetDecimal(Regex.Replace(dis_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        //DataUtils.GetDecimal(Regex.Replace(dis_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        null,
                        dis_txtTransDescription.Text, null, null,
                        DataUtils.GetDate(dis_txtEffectiveDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "forgiveness")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null,//DataUtils.GetDate(fg_txtTransDate.Text), 
                        null, null,
                        null, null,
                        null, null,
                        DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")),
                        null,
                        null,//DataUtils.GetDecimal(Regex.Replace(fg_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        fg_txtTransDescription.Text, null, null,
                        DataUtils.GetDate(fg_txtEffectiveDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "transfer")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, null, null,
                        null, null,
                        null, null,
                        DataUtils.GetDecimal(Regex.Replace(tr_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        DataUtils.GetDecimal(Regex.Replace(tr_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        tr_txtTransDescription.Text, DataUtils.GetInt(tr_txtTransProjTransfered.Text), 
                        DataUtils.GetInt(tr_txtTransProjConverted.Text),
                        DataUtils.GetDate(tr_txtTransDate.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "note modification")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(nm_txtTransDate.Text), DataUtils.GetDecimal(nm_txtTransIntrestRate.Text), DataUtils.GetInt(nm_ddlTransCompounding.SelectedValue),
                        DataUtils.GetInt(nm_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(nm_ddlTransPaymentType.SelectedValue),
                        DataUtils.GetDate(nm_txtTransMaturityDate.Text), DataUtils.GetDate(nm_txtTransStartDate.Text),
                        DataUtils.GetDecimal(Regex.Replace(nm_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDate(nm_txtTransStopDate.Text),
                        DataUtils.GetDecimal(Regex.Replace(nm_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        DataUtils.GetDecimal(Regex.Replace(nm_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                        nm_txtTransDescription.Text, null, null, null);
                }
            }

            if (IsSuccess)
                LogMessage("Transaction added successfully");

            cbAddTransaction.Checked = false;
            ddlTransType.SelectedIndex = -1;
            TransactionTypeChanged();
            ClearTransForm();
            BindLoanTransGrid();
        }

        protected void ddlTransType_SelectedIndexChanged(object sender, EventArgs e)
        {
            TransactionTypeChanged();
        }

        private void TransactionTypeChanged()
        {
            //VisibleAll();
            dvCaptalizing.Visible = false;
            dvAdgustment.Visible = false;
            dvCR.Visible = false;
            dvConversion.Visible = false;
            dvDisbursement.Visible = false;
            dvForgiveness.Visible = false;
            dvTransfer.Visible = false;
            dvNoteModification.Visible = false;

            ClearTransForm();

            if (ddlTransType.SelectedIndex != 0)
            {
                btnAddTransaction.Visible = true;
                btnAddTransaction.Text = "Add";

                switch (ddlTransType.SelectedItem.ToString().ToLower())
                {
                    case "capitalizing":
                        dvCaptalizing.Visible = true;
                        //VisibleCapitalizing();
                        break;
                    case "adjustment":
                        dvAdgustment.Visible = true;
                        //VisibleAdjustment();
                        break;
                    case "cash receipt":
                        dvCR.Visible = true;
                        //VisibleCashReceipt();
                        break;
                    case "conversion":
                        dvConversion.Visible = true;
                        //VisibleConversion();
                        break;
                    case "disbursement":
                        dvDisbursement.Visible=true;
                        break;
                    case "forgiveness":
                        dvForgiveness.Visible = true;
                        break;
                    case "note modification":
                        dvNoteModification.Visible = true;
                        break;
                    case "transfer":
                        dvTransfer.Visible = true;
                        break;
                }

            }
    }

        private void ClearTransForm()
        {
            //ddlTransType.SelectedIndex = -1;
            btnAddTransaction.Visible = false;

            ad_txtTransDate.Text = "";
            ad_txtTransIntrestRate.Text = "";
            ad_ddlTransCompounding.SelectedIndex = -1;
            ad_ddlTransPaymentFreq.SelectedIndex = -1;
            ad_ddlTransPaymentType.SelectedIndex = -1;
            ad_txtTransMaturityDate.Text = "";
            ad_txtTransStartDate.Text = "";
            ad_txtTransAmount.Text = "";
            ad_txtTransStopDate.Text = "";
            ad_txtTransPrinciple.Text = "";
            ad_txtTransIntrest.Text = "";
            ad_txtTransDescription.Text = "";
            ad_txtTransProjTransfered.Text = "";
            ad_txtTransProjConverted.Text = "";
            ad_cbLoanTransActive.Checked = true;
            ad_cbLoanTransActive.Enabled = false;

            cap_txtTransDate.Text = "";
            //cap_ddlTransPaymentType.SelectedIndex = -1;
            cap_txtTransAmount.Text = "";
            //cap_txtTransPrinciple.Text = "";
            cap_txtTransDescription.Text = "";
            cap_cbLoanTransActive.Checked = true;
            cap_cbLoanTransActive.Enabled = false;

            //cr_txtTransDate.Text = "";
            //cr_ddlTransPaymentType.SelectedIndex = -1;
            cr_txtTransAmount.Text = "";
            cr_txtTransPrinciple.Text = "";
            cr_txtTransIntrest.Text = "";
            cr_txtTransDescription.Text = "";
            cr_txtEffectiveDate.Text = "";
            cr_cbLoanTransActive.Checked = true;
            cr_cbLoanTransActive.Enabled = false;

            //cv_txtTransDate.Text = "";
            //cv_txtTransIntrestRate.Text = "";
            //cv_ddlTransCompounding.SelectedIndex = -1;
            //cv_ddlTransPaymentFreq.SelectedIndex = -1;
            //cv_ddlTransPaymentType.SelectedIndex = -1;
            //cv_txtTransStartDate.Text = "";
            cv_txtTransAmount.Text = "";
            //cv_txtTransStopDate.Text = "";
            //cv_txtTransPrinciple.Text = "";
            //cv_txtTransIntrest.Text = "";
            cv_txtTransDescription.Text = "";
            //cv_txtTransProjConverted.Text = "";
            cv_cbLoanTransActive.Checked = true;
            cv_cbLoanTransActive.Enabled = false;
            cv_txtEffectiveDate.Text = "";

            //Disbursement
            dis_txtTransAmount.Text = "";
            //dis_txtTransPrinciple.Text = "";
            dis_txtTransDescription.Text = "";
            dis_txtEffectiveDate.Text = "";
            dis_cbLoanTransActive.Checked = true;
            dis_cbLoanTransActive.Enabled = false;

            //forgiveness
            //fg_txtTransDate.Text = "";
            fg_txtTransAmount.Text = "";
            //fg_txtTransPrinciple.Text = "";
            fg_txtEffectiveDate.Text = "";
            fg_txtTransDescription.Text = "";
            fg_cbLoanTransActive.Checked = true;
            fg_cbLoanTransActive.Enabled = false;

            //Transfer
            tr_txtTransDate.Text = "";
            tr_txtTransAmount.Text = "";
            tr_txtTransPrinciple.Text = "";
            tr_txtTransDescription.Text = "";
            tr_txtTransProjTransfered.Text = "";
            tr_txtTransProjConverted.Text = "";
            tr_cbLoanTransActive.Checked = true;
            tr_cbLoanTransActive.Enabled = false;

            //NoteModification
            nm_txtTransDate.Text = "";
            nm_txtTransIntrestRate.Text = "";
            nm_ddlTransCompounding.SelectedIndex = -1;
            nm_ddlTransPaymentFreq.SelectedIndex = -1;
            nm_ddlTransPaymentType.SelectedIndex = -1;
            nm_txtTransMaturityDate.Text = "";
            nm_txtTransStartDate.Text = "";
            nm_txtTransAmount.Text = "";
            nm_txtTransStopDate.Text = "";
            nm_txtTransPrinciple.Text = "";
            nm_txtTransIntrest.Text = "";
            nm_txtTransDescription.Text = "";
            nm_cbLoanTransActive.Checked = true;
            nm_cbLoanTransActive.Enabled = false;
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetPrimaryApplicant(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ApplicantData.GetSortedApplicants(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        protected void btnAddFund_Click(object sender, EventArgs e)
        {
            try
            {
                LoanResult objLoanResult = LoanMaintenanceData.AddLoanFund(DataUtils.GetInt(hfLoanId.Value),
                    DataUtils.GetInt(ddlFund.SelectedValue),
                    DataUtils.GetDecimal(Regex.Replace(txtFundAmount.Text, "[^0-9a-zA-Z.]+", "")));

                if (objLoanResult.IsDuplicate && !objLoanResult.IsActive)
                    LogMessage("Loan Fund already exist as in-active");
                else if (objLoanResult.IsDuplicate)
                    LogMessage("Loan Fund already exist");
                else
                    LogMessage("New Loan Fund added successfully");

                BindFundDetailsGrid();
                ddlFund.SelectedIndex = -1;
                txtFundAmount.Text = "";
                cbAddNewFundDetails.Checked = false;
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        private void BindFundDetailsGrid()
        {
            try
            {
                DataTable dtLoanDetails = LoanMaintenanceData.GetFundDetailsByLoanId(DataUtils.GetInt(hfLoanId.Value), cbActiveOnly.Checked);

                if (dtLoanDetails.Rows.Count > 0)
                {
                    dvFundDetailsGrid.Visible = true;
                    gvFundDetails.DataSource = dtLoanDetails;
                    gvFundDetails.DataBind();

                    Label lblFooterTotalAmount = (Label)gvFundDetails.FooterRow.FindControl("lblFooterTotalAmount");
                    decimal totAmountFromDB = 0;

                    for (int i = 0; i < dtLoanDetails.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dtLoanDetails.Rows[i]["RowIsActive"].ToString()))
                            totAmountFromDB += DataUtils.GetDecimal(dtLoanDetails.Rows[i]["Amount"].ToString());
                    }

                    lblFooterTotalAmount.Text = CommonHelper.myDollarFormat(totAmountFromDB);

                    decimal NoteAmount = DataUtils.GetDecimal(Regex.Replace(hfSelectedNoteAmt.Value, "[^0-9a-zA-Z.]+", ""));

                    hfFundAmountWarning.Value = "0";
                    if (NoteAmount - totAmountFromDB != 0)
                    {
                        hfFundAmountWarning.Value = "1";
                        WarningMessage(dvFundAmountWarning, lblFundAmountWarning, "The Fund amount(s) must equal the Note Amount " + CommonHelper.myDollarFormat(NoteAmount));
                    }
                    else
                    {
                        dvFundAmountWarning.Visible = false;
                        lblFundAmountWarning.Text = "";
                    }
                }
                else
                {
                    dvFundDetailsGrid.Visible = false;
                    gvFundDetails.DataSource = null;
                    gvFundDetails.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindFundDetailsGrid", "", ex.Message);
            }
        }

        protected void gvFundDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFundDetails.EditIndex = -1;
            BindFundDetailsGrid();
        }

        protected void gvFundDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                CommonHelper.GridViewSetFocus(e.Row);
                btnAddFund.Text = "Update";
                //cbAddNewFundDetails.Checked = true;
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlFundEdit = (e.Row.FindControl("ddlFundEdit") as DropDownList);
                    TextBox txtFundID = (e.Row.FindControl("txtFundID") as TextBox);
                    BindFundType(ddlFundEdit);
                    PopulateDropDown(ddlFundEdit, txtFundID.Text);
                }
            }
        }

        protected void gvFundDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFundDetails.EditIndex = e.NewEditIndex;
            BindFundDetailsGrid();
        }

        protected void gvFundDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            
            int LoanFundID = DataUtils.GetInt(((Label)gvFundDetails.Rows[rowIndex].FindControl("lblLoanFundID")).Text);
            decimal Amount = DataUtils.GetDecimal(((TextBox)gvFundDetails.Rows[rowIndex].FindControl("txtFundAmount1")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvFundDetails.Rows[rowIndex].FindControl("chkActiveEditFund")).Checked); ;
            int FundId = DataUtils.GetInt(((DropDownList)gvFundDetails.Rows[rowIndex].FindControl("ddlFundEdit")).SelectedValue.ToString());

            LoanMaintenanceData.UpdateLoanFund(LoanFundID, FundId, Amount, RowIsActive);
            gvFundDetails.EditIndex = -1;

            BindFundDetailsGrid();
            LogMessage("Loan Fund updated successfully");

            ddlFund.SelectedIndex = -1;
            txtFundAmount.Text = "";
            cbAddNewFundDetails.Checked = false;
        }

        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }

        protected void ddlLegalDocs_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLegalDocs.SelectedIndex != 0)
            {
                //spnBoardApprovalDate.Visible = false;
                //txtBoardApprovalDate.Visible = false;
                pnlLoanDetailsForm1.Visible = true;
                pnlLoanDetailsForm2.Visible = true;

                switch (ddlLegalDocs.SelectedItem.ToString().ToLower())
                {
                    //case "modification":
                    //    spnBoardApprovalDate.Visible = true;
                    //    txtBoardApprovalDate.Visible = true;
                    //    break;
                    case "discharge":
                        pnlLoanDetailsForm1.Visible = false;
                        pnlLoanDetailsForm2.Visible = true;
                        break;
                }
            }
        }

        protected void cbAddNewLoanDetails_CheckedChanged(object sender, EventArgs e)
        {
            DataRow dr = LoanMaintenanceData.GetLatestLoanDetailsByLoanId(DataUtils.GetInt(hfLoanId.Value));

            if (dr != null)
            {
                btnAddLoanDetails.Visible = true;
                btnAddLoanDetails.Text = "Add";

                PopulateDropDown(ddlLoanCat, dr["LoanCat"].ToString());

                txtOriginalDateOfNote.Text = dr["NoteDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["NoteDate"].ToString()).ToShortDateString();
                txtMaturityDate.Text = dr["MaturityDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MaturityDate"].ToString()).ToShortDateString();
                txtIntrestRate.Text = dr["IntRate"].ToString();
                PopulateDropDown(ddlCompounded, dr["Compound"].ToString());
                PopulateDropDown(ddlPaymentFreq, dr["Frequency"].ToString());
                PopulateDropDown(ddlPaymentType, dr["PaymentType"].ToString());
                //PopulateDropDown(ddlLegalDocs, dr["LegalDoc"].ToString());
                txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();
                txtFileURL.Text = dr["URL"].ToString();
                txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                txtBoardApprovalDate.Text = dr["BoardApproveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["BoardApproveDate"].ToString()).ToShortDateString();
            }
        }

        protected void gvProjectLoanDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString());

                int loanDetailId = Convert.ToInt32(((Label)gvProjectLoanDetails.Rows[rowIndex].FindControl("lblLoanDetailID")).Text);
                DataRow dr = LoanMaintenanceData.GetLoanDetailsByLoanDetailId(loanDetailId);

                hfLoanDetailID.Value = loanDetailId.ToString();
                //Populate Edit Form
                cbAddNewLoanDetails.Checked = true;
                btnAddLoanDetails.Visible = false;
                PopulateDropDown(ddlLoanCat, dr["LoanCat"].ToString());

                txtOriginalDateOfNote.Text = dr["NoteDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["NoteDate"].ToString()).ToShortDateString();
                txtMaturityDate.Text = dr["MaturityDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MaturityDate"].ToString()).ToShortDateString();
                txtIntrestRate.Text = dr["IntRate"].ToString();
                PopulateDropDown(ddlCompounded, dr["Compound"].ToString());
                PopulateDropDown(ddlPaymentFreq, dr["Frequency"].ToString());
                PopulateDropDown(ddlPaymentType, dr["PaymentType"].ToString());
                PopulateDropDown(ddlLegalDocs, dr["LegalDoc"].ToString());
                txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();
                txtFileURL.Text = dr["URL"].ToString();
                txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();

                cbLoanDetailActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
                cbLoanDetailActive.Enabled = true;
            }
        }

        public bool IsLoanDetailAccess()
        {
            DataTable dt = new DataTable();
            dt = UserSecurityData.GetUserFxnSecurity(GetUserId());

            foreach (DataRow row in dt.Rows)
            {
                if (row["FxnID"].ToString() == "31969")
                    return true;
            }
            return false;
        }

        protected int GetUserId()
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetUserByUserName(Context.User.Identity.GetUserName());
                return dtUser != null ? Convert.ToInt32(dtUser.Rows[0][0].ToString()) : 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}