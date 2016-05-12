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
    public partial class Commitments : System.Web.UI.Page
    {
        DataTable dtProjects;
        private int BOARD_COMMITMENT = 238;
        private int TRANS_PENDING_STATUS = 261;
        private int ActiveOnly = 1;
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
                if (rdBtnSelection.SelectedIndex == 0)
                {

                    dtProjects = Project.GetProjects("GetProjects");
                    ddlProjFilter.DataSource = dtProjects;
                    ddlProjFilter.DataValueField = "projectId";
                    ddlProjFilter.DataTextField = "Proj_num";
                    ddlProjFilter.DataBind();
                    ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else
                {
                    dtProjects = Project.GetProjects("getCommittedPendingProjectslist");
                    ddlProjFilter.DataSource = dtProjects;
                    ddlProjFilter.DataValueField = "projectId";
                    ddlProjFilter.DataTextField = "Proj_num";
                    ddlProjFilter.DataBind();
                    ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
                }
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
                ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + ddlProjFilter.SelectedValue.ToString();

                if (rdBtnSelection.SelectedIndex == 1)
                {
                    DataTable dtTrans = FinancialTransactions.GetFinancialTransByProjId(Convert.ToInt32(ddlProjFilter.SelectedValue), ActiveOnly);
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
                dtable = FinancialTransactions.GetDataTableByProcName("GetFundAccounts");
                //dtable = FinancialTransactions.GetCommittedFundAccounts(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
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
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()));
                lblFundName.Text = dtable.Rows[0]["name"].ToString();

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
            catch (Exception)
            { }
        }

        private void BindFundDetails(int transId)
        {
            try
            {
                if (cbActiveOnly.Checked)
                    ActiveOnly = 1;
                else
                    ActiveOnly = 0;

                DataTable dtFundDet = new DataTable();
                dtFundDet = FinancialTransactions.GetCommitmentFundDetailsByProjectId(transId, BOARD_COMMITMENT, ActiveOnly);

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

                    totBalAmt = tranAmount - totFundAmt;
                    hfBalAmt.Value = totBalAmt.ToString();

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                    gvBCommit.Columns[0].Visible = false;
                    gvBCommit.FooterRow.Visible = true;
                    lblTransDetHeader.Text = "Transaction Detail";

                    if (totBalAmt == 0)
                    {
                        CommonHelper.DisableButton(btnCommitmentSubmit);
                        CommonHelper.EnableButton(btnTransactionSubmit);
                        if (rdBtnSelection.SelectedIndex == 0)
                        {
                            ddlProjFilter.SelectedIndex = 0;
                            if (ddlGrantee.Items.Count > 0)
                                ddlGrantee.SelectedIndex = 0;
                            lblProjName.Text = "";
                        }
                        
                    }
                    else
                    {
                        CommonHelper.DisableButton(btnTransactionSubmit);
                        CommonHelper.EnableButton(btnCommitmentSubmit);
                    }
                    if (lblBalAmt.Text != "$0.00")
                    {
                        lblErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";

                    }
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

                //DataTable dtable = new DataTable();
                //dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), "Board Commitment");
                //if (dtable.Rows.Count > 0)
                //    return Convert.ToInt32(dtable.Rows[0]["transid"].ToString());
                //else
                return 0;
            }
            else
                return Convert.ToInt32(hfTransId.Value);
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

        protected void btnCommitmentSubmit_Click(object sender, EventArgs e)
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
                        CommonHelper.DisableButton(btnCommitmentSubmit);

                        return;
                    }
                    else if (currentTranFudAmount > currentBalAmount)
                    {
                        //currentTranFudAmount = currentBalAmount;
                        //lblErrorMsg.Text = "Amount auto adjusted to available fund amount";

                        lblErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                        return;
                    }

                    if (FinancialTransactions.IsDuplicateFundDetailPerTransaction(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                        Convert.ToInt32(ddlTransType.SelectedValue.ToString())))
                    {
                        lblErrorMsg.Text = "Same fund and same transaction type is already submitted for this transaction. Please select different selection";
                        return;
                    }

                    FinancialTransactions.AddProjectFundDetails(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                        Convert.ToInt32(ddlTransType.SelectedValue.ToString()), currentTranFudAmount);

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
                //else if (ddlGrantee.Items.Count > 1 && ddlGrantee.SelectedIndex == 0)
                //{
                //    lblErrorMsg.Text = "Select Grantee to add new transaction";
                //    ddlGrantee.Focus();
                //    return;
                //}
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

                int? granteeId = null;
                if (ddlGrantee.SelectedIndex >= 0)
                    granteeId = Convert.ToInt32(ddlGrantee.SelectedValue.ToString());


                DataTable dtTrans = FinancialTransactions.AddBoardFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), Convert.ToDateTime(txtTransDate.Text),
                    TransAmount, granteeId, "Board Commitment",
                    TRANS_PENDING_STATUS);

                hfTransId.Value = dtTrans.Rows[0]["transid"].ToString();
                BindTransGrid(GetTransId());
                txtTransDate.Text = DateTime.Now.ToShortDateString();
                txtTotAmt.Text = "";

                CommonHelper.EnableButton(btnCommitmentSubmit);
                CommonHelper.DisableButton(btnTransactionSubmit);
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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
                    dtTrans = FinancialTransactions.GetFinancialTransByProjId(Convert.ToInt32(ddlProjFilter.SelectedValue), ActiveOnly);
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
                int fundId = Convert.ToInt32(((Label)gvBCommit.Rows[rowIndex].FindControl("lblFundId")).Text);

                int transId = Convert.ToInt32(((Label)gvBCommit.Rows[rowIndex].FindControl("lblTransId")).Text);

                decimal old_amount = Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                decimal allowed_amount = old_amount + bal_amount;



                if (amount == allowed_amount)
                {
                    lblErrorMsg.Text = "Transaction is complete, more funds not allowed";
                }
                else if (amount > allowed_amount)
                {
                    //amount = allowed_amount;
                    //lblErrorMsg.Text = "Amount auto adjusted to available fund amount";

                    lblErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                    return;
                }
                else if (amount < allowed_amount)
                {
                    if (!btnCommitmentSubmit.Enabled)
                        CommonHelper.EnableButton(btnCommitmentSubmit);
                }

                if (FinancialTransactions.IsDuplicateFundDetailPerTransaction(transId, fundId, transType))
                {
                    lblErrorMsg.Text = "Same fund and same transaction type is already submitted for this transaction. Please change selection";
                    return;
                }
                FinancialTransactions.UpdateTransDetails(detailId, transType, amount);
                //lblErrorMsg.Text = "";
                gvBCommit.EditIndex = -1;
                //BindFundDetails(Convert.ToInt32(ViewState["SelectedTransId"]));
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
                    Label lblFName = (e.Row.FindControl("lblFundName") as Label);
                    if (txtTransType != null)
                    {
                        DataTable dtable = new DataTable();
                        if (lblFName.Text.ToLower().Contains("hopwa"))
                        {
                            dtable = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                        }
                        else
                        {
                            dtable = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                        }

                       // dtable = FinancialTransactions.GetLookupDetailsByName("LkTransType");
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
                    CommonHelper.EnableButton(btnCommitmentSubmit);
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

        protected void gvBCommit_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string lblDetId = ((Label)gvBCommit.Rows[rowIndex].FindControl("lblDetId")).Text.Trim();
                if (lblDetId.ToString() != "")
                {
                    FinancialTransactions.InactivateFinancialDetailByDetailId(Convert.ToInt32(lblDetId));

                    BindFundDetails(GetTransId());

                    lblErrorMsg.Text = "Transaction detail was successfully inactavited";
                    CommonHelper.EnableButton(btnCommitmentSubmit);
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
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

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindProjects();
            gvPTrans.DataSource = null;
            gvPTrans.DataBind();
            gvBCommit.DataSource = null;
            gvBCommit.DataBind();
            lblProjName.Text = "";
            lbAwardSummary.Visible = false;
            ClearTransactionDetailForm();
            pnlTranDetails.Visible = false;
            lblErrorMsg.Text = "";
            ddlGrantee.Items.Clear();
            ddlGrantee.Items.Insert(0, new ListItem("Select", "NA"));
            if (rdBtnSelection.SelectedIndex > 0)
            {
                if (ddlProjFilter.SelectedIndex > 0)
                    BindTransGrid(GetTransId());
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

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            GetSelectedTransId(gvPTrans);
            BindFundDetails(Convert.ToInt32(ViewState["SelectedTransId"]));
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

       
    }
}