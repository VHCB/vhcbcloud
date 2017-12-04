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
    public partial class CashRefundnew : System.Web.UI.Page
    {
        string Pagename = "CashRefund";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;

            if (!IsPostBack)
            {

            }

            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtProjNum, "OnBlur");
            txtProjNum.Attributes.Add("onblur", onBlurScript);
        }

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtProjNum.UniqueID && args == "OnBlur")
            {
                if (txtProjNum.Text != "")
                {
                    hfProjId.Value = "";
                    hfProjId.Value = GetProjectID(txtProjNum.Text).ToString();

                    if (hfProjId.Value != "0")
                    {
                        DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(hfProjId.Value));

                        lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();

                        BindFinalizeTransGrid();
                    }
                    else
                    {
                        lblProjName.Text = "";
                        BindFinalizeTransGrid();
                    }
                }
            }
        }

        private int GetProjectID(string ProjectNum)
        {
            return ProjectMaintenanceData.GetProjectId(ProjectNum);
        }

        private void BindFinalizeTransGrid()
        {
            dvTransDetails.Visible = false;
            dvVoidSubmit.Visible = false;

            try
            {
                DataTable dt = FinancialTransactions.GetFinalizeTransactions(DataUtils.GetInt(hfProjId.Value));

                if (dt.Rows.Count > 0)
                {
                    dvFinalizedTrans.Visible = true;
                    gvFinalizedTrans.DataSource = dt;
                    gvFinalizedTrans.DataBind();
                    gvFinalizedTrans.Visible = true;
                }
                else
                {
                    dvFinalizedTrans.Visible = false;
                    LogMessage("No finalized disbursements exist for project");
                    gvFinalizedTrans.DataSource = null;
                    gvFinalizedTrans.DataBind();
                    gvFinalizedTrans.Visible = false;
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindFinalizeTransGrid", "", ex.Message);
            }
        }

        private void BindPCRTransDetails()
        {
            txtTransDate.Text = "";
            try
            {
                DataTable dtTranDetails = new DataTable();
                dtTranDetails = ProjectCheckRequestData.GetPCRTranDetails(this.hfTransId.Value);

                if (dtTranDetails.Rows.Count > 0)
                {
                    dvTransDetails.Visible = true;
                    gvTransDetails.DataSource = dtTranDetails;
                    gvTransDetails.DataBind();
                    dvVoidSubmit.Visible = true;
                }
                else
                {
                    dvTransDetails.Visible = false;
                    gvTransDetails.DataSource = null;
                    gvTransDetails.DataBind();
                    dvVoidSubmit.Visible = false;
                }
            }
            catch (Exception ex)
            {
                LogMessage(Pagename + ": BindPCRTransDetails: " + ex.Message);
                lblErrorMsg.Focus();
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

        protected void rdBtnSelectFinalizedTrans_CheckedChanged(object sender, EventArgs e)
        {
            SelectedFinalizeTranDetails objSelectedFinalizeTranDetails = GetSelectedFinalizeTransDetails(gvFinalizedTrans);
            hfTransId.Value = objSelectedFinalizeTranDetails.TransId.ToString();
            BindPCRTransDetails();
        }

        private SelectedFinalizeTranDetails GetSelectedFinalizeTransDetails(GridView gvFinalizedTrans)
        {
            SelectedFinalizeTranDetails objSelectedFinalizeTranDetails = new SelectedFinalizeTranDetails();

            for (int i = 0; i < gvFinalizedTrans.Rows.Count; i++)
            {
                RadioButton rbFinalizedTransRecord = (RadioButton)gvFinalizedTrans.Rows[i].Cells[0].FindControl("rdBtnSelectFinalizedTrans");

                if (rbFinalizedTransRecord != null)
                {
                    if (rbFinalizedTransRecord.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFinalizedTrans.Rows[i].Cells[0].FindControl("HiddenTransId");
                        // Label lblHomeOwnershipID = (Label)gvHOAddress.Rows[i].Cells[1].FindControl("lblHomeOwnershipID");

                        if (hf != null)
                        {
                            objSelectedFinalizeTranDetails.TransId = DataUtils.GetInt(hf.Value);
                            //objSelectedAddressRecordInfo.Building = DataUtils.GetInt(lblHomeOwnershipID.Text);
                        }
                        break;
                    }
                }
            }
            return objSelectedFinalizeTranDetails;
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectsByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjects("GetProjectsByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }

        protected void btnSubmitVoid_Click(object sender, EventArgs e)
        {
            try
            {
                FinancialTransactions.SubmitVoidTransaction(DataUtils.GetInt(hfTransId.Value));

                LogMessage("Successfully Void Check");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnSubmitVoid_Click", "", ex.Message);
            }
        }
    }

    public class SelectedFinalizeTranDetails
    {
        public int TransId { set; get; }
        // public int Building { set; get; }
    }
}