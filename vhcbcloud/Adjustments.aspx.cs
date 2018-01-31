using Microsoft.AspNet.Identity;
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
    public partial class Adjustments : System.Web.UI.Page
    {
        string Pagename = "Adjustment";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            txtTransDate.Text = DateTime.Now.ToShortDateString();
            if (!IsPostBack)
            {
                BindTransaction();
                BindFunds();
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
                ProjectSelectionChanged();
            }
        }

        private void ProjectSelectionChanged()
        {
            try
            {
                if (txtProjNum.Text != "")
                {
                    lblProjName.Text = "";
                    txtTransDate.Text = DateTime.Now.ToShortDateString();
                    ddlFundNum.SelectedIndex = -1;
                    ddlFundName.SelectedIndex = -1;
                    ddlTransType.SelectedIndex = -1;
                    txtAmt.Text = "";
                    txtComments.Text = "";

                    hfProjId.Value = "";
                    hfTransId.Value = "";
                    hfDetailId.Value = "";

                    btnSubmit.Text = "Submit";

                    DataTable dt = Project.GetProjects("GetProjectIdByProjNum", txtProjNum.Text.ToString());

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        hfProjId.Value = dt.Rows[0][0].ToString();
                        lblProjName.Text = dt.Rows[0][1].ToString();

                        DataTable dtFundInfo = FinancialTransactions.GetExistingAdjustmentByProjId(hfProjId.Value.ToString());

                        if (dtFundInfo.Rows.Count == 0)
                        {
                            rdBtnSelect.SelectedIndex = 0;
                        }
                        else
                        {
                            if (rdBtnSelect.SelectedIndex == 0)
                            {
                                rdBtnSelect.SelectedIndex = 1;
                            }
                            PopulateExistingData(dtFundInfo);
                        }
                    }
                }
                else
                {
                    hfProjId.Value = "";
                    hfTransId.Value = "";
                    hfDetailId.Value = "";
                }
                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
            }
            catch (Exception ex)
            {
                LogError(Pagename, "ProjectSelectionChanged", "", ex.Message);
            }
        }

        private void PopulateExistingData(DataTable dt)
        {
            this.hfTransId.Value = dt.Rows[0]["TransId"].ToString();
            this.hfDetailId.Value = dt.Rows[0]["DetailID"].ToString();

            txtTransDate.Text = dt.Rows[0]["TransDate"].ToString();

            PopulateDropDown(ddlFundNum, dt.Rows[0]["FundId"].ToString());
            FundNumSelected();
            PopulateDropDown(ddlTransType, dt.Rows[0]["FundTransType"].ToString());
            txtAmt.Text = dt.Rows[0]["DetailAmount"].ToString();
            txtComments.Text = dt.Rows[0]["Comments"].ToString();

            btnSubmit.Text = "Update";
            btnSubmit.Visible = true;
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

        protected void BindTransaction()
        {
            ddlTransaction.Items.Clear();
            ddlTransaction.Items.Insert(0, new ListItem("Select", "NA"));
            ddlTransaction.Items.Insert(1, new ListItem("Board", "Board"));
            ddlTransaction.Items.Insert(2, new ListItem("Cash", "Cash"));
        }

        protected void rdBtnSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void ddlTransaction_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlLKTransaction.Items.Clear();

            if (ddlTransaction.SelectedItem.Value == "Cash")
            {
                ddlLKTransaction.Items.Insert(0, new ListItem("Select", "NA"));
                ddlLKTransaction.Items.Insert(1, new ListItem("Disbursement", "236"));
                ddlLKTransaction.Items.Insert(2, new ListItem("Refund", "237"));
            }
            else
            {
                ddlLKTransaction.Items.Insert(0, new ListItem("Select", "NA"));
                ddlLKTransaction.Items.Insert(1, new ListItem("Assginment", "26552"));
                ddlLKTransaction.Items.Insert(2, new ListItem("Commitment", "238"));
                ddlLKTransaction.Items.Insert(3, new ListItem("Decommitment", "239"));
                ddlLKTransaction.Items.Insert(4, new ListItem("Reallocation", "240"));
            }

        }

        protected void ddlLKTransaction_SelectedIndexChanged(object sender, EventArgs e)
        {

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

        private void LogError(string pagename, string method, string message, string error)
        {
            dvMessage.Visible = true;
            if (message == "")
            {
                LogMessage(Pagename + ": " + method + ": Error Message: " + error);
            }
            else
                LogMessage(Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error);
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void BindFunds()
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetFundAccounts");
                //dtable = FinancialTransactions.GetCommittedFundAccounts(Convert.ToInt32(hfProjId.Value));
                ddlFundNum.DataSource = dtable;
                ddlFundNum.DataValueField = "fundid";
                ddlFundNum.DataTextField = "account";
                ddlFundNum.DataBind();
                ddlFundNum.Items.Insert(0, new ListItem("Select", "NA"));

                dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetFundNames");
                ddlFundName.DataSource = dtable;
                ddlFundName.DataValueField = "fundid";
                ddlFundName.DataTextField = "name";
                ddlFundName.DataBind();
                ddlFundName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlFundName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();
            if (ddlFundName.SelectedIndex != 0)
            {
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundName.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                ddlFundNum.SelectedValue = ddlFundName.SelectedValue;

                if (lblFundName.Text.ToLower().Contains("hopwa"))
                {
                    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                }
                else
                {
                    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                }
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "Description";
                ddlTransType.DataBind();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));


                if (DataUtils.GetInt(hfProjId.Value) != 0 &&  DataUtils.GetBool(dtable.Rows[0]["mitfund"].ToString()))
                {
                    lblUsePermit.Visible = true;
                    ddlUsePermit.Visible = true;
                    BindUsePermitNew(DataUtils.GetInt(hfProjId.Value), DataUtils.GetInt(ddlFundNum.SelectedItem.ToString()));
                }
                else
                {
                    ddlUsePermit.Items.Clear();
                    lblUsePermit.Visible = false;
                    ddlUsePermit.Visible = false;
                }
            }
            else
            {
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";

                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
            }
        }

        protected void BindUsePermitNew(int ProjectId, int FundId)
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetAllLandUsePermitForDecommitment(ProjectId, FundId);
                ddlUsePermit.DataSource = dtable;
                ddlUsePermit.DataValueField = "Act250FarmId";
                ddlUsePermit.DataTextField = "UsePermit";
                ddlUsePermit.DataBind();
                if (ddlUsePermit.Items.Count > 1)
                    ddlUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void ddlFundNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            FundNumSelected();
        }

        private void FundNumSelected()
        {
            DataTable dtable = new DataTable();
            if (ddlFundNum.SelectedIndex != 0)
            {
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundNum.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                ddlFundName.SelectedValue = ddlFundNum.SelectedValue;

                if (lblFundName.Text.ToLower().Contains("hopwa"))
                {
                    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                }
                else
                {
                    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                }

                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "Description";
                ddlTransType.DataBind();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                if (DataUtils.GetInt(hfProjId.Value) != 0 && DataUtils.GetBool(dtable.Rows[0]["mitfund"].ToString()))
                {
                    lblUsePermit.Visible = true;
                    ddlUsePermit.Visible = true;
                    BindUsePermitNew(DataUtils.GetInt(hfProjId.Value), DataUtils.GetInt(ddlFundNum.SelectedItem.ToString()));
                }
                else
                {
                    ddlUsePermit.Items.Clear();
                    lblUsePermit.Visible = false;
                    ddlUsePermit.Visible = false;
                }
            }
            else
            {
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";

                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlTransaction.SelectedIndex == 0)
                {
                    LogMessage("Select Board/Cash Transaction");
                    ddlTransaction.Focus();
                    return;
                }

                if (ddlLKTransaction.SelectedIndex == 0)
                {
                    LogMessage("Select Type (Lktransaction)");
                    ddlLKTransaction.Focus();
                    return;
                }

                if (txtProjNum.Text == "")
                {
                    LogMessage("Select Project#");
                    return;
                }
                if (txtTransDate.Text == "")
                {
                    LogMessage("Select Transaction Date");
                    txtTransDate.Focus();
                    return;
                }

                if (ddlFundName.SelectedIndex == 0)
                {
                    LogMessage("Select Fund");
                    ddlFundName.Focus();
                    return;
                }

                if (ddlTransType.SelectedIndex == 0)
                {
                    LogMessage("Select Fund Type");
                    ddlTransType.Focus();
                    return;
                }

                if (ddlUsePermit.Items.Count > 1 && ddlUsePermit.SelectedIndex == 0)
                {
                    LogMessage("Select Use Permit");
                    ddlUsePermit.Focus();
                    return;
                }

                decimal n;
                bool isDecimal = decimal.TryParse(txtAmt.Text.Trim(), out n);

                if (!isDecimal || Convert.ToDecimal(txtAmt.Text) == 0)
                {
                    LogMessage("Select a valid Disbursement amount");
                    txtAmt.Focus();
                    return;
                }

                if (btnSubmit.Text.ToLower() == "submit")
                {
                    FinancialTransactions.SubmitAdjustmentTransaction(DataUtils.GetInt(hfProjId.Value), DataUtils.GetDecimal(txtAmt.Text),
                        DataUtils.GetInt(ddlFundNum.SelectedValue), DataUtils.GetInt(ddlTransType.SelectedValue), txtComments.Text, GetUserId(), 
                        DataUtils.GetInt(ddlLKTransaction.SelectedValue), DataUtils.GetInt(ddlUsePermit.SelectedValue.ToString()));

                    LogMessage("Successfully Added Adjustment");

                    rdBtnSelect.SelectedIndex = 1;
                    btnSubmit.Text = "Update";
                }
                else
                {
                    FinancialTransactions.UpdaeAdjustmentTransaction(DataUtils.GetInt(hfTransId.Value), DataUtils.GetInt(hfDetailId.Value), 
                        DataUtils.GetInt(hfProjId.Value), DataUtils.GetDecimal(txtAmt.Text),
                        DataUtils.GetInt(ddlFundNum.SelectedValue), DataUtils.GetInt(ddlTransType.SelectedValue), txtComments.Text, GetUserId(), 
                        DataUtils.GetInt(ddlLKTransaction.SelectedValue), DataUtils.GetInt(ddlUsePermit.SelectedValue.ToString()));

                    LogMessage("Updated Adjustment");
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnSubmit_Click", "", ex.Message);
            }
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

        protected void ClearForm()
        {
            btnSubmit.Text = "Submit";
            txtProjNum.Text = "";
            lblProjName.Text = "";
            txtTransDate.Text = DateTime.Now.ToShortDateString();
            ddlFundNum.SelectedIndex = -1;
            ddlFundName.SelectedIndex = -1;
            ddlTransType.SelectedIndex = -1;
            txtAmt.Text = "";
            txtComments.Text = "";

            ddlUsePermit.Items.Clear();
            lblUsePermit.Visible = false;
            ddlUsePermit.Visible = false;
        }

        protected void ddlUsePermit_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}