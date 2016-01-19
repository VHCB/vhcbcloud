using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using System.Data;
using System.Text;

namespace vhcbcloud
{
    public partial class BoardFinancialTransactions : System.Web.UI.Page
    {
        DataTable dtProjects;
        DataTable dtable;
        private int TRANS_PENDING_STATUS = 261;
        private int BOARD_COMMITMENT = 238;
        private int BOARD_DECOMMITMENT = 239;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
                BindLkStatus();
                BindLkTransType();
                BindFundAccounts();
                BindAllFunds();
                if (rdBtnFinancial.SelectedIndex >= 0)
                    pnlHide.Visible = true;
            }
            //if (hfBalAmt.Value != "" && hfBalAmt.Value == "0.00")
            //    btnTransSubmit.Enabled = true;
          

            GetTransSelectedRecord(gvPTrans);
            lblErrorMsg.Text = "";
        }

        protected void BindProjects()
        {
            try
            {
                dtProjects = new DataTable();
                dtProjects = Project.GetProjects("GetProjects");
                ddlProjFilter.DataSource = dtProjects;
                ddlProjFilter.DataValueField = "projectId";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));

                ddlRFromProj.DataSource = dtProjects;
                ddlRFromProj.DataValueField = "projectId";
                ddlRFromProj.DataTextField = "Proj_num";
                ddlRFromProj.DataBind();
                ddlRFromProj.Items.Insert(0, new ListItem("Select", "NA"));

                ddlRToProj.DataSource = dtProjects;
                ddlRToProj.DataValueField = "projectId";
                ddlRToProj.DataTextField = "Proj_num";
                ddlRToProj.DataBind();
                ddlRToProj.Items.Insert(0, new ListItem("Select", "NA"));
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
                dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetFundAccounts");
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

        protected void BindAllFunds()
        {
            try
            {
                dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetAllFunds");

                ddlRToFund.DataSource = dtable;
                ddlRToFund.DataValueField = "fundid";
                ddlRToFund.DataTextField = "name";
                ddlRToFund.DataBind();
                ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        private void BindLkTransType()
        {
            try
            {
                ddlTransType.DataSource = FinancialTransactions.GetLookupDetailsByName("LkTransType");
                ddlTransType.DataValueField = "typeid";
                ddlTransType.DataTextField = "Description";
                ddlTransType.DataBind();
                ddlTransType.Items.Insert(0, new ListItem("Select", "NA"));

                ddlRtoFundType.DataSource = FinancialTransactions.GetLookupDetailsByName("LkTransType");
                ddlRtoFundType.DataValueField = "typeid";
                ddlRtoFundType.DataTextField = "Description";
                ddlRtoFundType.DataBind();
                ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindLkStatus()
        {
            try
            {
                ddlStatus.DataSource = FinancialTransactions.GetLookupDetailsByName("LKStatus");
                ddlStatus.DataValueField = "typeid";
                ddlStatus.DataTextField = "Description";
                ddlStatus.DataBind();
                ddlStatus.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindFundDetails(int transId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                if (rdBtnFinancial.SelectedIndex == 0 || rdBtnFinancial.SelectedIndex == 2)
                {
                    dtFundDet = FinancialTransactions.GetCommitmentFundDetailsByProjectId(transId, BOARD_COMMITMENT);
                }
                else
                {
                    dtFundDet = FinancialTransactions.GetCommitmentFundDetailsByProjectId(transId, BOARD_DECOMMITMENT);
                }


                gvBCommit.DataSource = dtFundDet;
                gvBCommit.DataBind();
                decimal totAmt = 0;
                if (dtFundDet.Rows.Count > 0)
                {
                    Label lblTotAmt = (Label)gvBCommit.FooterRow.FindControl("lblFooterAmount");
                    Label lblBalAmt = (Label)gvBCommit.FooterRow.FindControl("lblFooterBalance");
                    if (dtFundDet.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtFundDet.Rows.Count; i++)
                        {
                            //if (rdBtnFinancial.SelectedIndex == 1)
                            //{
                            //    totAmt -= Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());
                            //}
                            //else
                            //{
                            totAmt += Convert.ToDecimal(dtFundDet.Rows[i]["Amount"].ToString());
                            //}
                        }
                    }

                    lblTotAmt.Text = CommonHelper.myDollarFormat(totAmt);
                    GetTransRecord(gvBCommit); // this method is only for single transaction grid
                    GetTransSelectedRecord(gvPTrans); // this method is only for single transaction grid
                    if (hfTransAmt.Value != "")
                    {
                        lblBalAmt.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(hfTransAmt.Value) - totAmt);
                        hfBalAmt.Value = Convert.ToString(Convert.ToDecimal(hfTransAmt.Value) - totAmt);
                    }
                    if (rdBtnFinancial.SelectedIndex == 2)
                    {
                        gvBCommit.Columns[0].Visible = true;
                        gvBCommit.FooterRow.Visible = false;
                        lblTransDetHeader.Text = "Reallocate From";
                        divReallocate.Visible = true;
                    }
                    else
                    {
                        gvBCommit.Columns[0].Visible = false;
                        gvBCommit.FooterRow.Visible = true;
                        lblTransDetHeader.Text = "Transaction Detail";
                        divReallocate.Visible = false;
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

        private void BindSelectedProjects(DataTable dtTrans)
        {
            try
            {
                if (ddlProjFilter.SelectedIndex != 0)
                {
                    //DataTable dtTrans = FinancialTransactions.GetBoardCommitmentTrans(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), commitmentType);
                    if (dtTrans.Rows.Count > 0)
                    {
                        gvPTrans.DataSource = dtTrans;
                        gvPTrans.DataBind();
                        hfTransId.Value = dtTrans.Rows[0]["transid"].ToString();
                    }
                    else
                    {
                        txtTransDate.Text = DateTime.Now.ToShortDateString();
                        txtTotAmt.Text = "";
                        ddlStatus.SelectedIndex = 0;
                        gvPTrans.DataSource = null;
                        gvPTrans.DataBind();
                        gvBCommit.DataSource = null;
                        gvBCommit.DataBind();
                    }
                }
                else
                {
                    lblErrorMsg.Text = "Select a project to proceed";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindSelectedProjects()
        {
            try
            {
                if (ddlProjFilter.SelectedIndex != 0)
                {
                    DataTable dtTrans = FinancialTransactions.GetBoardCommitmentTrans(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), "Board Commitment");
                    if (dtTrans.Rows.Count > 0)
                    {
                        gvPTrans.DataSource = dtTrans;
                        gvPTrans.DataBind();
                    }
                    else
                    {
                        txtTransDate.Text = DateTime.Now.ToShortDateString();
                        txtTotAmt.Text = "";
                        ddlStatus.SelectedIndex = 0;
                        gvPTrans.DataSource = null;
                        gvPTrans.DataBind();
                        gvBCommit.DataSource = null;
                        gvBCommit.DataBind();
                    }
                }
                else
                {
                    lblErrorMsg.Text = "Select a project to proceed";
                }
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
                DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
                lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                BindGranteeByProject();
                lbAwardSummary.Visible = true;
                txtTransDate.Text = DateTime.Now.ToShortDateString();
                txtTotAmt.Text = "";
                gvPTrans.DataSource = null;
                gvPTrans.DataBind();
                gvBCommit.DataSource = null;
                gvBCommit.DataBind();
                ClearDetailSelection();

            }
        }

        protected void gvBCommit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvBCommit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBCommit.EditIndex = -1;
            BindFundDetails(GetTransId());
        }

        protected void gvBCommit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                decimal amount = Convert.ToDecimal(((TextBox)gvBCommit.Rows[rowIndex].FindControl("txtAmount")).Text);
                int transType = Convert.ToInt32(((DropDownList)gvBCommit.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                int detailId = Convert.ToInt32(((Label)gvBCommit.Rows[rowIndex].FindControl("lblDetId")).Text);

                if (hfBalAmt.Value != "")
                {
                    if (amount > Convert.ToDecimal(hfBalAmt.Value))
                    {
                        if (Convert.ToDecimal(hfBalAmt.Value) == 0)
                        {
                            lblErrorMsg.Text = "Transaction is complete, more funds not allowed";
                            return;
                        }
                        amount = Convert.ToDecimal(hfBalAmt.Value);
                        lblErrorMsg.Text = "Amount auto adjusted to available fund amount";
                    }
                }

                FinancialTransactions.UpdateTransDetails(detailId, transType, amount);
                lblErrorMsg.Text = "";
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
                    if (txtTransType != null)
                    {
                        dtable = new DataTable();
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

        protected void gvBCommit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBCommit.EditIndex = e.NewEditIndex;
            //BindFundDetails(Convert.ToInt32(ViewState["SelectedTransId"]));
            BindFundDetails(GetTransId());
        }

        protected void gvBCommit_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dtTrans = new DataTable();

            SortDireaction = CommonHelper.GridSorting(gvBCommit, dtTrans, SortExpression, SortDireaction);
        }

        private int GetTransId()
        {
            dtable = new DataTable();
            dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment");
            if (dtable.Rows.Count > 0)
                return Convert.ToInt32(dtable.Rows[0]["transid"].ToString());
            else
                return 0;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlTransType.SelectedIndex != 0)
                {
                    lblErrorMsg.Text = "";

                    hfTransId.Value = GetTransId().ToString();

                    if (ddlAcctNum.SelectedIndex<=0)
                    {
                        lblErrorMsg.Text = "Select Fund # to add the detail.";
                        return;
                    }

                    if (hfTransAmt.Value != "")
                    {
                        if (txtAmt.Text == "")
                        {
                            lblErrorMsg.Text = "Add detail amount";
                            return;
                        }
                        else
                        {

                            if (Convert.ToDecimal(txtAmt.Text) > Convert.ToDecimal(hfTransAmt.Value))
                            {
                                lblErrorMsg.Text = "Detail amount adjusted to maximum allowed amount.";
                                txtAmt.Text = hfTransAmt.Value;
                            }
                            else
                            {
                                if (hfBalAmt.Value != "" && hfBalAmt.Value != "0.00")
                                {
                                    if (Convert.ToDecimal(txtAmt.Text) > Convert.ToDecimal(hfBalAmt.Value))
                                    {
                                        lblErrorMsg.Text = "Detail amount adjusted to maximum allowed amount.";
                                        txtAmt.Text = hfBalAmt.Value;
                                    }
                                }
                                else if (hfBalAmt.Value != "" && hfBalAmt.Value == "0.00" && gvBCommit.Rows.Count > 0)
                                {
                                    lblErrorMsg.Text = "This transaction details are all set. No more funds allowed to add for the transaction.";
                                    ClearDetailSelection();
                                    btnTransSubmit.Enabled = true;
                                    return;
                                }
                            }
                        }
                    }

                    if (hfTransId.Value != null)
                    {
                        int transId = Convert.ToInt32(hfTransId.Value);

                        FinancialTransactions.AddProjectFundDetails(transId, Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()),
                            Convert.ToInt32(ddlTransType.SelectedValue.ToString()), Convert.ToDecimal(txtAmt.Text));

                        BindFundDetails(transId);
                        ClearDetailSelection();
                    }

                    //FinancialTransactions.AddProjectFundDetails(Convert.ToInt32(ViewState["SelectedTransId"]), ddlAcctNum.SelectedItem.Text, lblFundName.Text,
                    //    Convert.ToInt32(ddlTransType.SelectedValue.ToString()), Convert.ToDecimal(txtAmt.Text));

                    //BindFundDetails(Convert.ToInt32(ViewState["SelectedTransId"]));
                }
                else
                {
                    lblErrorMsg.Text = "Select transaction type to add detail";
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.ToLower().Contains("cannot insert duplicate key"))
                    lblErrorMsg.Text = "This Account number already added to another transaction. Please select another Account";
                else
                    lblErrorMsg.Text = ex.Message;
            }
            finally
            {
                hfTransId.Value = null;
            }
        }

        protected void gvPTrans_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvPTrans_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPTrans.EditIndex = -1;
            dtable = new DataTable();
            dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment");
            BindSelectedProjects(dtable);
        }

        protected void gvPTrans_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPTrans.EditIndex = e.NewEditIndex;
            dtable = new DataTable();
            dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment");
            BindSelectedProjects(dtable);
        }

        protected void gvPTrans_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                lblErrorMsg.Text = "";
                int rowIndex = e.RowIndex;
                int transId = Convert.ToInt32(hfTransId.Value);
                string TransDate = ((TextBox)gvPTrans.Rows[rowIndex].FindControl("txtTransDate")).Text;
                DateTime dtTrans = TransDate == "" ? DateTime.Today : Convert.ToDateTime(TransDate);
                decimal transAmt = 0;
                if (((TextBox)gvPTrans.Rows[rowIndex].FindControl("txtTransAmt")).Text == "")
                {
                    lblErrorMsg.Text = "Please enter transaction amount";
                    return;
                }
                else
                {
                    transAmt = Convert.ToDecimal(((TextBox)gvPTrans.Rows[rowIndex].FindControl("txtTransAmt")).Text);
                }
                //int transType = Convert.ToInt32(((DropDownList)gvPTrans.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                int transType = Convert.ToInt32(((TextBox)gvPTrans.Rows[rowIndex].FindControl("txtTransStatus")).Text);
                FinancialTransactions.UpdateBoardCommitmentTransaction(transId, dtTrans, transAmt, rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment", transType);
                gvPTrans.EditIndex = -1;
                dtable = new DataTable();
                dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment");
                BindSelectedProjects(dtable);
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvPTrans_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dtTrans = new DataTable();
            if (ddlProjFilter.SelectedIndex != 0)
            {

                DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));

                lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                // txtGrantee.Text = dtProjects.Rows[0]["Applicantname"].ToString();
                BindGranteeByProject();
                dtTrans = FinancialTransactions.GetBoardCommitmentTrans(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), "Board Commitment");
                if (dtTrans.Rows.Count > 0)
                {
                    gvPTrans.DataSource = dtTrans;
                    gvPTrans.DataBind();
                }
            }
            SortDireaction = CommonHelper.GridSorting(gvBCommit, dtTrans, SortExpression, SortDireaction);
        }

        protected void gvPTrans_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //Finding the Dropdown control.
                    DropDownList ddlTtype = (e.Row.FindControl("ddlTransType") as DropDownList);
                    if (ddlTtype != null)
                    {
                        ddlTtype.DataSource = FinancialTransactions.GetLookupDetailsByName("LKStatus");
                        ddlTtype.DataValueField = "typeid";
                        ddlTtype.DataTextField = "Description";
                        ddlTtype.DataBind();
                    }
                    TextBox txtTtype = e.Row.FindControl("txtTransStatus") as TextBox;
                    if (txtTtype != null)
                    {
                        ddlTtype.Items.FindByValue(txtTtype.Text).Selected = true;
                    }
                }
            }
        }

        public string SortDireaction
        {
            get
            {
                if (ViewState["SortDireaction"] == null)
                    return string.Empty;
                else
                    return ViewState["SortDireaction"].ToString() == "ASC" ? "DESC" : "ASC";
            }
            set
            {
                ViewState["SortDireaction"] = value;
            }
        }

        public string SortExpression
        {
            get
            {
                if (ViewState["SortExpression"] == null)
                    return string.Empty;
                else
                    return ViewState["SortExpression"].ToString();
            }
            set
            {
                ViewState["SortExpression"] = value;
            }
        }

        protected void gvPTrans_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            GridViewRow row = gvPTrans.Rows[e.NewSelectedIndex];
            HiddenField hf = (HiddenField)gvPTrans.Rows[e.NewSelectedIndex].Cells[0].FindControl("HiddenField1");
            if (hf.Value != "")
            {
                BindFundDetails(Convert.ToInt32(hf.Value));
            }
        }

        protected void gvPTrans_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetTransSelectedRecord(gvPTrans);
        }

        protected void btnTransSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (rdBtnFinancial.SelectedIndex == 0 || rdBtnFinancial.SelectedIndex == 1)
                {

                    if (ddlGrantee.Items.Count > 1 && ddlGrantee.SelectedIndex == 0)
                    {
                        lblErrorMsg.Text = "Select Grantee to add new transaction";
                        ddlGrantee.Focus();
                        return;
                    }
                    lblErrorMsg.Text = "";
                    decimal TransAmount = Convert.ToDecimal(txtTotAmt.Text);//rdBtnFinancial.SelectedIndex == 1 ? -Convert.ToDecimal(txtTotAmt.Text) : Convert.ToDecimal(txtTotAmt.Text);
                    DataTable dtTrans = FinancialTransactions.AddBoardFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), Convert.ToDateTime(txtTransDate.Text), TransAmount,
                        Convert.ToInt32(ddlGrantee.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment", TRANS_PENDING_STATUS);//Convert.ToInt32(ddlStatus.SelectedValue.ToString()));
                    BindSelectedProjects(dtTrans);
                    txtTransDate.Text = DateTime.Now.ToShortDateString();
                    txtTotAmt.Text = "";
                    ddlStatus.SelectedIndex = 0;
                   

                }
                else
                {
                    lblErrorMsg.Text = "Select Transcation Type to add new transaction";
                    rdBtnFinancial.Focus();
                    return;
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void GetTransRecord(GridView gvFGM)
        {
           
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {

                HiddenField hf1 = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                HiddenField hf2 = (HiddenField)gvFGM.Rows[i].Cells[2].FindControl("HiddenField2");
                if (hf1 != null && hf2 != null)
                {
                    ViewState["SelectedTransId"] = hf1.Value;
                    hfTransAmt.Value = hf2.Value;
                }
                break;
            }

        }


        private void GetTransSelectedRecord(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                if (gvFGM.Rows.Count == 1)
                {
                    HiddenField hf1 = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                    HiddenField hf2 = (HiddenField)gvFGM.Rows[i].Cells[2].FindControl("HiddenField2");
                    if (hf1 != null && hf2 != null)
                    {
                        ViewState["SelectedTransId"] = hf1.Value;
                        hfTransAmt.Value = hf2.Value;
                    }
                    break;
                }
                else
                {
                    RadioButton rb = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelect");
                    if (rb != null)
                    {
                        if (rb.Checked)
                        {
                            HiddenField hf1 = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                            HiddenField hf2 = (HiddenField)gvFGM.Rows[i].Cells[2].FindControl("HiddenField2");
                            if (hf1 != null && hf2 != null)
                            {
                                ViewState["SelectedTransId"] = hf1.Value;
                                hfTransAmt.Value = hf2.Value;
                            }
                            break;
                        }
                    }
                }
            }
        }

        private void GetSelectedRecord()
        {
            for (int i = 0; i < gvPTrans.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)gvPTrans.Rows[i].Cells[0].FindControl("rdBtnSelectTransDetail");
                if (rb != null)
                {
                    if (rb.Checked)
                    {
                        HiddenField hf = (HiddenField)gvPTrans.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedTransId"] = hf.Value;
                        }
                        break;
                    }
                }
            }
        }

        private void SetSelectedRecord(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rb != null)
                {
                    HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                    if (hf != null && ViewState["SelectedId"] != null)
                    {
                        if (hf.Value.Equals(ViewState["SelectedId"].ToString()))
                        {
                            rb.Checked = true;
                            break;
                        }
                    }
                }
            }
        }

        protected void gvPTrans_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                HiddenField hf = (HiddenField)gvPTrans.Rows[e.RowIndex].Cells[0].FindControl("HiddenField1");
                FinancialTransactions.DeleteProjectFund(Convert.ToInt32(hf.Value));
                dtable = new DataTable();
                dtable = FinancialTransactions.GetLastFinancialTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), rdBtnFinancial.SelectedIndex == 0 ? "Board Commitment" : "Board DeCommitment");
                BindSelectedProjects(dtable);
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                lblErrorMsg.Text = "";
                GetTransSelectedRecord(gvPTrans);
                //BindFundDetails(Convert.ToInt32(ViewState["SelectedTransId"]));
                ClearDetailSelection();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            dtable = new DataTable();
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
                ClearDetailSelection();
            }
        }

        private void ClearDetailSelection()
        {
            lblFundName.Text = "";
            ddlTransType.SelectedIndex = 0;
            txtAmt.Text = "";
            ddlAcctNum.SelectedIndex = 0;
            divReallocate.Visible = false;
        }

        private void ClearSelection()
        {
            txtTransDate.Text = DateTime.Now.ToShortDateString();
            txtTotAmt.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlProjFilter.SelectedIndex = 0;
            lblProjName.Text = "";
            ddlGrantee.DataSource = null;
            ddlGrantee.DataBind();
            gvPTrans.DataSource = null;
            gvPTrans.DataBind();
            gvBCommit.DataSource = null;
            gvBCommit.DataBind();
        }

        protected void rdBtnFinancial_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (rdBtnFinancial.SelectedIndex == 2)
            {
                CleanReallocation();
                divReallocateTo.Visible = true;
                divPtransEntry.Visible = false;
                divTransDetailEntry.Visible = false;
                pnlHide.Visible = false;
                pnlReallocations.Visible = true;
                txtRfromDate.Text = DateTime.Now.ToShortDateString();
            }
            else
            {
                ClearSelection();
                divReallocateTo.Visible = false;
                divPtransEntry.Visible = true;
                divTransDetailEntry.Visible = true;
                pnlHide.Visible = true;
                pnlReallocations.Visible = false;
            }

        }

        protected void rdBtnSelectTransDetail_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (rdBtnFinancial.SelectedIndex == 2)
                {
                    gvBCommit.Columns[0].Visible = true;
                    gvBCommit.FooterRow.Visible = false;
                    lblTransDetHeader.Text = "Reallocate From";
                    divReallocate.Visible = true;
                }
                else
                {
                    gvBCommit.Columns[0].Visible = false;
                    gvBCommit.FooterRow.Visible = true;
                    lblTransDetHeader.Text = "Transaction Detail";
                    divReallocate.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        public void ClearReallocationToPanel()
        {
            ddlRToFund.SelectedIndex = 0;
            ddlRtoFundType.SelectedIndex = 0;
            txtRToAmt.Text = "";
        }

        protected void imgBtnReallocate_Click(object sender, EventArgs e)
        {
            int? nullable = null;
            try
            {
                if (ddlRFromProj.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select reallocate from project";
                    ddlRFromProj.Focus();
                    return;
                }
                if (ddlRFromFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from reallocate from project";
                    ddlRFromFund.Focus();
                    return;
                }
                if (ddlRFromFundType.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund type from reallocate from project";
                    ddlRFromFundType.Focus();
                    return;
                }
                if (txtRToAmt.Text == "" || txtRfromAmt.Text == "" || Convert.ToDecimal(txtRfromAmt.Text) == 0 || Convert.ToDecimal(txtRToAmt.Text) == 0)
                {
                    lblRErrorMsg.Text = "Please enter a non zero amount before proceed";
                    return;
                }

                if (ddlRToProj.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select reallocate to project";
                    ddlRToProj.Focus();
                    return;
                }
                if (ddlRToFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from reallocate to project";
                    ddlRToFund.Focus();
                    return;
                }
                if (ddlRtoFundType.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund type from reallocate to project";
                    ddlRtoFundType.Focus();
                    return;
                }
                if (Convert.ToInt32(txtRfromAmt.Text) < Convert.ToInt32(txtRToAmt.Text))
                {
                    lblRErrorMsg.Text = "Reallocate to amount can't be more than available reallocation from amount";
                    txtRToAmt.Focus();
                    return;
                }
                if (ddlRFromFund.SelectedValue.ToString() == ddlRToFund.SelectedValue.ToString())
                {
                    if (ddlRtoFundType.SelectedValue.ToString() == ddlRFromFundType.SelectedValue.ToString())
                    {
                        lblRErrorMsg.Text = "Fund can not be reallocated to same fund type. Reallocate to different fund type.";
                        ddlRtoFundType.Focus();
                        return;
                    }
                }
                //if (hfTransId.Value != "" && hfRFromTransId.Value !="")
                //{
                //    DataTable dtIsDuplicate = new DataTable();
                //    dtIsDuplicate = FinancialTransactions.IsDuplicateReallocation(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(hfRFromTransId.Value), Convert.ToInt32(hfTransId.Value));

                //    if (dtIsDuplicate.Rows.Count > 0)
                //    {
                //        lblRErrorMsg.Text = "A reallocation was already made to this Fund and can not be reallocated to same fund. Reallocate to different fund";
                //        ddlRToFund.Focus();
                //        return;
                //    }
                //}

                if (hfBalAmt.Value != "")
                {
                    if (Convert.ToDecimal(txtRToAmt.Text) > Convert.ToDecimal(hfBalAmt.Value))
                    {
                        if (Convert.ToDecimal(hfBalAmt.Value) == 0)
                        {
                            lblRErrorMsg.Text = "Reallocation is complete, more funds not allowed";                            
                        }
                        txtRToAmt.Text = hfBalAmt.Value;
                        lblRErrorMsg.Text = "Amount auto adjusted to available fund amount";
                    }
                }

                dtable = new DataTable();
                dtable = FinancialTransactions.AddBoardReallocationTransaction(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRToProj.SelectedValue.ToString()),
                                                                      Convert.ToDateTime(txtRfromDate.Text),
                                                                      Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()),
                                                                      Convert.ToDecimal(txtRfromAmt.Text),
                                                                      Convert.ToInt32(ddlRToFund.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRtoFundType.SelectedValue.ToString()),
                                                                      Convert.ToDecimal(txtRToAmt.Text),
                                                                      hfRFromTransId.Value == "" ? nullable : Convert.ToInt32(hfRFromTransId.Value),
                                                                      hfTransId.Value == "" ? nullable : Convert.ToInt32(hfTransId.Value));

                hfRFromTransId.Value = dtable.Rows[0][0].ToString();
                hfTransId.Value = dtable.Rows[0][1].ToString();
                lblRErrorMsg.Text = "Reallocation was added successfully";
                BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(hfTransId.Value));
                ClearReallocationToPanel();
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        private void BindGvReallocate(int fromProjId, int toTransId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);
                gvReallocate.DataSource = dtFundDet;
                gvReallocate.DataBind();
                decimal totAmt = 0;
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
                    if (txtRfromAmt.Text != "")
                    {
                        lblBalAmt.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(txtRfromAmt.Text) - totAmt);
                        hfBalAmt.Value = Convert.ToString(Convert.ToDecimal(txtRfromAmt.Text) - totAmt);
                    }

                    if (lblBalAmt.Text != "$0.00")
                        lblErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }

        protected void ddlRFromProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromProj.SelectedIndex > 0)
            {
                hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";
                ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ddlRFromFund.DataValueField = "fundid";
                ddlRFromFund.DataTextField = "name";
                ddlRFromFund.DataBind();
                ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));

                ddlRToProj.SelectedIndex = ddlRFromProj.SelectedIndex;
                BindAllFunds();
                lbtnFromAwdSummary.Visible = true;
            }
        }

        protected void ClearReallocation()
        {
            txtRfromDate.Text = DateTime.Now.ToShortDateString();
            ddlRFromFund.SelectedIndex = 0;
            ddlRFromFundType.SelectedIndex = 0;
            txtRfromAmt.Text = "";
            ddlRToFund.SelectedIndex = 0;
            ddlRtoFundType.SelectedIndex = 0;
            txtRToAmt.Text = "";
            lblRErrorMsg.Text = "";
            gvReallocate.DataSource = null;
            gvReallocate.DataBind();
        }


        protected void CleanReallocation()
        {
            txtRfromDate.Text = DateTime.Now.ToShortDateString();
            txtRfromAmt.Text = "";
            txtRToAmt.Text = "";
            lblRErrorMsg.Text = "";

            ddlRFromFund.DataSource = null;
            ddlRFromFund.DataBind();
            ddlRFromFundType.DataSource = null;
            ddlRFromFundType.DataBind();
            ddlRToFund.DataSource = null;
            ddlRToFund.DataBind();
            ddlRtoFundType.DataSource = null;
            ddlRToFund.DataBind();
            gvReallocate.DataSource = null;
            gvReallocate.DataBind();
        }
        protected void ddlRToProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRToProj.SelectedIndex > 0)
            {
                hfTransId.Value = ""; hfRFromTransId.Value = "";
                if (ddlRToProj.SelectedIndex != ddlRFromProj.SelectedIndex)
                {
                    ddlRToFund.DataSource = FinancialTransactions.GetFundByProject(Convert.ToInt32(ddlRToProj.SelectedValue.ToString()));
                }
                else
                {
                    ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
                }
                ddlRToFund.DataValueField = "fundid";
                ddlRToFund.DataTextField = "name";
                ddlRToFund.DataBind();
                ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        protected void gvReallocate_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvReallocate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReallocate.EditIndex = -1;
            BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(hfTransId.Value));
        }

        protected void gvReallocate_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvReallocate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReallocate.EditIndex = e.NewEditIndex;
            BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(hfTransId.Value));
        }

        protected void gvReallocate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                decimal amount = Convert.ToDecimal(((TextBox)gvReallocate.Rows[rowIndex].FindControl("txtAmount")).Text);
                int detailId = Convert.ToInt32(((Label)gvReallocate.Rows[rowIndex].FindControl("lblDetId")).Text);

                if (hfBalAmt.Value != "")
                {
                    if (amount > Convert.ToDecimal(hfBalAmt.Value))
                    {
                        if (Convert.ToDecimal(hfBalAmt.Value) == 0)
                        {
                            lblRErrorMsg.Text = "Reallocation is complete, more funds not allowed";
                            return;
                        }
                        amount = Convert.ToDecimal(hfBalAmt.Value);
                        lblRErrorMsg.Text = "Amount auto adjusted to available fund amount";
                    }
                }

                FinancialTransactions.UpdateReallocationTransDetails(detailId, Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), amount);
                lblErrorMsg.Text = "";
                gvReallocate.EditIndex = -1;
                BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(hfTransId.Value));
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlRFromFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromFund.SelectedIndex > 0)
            {
                if (ddlRFromFund.SelectedItem.Text.ToLower().Contains("hopwa"))
                {
                    ddlRFromFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                }
                else
                {
                    ddlRFromFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                }

                //ddlRFromFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                ddlRFromFundType.DataValueField = "typeid";
                ddlRFromFundType.DataTextField = "Description";
                ddlRFromFundType.DataBind();
                ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
            }

        }

        protected void ddlRToFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRToFund.SelectedIndex > 0)
            {
                if (ddlRToFund.SelectedItem.Text.ToLower().Contains("hopwa"))
                {
                    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                }
                else
                {
                    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                }
                //ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                ddlRtoFundType.DataValueField = "typeid";
                ddlRtoFundType.DataTextField = "Description";
                ddlRtoFundType.DataBind();
                ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        protected void lbAwardSummary_Click(object sender, EventArgs e)
        {
            if (ddlProjFilter.SelectedIndex > 0)
            {
                string url = "https://vhcbcloud.org/awardsummary.aspx?projectid="+ ddlProjFilter.SelectedValue.ToString();
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
    }
}