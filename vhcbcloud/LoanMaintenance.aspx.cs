using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

            BindLookUP(ddlTransCompounding, 190);
            BindLookUP(ddlTransPaymentFreq, 191);
            BindLookUP(ddlTransPaymentType, 192);
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
                //ProjectSelectionChanged();
            }
        }
        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

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
            VisibleAll();
            if (ddlTransType.SelectedIndex != 0)
            {
                switch (ddlTransType.SelectedItem.ToString().ToLower())
                {
                    case "capitalizing":
                        VisibleCapitalizing();
                        break;
                    case "adjustment":
                        VisibleAdjustment();
                        break;
                    case "cash receipt":
                        VisibleCashReceipt();
                        break;
                    case "conversion":
                        VisibleConversion();
                        break;
                    case "disbursement":
                        VisibleDisbursement();
                        break;
                    case "forgiveness":
                        VisibleForgiveness();
                        break;
                    case "note modification":
                        VisibleNoteModification();
                        break;
                    case "transfer":
                        VisibleTransfer();
                        break;
                }


            }
        }

        private void VisibleAll()
        {
            spanTransactionDate.Visible = true;
            txtTransDate.Visible = true;
            spanIntrestRate.Visible = true;
            txtTransIntrestRate.Visible = true;
            spanCompounding.Visible = true;
            ddlTransCompounding.Visible = true;
            spanPaymentFreq.Visible = true;
            ddlTransPaymentFreq.Visible = true;
            spanPaymentType.Visible = true;
            ddlTransPaymentType.Visible = true;
            spanMaturityDate.Visible = true;
            txtTransMaturityDate.Visible = true;
            spanStartDate.Visible = true;
            txtTransStartDate.Visible = true;
            spanAmount.Visible = true;
            txtTransAmount.Visible = true;
            spanStopDate.Visible = true;
            txtTransStopDate.Visible = true;
            spanPrinciple.Visible = true;
            txtTransPrinciple.Visible = true;
            spanIntrest.Visible = true;
            txtTransIntrest.Visible = true;
            spanDescription.Visible = true;
            txtTransDescription.Visible = true;
            spanProjTranf.Visible = true;
            txtTransProjTransfered.Visible = true;
            spanConverted.Visible = true;
            txtTransProjConverted.Visible = true;
        }

        private void VisibleCapitalizing()
        {
            
            spanIntrestRate.Visible = false;
            txtTransIntrestRate.Visible = false;
            spanCompounding.Visible = false;
            ddlTransCompounding.Visible = false;
            spanPaymentFreq.Visible = false;
            ddlTransPaymentFreq.Visible = false;
            spanPaymentType.Visible = false;
            ddlTransPaymentType.Visible = false;

            spanMaturityDate.Visible = false;
            txtTransMaturityDate.Visible = false;
            spanStartDate.Visible = false;
            txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            spanStopDate.Visible = false;
            txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            spanIntrest.Visible = false;
            txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            spanProjTranf.Visible = false;
            txtTransProjTransfered.Visible = false;
            spanConverted.Visible = false;
            txtTransProjConverted.Visible = false;
        }

        private void VisibleCashReceipt()
        {

            spanIntrestRate.Visible = false;
            txtTransIntrestRate.Visible = false;
            spanCompounding.Visible = false;
            ddlTransCompounding.Visible = false;
            spanPaymentFreq.Visible = false;
            ddlTransPaymentFreq.Visible = false;
            //spanPaymentType.Visible = false;
            //ddlTransPaymentType.Visible = false;

            spanMaturityDate.Visible = false;
            txtTransMaturityDate.Visible = false;
            spanStartDate.Visible = false;
            txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            spanStopDate.Visible = false;
            txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            //spanIntrest.Visible = false;
            //txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            spanProjTranf.Visible = false;
            txtTransProjTransfered.Visible = false;
            spanConverted.Visible = false;
            txtTransProjConverted.Visible = false;
        }

        private void VisibleConversion()
        {

            //spanIntrestRate.Visible = false;
            //txtTransIntrestRate.Visible = false;
            //spanCompounding.Visible = false;
            //ddlTransCompounding.Visible = false;
            //spanPaymentFreq.Visible = false;
            //ddlTransPaymentFreq.Visible = false;
            //spanPaymentType.Visible = false;
            //ddlTransPaymentType.Visible = false;

            spanMaturityDate.Visible = false;
            txtTransMaturityDate.Visible = false;
            //spanStartDate.Visible = false;
            //txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            //spanStopDate.Visible = false;
            //txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            //spanIntrest.Visible = false;
            //txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            spanProjTranf.Visible = false;
            txtTransProjTransfered.Visible = false;
            //spanConverted.Visible = false;
            //txtTransProjConverted.Visible = false;
        }

        private void VisibleDisbursement()
        {
            spanTransactionDate.Visible = false;
            txtTransDate.Visible = false;
            spanIntrestRate.Visible = false;
            txtTransIntrestRate.Visible = false;
            spanCompounding.Visible = false;
            ddlTransCompounding.Visible = false;
            spanPaymentFreq.Visible = false;
            ddlTransPaymentFreq.Visible = false;
            spanPaymentType.Visible = false;
            ddlTransPaymentType.Visible = false;

            spanMaturityDate.Visible = false;
            txtTransMaturityDate.Visible = false;
            spanStartDate.Visible = false;
            txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            spanStopDate.Visible = false;
            txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            spanIntrest.Visible = false;
            txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            spanProjTranf.Visible = false;
            txtTransProjTransfered.Visible = false;
            spanConverted.Visible = false;
            txtTransProjConverted.Visible = false;
        }

        private void VisibleForgiveness()
        {
            //spanTransactionDate.Visible = false;
            //txtTransDate.Visible = false;
            spanIntrestRate.Visible = false;
            txtTransIntrestRate.Visible = false;
            spanCompounding.Visible = false;
            ddlTransCompounding.Visible = false;
            spanPaymentFreq.Visible = false;
            ddlTransPaymentFreq.Visible = false;
            spanPaymentType.Visible = false;
            ddlTransPaymentType.Visible = false;

            spanMaturityDate.Visible = false;
            txtTransMaturityDate.Visible = false;
            spanStartDate.Visible = false;
            txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            spanStopDate.Visible = false;
            txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            spanIntrest.Visible = false;
            txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            spanProjTranf.Visible = false;
            txtTransProjTransfered.Visible = false;
            spanConverted.Visible = false;
            txtTransProjConverted.Visible = false;
        }

        private void VisibleTransfer()
        {
            //spanTransactionDate.Visible = false;
            //txtTransDate.Visible = false;
            spanIntrestRate.Visible = false;
            txtTransIntrestRate.Visible = false;
            spanCompounding.Visible = false;
            ddlTransCompounding.Visible = false;
            spanPaymentFreq.Visible = false;
            ddlTransPaymentFreq.Visible = false;
            spanPaymentType.Visible = false;
            ddlTransPaymentType.Visible = false;

            spanMaturityDate.Visible = false;
            txtTransMaturityDate.Visible = false;
            spanStartDate.Visible = false;
            txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            spanStopDate.Visible = false;
            txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            spanIntrest.Visible = false;
            txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            //spanProjTranf.Visible = false;
            //txtTransProjTransfered.Visible = false;
            //spanConverted.Visible = false;
            //txtTransProjConverted.Visible = false;
        }

        private void VisibleNoteModification()
        {
            //spanTransactionDate.Visible = false;
            //txtTransDate.Visible = false;
            //spanIntrestRate.Visible = false;
            //txtTransIntrestRate.Visible = false;
            //spanCompounding.Visible = false;
            //ddlTransCompounding.Visible = false;
            //spanPaymentFreq.Visible = false;
            //ddlTransPaymentFreq.Visible = false;
            //spanPaymentType.Visible = false;
            //ddlTransPaymentType.Visible = false;

            //spanMaturityDate.Visible = false;
            //txtTransMaturityDate.Visible = false;
            //spanStartDate.Visible = false;
            //txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            //spanStopDate.Visible = false;
            //txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            //spanIntrest.Visible = false;
            //txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            spanProjTranf.Visible = false;
            txtTransProjTransfered.Visible = false;
            spanConverted.Visible = false;
            txtTransProjConverted.Visible = false;
        }

        private void VisibleAdjustment()
        {
            //spanTransactionDate.Visible = false;
            //txtTransDate.Visible = false;
            //spanIntrestRate.Visible = false;
            //txtTransIntrestRate.Visible = false;
            //spanCompounding.Visible = false;
            //ddlTransCompounding.Visible = false;
            //spanPaymentFreq.Visible = false;
            //ddlTransPaymentFreq.Visible = false;
            //spanPaymentType.Visible = false;
            //ddlTransPaymentType.Visible = false;

            //spanMaturityDate.Visible = false;
            //txtTransMaturityDate.Visible = false;
            //spanStartDate.Visible = false;
            //txtTransStartDate.Visible = false;

            //spanAmount.Visible = true;
            //txtTransAmount.Visible = true;
            //spanStopDate.Visible = false;
            //txtTransStopDate.Visible = false;
            //spanPrinciple.Visible = true;
            //txtTransPrinciple.Visible = true;
            //spanIntrest.Visible = false;
            //txtTransIntrest.Visible = false;
            //spanDescription.Visible = true;
            //txtTransDescription.Visible = true;
            //spanProjTranf.Visible = false;
            //txtTransProjTransfered.Visible = false;
            //spanConverted.Visible = false;
            //txtTransProjConverted.Visible = false;
        }

        protected void btnAddTransaction_Click(object sender, EventArgs e)
        {

        }

        protected void btnAddNotes_Click(object sender, EventArgs e)
        {

        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {

        }
    }
}