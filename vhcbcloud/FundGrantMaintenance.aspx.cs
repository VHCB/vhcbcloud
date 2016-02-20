using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using System.Data;
using System.Globalization;

namespace vhcbcloud
{
    public partial class FundGrantMaintenance : System.Web.UI.Page
    {
        DataTable dtable;
        protected void Page_Load(object sender, EventArgs e)  
        {
            if (!IsPostBack)
            {
                BindLookups();
                BindFundInfo();
            }
            GetFundSelectedRecord(gvFund);
            GetGrantInfoSelectedRecord(gvGranInfo);
            lblErrorMsg.Text = "";
        }

        protected void BindLookups()
        {
            try
            {
                dtable = new DataTable();
                dtable = FundTypeData.GetFundType("GetFundTypeData");
                ddlFundType.DataSource = dtable;
                ddlFundType.DataValueField = "typeid";
                ddlFundType.DataTextField = "description";
                ddlFundType.DataBind();
                ddlFundType.Items.Insert(0, new ListItem("Select", "NA"));

                dtable = new DataTable();
                dtable = FinancialTransactions.GetLookupDetailsByName("LkAcctMethod");
                ddlAcctMethod.DataSource = dtable;
                ddlAcctMethod.DataValueField = "typeid";
                ddlAcctMethod.DataTextField = "description";
                ddlAcctMethod.DataBind();
                ddlAcctMethod.Items.Insert(0, new ListItem("Select", "NA"));


                dtable = new DataTable();
                dtable = FinancialTransactions.GetLookupDetailsByName("LkGrantor");
                ddlGrantor.DataSource = dtable;
                ddlGrantor.DataValueField = "typeid";
                ddlGrantor.DataTextField = "description";
                ddlGrantor.DataBind();
                ddlGrantor.Items.Insert(0, new ListItem("Select", "NA"));

                dtable = new DataTable();
                dtable = FinancialTransactions.GetLookupDetailsByName("LkYear");
                ddlFiscalYr.DataSource = dtable;
                ddlFiscalYr.DataValueField = "typeid";
                ddlFiscalYr.DataTextField = "description";
                ddlFiscalYr.DataBind();
                ddlFiscalYr.Items.Insert(0, new ListItem("Select", "NA"));

                dtable = new DataTable();
                dtable = FinancialTransactions.GetLookupDetailsByName("LKGrantSource");
                ddlGrantSource.DataSource = dtable;
                ddlGrantSource.DataValueField = "typeid";
                ddlGrantSource.DataTextField = "description";
                ddlGrantSource.DataBind();
                ddlGrantSource.Items.Insert(0, new ListItem("Select", "NA"));

                dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetStaffUsers");
                ddlStaff.DataSource = dtable;
                ddlStaff.DataValueField = "userid";
                ddlStaff.DataTextField = "name";
                ddlStaff.DataBind();
                ddlStaff.Items.Insert(0, new ListItem("Select", "NA"));

                dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetContactUsers");
                ddlContact.DataSource = dtable;
                ddlContact.DataValueField = "contactid";
                ddlContact.DataTextField = "name";
                ddlContact.DataBind();
                ddlContact.Items.Insert(0, new ListItem("Select", "NA"));


            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindFundInfo()
        {
            try
            {
                DataTable dtFundInfo = new DataTable();
                dtFundInfo = FinancialTransactions.GetFundInfoDetails();
                gvFund.DataSource = dtFundInfo;
                gvFund.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindFundInfoAddUpdate()
        {
            try
            {
                DataTable dtFundInfo = new DataTable();
                dtFundInfo = FinancialTransactions.GetFundInfoDetailsByLastModified();
                gvFund.DataSource = dtFundInfo;
                gvFund.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindGridWithSort()
        {
            DataTable dt = new DataTable();
            dt = FinancialTransactions.GetFundInfoDetails();
            SortDireaction = CommonHelper.GridSorting(gvFund, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);

        }

        protected void BindFundGrantInfo()
        {
            try
            {
                if (ViewState["SelectedFundId"] != null && ViewState["SelectedFundId"].ToString() != "")
                {
                    DataTable dtFGrantInfo = new DataTable();
                    dtFGrantInfo = FinancialTransactions.GetGrantInfoDetailsByFund(Convert.ToInt32(ViewState["SelectedFundId"]));
                    gvGranInfo.DataSource = dtFGrantInfo;
                    gvGranInfo.DataBind();
                    gvFrantInfoFy.DataSource = null;
                    gvFrantInfoFy.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        protected void btnFundSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (ddlFundType.SelectedIndex != 0)
                    if (ddlAcctMethod.SelectedIndex != 0)
                        if (hdUpdateMode.Value == "false")
                        {
                            FinancialTransactions.AddFundInfo(txtFname.Text, txtFAbbr.Text, Convert.ToInt32(ddlFundType.SelectedValue.ToString()), txtAcctNumber.Text, txtVHCBCode.Text,
                                Convert.ToInt32(ddlAcctMethod.SelectedValue.ToString()), txtDeptId.Text, rdBtnDrawDown.SelectedItem.Text == "Yes" ? true : false);
                        }
                        else
                        {
                            FinancialTransactions.UpdateFundInfo(Convert.ToInt32(hfFundId.Value), txtAcctNumber.Text, txtFname.Text, txtFAbbr.Text, Convert.ToInt32(ddlFundType.SelectedValue.ToString()), txtVHCBCode.Text,
                            Convert.ToInt32(ddlAcctMethod.SelectedValue.ToString()), txtDeptId.Text, rdBtnDrawDown.SelectedItem.Text == "Yes" ? true : false);
                            hdUpdateMode.Value = "false";
                            gvFund.EditIndex = -1;
                            ClearFundInfo();
                        }
                    else lblErrorMsg.Text = "Select Account Method to add new fund.";
                else lblErrorMsg.Text = "Select Fund type to add new fund.";
                ClearFundInfo();
                BindFundInfoAddUpdate();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ClearFundInfo()
        {
            txtFname.Text = "";
            txtFAbbr.Text = "";
            txtAcctNumber.Text = "";
            txtDeptId.Text = "";
            txtVHCBCode.Text = "";
            rdBtnDrawDown.ClearSelection();
            ddlFundType.SelectedIndex = 0;
            ddlAcctMethod.SelectedIndex = 0;
        }

        protected void gvFund_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvFund.EditIndex != -1)
            {
                // Use the Cancel property to cancel the paging operation.
                e.Cancel = true;

                // Display an error message.
                int newPageNumber = e.NewPageIndex + 1;
                lblErrorMsg.Text = "Please update the record before moving to page " +
                  newPageNumber.ToString() + ".";
            }
            else
            {
                // Clear the error message.
                lblErrorMsg.Text = "";
                gvFund.PageIndex = e.NewPageIndex;
                BindGridWithSort();
            }
        }

        protected void gvFund_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ClearFundInfo();
            gvFund.EditIndex = -1;
            BindFundInfo();
        }

        protected void gvFund_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int fundId = Convert.ToInt32(((Label)gvFund.Rows[e.RowIndex].FindControl("lblFundId")).Text);
                FinancialTransactions.DeleteFundInfo(fundId);
                BindFundInfo();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFund_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFund.EditIndex = e.NewEditIndex;
            BindFundInfo();
        }

        protected void gvFund_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int fundId = Convert.ToInt32(((Label)gvFund.Rows[rowIndex].FindControl("lblFundId")).Text);

                int fFundsType = Convert.ToInt32(((DropDownList)gvFund.Rows[rowIndex].FindControl("ddlFundsType")).SelectedValue.ToString());

                FinancialTransactions.UpdateFundInfo(fundId, txtAcctNumber.Text, txtFname.Text, txtFAbbr.Text, Convert.ToInt32(ddlFundType.SelectedValue.ToString()), txtVHCBCode.Text,
                        Convert.ToInt32(ddlAcctMethod.SelectedValue.ToString()), txtDeptId.Text, rdBtnDrawDown.SelectedItem.Text == "Yes" ? true : false);
                gvFund.EditIndex = -1;
                BindFundInfoAddUpdate();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFund_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            dtable = new DataTable();
            dtable = FinancialTransactions.GetFundInfoDetails();
            if (dtable.Rows.Count > 0)
            {
                gvFund.DataSource = dtable;
                gvFund.DataBind();
            }
            SortDireaction = CommonHelper.GridSorting(gvFund, dtable, SortExpression, SortDireaction);
        }

        protected void gvFund_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                CommonHelper.GridViewSetFocus(e.Row);

                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //Finding the Dropdown control.
                    hdUpdateMode.Value = "true";
                    Label lblFundId = e.Row.FindControl("lblFundId") as Label;
                    hfFundId.Value = lblFundId.Text;
                    dtable = new DataTable();
                    dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(lblFundId.Text));
                    DataRow drData = dtable.Rows[0];
                    txtFname.Text = drData["name"].ToString();
                    txtFAbbr.Text = drData["abbrv"].ToString();
                    txtAcctNumber.Text = drData["account"].ToString();
                    txtVHCBCode.Text = drData["VHCBCode"].ToString();
                    txtDeptId.Text = drData["DeptID"].ToString();
                    rdBtnDrawDown.SelectedIndex = drData["Drawdown"].ToString() == "0" ? 0 : 1;

                    string itemToCompare = string.Empty;
                    foreach (ListItem item in ddlFundType.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (drData["LkFundType"].ToString().ToLower() == itemToCompare)
                        {
                            ddlFundType.ClearSelection();
                            item.Selected = true;
                        }
                    }

                    itemToCompare = string.Empty;
                    foreach (ListItem item in ddlAcctMethod.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (drData["LkAcctMethod"].ToString().ToLower() == itemToCompare)
                        {
                            ddlAcctMethod.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }
            }
        }

        private void GetFundSelectedRecord(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rb != null)
                {
                    if (rb.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedFundId"] = hf.Value;
                        }
                        break;
                    }
                }
            }
        }

