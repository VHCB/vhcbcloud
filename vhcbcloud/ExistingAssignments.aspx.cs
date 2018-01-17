﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ExistingAssignments : System.Web.UI.Page
    {
        string Pagename = "ExistingAssignments";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

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

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdBtnSelection.SelectedIndex == 0)
            {
                Response.Redirect("Assignments.aspx");
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void gvAssignments_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvAssignments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                string TransId = ((Label)gvAssignments.Rows[rowIndex].FindControl("lblTransId")).Text.Trim();

                if (TransId.ToString() != "")
                {
                    FinancialTransactions.InactivateFinancialTransByTransId(Convert.ToInt32(TransId));

                    BindAssignmentTransGrid();

                    lblRErrorMsg.Text = "Transaction was successfully inactivated. All details related to this transaction also have been inactivated.";
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        protected void gvAssignments_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvAssignments_RowCreated(object sender, GridViewRowEventArgs e)
        {

        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblRErrorMsg.Text = "";
            GetSelectedTransId(gvAssignments);
            gvAssignments.EditIndex = -1;
            BindGvToAssignments();
            pnlTranDetails.Visible = true;
            ClearDetailForm();

            PopulateDetailFormStaticFields();
        }

        private void PopulateDetailFormStaticFields()
        {
            //lblFromFundNumber.Text = hfFromAccountNumber.Value;
            lblFromFundName.Text = hfFromFundName.Value;
            lblFromTransType.Text = hfFromTransType.Value;
        }

        private void ClearDetailForm()
        {
            txtToAmt.Text = "";
            txtToProjNum.Text = "";
            //lblFromFundNumber.Text = "";
            lblFromFundName.Text = "";
            lblFromTransType.Text = "";
            btnToAssignmentDetailSubmit.Text = "Submit";
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
        protected void gvAssignments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

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

           // Label lblFundNum = (Label)gvFGM.Rows[0].Cells[2].FindControl("lblFundName");
            Label lblFundName = (Label)gvFGM.Rows[0].Cells[2].FindControl("lblFundName");
            Label lblTransType = (Label)gvFGM.Rows[0].Cells[3].FindControl("lblTransType");

            //lblFromFundNumber.Text = lblFundNum.Text;
            hfFromFundName.Value= lblFundName.Text;
            hfFromTransType.Value = lblTransType.Text;

        }

        private void SetRadioButton(string TransId)
        {
            if (TransId.ToString() != string.Empty)
            {
                for (int i = 0; i < gvAssignments.Rows.Count; i++)
                {
                    HiddenField hf = (HiddenField)gvAssignments.Rows[i].Cells[0].FindControl("HiddenField1");
                    if (hf != null)
                    {
                        if (hf.Value == TransId.ToString())
                        {
                            ((RadioButton)gvAssignments.Rows[i].Cells[0].FindControl("rdBtnSelect")).Checked = true;
                            break;
                        }
                    }
                }
            }
        }

        private void getDetails(DataTable dt)
        {
            //lblAvailFund.Text = "";
            //lblAvailVisibleFund.Text = "";
            hfProjId.Value = dt.Rows[0][0].ToString();

            try
            {

                if (dt.Rows.Count != 0)
                {
                    hfProjId.Value = dt.Rows[0][0].ToString();
                    pnlTranDetails.Visible = false;
                    lblRErrorMsg.Text = "";

                    //ClearTransactionDetailForm();
                    DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(hfProjId.Value));

                    lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                    dt = new DataTable();
                    dt = FinancialTransactions.GetGranteeByProject(Convert.ToInt32(hfProjId.Value));

                    //if (dt.Rows.Count > 0)
                    //{
                    //    lblGrantee.Text = dt.Rows[0]["Applicantname"].ToString();
                    //    hfGrantee.Value = dt.Rows[0]["applicantid"].ToString();
                    //}
                    //else
                    //{
                    //    lblGrantee.Text = "";
                    //    hfGrantee.Value = "";
                    //}

                    ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;

                    BindAssignmentTransGrid();
                }
                else
                {
                    lblProjName.Text = "";
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }


            //hfReallocateGuid.Value = "";
            //hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";
            ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;
        }

        private void BindAssignmentTransGrid()
        {
            try
            {
                gvAssignments.DataSource = null;
                gvAssignments.DataBind();

                DataTable dtTrans = FinancialTransactions.GetAssignmentTransactionsByProject(Convert.ToInt32(hfProjId.Value), 26552, cbActiveOnly.Checked);

                if (dtTrans.Rows.Count > 0)
                {
                    gvAssignments.DataSource = dtTrans;
                    gvAssignments.DataBind();
                    dvAssignmentsGrid.Visible = true;
                }
                else
                {
                    gvAssignments.DataSource = null;
                    gvAssignments.DataBind();
                    dvAssignmentsGrid.Visible = false;
                }



            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAssignmentProjectslist(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            //dt = Project.GetProjects("GetAssignmentProjectslistByFilter", prefixText);
            dt = Project.GetProjects("GetProjectsByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAssignmentProjectslistByFilter(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();
            //dt = Project.GetProjects("GetAssignmentProjectslistByFilter", prefixText);
            dt = Project.GetProjects("GetProjectsByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if(dt.Rows[i][0].ToString() != contextKey)
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }

        protected void hdnAssignmentProjValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();

            if (txtFromProjectNum.Text == "")
            {
                lblRErrorMsg.Text = "Please select project number";
                return;
            }
            dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());

            ///populate the form based on retrieved data
            getDetails(dt);
        }

        protected void hdnAssignmentToProjectValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();

            if (txtToProjNum.Text == "")
            {
                lblRErrorMsg.Text = "Please select project number";
                return;
            }
            dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            hfToProjId.Value = dt.Rows[0][0].ToString();
        }

        protected void btnAssignmentDetailSubmit_Click(object sender, EventArgs e)
        {
            txtToAmt.Text = Regex.Replace(txtToAmt.Text, "[^0-9a-zA-Z.]+", "");

            if (txtToProjNum.Text == "")
            {
                lblRErrorMsg.Text = "Select assignment to project";
                txtToProjNum.Focus();
                return;
            }

            if (txtToAmt.Text == "" || Convert.ToDecimal(txtToAmt.Text) == 0)
            {
                lblRErrorMsg.Text = "Please enter a non zero amount before proceed";
                txtToAmt.Focus();
                return;
            }

            hfTransId.Value = GetTransId().ToString();
            if (hfTransId.Value != null)
            {
                if (btnToAssignmentDetailSubmit.Text.ToLower() == "submit")
                {
                    DataTable dtFundDet = new DataTable();
                    dtFundDet = FinancialTransactions.GetAssignmentByTransId(Convert.ToInt32(hfTransId.Value));

                    decimal tranAmount = 0;
                    decimal totFundAmt = 0;
                    decimal totBalAmt = 0;
                    decimal totDetailAmount = 0;

                    tranAmount = Convert.ToDecimal(this.hfTransAmt.Value);

                    if (dtFundDet.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtFundDet.Rows.Count; i++)
                        {
                            if (Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString()) > 0)
                                totDetailAmount += Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());
                        }
                    }

                    totBalAmt = tranAmount - totDetailAmount;

                    if (totBalAmt == 0)
                    {
                        lblRErrorMsg.Text = "Assignment is complete, more funds not allowed";
                        return;
                    }

                    if (Convert.ToDecimal(txtToAmt.Text) > totBalAmt)
                    {
                        lblRErrorMsg.Text = "Amount can't be more than available assignment funds (" + CommonHelper.myDollarFormat(totBalAmt) + ")";
                        txtToAmt.Focus();
                        return;
                    }

                    FinancialTransactions.InsertAssignmentDetail((Convert.ToInt32(hfTransId.Value)), Convert.ToInt32(hfToProjId.Value.ToString()), Convert.ToDecimal(txtToAmt.Text));
                    lblRErrorMsg.Text = "Assignment was added successfully";
                    BindGvToAssignments();
                    ClearToAssignmentsForm();
                }
                else
                {
                    int detailId = Convert.ToInt32(hfDetailId.Value);

                    decimal old_amount = Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                    decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                    decimal allowed_amount = old_amount + bal_amount;

                    decimal amount = Convert.ToDecimal(txtToAmt.Text); ;
                    if (amount == allowed_amount)
                    {
                        lblRErrorMsg.Text = "Transaction is complete, more funds not allowed";
                    }
                    else if (amount > allowed_amount)
                    {
                        lblRErrorMsg.Text = "Amount can't be more than available assignment funds (" + CommonHelper.myDollarFormat(bal_amount) + ")";
                        txtToAmt.Focus();
                        return;
                    }

                    FinancialTransactions.UpdateAssignmentDetails(detailId, Convert.ToInt32(hfToProjId.Value.ToString()), amount);

                    gvToAssignments.EditIndex = -1;
                    ClearToAssignmentsForm();
                    BindGvToAssignments();
                }
            }
        }

        protected void gvToAssignments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvToAssignments.EditIndex = -1;
            ClearToAssignmentsForm();
            BindGvToAssignments();
        }

        private void ClearToAssignmentsForm()
        {
            txtToProjNum.Text = "";
            txtToAmt.Text = "";
            btnToAssignmentDetailSubmit.Text = "Submit";
        }

        protected void gvToAssignments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnToAssignmentDetailSubmit.Text = "Update";
                    dvToAssignmentsForm.Visible = true;
                    pnlTranDetails.Visible = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        // e.Row.Cells[11].Controls[0].Visible = false;
                        Label lblDetId = e.Row.FindControl("lblDetId") as Label;
                        hfDetailId.Value = lblDetId.Text;
                        DataRow dr = FinancialTransactions.GetTransactionDetailsByDetailId(Convert.ToInt32(lblDetId.Text));

                        txtToProjNum.Text = dr["ProjectNum"].ToString();
                        txtToAmt.Text = dr["Amount"].ToString();
                        hfToProjId.Value = dr["ProjectId"].ToString(); 
                        //Label lblFundNum = e.Row.FindControl("lblAcctNum") as Label;
                        //Label lblFundName = e.Row.FindControl("lblFundName") as Label;
                        //Label lblTransType = e.Row.FindControl("lblTransType") as Label;
                        //
                        //lblFromFundNumber.Text = lblFundNum.Text;
                        //lblFromFundName.Text = lblFundName.Text;
                        //lblFromTransType.Text = lblTransType.Text;

                        //PopulateDropDown(ddlUsePermit, dr["LandUsePermitID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvbRelocationDetails_RowDataBound", "", ex.Message);
            }
        }

        protected void gvToAssignments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label lblGuid = (Label)gvToAssignments.Rows[e.RowIndex].FindControl("lblProjGuid");

            FinancialTransactions.DeleteAssignmentDetailByGUID(lblGuid.Text);

            ClearToAssignmentsForm();
            BindGvToAssignments();
        }

        protected void gvToAssignments_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvToAssignments.EditIndex = e.NewEditIndex;
            BindGvToAssignments();
        }

        private void BindGvToAssignments()
        {
            try
            {
                DataTable dtFundDet = new DataTable();

                dtFundDet = FinancialTransactions.GetAssignmentByTransId(Convert.ToInt32(hfTransId.Value));

                if (dtFundDet.Rows.Count > 0)
                {
                    gvToAssignments.DataSource = dtFundDet;
                    gvToAssignments.DataBind();

                    dvToAssignmentsGrid.Visible = true;

                    decimal tranAmount = 0;
                    decimal totFundAmt = 0;
                    decimal totBalAmt = 0;
                    decimal totDetailAmount = 0;

                    hfBalAmt.Value = "";
                        tranAmount = Convert.ToDecimal(this.hfTransAmt.Value);

                        Label lblTotAmt = (Label)gvToAssignments.FooterRow.FindControl("lblFooterAmount");
                        Label lblBalAmt = (Label)gvToAssignments.FooterRow.FindControl("lblFooterBalance");

                        if (dtFundDet.Rows.Count > 0)
                        {
                            for (int i = 0; i < dtFundDet.Rows.Count; i++)
                            {
                                totFundAmt += Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());

                                if (Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString()) > 0)
                                    totDetailAmount += Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());
                            }
                        }

                        totBalAmt = tranAmount - totDetailAmount;
                        hfBalAmt.Value = totBalAmt.ToString();

                        lblTotAmt.Text = CommonHelper.myDollarFormat(totDetailAmount);
                        lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                        if (btnToAssignmentDetailSubmit.Text.ToLower() == "submit")// When Edit mode form needs to show
                        {
                            if (lblBalAmt.Text != "$0.00")
                            {
                                //tblToAssignment.Visible = true;
                                dvToAssignmentsForm.Visible = true;
                                // btnToAssignmentDetailSubmit.Visible = true;
                                lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                                //btnNewTransaction.Visible = false;
                                DisableToAssignmentsForm();
                            }
                            if (lblBalAmt.Text == "$0.00")
                            {
                                //tblToAssignment.Visible = false;
                                dvToAssignmentsForm.Visible = false;
                                // btnToAssignmentDetailSubmit.Visible = false;
                                //CommonHelper.DisableButton(btnToAssignmentDetailSubmit);
                                //btnNewTransaction.Visible = true;
                                //hfReallocateGuid.Value = "";
                                EnableToAssignmentsForm();
                            }
                        }
                }
                else
                {
                    gvToAssignments.DataSource = null;
                    gvToAssignments.DataBind();

                    dvToAssignmentsGrid.Visible = false;
                    dvToAssignmentsForm.Visible = true;
                    lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                    //btnNewTransaction.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }

        private void DisableToAssignmentsForm()
        {
            //txtFromProjNum.Enabled = false;
            //ddlRFromFund.Enabled = false;
            //ddlRFromFundType.Enabled = false;
            //txtRfromDate.Enabled = false;
            //txtRfromAmt.Enabled = false;
        }

        private void EnableToAssignmentsForm()
        {
            //txtFromProjNum.Enabled = true;
            //ddlRFromFund.Enabled = true;
            //ddlRFromFundType.Enabled = true;
            //txtRfromDate.Enabled = true;
            //txtRfromAmt.Enabled = true;
        }

        protected void btnNewTransaction_Click(object sender, EventArgs e)
        {

        }

        private void LogError(string pagename, string method, string message, string error)
        {
            lblRErrorMsg.Visible = true;
            if (message == "")
            {
                lblRErrorMsg.Text = Pagename + ": " + method + ": Error Message: " + error;
            }
            else
                lblRErrorMsg.Text = Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error;
        }

        private void LogMessage(string message)
        {
            lblRErrorMsg.Visible = true;
            lblRErrorMsg.Text = message;
        }
    }
}