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
    public partial class ProjectCheckRequest : System.Web.UI.Page
    {
        string Pagename = "ProjectCheckRequest";
        DataTable dtProjects;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            if (!IsPostBack)
            {
                BindProjects();
                //BindTransDate();
                BindApplicantName();
                BindPayee();
                BindProgram();
                BindMatchingGrant();
                BindFundTypeCommitments();
                BindTransType();
                BindStateVHCBS();
                BindNODData();
                BindPCRQuestions(false);
            }
        }

        protected void BindProjects()
        {
            try
            {
                dtProjects = new DataTable();
                dtProjects = ProjectCheckRequestData.GetData("PCR_Projects");
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

        protected void BindApplicantName()
        {
            try
            {
                DataTable dtApplicantname;
                dtApplicantname = new DataTable();
                dtApplicantname = ProjectCheckRequestData.GetData("PCR_ApplicantName");

                ddlApplicantName.DataSource = dtApplicantname;
                ddlApplicantName.DataValueField = "Applicantname";
                ddlApplicantName.DataTextField = "Applicantname";
                ddlApplicantName.DataBind();
                ddlApplicantName.Items.Insert(0, new ListItem("Select", "NA"));
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

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProjFilter.SelectedIndex != 0)
            {
                string[] tokens = ddlProjFilter.SelectedValue.ToString().Split('|');
                lblProjName.Text = tokens[1];
            }
            else
            {
                lblProjName.Text = "--";
            }
        }

        protected void btnCRSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string[] ProjectTokens = ddlProjFilter.SelectedValue.ToString().Split('|');

                DateTime TransDate = DateTime.Parse(txtTransDate.Text);//DateTime.Parse(ddlDate.SelectedValue.ToString())

                PCRDetails pcr = ProjectCheckRequestData.SubmitPCR(int.Parse(ProjectTokens[0]), TransDate, int.Parse(ddlProgram.SelectedValue.ToString()),
                    chkLegalReview.Checked, chkFinalPayment.Checked, chkLCB.Checked, decimal.Parse(txtEligibleAmt.Text), int.Parse(ddlMatchingGrant.SelectedValue.ToString()),
                    decimal.Parse(txtDisbursementAmt.Text), int.Parse(ddlPayee.SelectedValue.ToString()),
                    txtNotes.Text, 1234);

                this.hfTransId.Value = pcr.TransID.ToString();
                this.hfTransAmt.Value = txtDisbursementAmt.Text;
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
                ProjectCheckRequestData.AddPCRTransactionFundDetails(int.Parse(hfTransId.Value.ToString()), int.Parse(ddlFundTypeCommitments.SelectedValue.ToString()), int.Parse(ddlTransType.SelectedValue.ToString()), 
                    decimal.Parse(txtTransDetailAmt.Text));

                BindPCRTransDetails();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "ProjectCheckRequest: btnPCRTransDetails_Click: " + ex.Message;
            }
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

        protected void chkLegalReview_CheckedChanged(object sender, EventArgs e)
        {
            BindPCRQuestions(chkLegalReview.Checked);
        }
    }
}