        private void ClearGrantInfo()
        {
            txtGrantName.Text = "";
            txtVHCBGrantName.Text = "";
            txtAwardNum.Text = "";
            ddlGrantor.SelectedIndex = 0;
            txtAwdAmt.Text = "";
            ddlGrantSource.SelectedIndex = 0;
            txtBeginDate.Text = "";
            txtEndDate.Text = "";
            ddlStaff.SelectedIndex = 0;
            ddlContact.SelectedIndex = 0;
            txtCGDANum.Text = "";
            rdbtnSignedGrant.ClearSelection();
            rdBtnFedFunds.ClearSelection();
            rdBtnAdmin.ClearSelection();
            rdBtnMatch.ClearSelection();
            rdBtnFundsRec.ClearSelection();
        }

        private void GetGrantInfoSelectedRecord(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rbGInfo = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelectGrantInfo");
                if (rbGInfo != null)
                {
                    if (rbGInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedGrantInfoId"] = hf.Value;
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

        protected void btnGrantSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                lblErrorMsg.Text = "";
                int? nullable = null;
                DateTime? nullableDateTime = null;
                if (ViewState["SelectedFundId"] != null && ViewState["SelectedFundId"].ToString() != "")
                {
                    if (txtBeginDate.Text != "")
                    {
                        if (txtEndDate.Text != "")
                            if (Convert.ToDateTime(txtBeginDate.Text) > Convert.ToDateTime(txtEndDate.Text))
                            {
                                lblErrorMsg.Text = "Grant end date can't be less than begin date.";
                                txtEndDate.Focus();
                                return;
                            }
                    }
                    if (txtVHCBGrantName.Text == "")
                    {
                        lblErrorMsg.Text = "Enter VHCB Name to add the Grant Info details for the fund ";
                        txtVHCBGrantName.Focus();
                        return;
                    }
                    //if (ddlGrantSource.SelectedIndex == 0 || ddlContact.SelectedIndex==0 || ddlStaff.SelectedIndex==0)
                    //{
                    //    lblErrorMsg.Text = "Source of Grant, Contact and Staff were required to add Grant information. ";
                    //    return;
                    //}
                    if (ddlGrantor.SelectedIndex != 0)
                    {
                        if (hfGIUpdateMode.Value == "false")
                        {
                            FinancialTransactions.AddGrantInfo(Convert.ToInt32(ViewState["SelectedFundId"]),
                                                               txtGrantName.Text,
                                                               txtVHCBGrantName.Text,
                                                               Convert.ToInt32(ddlGrantor.SelectedValue.ToString()),
                                                               ddlGrantSource.SelectedIndex != 0 ? Convert.ToInt32(ddlGrantSource.SelectedValue.ToString()) : nullable,
                                                               txtAwardNum.Text,
                                                               txtAwdAmt.Text == "" ? 0 : Convert.ToDecimal(txtAwdAmt.Text),
                                                               txtBeginDate.Text == "" ? nullableDateTime : Convert.ToDateTime(txtBeginDate.Text),
                                                               txtEndDate.Text == "" ? nullableDateTime : Convert.ToDateTime(txtEndDate.Text),
                                                               ddlStaff.SelectedIndex != 0 ? Convert.ToInt32(ddlStaff.SelectedValue.ToString()) : nullable,
                                                               ddlContact.SelectedIndex != 0 ? Convert.ToInt32(ddlContact.SelectedValue.ToString()) : nullable,
                                                               txtCGDANum.Text,
                                                               rdbtnSignedGrant.SelectedIndex == 0 ? true : false,
                                                               rdBtnFedFunds.SelectedIndex == 0 ? true : false,
                                                               rdBtnMatch.SelectedIndex == 0 ? true : false,
                                                               rdBtnFundsRec.SelectedIndex == 0 ? true : false,
                                                               rdBtnAdmin.SelectedIndex == 0 ? true : false
                                                               );
                        }
                        else
                        {
                            FinancialTransactions.UpdateGrantInfo(Convert.ToInt32(hfGInfoId.Value),
                                                               txtGrantName.Text,
                                                               txtVHCBGrantName.Text,
                                                               Convert.ToInt32(ddlGrantor.SelectedValue.ToString()),
                                                               ddlGrantSource.SelectedIndex != 0 ? Convert.ToInt32(ddlGrantSource.SelectedValue.ToString()) : nullable,
                                                               txtAwardNum.Text,
                                                               txtAwdAmt.Text == "" ? 0 : decimal.Parse(txtAwdAmt.Text, NumberStyles.Currency),// Convert.ToDecimal(txtAwdAmt.Text),
                                                               txtBeginDate.Text == "" ? nullableDateTime : Convert.ToDateTime(txtBeginDate.Text),
                                                               txtEndDate.Text == "" ? nullableDateTime : Convert.ToDateTime(txtEndDate.Text),
                                                               ddlStaff.SelectedIndex != 0 ? Convert.ToInt32(ddlStaff.SelectedValue.ToString()) : nullable,
                                                               ddlContact.SelectedIndex != 0 ? Convert.ToInt32(ddlContact.SelectedValue.ToString()) : nullable,
                                                               txtCGDANum.Text,
                                                               rdbtnSignedGrant.SelectedIndex == 0 ? true : false,
                                                               rdBtnFedFunds.SelectedIndex == 0 ? true : false,
                                                               rdBtnMatch.SelectedIndex == 0 ? true : false,
                                                               rdBtnFundsRec.SelectedIndex == 0 ? true : false,
                                                               rdBtnAdmin.SelectedIndex == 0 ? true : false
                                                               );
                            hfGIUpdateMode.Value = "false";
                            gvGranInfo.EditIndex = -1;
                        }
                        ClearGrantInfo();
                    }
                    else lblErrorMsg.Text = "Select Grantor to add Grant Information.";
                }
                else lblErrorMsg.Text = "Select Fund to add associated Grant information.";

                BindFundGrantInfo();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvGranInfo_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetGrantInfoSelectedRecord(gvGranInfo);
        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                BindFundGrantInfo();
                txtGrantName.Focus();
                gvGranInfo.Focus();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvGranInfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvGranInfo.EditIndex != -1)
            {
                // Use the Cancel property to cancel the paging operation.
                e.Cancel = true;

                // Display an error message.
                int newPageNumber = e.NewPageIndex + 1;
                lblErrorMsg.Text = "Please update the record before moving to page " +
                  newPageNumber.ToString() + ".";
            }
            else
            {
                // Clear the error message.
                lblErrorMsg.Text = "";
                gvGranInfo.PageIndex = e.NewPageIndex;
                BindFundGrantInfo();
            }
        }

        protected void gvGranInfo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ClearGrantInfo();
            gvGranInfo.EditIndex = -1;
            BindFundGrantInfo();
        }

