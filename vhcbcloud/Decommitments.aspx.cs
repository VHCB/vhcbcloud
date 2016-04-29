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
    public partial class Decommitments: System.Web.UI.Page
    {
        DataTable dtProjects;
        private int TRANS_PENDING_STATUS = 261;
        private int BOARD_COMMITMENT = 238;
        private int BOARD_DECOMMITMENT = 239;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();                
            }
        }

        protected void BindProjects()
        {
            try
            {
                dtProjects = new DataTable();
                dtProjects = ProjectCheckRequestData.GetData("getCommittedProjectslist");
                ddlProjFilter.DataSource = dtProjects;
                ddlProjFilter.DataValueField = "projectId";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));

                //ddlRFromProj.DataSource = dtProjects;
                //ddlRFromProj.DataValueField = "projectId";
                //ddlRFromProj.DataTextField = "Proj_num";
                //ddlRFromProj.DataBind();
                //ddlRFromProj.Items.Insert(0, new ListItem("Select", "NA"));

                //ddlRToProj.DataSource = dtProjects;
                //ddlRToProj.DataValueField = "projectId";
                //ddlRToProj.DataTextField = "Proj_num";
                //ddlRToProj.DataBind();
                //ddlRToProj.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
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

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlTranDetails.Visible = false;
            lblErrorMsg.Text = "";

            gvPTrans.DataSource = null;
            gvPTrans.DataBind();

            ddlGrantee.Items.Clear();
            ddlGrantee.Items.Insert(0, new ListItem("Select", "NA"));

            ClearTransactionDetailForm();

            if (ddlProjFilter.SelectedIndex != 0)
            {
                DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
                lblProjNameText.Visible = true;
                lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                BindGranteeByProject(); //Bind Grantee Drop Down
                lbAwardSummary.Visible = true;
                txtTransDate.Text = DateTime.Now.ToShortDateString();
                txtTotAmt.Text = "";
                BindFundAccounts();
            }
            else
            {
                lbAwardSummary.Visible = false;
                lblProjNameText.Visible = false;
                lblProjName.Text = "";
            }
        }

        protected void BindGranteeByProject()
        {
            try
            {
                DataTable dtGrantee = FinancialTransactions.GetGranteeByProject(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
                ddlGrantee.DataSource = dtGrantee;
                ddlGrantee.DataValueField = "applicantid";
                ddlGrantee.DataTextField = "Applicantname";
                ddlGrantee.DataBind();
                if (dtGrantee.Rows.Count > 1)
                    ddlGrantee.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindFundAccounts()
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetCommittedFundAccounts(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
                ddlAcctNum.Items.Clear();
                ddlAcctNum.DataSource = dtable;
                ddlAcctNum.DataValueField = "fundid";
                ddlAcctNum.DataTextField = "account";
                
                ddlAcctNum.DataBind();
                ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();
            if (ddlAcctNum.SelectedIndex != 0)
            {
                dtable = FinancialTransactions.GetCommittedFundDetailsByFundId(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

                //if (lblFundName.Text.ToLower().Contains("hopwa"))
                //{
                //    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                //}
                //else
                //{
                //    ddlTransType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                //}
                ddlTransType.DataSource = dtable;
                ddlTransType.DataValueField = "lktranstype";
                ddlTransType.DataTextField = "fundtype";
                ddlTransType.DataBind();


                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
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
            try {
                ddlTransType.SelectedIndex = 0;
                ddlAcctNum.SelectedIndex = 0;
            }
            catch(Exception e)
            { }
        }

        private void BindFundDetails(int transId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                dtFundDet = FinancialTransactions.GetCommitmentFundDetailsByProjectId(transId, BOARD_DECOMMITMENT);

                gvBCommit.DataSource = dtFundDet;
                gvBCommit.DataBind();

                decimal tranAmount = 0;
                decimal totFundAmt = 0;
                decimal totBalAmt = 0;

                if (dtFundDet.Rows.Count > 0)
                {
                    //tranAmount = Convert.ToDecimal(dtFundDet.Rows[0]["TransAmt"].ToString());
                    tranAmount = -Convert.ToDecimal(this.hfTransAmt.Value);

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
            DataTable dtable = new DataTable();
            dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), "Board DeCommitment");
            if (dtable.Rows.Count > 0)
                return Convert.ToInt32(dtable.Rows[0]["transid"].ToString());
            else
                return 0;
        }

        protected void rdBtnSelectTransDetail_CheckedChanged(object sender, EventArgs e)
        {
        }

        protected void lbAwardSummary_Click(object sender, EventArgs e)
        {
            if (ddlProjFilter.SelectedIndex > 0)
            {
                string url = "/awardsummary.aspx?projectid=" + ddlProjFilter.SelectedValue.ToString();
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.open('");
                sb.Append(url);
                sb.Append("');");
                sb.Append("</script>");
                ClientScript.RegisterStartupScript(this.GetType(),
                        "script", sb.ToString());
            }
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

                decimal currentTranAmount = 0;
                decimal currentTranFudAmount = 0;
                decimal currentBalAmount = 0;

                currentTranAmount = Convert.ToDecimal(hfTransAmt.Value);
                currentTranFudAmount = Convert.ToDecimal(txtAmt.Text);
                currentBalAmount = Convert.ToDecimal(hfBalAmt.Value);

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
                    else if (currentTranFudAmount > currentBalAmount)
                    {
                        currentTranFudAmount = currentBalAmount;
                        lblErrorMsg.Text = "Amount auto adjusted to available fund amount";
                        CommonHelper.DisableButton(btnTransactionSubmit );
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                    }
                    else
                    {
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        CommonHelper.EnableButton(btnDecommitmentSubmit);
                    }

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
                if (ddlProjFilter.Items.Count > 1 && ddlProjFilter.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Select Project to add new transaction";
                    ddlProjFilter.Focus();
                    return;
                }
                else if (ddlGrantee.Items.Count > 1 && ddlGrantee.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Select Grantee to add new transaction";
                    ddlGrantee.Focus();
                    return;
                }
                else if (txtTotAmt.Text.Trim() == "" || Convert.ToDecimal(txtTotAmt.Text) <= 0)
                {
                    lblErrorMsg.Text = "Select a valid transaction amount";
                    txtTotAmt.Focus();
                    return;
                }

                lblErrorMsg.Text = "";
                decimal TransAmount = Convert.ToDecimal(txtTotAmt.Text);

                this.hfTransAmt.Value = TransAmount.ToString();
                this.hfBalAmt.Value = TransAmount.ToString();

                //if (pnlTranDetails.Visible)
                //    ClearTransactionDetailForm();

                gvBCommit.DataSource = null;
                gvBCommit.DataBind();

                pnlTranDetails.Visible = true;
                ClearTransactionDetailForm();

                CommonHelper.EnableButton(btnDecommitmentSubmit);
                CommonHelper.DisableButton(btnTransactionSubmit);

                DataTable dtTrans = FinancialTransactions.AddBoardFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), Convert.ToDateTime(txtTransDate.Text),
                    -TransAmount, Convert.ToInt32(ddlGrantee.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment",
                    TRANS_PENDING_STATUS);

                gvPTrans.DataSource = dtTrans;
                gvPTrans.DataBind();

                txtTransDate.Text = DateTime.Now.ToShortDateString();
                txtTotAmt.Text = "";
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
                    amount = allowed_amount;
                    lblErrorMsg.Text = "Amount auto adjusted to available fund amount";
                    CommonHelper.DisableButton(btnTransactionSubmit);
                    CommonHelper.EnableButton(btnDecommitmentSubmit);
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

    }
}