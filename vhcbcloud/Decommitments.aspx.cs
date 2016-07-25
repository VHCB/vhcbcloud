using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }


        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetCommittedProjectsByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjects("getCommittedProjectslistByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }


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

        protected void rdBtnFinancial_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdBtnFinancial.SelectedIndex == 0)
                Response.Redirect("Commitments.aspx");
            else if (rdBtnFinancial.SelectedIndex == 1)
                Response.Redirect("Decommitments.aspx");
            else if (rdBtnFinancial.SelectedIndex == 2)
                Response.Redirect("Reallocations.aspx");
            else
                Response.Redirect("CashRefund.aspx");
        }

        protected void BindFundAccounts()
        {
            ddlAcctNum.DataSource = null;
            ddlAcctNum.DataBind();
            ddlFundName.DataSource = null;
            ddlFundName.DataBind();

            DataTable dtable = new DataTable();
            try
            {
                dtable = FinancialTransactions.GetCommittedFundAccounts(Convert.ToInt32(hfProjId.Value));
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

        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();
            if (ddlAcctNum.SelectedIndex != 0)
            {
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                ddlFundName.SelectedValue = ddlAcctNum.SelectedValue;

                //if (lblFundName.Text.ToLower().Contains("hopwa"))
                //{
                //    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                //}
                //else
                //{
                //    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                //}

                ddlTransType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjAcct(Convert.ToInt32(hfProjId.Value), ddlAcctNum.SelectedItem.Text);
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "fundtype";
                ddlTransType.DataBind();
                if (ddlTransType.Items.Count > 1)
                    ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                BindUsePermit();

                if (ddlAcctNum.SelectedValue.ToString() == strLandUsePermit)
                {
                    lblUsePermit.Visible = true;
                    ddlUsePermit.Visible = true;
                }
                else
                {
                    lblUsePermit.Visible = false;
                    ddlUsePermit.Visible = false;
                }
            }
            else
            {
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";
                txtAmt.Text = "";
                //ClearDetailSelection();
            }
        }

        private void ClearTransactionDetailForm()
        {

            lblFundName.Text = "";
            txtAmt.Text = "";
            try
            {
                ddlTransType.SelectedIndex = 0;
                ddlAcctNum.SelectedIndex = 0;
            }
            catch (Exception e)
            { }
        }

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

                    totBalAmt = tranAmount + totFundAmt;

                    hfBalAmt.Value = (-totBalAmt).ToString();

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                    gvBCommit.Columns[0].Visible = false;
                    gvBCommit.FooterRow.Visible = true;
                    lblTransDetHeader.Text = "Transaction Detail";

                    if (totBalAmt == 0)
                    {
                        CommonHelper.DisableButton(btnDecommitmentSubmit);
                        CommonHelper.EnableButton(btnTransactionSubmit);
                        if (rdBtnSelection.SelectedIndex == 0)
                        {
                            lblProjName.Text = "";
                            lblGrantee.Text = "";
                        }
                    }
                    else
                    {
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                    }

                    if (lblBalAmt.Text != "$0.00")
                        lblErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

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


        protected void btnDecommitmentSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                lblErrorMsg.Text = "";

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
                    int n;
                    bool isNumeric = int.TryParse(txtAmt.Text.Trim(), out n);

                    if (!isNumeric || Convert.ToDecimal(txtAmt.Text) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid transaction amount";
                        txtAmt.Focus();
                        return;
                    }
                }
                DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundsPerProjAcctFundtype(Convert.ToInt32(hfProjId.Value), ddlAcctNum.SelectedItem.Text, Convert.ToInt32(ddlTransType.SelectedValue.ToString()));
                if (dtAvailFunds != null)
                    if (dtAvailFunds.Rows.Count > 0)
                        if (Convert.ToDecimal(txtAmt.Text) > Convert.ToDecimal(dtAvailFunds.Rows[0]["availFunds"].ToString()))
                        {
                            lblErrorMsg.Text = "Detail amount can not be more than available funds : " + CommonHelper.myDollarFormat(dtAvailFunds.Rows[0]["availFunds"].ToString()) + " for the selected Fund";
                            return;
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
                       Convert.ToInt32(ddlTransType.SelectedValue.ToString())))
                    {
                        lblErrorMsg.Text = "Same fund and same transaction type is already submitted for this transaction. Please select different selection";
                        return;
                    }
                    else
                    {
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                    }

                    if (ddlAcctNum.SelectedValue.ToString() == strLandUsePermit)
                    {
                        if (ddlUsePermit.Items.Count > 1 && ddlUsePermit.SelectedIndex == 0)
                        {
                            lblErrorMsg.Text = "Select Use Permit";
                            ddlUsePermit.Focus();
                            return;
                        }

                        FinancialTransactions.AddProjectFundDetails(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                        Convert.ToInt32(ddlTransType.SelectedValue.ToString()), -currentTranFudAmount, ddlUsePermit.SelectedItem.Text);
                    }
                    else
                        FinancialTransactions.AddProjectFundDetails(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                            Convert.ToInt32(ddlTransType.SelectedValue.ToString()), -currentTranFudAmount);



                    BindFundDetails(transId);
                    ClearTransactionDetailForm();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }


        protected void btnTransactionSubmit_Click(object sender, EventArgs e)
        {
            try
            {
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
                DataTable dtCommitFund = FinancialTransactions.GetCommittedFundPerProject(txtProjNum.Text);
                if (dtCommitFund != null)
                    if (dtCommitFund.Rows.Count > 0)
                        if (Convert.ToDecimal(dtCommitFund.Rows[0]["availFunds"].ToString()) < Convert.ToDecimal(txtTotAmt.Text.Trim()))
                        {
                            lblErrorMsg.Text = "Decommitted amount can not be more than available funds : " + CommonHelper.myDollarFormat(dtCommitFund.Rows[0]["availFunds"].ToString()) + " for the selected project";
                            return;
                        }

                lblErrorMsg.Text = "";
                decimal TransAmount = Convert.ToDecimal(txtTotAmt.Text);

                this.hfTransAmt.Value = (-TransAmount).ToString();
                this.hfBalAmt.Value = (-TransAmount).ToString();

                //if (pnlTranDetails.Visible)
                //    ClearTransactionDetailForm();

                gvBCommit.DataSource = null;
                gvBCommit.DataBind();

                pnlTranDetails.Visible = true;
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
                    TRANS_PENDING_STATUS);

                gvPTrans.DataSource = dtTrans;
                gvPTrans.DataBind();

                hfTransId.Value = dtTrans.Rows[0]["transid"].ToString();
                BindTransGrid(GetTransId());
                txtTransDate.Text = DateTime.Now.ToShortDateString();
                txtTotAmt.Text = "";

                CommonHelper.EnableButton(btnDecommitmentSubmit);
                CommonHelper.DisableButton(btnTransactionSubmit);
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            ClearTransactionDetailForm();
            GetSelectedTransId(gvPTrans);
            BindFundDetails(GetTransId());
            pnlTranDetails.Visible = true;
        }

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
                            ViewState["TransAmt"] = hfAmt.Value;
                            hfTransAmt.Value = hfAmt.Value;
                            hfBalAmt.Value = hfAmt.Value;
                        }
                        break;
                    }
                }
            }
        }

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
                    CommonHelper.EnableButton(btnTransactionSubmit);

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvBCommit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBCommit.EditIndex = -1;
            BindFundDetails(GetTransId());
        }

        protected void gvBCommit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBCommit.EditIndex = e.NewEditIndex;
            BindFundDetails(GetTransId());
        }

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

                decimal old_amount = -Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                decimal allowed_amount = old_amount + bal_amount;

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

        private void getDetails(DataTable dt)
        {
            try
            {

                if (dt.Rows.Count != 0)
                {
                    hfProjId.Value = dt.Rows[0][0].ToString();
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

                    txtTransDate.Text = DateTime.Now.ToShortDateString();
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
            }
            else
            {
                txtProjNum.Visible = true;
                txtCommitedProjNum.Visible = false;
                imgNewAwardSummary.Visible = false;
                imgExistingAwardSummary.Visible = true;

            }

        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            if (cbActiveOnly.Checked)
                ActiveOnly = 1;
            else
                ActiveOnly = 0;
            BindTransGrid(GetTransId());
            BindFundDetails(GetTransId());
        }

        protected void gvPTrans_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetSelectedTransId(gvPTrans);
        }

        protected void gvPTrans_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (rdBtnSelection.SelectedIndex == 0)
                e.Row.Cells[0].Visible = false;
            else
                e.Row.Cells[0].Visible = true;
        }

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


        protected void gvPTrans_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPTrans.EditIndex = e.NewEditIndex;
            BindTransGrid(GetTransId());
        }

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

        protected void gvPTrans_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPTrans.EditIndex = -1;
            BindTransGrid(GetTransId());
        }

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

        protected void ddlFundName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();
            if (ddlFundName.SelectedIndex != 0)
            {
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundName.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                ddlAcctNum.SelectedValue = ddlFundName.SelectedValue;

                //if (lblFundName.Text.ToLower().Contains("hopwa"))
                //{
                //    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                //}
                //else
                //{
                //    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                //}

                ddlTransType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjAcct(Convert.ToInt32(hfProjId.Value), ddlAcctNum.SelectedItem.Text);
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "fundtype";
                ddlTransType.DataBind();
                if (ddlTransType.Items.Count > 1)
                    ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                BindUsePermit();

                if (ddlFundName.SelectedValue.ToString() == strLandUsePermit)
                {
                    lblUsePermit.Visible = true;
                    ddlUsePermit.Visible = true;
                }
                else
                {
                    lblUsePermit.Visible = false;
                    ddlUsePermit.Visible = false;
                }
            }
            else
            {
                ddlTransType.Items.Clear();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";
                txtAmt.Text = "";
                //ClearDetailSelection();
            }
        }
        protected void BindUsePermit()
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetLandUsePermit");
                ddlUsePermit.DataSource = dtable;
                ddlUsePermit.DataValueField = "Act250FarmId";
                ddlUsePermit.DataTextField = "UsePermit";
                ddlUsePermit.DataBind();
                ddlUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }
    }
}