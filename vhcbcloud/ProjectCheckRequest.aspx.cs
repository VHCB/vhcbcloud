using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ProjectCheckRequest : System.Web.UI.Page
    {
        string Pagename = "ProjectCheckRequest";
        DataTable dtProjects;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            lblMessage.Text = "";

            if (!IsPostBack)
            {
                DisableButton(btnSubmit);
                BindProjects();

                //BindProgram();
                BindStatus();
                BindMatchingGrant();
                BindNODData();
                BindPCRQuestions(false);
                BindPCRData();

                //BindFundTypeCommitments();
                //BindTransDate();
                //BindApplicantName();
                //BindPayee();
                //BindTransType();
                //BindStateVHCBS();

                pnlApprovals.Visible = false;
                pnlDisbursement.Visible = false;
                lblAmtEligibleForMatch.Visible = false;
                txtEligibleAmt.Visible = false;
                ddlMatchingGrant.Visible = false;
                lblMatchingGrant.Visible = false;

                if (rdBtnSelect.SelectedIndex == 1)
                {
                    ClearPCRForm();
                    BindExistingPCR();
                    ddlProjFilter.Enabled = false;
                }
                else if (rdBtnSelect.SelectedIndex == 0)
                {
                    txtTransDate.Text = DateTime.Now.ToShortDateString();
                    ddlProjFilter.Enabled = true;
                }
            }


            //GetPCRSelectedRecord(gvPCRData);
        }

        #region BindData

        protected void BindExistingPCR()
        {
            try
            {
                DataTable dtPCR = new DataTable();
                dtPCR = ProjectCheckRequestData.GetData("GetExistingPCR");
                ddlDate.Items.Clear();
                ddlDate.DataSource = dtPCR;
                ddlDate.DataValueField = "ProjectCheckReqId";
                ddlDate.DataTextField = "pcq";
                ddlDate.DataBind();
                ddlDate.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindProjects()
        {
            try
            {
                dtProjects = new DataTable();
                dtProjects = ProjectCheckRequestData.GetData("getCommittedProjectslist");
                ddlProjFilter.Items.Clear();
                ddlProjFilter.DataSource = dtProjects;
                ddlProjFilter.DataValueField = "project_id_name";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindTransDate(DataTable dtPcr)
        {
            try
            {

                ddlDate.DataSource = dtPcr;
                ddlDate.DataValueField = "ProjectCheckReqId";
                ddlDate.DataTextField = "pcq";
                ddlDate.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void BindApplicantName(int ProjectId)
        {
            try
            {
                DataTable dtApplicantname;
                dtApplicantname = new DataTable();
                dtApplicantname = ProjectCheckRequestData.GetApplicantName(ProjectId);

                ddlApplicantName.DataSource = dtApplicantname;
                ddlApplicantName.DataValueField = "Applicantname";
                ddlApplicantName.DataTextField = "Applicantname";
                ddlApplicantName.DataBind();
                //ddlApplicantName.Items.Insert(0, new ListItem("Select", "NA"));

                BindPayee(ProjectId);
                BindProgram(ProjectId);
                DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(ProjectId);
                CommonHelper.PopulateDropDown(ddlProgram, drProjectDetails["LkProgram"].ToString());
                if (ddlProgram.Items.Count > 1)
                    DisplayControls(ddlProgram.SelectedItem.ToString());
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindPayee(int projId)
        {
            try
            {
                ddlPayee.DataSource = null;
                ddlPayee.DataBind();

                DataTable dtPayee;
                dtPayee = new DataTable();
                dtPayee = ProjectCheckRequestData.GetProjectFinLegalApplicant(projId);

                ddlPayee.DataSource = dtPayee;
                ddlPayee.DataValueField = "ApplicantId";
                ddlPayee.DataTextField = "Applicantname";
                ddlPayee.DataBind();
                if (ddlPayee.Items.Count > 1)
                    ddlPayee.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: BindPayee: " + ex.Message;
            }

        }

        protected void BindProgram(int projId)
        {
            try
            {
                DataTable dtProgram;
                dtProgram = new DataTable();
                dtProgram = ProjectCheckRequestData.PCR_Program(projId);

                ddlProgram.DataSource = dtProgram;
                ddlProgram.DataValueField = "typeid";
                ddlProgram.DataTextField = "Description";
                ddlProgram.DataBind();
                if (ddlProgram.Items.Count > 1)
                    ddlProgram.Items.Insert(0, new ListItem("Select", "NA"));
                DisplayControls(ddlProgram.SelectedItem.ToString());
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void BindStatus()
        {
            try
            {
                DataTable dtStatus = new DataTable();
                dtStatus = ProjectCheckRequestData.GetData("PCR_Trans_Status");

                ddlStatus.DataSource = dtStatus;
                ddlStatus.DataValueField = "typeid";
                ddlStatus.DataTextField = "Description";
                ddlStatus.DataBind();

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: BindStatus: " + ex.Message;
            }
        }

        protected void BindMatchingGrant()
        {
            try
            {
                DataTable dtMatchingGrant;
                dtMatchingGrant = new DataTable();
                dtMatchingGrant = ProjectCheckRequestData.GetData("PCR_MatchingGrant");

                ddlMatchingGrant.DataSource = dtMatchingGrant;
                ddlMatchingGrant.DataValueField = "typeid";
                ddlMatchingGrant.DataTextField = "Description";
                ddlMatchingGrant.DataBind();
                ddlMatchingGrant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindFundTypeCommitments(int projId)
        {
            try
            {
                DataTable dtFundType;
                dtFundType = new DataTable();
                dtFundType = FinancialTransactions.GetCommittedFundAccounts(projId);

                ddlFundTypeCommitments.DataSource = dtFundType;
                ddlFundTypeCommitments.DataValueField = "FundId";
                ddlFundTypeCommitments.DataTextField = "name";
                ddlFundTypeCommitments.DataBind();
                ddlFundTypeCommitments.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindTransType()
        {
            try
            {
                DataTable dtFundType;
                dtFundType = new DataTable();
                dtFundType = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa"); //ProjectCheckRequestData.GetData("PCR_TransType");

                ddlTransType.DataSource = dtFundType;
                ddlTransType.DataValueField = "TypeId";
                ddlTransType.DataTextField = "Description";
                ddlTransType.DataBind();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }


        private void BindPCRTransDetails()
        {
            try
            {
                DataTable dtPCRTranDetails = new DataTable();
                dtPCRTranDetails = ProjectCheckRequestData.GetPCRTranDetails(this.hfTransId.Value);

                gvPTransDetails.DataSource = dtPCRTranDetails;
                gvPTransDetails.DataBind();

                decimal tranAmount = 0;
                decimal totFundAmt = 0;
                decimal totBalAmt = 0;

                if (dtPCRTranDetails.Rows.Count > 0)
                {
                    //tranAmount = Convert.ToDecimal(dtFundDet.Rows[0]["TransAmt"].ToString());
                    tranAmount = Convert.ToDecimal(this.hfTransAmt.Value);

                    Label lblTotAmt = (Label)gvPTransDetails.FooterRow.FindControl("lblFooterAmount");
                    Label lblBalAmt = (Label)gvPTransDetails.FooterRow.FindControl("lblFooterBalance");

                    if (dtPCRTranDetails.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtPCRTranDetails.Rows.Count; i++)
                        {
                            totFundAmt += Convert.ToDecimal(dtPCRTranDetails.Rows[i]["Amount"].ToString());
                        }
                    }

                    totBalAmt = tranAmount - totFundAmt;
                    hfBalAmt.Value = totBalAmt.ToString();

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                    gvPTransDetails.Columns[0].Visible = false;
                    gvPTransDetails.FooterRow.Visible = true;

                    //lblTransDetHeader.Text = "Transaction Detail";

                    if (totBalAmt == 0)
                    {
                        DisableButton(btnPCRTransDetails);
                        EnableButton(btnSubmit);
                    }

                    if (lblBalAmt.Text != "$0.00")
                        lblErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = Pagename + ": BindPCRTransDetails: " + ex.Message;
            }
        }

        protected void BindNODData()
        {
            try
            {
                DataTable dtNOD;
                dtNOD = new DataTable();
                dtNOD = ProjectCheckRequestData.GetData("PCR_NOD_Load");

                lbNOD.DataSource = dtNOD;
                lbNOD.DataValueField = "typeid";
                lbNOD.DataTextField = "Description";
                lbNOD.DataBind();
                //ddlMatchingGrant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindPCRQuestions(bool IsLegal)
        {
            try
            {
                DataTable dtPCRQuestions;
                dtPCRQuestions = new DataTable();
                dtPCRQuestions = ProjectCheckRequestData.GetPCRQuestions(IsLegal);

                ddlPCRQuestions.DataSource = dtPCRQuestions;
                ddlPCRQuestions.DataValueField = "typeid";
                ddlPCRQuestions.DataTextField = "Description";
                ddlPCRQuestions.DataBind();
                ddlPCRQuestions.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        #endregion

        protected void BindPCRData()
        {
            try
            {
                DataTable dtFundInfo = new DataTable();
                dtFundInfo = ProjectCheckRequestData.GetData("GetPCRData");
                gvPCRData.DataSource = dtFundInfo;
                gvPCRData.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: BindPCRData: " + ex.Message;
            }
        }

        protected void AddDefaultPCRQuestions()
        {
            try
            {
                ProjectCheckRequestData.AddDefaultPCRQuestions(chkLegalReview.Checked, int.Parse(this.hfPCRId.Value), GetUserId());
                BindPCRQuestionsForApproval();
            }
            catch (Exception ex)
            {

                lblErrorMsg.Text = "Exception arised while adding default PCR questions: " + ex.Message;
            }
        }

        protected void BindPCRQuestionsForApproval()
        {
            try
            {
                DataTable dtPCRQuestionsForApproval = new DataTable();
                dtPCRQuestionsForApproval = ProjectCheckRequestData.GetDefaultPCRQuestions(chkLegalReview.Checked, int.Parse(this.hfPCRId.Value));
                gvQuestionsForApproval.DataSource = dtPCRQuestionsForApproval;
                gvQuestionsForApproval.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: BindPCRQuestionsForApproval: " + ex.Message;
            }
        }
        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                ClearPCRForm();
                EnableButton(btnPCRTransDetails);
                DisableButton(btnSubmit);
                BindPCRTransDetails();
                BindPCRQuestionsForApproval();
                ddlPCRQuestions.SelectedIndex = -1;

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: rdBtnSelect_CheckedChanged: " + ex.Message;
            }
        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProjFilter.SelectedIndex != 0)
            {
                ClearPCRForm();
                EnablePCR();
                string[] tokens = ddlProjFilter.SelectedValue.ToString().Split('|');
                lblProjName.Text = tokens[1];
                DataRow dr = ProjectCheckRequestData.GetAvailableFundsByProject(int.Parse(tokens[0]));
                lblAvailFund.Text = Convert.ToDecimal(dr["availFund"].ToString()).ToString("#.##");
                BindApplicantName(int.Parse(tokens[0]));

                hfProjId.Value = tokens[0].ToString();
                pnlApprovals.Visible = false;
                pnlDisbursement.Visible = false;
                BindFundTypeCommitments(int.Parse(tokens[0]));
                txtTransDate.Text = DateTime.Now.ToShortDateString();

            }
            else
            {
                lblProjName.Text = "--";
            }
        }

        protected void chkLegalReview_CheckedChanged(object sender, EventArgs e)
        {
            BindPCRQuestions(chkLegalReview.Checked);
        }

        private void ClearTransactionDetailForm()
        {
            ddlFundTypeCommitments.SelectedIndex = 0;
            ddlTransType.SelectedIndex = 0;
            txtTransDetailAmt.Text = "";
        }

        public static void DisableButton(Button btn)
        {
            btn.Enabled = false;
            btn.CssClass = "btn btn-info";
        }

        public static void EnableButton(Button btn)
        {
            btn.Enabled = true;
            btn.CssClass = "btn btn-info";
        }

        #region gvPTransDetails
        protected void gvPTransDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                if (((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim() != "")
                {
                    decimal n;
                    bool isDecimal = decimal.TryParse(((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim(), out n);

                    if (!isDecimal || Convert.ToDecimal(((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim()) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid transaction amount";
                        ((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Focus();
                        return;
                    }
                }

                decimal amount = Convert.ToDecimal(((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text);
                int transType = Convert.ToInt32(((DropDownList)gvPTransDetails.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                int detailId = Convert.ToInt32(((Label)gvPTransDetails.Rows[rowIndex].FindControl("lblDetId")).Text);

                decimal old_amount = Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                decimal allowed_amount = old_amount + bal_amount;

                if (amount == allowed_amount)
                {
                    lblErrorMsg.Text = "Transaction is complete, more funds not allowed";
                }
                else if (amount > allowed_amount)
                {
                    amount = allowed_amount;
                    lblErrorMsg.Text = "Amount auto adjusted to available fund amount";
                }
                else if (amount < allowed_amount)
                {
                    if (!btnPCRTransDetails.Enabled)
                    {
                        EnableButton(btnPCRTransDetails);
                        DisableButton(btnSubmit);
                    }
                }
                FinancialTransactions.UpdateTransDetails(detailId, transType, amount);

                gvPTransDetails.EditIndex = -1;
                BindPCRTransDetails();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: gvPTransDetails_RowUpdating: " + ex.Message;
            }

        }

        protected void gvPTransDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPTransDetails.EditIndex = e.NewEditIndex;
            BindPCRTransDetails();
        }

        protected void gvPTransDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPTransDetails.EditIndex = -1;
            BindPCRTransDetails();
        }

        protected void gvPTransDetails_RowDataBound(object sender, GridViewRowEventArgs e)
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
        #endregion

        #region ButtonSubmit
        protected void btnCRSubmit_Click(object sender, EventArgs e)
        {
            string PCRID = this.hfEditPCRId.Value;

            #region Validations
            if (ddlProjFilter.Items.Count > 1 && ddlProjFilter.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select Project#";
                ddlProjFilter.Focus();
                return;
            }
            if (txtTransDate.Text == "")
            {
                lblErrorMsg.Text = "Select Transaction Date";
                txtTransDate.Focus();
                return;
            }
             if (txtTransDate.Text.Trim() != "")
            {
                DateTime dt;
                bool isDateTime = DateTime.TryParse(txtTransDate.Text.Trim(), out dt);

                if (!isDateTime)
                {
                    lblErrorMsg.Text = "Select a valid Transaction Date";
                    txtTransDate.Focus();
                    return;
                }
            }

            if (ddlPayee.Items.Count > 1 && ddlPayee.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select Payee";
                ddlPayee.Focus();
                return;
            }
            if (ddlPayee.Items.Count == 0)
            {
                lblErrorMsg.Text = "Add a payee to this project before proceed with disbursement";
                return;
            }
            if (ddlProgram.Items.Count > 1 && ddlProgram.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select Program";
                ddlProgram.Focus();
                return;
            }
            if (ddlProgram.Items.Count == 0)
            {
                lblErrorMsg.Text = "Add a program to this project before proceed with disbursement";
                return;
            }
            //else if (ddlStatus.Items.Count > 1 && ddlStatus.SelectedIndex == 0)
            //{
            //    lblErrorMsg.Text = "Select Status";
            //    ddlStatus.Focus();
            //    return;
            //}
            //else if (lbNOD.Items.Count > 1 && lbNOD.SelectedIndex == -1)
            //{
            //    lblErrorMsg.Text = "Select NOD";
            //    lbNOD.Focus();
            //    return;
            //}

            if (txtEligibleAmt.Visible)
            {
                if (txtEligibleAmt.Text.Trim() == "")
                {
                    lblErrorMsg.Text = "Select Eligible Amount";
                    txtEligibleAmt.Focus();
                    return;
                }
                if (txtEligibleAmt.Text.Trim() != "")
                {
                    decimal n;
                    bool isDecimal = decimal.TryParse(txtEligibleAmt.Text.Trim(), out n);

                    if (!isDecimal || Convert.ToDecimal(txtEligibleAmt.Text) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid Eligible amount";
                        txtEligibleAmt.Focus();
                        return;
                    }
                }
            }

            if (txtEligibleAmt.Visible && ddlMatchingGrant.Items.Count > 1 && ddlMatchingGrant.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select Matching Grant";
                ddlMatchingGrant.Focus();
                return;
            }

            if (txtDisbursementAmt.Text.Trim() == "")
            {
                lblErrorMsg.Text = "Select Disbursement Amount";
                txtDisbursementAmt.Focus();
                return;
            }
            if (txtDisbursementAmt.Text.Trim() != "")
            {
                decimal n;
                bool isDecimal = decimal.TryParse(txtDisbursementAmt.Text.Trim(), out n);

                if (!isDecimal || Convert.ToDecimal(txtDisbursementAmt.Text) <= 0)
                {
                    lblErrorMsg.Text = "Select a valid Disbursement amount";
                    txtDisbursementAmt.Focus();
                    return;
                }
                //bool availFunds = decimal.TryParse(lblAvailFund.Text.Trim(), out n);
                //if (!availFunds || Convert.ToDecimal(txtDisbursementAmt.Text) > Convert.ToDecimal(lblAvailFund.Text))
                //{
                //    lblErrorMsg.Text = "Disbursement amount can't be more than available funds for the selected project";
                //    txtDisbursementAmt.Focus();
                //    return;
                //}
            }
            #endregion

            try
            {
                string[] ProjectTokens = ddlProjFilter.SelectedValue.ToString().Split('|');
                string lbNODS = string.Empty;
                DateTime TransDate = DateTime.Parse(txtTransDate.Text);

                int MatchingGrant = 0;
                decimal EligibleAmt = 0;

                if (txtEligibleAmt.Visible)
                {
                    MatchingGrant = int.Parse(ddlMatchingGrant.SelectedValue.ToString());
                    EligibleAmt = decimal.Parse(txtEligibleAmt.Text);
                }

                //foreach (ListItem listItem in lbNOD.Items)
                //{
                //    if (listItem.Selected == true)
                //    {
                //        if (lbNODS.Length == 0)
                //            lbNODS = listItem.Value;
                //        else
                //            lbNODS = lbNODS + "|" + listItem.Value;
                //    }
                //}

                DataTable dtPCR = null;
                PCRDetails pcr = new PCRDetails();

                if (PCRID == "")
                {
                    dtPCR = ProjectCheckRequestData.SubmitPCR(int.Parse(ProjectTokens[0]), TransDate, int.Parse(ddlProgram.SelectedValue.ToString()),
                        chkLegalReview.Checked, chkLCB.Checked, EligibleAmt, MatchingGrant,
                        decimal.Parse(txtDisbursementAmt.Text), ddlPayee.Items.Count > 0 ? int.Parse(ddlPayee.SelectedValue.ToString()) : 0, int.Parse(ddlStatus.SelectedValue.ToString()),
                        txtNotes.Text, GetUserId(), lbNODS);
                    if (dtPCR.Rows.Count > 0)
                    {
                        pcr.TransID = Convert.ToInt32(dtPCR.Rows[0]["TransID"].ToString());
                        pcr.ProjectCheckReqID = Convert.ToInt32(dtPCR.Rows[0]["ProjectCheckReqId"].ToString());
                        pcr.pcrDetails = dtPCR.Rows[0]["pcq"].ToString();

                        foreach (ListItem listItem in lbNOD.Items)
                        {
                            if (listItem.Selected == true)
                            {
                                ProjectCheckRequestData.PCR_Submit_NOD(pcr.ProjectCheckReqID, Convert.ToInt32(listItem.Value));
                            }
                        }
                        BindTransDate(dtPCR);
                    }
                    lblMessage.Text = "Successfully Saved Check Request";
                }
                else
                {
                    //Get PCR Disbursement Details Total
                    decimal TotalDisbursementDetail = ProjectCheckRequestData.GetPCRDisbursemetDetailTotal(int.Parse(PCRID));

                    if (decimal.Parse(txtDisbursementAmt.Text) >= TotalDisbursementDetail)
                    {
                        pcr = ProjectCheckRequestData.UpdatePCR(int.Parse(PCRID), int.Parse(ProjectTokens[0]), TransDate, int.Parse(ddlProgram.SelectedValue.ToString()),
                            chkLegalReview.Checked, chkLCB.Checked, EligibleAmt, MatchingGrant,
                            decimal.Parse(txtDisbursementAmt.Text), int.Parse(ddlPayee.SelectedValue.ToString()), int.Parse(ddlStatus.SelectedValue.ToString()),
                            txtNotes.Text, GetUserId(), lbNODS);
                        lblMessage.Text = "Successfully Updated Check Request";
                    }
                    else
                    {
                        lblMessage.Text = "Disbursement value cannot be less than total disbursement detail " + TotalDisbursementDetail + " value";
                        txtDisbursementAmt.Focus();
                        return;
                    }
                }

                this.hfTransId.Value = pcr.TransID.ToString();
                this.hfPCRId.Value = pcr.ProjectCheckReqID.ToString();
                this.hfTransAmt.Value = txtDisbursementAmt.Text;

                BindPCRData();
                DisablePCR();
                //ClearPCRForm();
                //ClearPCRDetails();
                this.hfEditPCRId.Value = "";
                pnlDisbursement.Visible = true;
                pnlApprovals.Visible = true;

                ddlDate.Visible = true;
                txtTransDate.Visible = false;

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: btnCRSubmit_Click: " + ex.Message;
            }

        }

        protected void btnPCRTransDetails_Click(object sender, EventArgs e)
        {
            try
            {

                #region Validations
                if (ddlFundTypeCommitments.Items.Count > 1 && ddlFundTypeCommitments.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Select Source";
                    ddlFundTypeCommitments.Focus();
                    return;
                }
                else if (ddlTransType.Items.Count > 1 && ddlTransType.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Select Grant/Loan/Contract";
                    ddlTransType.Focus();
                    return;
                }

                if (txtTransDetailAmt.Text.Trim() == "")
                {
                    lblErrorMsg.Text = "Select Amount";
                    txtTransDetailAmt.Focus();
                    return;
                }
                else if (txtTransDetailAmt.Text.Trim() != "")
                {
                    decimal n;
                    bool isDecimal = decimal.TryParse(txtTransDetailAmt.Text.Trim(), out n);

                    if (!isDecimal || Convert.ToDecimal(txtTransDetailAmt.Text) <= 0)
                    {
                        lblErrorMsg.Text = "Select a valid Amount";
                        txtTransDetailAmt.Focus();
                        return;
                    }
                }
                #endregion

                decimal currentTranAmount = 0;
                decimal currentTranFudAmount = 0;
                decimal currentBalAmount = 0;

                currentTranAmount = Convert.ToDecimal(hfTransAmt.Value);
                currentTranFudAmount = decimal.Parse(txtTransDetailAmt.Text);
                currentBalAmount = Convert.ToDecimal(hfBalAmt.Value);

                hfTransId.Value = this.hfTransId.Value;

                if (hfTransId.Value != null)
                {
                    int transId = Convert.ToInt32(hfTransId.Value);

                    if (gvPTransDetails.Rows.Count == 0)
                        currentBalAmount = currentTranAmount;

                    if (currentBalAmount == 0 && gvPTransDetails.Rows.Count > 0)
                    {
                        lblErrorMsg.Text = "This transaction details are all set. No more funds allowed to add for the transaction.";
                        ClearTransactionDetailForm();
                        DisableButton(btnPCRTransDetails);
                        return;
                    }
                    else if (currentTranFudAmount > currentBalAmount)
                    {
                        currentTranFudAmount = currentBalAmount;
                        lblErrorMsg.Text = "Amount auto adjusted to available fund amount";
                    }

                    ProjectCheckRequestData.AddPCRTransactionFundDetails(int.Parse(hfTransId.Value.ToString()), int.Parse(ddlFundTypeCommitments.SelectedValue.ToString()), int.Parse(ddlTransType.SelectedValue.ToString()), currentTranFudAmount);
                    AddDefaultPCRQuestions();
                    BindPCRTransDetails();
                    ClearTransactionDetailForm();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: btnPCRTransDetails_Click: " + ex.Message;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddlPCRQuestions.Items.Count > 1 && ddlPCRQuestions.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select PCR Question";
                ddlPCRQuestions.Focus();
                return;
            }

            ProjectCheckRequestData.SubmitPCRForm(int.Parse(this.hfPCRId.Value), int.Parse(ddlPCRQuestions.SelectedValue.ToString()), GetUserId());

            lblMessage.Text = "PCR Approvals Saved Successfully";

            ddlPCRQuestions.SelectedIndex = -1;

            BindPCRQuestionsForApproval();
        }
        #endregion

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

        protected string GetFullName()
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetData(Context.User.Identity.GetUserName());
                return dtUser != null ? dtUser.Rows[0][1].ToString() : "";
            }
            catch (Exception)
            {
                return "";
            }
        }

        #region gvPCRData
        protected void gvPCRData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPCRData.EditIndex = e.NewEditIndex;
            BindPCRData();
        }

        protected void gvPCRData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    ClearPCRDetails();

                    CommonHelper.GridViewSetFocus(e.Row);

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        Label lblPCRId = e.Row.FindControl("lblProjectCheckReqId") as Label;
                        Label lblProjectName = e.Row.FindControl("lblProjectName") as Label;

                        this.hfEditPCRId.Value = lblPCRId.Text;

                        DataSet ds = new DataSet();
                        DataTable dtable = new DataTable();
                        ds = ProjectCheckRequestData.GetPCRDetails(int.Parse(lblPCRId.Text));

                        DataRow drPCR = ds.Tables[0].Rows[0];
                        DataRow drTrans = ds.Tables[1].Rows[0];

                        DataTable dtNOD = new DataTable();
                        dtNOD = ds.Tables[4];

                        lblProjName.Text = lblProjectName.Text;

                        foreach (ListItem item in ddlProjFilter.Items)
                        {
                            if (drPCR["ProjectID"].ToString() + '|' + lblProjectName.Text == item.Value.ToString())
                            {
                                ddlProjFilter.ClearSelection();
                                item.Selected = true;
                                BindApplicantName(int.Parse(drPCR["ProjectID"].ToString()));
                            }
                        }

                        txtTransDate.Text = String.IsNullOrEmpty(drPCR["InitDate"].ToString()) ? "" : DateTime.Parse(drPCR["InitDate"].ToString()).ToShortDateString();

                        foreach (ListItem item in ddlPayee.Items)
                        {
                            if (drTrans["PayeeApplicant"].ToString() == item.Value.ToString())
                            {
                                ddlPayee.ClearSelection();
                                item.Selected = true;
                            }
                        }

                        foreach (ListItem item in ddlProgram.Items)
                        {
                            if (drPCR["LkProgram"].ToString() == item.Value.ToString())
                            {
                                ddlProgram.ClearSelection();
                                item.Selected = true;
                                DisplayControls(item.Text);
                            }
                        }

                        foreach (ListItem item in ddlStatus.Items)
                        {
                            if (drTrans["LkStatus"].ToString() == item.Value.ToString())
                            {
                                ddlStatus.ClearSelection();
                                item.Selected = true;
                            }
                        }

                        chkLCB.Checked = String.IsNullOrEmpty(drPCR["LCB"].ToString()) ? false : bool.Parse(drPCR["LCB"].ToString());
                        chkLegalReview.Checked = String.IsNullOrEmpty(drPCR["LegalReview"].ToString()) ? false : bool.Parse(drPCR["LegalReview"].ToString());
                        txtEligibleAmt.Text = String.IsNullOrEmpty(drPCR["MatchAmt"].ToString()) ? "" : Decimal.Round(Decimal.Parse(drPCR["MatchAmt"].ToString()), 2).ToString();
                        txtNotes.Text = String.IsNullOrEmpty(drPCR["Notes"].ToString()) ? "" : drPCR["Notes"].ToString();
                        txtDisbursementAmt.Text = String.IsNullOrEmpty(drTrans["TransAmt"].ToString()) ? "" : Decimal.Round(Decimal.Parse(drTrans["TransAmt"].ToString()), 2).ToString();

                        foreach (ListItem item in ddlMatchingGrant.Items)
                        {
                            if (drPCR["LkFVGrantMatch"].ToString() == item.Value.ToString())
                            {
                                ddlMatchingGrant.ClearSelection();
                                item.Selected = true;
                            }
                        }

                        foreach (ListItem item in lbNOD.Items)
                        {
                            foreach (DataRow dr in dtNOD.Rows)
                                if (dr["LKNOD"].ToString() == item.Value.ToString())
                                    item.Selected = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: gvPCRData_RowDataBound: " + ex.Message;
            }
        }

        protected void gvPCRData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.hfEditPCRId.Value = "";
            ClearPCRForm();
            ClearPCRDetails();
            gvPCRData.EditIndex = -1;
            BindPCRData();
        }

        #endregion

        private void DisablePCR()
        {
            // ddlProjFilter.Enabled = false;
            ddlApplicantName.Enabled = false;
            txtTransDate.Enabled = false;
            ddlPayee.Enabled = false;
            ddlProgram.Enabled = false;
            ddlStatus.Enabled = false;
            DisableButton(btnCRSubmit);
            chkLCB.Enabled = false;
            chkLegalReview.Enabled = false;
            lbNOD.Enabled = false;

            if (txtEligibleAmt.Visible)
            {
                txtEligibleAmt.Enabled = false;
                ddlMatchingGrant.Enabled = false;
            }
            else
            {
                txtEligibleAmt.Enabled = false;
                ddlMatchingGrant.Enabled = false;

                txtEligibleAmt.Enabled = false;
                ddlMatchingGrant.Enabled = false;
            }
            txtNotes.Enabled = false;
            txtDisbursementAmt.Enabled = false;
        }

        private void EnablePCR()
        {
            ddlProjFilter.Enabled = true;
            ddlApplicantName.Enabled = true;
            txtTransDate.Enabled = true;
            ddlPayee.Enabled = true;
            ddlProgram.Enabled = true;
            ddlStatus.Enabled = false;
            lbNOD.Enabled = true;
            chkLCB.Enabled = true;
            chkLegalReview.Enabled = true;

            if (txtEligibleAmt.Visible)
            {
                txtEligibleAmt.Enabled = true;
                ddlMatchingGrant.Enabled = true;
            }
            else
            {
                txtEligibleAmt.Enabled = true;
                ddlMatchingGrant.Enabled = true;

                txtEligibleAmt.Enabled = true;
                ddlMatchingGrant.Enabled = true;
            }
            txtNotes.Enabled = true;
            txtDisbursementAmt.Enabled = true;
        }

        private void ClearPCRForm()
        {
            ddlApplicantName.Items.Clear();
            lblProjName.Text = "--";
            txtTransDate.Text = "";
            if (ddlPayee.Items.Count > 0) ddlPayee.SelectedIndex = 0;
            if (ddlProgram.Items.Count > 0) ddlProgram.SelectedIndex = 0;
            if (ddlStatus.Items.Count > 0) ddlStatus.SelectedIndex = 0;
            EnableButton(btnCRSubmit);
            chkLCB.Checked = false;
            chkLegalReview.Checked = false;

            if (txtEligibleAmt.Visible)
            {
                txtEligibleAmt.Text = "";
                if (ddlMatchingGrant.Items.Count > 0) ddlMatchingGrant.SelectedIndex = 0;
            }
            else
            {
                lblAmtEligibleForMatch.Visible = true;
                txtEligibleAmt.Visible = true;
                ddlMatchingGrant.Visible = true;
                lblMatchingGrant.Visible = true;

                txtEligibleAmt.Text = "";
                if (ddlMatchingGrant.Items.Count > 0) ddlMatchingGrant.SelectedIndex = 0;
            }
            ddlDate.Visible = false;
            txtTransDate.Visible = true;
            lbNOD.SelectedIndex = -1;
            txtNotes.Text = "";
            txtDisbursementAmt.Text = "";
        }

        private void ClearPCRDetails()
        {
            gvPTransDetails.DataSource = null;
            gvPTransDetails.DataBind();

            lbNOD.SelectedIndex = -1;
            ddlPCRQuestions.SelectedIndex = -1;

        }

        protected void ddlProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayControls(ddlProgram.SelectedItem.ToString());
        }

        private void DisplayControls(string SelectedText)
        {
            if (SelectedText != "Farm/Forest Viability")
            {
                lblAmtEligibleForMatch.Visible = false;
                txtEligibleAmt.Visible = false;
                ddlMatchingGrant.Visible = false;
                lblMatchingGrant.Visible = false;
            }
            else
            {
                lblAmtEligibleForMatch.Visible = true;
                txtEligibleAmt.Visible = true;
                ddlMatchingGrant.Visible = true;
                lblMatchingGrant.Visible = true;
            }
        }

        protected void gvPCRData_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetPCRSelectedRecord(gvPCRData);
        }

        private void GetPCRSelectedRecord(GridView gvPCRData)
        {
            this.hfPCRId.Value = "";
            this.hfTransId.Value = "";
            this.hfTransAmt.Value = "0";

            for (int i = 0; i < gvPCRData.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)gvPCRData.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rb != null)
                {
                    if (rb.Checked)
                    {
                        HiddenField hf = (HiddenField)gvPCRData.Rows[i].Cells[0].FindControl("hfIDs");
                        if (hf != null)
                        {
                            string[] tokens = hf.Value.Split('|');
                            lblProjName.Text = tokens[1];

                            this.hfPCRId.Value = tokens[0];
                            this.hfTransId.Value = tokens[1];
                            this.hfTransAmt.Value = tokens[2];
                        }
                        break;
                    }
                }
            }
        }

        #region gvQuestionsForApproval
        protected void gvQuestionsForApproval_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQuestionsForApproval.EditIndex = -1;
            BindPCRQuestionsForApproval();
        }

        protected void gvQuestionsForApproval_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQuestionsForApproval.EditIndex = e.NewEditIndex;
            BindPCRQuestionsForApproval();
        }

        protected void gvQuestionsForApproval_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                bool isApproved = Convert.ToBoolean(((CheckBox)gvQuestionsForApproval.Rows[rowIndex].FindControl("cbApproved")).Checked);
                int ProjectCheckReqQuestionid = Convert.ToInt32(((HiddenField)gvQuestionsForApproval.Rows[rowIndex].FindControl("hfProjectCheckReqQuestionID")).Value);

                ProjectCheckRequestData.UpdatePCRQuestionsApproval(ProjectCheckReqQuestionid, isApproved, GetUserId());

                gvQuestionsForApproval.EditIndex = -1;
                BindPCRQuestionsForApproval();



                //if (((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim() != "")
                //{
                //    decimal n;
                //    bool isDecimal = decimal.TryParse(((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim(), out n);

                //    if (!isDecimal || Convert.ToDecimal(((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim()) <= 0)
                //    {
                //        lblErrorMsg.Text = "Select a valid transaction amount";
                //        ((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Focus();
                //        return;
                //    }
                //}

                //decimal amount = Convert.ToDecimal(((TextBox)gvPTransDetails.Rows[rowIndex].FindControl("txtAmount")).Text);
                //int transType = Convert.ToInt32(((DropDownList)gvPTransDetails.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                //int detailId = Convert.ToInt32(((Label)gvPTransDetails.Rows[rowIndex].FindControl("lblDetId")).Text);

                //decimal old_amount = Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                //decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                //decimal allowed_amount = old_amount + bal_amount;

                //if (amount == allowed_amount)
                //{
                //    lblErrorMsg.Text = "Transaction is complete, more funds not allowed";
                //}
                //else if (amount > allowed_amount)
                //{
                //    amount = allowed_amount;
                //    lblErrorMsg.Text = "Amount auto adjusted to available fund amount";
                //}
                //else if (amount < allowed_amount)
                //{
                //    if (!btnPCRTransDetails.Enabled)
                //    {
                //        EnableButton(btnPCRTransDetails);
                //        DisableButton(btnSubmit);
                //    }
                //}
                //FinancialTransactions.UpdateTransDetails(detailId, transType, amount);
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: gvPTransDetails_RowUpdating: " + ex.Message;
            }
        }

        protected void gvQuestionsForApproval_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //CheckBox cbApproved = (e.Row.FindControl("cbApproved") as CheckBox);
                    //Label lblProjectCheckReqQuestionID = (e.Row.FindControl("hfProjectCheckReqQuestionID") as Label);
                    //Label lblApproved = (e.Row.FindControl("lblApproved") as Label);


                    //if (cbApproved != null)
                    //{
                    //    //cbApproved.Checked = bool.Parse(lblApproved.Text);
                    //}
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

            }
        }
        #endregion

        protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDate.SelectedIndex > 0)
            {
                DataTable dtEPCR = ProjectCheckRequestData.GetPCRDataById(ddlDate.SelectedItem.Value);
                this.hfPCRId.Value = dtEPCR.Rows[0]["ProjectCheckReqId"].ToString();
                this.hfTransId.Value = dtEPCR.Rows[0]["transid"].ToString();
                this.hfTransAmt.Value = dtEPCR.Rows[0]["TransAmt"].ToString();
                this.hfProjId.Value = dtEPCR.Rows[0]["ProjectID"].ToString();
                EnableButton(btnPCRTransDetails);
                DisableButton(btnCRSubmit);
                BindPCRTransDetails();
                BindPCRQuestionsForApproval();
                ddlPCRQuestions.SelectedIndex = -1;
                pnlApprovals.Visible = true;
                pnlDisbursement.Visible = true;
                fillPCRDetails(Convert.ToInt32(hfPCRId.Value), dtEPCR.Rows[0]["project_name"].ToString());
                DisablePCR();
            }
            else
            {
                lblErrorMsg.Text = "Please select the existing check request date selection.";
                pnlApprovals.Visible = false;
                pnlDisbursement.Visible = false;

            }
        }

        protected void rdBtnSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlApprovals.Visible = false;
            pnlDisbursement.Visible = false;
            ClearPCRForm();
            if (rdBtnSelect.SelectedIndex == 0)
            {

                EnablePCR();
                ddlDate.Visible = false;
                txtTransDate.Visible = true;
                EnableButton(btnCRSubmit);
            }
            else
            {
                ddlProjFilter.SelectedIndex = 0;
                BindExistingPCR();
                EnableButton(btnPCRTransDetails);
                DisableButton(btnCRSubmit);
                DisablePCR();
                ddlDate.Visible = true;
                txtTransDate.Visible = false;
            }
        }

        protected void fillPCRDetails(int pcrId, string projName)
        {
            try
            {
                this.hfEditPCRId.Value = pcrId.ToString();
                DataSet ds = new DataSet();
                DataTable dtable = new DataTable();
                ds = ProjectCheckRequestData.GetPCRDetails(pcrId);

                DataRow drPCR = ds.Tables[0].Rows[0];
                DataRow drTrans = ds.Tables[1].Rows[0];

                DataTable dtNOD = new DataTable();
                dtNOD = ds.Tables[4];

                lblProjName.Text = projName;

                foreach (ListItem item in ddlProjFilter.Items)
                {
                    if (drPCR["ProjectID"].ToString() + '|' + projName == item.Value.ToString())
                    {
                        ddlProjFilter.ClearSelection();
                        item.Selected = true;
                        BindApplicantName(int.Parse(drPCR["ProjectID"].ToString()));
                    }
                }

                txtTransDate.Text = String.IsNullOrEmpty(drPCR["InitDate"].ToString()) ? "" : DateTime.Parse(drPCR["InitDate"].ToString()).ToShortDateString();

                foreach (ListItem item in ddlPayee.Items)
                {
                    if (drTrans["PayeeApplicant"].ToString() == item.Value.ToString())
                    {
                        ddlPayee.ClearSelection();
                        item.Selected = true;
                    }
                }

                foreach (ListItem item in ddlProgram.Items)
                {
                    if (drPCR["LkProgram"].ToString() == item.Value.ToString())
                    {
                        ddlProgram.ClearSelection();
                        item.Selected = true;
                        DisplayControls(item.Text);
                    }
                }

                foreach (ListItem item in ddlStatus.Items)
                {
                    if (drTrans["LkStatus"].ToString() == item.Value.ToString())
                    {
                        ddlStatus.ClearSelection();
                        item.Selected = true;
                    }
                }

                if (ds.Tables[6].Rows.Count > 0)
                {
                    DataRow drPayee = ds.Tables[6].Rows[0];
                    foreach (ListItem item in ddlPayee.Items)
                    {
                        if (drPayee["applicantid"].ToString() == item.Value.ToString())
                        {
                            ddlPayee.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }

                chkLCB.Checked = String.IsNullOrEmpty(drPCR["LCB"].ToString()) ? false : bool.Parse(drPCR["LCB"].ToString());
                chkLegalReview.Checked = String.IsNullOrEmpty(drPCR["LegalReview"].ToString()) ? false : bool.Parse(drPCR["LegalReview"].ToString());
                txtEligibleAmt.Text = String.IsNullOrEmpty(drPCR["MatchAmt"].ToString()) ? "" : Decimal.Round(Decimal.Parse(drPCR["MatchAmt"].ToString()), 2).ToString();
                txtNotes.Text = String.IsNullOrEmpty(drPCR["Notes"].ToString()) ? "" : drPCR["Notes"].ToString();
                txtDisbursementAmt.Text = String.IsNullOrEmpty(drTrans["TransAmt"].ToString()) ? "" : Decimal.Round(Decimal.Parse(drTrans["TransAmt"].ToString()), 2).ToString();

                foreach (ListItem item in ddlMatchingGrant.Items)
                {
                    if (drPCR["LkFVGrantMatch"].ToString() == item.Value.ToString())
                    {
                        ddlMatchingGrant.ClearSelection();
                        item.Selected = true;
                    }
                }

                foreach (ListItem item in lbNOD.Items)
                {
                    foreach (DataRow dr in dtNOD.Rows)
                        if (dr["LKNOD"].ToString() == item.Value.ToString())
                            item.Selected = true;
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
                throw;
            }
        }

        protected void ddlFundTypeCommitments_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFundTypeCommitments.SelectedIndex != 0)
            {
                string[] tokens = ddlProjFilter.SelectedValue.ToString().Split('|');


                DataTable dtable = FinancialTransactions.GetCommittedFundDetailsByFundId(Convert.ToInt32(tokens[0].ToString()), Convert.ToInt32(ddlFundTypeCommitments.SelectedValue.ToString()));

                lblCommittedAvailFunds.Text = Convert.ToDecimal(dtable.Rows[0]["CommitmentAmount"].ToString()).ToString("#.##");

                ddlTransType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(tokens[0].ToString()), Convert.ToInt32(ddlFundTypeCommitments.SelectedValue.ToString())); ;
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "fundtype";
                ddlTransType.DataBind();
                if (ddlTransType.Items.Count > 1)
                    ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                //ddlTransType.DataSource = dtable;
                //ddlTransType.DataValueField = "lktranstype";
                //ddlTransType.DataTextField = "fundtype";
                //ddlTransType.DataBind();
                //ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            else
            {
                ddlTransType.Items.Clear();
            }
        }
    }
}