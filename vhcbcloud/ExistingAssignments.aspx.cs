﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ExistingAssignments : System.Web.UI.Page
    {
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
            BindAssignmentdDetails(GetTransId());
            pnlTranDetails.Visible = true;
            ClearDetailForm();
        }

        private void ClearDetailForm()
        {
            //lblFundName.Text = "";
            //txtAmt.Text = "";
            //lblUsePermit.Visible = false;
            //ddlUsePermit.Visible = false;
            //try
            //{
            //    ddlTransType.SelectedIndex = 0;
            //    ddlAcctNum.SelectedIndex = 0;
            //    ddlFundName.SelectedIndex = 0;
            //    btnReallocateSubmit.Text = "Submit";
            //}
            //catch (Exception)
            //{ }
        }

        private void BindAssignmentdDetails(int transId)
        {

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

                gvAssignments.DataSource = dtTrans;
                gvAssignments.DataBind();

            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAssignmentProjectslistByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjects("GetAssignmentProjectslistByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
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
        }

        private void getToDetails(DataTable dt)
        {

        }

        protected void ddlToFund_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlToFundName_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnReallocateSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void btnAssignmentDetailSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}