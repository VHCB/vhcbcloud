using System;
using System.Collections;
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
    public partial class ExistingReallocations : System.Web.UI.Page
    {
        private int BOARD_RELOCATION = 240;
        private int TRANS_PENDING_STATUS = 261;
        private int ActiveOnly = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rdBtnSelection.SelectedIndex = 1;
                hfReallocateGuid.Value = "";
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
                this.MasterPageFile = "SiteNonAdmin.Master";
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
            BindFundDetails(GetTransId());
            pnlTranDetails.Visible = true;
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
                FinancialTransactions.UpdateTransDetailsWithFund(detailId, transType, amount, fundId);


                gvbRelocationDetails.EditIndex = -1;
                BindFundDetails(GetTransId());
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }

        }

        protected void gvbRelocationDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlTrans = (e.Row.FindControl("ddlTransType") as DropDownList);
                    TextBox txtTransType = (e.Row.FindControl("txtTransType") as TextBox);
                    //Label lblFName = (e.Row.FindControl("lblFundName") as Label);
                    TextBox txtFundName = (e.Row.FindControl("txtFundName") as TextBox);
                    Label lblAmt = (e.Row.FindControl("lblAmt") as Label);
                    if(lblAmt != null)
                    {
                        if (Convert.ToDecimal(lblAmt.Text.Trim()) < 0)
                        {
                            LinkButton lnkBtnEdit = (e.Row.FindControl("LnkBtnEdit") as LinkButton);
                            lnkBtnEdit.Visible = false;
                        }
                    }
                    if (txtTransType != null)
                    {
                        DataTable dtable = new DataTable();
                        if (txtFundName.Text.ToLower().Contains("hopwa"))
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

                    DropDownList ddlEditFundName = (e.Row.FindControl("ddlEditFundName") as DropDownList);
                    if (txtFundName != null)
                    {
                        if (txtFundName.Text != null)
                        {
                            
                            DataTable dtable = new DataTable();
                            dtable = FinancialTransactions.GetDataTableByProcName("GetAllFunds");

                            ddlEditFundName.DataSource = dtable;
                            ddlEditFundName.DataValueField = "fundid";
                            ddlEditFundName.DataTextField = "name";
                            ddlEditFundName.DataBind();

                            string itemToCompare = string.Empty;
                            foreach (ListItem item in ddlEditFundName.Items)
                            {
                                itemToCompare = item.Text.ToString();
                                if (txtFundName.Text.ToLower() == itemToCompare.ToLower())
                                {
                                    ddlEditFundName.ClearSelection();
                                    item.Selected = true;
                                }
                            }
                        }
                    }
                }
            }

            
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
                        }
                    }

                    totBalAmt = tranAmount - totFundAmt;
                    hfBalAmt.Value = totBalAmt.ToString();

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);
                    lblBalAmt.Text = CommonHelper.myDollarFormat(totBalAmt);

                    gvbRelocationDetails.Columns[0].Visible = false;
                    gvbRelocationDetails.FooterRow.Visible = true;
                    lblTransDetHeader.Text = "Transaction Detail";

                    if (lblBalAmt.Text != "$0.00")
                    {
                        lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";

                    }
                }
                else
                {
                    pnlTranDetails.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

       
    }
}