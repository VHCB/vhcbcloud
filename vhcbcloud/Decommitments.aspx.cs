
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class Decommitments : System.Web.UI.Page
    {
        DataTable dtProjects;
        private int TRANS_PENDING_STATUS = 261;
        private int BOARD_DECOMMITMENT = 239;
        private int ActiveOnly = 1;
        private string strLandUsePermit = "148";
        private object regex;

        /// <summary>
        /// Page load
        /// Check Page Access
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPageAccess();
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

        /// <summary>
        /// Project selection by filter
        /// </summary>
        /// <param name="prefixText"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetCommittedProjectsByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            //dt = Project.GetProjects("getCommittedProjectslistByFilter", prefixText);
            dt = Project.GetProjects("GetProjectsByFilter", prefixText);
            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }

        /// <summary>
        /// Get projects and project names
        /// </summary>
        /// <param name="prefixText"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetCommittedPendingProjectslistByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjects("getCommittedPendingDecommitmentProjectslistByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }

        /// <summary>
        /// Select decommitment radio
        /// Redirect to corresponding selected pages
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void rdBtnFinancial_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdBtnFinancial.SelectedIndex == 0)
                Response.Redirect("Commitments.aspx");
            else if (rdBtnFinancial.SelectedIndex == 1)
                Response.Redirect("Decommitments.aspx");
            else if (rdBtnFinancial.SelectedIndex == 2)
                Response.Redirect("Reallocations.aspx");
            else if (rdBtnFinancial.SelectedIndex == 3)
                Response.Redirect("Assignments.aspx");
            else
                Response.Redirect("CashRefund.aspx");
        }

        /// <summary>
        /// Populate Accunt number dropdown
        /// Populate Fund name dropdown
        /// </summary>
        protected void BindFundAccounts()
        {
            ddlAcctNum.DataSource = null;
            ddlAcctNum.DataBind();
            ddlFundName.DataSource = null;
            ddlFundName.DataBind();

            DataTable dtable = new DataTable();
            try
            {
                //dtable = FinancialTransactions.GetCommittedFundAccounts(Convert.ToInt32(hfProjId.Value));
                dtable = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value));
                ddlAcctNum.DataSource = dtable;
                ddlAcctNum.DataValueField = "fundid";
                ddlAcctNum.DataTextField = "account";
                ddlAcctNum.DataBind();
                ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {

            }
            try
            {
                dtable = new DataTable();
                dtable = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value));
                ddlFundName.DataSource = dtable;
                ddlFundName.DataValueField = "fundid";
                ddlFundName.DataTextField = "name";
                ddlFundName.DataBind();
                ddlFundName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {

            }
        }

        /// <summary>
        /// Clear Transaction details form
        /// </summary>
        private void ClearTransactionDetailForm()
        {
            lblFundName.Text = "";
            txtAmt.Text = "";
            lblUsePermit.Visible = false;
            ddlUsePermit.Visible = false;
            lblAvDetailFund.Text = "";
            try
            {
                ddlTransType.SelectedIndex = 0;
                ddlAcctNum.SelectedIndex = 0;
                ddlFundName.SelectedIndex = 0;
            }
            catch (Exception e)
            { }
        }

        /// <summary>
        /// Populate fund details by transaction id
        /// </summary>
        /// <param name="transId"></param>
        private void BindFundDetails(int transId)
        {
            try
            {
                BindFundAccounts();

                DataTable dtFundDet = new DataTable();
                dtFundDet = FinancialTransactions.GetCommitmentFundDetailsByProjectId(transId, BOARD_DECOMMITMENT, ActiveOnly);

                gvBCommit.DataSource = dtFundDet;
                gvBCommit.DataBind();

                decimal tranAmount = 0;
                decimal totFundAmt = 0;
                decimal totBalAmt = 0;

                if (dtFundDet.Rows.Count > 0)
                {
                    //tranAmount = Convert.ToDecimal(dtFundDet.Rows[0]["TransAmt"].ToString());
                    tranAmount = Convert.ToDecimal(this.hfTransAmt.Value);

                    Label lblTotAmt = (Label)gvBCommit.FooterRow.FindControl("lblFooterAmount");
                    Label lblBalAmt = (Label)gvBCommit.FooterRow.FindControl("lblFooterBalance");

                    if (dtFundDet.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtFundDet.Rows.Count; i++)
                        {
                            totFundAmt += Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());
                        }
                    }

                    totBalAmt = tranAmount + (totFundAmt);

                    hfBalAmt.Value = (-totBalAmt).ToString();

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                    gvBCommit.Columns[0].Visible = false;
                    gvBCommit.FooterRow.Visible = true;
                    lblTransDetHeader.Text = "Transaction Detail";

                    if (totBalAmt == 0)
                    {
                        //pnlTranDetails.Visible = false;

                        tblFundDet.Visible = false;
                        btnDecommitmentSubmit.Visible = false;
                        CommonHelper.DisableButton(btnDecommitmentSubmit);
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        btnNewTransaction.Visible = true;
                        if (rdBtnSelection.SelectedIndex == 0)
                        {
                            lblProjName.Text = "";
                            lblGrantee.Text = "";
                        }
                    }
                    else
                    {
                        tblFundDet.Visible = true;
                        btnDecommitmentSubmit.Visible = true;
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                        btnNewTransaction.Visible = false;
                    }

                    if (lblBalAmt.Text != "$0.00")
                        lblErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                }
                else
                {
                    tblFundDet.Visible = true;
                    btnDecommitmentSubmit.Visible = true;
                    CommonHelper.DisableButton(btnTransactionSubmit);
                    CommonHelper.EnableButton(btnDecommitmentSubmit);
                    btnNewTransaction.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        ///  Get Transaction Id
        /// </summary>
        /// <returns></returns>
        private int GetTransId()
        {
            if (hfTransId.Value.ToString() == "")
            {
                return 0;
            }
            else
                return Convert.ToInt32(hfTransId.Value);
        }

        protected void rdBtnSelectTransDetail_CheckedChanged(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// DeCommitment Submit click
        /// Verify available amount
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDecommitmentSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string str = txtAmt.Text;
                string tmp = Regex.Replace(str, "[^0-9a-zA-Z.]+", "");
                txtAmt.Text = tmp.ToString();

                lblErrorMsg.Text = "";
                btnNewTransaction.Visible = false;
                if (ddlAcctNum.Items.Count > 1 && ddlAcctNum.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Select Account to add new transaction detail";
                    ddlAcctNum.Focus();
                    return;
                }
                else if (ddlTransType.Items.Count > 1 && ddlTransType.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Select a Transaction type";
                    ddlTransType.Focus();
                    return;
                }
                else if (txtAmt.Text.Trim() == "")
                {
                    lblErrorMsg.Text = "Select a valid transaction amount";
                    txtAmt.Focus();
                    return;
                }
                else if (txtAmt.Text.Trim() != "")
                {
                    decimal n;
                    bool IsDecimal = decimal.TryParse(txtAmt.Text.Trim(), out n);

                    if (!IsDecimal || Convert.ToDecimal(txtAmt.Text) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid transaction amount";
                        txtAmt.Focus();
                        return;
                    }
                }

                decimal currentTranAmount = 0;
                decimal currentTranFudAmount = 0;
                decimal currentBalAmount = 0;

                currentTranAmount = -Convert.ToDecimal(hfTransAmt.Value);
                currentTranFudAmount = Convert.ToDecimal(txtAmt.Text);
                currentBalAmount = -Convert.ToDecimal(hfBalAmt.Value);

                hfTransId.Value = GetTransId().ToString();
                if (hfTransId.Value != null)
                {
                    int transId = Convert.ToInt32(hfTransId.Value);

                    if (currentBalAmount == 0 && gvBCommit.Rows.Count > 0)
                    {
                        lblErrorMsg.Text = "This transaction details are all set. No more funds allowed to add for the transaction.";
                        ClearTransactionDetailForm();
                        CommonHelper.DisableButton(btnDecommitmentSubmit);
                        CommonHelper.EnableButton(btnTransactionSubmit);
                        return;
                    }
                    else if (currentTranFudAmount > (currentBalAmount < 0 ? -currentBalAmount : currentBalAmount))
                    {
                        lblErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                        return;
                    }
                    else if (FinancialTransactions.IsDuplicateFundDetailPerTransaction(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                        Convert.ToInt32(ddlTransType.SelectedValue.ToString()), ddlUsePermit.SelectedIndex == 0 ? "" : ddlUsePermit.SelectedValue.ToString()))
                    {
                        //lblErrorMsg.Text = "Same fund and same transaction type is already submitted for this transaction. Please select different selection";
                        lblErrorMsg.Text = "Same transaction already exist. Please select different selection";
                        return;
                    }
                    else
                    {
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                    }

                    //if (ddlAcctNum.SelectedItem.ToString() == "420" || ddlAcctNum.SelectedItem.ToString() == "415")
                    if (ddlUsePermit.Items.Count > 1 && ddlUsePermit.SelectedIndex == 0)
                    {
                        lblErrorMsg.Text = "Select Use Permit";
                        ddlUsePermit.Focus();
                        return;
                    }

                    DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundAmount(Convert.ToInt32(hfProjId.Value),
                               DataUtils.GetInt(ddlAcctNum.SelectedValue.ToString()),
                               DataUtils.GetInt(ddlTransType.SelectedValue.ToString()),
                               ddlUsePermit.SelectedValue.ToString());

                    if (dtAvailFunds != null && dtAvailFunds.Rows.Count > 0)
                    {
                        if (Convert.ToDecimal(txtAmt.Text) > Convert.ToDecimal(dtAvailFunds.Rows[0]["Balanced"].ToString()))
                        {
                            lblErrorMsg.Text = "Detail amount can not be more than available funds : " + CommonHelper.myDollarFormat(dtAvailFunds.Rows[0]["Balanced"].ToString()) + " for the selected Fund. ";// However the transaction is still added.";
                            return;
                        }
                    }
                    else
                    {
                        lblErrorMsg.Text = "Detail amount can not be more than available funds : " + CommonHelper.myDollarFormat("0.00") + " for the selected Fund. ";
                        return;
                    }

                    DataTable dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundName.SelectedValue.ToString()));
                    //if (ddlAcctNum.SelectedValue.ToString() == strLandUsePermit)
                    if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        //WO45 following code deleted
                        //decimal mitigationFundBalance = FinancialTransactions.Act250MitigationFundBalance(DataUtils.GetInt(ddlUsePermit.SelectedValue.ToString()));

                        //if (Convert.ToDecimal(txtAmt.Text) > mitigationFundBalance)
                        //{
                        //    lblErrorMsg.Text = "Permit " + ddlUsePermit.SelectedItem.ToString() + " does not have available funds ";
                        //    return;
                        //}

                        FinancialTransactions.AddDeCommitmentTransDetailsWithLandPermit(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                        //Convert.ToInt32(ddlTransType.SelectedValue.ToString()), Convert.ToInt32(hfProjId.Value), -currentTranFudAmount,
                        Convert.ToInt32(ddlTransType.SelectedValue.ToString()), Convert.ToInt32(hfProjId.Value), currentTranFudAmount,
                        ddlUsePermit.SelectedItem.Text, ddlUsePermit.SelectedValue.ToString());
                    }
                    else
                        FinancialTransactions.AddDeCommitmentTransDetails(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                            //Convert.ToInt32(ddlTransType.SelectedValue.ToString()), Convert.ToInt32(hfProjId.Value), -currentTranFudAmount);
                            Convert.ToInt32(ddlTransType.SelectedValue.ToString()), Convert.ToInt32(hfProjId.Value), currentTranFudAmount);



                    BindFundDetails(transId);
                    ClearTransactionDetailForm();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Submit Transaction details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnTransactionSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string str = txtTotAmt.Text;
                string tmp = Regex.Replace(str, "[^0-9a-zA-Z.]+", "");
                txtTotAmt.Text = tmp.ToString();

                if (txtProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Select Project to add new transaction";
                    txtProjNum.Focus();
                    return;
                }

                else if (txtTotAmt.Text.Trim() == "")
                {
                    lblErrorMsg.Text = "Select a valid transaction amount";
                    txtTotAmt.Focus();
                    return;
                }
                decimal n;
                bool isNumeric = decimal.TryParse(txtTotAmt.Text.Trim(), out n);
                if (!isNumeric)
                {
                    lblErrorMsg.Text = "Must enter numbers in Total Amount";
                    return;
                }
                if (Convert.ToDecimal(txtTotAmt.Text.Trim()) <= 0)
                {
                    lblErrorMsg.Text = "Select a valid transaction amount";
                    return;
                }
                //DataTable dtCommitFund = FinancialTransactions.GetCommittedFundPerProject(txtProjNum.Text);
                //if (dtCommitFund != null)
                //    if (dtCommitFund.Rows.Count > 0)
                //        if (Convert.ToDecimal(dtCommitFund.Rows[0]["availFunds"].ToString()) < Convert.ToDecimal(txtTotAmt.Text.Trim()))
                //        {
                //            lblErrorMsg.Text = "Decommitted amount can not be more than available funds : " + CommonHelper.myDollarFormat(dtCommitFund.Rows[0]["availFunds"].ToString()) + " for the selected project";
                //            return;
                //        }

                if (txtTotAmt.Text.Trim() != "")
                {
                    bool isDecimal = decimal.TryParse(txtTotAmt.Text.Trim(), out n);

                    if (!isDecimal || Convert.ToDecimal(txtTotAmt.Text) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid decommitment amount";
                        txtTotAmt.Focus();
                        return;
                    }
                    bool availFunds = decimal.TryParse(lblAvailFund.Text.Trim(), out n);
                    if (!availFunds || Convert.ToDecimal(txtTotAmt.Text) > Convert.ToDecimal(lblAvailFund.Text))
                    {
                        if (!availFunds)
                            lblErrorMsg.Text = "Decommitment amount can't be more than available funds (" + CommonHelper.myDollarFormat(0) + ") for the selected project";
                        else
                            lblErrorMsg.Text = "Decommitment amount can't be more than available funds (" + CommonHelper.myDollarFormat(lblAvailFund.Text) + ") for the selected project";

                        txtTotAmt.Focus();
                        return;
                    }
                }

                if (txtTransDate.Text == "")
                {
                    lblErrorMsg.Text = "Please enter transaction date";
                    txtTransDate.Focus();
                    return;
                }

                DateTime AcctEffectiveDate = FinancialTransactions.GetSetupDate();

                if (AcctEffectiveDate > Convert.ToDateTime(txtTransDate.Text))
                {
                    lblErrorMsg.Text = "Trans date should not be lessthan Acct Effective Date " + AcctEffectiveDate.ToShortDateString();
                    txtTransDate.Focus();
                    return;
                }

                lblErrorMsg.Text = "";
                decimal TransAmount = Convert.ToDecimal(txtTotAmt.Text);

                //this.hfTransAmt.Value = (-TransAmount).ToString();
                //this.hfBalAmt.Value = (-TransAmount).ToString();

                this.hfTransAmt.Value = (TransAmount).ToString();
                this.hfBalAmt.Value = (TransAmount).ToString();

                //if (pnlTranDetails.Visible)
                //    ClearTransactionDetailForm();

                gvBCommit.DataSource = null;
                gvBCommit.DataBind();

                pnlTranDetails.Visible = true;
                tblFundDet.Visible = true;
                btnDecommitmentSubmit.Visible = true;
                ClearTransactionDetailForm();

                CommonHelper.EnableButton(btnDecommitmentSubmit);
                CommonHelper.DisableButton(btnTransactionSubmit);

                int? granteeId = null;
                if (hfGrantee.Value != "")
                {
                    granteeId = Convert.ToInt32(hfGrantee.Value);
                }

                DataTable dtTrans = FinancialTransactions.AddBoardFinancialTransaction(Convert.ToInt32(hfProjId.Value), Convert.ToDateTime(txtTransDate.Text),
                    -TransAmount, granteeId, rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment",
                    //TransAmount, granteeId, rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment",
                    TRANS_PENDING_STATUS, GetUserId());

                gvPTrans.DataSource = dtTrans;
                gvPTrans.DataBind();

                hfTransId.Value = dtTrans.Rows[0]["transid"].ToString();
                BindTransGrid(GetTransId());
                //txtTransDate.Text = DateTime.Now.ToShortDateString();
                txtTotAmt.Text = "";

                CommonHelper.EnableButton(btnDecommitmentSubmit);
                CommonHelper.DisableButton(btnTransactionSubmit);
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Get UserId
        /// </summary>
        /// <returns></returns>
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

        /// <summary>
        /// When Radio button selected clear form details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            //lblAvailVisibleFund.Text = "";
            ClearTransactionDetailForm();
            GetSelectedTransId(gvPTrans);
            BindFundDetails(GetTransId());
            pnlTranDetails.Visible = true;
        }

        /// <summary>
        /// Get selected Trans details
        /// </summary>
        /// <param name="gvFGM"></param>
        private void GetSelectedTransId(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rbGInfo = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rbGInfo != null)
                {
                    if (rbGInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedTransId"] = hf.Value;
                            hfTransId.Value = hf.Value;
                        }
                        HiddenField hfAmt = (HiddenField)gvFGM.Rows[i].Cells[2].FindControl("HiddenField2");
                        if (hfAmt != null)
                        {
                            var Amount = -DataUtils.GetDecimal(hfAmt.Value);
                            ViewState["TransAmt"] = Amount;
                            hfTransAmt.Value = Amount.ToString();
                            hfBalAmt.Value = Amount.ToString();
                        }
                        break;
                    }
                }
            }
        }

        /// <summary>
        /// Bind Transacton details
        /// </summary>
        /// <param name="TransId"></param>
        private void BindTransGrid(int TransId)
        {
            try
            {
                if (cbActiveOnly.Checked)
                    ActiveOnly = 1;
                else
                    ActiveOnly = 0;
                gvPTrans.DataSource = null;
                gvPTrans.DataBind();

                DataTable dtTrans = null;
                if (rdBtnSelection.SelectedIndex == 0)
                {
                    dtTrans = FinancialTransactions.GetFinancialTransByTransId(TransId, ActiveOnly);
                    gvPTrans.DataSource = dtTrans;
                    gvPTrans.DataBind();
                }
                else
                {
                    dtTrans = FinancialTransactions.GetFinancialTransByProjId(Convert.ToInt32(hfProjId.Value), ActiveOnly, BOARD_DECOMMITMENT);
                    gvPTrans.DataSource = dtTrans;
                    gvPTrans.DataBind();
                }
                if (dtTrans.Rows.Count > 0)
                    CommonHelper.DisableButton(btnTransactionSubmit);
                else
                {
                    CommonHelper.EnableButton(btnTransactionSubmit);
                    btnNewTransaction.Visible = false;
                    pnlTranDetails.Visible = false;
                }

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Bind Fund Detaisl
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBCommit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBCommit.EditIndex = -1;
            BindFundDetails(GetTransId());
        }

        /// <summary>
        /// Bind Fund details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBCommit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBCommit.EditIndex = e.NewEditIndex;
            BindFundDetails(GetTransId());
            if (btnNewTransaction.Visible == true)
            {
                btnNewTransaction.Visible = false;
            }
        }

        /// <summary>
        /// DeCommitment details updating
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBCommit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                if (((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAmount")).Text.Trim() != "")
                {
                    decimal n;
                    bool isNumeric = decimal.TryParse(((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAmount")).Text.Trim(), out n);

                    if (!isNumeric || Convert.ToDecimal(((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAmount")).Text.Trim()) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid transaction amount";
                        ((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAmount")).Focus();
                        return;
                    }
                }

                decimal amount = Convert.ToDecimal(((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAmount")).Text);
                int transType = Convert.ToInt32(((DropDownList)gvBCommit.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                int detailId = Convert.ToInt32(((Label)gvBCommit.Rows[rowIndex].FindControl("lblDetId")).Text);
                int AcctNum = Convert.ToInt32(((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAcctNum")).Text);
                
                decimal old_amount = -Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                decimal bal_amount = -Convert.ToDecimal(hfBalAmt.Value);
                decimal allowed_amount = old_amount + bal_amount;

                DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundAmount(Convert.ToInt32(hfProjId.Value),
                              AcctNum,
                              transType,
                              "");

                if (dtAvailFunds != null && dtAvailFunds.Rows.Count > 0)
                {
                    if (amount > Convert.ToDecimal(dtAvailFunds.Rows[0]["Balanced"].ToString()))
                    {
                        lblErrorMsg.Text = "Detail amount can not be more than available funds : " + CommonHelper.myDollarFormat(dtAvailFunds.Rows[0]["Balanced"].ToString()) + " for the selected Fund. ";// However the transaction is still added.";
                        return;
                    }
                }
                else
                {
                    lblErrorMsg.Text = "Detail amount can not be more than available funds : " + CommonHelper.myDollarFormat("0.00") + " for the selected Fund. ";
                    return;
                }

                if (amount == allowed_amount)
                {
                    lblErrorMsg.Text = "Transaction is complete, more funds not allowed";
                    CommonHelper.DisableButton(btnDecommitmentSubmit);
                    CommonHelper.EnableButton(btnTransactionSubmit);
                }
                else if (amount > allowed_amount)
                {
                    lblErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                    CommonHelper.DisableButton(btnTransactionSubmit);
                    CommonHelper.EnableButton(btnDecommitmentSubmit);
                    return;
                }
                else if (amount < allowed_amount)
                {
                    CommonHelper.DisableButton(btnTransactionSubmit);
                    CommonHelper.EnableButton(btnDecommitmentSubmit);

                    if (!btnDecommitmentSubmit.Enabled)
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                }

                FinancialTransactions.UpdateTransDetails(detailId, transType, -amount);

                gvBCommit.EditIndex = -1;
                BindFundDetails(GetTransId());
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        /// <summary>
        /// DeCommitment details setting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBCommit_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlTrans = (e.Row.FindControl("ddlTransType") as DropDownList);
                    TextBox txtTransType = (e.Row.FindControl("txtTransType") as TextBox);
                    if (txtTransType != null)
                    {
                        DataTable dtable = new DataTable();
                        dtable = FinancialTransactions.GetLookupDetailsByName("LkTransType");
                        ddlTrans.DataSource = dtable;
                        ddlTrans.DataValueField = "typeid";
                        ddlTrans.DataTextField = "Description";
                        ddlTrans.DataBind();
                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlTrans.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtTransType.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlTrans.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

            }

        }

        /// <summary>
        /// Set hidden project value
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void hdnCommitedProjValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();
            if (rdBtnSelection.SelectedIndex > 0)
            {
                if (txtCommitedProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }
            else
            {
                if (txtProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }

            ///populate the form based on retrieved data
            getDetails(dt);
        }

        /// <summary>
        /// Project Number changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void hdnValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();
            if (rdBtnSelection.SelectedIndex > 0)
            {
                if (txtCommitedProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }
            else
            {
                if (txtProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }

            ///populate the form based on retrieved data
            getDetails(dt);
        }
        
        /// <summary>
        /// Get Available funds
        /// </summary>
        /// <param name="dt"></param>
        private void getDetails(DataTable dt)
        {
            try
            {
                lblAvailFund.Text = "";
                lblAvailVisibleFund.Text = "";

                if (dt.Rows.Count != 0)
                {
                    hfProjId.Value = dt.Rows[0][0].ToString();

                    DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundAmountByProjectId(Convert.ToInt32(hfProjId.Value));

                    if (dtAvailFunds != null && dtAvailFunds.Rows.Count > 0 && dtAvailFunds.Rows[0]["Balanced"].ToString() != "")
                    {
                        lblAvailFund.Text = Convert.ToDecimal(dtAvailFunds.Rows[0]["Balanced"].ToString()).ToString("#.##");
                        lblAvailVisibleFund.Text = CommonHelper.myDollarFormat(dtAvailFunds.Rows[0]["Balanced"].ToString());
                    }
                    else
                    {
                        lblAvailFund.Text = "0.00";
                        lblAvailVisibleFund.Text = "0.00";
                    }


                    //DataRow dr = ProjectCheckRequestData.GetAvailableFundsByProject(int.Parse(hfProjId.Value));

                    //if (dr != null)
                    //    if (Convert.ToDecimal(dr["availFund"].ToString()) > 0)
                    //    {
                    //        lblAvailFund.Text = Convert.ToDecimal(dr["availFund"].ToString()).ToString("#.##");
                    //        lblAvailVisibleFund.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(dr["availFund"].ToString()));
                    //        //.ToString("#.##");
                    //    }
                    //    else
                    //    {
                    //        lblAvailFund.Text = "0.00";
                    //        lblAvailVisibleFund.Text = "0.00";
                    //    }

                    pnlTranDetails.Visible = false;
                    lblErrorMsg.Text = "";

                    gvPTrans.DataSource = null;
                    gvPTrans.DataBind();

                    ClearTransactionDetailForm();
                    DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(hfProjId.Value));

                    lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                    dt = new DataTable();
                    dt = FinancialTransactions.GetGranteeByProject(Convert.ToInt32(hfProjId.Value));
                    if (dt.Rows.Count > 0)
                    {
                        lblGrantee.Text = dt.Rows[0]["Applicantname"].ToString();
                        hfGrantee.Value = dt.Rows[0]["applicantid"].ToString();
                    }
                    else
                    {
                        lblGrantee.Text = "";
                        hfGrantee.Value = "";
                    }

                    //txtTransDate.Text = DateTime.Now.ToShortDateString();
                    txtTotAmt.Text = "";
                    BindFundAccounts();
                    ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;

                    if (rdBtnSelection.SelectedIndex == 1)
                    {
                        DataTable dtTrans = FinancialTransactions.GetFinancialTransByProjId(Convert.ToInt32(hfProjId.Value), ActiveOnly, BOARD_DECOMMITMENT);
                        gvPTrans.DataSource = dtTrans;
                        gvPTrans.DataBind();
                        CommonHelper.DisableButton(btnTransactionSubmit);
                    }
                    else if (rdBtnSelection.SelectedIndex == 0)
                    {
                        CommonHelper.EnableButton(btnTransactionSubmit);
                    }
                }
                else
                {
                    lblProjName.Text = "";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// When Decommitment grid populated select one item/record
        /// populate selected item details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvPTrans.DataSource = null;
            gvPTrans.DataBind();
            gvBCommit.DataSource = null;
            gvBCommit.DataBind();
            lblProjName.Text = "";
            hfProjId.Value = "";
            ClearTransactionDetailForm();
            pnlTranDetails.Visible = false;
            lblErrorMsg.Text = "";
            txtCommitedProjNum.Text = "";
            txtProjNum.Text = "";
            lblGrantee.Text = "";
            if (rdBtnSelection.SelectedIndex > 0)
            {
                txtProjNum.Visible = false;
                txtCommitedProjNum.Visible = true;
                imgNewAwardSummary.Visible = true;
                imgExistingAwardSummary.Visible = false;
                btnNewTransaction.Visible = false;
                lblAvailVisibleFund.Text = "";
                txtTransDate.Text = "";
                divPtransEntry.Visible = false;
            }
            else
            {
                txtProjNum.Visible = true;
                txtCommitedProjNum.Visible = false;
                imgNewAwardSummary.Visible = false;
                imgExistingAwardSummary.Visible = true;
                btnNewTransaction.Visible = true;
                Response.Redirect("decommitments.aspx");
            }

        }

        /// <summary>
        /// Active Only checkbox checked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            if (cbActiveOnly.Checked)
                ActiveOnly = 1;
            else
                ActiveOnly = 0;
            BindTransGrid(GetTransId());
            BindFundDetails(GetTransId());
        }

        /// <summary>
        /// Get selected Trans Id
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvPTrans_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetSelectedTransId(gvPTrans);
        }

        /// <summary>
        /// Transaction Row created
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvPTrans_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (rdBtnSelection.SelectedIndex == 0)
                e.Row.Cells[0].Visible = false;
            else
                e.Row.Cells[0].Visible = true;
        }

        /// <summary>
        /// Award Summary link
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lbAwardSummary_Click(object sender, ImageClickEventArgs e)
        {
            if (hfProjId.Value != "")
            {
                string url = "/awardsummary.aspx?projectid=" + hfProjId.Value;
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.open('");
                sb.Append(url);
                sb.Append("');");
                sb.Append("</script>");
                ClientScript.RegisterStartupScript(this.GetType(),
                        "script", sb.ToString());
            }
            else
                lblErrorMsg.Text = "Select a project to see the award summary";
        }

        /// <summary>
        /// Select DeCommitment details by Project Id
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnfind_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            if (rdBtnSelection.SelectedIndex > 0)
            {
                if (txtCommitedProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", txtCommitedProjNum.Text);
            }
            else
            {
                if (txtProjNum.Text == "")
                {
                    lblErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", txtProjNum.Text);
            }
            getDetails(dt);
        }
        
        /// <summary>
        /// Trasaction Row Editing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvPTrans_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPTrans.EditIndex = e.NewEditIndex;
            BindTransGrid(GetTransId());
        }

        /// <summary>
        /// Trasaction Row Updating
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvPTrans_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string lblDetId = ((Label)gvBCommit.Rows[rowIndex].FindControl("lblDetId")).Text.Trim();
                if (lblDetId.ToString() != "")
                {
                    FinancialTransactions.ActivateFinancialTransByTransId(Convert.ToInt32(lblDetId));

                    BindFundDetails(GetTransId());

                    lblErrorMsg.Text = "Transaction detail was successfully activated";
                    CommonHelper.EnableButton(btnDecommitmentSubmit);
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Trasaction cancel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvPTrans_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPTrans.EditIndex = -1;
            BindTransGrid(GetTransId());
        }

        /// <summary>
        /// Trasaction Deleting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvPTrans_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string TransId = ((Label)gvPTrans.Rows[rowIndex].FindControl("lblTransId")).Text.Trim();
                if (TransId.ToString() != "")
                {
                    FinancialTransactions.InactivateFinancialTransByTransId(Convert.ToInt32(TransId));
                    BindTransGrid(GetTransId());
                    BindFundDetails(GetTransId());

                    CommonHelper.EnableButton(btnTransactionSubmit);
                    lblErrorMsg.Text = "Transaction was successfully inactivated. All details related to this transaction also have been inactivated.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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
                else
                {
                    SetAvailableFundsLabel();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Populate usepermit
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <param name="AccountId"></param>
        /// <param name="FundTransType"></param>
        protected void PopulateUsePermit(int ProjectId, string AccountId, int FundTransType)
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetLandUsePermit(ProjectId, AccountId, FundTransType);
                ddlUsePermit.DataSource = dtable;
                ddlUsePermit.DataValueField = "Act250FarmId";
                ddlUsePermit.DataTextField = "UsePermit";
                ddlUsePermit.DataBind();

                if (ddlUsePermit.Items.Count > 1)
                    ddlUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
                else
                {
                    //decimal mitigationFundBalance = FinancialTransactions.Act250MitigationFundBalance(DataUtils.GetInt(ddlUsePermit.SelectedValue.ToString()));
                    //lblAvDetailFund.Text = CommonHelper.myDollarFormat(mitigationFundBalance);
                    SetAvailableFundsLabel();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        /// <summary>
        /// Bind UsePermit dropdown
        /// </summary>
        /// <param name="projId"></param>
        protected void BindUsePermit(int projId)
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetLandUsePermit(projId);
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

        /// <summary>
        /// Button click for new decommitment page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnNewTransaction_Click(object sender, EventArgs e)
        {
            Response.Redirect("decommitments.aspx");
        }
        
        /// <summary>
        /// Row deleting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBCommit_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblDetailId = (Label)gvBCommit.Rows[rowIndex].FindControl("lblDetId");
                if (lblDetailId != null)
                    FinancialTransactions.DeleteTransactionDetail(Convert.ToInt32(lblDetailId.Text));
                BindFundDetails(GetTransId());
                lblErrorMsg.Text = "Transaction detail was successfully deleted";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Delete detail: " + ex.Message;
            }
        }

        /// <summary>
        /// When Account number changes select corresponding Fund
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();

            if (ddlAcctNum.SelectedIndex != 0)
            {
                lblFundName.Text = "";
                lblErrorMsg.Text = "";
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
                lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");

                ddlFundName.SelectedValue = ddlAcctNum.SelectedValue;
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                ddlTransType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjAcct(Convert.ToInt32(hfProjId.Value), ddlAcctNum.SelectedItem.Text);
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "fundtype";
                ddlTransType.DataBind();

                if (ddlTransType.Items.Count > 1)
                    ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                else
                {
                    if (ddlTransType.Items.Count < 1)
                    {
                        lblErrorMsg.Text = "No transaction types found for this fund and hence this fund can't be used for disbursement";
                        return;
                    }
                    lblErrorMsg.Text = "";

                    if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        lblUsePermit.Visible = true;
                        ddlUsePermit.Visible = true;
                        PopulateUsePermit(DataUtils.GetInt(hfProjId.Value), ddlAcctNum.SelectedItem.ToString(),
                            DataUtils.GetInt(ddlTransType.SelectedValue.ToString()));
                    }
                    else
                    {
                        ddlUsePermit.Items.Clear();
                        lblUsePermit.Visible = false;
                        ddlUsePermit.Visible = false;

                        SetAvailableFundsLabel();
                    }
                }
            }
            else
            {
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";
                txtAmt.Text = "";
                lblErrorMsg.Text = "";
                //ClearDetailSelection();
                lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");
                ddlAcctNum.SelectedIndex = 0;
                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
            }
        }

        /// <summary>
        /// When Fund Name changes select corresponding Account Id
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlFundName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();

            if (ddlFundName.SelectedIndex != 0)
            {
                lblFundName.Text = "";
                lblErrorMsg.Text = "";
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
                lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");

                ddlAcctNum.SelectedValue = ddlFundName.SelectedValue;
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundName.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                ddlTransType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjAcct(Convert.ToInt32(hfProjId.Value), ddlAcctNum.SelectedItem.Text);
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "fundtype";
                ddlTransType.DataBind();

                if (ddlTransType.Items.Count > 1)
                    ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                else
                {
                    if (ddlTransType.Items.Count < 1)
                    {
                        lblErrorMsg.Text = "No transaction types found for this fund and hence this fund can't be used for disbursement";
                        return;
                    }
                    lblErrorMsg.Text = "";

                    if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        lblUsePermit.Visible = true;
                        ddlUsePermit.Visible = true;
                        PopulateUsePermit(DataUtils.GetInt(hfProjId.Value), ddlAcctNum.SelectedItem.ToString(),
                            DataUtils.GetInt(ddlTransType.SelectedValue.ToString()));
                    }
                    else
                    {
                        ddlUsePermit.Items.Clear();
                        lblUsePermit.Visible = false;
                        ddlUsePermit.Visible = false;
                        SetAvailableFundsLabel();
                    }
                }
            }
            else
            {
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";
                txtAmt.Text = "";
                lblErrorMsg.Text = "";
                //ClearDetailSelection();
                lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");
                ddlAcctNum.SelectedIndex = 0;
                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
            }
        }

        /// <summary>
        /// Trans Type changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlTransType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");
            if (ddlTransType.SelectedIndex > 0)
            {
                DataTable dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundName.SelectedValue.ToString()));

                if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                {
                    lblUsePermit.Visible = true;
                    ddlUsePermit.Visible = true;
                    PopulateUsePermit(DataUtils.GetInt(hfProjId.Value), ddlAcctNum.SelectedItem.ToString(),
                               DataUtils.GetInt(ddlTransType.SelectedValue.ToString()));
                }
                else
                {
                    ddlUsePermit.Items.Clear();
                    lblUsePermit.Visible = false;
                    ddlUsePermit.Visible = false;

                    if (ddlTransType.SelectedIndex > 0)
                    {
                        SetAvailableFundsLabel();
                    }
                }
            }
            else
            {
                lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");
                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;
            }
        }

        /// <summary>
        /// usePermit dropdown element changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlUsePermit_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");
            if (ddlUsePermit.SelectedIndex > 0)
            {
                //decimal mitigationFundBalance = FinancialTransactions.Act250MitigationFundBalance(DataUtils.GetInt(ddlUsePermit.SelectedValue.ToString()));
                //lblAvDetailFund.Text = CommonHelper.myDollarFormat(mitigationFundBalance);
                SetAvailableFundsLabel();
            }
        }

        /// <summary>
        /// Set Available funds amount
        /// </summary>
        private void SetAvailableFundsLabel()
        {
            DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundAmount(Convert.ToInt32(hfProjId.Value),
                                DataUtils.GetInt(ddlAcctNum.SelectedValue.ToString()),
                                DataUtils.GetInt(ddlTransType.SelectedValue.ToString()),
                                ddlUsePermit.SelectedValue.ToString());

            if (dtAvailFunds != null && dtAvailFunds.Rows.Count > 0)
                lblAvDetailFund.Text = CommonHelper.myDollarFormat(dtAvailFunds.Rows[0]["Balanced"].ToString());
            else
                lblAvDetailFund.Text = CommonHelper.myDollarFormat("0.00");
        }

        /// <summary>
        /// Check for login user can able to access this page
        /// </summary>
        private void CheckPageAccess()
        {
            DataTable dt = new DataTable();
            dt = UserSecurityData.GetuserPageSecurity(GetUserId());

            foreach (DataRow row in dt.Rows)
            {
                if (row["pageid"].ToString() == "26725")
                    rdBtnFinancial.Items[0].Enabled = false;
                if (row["pageid"].ToString() == "26780")
                    rdBtnFinancial.Items[1].Enabled = false;
                if (row["pageid"].ToString() == "27455")
                    rdBtnFinancial.Items[2].Enabled = false;
                if (row["pageid"].ToString() == "27456")
                    rdBtnFinancial.Items[3].Enabled = false;
            }

            //if (rdBtnFinancial.Items[0].Enabled)
            //    rdBtnFinancial.Items[0].Selected = true;
            if (rdBtnFinancial.Items[1].Enabled)
                rdBtnFinancial.Items[1].Selected = true;
            else if (rdBtnFinancial.Items[2].Enabled)
                Response.Redirect("Reallocations.aspx");
            else if (rdBtnFinancial.Items[3].Enabled)
                Response.Redirect("Assignments.aspx");
        }
    }

}