        protected void gvGranInfo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvGranInfo.EditIndex = e.NewEditIndex;
            BindFundGrantInfo();
        }

        protected void gvGranInfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int grantInfoId = Convert.ToInt32(((Label)gvGranInfo.Rows[e.RowIndex].FindControl("lblGIId")).Text);
                FinancialTransactions.DeleteGrantInfo(grantInfoId);
                BindFundGrantInfo();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvGranInfo_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int grantInfoId = Convert.ToInt32(((Label)gvGranInfo.Rows[rowIndex].FindControl("lblGIId")).Text);

                FinancialTransactions.UpdateGrantInfo(grantInfoId,
                                                    txtGrantName.Text,
                                                    txtVHCBGrantName.Text,
                                                    Convert.ToInt32(ddlGrantor.SelectedValue.ToString()),
                                                    Convert.ToInt32(ddlGrantSource.SelectedValue.ToString()),
                                                    txtAwardNum.Text,
                                                    Convert.ToDecimal(txtAwdAmt.Text),
                                                    Convert.ToDateTime(txtBeginDate.Text),
                                                    Convert.ToDateTime(txtEndDate.Text),
                                                    Convert.ToInt32(ddlStaff.SelectedValue.ToString()),
                                                    Convert.ToInt32(ddlContact.SelectedValue.ToString()),
                                                    txtCGDANum.Text,
                                                    rdbtnSignedGrant.SelectedIndex == 0 ? true : false,
                                                    rdBtnFedFunds.SelectedIndex == 0 ? true : false,
                                                    rdBtnMatch.SelectedIndex == 0 ? true : false,
                                                    rdBtnFundsRec.SelectedIndex == 0 ? true : false,
                                                    rdBtnAdmin.SelectedIndex == 0 ? true : false);
                gvGranInfo.EditIndex = -1;
                BindFundGrantInfo();

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvGranInfo_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            dtable = new DataTable();
            dtable = FinancialTransactions.GetGrantInfoDetailsByFund(Convert.ToInt32(ViewState["SelectedFundId"]));
            if (dtable.Rows.Count > 0)
            {
                gvGranInfo.DataSource = dtable;
                gvGranInfo.DataBind();
            }
            SortDireaction = CommonHelper.GridSorting(gvGranInfo, dtable, SortExpression, SortDireaction);
        }

        protected void gvGranInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                CommonHelper.GridViewSetFocus(e.Row);
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    hfGIUpdateMode.Value = "true";
                    Label lblGInfo = e.Row.FindControl("lblGIId") as Label;
                    hfGInfoId.Value = lblGInfo.Text;
                    dtable = new DataTable();
                    dtable = FinancialTransactions.GetGrantInfoDetailsByGrantInfoId(Convert.ToInt32(lblGInfo.Text));
                    DataRow dr = dtable.Rows[0];
                    txtGrantName.Text = dr["GrantName"].ToString();
                    txtVHCBGrantName.Text = dr["VHCBName"].ToString();

                    txtAwardNum.Text = dr["AwardNum"].ToString();
                    txtAwdAmt.Text = string.Format("{0:C2}", Convert.ToDecimal(dr["AwardAmt"].ToString()));
                    txtBeginDate.Text = dr["BeginDate"].ToString();
                    txtEndDate.Text = dr["EndDate"].ToString();

                    txtCGDANum.Text = dr["cfda"].ToString();
                    rdbtnSignedGrant.SelectedIndex = dr["SignAgree"].ToString() == "0" ? 0 : 1;
                    rdBtnFedFunds.SelectedIndex = dr["Fedfunds"].ToString() == "0" ? 0 : 1;
                    rdBtnMatch.SelectedIndex = dr["match"].ToString() == "0" ? 0 : 1;
                    rdBtnFundsRec.SelectedIndex = dr["fundsrec"].ToString() == "0" ? 0 : 1;
                    rdBtnAdmin.SelectedIndex = dr["admin"].ToString() == "0" ? 0 : 1;

                    string itemToCompare = string.Empty;
                    foreach (ListItem item in ddlStaff.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (dr["staff"].ToString().ToLower() == itemToCompare)
                        {
                            ddlStaff.ClearSelection();
                            item.Selected = true;
                        }
                    }
                    itemToCompare = string.Empty;
                    foreach (ListItem item in ddlContact.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (dr["ContactID"].ToString().ToLower() == itemToCompare)
                        {
                            ddlContact.ClearSelection();
                            item.Selected = true;
                        }
                    }
                    itemToCompare = string.Empty;
                    foreach (ListItem item in ddlGrantor.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (dr["LkGrantor"].ToString().ToLower() == itemToCompare)
                        {
                            ddlGrantor.ClearSelection();
                            item.Selected = true;
                        }
                    }
                    itemToCompare = string.Empty;
                    foreach (ListItem item in ddlGrantSource.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (dr["LkGrantSource"].ToString().ToLower() == itemToCompare)
                        {
                            ddlGrantSource.ClearSelection();
                            item.Selected = true;
                        }
                    }

                }
            }
            //foreach (GridViewRow row in gvGranInfo.Rows)
            //{
            //    if (ViewState["SelectedGrantInfoId"] != null && ViewState["SelectedGrantInfoId"].ToString() != "")

            //        if (((Label)row.FindControl("lblGIId")).Text == ViewState["SelectedGrantInfoId"].ToString())
            //        {
            //            ((RadioButton)row.FindControl("rdBtnSelectGrantInfo")).Checked = true;
            //        }
            //}
        }

        protected void gvFrantInfoFy_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvFrantInfoFy.EditIndex != -1)
            {
                // Use the Cancel property to cancel the paging operation.
                e.Cancel = true;

                // Display an error message.
                int newPageNumber = e.NewPageIndex + 1;
                lblErrorMsg.Text = "Please update the record before moving to page " +
                  newPageNumber.ToString() + ".";
            }
            else
            {
                // Clear the error message.
                lblErrorMsg.Text = "";
                gvFrantInfoFy.PageIndex = e.NewPageIndex;
                BindFiscalYr();
            }
        }

        protected void gvFrantInfoFy_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFrantInfoFy.EditIndex = -1;
            BindFiscalYr();
        }

        protected void gvFrantInfoFy_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblFyAmt = (Label)gvFrantInfoFy.Rows[rowIndex].FindControl("lblGrantInfoFY");
                if (lblFyAmt != null)
                    FinancialTransactions.DeleteGrantInfoFyAmt(Convert.ToInt32(lblFyAmt.Text));
                BindFiscalYr();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFrantInfoFy_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFrantInfoFy.EditIndex = e.NewEditIndex;
            BindFiscalYr();
        }

        protected void gvFrantInfoFy_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            dtable = new DataTable();
            dtable = FinancialTransactions.GetGrantInfoFYAmount(Convert.ToInt32(ViewState["SelectedGrantInfoId"]));
            if (dtable.Rows.Count > 0)
            {
                gvFrantInfoFy.DataSource = dtable;
                gvFrantInfoFy.DataBind();
            }
            SortDireaction = CommonHelper.GridSorting(gvFrantInfoFy, dtable, SortExpression, SortDireaction);
        }

        protected void gvFrantInfoFy_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                CommonHelper.GridViewSetFocus(e.Row);
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    HiddenField hfFY = e.Row.FindControl("hfYear") as HiddenField;
                    DropDownList ddlyear = e.Row.FindControl("ddlFiscalYr") as DropDownList;

                    ddlyear.DataSource = FinancialTransactions.GetLookupDetailsByName("LkYear");
                    ddlyear.DataValueField = "typeid";
                    ddlyear.DataTextField = "description";
                    ddlyear.DataBind();
                    string itemToCompare = string.Empty;
                    foreach (ListItem item in ddlyear.Items)
                    {
                        itemToCompare = item.Value.ToString();
                        if (hfFY.Value.ToString().ToLower() == itemToCompare.ToLower())
                        {
                            ddlyear.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }
            }
        }

        protected void btnFisYrAmt_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                lblErrorMsg.Text = "";
                if (ViewState["SelectedGrantInfoId"] != null && ViewState["SelectedGrantInfoId"].ToString() != "")
                {
                    if (ddlFiscalYr.SelectedIndex != 0)
                        FinancialTransactions.AddGrantInfoFyAmt(Convert.ToInt32(ViewState["SelectedGrantInfoId"]), Convert.ToInt32(ddlFiscalYr.SelectedValue.ToString()), Convert.ToDecimal(txtAmount.Text));
                    else lblErrorMsg.Text = "Select Fiscal Year for Grant.";
                    BindFiscalYr();
                    ddlFiscalYr.SelectedIndex = 0;
                    txtAmount.Text = "";
                }
                else
                    lblErrorMsg.Text = "Select Grant to add Fiscal Year Amount";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetFundSelectedRecord(gvFund);
        }

        protected void rdBtnSelectGrantInfo_CheckedChanged(object sender, EventArgs e)
        {
            GetGrantInfoSelectedRecord(gvGranInfo);

            dtable = new DataTable();
            dtable = FinancialTransactions.GetGrantInfoDetailsByFund(Convert.ToInt32(ViewState["SelectedFundId"]));
            //ddlGrantInfoDet.DataSource = dtable;
            //ddlGrantInfoDet.DataValueField = "GrantinfoID";
            //ddlGrantInfoDet.DataTextField = "GrantName";
            //ddlGrantInfoDet.DataBind();
            //ddlGrantInfoDet.Items.Insert(0, new ListItem("Select", "NA"));
            hfGInfoId.Value = Convert.ToString(ViewState["SelectedGrantInfoId"]);
            DataTable dtFiscalYr = new DataTable();
            dtFiscalYr = FinancialTransactions.GetGrantInfoFYAmount(Convert.ToInt32(hfGInfoId.Value));
            gvFrantInfoFy.DataSource = dtFiscalYr;
            gvFrantInfoFy.DataBind();
        }

        protected void ddlGrantInfoDet_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindFiscalYr();
        }

        protected void BindFiscalYr()
        {
            try
            {

                DataTable dtFiscalYr = new DataTable();
                if (hfGInfoId.Value != "")
                    dtFiscalYr = FinancialTransactions.GetGrantInfoFYAmount(Convert.ToInt32(hfGInfoId.Value));
                else
                    dtFiscalYr = FinancialTransactions.GetGrantInfoFYAmount(Convert.ToInt32(ViewState["SelectedGrantInfoId"]));
                gvFrantInfoFy.DataSource = dtFiscalYr;
                gvFrantInfoFy.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFrantInfoFy_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int gInfoFyId = Convert.ToInt32(((Label)gvFrantInfoFy.Rows[rowIndex].FindControl("lblGrantInfoFY")).Text);
                int gInfoYr = Convert.ToInt32(((DropDownList)gvFrantInfoFy.Rows[rowIndex].FindControl("ddlFiscalYr")).SelectedValue.ToString());
                string gInfoYrAmt = ((TextBox)gvFrantInfoFy.Rows[rowIndex].FindControl("txtAmount")).Text;
                FinancialTransactions.UpdateGrantInfoFYAmt(gInfoFyId, gInfoYr, Convert.ToDecimal(gInfoYrAmt.ToString()));
                gvFrantInfoFy.EditIndex = -1;
                BindFiscalYr();
                ddlFiscalYr.SelectedIndex = 0;
                txtAmount.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

    }
}