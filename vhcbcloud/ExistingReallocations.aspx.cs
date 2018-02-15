using System;
using System.Collections;
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
    public partial class ExistingReallocations : System.Web.UI.Page
    {
        private int BOARD_RELOCATION = 240;
        private int TRANS_PENDING_STATUS = 261;
        private int ActiveOnly = 1;

        string Pagename = "ExistingReallocations";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rdBtnSelection.SelectedIndex = 1;
                hfReallocateGuid.Value = "";
                BindFundAccounts();
            }
            if (rdBtnSelection.SelectedIndex == 0)
            {
                txtFromCommitedProjNum.Visible = false;
            }
            else
            {
                txtFromCommitedProjNum.Visible = true;
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

        protected void BindFundAccounts()
        {
            try
            {
                DataTable dtable = new DataTable();
                //dtable = FinancialTransactions.GetDataTableByProcName("GetFundAccounts");
                dtable = FinancialTransactions.GetAllFundsByProjectProgram(DataUtils.GetInt(hfProjId.Value));
                //dtable = FinancialTransactions.GetCommittedFundAccounts(Convert.ToInt32(hfProjId.Value));
                ddlAcctNum.DataSource = dtable;
                ddlAcctNum.DataValueField = "fundid";
                ddlAcctNum.DataTextField = "account";
                ddlAcctNum.DataBind();
                ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));

                //dtable = new DataTable();
                //dtable = FinancialTransactions.GetDataTableByProcName("GetFundNames");
                ddlFundName.DataSource = dtable;
                ddlFundName.DataValueField = "fundid";
                ddlFundName.DataTextField = "name";
                ddlFundName.DataBind();
                ddlFundName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetCommittedPendingProjectslistByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjects("getCommittedPendingReallocationProjectslistByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }



        protected void hdnValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();
            if (rdBtnSelection.SelectedIndex > 0)
            {
                if (txtFromCommitedProjNum.Text == "")
                {
                    lblRErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }
            ///populate the form based on retrieved data
            getDetails(dt);
        }

        protected void hdnRelocationProjValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();
            if (rdBtnSelection.SelectedIndex > 0)
            {
                if (txtFromCommitedProjNum.Text == "")
                {
                    lblRErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }

            ///populate the form based on retrieved data
            getDetails(dt);

        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblRErrorMsg.Text = "";
            GetSelectedTransId(gvReallocate);
            gvbRelocationDetails.EditIndex = -1;
            BindFundDetails(GetTransId());
            pnlTranDetails.Visible = true;
            ClearTransactionDetailForm();
        }
        private void getDetails(DataTable dt)
        {
            lblAvailFund.Text = "";
            lblAvailVisibleFund.Text = "";
            hfProjId.Value = dt.Rows[0][0].ToString();

            try
            {

                if (dt.Rows.Count != 0)
                {
                    hfProjId.Value = dt.Rows[0][0].ToString();
                    pnlTranDetails.Visible = false;
                    lblRErrorMsg.Text = "";
                    BindFundAccounts();
                    gvReallocate.DataSource = null;
                    gvReallocate.DataBind();

                    //ClearTransactionDetailForm();
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

                    ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;

                    DataTable dtTrans = FinancialTransactions.GetFinancialTransByProjId(Convert.ToInt32(hfProjId.Value), ActiveOnly, BOARD_RELOCATION);
                    gvReallocate.DataSource = dtTrans;
                    gvReallocate.DataBind();
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


            hfReallocateGuid.Value = "";
            hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";
            ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;
        }


        private void clearGvReallocate()
        {
            gvReallocate.DataSource = null;
            gvReallocate.DataBind();
        }


        private void ClearReallocationFromPanel()
        {
            txtFromCommitedProjNum.Text = "";
        }

        private void BindGvReallocate(int fromProjId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                // dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);
                }
                else
                {
                    dtFundDet = FinancialTransactions.GetReallocationDetailsByGuid(fromProjId, hfReallocateGuid.Value);
                }

                gvReallocate.DataSource = dtFundDet;
                gvReallocate.DataBind();
                decimal totAmt = 0;
                hfBalAmt.Value = "";
                if (dtFundDet.Rows.Count > 0)
                {
                    Label lblTotAmt = (Label)gvReallocate.FooterRow.FindControl("lblFooterAmount");
                    Label lblBalAmt = (Label)gvReallocate.FooterRow.FindControl("lblFooterBalance");
                    if (dtFundDet.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtFundDet.Rows.Count; i++)
                        {
                            if (Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString()) > 0)
                                totAmt += Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());
                        }
                    }

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totAmt);

                    if (lblBalAmt.Text != "$0.00")
                    {
                        lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                    }
                    if (lblBalAmt.Text == "$0.00")
                    {
                        hfReallocateGuid.Value = "";
                    }
                }

            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }

        private void BindGvReallocate(int fromProjId, string reallocateGuid)
        {
            try
            {
                DataTable dtFundDet = new DataTable();

                dtFundDet = FinancialTransactions.GetReallocationDetailsByGuid(fromProjId, reallocateGuid);

                gvReallocate.DataSource = dtFundDet;
                gvReallocate.DataBind();

            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }


        private void BindGvReallocate(int fromProjId, int fundId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();

                gvReallocate.DataSource = dtFundDet;
                gvReallocate.DataBind();

            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }

        private void BindGvReallocate(int fromProjId, int fundId, int transTypeId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    //if (txtRfromDate.Text != "")
                    //{
                    //    DateTime dtFromDate = Convert.ToDateTime(txtRfromDate.Text);
                    //    dtFundDet = FinancialTransactions.GetDistinctReallocationGuidsByProjFundTransType(fromProjId, fundId, transTypeId, dtFromDate);
                    //}
                }
                gvReallocate.DataSource = dtFundDet;
                gvReallocate.DataBind();

            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }



        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfReallocateGuid.Value = "";
            ClearReallocationFromPanel();
            lblRErrorMsg.Text = "";
            gvReallocate.DataSource = null;
            gvReallocate.DataBind();

            if (rdBtnSelection.SelectedIndex == 0)
            {
                Response.Redirect("reallocations.aspx");
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            if (cbActiveOnly.Checked)
                ActiveOnly = 1;
            else
                ActiveOnly = 0;
            BindTransGrid();
            SetRadioButton(GetTransId().ToString());
            BindFundDetails(GetTransId());
        }
        protected void gvReallocate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReallocate.EditIndex = e.NewEditIndex;
            Label lblGuid = (Label)gvReallocate.Rows[e.NewEditIndex].FindControl("lblProjGuid");

            BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()), lblGuid.Text);
        }

        protected void gvReallocate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReallocate.EditIndex = -1;
            Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()), lblGuid.Text);
            BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()));
        }

        protected void gvReallocate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string TransId = ((Label)gvReallocate.Rows[rowIndex].FindControl("lblTransId")).Text.Trim();
                if (TransId.ToString() != "")
                {
                    FinancialTransactions.InactivateFinancialTransByTransId(Convert.ToInt32(TransId));
                    BindTransGrid();
                    BindFundDetails(GetTransId());

                    lblRErrorMsg.Text = "Transaction was successfully inactivated. All details related to this transaction also have been inactivated.";
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }


            //Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            //FinancialTransactions.DeleteReallocationsByGUID(lblGuid.Text);
            // BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
        }

        protected void gvReallocate_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (rdBtnSelection.SelectedIndex == 0)
                e.Row.Cells[0].Visible = false;
            else
                e.Row.Cells[0].Visible = true;
        }

        protected void gvReallocate_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void gvReallocate_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvReallocate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvbRelocationDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvbRelocationDetails.EditIndex = -1;
            ClearTransactionDetailForm();
            BindFundDetails(GetTransId());
        }

        protected void gvbRelocationDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvbRelocationDetails.EditIndex = e.NewEditIndex;
            BindFundDetails(GetTransId());
        }

        protected void gvbRelocationDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                if (((TextBox)gvbRelocationDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim() != "")
                {
                    decimal n;
                    bool isNumeric = decimal.TryParse(((TextBox)gvbRelocationDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim(), out n);

                    if (!isNumeric || Convert.ToDecimal(((TextBox)gvbRelocationDetails.Rows[rowIndex].FindControl("txtAmount")).Text.Trim()) <= 0)
                    {
                        lblRErrorMsg.Text = "Select a valid transaction amount";
                        ((TextBox)gvbRelocationDetails.Rows[rowIndex].FindControl("txtAmount")).Focus();
                        return;
                    }
                }

                decimal amount = Convert.ToDecimal(((TextBox)gvbRelocationDetails.Rows[rowIndex].FindControl("txtAmount")).Text);
                // decimal amount = DataUtils.GetDecimal(Regex.Replace(((TextBox)gvbRelocationDetails.Rows[rowIndex].FindControl("txtAmount")).Text, "[^0-9a-zA-Z.]+", ""));

                int transType = Convert.ToInt32(((DropDownList)gvbRelocationDetails.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                int detailId = Convert.ToInt32(((Label)gvbRelocationDetails.Rows[rowIndex].FindControl("lblDetId")).Text);
                //int fundId = Convert.ToInt32(((Label)gvbRelocationDetails.Rows[rowIndex].FindControl("lblFundId")).Text);
                int fundId = Convert.ToInt32(((DropDownList)gvbRelocationDetails.Rows[rowIndex].FindControl("ddlEditFundName")).SelectedValue.ToString());

                int transId = Convert.ToInt32(((Label)gvbRelocationDetails.Rows[rowIndex].FindControl("lblTransId")).Text);

                decimal old_amount = Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                decimal allowed_amount = old_amount + bal_amount;



                if (amount == allowed_amount)
                {
                    lblRErrorMsg.Text = "Transaction is complete, more funds not allowed";
                }
                else if (amount > allowed_amount)
                {
                    //amount = allowed_amount;
                    //lblRErrorMsg.Text = "Amount auto adjusted to available fund amount";

                    lblRErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                    return;
                }
                FinancialTransactions.UpdateTransDetailsWithFund(detailId, transType, amount, fundId, null);


                gvbRelocationDetails.EditIndex = -1;
                BindFundDetails(GetTransId());
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }

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

        protected void gvbRelocationDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnReallocateSubmit.Text = "Update";
                    dvReallocateToForm.Visible = true;
                    pnlTranDetails.Visible = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                       // e.Row.Cells[11].Controls[0].Visible = false;
                        Label lblDetId = e.Row.FindControl("lblDetId") as Label;
                        hfDetailId.Value = lblDetId.Text;
                        DataRow dr = FinancialTransactions.GetTransactionDetailsByDetailId(Convert.ToInt32(lblDetId.Text));

                        PopulateDropDown(ddlAcctNum, dr["FundId"].ToString());
                        SelectedFundNum();
                        PopulateDropDown(ddlFundName, dr["FundId"].ToString());
                        //PopulateDropDown(ddlTransType, dr["LkTransType"].ToString());
                        txtAmt.Text = dr["Amount"].ToString();
                        PopulateDropDown(ddlUsePermit, dr["LandUsePermitID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvbRelocationDetails_RowDataBound", "", ex.Message);
            }


            //if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            //    CommonHelper.GridViewSetFocus(e.Row);
            //{
            //    //Checking whether the Row is Data Row
            //    if (e.Row.RowType == DataControlRowType.DataRow)
            //    {
            //        DropDownList ddlTrans = (e.Row.FindControl("ddlTransType") as DropDownList);
            //        TextBox txtTransType = (e.Row.FindControl("txtTransType") as TextBox);
            //        //Label lblFName = (e.Row.FindControl("lblFundName") as Label);
            //        TextBox txtFundName = (e.Row.FindControl("txtFundName") as TextBox);
            //        Label lblAmt = (e.Row.FindControl("lblAmt") as Label);
            //        if (lblAmt != null)
            //        {
            //            if (Convert.ToDecimal(lblAmt.Text.Trim()) < 0)
            //            {
            //                LinkButton lnkBtnEdit = (e.Row.FindControl("LnkBtnEdit") as LinkButton);
            //                lnkBtnEdit.Visible = false;
            //            }
            //        }
            //        if (txtTransType != null)
            //        {
            //            DataTable dtable = new DataTable();
            //            if (txtFundName.Text.ToLower().Contains("hopwa"))
            //            {
            //                dtable = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
            //            }
            //            else
            //            {
            //                dtable = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
            //            }

            //            // dtable = FinancialTransactions.GetLookupDetailsByName("LkTransType");
            //            ddlTrans.DataSource = dtable;
            //            ddlTrans.DataValueField = "typeid";
            //            ddlTrans.DataTextField = "Description";
            //            ddlTrans.DataBind();
            //            string itemToCompare = string.Empty;
            //            foreach (ListItem item in ddlTrans.Items)
            //            {
            //                itemToCompare = item.Value.ToString();
            //                if (txtTransType.Text.ToLower() == itemToCompare.ToLower())
            //                {
            //                    ddlTrans.ClearSelection();
            //                    item.Selected = true;
            //                }
            //            }
            //        }

            //        DropDownList ddlEditFundName = (e.Row.FindControl("ddlEditFundName") as DropDownList);
            //        if (txtFundName != null)
            //        {
            //            if (txtFundName.Text != null)
            //            {

            //                DataTable dtable = new DataTable();
            //                dtable = FinancialTransactions.GetDataTableByProcName("GetAllFunds");

            //                ddlEditFundName.DataSource = dtable;
            //                ddlEditFundName.DataValueField = "fundid";
            //                ddlEditFundName.DataTextField = "name";
            //                ddlEditFundName.DataBind();

            //                string itemToCompare = string.Empty;
            //                foreach (ListItem item in ddlEditFundName.Items)
            //                {
            //                    itemToCompare = item.Text.ToString();
            //                    if (txtFundName.Text.ToLower() == itemToCompare.ToLower())
            //                    {
            //                        ddlEditFundName.ClearSelection();
            //                        item.Selected = true;
            //                    }
            //                }
            //            }
            //        }
            //    }
            //}


        }

        protected void gvbRelocationDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblDetailId = (Label)gvbRelocationDetails.Rows[rowIndex].FindControl("lblDetId");
                if (lblDetailId != null)
                {
                    FinancialTransactions.DeleteTransactionDetail(Convert.ToInt32(lblDetailId.Text));

                    BindFundDetails(GetTransId());

                    lblRErrorMsg.Text = "Transaction detail was successfully deleted";
                    // CommonHelper.EnableButton(btnCommitmentSubmit);
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        private void BindTransGrid()
        {
            try
            {
                if (cbActiveOnly.Checked)
                    ActiveOnly = 1;
                else
                    ActiveOnly = 0;

                gvReallocate.DataSource = null;
                gvReallocate.DataBind();

                DataTable dtTrans = null;
                if (rdBtnSelection.SelectedIndex > 0)
                {
                    dtTrans = FinancialTransactions.GetFinancialTransByProjId(Convert.ToInt32(hfProjId.Value), ActiveOnly, BOARD_RELOCATION);
                    gvReallocate.DataSource = dtTrans;
                    gvReallocate.DataBind();
                }

            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
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
                        HiddenField hfTransType = (HiddenField)gvFGM.Rows[i].Cells[2].FindControl("hiddenFieldTransType");
                       
                        if (hfTransType != null)
                        {
                            txtTransType.Text = hfTransType.Value;
                        }
                        else
                        {
                            txtTransType.Text = "";
                        }

                        HiddenField hfTransTypeId1 = (HiddenField)gvFGM.Rows[i].Cells[2].FindControl("hiddenFieldTransTypeId");

                        if (hfTransTypeId1 != null)
                        {
                            hfTransTypeId.Value = hfTransTypeId1.Value;
                        }
                        else
                        {
                            hfTransTypeId.Value = "";
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
                for (int i = 0; i < gvReallocate.Rows.Count; i++)
                {
                    HiddenField hf = (HiddenField)gvReallocate.Rows[i].Cells[0].FindControl("HiddenField1");
                    if (hf != null)
                    {
                        if (hf.Value == TransId.ToString())
                        {
                            ((RadioButton)gvReallocate.Rows[i].Cells[0].FindControl("rdBtnSelect")).Checked = true;
                            break;
                        }
                    }
                }
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

        private void BindFundDetails(int transId)
        {
            try
            {
                if (cbActiveOnly.Checked)
                    ActiveOnly = 1;
                else
                    ActiveOnly = 0;

                DataTable dtFundDet = new DataTable();
                dtFundDet = FinancialTransactions.GetCommitmentFundDetailsByProjectId(transId, BOARD_RELOCATION, ActiveOnly);

                gvbRelocationDetails.DataSource = dtFundDet;
                gvbRelocationDetails.DataBind();

                decimal tranAmount = 0;
                decimal totFundAmt = 0;
                decimal totBalAmt = 0;
                decimal totDetailAmount = 0;

                if (dtFundDet.Rows.Count > 0)
                {
                    //tranAmount = Convert.ToDecimal(dtFundDet.Rows[0]["TransAmt"].ToString());
                    tranAmount = Convert.ToDecimal(this.hfTransAmt.Value);

                    Label lblTotAmt = (Label)gvbRelocationDetails.FooterRow.FindControl("lblFooterAmount");
                    Label lblBalAmt = (Label)gvbRelocationDetails.FooterRow.FindControl("lblFooterBalance");

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

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                    gvbRelocationDetails.Columns[0].Visible = false;
                    gvbRelocationDetails.FooterRow.Visible = true;
                    lblTransDetHeader.Text = "Transaction Detail";

                    if (btnReallocateSubmit.Text.ToLower() == "submit")// When Edit mode form needs to show
                    {
                        dvReallocateToForm.Visible = false;

                        if (lblBalAmt.Text != "$0.00")
                        {
                            lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                            dvReallocateToForm.Visible = true;
                        }
                    }
                    else
                    {
                        dvReallocateToForm.Visible = true;
                    }
                }
                else
                    dvReallocateToForm.Visible = true;
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
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

        protected void ddlRToFund_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlRToProj_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectedFundNum();
        }

        private void SelectedFundNum()
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
                //ddlTransType.DataValueField = "typeid";
                //ddlTransType.DataTextField = "Description";
                //ddlTransType.DataBind();
                //ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                BindUsePermit(hfProjId.Value != "" ? Convert.ToInt32(hfProjId.Value) : 0);

                //if (ddlAcctNum.SelectedValue.ToString() == strLandUsePermit)
                if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
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
                //ddlTransType.Items.Clear();
                //ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";
                txtAmt.Text = "";
                //ClearDetailSelection();
            }
        }

        protected void BindUsePermit(int projId)
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetAllLandUsePermit(projId);
                ddlUsePermit.DataSource = dtable;
                ddlUsePermit.DataValueField = "Act250FarmId";
                ddlUsePermit.DataTextField = "UsePermit";
                ddlUsePermit.DataBind();
                if (ddlUsePermit.Items.Count > 1)
                    ddlUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }

        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetFundAccountsByFilter(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjects("GetFundAccountsByFilter", prefixText);

            List<string> FundAccts = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                FundAccts.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return FundAccts.ToArray();
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
                //ddlTransType.DataValueField = "typeid";
                //ddlTransType.DataTextField = "Description";
                //ddlTransType.DataBind();
                //ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                BindUsePermit(hfProjId.Value != "" ? Convert.ToInt32(hfProjId.Value) : 0);

                //if (ddlFundName.SelectedValue.ToString() == strLandUsePermit)
                if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
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
                //ddlTransType.Items.Clear();
                //ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));
                lblFundName.Text = "";
                txtAmt.Text = "";
                //ClearDetailSelection();
            }
        }

        protected void btnReallocateSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string str = txtAmt.Text;
                string tmp = Regex.Replace(str, "[^0-9a-zA-Z.]+", "");
                txtAmt.Text = tmp.ToString();

                lblRErrorMsg.Text = "";
                //btnNewTransaction.Visible = false;
                if (ddlAcctNum.Items.Count > 1 && ddlAcctNum.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select Account to add new transaction detail";
                    ddlAcctNum.Focus();
                    return;
                }
                //else if (ddlTransType.Items.Count > 1 && ddlTransType.SelectedIndex == 0)
                //{
                //    lblRErrorMsg.Text = "Select a Transaction type";
                //    ddlTransType.Focus();
                //    return;
                //}
                else if (txtAmt.Text.Trim() == "")
                {
                    lblRErrorMsg.Text = "Select a valid transaction amount";
                    txtAmt.Focus();
                    return;
                }
                else if (txtAmt.Text.Trim() != "")
                {
                    decimal n;
                    bool isNumeric = decimal.TryParse(txtAmt.Text.Trim(), out n);

                    if (!isNumeric || Convert.ToDecimal(txtAmt.Text) <= 0)
                    {
                        lblRErrorMsg.Text = "Select a valid transaction amount";
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
                    DataTable dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlFundName.SelectedValue.ToString()));

                    if (btnReallocateSubmit.Text.ToLower() == "submit")
                    {
                        if (currentBalAmount == 0 && gvbRelocationDetails.Rows.Count > 0)
                        {
                            lblRErrorMsg.Text = "This transaction details are all set. No more funds allowed to add for the transaction.";
                            ClearTransactionDetailForm();
                            CommonHelper.DisableButton(btnReallocateSubmit);

                            return;
                        }
                        else if (currentTranFudAmount > currentBalAmount)
                        {
                            //currentTranFudAmount = currentBalAmount;
                            //lblErrorMsg.Text = "Amount auto adjusted to available fund amount";

                            lblRErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                            return;
                        }

                        if (FinancialTransactions.IsDuplicateFundDetailPerTransaction(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                            Convert.ToInt32(hfTransTypeId.Value.ToString())))
                        {
                            lblRErrorMsg.Text = "Same fund and same transaction type is already submitted for this transaction. Please select different selection";
                            return;
                        }

                        //if (ddlAcctNum.SelectedValue.ToString() == strLandUsePermit)
                        if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                        {
                            if (ddlUsePermit.Items.Count > 1 && ddlUsePermit.SelectedIndex == 0)
                            {
                                lblRErrorMsg.Text = "Select Use Permit";
                                ddlUsePermit.Focus();
                                return;
                            }

                            FinancialTransactions.AddProjectFundDetails(DataUtils.GetInt(hfProjId.Value), transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                            Convert.ToInt32(hfTransTypeId.Value.ToString()), currentTranFudAmount, ddlUsePermit.SelectedItem.Text, ddlUsePermit.SelectedValue.ToString());
                        }
                        else
                            FinancialTransactions.AddProjectFundDetailsReallocation(DataUtils.GetInt(hfProjId.Value), transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                                Convert.ToInt32(hfTransTypeId.Value.ToString()), currentTranFudAmount);

                        ClearTransactionDetailForm();
                        BindFundDetails(transId);
                    }
                    else
                    {
                        //Update
                        int detailId = Convert.ToInt32(hfDetailId.Value);

                        decimal old_amount = Convert.ToDecimal(FinancialTransactions.GetTransDetails(detailId).Rows[0]["Amount"].ToString());
                        decimal bal_amount = Convert.ToDecimal(hfBalAmt.Value);
                        decimal allowed_amount = old_amount + bal_amount;


                        decimal amount = currentTranFudAmount;
                        if (amount == allowed_amount)
                        {
                            lblRErrorMsg.Text = "Transaction is complete, more funds not allowed";
                        }
                        else if (amount > allowed_amount)
                        {
                            //amount = allowed_amount;
                            //lblRErrorMsg.Text = "Amount auto adjusted to available fund amount";

                            lblRErrorMsg.Text = "Amount entered is more than the available balance amount. Please enter available funds.";
                            return;
                        }

                        if (ddlUsePermit.SelectedValue.ToString() != "NA")
                        {
                            FinancialTransactions.UpdateTransDetailsWithFund(detailId, Convert.ToInt32(hfTransTypeId.Value.ToString()),
                                currentTranFudAmount, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()), ddlUsePermit.SelectedValue.ToString());
                        }
                        else
                        {
                            FinancialTransactions.UpdateTransDetailsWithFund(detailId, Convert.ToInt32(hfTransTypeId.Value.ToString()),
                               currentTranFudAmount, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()), null);
                        }

                        gvbRelocationDetails.EditIndex = -1;
                        ClearTransactionDetailForm();
                        BindFundDetails(transId);
                    }
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }
        private void ClearTransactionDetailForm()
        {
            lblFundName.Text = "";
            txtAmt.Text = "";
            lblUsePermit.Visible = false;
            ddlUsePermit.Visible = false;
            try
            {
                //ddlTransType.SelectedIndex = 0;
                ddlAcctNum.SelectedIndex = 0;
                ddlFundName.SelectedIndex = 0;
                btnReallocateSubmit.Text = "Submit";
            }
            catch (Exception)
            { }
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