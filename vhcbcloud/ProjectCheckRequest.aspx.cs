using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
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
                BindProjects();
                //BindTransDate();
               // BindApplicantName();
                BindPayee();
                BindProgram();
                BindStatus();
                BindMatchingGrant();
                BindFundTypeCommitments();
                BindTransType();
                BindStateVHCBS();
                BindNODData();
                BindPCRQuestions(false);

                BindPCRData();
            }
            GetPCRSelectedRecord(gvPCRData);
        }

        #region BindData

        protected void BindProjects()
        {
            try
            {
                dtProjects = new DataTable();
                dtProjects = ProjectCheckRequestData.GetData("PCR_Projects");
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

        protected void BindTransDate()
        {
            try
            {
                DataTable dtdate;
                dtdate = new DataTable();
                dtdate = ProjectCheckRequestData.GetData("PCR_Dates");

                ddlDate.DataSource = dtdate;
                ddlDate.DataValueField = "Date";
                ddlDate.DataTextField = "Date";
                ddlDate.DataBind();
                ddlDate.Items.Insert(0, new ListItem("Select", "NA"));
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
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void BindPayee()
        {
            try
            {
                DataTable dtPayee;
                dtPayee = new DataTable();
                dtPayee = ProjectCheckRequestData.GetData("PCR_Payee");

                ddlPayee.DataSource = dtPayee;
                ddlPayee.DataValueField = "ApplicantId";
                ddlPayee.DataTextField = "Applicantname";
                ddlPayee.DataBind();
                ddlPayee.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: BindPayee: " + ex.Message;
            }

        }

        protected void BindProgram()
        {
            try
            {
                DataTable dtProgram;
                dtProgram = new DataTable();
                dtProgram = ProjectCheckRequestData.GetData("PCR_Program");

                ddlProgram.DataSource = dtProgram;
                ddlProgram.DataValueField = "typeid";
                ddlProgram.DataTextField = "Description";
                ddlProgram.DataBind();
                ddlProgram.Items.Insert(0, new ListItem("Select", "NA"));
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
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
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

        protected void BindFundTypeCommitments()
        {
            try
            {
                DataTable dtFundType;
                dtFundType = new DataTable();
                dtFundType = ProjectCheckRequestData.GetData("PCR_FundName_Commitments");

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

        protected void BindStateVHCBS()
        {
            try
            {
                DataTable dtFundType;
                dtFundType = new DataTable();
                dtFundType = ProjectCheckRequestData.GetData("PCR_State_VHCBS");

                ddlStateVHCBS.DataSource = dtFundType;
                ddlStateVHCBS.DataValueField = "StateAcctnum";
                ddlStateVHCBS.DataTextField = "StateAcctnum";
                ddlStateVHCBS.DataBind();
                ddlStateVHCBS.Items.Insert(0, new ListItem("Select", "NA"));
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
                        DisableButton(btnPCRTransDetails);

                    if (lblBalAmt.Text != "$0.00")
                        lblErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = Pagename + ": btnCRSubmit_Click: " + ex.Message;
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

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                ClearPCRForm();

                BindPCRTransDetails();

                lbNOD.SelectedIndex = -1;
                ddlPCRQuestions.SelectedIndex = -1;

                DataTable dtNOD = new DataTable();
                dtNOD = ProjectCheckRequestData.GetPCRNODDetails(this.hfPCRId.Value);

                foreach (ListItem item in lbNOD.Items)
                {
                    foreach(DataRow dr in dtNOD.Rows)
                        if(dr["LKNOD"].ToString() == item.Value.ToString())
                            item.Selected = true;
                }

                DataTable dtQuestions = new DataTable();
                dtQuestions = ProjectCheckRequestData.GetPCRQuestions(this.hfPCRId.Value);

                if (dtQuestions.Rows.Count > 0)
                {
                    foreach (ListItem item in ddlPCRQuestions.Items)
                    {
                        if (dtQuestions.Rows[0]["LkPCRQuestionsID"].ToString() == item.Value.ToString())
                        {
                            ddlPCRQuestions.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }
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
                string[] tokens = ddlProjFilter.SelectedValue.ToString().Split('|');
                lblProjName.Text = tokens[1];
                BindApplicantName(int.Parse(tokens[0]));
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
                        EnableButton(btnPCRTransDetails);
                }
                FinancialTransactions.UpdateTransDetails(detailId, transType, amount);

                gvPTransDetails.EditIndex = -1;
                BindPCRTransDetails();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: btnPCRTransDetails_Click: " + ex.Message;
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
            try
            {
                string[] ProjectTokens = ddlProjFilter.SelectedValue.ToString().Split('|');

                DateTime TransDate = DateTime.Parse(txtTransDate.Text);

                int MatchingGrant=0;
                decimal EligibleAmt = 0;

                if (txtEligibleAmt.Visible)
                {
                    MatchingGrant = int.Parse(ddlMatchingGrant.SelectedValue.ToString());
                    EligibleAmt = decimal.Parse(txtEligibleAmt.Text);
                }

                PCRDetails pcr = new PCRDetails();

                if (PCRID == "")
                {
                    pcr = ProjectCheckRequestData.SubmitPCR(int.Parse(ProjectTokens[0]), TransDate, int.Parse(ddlProgram.SelectedValue.ToString()),
                        chkLegalReview.Checked, chkLCB.Checked, EligibleAmt, MatchingGrant,
                        decimal.Parse(txtDisbursementAmt.Text), int.Parse(ddlPayee.SelectedValue.ToString()), int.Parse(ddlStatus.SelectedValue.ToString()),
                        txtNotes.Text, 1234);

                    lblMessage.Text = "Successfully Saved Check Request";
                }
                else
                {
                    pcr = ProjectCheckRequestData.UpdatePCR(int.Parse(PCRID), int.Parse(ProjectTokens[0]), TransDate, int.Parse(ddlProgram.SelectedValue.ToString()),
                        chkLegalReview.Checked, chkLCB.Checked, EligibleAmt, MatchingGrant,
                        decimal.Parse(txtDisbursementAmt.Text), int.Parse(ddlPayee.SelectedValue.ToString()), int.Parse(ddlStatus.SelectedValue.ToString()),
                        txtNotes.Text, 1234);
                    lblMessage.Text = "Successfully Updated Check Request";
                }

                this.hfTransId.Value = pcr.TransID.ToString();
                this.hfPCRId.Value = pcr.ProjectCheckReqID.ToString();
                this.hfTransAmt.Value = txtDisbursementAmt.Text;

                BindPCRData();
                ClearPCRForm();
                this.hfEditPCRId.Value = "";
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

                    ProjectCheckRequestData.AddPCRTransactionFundDetails(int.Parse(hfTransId.Value.ToString()), int.Parse(ddlFundTypeCommitments.SelectedValue.ToString()), int.Parse(ddlTransType.SelectedValue.ToString()),
                    currentTranFudAmount);

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
            string lbNODS = string.Empty;

            foreach (ListItem listItem in lbNOD.Items)
            {
                if (listItem.Selected == true)
                {
                    if (lbNODS.Length == 0)
                        lbNODS = listItem.Value;
                    else
                        lbNODS = lbNODS + "|" + listItem.Value;
                }
            }

            ProjectCheckRequestData.SubmitPCRForm(int.Parse(this.hfPCRId.Value), int.Parse(ddlPCRQuestions.SelectedValue.ToString()),
                true, DateTime.Parse(DateTime.Now.ToString()), 1234, lbNODS);

            lblMessage.Text = "PCR Approvals Saved Successfully";
        }
        #endregion

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
                        
                        txtTransDate.Text = String.IsNullOrEmpty(drPCR["InitDate"].ToString()) ? "" : drPCR["InitDate"].ToString();
                        
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
                        txtEligibleAmt.Text = String.IsNullOrEmpty(drPCR["MatchAmt"].ToString()) ?  "" : drPCR["MatchAmt"].ToString();
                        txtNotes.Text = String.IsNullOrEmpty(drPCR["Notes"].ToString()) ? "" : drPCR["Notes"].ToString();
                        txtDisbursementAmt.Text = String.IsNullOrEmpty(drTrans["TransAmt"].ToString()) ? "" : drTrans["TransAmt"].ToString();

                        foreach (ListItem item in ddlMatchingGrant.Items)
                        {
                            if (drPCR["LkFVGrantMatch"].ToString() == item.Value.ToString())
                            {
                                ddlMatchingGrant.ClearSelection();
                                item.Selected = true;
                            }
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

        private void ClearPCRForm()
        {
            ddlProjFilter.SelectedIndex = 0;
            ddlApplicantName.Items.Clear();
            lblProjName.Text = "--";
            txtTransDate.Text = "";
            ddlPayee.SelectedIndex = 0;
            ddlProgram.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;

            chkLCB.Checked = false;
            chkLegalReview.Checked = false;

            if (txtEligibleAmt.Visible)
            {
                txtEligibleAmt.Text = "";
                ddlMatchingGrant.SelectedIndex = 0;
            }
            else
            {
                lblAmtEligibleForMatch.Visible = true;
                txtEligibleAmt.Visible = true;
                ddlMatchingGrant.Visible = true;
                lblMatchingGrant.Visible = true;

                txtEligibleAmt.Text = "";
                ddlMatchingGrant.SelectedIndex = 0;
            }
            
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
            if (SelectedText == "Farm/Forest Viability")
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
    }
}