using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
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
                CheckAccess();
            }
        }

        private void CheckAccess()
        {
            if(IsViewOnlyAccess())
            {
                btnLoanMaster.Visible = false;
                btnAddLoanDetails.Visible = false;
                btnAddFund.Visible = false;
                btnAddTransaction.Visible = false;
                AddEvent.Visible = false;
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

        protected bool IsAdminUser()
        {
            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            if (dr != null)
            {
                if (dr["usergroupid"].ToString() == "0") // Admin Only
                {
                   return true;
                }
            }
            return false;
        }

        private void BindControls()
        {
            BindLookUP(ddlLoanCat, 179);
            BindLookUP(ddlCompounded, 190);
            BindLookUP(ddlPaymentFreq, 191);
            BindLookUP(ddlPaymentType, 192);
            BindLookUP(ddlTransType, 178);
            ddlTransType.Items.Remove(ddlTransType.Items.FindByValue("33090"));

            BindLookUP(ddlLegalDocs, 268);
            BindLookUP(ddlLegalDocs_dc, 268);
            BindLookUP(ad_ddlTransCompounding, 190);
            BindLookUP(ad_ddlTransPaymentFreq, 191);
            BindLookUP(ad_ddlTransPaymentType, 192);

            BindLookUP(nm_ddlTransCompounding, 190);
            BindLookUP(nm_ddlTransPaymentFreq, 191);
            BindLookUP(nm_ddlTransPaymentType, 192);
            BindLookUP(ddlEvent, 1268);

            //BindLookUP(cap_ddlTransPaymentType, 192);
            //BindLookUP(cr_ddlTransPaymentType, 192);

            //BindLookUP(cv_ddlTransCompounding, 190);
            //BindLookUP(cv_ddlTransPaymentFreq, 191);
            //BindLookUP(cv_ddlTransPaymentType, 192);
            //BindTaxCreditPartner();
            BindNoteOwner();
            BindFund(dis_ddlFundName);
            BindFundType(ddlFund);
            //BindFund(ddlNotesFund);
            BindLookUP(ddlFundGroup, 1269);
            BindSubLookUP(fg_ddlSubcategory, 26316);

        }

        private void BindSubLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.GetSubLookupValues(LookupType);
                ddList.DataValueField = "SubTypeID";
                ddList.DataTextField = "SubDescription";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
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
                //ddlNoteOwner.DataSource = LoanMaintenanceData.GetAllEntities();
                //ddlNoteOwner.DataValueField = "ApplicantId";
                //ddlNoteOwner.DataTextField = "Applicantname";
                //ddlNoteOwner.DataBind();

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
                ddltaxCreditPartner.DataSource = LoanMaintenanceData.GetPartnershipByProjectId(DataUtils.GetInt(hfProjectId.Value));// GetAllEntities();
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
                hfProjectId.Value = GetProjectID(txtProjectNumDDL.Text).ToString();
                if (hfProjectId.Value != "0")
                {
                    lblProjName.Visible = true;
                    txtProjName.Visible = true;
                    DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
                    txtProjName.InnerText = dr["ProjectName"].ToString();
                    dvNewProjectInfo.Visible = true;
                    BindProjectLoanMasterGrid();
                    BindPrimaryApplicants();
                    BindRelatedProjectsGrid();
                    DataRow drPrimaryApplicant = ProjectMaintenanceData.GetPrimaryApplicantbyProjectId(DataUtils.GetInt(hfProjectId.Value));

                    if (drPrimaryApplicant != null)
                    {
                        PopulateDropDown(ddlPrimaryApplicant, drPrimaryApplicant["ApplicantId"].ToString());
                        ddlNoteOwner.Items.Clear();
                        ddlNoteOwner.Items.Insert(0, new ListItem(ddlPrimaryApplicant.SelectedItem.ToString(), ddlPrimaryApplicant.SelectedValue.ToString()));
                    }

                    DataRow drNoteAmount = ProjectMaintenanceData.GetPrimaryApplicantbyProjectId(DataUtils.GetInt(hfProjectId.Value));

                    BindTaxCreditPartner();
                }
                else
                {
                    LogMessage("Project does not exist");
                }
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
            ddlNoteOwner.Items.Clear();
            //txtNoteAmount.Text = "";
            spnNoteAmount.InnerHtml = "";
            //txtBalanceForward.Text = "";
            ddlFundGroup.SelectedIndex = -1;
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
                PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());

                //txtTaxCreditPartner.Text = drLoanMasterDetails["TaxCreditPartner"].ToString();
                //txtNoteOwner.Text = drLoanMasterDetails["NoteOwner"].ToString();
                //txtPrimaryApplicant.Text = drLoanMasterDetails["ApplicantID"].ToString();

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
            DateTime? EffectiveDate, bool Adjustment, string URL, int? FundID, int ToLoanID, int? TransSubType)
        {
            DateTime TransDate1 = TransDate ?? DateTime.MinValue;
            DateTime MatDate1 = MatDate ?? DateTime.MinValue;
            DateTime StartDate1 = StartDate ?? DateTime.MinValue;
            DateTime StopDate1 = StopDate ?? DateTime.MinValue;
            DateTime EffectiveDate1 = EffectiveDate ?? DateTime.MinValue;

            LoanMaintenanceData.AddLoanTransactions(LoanId, TransType, TransDate1, IntRate, Compound, Freq, PayType, MatDate1, StartDate1,
                Amount, StopDate1, Principal, Interest, Description, TransferTo, ConvertFrom, EffectiveDate1, 
                Adjustment, URL, FundID, ToLoanID, TransSubType);

            return true;
        }

        private bool UpdateLoanTransactions(int LoanTransId, int TransType, DateTime? TransDate, decimal? IntRate,
            int? Compound, int? Freq, int? PayType, DateTime? MatDate, DateTime? StartDate, decimal? Amount, DateTime? StopDate,
            decimal? Principal, decimal? Interest, string Description, int? TransferTo, int? ConvertFrom,
            DateTime? EffectiveDate, bool RowIsActive, bool Adjustment, string URL, int? FundID, int? TransSubType)
        {
            DateTime TransDate1 = TransDate ?? DateTime.MinValue;
            DateTime MatDate1 = MatDate ?? DateTime.MinValue;
            DateTime StartDate1 = StartDate ?? DateTime.MinValue;
            DateTime StopDate1 = StopDate ?? DateTime.MinValue;
            DateTime EffectiveDate1 = EffectiveDate ?? DateTime.MinValue;

            LoanMaintenanceData.UpdateLoanTransactions(LoanTransId, TransType, TransDate1, IntRate, Compound, Freq, PayType, MatDate1, StartDate1,
                Amount, StopDate1, Principal, Interest, Description, TransferTo, ConvertFrom, EffectiveDate1, 
                RowIsActive, Adjustment, URL, FundID, TransSubType);

            return true;
        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {
            try
            {
                string URL = txtFileHoldLink.Text;

                if (URL != "")
                    URL = URL.Split('/').Last();

                LoanResult objLoanResult = LoanMaintenanceData.AddLoanEvent(DataUtils.GetInt(hfLoanId.Value),
                    txtEventDescription.Text, DataUtils.GetDate(txtEventDate.Text),
                DataUtils.GetInt(ddlEvent.SelectedValue), URL);

                if (objLoanResult.IsDuplicate && !objLoanResult.IsActive)
                    LogMessage("Milestone already exist as in-active");
                else if (objLoanResult.IsDuplicate)
                    LogMessage("Milestone already exist");
                else
                    LogMessage("New Milestone added successfully");

                BindLoanEventsGrid();
                txtEventDescription.Text = "";
                cbAddEvent.Checked = false;
                txtEventDate.Text = "";
                ddlEvent.SelectedIndex = -1;
                txtFileHoldLink.Text = "";
                txtEventDescription.Text = "";
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        protected void btnLoanMaster_Click(object sender, EventArgs e)
        {
            //if (DataUtils.GetDecimal(Regex.Replace(txtNoteAmount.Text, "[^0-9a-zA-Z.]+", "")) == 0)
            //{
            //    LogMessage("Enter Note Amount");
            //    txtNoteAmount.Focus();
            //    return;
            //}

            var NoteOwnerValue = HttpContext.Current.Request.Form["ctl00$MainContent$ddlNoteOwner"];

            if (btnLoanMaster.Text == "Add")
            {
                LoanMaintenanceData.AddLoanMaster(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddltaxCreditPartner.SelectedValue.ToString()),
                    DataUtils.GetInt(NoteOwnerValue),
                    //DataUtils.GetInt(ddlNoteOwner.SelectedValue.ToString()), 
                    0,
                    //DataUtils.GetDecimal(Regex.Replace(txtNoteAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetInt(ddlFundGroup.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()));
            }
            else
            {
                LoanMaintenanceData.UpdateLoanMaster(DataUtils.GetInt(hfLoanId.Value),
                    DataUtils.GetInt(ddltaxCreditPartner.SelectedValue.ToString()),
                    DataUtils.GetInt(NoteOwnerValue),
                    //DataUtils.GetInt(ddlNoteOwner.SelectedValue.ToString()),
                    DataUtils.GetDecimal(Regex.Replace(spnNoteAmount.InnerHtml, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetInt(ddlFundGroup.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()), cbLoanMasterActive.Checked);

                LogMessage("Loan Master updated successfully");

                hfLoanId.Value = "";
                btnLoanMaster.Text = "Add";
                cbAddLoanMaster.Checked = false;
                gvLoanMaster.EditIndex = -1;
                ddlNoteOwner.Items.Clear();
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
            txtBoardApprovalDate.Text = "";

            ddlLegalDocs_dc.SelectedIndex = -1;
            txtDocumentDate_DC.Text = "";
            txtEffectiveDate_DC.Text = "";
            txtFileHoldLink_DC.Text = "";
            cbLoanDetailActive_DC.Checked = true;
            cbLoanDetailActive_DC.Enabled = false;

            cbLoanDetailActive_ON.Checked = true;
            cbLoanDetailActive_ON.Enabled = false;

            txtOriginalDateOfNote.Enabled = true;
        }

        protected void gvProjectLoanDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Label lblLegalDocument = e.Row.FindControl("lblLegalDoc") as Label;

                    if (lblLegalDocument.Text.ToLower() == "db conversion")
                    {
                        LinkButton lbEdit = e.Row.FindControl("LinkButton1") as LinkButton;
                        lbEdit.Visible = false;
                        spnLegalDoc.Visible = true;
                    }

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

                        if (!IsAdminUser())
                            txtOriginalDateOfNote.Enabled = false;

                        txtMaturityDate.Text = dr["MaturityDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MaturityDate"].ToString()).ToShortDateString();
                        txtIntrestRate.Text = dr["IntRate"].ToString();
                        PopulateDropDown(ddlCompounded, dr["Compound"].ToString());
                        PopulateDropDown(ddlPaymentFreq, dr["Frequency"].ToString());
                        PopulateDropDown(ddlPaymentType, dr["PaymentType"].ToString());
                        PopulateDropDown(ddlLegalDocs, dr["LegalDoc"].ToString());
                        PopulateDropDown(ddlLegalDocs_dc, dr["LegalDoc"].ToString());
                        txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();
                        txtFileURL.Text = dr["URL"].ToString();
                        txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                        txtBoardApprovalDate.Text = dr["DocumentDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DocumentDate"].ToString()).ToShortDateString();
                        cbLoanDetailActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbLoanDetailActive.Enabled = true;

                        cbLoanDetailActive_ON.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbLoanDetailActive_ON.Enabled = true;

                        cbLoanDetailActive_DC.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbLoanDetailActive_DC.Enabled = true;

                        txtDocumentDate_DC.Text = dr["DocumentDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DocumentDate"].ToString()).ToShortDateString(); ;
                        txtEffectiveDate_DC.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                        txtFileHoldLink_DC.Text = dr["URL"].ToString();
                        txtNoteAmountLoanDetails.Text = CommonHelper.myDollarFormat(dr["NoteAmt"].ToString());

                        PopulateDCForm();
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
                int intLegalDoc = 0;
                DateTime EffDate = DateTime.Now;
                DateTime DocDate = DateTime.Now;
                bool isActive = false;
                string URL = "";

                if (!pnlLoanDetailsForm_DC.Visible && ddlLegalDocs.SelectedIndex != 0)
                {
                    intLegalDoc = DataUtils.GetInt(ddlLegalDocs.SelectedValue.ToString());
                    EffDate = DataUtils.GetDate(txtEffectiveDate.Text);
                    DocDate = DataUtils.GetDate(txtBoardApprovalDate.Text);
                    if (txtFileURL.Text != "")
                        URL = txtFileURL.Text.Split('/').Last();

                    if (pnlLoanDetailsForm_ON.Visible)
                        isActive = cbLoanDetailActive_ON.Checked;
                    else
                        isActive = cbLoanDetailActive.Checked;
                }

                if (pnlLoanDetailsForm_DC.Visible && ddlLegalDocs_dc.SelectedIndex != 0)
                {
                    intLegalDoc = DataUtils.GetInt(ddlLegalDocs_dc.SelectedValue.ToString());
                    EffDate = DataUtils.GetDate(txtEffectiveDate_DC.Text);
                    DocDate = DataUtils.GetDate(txtDocumentDate_DC.Text);
                    if (txtFileHoldLink_DC.Text != "")
                        URL = txtFileHoldLink_DC.Text.Split('/').Last();
                    isActive = cbLoanDetailActive_DC.Checked;
                }

                if (btnAddLoanDetails.Text == "Add")
                {
                    LoadDetailsResult objLoadDetailsResult = LoanMaintenanceData.AddLoanDetail(
                        DataUtils.GetInt(hfLoanId.Value),
                        intLegalDoc,
                        DataUtils.GetInt(ddlLoanCat.SelectedValue.ToString()),
                        DataUtils.GetDate(txtOriginalDateOfNote.Text), DataUtils.GetDate(txtMaturityDate.Text),
                        DataUtils.GetDecimal(txtIntrestRate.Text),
                        DataUtils.GetInt(ddlCompounded.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentFreq.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentType.SelectedValue.ToString()),
                        DataUtils.GetDate(txtWatchDate.Text),
                        URL, EffDate, DocDate,
                        DataUtils.GetDecimal(Regex.Replace(txtNoteAmountLoanDetails.Text, "[^0-9a-zA-Z.]+", "")));

                    if (objLoadDetailsResult.IsExist)
                        LogMessage("Loan details already exists");
                    else
                    {
                        LogMessage("Loan details added successfully");
                        UpdateLoanMasterGrid(objLoadDetailsResult.LoanDetailId);
                    }
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
                        URL, EffDate,
                        DataUtils.GetDate(txtBoardApprovalDate.Text),
                        DataUtils.GetDecimal(Regex.Replace(txtNoteAmountLoanDetails.Text, "[^0-9a-zA-Z.]+", "")),
                        isActive);

                    LogMessage("Loan details updated successfully");
                    UpdateLoanMasterGrid(DataUtils.GetInt(hfLoanDetailID.Value));
                    hfLoanDetailID.Value = "";
                    btnAddLoanDetails.Text = "Add";
                    gvProjectLoanDetails.EditIndex = -1;
                }

                cbAddNewLoanDetails.Checked = false;
                ClearLoanDetailsForm();
                BindLoanMasterDetailsGrid();
            }
        }

        private void UpdateLoanMasterGrid(int LoanDetailID)
        {
            DataRow drLoanMasterNoteAmount = LoanMaintenanceData.GetLoanMasterNoteAmount(LoanDetailID);

            if (drLoanMasterNoteAmount != null)
            {
                foreach (GridViewRow row in gvLoanMaster.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        RadioButton rbRow = (row.Cells[0].FindControl("rdBtnSelectLoan") as RadioButton);
                        if (rbRow.Checked)
                        {
                            Label lblNoteAmt = (row.Cells[0].FindControl("lblNoteAmt") as Label);
                            lblNoteAmt.Text = CommonHelper.myDollarFormat(drLoanMasterNoteAmount["NoteAmount"].ToString()); ;
                            break;
                        }
                    }
                }
            }
        }

        protected bool IsLoanDetailFormValid()
        {
            if (pnlLoanDetailsForm_DC.Visible)
            {
                if (ddlLegalDocs_dc.SelectedIndex == 0)
                {
                    LogMessage("Select Legal Docs");
                    ddlLegalDocs_dc.Focus();
                    return false;
                }
            }
            else
            {
                if (ddlLegalDocs.SelectedIndex == 0)
                {
                    LogMessage("Select Legal Docs");
                    ddlLegalDocs.Focus();
                    return false;
                }
            }

            //if (ddlLegalDocs.SelectedItem.ToString().ToLower() == "modification")
            //{
            //    if (ddlPaymentType.SelectedIndex == 0)
            //    {
            //        LogMessage("Select Payment Type");
            //        ddlPaymentType.Focus();
            //        return false;
            //    }
            //}

            if (ddlLoanCat.SelectedIndex == 0)
            {
                LogMessage("Select Loan Category");
                ddlLoanCat.Focus();
                return false;
            }
            else if (txtBoardApprovalDate.Text.Trim() == "")
            {
                if (!DataUtils.IsDateTime(txtBoardApprovalDate.Text.Trim()))
                {
                    LogMessage("Enter valid Document Date");
                    txtBoardApprovalDate.Focus();
                    return false;
                }
            }
            else if (txtMaturityDate.Text.Trim() == "")
            {
                if (!DataUtils.IsDateTime(txtMaturityDate.Text.Trim()))
                {
                    LogMessage("Enter valid Maturity Date");
                    txtMaturityDate.Focus();
                    return false;
                }
            }
            else if (ddlLegalDocs.SelectedItem.ToString().ToLower() != "discharge")
            {
                if (txtOriginalDateOfNote.Text.Trim() == "")
                {
                    LogMessage("Enter Original Date of Note");
                    txtOriginalDateOfNote.Focus();
                    return false;
                }
                else
                {
                    if (!DataUtils.IsDateTime(txtOriginalDateOfNote.Text.Trim()))
                    {
                        LogMessage("Enter valid Original Date of Note");
                        txtOriginalDateOfNote.Focus();
                        return false;
                    }
                }
            }

            if (ddlPaymentFreq.SelectedIndex != 0)
            {
                if(ddlPaymentFreq.SelectedItem.ToString().ToLower() != "none")
                {
                    if (ddlPaymentType.SelectedIndex == 0)
                    {
                        LogMessage("Select Payment Type");
                        ddlPaymentType.Focus();
                        return false;
                    }
                }
            }
           

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
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    gvLoanMaster.Columns[7].Visible = true;
                    if (IsViewOnlyAccess())
                        gvLoanMaster.Columns[7].Visible = false;
                     
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnLoanMaster.Text = "Update";
                    btnLoanMaster.Visible = true;
                    cbAddLoanMaster.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[0].Visible = false;
                        Label lblLoanID = e.Row.FindControl("lblLoanID") as Label;
                        DataRow drLoanMasterDetails = LoanMaintenanceData.GetLoanMasterDetailsByLoanID(Convert.ToInt32(lblLoanID.Text));

                        hfLoanId.Value = lblLoanID.Text;
                        spnLoanId.InnerText = lblLoanID.Text;
                        //txtDescriptor.Text = drLoanMasterDetails["Descriptor"].ToString();
                        PopulateDropDown(ddltaxCreditPartner, drLoanMasterDetails["TaxCreditPartner"].ToString());
                        //PopulateDropDown(ddlNoteOwner, drLoanMasterDetails["NoteOwner"].ToString());
                        //txtNoteAmount.Text = drLoanMasterDetails["NoteAmt"].ToString();
                        spnNoteAmount.InnerHtml = CommonHelper.myDollarFormat(drLoanMasterDetails["NoteAmt"].ToString());
                        //txtBalanceForward.Text = drLoanMasterDetails["BalForward"].ToString();
                        PopulateDropDown(ddlFundGroup, drLoanMasterDetails["FundGroup"].ToString());
                        //txtPrimaryApplicant.Text = drLoanMasterDetails["Applicantname"].ToString();
                        PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
                        //PopulateDropDown(ddlFund, drLoanMasterDetails["FundID"].ToString());
                        btnLoanMaster.Text = "Update";


                        //ddlNoteOwner.Items.Insert(0, new ListItem("Select", "NA"));
                        ddlNoteOwner.Items.Clear();
                        ddlNoteOwner.Items.Insert(0, new ListItem(ddlPrimaryApplicant.SelectedItem.ToString(), ddlPrimaryApplicant.SelectedValue.ToString()));
                        ddlNoteOwner.Items.Insert(1, new ListItem(ddltaxCreditPartner.SelectedItem.ToString(), ddltaxCreditPartner.SelectedValue.ToString()));
                        PopulateDropDown(ddlNoteOwner, drLoanMasterDetails["NoteOwner"].ToString());

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
            txtNoteAmountLoanDetails.Text = objSelectedLoanMasterInfo.NoteAmt.ToString();
            //spnNoteAmt.InnerText = objSelectedLoanMasterInfo.NoteAmt.ToString();
            hfSelectedNoteAmt.Value = objSelectedLoanMasterInfo.NoteAmt.ToString();

            dvNewLoanDetailInfo.Visible = true;
            dvNewEvent.Visible = true;
            dvTransaction.Visible = true;
            //dvNotes.Visible = true;
            dvNewFundInfo.Visible = true;

            ibLoanSummary.Visible = true;

            BindLoanMasterDetailsGrid();
            BindLoanEventsGrid();
            BindLoanNotesGrid();
            BindLoanTransGrid();
            BindFundDetailsGrid();
            ClearLoanDetailsForm();
            ClearLoanTransForm();
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
            int EventId = DataUtils.GetInt(((DropDownList)gvLoanEvents.Rows[rowIndex].FindControl("ddlEvent")).SelectedValue.ToString());
            string NotesURL = ((TextBox)gvLoanEvents.Rows[rowIndex].FindControl("txtNotesURL")).Text;
            string URL = string.Empty;

            if (NotesURL != "")
                URL = NotesURL.Split('/').Last();

            DateTime EventDate = DataUtils.GetDate(((TextBox)gvLoanEvents.Rows[rowIndex].FindControl("txtEventDate")).Text);
            LoanMaintenanceData.UpdateLoanEvent(LoanEventID, Description, RowIsActive, EventDate, EventId, URL);
            gvLoanEvents.EditIndex = -1;

            BindLoanEventsGrid();
            LogMessage("Loan event updated successfully");
        }

        protected void gvLoanEvents_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    gvLoanEvents.Columns[6].Visible = true;
                    if (IsViewOnlyAccess())
                        gvLoanEvents.Columns[6].Visible = false;
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkActiveEditEvent = e.Row.FindControl("chkActiveEditEvent") as CheckBox;
                        chkActiveEditEvent.Enabled = true;

                        Label lblLoanEventID = e.Row.FindControl("lblLoanEventID") as Label;
                        DataRow dr = LoanMaintenanceData.GetLoanEventsByLoanEventID(DataUtils.GetInt(lblLoanEventID.Text));


                        DropDownList ddlEvent = (e.Row.FindControl("ddlEvent") as DropDownList);
                        BindLookUP(ddlEvent, 1268);
                        PopulateDropDown(ddlEvent, dr["Events"].ToString());

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
            cbAddTransaction.Checked = false;

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
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Label lblTransType = e.Row.FindControl("lblTransTypeDesc") as Label;

                    if (lblTransType.Text.ToLower() == "db converted balance")
                    {
                        LinkButton lbEdit = e.Row.FindControl("LinkButton1") as LinkButton;
                        lbEdit.Visible = false;
                    }
                    //else
                    //{
                    //    LinkButton lbView = e.Row.FindControl("AddButton") as LinkButton;
                    //    lbView.Visible = false;
                    //}

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
                    //btnAddNotes.Text = "Update";
                    cbAddTransaction.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[9].Controls[0].Visible = false;
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

            spnLRInsText.InnerHtml = "* Must be negative amount";
            insText.InnerHtml = "* Must be negative amount";
            spnL2LInsText.InnerHtml = "* Must be negative amount";

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
                    case "convert grant to  loan":
                        PopulateConversionForm(dr);
                        break;
                    case "disbursement":
                        PopulateDisbursementForm(dr);
                        break;
                    case "loan reduction":
                        PopulateForgivenessForm(dr);
                        break;
                    case "note modification":
                        PopulateNoteModificationForm(dr);
                        break;
                    case "loan to loan transfer":
                        PopulateTransferForm(dr);
                        break;
                    case "db converted balance":
                        PopulateDBConvertedBalanceForm(dr);
                        break;
                }
            }
        }

        private void PopulateDBConvertedBalanceForm(DataRow dr)
        {
            db_EffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            db_amount.Text = CommonHelper.myDollarFormat(dr["Amount"].ToString());
            db_description.Text = dr["Description"].ToString();
            db_Active.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            db_Active.Enabled = true;
            db_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());
        }

        private void PopulateTransferForm(DataRow dr)
        {
            tr_txtTransDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            tr_txtTransPrinciple.Text = dr["Principal"].ToString();//  dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            tr_txtTransAmount.Text = dr["Amount"].ToString();// CommonHelper.myDollarFormat(dr["Amount"].ToString());
            tr_txtTransDescription.Text = dr["Description"].ToString();
            //tr_txtTransProjTransfered.Text = dr["TransferTo"].ToString();
            //tr_txtTransProjConverted.Text = dr["ConvertFrom"].ToString();
            PopulateDropDown(ddlProjTransferedTo, dr["TransferTo"].ToString());
            spnTransFrom.InnerHtml = dr["ConvertFrom"].ToString() + ' ' + dr["FromFundGroupName"].ToString();
            //PopulateDropDown(ddlProjTransferedFrom, dr["ConvertFrom"].ToString());

            tr_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            tr_cbLoanTransActive.Enabled = true;
            tr_txtURL.Text = dr["URL"].ToString();
            tr_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());

            if (tr_cbAdjustment.Checked)
                spnL2LInsText.InnerHtml = "";
            else
                spnL2LInsText.InnerHtml = "* Must be negative amount";
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
            nm_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : CommonHelper.myDollarFormat(dr["Principal"].ToString());
            nm_txtTransIntrest.Text = dr["Interest"].ToString();
            nm_txtTransAmount.Text = CommonHelper.myDollarFormat(dr["Amount"].ToString());
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
            fg_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            fg_cbLoanTransActive.Enabled = true;
            fg_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());
            fg_txtURL.Text = dr["URL"].ToString();
            PopulateDropDown(fg_ddlSubcategory, dr["transsubtype"].ToString());
 
            if (fg_cbAdjustment.Checked)
                spnLRInsText.InnerHtml = "";
            else
                spnLRInsText.InnerHtml = "* Must be negative amount";
        }

        private void PopulateDisbursementForm(DataRow dr)
        {
            //dis_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            dis_txtTransAmount.Text = CommonHelper.myDollarFormat(dr["Amount"].ToString());
            dis_txtTransDescription.Text = dr["Description"].ToString();
            dis_txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            dis_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            dis_cbLoanTransActive.Enabled = true;
            dis_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());
            dis_spnVoid.InnerHtml = (DataUtils.GetDecimal(dr["Amount"].ToString()) < 0 && DataUtils.GetBool(dr["Adjustment"].ToString())) ? "Void" : "";
            PopulateDropDown(dis_ddlFundName, dr["FundID"].ToString());
        }

        private void PopulateConversionForm(DataRow dr)
        {
            cv_txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            cv_txtTransAmount.Text = CommonHelper.myDollarFormat(dr["Amount"].ToString());
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
            cv_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            cv_cbLoanTransActive.Enabled = true;
            cv_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());
            cv_txtURL.Text = dr["URL"].ToString();
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
            cr_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            cr_cbLoanTransActive.Enabled = true;
            cr_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());

            if (cr_cbAdjustment.Checked)
                insText.InnerHtml = "";
            else
                insText.InnerHtml = "* Must be negative amount";
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
            ad_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : CommonHelper.myDollarFormat(dr["Principal"].ToString());
            ad_txtTransIntrest.Text = dr["Interest"].ToString();
            ad_txtTransAmount.Text = CommonHelper.myDollarFormat(dr["Amount"].ToString());
            ad_txtTransStopDate.Text = dr["StopDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StopDate"].ToString()).ToShortDateString();
            ad_txtTransDescription.Text = dr["Description"].ToString();
            PopulateDropDown(ddlTransProjTransferedTo, dr["TransferTo"].ToString());
            PopulateDropDown(ddlTransProjConvertedFrom, dr["ConvertFrom"].ToString());
            ad_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            ad_cbLoanTransActive.Enabled = true;
        }

        private void PopulateCapitalizingForm(DataRow dr)
        {
            cap_txtTransDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
            //PopulateDropDown(cap_ddlTransPaymentType, dr["PayType"].ToString());
            cap_txtTransAmount.Text = CommonHelper.myDollarFormat(dr["Amount"].ToString());
            //cap_txtTransPrinciple.Text = dr["Principal"].ToString();
            cap_txtTransDescription.Text = dr["Description"].ToString();
            cap_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
            cap_cbLoanTransActive.Enabled = true;
            cap_cbAdjustment.Checked = DataUtils.GetBool(dr["Adjustment"].ToString());
            cap_txtURL.Text = dr["URL"].ToString();
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
                else if (!cr_cbAdjustment.Checked &&
                    (DataUtils.GetDecimal(cr_txtTransAmount.Text.Replace("$", "")) > 0 ||
                    DataUtils.GetDecimal(cr_txtTransPrinciple.Text.Replace("$", "")) > 0 ||
                        DataUtils.GetDecimal(cr_txtTransIntrest.Text.Replace("$", "")) > 0))
                {
                    LogMessage("Cash Receipt Amount, Principal and Interest must be negative");
                    IsValid = false;
                }
                else if (DataUtils.GetDecimal(cr_txtTransAmount.Text.Replace("$", "")) !=
                    (DataUtils.GetDecimal(cr_txtTransPrinciple.Text.Replace("$", "")) +
                        DataUtils.GetDecimal(cr_txtTransIntrest.Text.Replace("$", ""))))
                {
                    LogMessage("Cash Receipt Amount must be equal to Principal and Interest amount");
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "convert grant to loan")
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
            else if (ddlTransType.SelectedItem.Text.ToLower() == "loan reduction")
            {
                if (fg_txtEffectiveDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    fg_txtEffectiveDate.Focus();
                    IsValid = false;
                }
                else if (!fg_cbAdjustment.Checked &&
                    DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")) > 0)
                {
                    LogMessage("Loan Reduction Amount must be negative");
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "loan to loan transfer")
            {
                if (tr_txtTransDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    tr_txtTransDate.Focus();
                    IsValid = false;
                }
                else if (!tr_cbAdjustment.Checked &&
                    DataUtils.GetDecimal(tr_txtTransAmount.Text.Replace("$", "")) > 0)
                {
                    LogMessage("Loan to loan Amount must be negative");
                    IsValid = false;
                }
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "db converted balance")
            {
                if (db_EffectiveDate.Text == "")
                {
                    LogMessage("Please enter Effective Date");
                    db_EffectiveDate.Focus();
                    IsValid = false;
                }
                else if (DataUtils.GetDecimal(db_amount.Text.Replace("$", "")) == 0)
                {
                    LogMessage("Please enter valid amount");
                    db_amount.Focus();
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
                UpdateLoanMasterCurrentBalanceGrid(hfLoanId.Value);
            }
        }

        private void UpdateTransaction()
        {
            //if (ddlTransType.SelectedItem.Text.ToLower() == "adjustment")
            //{
            //    UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
            //        null, DataUtils.GetDecimal(ad_txtTransIntrestRate.Text), DataUtils.GetInt(ad_ddlTransCompounding.SelectedValue),
            //        DataUtils.GetInt(ad_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(ad_ddlTransPaymentType.SelectedValue),
            //        DataUtils.GetDate(ad_txtTransMaturityDate.Text), DataUtils.GetDate(ad_txtTransStartDate.Text),
            //        DataUtils.GetDecimal(ad_txtTransAmount.Text.Replace("$", "")),
            //        DataUtils.GetDate(ad_txtTransStopDate.Text),
            //        DataUtils.GetDecimal(Regex.Replace(ad_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
            //        DataUtils.GetDecimal(Regex.Replace(ad_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
            //        ad_txtTransDescription.Text, 
            //        DataUtils.GetInt(ddlTransProjTransferedTo.SelectedValue), 
            //        DataUtils.GetInt(ddlTransProjConvertedFrom.SelectedValue), 
            //        DataUtils.GetDate(ad_txtTransDate.Text),
            //        ad_cbLoanTransActive.Checked);
            //}
            if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
            {
                string URL = cap_txtURL.Text;

                if (URL != "")
                    URL = URL.Split('/').Last();

                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null,
                    //DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                    null,
                    null, null,
                    cap_cbAdjustment.Checked ? DataUtils.GetDecimal(cap_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cap_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    cap_cbAdjustment.Checked ? DataUtils.GetDecimal(cap_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cap_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    cap_txtTransDescription.Text, null, null,
                    DataUtils.GetDate(cap_txtTransDate.Text),
                    cap_cbLoanTransActive.Checked, cap_cbAdjustment.Checked, URL, null, null);
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
                    cr_txtTransDescription.Text, null, null,
                    DataUtils.GetDate(cr_txtEffectiveDate.Text), cr_cbLoanTransActive.Checked, cr_cbAdjustment.Checked, null, null, null);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "convert grant to  loan") //"conversion")
            {
                string URL = cv_txtURL.Text;

                if (URL != "")
                    URL = URL.Split('/').Last();

                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value),
                    DataUtils.GetInt(ddlTransType.SelectedValue),
                    null,//DataUtils.GetDate(cv_txtTransDate.Text), 
                    null,//DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), 
                    null,//DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                    null,//DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), 
                    null,//DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                    null,
                    null,//DataUtils.GetDate(cv_txtTransStartDate.Text),
                    cv_cbAdjustment.Checked ? DataUtils.GetDecimal(cv_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cv_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,//DataUtils.GetDate(cv_txtTransStopDate.Text),
                    cv_cbAdjustment.Checked ? DataUtils.GetDecimal(cv_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cv_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,//DataUtils.GetDecimal(Regex.Replace(cv_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                    cv_txtTransDescription.Text,
                    null,
                    null,//DataUtils.GetInt(cv_txtTransProjConverted.Text), 
                    DataUtils.GetDate(cv_txtEffectiveDate.Text),
                    cv_cbLoanTransActive.Checked, cv_cbAdjustment.Checked, URL, null, null);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null, null,
                    null, null,
                    dis_cbAdjustment.Checked ? DataUtils.GetDecimal(dis_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(dis_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    dis_cbAdjustment.Checked ? DataUtils.GetDecimal(dis_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(dis_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    dis_txtTransDescription.Text, null, null,
                    DataUtils.GetDate(dis_txtEffectiveDate.Text),
                    dis_cbLoanTransActive.Checked, dis_cbAdjustment.Checked, null,
                    DataUtils.GetInt(dis_ddlFundName.SelectedValue.ToString()), null);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "loan reduction") //"forgiveness")
            {
                string URL = fg_txtURL.Text;

                if (URL != "")
                    URL = URL.Split('/').Last();

                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null,//DataUtils.GetDate(fg_txtTransDate.Text), 
                    null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")),
                    null,
                    DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")),
                    null,
                    fg_txtTransDescription.Text, null, null,
                    DataUtils.GetDate(fg_txtEffectiveDate.Text),
                    fg_cbLoanTransActive.Checked, fg_cbAdjustment.Checked, URL, null, DataUtils.GetInt(fg_ddlSubcategory.SelectedValue));
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "loan to loan transfer")
            {
                string URL = tr_txtURL.Text;

                if (URL != "")
                    URL = URL.Split('/').Last();

                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(tr_txtTransAmount.Text.Replace("$", "")),
                    null,
                    DataUtils.GetDecimal(tr_txtTransAmount.Text.Replace("$", "")),
                    null,
                    tr_txtTransDescription.Text, DataUtils.GetInt(ddlProjTransferedTo.SelectedValue),
                    DataUtils.GetInt(hfLoanId.Value),
                    DataUtils.GetDate(tr_txtTransDate.Text), tr_cbLoanTransActive.Checked,
                    tr_cbAdjustment.Checked, URL, null, null);
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
                    nm_txtTransDescription.Text, null, null, null, nm_cbLoanTransActive.Checked, false, null, null, null);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "db converted balance")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value),
                    DataUtils.GetInt(ddlTransType.SelectedValue),
                    null,
                    null, null,
                    null, null,
                    null, null,
                    DataUtils.GetDecimal(Regex.Replace(db_amount.Text, "[^0-9a-zA-Z.]+", "")),
                    null,
                    DataUtils.GetDecimal(Regex.Replace(db_amount.Text, "[^0-9a-zA-Z.]+", "")), null,
                    db_description.Text, null, null, DataUtils.GetDate(db_EffectiveDate.Text),
                    db_Active.Checked, db_cbAdjustment.Checked, null, null, null);
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
                //if (ddlTransType.SelectedItem.Text.ToLower() == "adjustment")
                //{
                //    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                //        null, DataUtils.GetDecimal(ad_txtTransIntrestRate.Text), DataUtils.GetInt(ad_ddlTransCompounding.SelectedValue),
                //        DataUtils.GetInt(ad_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(ad_ddlTransPaymentType.SelectedValue),
                //        DataUtils.GetDate(ad_txtTransMaturityDate.Text), DataUtils.GetDate(ad_txtTransStartDate.Text),
                //        DataUtils.GetDecimal(ad_txtTransAmount.Text.Replace("$", "")),
                //        DataUtils.GetDate(ad_txtTransStopDate.Text),
                //        DataUtils.GetDecimal(Regex.Replace(ad_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                //        DataUtils.GetDecimal(Regex.Replace(ad_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                //        ad_txtTransDescription.Text,
                //        DataUtils.GetInt(ddlTransProjTransferedTo.SelectedValue),
                //        DataUtils.GetInt(ddlTransProjConvertedFrom.SelectedValue),
                //        DataUtils.GetDate(ad_txtTransDate.Text));
                //}
                if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
                {
                    string URL = cap_txtURL.Text;

                    if (URL != "")
                        URL = URL.Split('/').Last();

                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value),
                        DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, null, null,
                        null,
                        //DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                        null,
                        null, null,
                        cap_cbAdjustment.Checked? DataUtils.GetDecimal(cap_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cap_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        cap_cbAdjustment.Checked? DataUtils.GetDecimal(cap_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cap_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        cap_txtTransDescription.Text, null, null,
                        DataUtils.GetDate(cap_txtTransDate.Text),
                        cap_cbAdjustment.Checked, URL, null, 0, null);
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
                        cr_txtTransDescription.Text, null, null,
                        DataUtils.GetDate(cr_txtEffectiveDate.Text),
                        cr_cbAdjustment.Checked, null, null, 0, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "convert grant to  loan") //"conversion")
                {
                    string URL = cv_txtURL.Text;

                    if (URL != "")
                        URL = URL.Split('/').Last();

                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value),
                        DataUtils.GetInt(ddlTransType.SelectedValue),
                        null,//DataUtils.GetDate(cv_txtTransDate.Text), 
                        null,//DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), 
                        null,//DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                        null,//DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), 
                        null,//DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                        null,
                        null,//DataUtils.GetDate(cv_txtTransStartDate.Text),
                        cv_cbAdjustment.Checked ? DataUtils.GetDecimal(cv_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cv_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,//DataUtils.GetDate(cv_txtTransStopDate.Text),
                        cv_cbAdjustment.Checked ? DataUtils.GetDecimal(cv_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(cv_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,//DataUtils.GetDecimal(Regex.Replace(cv_txtTransIntrest.Text, "[^0-9a-zA-Z.]+", "")),
                        cv_txtTransDescription.Text,
                        null,
                        null,//DataUtils.GetInt(cv_txtTransProjConverted.Text), 
                        DataUtils.GetDate(cv_txtEffectiveDate.Text), cv_cbAdjustment.Checked, URL, null, 0, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, null, null,
                        null, null,
                        null, null,
                        dis_cbAdjustment.Checked ? DataUtils.GetDecimal(dis_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(dis_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        dis_cbAdjustment.Checked ? DataUtils.GetDecimal(dis_txtTransAmount.Text.Replace("$", "")) : DataUtils.GetDecimal(Regex.Replace(dis_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        dis_txtTransDescription.Text, null, null,
                        DataUtils.GetDate(dis_txtEffectiveDate.Text), dis_cbAdjustment.Checked, null,
                        DataUtils.GetInt(dis_ddlFundName.SelectedValue.ToString()), 0, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "loan reduction")//forgiveness")
                {
                    string URL = fg_txtURL.Text;

                    if (URL != "")
                        URL = URL.Split('/').Last();

                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null,//DataUtils.GetDate(fg_txtTransDate.Text), 
                        null, null,
                        null, null,
                        null, null,
                        DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")),
                        null,
                        DataUtils.GetDecimal(fg_txtTransAmount.Text.Replace("$", "")),
                        null,
                        fg_txtTransDescription.Text, null, null,
                        DataUtils.GetDate(fg_txtEffectiveDate.Text), fg_cbAdjustment.Checked, URL, null, 
                        0, DataUtils.GetInt(fg_ddlSubcategory.SelectedValue));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "loan to loan transfer")
                {
                    string URL = tr_txtURL.Text;

                    if (URL != "")
                        URL = URL.Split('/').Last();
                    string ToLoanId = ddlProjTransferedTo.SelectedItem.ToString().Split(' ').First();

                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, null, null,
                        null, null,
                        null, null,
                        DataUtils.GetDecimal(tr_txtTransAmount.Text.Replace("$", "")),
                        //DataUtils.GetDecimal(Regex.Replace(tr_txtTransAmount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        DataUtils.GetDecimal(tr_txtTransAmount.Text.Replace("$", "")),
                        //DataUtils.GetDecimal(Regex.Replace(tr_txtTransPrinciple.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        tr_txtTransDescription.Text, DataUtils.GetInt(ddlProjTransferedTo.SelectedValue),
                        DataUtils.GetInt(hfLoanId.Value),
                        DataUtils.GetDate(tr_txtTransDate.Text), tr_cbAdjustment.Checked, URL, null,
                        DataUtils.GetInt(ToLoanId), null);
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
                        nm_txtTransDescription.Text, null, null, null, false, null, null, 0, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "db converted balance")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value),
                        DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(nm_txtTransDate.Text),
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        DataUtils.GetDecimal(Regex.Replace(db_amount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        DataUtils.GetDecimal(Regex.Replace(db_amount.Text, "[^0-9a-zA-Z.]+", "")),
                        null,
                        db_description.Text, null, null,
                        DataUtils.GetDate(db_EffectiveDate.Text), db_cbAdjustment.Checked, null, null, 0, null);
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
            dvDBConvertedBalance.Visible = false;

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
                        BindProjects(ddlTransProjTransferedTo);
                        BindProjects(ddlTransProjConvertedFrom);
                        //VisibleAdjustment();
                        break;
                    case "cash receipt":
                        dvCR.Visible = true;
                        insText.InnerHtml = "* Must be negative amount";
                        //VisibleCashReceipt();
                        break;
                    case "convert grant to  loan":
                        dvConversion.Visible = true;
                        //VisibleConversion();
                        break;
                    case "disbursement":
                        dvDisbursement.Visible = true;
                        break;
                    case "loan reduction":
                        dvForgiveness.Visible = true;
                        spnLRInsText.InnerHtml = "* Must be negative amount";
                        break;
                    case "note modification":
                        dvNoteModification.Visible = true;
                        break;
                    case "loan to loan transfer":
                        dvTransfer.Visible = true;
                        BindLoanTransferTo(ddlProjTransferedTo);
                        DataRow drLoanMasterDetails = LoanMaintenanceData.GetLoanMasterDetailsByLoanID(Convert.ToInt32(hfLoanId.Value));
                        string FundGroupName = string.Empty;
                        if (drLoanMasterDetails != null)
                            FundGroupName = drLoanMasterDetails["FundGroupname"].ToString();

                        spnTransFrom.InnerHtml = hfLoanId.Value + ' ' + FundGroupName;
                        spnL2LInsText.InnerHtml = "* Must be negative amount";
                        break;
                    case "db converted balance":
                        dvDBConvertedBalance.Visible = true;
                        break;
                }

            }
        }

        protected void BindLoanTransferTo(DropDownList ddList)
        {
            try
            {
                ddList.DataSource = LoanMaintenanceData.GetLoanTransferList(DataUtils.GetInt(hfLoanId.Value));
                ddList.DataValueField = "LoanID";
                ddList.DataTextField = "FundGroup";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindProjects(DropDownList ddList)
        {
            try
            {
                ddList.DataSource = Project.GetProjects("GetProjects"); ;
                ddList.DataValueField = "projectId";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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
            ddlTransProjTransferedTo.SelectedIndex = -1;
            ddlTransProjConvertedFrom.SelectedIndex = -1;
            ad_cbLoanTransActive.Checked = true;
            ad_cbLoanTransActive.Enabled = false;

            cap_txtTransDate.Text = "";
            //cap_ddlTransPaymentType.SelectedIndex = -1;
            cap_txtTransAmount.Text = "";
            //cap_txtTransPrinciple.Text = "";
            cap_txtTransDescription.Text = "";
            cap_cbLoanTransActive.Checked = true;
            cap_cbLoanTransActive.Enabled = false;
            cap_cbAdjustment.Checked = false;
            cap_txtURL.Text = "";

            //cr_txtTransDate.Text = "";
            //cr_ddlTransPaymentType.SelectedIndex = -1;
            cr_txtTransAmount.Text = "";
            cr_txtTransPrinciple.Text = "";
            cr_txtTransIntrest.Text = "";
            cr_txtTransDescription.Text = "";
            cr_txtEffectiveDate.Text = "";
            cr_cbLoanTransActive.Checked = true;
            cr_cbLoanTransActive.Enabled = false;
            cr_cbAdjustment.Checked = false;

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
            cv_cbAdjustment.Checked = false;
            cv_txtURL.Text = "";

            //Disbursement
            dis_txtTransAmount.Text = "";
            //dis_txtTransPrinciple.Text = "";
            dis_txtTransDescription.Text = "";
            dis_txtEffectiveDate.Text = "";
            dis_cbLoanTransActive.Checked = true;
            dis_cbLoanTransActive.Enabled = false;
            dis_cbAdjustment.Checked = false;
            dis_ddlFundName.SelectedIndex = -1;
            dis_spnVoid.InnerHtml = "";
            //forgiveness
            //fg_txtTransDate.Text = "";
            fg_txtTransAmount.Text = "";
            //fg_txtTransPrinciple.Text = "";
            fg_txtEffectiveDate.Text = "";
            fg_txtTransDescription.Text = "";
            fg_cbLoanTransActive.Checked = true;
            fg_cbLoanTransActive.Enabled = false;
            fg_cbAdjustment.Checked = false;
            fg_txtURL.Text = "";
            fg_ddlSubcategory.SelectedIndex = -1;

            //Transfer
            tr_txtTransDate.Text = "";
            tr_txtTransAmount.Text = "";
            tr_txtTransPrinciple.Text = "";
            tr_txtTransDescription.Text = "";
            //tr_txtTransProjTransfered.Text = "";
            //tr_txtTransProjConverted.Text = "";
            spnTransFrom.InnerHtml = "";
            //ddlProjTransferedFrom.SelectedIndex = -1;
            ddlProjTransferedTo.SelectedIndex = -1;

            tr_cbLoanTransActive.Checked = true;
            tr_cbLoanTransActive.Enabled = false;
            tr_cbAdjustment.Checked = false;
            tr_txtURL.Text = "";
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

            db_amount.Text = "";
            db_description.Text = "";
            db_EffectiveDate.Text = "";
            db_Active.Checked = true;
            db_Active.Enabled = false;
            db_cbAdjustment.Checked = false;
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
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                gvFundDetails.Columns[4].Visible = true;

                if (IsViewOnlyAccess())
                    gvFundDetails.Columns[4].Visible = false;
                 
            }
                

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
                    //e.Row.Cells[3].Controls[0].Visible = false;
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

        protected void cbAddNewLoanDetails_CheckedChanged(object sender, EventArgs e)
        {
            DataRow dr = LoanMaintenanceData.GetLatestLoanDetailsByLoanId(DataUtils.GetInt(hfLoanId.Value));

            if (dr != null)
            {
                btnAddLoanDetails.Visible = true;

                if (IsViewOnlyAccess())
                btnAddLoanDetails.Visible = false;

                btnAddLoanDetails.Text = "Add";
                ddlLegalDocs.Visible = true;
                spnLegalDoc.Visible = false;

                PopulateDropDown(ddlLoanCat, dr["LoanCat"].ToString());

                txtOriginalDateOfNote.Text = dr["NoteDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["NoteDate"].ToString()).ToShortDateString();
                txtOriginalDateOfNote.Enabled = true;

                txtMaturityDate.Text = dr["MaturityDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MaturityDate"].ToString()).ToShortDateString();
                txtIntrestRate.Text = dr["IntRate"].ToString();
                PopulateDropDown(ddlCompounded, dr["Compound"].ToString());
                PopulateDropDown(ddlPaymentFreq, dr["Frequency"].ToString());
                PopulateDropDown(ddlPaymentType, dr["PaymentType"].ToString());
                //PopulateDropDown(ddlLegalDocs, dr["LegalDoc"].ToString());
                txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();
                txtFileURL.Text = dr["URL"].ToString();
                txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                txtBoardApprovalDate.Text = dr["DocumentDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DocumentDate"].ToString()).ToShortDateString();

                txtDocumentDate_DC.Text = dr["DocumentDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DocumentDate"].ToString()).ToShortDateString(); ;
                txtEffectiveDate_DC.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                txtFileHoldLink_DC.Text = dr["URL"].ToString();
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
                txtOriginalDateOfNote.Enabled = false;

                txtMaturityDate.Text = dr["MaturityDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MaturityDate"].ToString()).ToShortDateString();
                txtIntrestRate.Text = dr["IntRate"].ToString();
                PopulateDropDown(ddlCompounded, dr["Compound"].ToString());
                PopulateDropDown(ddlPaymentFreq, dr["Frequency"].ToString());
                PopulateDropDown(ddlPaymentType, dr["PaymentType"].ToString());
                PopulateDropDown(ddlLegalDocs, dr["LegalDoc"].ToString());
                PopulateDropDown(ddlLegalDocs_dc, dr["LegalDoc"].ToString());
                txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();
                txtFileURL.Text = dr["URL"].ToString();
                txtEffectiveDate.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();

                cbLoanDetailActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
                //cbLoanDetailActive.Enabled = true;

                cbLoanDetailActive_ON.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                //cbLoanDetailActive_ON.Enabled = true;

                cbLoanDetailActive_DC.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                //cbLoanDetailActive_DC.Enabled = true;

                txtDocumentDate_DC.Text = dr["DocumentDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DocumentDate"].ToString()).ToShortDateString(); ;
                txtEffectiveDate_DC.Text = dr["EffectiveDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffectiveDate"].ToString()).ToShortDateString();
                txtFileHoldLink_DC.Text = dr["URL"].ToString();
                txtNoteAmountLoanDetails.Text = CommonHelper.myDollarFormat(dr["NoteAmt"].ToString());

                if (dr["LegalDoc"].ToString().ToLower() == "Discharge")
                    PopulateDCForm();
                else
                    PopulateNonDCForm();

                spnLegalDoc.Visible = false;
                ddlLegalDocs.Visible = true;
                if (dr["LegalDocDesc"].ToString().ToLower() == "db conversion")
                {
                    spnLegalDoc.Visible = true;
                    spnLegalDoc.InnerHtml = dr["LegalDocDesc"].ToString();
                    ddlLegalDocs.Visible = false;
                }
            }
        }

        public bool IsViewOnlyAccess()
        {
            DataTable dt = new DataTable();
            dt = UserSecurityData.GetUserFxnSecurity(GetUserId());

            foreach (DataRow row in dt.Rows)
            {
                if (row["FxnID"].ToString() == "37632")
                    return true;
            }
            return false;
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

        protected void gvRelatedProjects_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlLegalDocs_dc_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateDCForm();
        }

        private void PopulateDCForm()
        {
            if (ddlLegalDocs_dc.SelectedIndex != 0)
            {
                pnlLoanDetailsForm1.Visible = false;
                pnlLoanDetailsForm2.Visible = false;
                pnlLoanDetailsForm_ON.Visible = false;
                pnlLoanDetailsForm_DC.Visible = false;

                switch (ddlLegalDocs_dc.SelectedItem.ToString().ToLower())
                {
                    case "original note":
                        pnlLoanDetailsForm1.Visible = true;
                        pnlLoanDetailsForm_ON.Visible = true;
                        PopulateLegalDoc(ddlLegalDocs, "original note");
                        break;
                    case "modification":
                        pnlLoanDetailsForm1.Visible = true;
                        pnlLoanDetailsForm2.Visible = true;
                        PopulateLegalDoc(ddlLegalDocs, "modification");
                        break;
                    case "db conversion":
                        pnlLoanDetailsForm1.Visible = true;
                        pnlLoanDetailsForm2.Visible = true;
                        PopulateLegalDoc(ddlLegalDocs, "db conversion");
                        break;
                    case "discharge":
                        pnlLoanDetailsForm_DC.Visible = true;
                        PopulateLegalDoc(ddlLegalDocs_dc, "discharge");
                        break;
                }
            }
        }

        protected void ddlLegalDocs_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateNonDCForm();
        }

        private void PopulateNonDCForm()
        {
            if (ddlLegalDocs.SelectedIndex != 0)
            {
                //spnBoardApprovalDate.Visible = false;
                //txtBoardApprovalDate.Visible = false;
                pnlLoanDetailsForm1.Visible = false;
                pnlLoanDetailsForm2.Visible = false;
                pnlLoanDetailsForm_ON.Visible = false;
                pnlLoanDetailsForm_DC.Visible = false;

                switch (ddlLegalDocs.SelectedItem.ToString().ToLower())
                {
                    case "original note":
                        pnlLoanDetailsForm1.Visible = true;
                        pnlLoanDetailsForm_ON.Visible = true;
                        break;
                    case "modification":
                        pnlLoanDetailsForm1.Visible = true;
                        pnlLoanDetailsForm2.Visible = true;
                        break;
                    case "db conversion":
                        pnlLoanDetailsForm1.Visible = true;
                        pnlLoanDetailsForm2.Visible = true;
                        break;
                    case "discharge":
                        pnlLoanDetailsForm_DC.Visible = true;
                        PopulateLegalDoc(ddlLegalDocs_dc, "discharge");
                        break;
                }
            }
        }

        private void PopulateLegalDoc(DropDownList ddl, string seletedText)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (item.Text.ToLower().ToString() == seletedText)
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }

        protected void gvLoanTrans_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString());

                int loanTransId = Convert.ToInt32(((Label)gvLoanTrans.Rows[rowIndex].FindControl("lblLoanTransID")).Text);
                
                DataRow dr = LoanMaintenanceData.GetLoanTransByLoanID(loanTransId);
                BindLookUP(ddlTransType, 178);
                hfLoanTransID.Value = loanTransId.ToString();
                //Populate Edit Form
                PopulateLoanTransEditForm(dr);
                cbAddTransaction.Checked = true;
                btnAddTransaction.Visible = false;
                ddlTransType.Items.Remove(ddlTransType.Items.FindByValue("33090"));
            }
        }

        protected void gvLoanMaster_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString());
                int intLoanID = Convert.ToInt32(((Label)gvLoanMaster.Rows[rowIndex].FindControl("lblLoanID")).Text);
              
                DataRow drLoanMasterDetails = LoanMaintenanceData.GetLoanMasterDetailsByLoanID(intLoanID);

                //hfLoanId.Value = lblLoanID.Text;
                spnLoanId.InnerText = intLoanID.ToString();
                
                PopulateDropDown(ddltaxCreditPartner, drLoanMasterDetails["TaxCreditPartner"].ToString());
                
                spnNoteAmount.InnerHtml = CommonHelper.myDollarFormat(drLoanMasterDetails["NoteAmt"].ToString());
                
                PopulateDropDown(ddlFundGroup, drLoanMasterDetails["FundGroup"].ToString());
                
                PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
                
                btnLoanMaster.Visible = false;

                ddlNoteOwner.Items.Clear();
                ddlNoteOwner.Items.Insert(0, new ListItem(ddlPrimaryApplicant.SelectedItem.ToString(), ddlPrimaryApplicant.SelectedValue.ToString()));
                ddlNoteOwner.Items.Insert(1, new ListItem(ddltaxCreditPartner.SelectedItem.ToString(), ddltaxCreditPartner.SelectedValue.ToString()));
                PopulateDropDown(ddlNoteOwner, drLoanMasterDetails["NoteOwner"].ToString());

                cbLoanMasterActive.Checked = DataUtils.GetBool(drLoanMasterDetails["RowIsActive"].ToString()); ;
                cbLoanMasterActive.Enabled = false;

                cbAddLoanMaster.Checked = true;
            }
        }

        public string getCurrentBalance(string loanId)
        {
            int LoanId = DataUtils.GetInt(loanId);
            decimal balanceAmount =0;

            DataTable dtLoanSummary = null;
            dtLoanSummary = LoanMaintenanceData.GetLoanSummaryDetails(LoanId).Tables[0];

            if (dtLoanSummary.Rows.Count > 0)
                balanceAmount = DataUtils.GetDecimal(dtLoanSummary.Rows[0]["Balance"].ToString());

            return string.Format("{0:C}", balanceAmount);
        }

        private void UpdateLoanMasterCurrentBalanceGrid(string LoanID)
        {
                foreach (GridViewRow row in gvLoanMaster.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        RadioButton rbRow = (row.Cells[0].FindControl("rdBtnSelectLoan") as RadioButton);
                        if (rbRow.Checked)
                        {
                            Label lblCurrentBalance = (row.Cells[0].FindControl("lblCurrentBalance") as Label);
                            lblCurrentBalance.Text = getCurrentBalance(LoanID);
                            break;
                        }
                    }
                }
        }
    }
}