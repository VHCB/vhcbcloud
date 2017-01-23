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

            BindLookUP(cap_ddlTransPaymentType, 192);
            BindLookUP(cr_ddlTransPaymentType, 192);

            BindLookUP(cv_ddlTransCompounding, 190);
            BindLookUP(cv_ddlTransPaymentFreq, 191);
            BindLookUP(cv_ddlTransPaymentType, 192);

            BindPrimaryApplicants();
            BindFund(ddlFund);
            //BindFund(ddlNotesFund);
        }
        private void BindPrimaryApplicants()
        {
            try
            {
                ddlPrimaryApplicant.Items.Clear();
                ddlPrimaryApplicant.DataSource = ApplicantData.GetSortedApplicants();
                ddlPrimaryApplicant.DataValueField = "appnameid";
                ddlPrimaryApplicant.DataTextField = "Applicantname";
                ddlPrimaryApplicant.DataBind();
                ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
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
            ddlFund.SelectedIndex = -1;
            ddlPrimaryApplicant.SelectedIndex = -1;
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
                PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
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

        protected void ddlTransType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //VisibleAll();
            dvCaptalizing.Visible = false;
            dvAdgustment.Visible = false;
            dvCR.Visible = false;
            dvConversion.Visible = false;

            if (ddlTransType.SelectedIndex != 0)
            {
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
                        //case "disbursement":
                        //    VisibleDisbursement();
                        //    break;
                        //case "forgiveness":
                        //    VisibleForgiveness();
                        //    break;
                        //case "note modification":
                        //    VisibleNoteModification();
                        //    break;
                        //case "transfer":
                        //    VisibleTransfer();
                        //    break;
                }


            }
        }

        //private void VisibleAll()
        //{
        //    spanTransactionDate.Visible = true;
        //    txtTransDate.Visible = true;
        //    spanIntrestRate.Visible = true;
        //    txtTransIntrestRate.Visible = true;
        //    spanCompounding.Visible = true;
        //    ddlTransCompounding.Visible = true;
        //    spanPaymentFreq.Visible = true;
        //    ddlTransPaymentFreq.Visible = true;
        //    spanPaymentType.Visible = true;
        //    ddlTransPaymentType.Visible = true;
        //    spanMaturityDate.Visible = true;
        //    txtTransMaturityDate.Visible = true;
        //    spanStartDate.Visible = true;
        //    txtTransStartDate.Visible = true;
        //    spanAmount.Visible = true;
        //    txtTransAmount.Visible = true;
        //    spanStopDate.Visible = true;
        //    txtTransStopDate.Visible = true;
        //    spanPrinciple.Visible = true;
        //    txtTransPrinciple.Visible = true;
        //    spanIntrest.Visible = true;
        //    txtTransIntrest.Visible = true;
        //    spanDescription.Visible = true;
        //    txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = true;
        //    txtTransProjTransfered.Visible = true;
        //    spanConverted.Visible = true;
        //    txtTransProjConverted.Visible = true;
        //}

        //private void VisibleCapitalizing()
        //{

        //    spanIntrestRate.Visible = false;
        //    txtTransIntrestRate.Visible = false;
        //    spanCompounding.Visible = false;
        //    ddlTransCompounding.Visible = false;
        //    spanPaymentFreq.Visible = false;
        //    ddlTransPaymentFreq.Visible = false;
        //    spanPaymentType.Visible = false;
        //    ddlTransPaymentType.Visible = false;

        //    spanMaturityDate.Visible = false;
        //    txtTransMaturityDate.Visible = false;
        //    spanStartDate.Visible = false;
        //    txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    spanStopDate.Visible = false;
        //    txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    spanIntrest.Visible = false;
        //    txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = false;
        //    txtTransProjTransfered.Visible = false;
        //    spanConverted.Visible = false;
        //    txtTransProjConverted.Visible = false;
        //}

        //private void VisibleCashReceipt()
        //{

        //    spanIntrestRate.Visible = false;
        //    txtTransIntrestRate.Visible = false;
        //    spanCompounding.Visible = false;
        //    ddlTransCompounding.Visible = false;
        //    spanPaymentFreq.Visible = false;
        //    ddlTransPaymentFreq.Visible = false;
        //    //spanPaymentType.Visible = false;
        //    //ddlTransPaymentType.Visible = false;

        //    spanMaturityDate.Visible = false;
        //    txtTransMaturityDate.Visible = false;
        //    spanStartDate.Visible = false;
        //    txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    spanStopDate.Visible = false;
        //    txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    //spanIntrest.Visible = false;
        //    //txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = false;
        //    txtTransProjTransfered.Visible = false;
        //    spanConverted.Visible = false;
        //    txtTransProjConverted.Visible = false;
        //}

        //private void VisibleConversion()
        //{

        //    //spanIntrestRate.Visible = false;
        //    //txtTransIntrestRate.Visible = false;
        //    //spanCompounding.Visible = false;
        //    //ddlTransCompounding.Visible = false;
        //    //spanPaymentFreq.Visible = false;
        //    //ddlTransPaymentFreq.Visible = false;
        //    //spanPaymentType.Visible = false;
        //    //ddlTransPaymentType.Visible = false;

        //    spanMaturityDate.Visible = false;
        //    txtTransMaturityDate.Visible = false;
        //    //spanStartDate.Visible = false;
        //    //txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    //spanStopDate.Visible = false;
        //    //txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    //spanIntrest.Visible = false;
        //    //txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = false;
        //    txtTransProjTransfered.Visible = false;
        //    //spanConverted.Visible = false;
        //    //txtTransProjConverted.Visible = false;
        //}

        //private void VisibleDisbursement()
        //{
        //    spanTransactionDate.Visible = false;
        //    txtTransDate.Visible = false;
        //    spanIntrestRate.Visible = false;
        //    txtTransIntrestRate.Visible = false;
        //    spanCompounding.Visible = false;
        //    ddlTransCompounding.Visible = false;
        //    spanPaymentFreq.Visible = false;
        //    ddlTransPaymentFreq.Visible = false;
        //    spanPaymentType.Visible = false;
        //    ddlTransPaymentType.Visible = false;

        //    spanMaturityDate.Visible = false;
        //    txtTransMaturityDate.Visible = false;
        //    spanStartDate.Visible = false;
        //    txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    spanStopDate.Visible = false;
        //    txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    spanIntrest.Visible = false;
        //    txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = false;
        //    txtTransProjTransfered.Visible = false;
        //    spanConverted.Visible = false;
        //    txtTransProjConverted.Visible = false;
        //}

        //private void VisibleForgiveness()
        //{
        //    //spanTransactionDate.Visible = false;
        //    //txtTransDate.Visible = false;
        //    spanIntrestRate.Visible = false;
        //    txtTransIntrestRate.Visible = false;
        //    spanCompounding.Visible = false;
        //    ddlTransCompounding.Visible = false;
        //    spanPaymentFreq.Visible = false;
        //    ddlTransPaymentFreq.Visible = false;
        //    spanPaymentType.Visible = false;
        //    ddlTransPaymentType.Visible = false;

        //    spanMaturityDate.Visible = false;
        //    txtTransMaturityDate.Visible = false;
        //    spanStartDate.Visible = false;
        //    txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    spanStopDate.Visible = false;
        //    txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    spanIntrest.Visible = false;
        //    txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = false;
        //    txtTransProjTransfered.Visible = false;
        //    spanConverted.Visible = false;
        //    txtTransProjConverted.Visible = false;
        //}

        //private void VisibleTransfer()
        //{
        //    //spanTransactionDate.Visible = false;
        //    //txtTransDate.Visible = false;
        //    spanIntrestRate.Visible = false;
        //    txtTransIntrestRate.Visible = false;
        //    spanCompounding.Visible = false;
        //    ddlTransCompounding.Visible = false;
        //    spanPaymentFreq.Visible = false;
        //    ddlTransPaymentFreq.Visible = false;
        //    spanPaymentType.Visible = false;
        //    ddlTransPaymentType.Visible = false;

        //    spanMaturityDate.Visible = false;
        //    txtTransMaturityDate.Visible = false;
        //    spanStartDate.Visible = false;
        //    txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    spanStopDate.Visible = false;
        //    txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    spanIntrest.Visible = false;
        //    txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    //spanProjTranf.Visible = false;
        //    //txtTransProjTransfered.Visible = false;
        //    //spanConverted.Visible = false;
        //    //txtTransProjConverted.Visible = false;
        //}

        //private void VisibleNoteModification()
        //{
        //    //spanTransactionDate.Visible = false;
        //    //txtTransDate.Visible = false;
        //    //spanIntrestRate.Visible = false;
        //    //txtTransIntrestRate.Visible = false;
        //    //spanCompounding.Visible = false;
        //    //ddlTransCompounding.Visible = false;
        //    //spanPaymentFreq.Visible = false;
        //    //ddlTransPaymentFreq.Visible = false;
        //    //spanPaymentType.Visible = false;
        //    //ddlTransPaymentType.Visible = false;

        //    //spanMaturityDate.Visible = false;
        //    //txtTransMaturityDate.Visible = false;
        //    //spanStartDate.Visible = false;
        //    //txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    //spanStopDate.Visible = false;
        //    //txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    //spanIntrest.Visible = false;
        //    //txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    spanProjTranf.Visible = false;
        //    txtTransProjTransfered.Visible = false;
        //    spanConverted.Visible = false;
        //    txtTransProjConverted.Visible = false;
        //}

        //private void VisibleAdjustment()
        //{
        //    //spanTransactionDate.Visible = false;
        //    //txtTransDate.Visible = false;
        //    //spanIntrestRate.Visible = false;
        //    //txtTransIntrestRate.Visible = false;
        //    //spanCompounding.Visible = false;
        //    //ddlTransCompounding.Visible = false;
        //    //spanPaymentFreq.Visible = false;
        //    //ddlTransPaymentFreq.Visible = false;
        //    //spanPaymentType.Visible = false;
        //    //ddlTransPaymentType.Visible = false;

        //    //spanMaturityDate.Visible = false;
        //    //txtTransMaturityDate.Visible = false;
        //    //spanStartDate.Visible = false;
        //    //txtTransStartDate.Visible = false;

        //    //spanAmount.Visible = true;
        //    //txtTransAmount.Visible = true;
        //    //spanStopDate.Visible = false;
        //    //txtTransStopDate.Visible = false;
        //    //spanPrinciple.Visible = true;
        //    //txtTransPrinciple.Visible = true;
        //    //spanIntrest.Visible = false;
        //    //txtTransIntrest.Visible = false;
        //    //spanDescription.Visible = true;
        //    //txtTransDescription.Visible = true;
        //    //spanProjTranf.Visible = false;
        //    //txtTransProjTransfered.Visible = false;
        //    //spanConverted.Visible = false;
        //    //txtTransProjConverted.Visible = false;
        //}

        protected void btnAddTransaction_Click(object sender, EventArgs e)
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

                    ddlTransType.SelectedIndex = -1;
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
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "capitalizing")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(cap_txtTransDate.Text), null, null,
                        null, DataUtils.GetInt(cap_ddlTransPaymentType.SelectedValue),
                        null, null, DataUtils.GetDecimal(cap_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(cap_txtTransPrinciple.Text), null,
                        cap_txtTransDescription.Text, null, null);

                    ddlTransType.SelectedIndex = -1;
                    cap_txtTransDate.Text = "";
                    cap_ddlTransPaymentType.SelectedIndex = -1;
                    cap_txtTransAmount.Text = "";
                    cap_txtTransPrinciple.Text = "";
                    cap_txtTransDescription.Text = "";
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "cash receipt")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(cr_txtTransDate.Text), null, null,
                        null, DataUtils.GetInt(cr_ddlTransPaymentType.SelectedValue),
                        null, null, DataUtils.GetDecimal(cr_txtTransAmount.Text),
                        null, DataUtils.GetDecimal(cr_txtTransPrinciple.Text), DataUtils.GetInt(cr_txtTransIntrest.Text),
                        cr_txtTransDescription.Text, null, null);

                    ddlTransType.SelectedIndex = -1;
                    cr_txtTransDate.Text = "";
                    cr_ddlTransPaymentType.SelectedIndex = -1;
                    cr_txtTransAmount.Text = "";
                    cr_txtTransPrinciple.Text = "";
                    cr_txtTransIntrest.Text = "";
                    cr_txtTransDescription.Text = "";
                }
                else if (ddlTransType.SelectedItem.Text.ToLower() == "conversion")
                {
                    IsSuccess = AddLoanTransactions(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlTransType.SelectedValue),
                        DataUtils.GetDate(cv_txtTransDate.Text), DataUtils.GetDecimal(cv_txtTransIntrestRate.Text), DataUtils.GetInt(cv_ddlTransCompounding.SelectedValue),
                        DataUtils.GetInt(cv_ddlTransPaymentFreq.SelectedValue), DataUtils.GetInt(cv_ddlTransPaymentType.SelectedValue),
                        null, DataUtils.GetDate(cv_txtTransStartDate.Text), DataUtils.GetDecimal(cv_txtTransAmount.Text),
                        DataUtils.GetDate(cv_txtTransStopDate.Text), DataUtils.GetDecimal(cv_txtTransPrinciple.Text), DataUtils.GetDecimal(cv_txtTransIntrest.Text),
                        cv_txtTransDescription.Text, null, DataUtils.GetInt(cv_txtTransProjConverted.Text));

                    ddlTransType.SelectedIndex = -1;
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
                }
                }

            if (IsSuccess)
                LogMessage("Transaction added successfully");

            cbAddTransaction.Checked = false;
        }

        private bool AddLoanTransactions(int LoanId, int TransType, DateTime TransDate, decimal? IntRate,
            int? Compound, int? Freq, int? PayType, DateTime? MatDate, DateTime? StartDate, decimal? Amount, DateTime? StopDate,
            decimal? Principal, decimal? Interest, string Description, int? TransferTo, int? ConvertFrom)
        {
            LoanMaintenanceData.AddLoanTransactions(LoanId, TransType, TransDate, IntRate, Compound, Freq, PayType, MatDate, StartDate,
                Amount, StopDate, Principal, Interest, Description, TransferTo, ConvertFrom);

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
                    txtNoteOwner.Text, DataUtils.GetInt(ddlFund.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()));
            }
            else
            {
                LoanMaintenanceData.UpdateLoanMaster(DataUtils.GetInt(hfLoanId.Value), txtDescriptor.Text, txtTaxCreditPartner.Text,
                    txtNoteOwner.Text, DataUtils.GetInt(ddlFund.SelectedValue.ToString()),
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
            txtNoteAmount.Text = "";
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
                        txtNoteAmount.Text = dr["NoteAmt"].ToString();
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
            if (btnAddLoanDetails.Text == "Add")
            {
                LoanMaintenanceData.AddLoanDetail(DataUtils.GetInt(hfLoanId.Value), DataUtils.GetInt(ddlLoanCat.SelectedValue.ToString()),
                    DataUtils.GetDate(txtOriginalDateOfNote.Text), DataUtils.GetDate(txtMaturityDate.Text),
                    DataUtils.GetDecimal(txtNoteAmount.Text), DataUtils.GetDecimal(txtIntrestRate.Text),
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
                    DataUtils.GetDecimal(txtNoteAmount.Text), DataUtils.GetDecimal(txtIntrestRate.Text),
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
                        PopulateDropDown(ddlPrimaryApplicant, drLoanMasterDetails["ApplicantID"].ToString());
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
            //hfSelectedBuilding.Value = objSelectedBldInfo.Building.ToString();
            dvNewLoanDetailInfo.Visible = true;
            dvNewEvent.Visible = true;
            dvTransaction.Visible = true;
            dvNotes.Visible = true;
            BindLoanMasterDetailsGrid();
            BindLoanEventsGrid();
            BindLoanNotesGrid();
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
                        //Label lblBuilding = (Label)gvBldgInfo.Rows[i].Cells[1].FindControl("lblBuilding");

                        if (hf != null)
                        {
                            objSelectedLoanMasterInfo.LoanID = DataUtils.GetInt(hf.Value);
                            //objSelectedLoanMasterInfo.Building = DataUtils.GetInt(lblBuilding.Text);
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
            public int Building { set; get; }
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
    }
}