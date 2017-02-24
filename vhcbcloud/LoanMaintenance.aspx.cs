using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
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
                this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }
        private void BindControls()
        {
            BindLookUP(ddlLoanCat, 179);
            BindLookUP(ddlCompounded, 190);
            BindLookUP(ddlPaymentFreq, 191);
            BindLookUP(ddlPaymentType, 192);
            BindLookUP(ddlTransType, 178);

            BindLookUP(ad_ddlTransCompounding, 190);
            BindLookUP(ad_ddlTransPaymentFreq, 191);
            BindLookUP(ad_ddlTransPaymentType, 192);

            BindLookUP(nm_ddlTransCompounding, 190);
            BindLookUP(nm_ddlTransPaymentFreq, 191);
            BindLookUP(nm_ddlTransPaymentType, 192);

            BindLookUP(cap_ddlTransPaymentType, 192);
            BindLookUP(cr_ddlTransPaymentType, 192);

            BindLookUP(cv_ddlTransCompounding, 190);
            BindLookUP(cv_ddlTransPaymentFreq, 191);
            BindLookUP(cv_ddlTransPaymentType, 192);

            //BindPrimaryApplicants();
            BindFund(ddlFund);
            //BindFund(ddlNotesFund);
        }
        //private void BindPrimaryApplicants()
        //{
        //    try
        //    {
        //        ddlPrimaryApplicant.Items.Clear();
        //        ddlPrimaryApplicant.DataSource = ApplicantData.GetSortedApplicants();
        //        ddlPrimaryApplicant.DataValueField = "appnameid";
        //        ddlPrimaryApplicant.DataTextField = "Applicantname";
        //        ddlPrimaryApplicant.DataBind();
        //        ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
        //    }
        //}

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
            }
            else
            {
                //dvDetails.Visible = false;
                lblProjName.Visible = false;
                txtProjName.Visible = false;
            }
        }

        private void ClearLoanMasterForm()
        {
            txtDescriptor.Text = "";
            txtTaxCreditPartner.Text = "";
            txtNoteOwner.Text = "";
            txtNoteAmount.Text = "";
            ddlFund.SelectedIndex = -1;
            //ddlPrimaryApplicant.SelectedIndex = -1;
            txtPrimaryApplicant.Text = "";
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
                txtDescriptor.Text = drLoanMasterDetails["Descriptor"].ToString();
                txtTaxCreditPartner.Text = drLoanMasterDetails["TaxCreditPartner"].ToString();
                txtNoteOwner.Text = drLoanMasterDetails["NoteOwner"].ToString();
                txtPrimaryApplicant.Text = drLoanMasterDetails["ApplicantID"].ToString();
                //PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
                PopulateDropDown(ddlFund, drLoanMasterDetails["FundID"].ToString());
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
            decimal? Principal, decimal? Interest, string Description, int? TransferTo, int? ConvertFrom)
        {
            DateTime TransDate1 = TransDate ?? DateTime.MinValue;
            DateTime MatDate1 = MatDate ?? DateTime.MinValue;
            DateTime StartDate1 = StartDate ?? DateTime.MinValue;
            DateTime StopDate1 = StopDate ?? DateTime.MinValue;


            LoanMaintenanceData.AddLoanTransactions(LoanId, TransType, TransDate1, IntRate, Compound, Freq, PayType, MatDate1, StartDate1,
                Amount, StopDate1, Principal, Interest, Description, TransferTo, ConvertFrom);

            return true;
        }

        private bool UpdateLoanTransactions(int LoanTransId, int TransType, DateTime? TransDate, decimal? IntRate,
            int? Compound, int? Freq, int? PayType, DateTime? MatDate, DateTime? StartDate, decimal? Amount, DateTime? StopDate,
            decimal? Principal, decimal? Interest, string Description, int? TransferTo, int? ConvertFrom, bool RowIsActive)
        {
            DateTime TransDate1 = TransDate ?? DateTime.MinValue;
            DateTime MatDate1 = MatDate ?? DateTime.MinValue;
            DateTime StartDate1 = StartDate ?? DateTime.MinValue;
            DateTime StopDate1 = StopDate ?? DateTime.MinValue;

            LoanMaintenanceData.UpdateLoanTransactions(LoanTransId, TransType, TransDate1, IntRate, Compound, Freq, PayType, MatDate1, StartDate1,
                Amount, StopDate1, Principal, Interest, Description, TransferTo, ConvertFrom, RowIsActive);

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
            if (btnLoanMaster.Text == "Add")
            {
                LoanMaintenanceData.AddLoanMaster(DataUtils.GetInt(hfProjectId.Value), txtDescriptor.Text, txtTaxCreditPartner.Text,
                    txtNoteOwner.Text, DataUtils.GetDecimal(txtNoteAmount.Text), DataUtils.GetInt(ddlFund.SelectedValue.ToString()),
                    txtPrimaryApplicant.Text);
            }
            else
            {
                LoanMaintenanceData.UpdateLoanMaster(DataUtils.GetInt(hfLoanId.Value), txtDescriptor.Text, txtTaxCreditPartner.Text,
                    txtNoteOwner.Text, DataUtils.GetDecimal(txtNoteAmount.Text), DataUtils.GetInt(ddlFund.SelectedValue.ToString()),
                    txtPrimaryApplicant.Text, cbLoanMasterActive.Checked);

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
        }

        protected void gvProjectLoanDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddLoanDetails.Text = "Update";
                    cbAddNewLoanDetails.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[4].Controls[0].Visible = false;
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

                        txtWatchDate.Text = dr["WatchDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["WatchDate"].ToString()).ToShortDateString();

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
                if (btnAddLoanDetails.Text == "Add")
                {
                    LoanMaintenanceData.AddLoanDetail(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlLoanCat.SelectedValue.ToString()),
                        DataUtils.GetDate(txtOriginalDateOfNote.Text), DataUtils.GetDate(txtMaturityDate.Text),
                        DataUtils.GetDecimal(txtIntrestRate.Text),
                        DataUtils.GetInt(ddlCompounded.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentFreq.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentType.SelectedValue.ToString()),
                        DataUtils.GetDate(txtWatchDate.Text));
                    LogMessage("Loan details added successfully");
                }
                else
                {
                    LoanMaintenanceData.UpdateLoanDetail(DataUtils.GetInt(hfLoanDetailID.Value), DataUtils.GetInt(ddlLoanCat.SelectedValue.ToString()),
                        DataUtils.GetDate(txtOriginalDateOfNote.Text), DataUtils.GetDate(txtMaturityDate.Text),
                        DataUtils.GetDecimal(txtIntrestRate.Text),
                        DataUtils.GetInt(ddlCompounded.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentFreq.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlPaymentType.SelectedValue.ToString()),
                        DataUtils.GetDate(txtWatchDate.Text), cbLoanDetailActive.Checked);
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
            if (txtOriginalDateOfNote.Text.Trim() == "")
            {
                if (!DataUtils.IsDateTime(txtOriginalDateOfNote.Text.Trim()))
                {
                    LogMessage("Enter valid Original Date of Note");
                    txtOriginalDateOfNote.Focus();
                    return false;
                }
            }
            if (txtMaturityDate.Text.Trim() == "")
            {
                if (!DataUtils.IsDateTime(txtMaturityDate.Text.Trim()))
                {
                    LogMessage("Enter valid Final Maturity Date of Note");
                    txtMaturityDate.Focus();
                    return false;
                }
            }
            return true;
        }

        private void BindProjectLoanMasterGrid()
        {
            dvNewLoanDetailInfo.Visible = false;
            dvNewEvent.Visible = false;
            dvTransaction.Visible = false;
            dvNotes.Visible = false;

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
                        txtDescriptor.Text = drLoanMasterDetails["Descriptor"].ToString();
                        txtTaxCreditPartner.Text = drLoanMasterDetails["TaxCreditPartner"].ToString();
                        txtNoteOwner.Text = drLoanMasterDetails["NoteOwner"].ToString();
                        txtNoteAmount.Text = drLoanMasterDetails["NoteAmt"].ToString();
                        
                        txtPrimaryApplicant.Text = drLoanMasterDetails["Applicantname"].ToString();
                        //PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["AppNameID"].ToString());
                        PopulateDropDown(ddlFund, drLoanMasterDetails["FundID"].ToString());
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
            BindLoanMasterDetailsGrid();
            BindLoanEventsGrid();
            BindLoanNotesGrid();
            BindLoanTransGrid();
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
            if (btnAddNotes.Text == "Add")
            {
                LoanMaintenanceData.AddLoanNotes(DataUtils.GetInt(hfLoanId.Value), txtNotes.Text, txtFHL.Text);
                LogMessage("Loan Notes added successfully");
            }
            else
            {
                LoanMaintenanceData.UpdateLoanNotes(DataUtils.GetInt(hfLoanNoteID.Value), txtNotes.Text, txtFHL.Text,
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
            cap_ddlTransPaymentType.SelectedIndex = -1;
            cap_txtTransAmount.Text = "";
            cap_txtTransPrinciple.Text = "";
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
            tr_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
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
            fg_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            fg_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            fg_txtTransAmount.Text = dr["Amount"].ToString();
            fg_txtTransDescription.Text = dr["Description"].ToString();
            
            fg_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            fg_cbLoanTransActive.Enabled = true;
        }

        private void PopulateDisbursementForm(DataRow dr)
        {
            dis_txtTransPrinciple.Text = dr["Principal"] == DBNull.Value ? "" : dr["Principal"].ToString();
            dis_txtTransAmount.Text = dr["Amount"].ToString();
            dis_txtTransDescription.Text = dr["Description"].ToString();

            dis_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            dis_cbLoanTransActive.Enabled = true;
        }

        private void PopulateConversionForm(DataRow dr)
        {
            cv_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            cv_txtTransIntrestRate.Text = dr["IntRate"].ToString(); ;
            PopulateDropDown(cv_ddlTransCompounding, dr["Compound"].ToString());
            PopulateDropDown(cv_ddlTransPaymentType, dr["PayType"].ToString());
            PopulateDropDown(cv_ddlTransPaymentFreq, dr["Freq"].ToString());
            cv_txtTransStartDate.Text = dr["StartDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StartDate"].ToString()).ToShortDateString();
            cv_txtTransAmount.Text = dr["Amount"].ToString();
            cv_txtTransStopDate.Text = dr["StopDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StopDate"].ToString()).ToShortDateString();
            cv_txtTransPrinciple.Text = dr["Principal"].ToString();
            cv_txtTransIntrest.Text = dr["Interest"].ToString();
            cv_txtTransDescription.Text = dr["Description"].ToString();
            cv_txtTransProjConverted.Text = dr["ConvertFrom"].ToString();
            cv_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            cv_cbLoanTransActive.Enabled = true;
        }

        private void PopulateCashReceiptForm(DataRow dr)
        {
            cr_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            PopulateDropDown(cr_ddlTransPaymentType, dr["PayType"].ToString());
            cr_txtTransAmount.Text = dr["Amount"].ToString();
            cr_txtTransPrinciple.Text = dr["Principal"].ToString();
            cr_txtTransIntrest.Text = dr["Interest"].ToString();
            cr_txtTransDescription.Text = dr["Description"].ToString();
            cr_cbLoanTransActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString()); ;
            cr_cbLoanTransActive.Enabled = true;
        }

        private void PopulateAdjustmentForm(DataRow dr)
        {
            ad_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
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
            cap_txtTransDate.Text = dr["TransDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["TransDate"].ToString()).ToShortDateString();
            PopulateDropDown(cap_ddlTransPaymentType, dr["PayType"].ToString());
            cap_txtTransAmount.Text = dr["Amount"].ToString();
            cap_txtTransPrinciple.Text = dr["Principal"].ToString();
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
            if (btnAddTransaction.Text == "Add")
            {
                AddLoanTransaction();
            }
            else
            {
                UpdateTransaction();
            }
        }

        private void UpdateTransaction()
        {
            if (ddlTransType.SelectedItem.Text.ToLower() == "adjustment")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(ad_txtTransDate.Text), DataUtils.GetDecimal(ad_txtTransIntrestRate.Text), DataUtils.GetInt(ad_ddlTransCompounding.SelectedValue),
                    DataUtils.GetInt(ad_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(ad_ddlTransPaymentType.SelectedValue),
                    DataUtils.GetDate(ad_txtTransMaturityDate.Text), DataUtils.GetDate(ad_txtTransStartDate.Text), DataUtils.GetDecimal(ad_txtTransAmount.Text),
                    DataUtils.GetDate(ad_txtTransStopDate.Text), DataUtils.GetDecimal(ad_txtTransPrinciple.Text), DataUtils.GetDecimal(ad_txtTransIntrest.Text),
                    ad_txtTransDescription.Text, DataUtils.GetInt(ad_txtTransProjTransfered.Text), DataUtils.GetInt(ad_txtTransProjConverted.Text), 
                    ad_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(cap_txtTransDate.Text), null, null,
                    null, DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                    null, null, DataUtils.GetDecimal(cap_txtTransAmount.Text),
                    null, DataUtils.GetDecimal(cap_txtTransPrinciple.Text), null,
                    cap_txtTransDescription.Text, null, null, cap_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "cash receipt")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(cr_txtTransDate.Text), null, null,
                    null, DataUtils.GetInt(cr_ddlTransPaymentType.SelectedValue),
                    null, null, DataUtils.GetDecimal(cr_txtTransAmount.Text),
                    null, DataUtils.GetDecimal(cr_txtTransPrinciple.Text), DataUtils.GetInt(cr_txtTransIntrest.Text),
                    cr_txtTransDescription.Text, null, null, cr_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "conversion")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(cv_txtTransDate.Text), DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                    DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                    null, DataUtils.GetDate(cv_txtTransStartDate.Text), DataUtils.GetDecimal(cv_txtTransAmount.Text),
                    DataUtils.GetDate(cv_txtTransStopDate.Text), DataUtils.GetDecimal(cv_txtTransPrinciple.Text), DataUtils.GetDecimal(cv_txtTransIntrest.Text),
                    cv_txtTransDescription.Text, null, DataUtils.GetInt(cv_txtTransProjConverted.Text), cv_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    null, null, null,
                    null, null,
                    null, null, DataUtils.GetDecimal(dis_txtTransAmount.Text),
                    null, DataUtils.GetDecimal(dis_txtTransPrinciple.Text), null,
                    dis_txtTransDescription.Text, null, null, dis_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "forgiveness")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(fg_txtTransDate.Text), null, null,
                    null, null,
                    null, null, DataUtils.GetDecimal(fg_txtTransAmount.Text),
                    null, DataUtils.GetDecimal(fg_txtTransPrinciple.Text), null,
                    fg_txtTransDescription.Text, null, null, fg_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "transfer")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(tr_txtTransDate.Text), null, null,
                    null, null,
                    null, null, DataUtils.GetDecimal(tr_txtTransAmount.Text),
                    null, DataUtils.GetDecimal(tr_txtTransPrinciple.Text), null,
                    tr_txtTransDescription.Text, DataUtils.GetInt(tr_txtTransProjTransfered.Text), 
                    DataUtils.GetInt(tr_txtTransProjConverted.Text), tr_cbLoanTransActive.Checked);
            }
            else if (ddlTransType.SelectedItem.Text.ToLower() == "note modification")
            {
                UpdateLoanTransactions(DataUtils.GetInt(hfLoanTransID.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                    DataUtils.GetDate(nm_txtTransDate.Text), DataUtils.GetDecimal(nm_txtTransIntrestRate.Text), DataUtils.GetInt(nm_ddlTransCompounding.SelectedValue),
                    DataUtils.GetInt(nm_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(nm_ddlTransPaymentType.SelectedValue),
                    DataUtils.GetDate(nm_txtTransMaturityDate.Text), DataUtils.GetDate(nm_txtTransStartDate.Text), DataUtils.GetDecimal(nm_txtTransAmount.Text),
                    DataUtils.GetDate(nm_txtTransStopDate.Text), DataUtils.GetDecimal(nm_txtTransPrinciple.Text), DataUtils.GetDecimal(nm_txtTransIntrest.Text),
                    nm_txtTransDescription.Text, null, null, nm_cbLoanTransActive.Checked);
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
                        DataUtils.GetDate(ad_txtTransDate.Text), DataUtils.GetDecimal(ad_txtTransIntrestRate.Text), DataUtils.GetInt(ad_ddlTransCompounding.SelectedValue),
                        DataUtils.GetInt(ad_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(ad_ddlTransPaymentType.SelectedValue),
                        DataUtils.GetDate(ad_txtTransMaturityDate.Text), DataUtils.GetDate(ad_txtTransStartDate.Text), DataUtils.GetDecimal(ad_txtTransAmount.Text),
                        DataUtils.GetDate(ad_txtTransStopDate.Text), DataUtils.GetDecimal(ad_txtTransPrinciple.Text), DataUtils.GetDecimal(ad_txtTransIntrest.Text),
                        ad_txtTransDescription.Text, DataUtils.GetInt(ad_txtTransProjTransfered.Text), DataUtils.GetInt(ad_txtTransProjConverted.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(cap_txtTransDate.Text), null, null,
                        null, DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                        null, null, DataUtils.GetDecimal(cap_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(cap_txtTransPrinciple.Text), null,
                        cap_txtTransDescription.Text, null, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "cash receipt")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(cr_txtTransDate.Text), null, null,
                        null, DataUtils.GetInt(cr_ddlTransPaymentType.SelectedValue),
                        null, null, DataUtils.GetDecimal(cr_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(cr_txtTransPrinciple.Text), DataUtils.GetInt(cr_txtTransIntrest.Text),
                        cr_txtTransDescription.Text, null, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "conversion")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(cv_txtTransDate.Text), DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                        DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                        null, DataUtils.GetDate(cv_txtTransStartDate.Text), DataUtils.GetDecimal(cv_txtTransAmount.Text),
                        DataUtils.GetDate(cv_txtTransStopDate.Text), DataUtils.GetDecimal(cv_txtTransPrinciple.Text), DataUtils.GetDecimal(cv_txtTransIntrest.Text),
                        cv_txtTransDescription.Text, null, DataUtils.GetInt(cv_txtTransProjConverted.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "disbursement")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        null, null, null,
                        null, null,
                        null, null, DataUtils.GetDecimal(dis_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(dis_txtTransPrinciple.Text), null,
                        dis_txtTransDescription.Text, null, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "forgiveness")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(fg_txtTransDate.Text), null, null,
                        null, null,
                        null, null, DataUtils.GetDecimal(fg_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(fg_txtTransPrinciple.Text), null,
                        fg_txtTransDescription.Text, null, null);
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "transfer")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(tr_txtTransDate.Text), null, null,
                        null, null,
                        null, null, DataUtils.GetDecimal(tr_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(tr_txtTransPrinciple.Text), null,
                        tr_txtTransDescription.Text, DataUtils.GetInt(tr_txtTransProjTransfered.Text), DataUtils.GetInt(tr_txtTransProjConverted.Text));
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "note modification")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(nm_txtTransDate.Text), DataUtils.GetDecimal(nm_txtTransIntrestRate.Text), DataUtils.GetInt(nm_ddlTransCompounding.SelectedValue),
                        DataUtils.GetInt(nm_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(nm_ddlTransPaymentType.SelectedValue),
                        DataUtils.GetDate(nm_txtTransMaturityDate.Text), DataUtils.GetDate(nm_txtTransStartDate.Text), DataUtils.GetDecimal(nm_txtTransAmount.Text),
                        DataUtils.GetDate(nm_txtTransStopDate.Text), DataUtils.GetDecimal(nm_txtTransPrinciple.Text), DataUtils.GetDecimal(nm_txtTransIntrest.Text),
                        nm_txtTransDescription.Text, null, null);
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
            cap_ddlTransPaymentType.SelectedIndex = -1;
            cap_txtTransAmount.Text = "";
            cap_txtTransPrinciple.Text = "";
            cap_txtTransDescription.Text = "";
            cap_cbLoanTransActive.Checked = true;
            cap_cbLoanTransActive.Enabled = false;

            cr_txtTransDate.Text = "";
            cr_ddlTransPaymentType.SelectedIndex = -1;
            cr_txtTransAmount.Text = "";
            cr_txtTransPrinciple.Text = "";
            cr_txtTransIntrest.Text = "";
            cr_txtTransDescription.Text = "";
            cr_cbLoanTransActive.Checked = true;
            cr_cbLoanTransActive.Enabled = false;

            cv_txtTransDate.Text = "";
            cv_txtTransIntrestRate.Text = "";
            cv_ddlTransCompounding.SelectedIndex = -1;
            cv_ddlTransPaymentFreq.SelectedIndex = -1;
            cv_ddlTransPaymentType.SelectedIndex = -1;
            cv_txtTransStartDate.Text = "";
            cv_txtTransAmount.Text = "";
            cv_txtTransStopDate.Text = "";
            cv_txtTransPrinciple.Text = "";
            cv_txtTransIntrest.Text = "";
            cv_txtTransDescription.Text = "";
            cv_txtTransProjConverted.Text = "";
            cv_cbLoanTransActive.Checked = true;
            cv_cbLoanTransActive.Enabled = false;

            //Disbursement
            dis_txtTransAmount.Text = "";
            dis_txtTransPrinciple.Text = "";
            dis_txtTransDescription.Text = "";
            dis_cbLoanTransActive.Checked = true;
            dis_cbLoanTransActive.Enabled = false;

            //forgiveness
            fg_txtTransDate.Text = "";
            fg_txtTransAmount.Text = "";
            fg_txtTransPrinciple.Text = "";
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
    }
}