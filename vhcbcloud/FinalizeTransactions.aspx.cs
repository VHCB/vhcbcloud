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
    public partial class FinalizeTransactions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //CompareEndTodayValidator.ValueToCompare = DateTime.Now.ToShortDateString();
            lblErrorMsg.Text = "";
            if (!IsPostBack)
            {
                BindProjects();
            }
        }

        protected void BindProjects()
        {
            try
            {
                DataTable dtProjects = new DataTable();
                dtProjects = Project.GetProjects("GetProjects");
                ddlProjFilter.DataSource = dtProjects;
                ddlProjFilter.DataValueField = "projectId";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
                ddlProjFilter.Items.Insert(1, new ListItem("All", "-1"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {

            lblErrorMsg.Text = "";

            gvTransactions.DataSource = null;
            gvTransactions.DataBind();

            pnlTranDetails.Visible = false;

            if (ddlProjFilter.SelectedIndex != 0)
            {
                int ProjectNo = Convert.ToInt32(ddlProjFilter.SelectedValue.ToString());
                lblProjNameText.Visible = true;

                if (ProjectNo == -1)
                    lblProjName.Text = "All";
                else
                {
                    DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(ProjectNo);
                    lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                }
            }
            else
            {
                lblProjNameText.Visible = false;
                lblProjName.Text = "";
            }
        }

        protected void btnSubit_click(object sender, EventArgs e)
        {
            DateTime tranFromDate;
            DateTime tranToDate;

            #region Validation
            if (ddlProjFilter.Items.Count > 1 && ddlProjFilter.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select Project";
                ddlProjFilter.Focus();
                return;
            }
            else if (ddlFinancialTrans.Items.Count > 1 && ddlFinancialTrans.SelectedIndex == 0)
            {
                lblErrorMsg.Text = "Select financial transaction";
                ddlFinancialTrans.Focus();
                return;
            }
            else if (txtTransDateFrom.Text.Trim() == "")
            {
                lblErrorMsg.Text = "Select Transaction From Date";
                txtTransDateFrom.Focus();
                return;
            }
            else if (txtTransDateTo.Text.Trim() == "")
            {
                lblErrorMsg.Text = "Select Transaction End Date";
                txtTransDateTo.Focus();
                return;

            }
            else
            {
                if (!DateTime.TryParse(txtTransDateFrom.Text.Trim(), out tranFromDate))
                {
                    lblErrorMsg.Text = "Select valid transaction From date";
                    txtTransDateFrom.Focus();
                    return;
                }
                if (!DateTime.TryParse(txtTransDateTo.Text.Trim(), out tranToDate))
                {
                    lblErrorMsg.Text = "Select valid transaction To date";
                    txtTransDateTo.Focus();
                    return;
                }
                if (tranFromDate >= DateTime.Today)
                {
                    lblErrorMsg.Text = "Transaction From date should be less than today";
                    txtTransDateFrom.Focus();
                    return;
                }
                if (tranToDate > DateTime.Today)
                {
                    lblErrorMsg.Text = "Transaction End date should be less than today";
                    txtTransDateTo.Focus();
                    return;
                }
                if (tranFromDate >= tranToDate)
                {
                    lblErrorMsg.Text = "Transaction From date should be less than End date";
                    txtTransDateFrom.Focus();
                    return;
                }
            }
            #endregion

            ViewState["FromDate"] = tranFromDate;
            ViewState["EndDate"] = tranToDate;

            PopulateTransactions(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), tranFromDate, tranToDate, Convert.ToInt32(ddlFinancialTrans.SelectedValue.ToString()));

        }

        private void PopulateTransactions(int Projectid, DateTime TranFromDate, DateTime TranToDate, int TransType)
        {
            DataTable dtable = FinancialTransactions.GetFinancialTransactions(Projectid, TranFromDate, TranToDate, TransType);

            if (dtable.Rows.Count > 0)
            {
                pnlTranDetails.Visible = true;
            }
            else
            {
                lblErrorMsg.Text = "No transactions found during this period.";
                pnlTranDetails.Visible = false;
            }

            gvTransactions.DataSource = dtable;
            gvTransactions.DataBind();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int transId = Convert.ToInt32(gvTransactions.DataKeys[e.Row.RowIndex].Value.ToString());
                GridView gvDetails = e.Row.FindControl("gvDetails") as GridView;

                DataTable dtDetails = FinancialTransactions.GetFinancialTransactionDetails(transId);
                gvDetails.DataSource = dtDetails;
                gvDetails.DataBind();

                decimal totFundAmt = 0;

                if (dtDetails.Rows.Count > 0)
                {
                    for (int i = 0; i < dtDetails.Rows.Count; i++)
                    {
                        totFundAmt += Convert.ToDecimal(dtDetails.Rows[i]["Amount"].ToString());
                    }
                }

                Label lblTotAmt = (Label)gvDetails.FooterRow.FindControl("lblFooterAmount");
                lblTotAmt.Text = CommonHelper.myDollarFormat(totFundAmt);

            }
        }

        protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    int transId = Convert.ToInt32(gvTransactions.DataKeys[e.Row.RowIndex].Value.ToString());
            //    GridView gvDetails = e.Row.FindControl("gvDetails") as GridView;
            //    gvDetails.DataSource = FinancialTransactions.GetFinancialTransactionDetails(transId);
            //    gvDetails.DataBind();
            //}
        }

        protected void btnTranSubmit_click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvTransactions.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkTrans") as CheckBox);
                    if (chkRow.Checked)
                    {
                        int transId = Convert.ToInt32(gvTransactions.DataKeys[row.RowIndex].Value.ToString());

                        FinancialTransactions.UpdateFinancialTransactionStatus(transId);
                    }
                }
            }

            PopulateTransactions(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), DateTime.Parse(ViewState["FromDate"].ToString()), DateTime.Parse(ViewState["EndDate"].ToString()), 
                Convert.ToInt32(ddlFinancialTrans.SelectedValue.ToString()));
        }
    }
}