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
    public partial class TransferDisbursements : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            if (!IsPostBack)
            {
                BindProjects();
                //BindFinancialTrans();
                txtTransDateTo.Text = DateTime.Now.ToString("M/dd/yyyy", CultureInfo.InvariantCulture);
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


        protected void lbtnShowAll_Click(object sender, EventArgs e)
        {

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

        protected void hdnValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;
            DataTable dt = new DataTable();

            dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            ///populate the form based on retrieved data
            if (dt.Rows.Count > 0)
            {
                lblProjNameText.Visible = true;

                if (txtFromCommitedProjNum.Text.ToLower() == "all")
                {
                    lblProjName.Text = "All";
                    //BindFinancialTrans();
                    //lbtnShowAll.Visible = false;
                }
                else
                {
                    //lbtnShowAll.Visible = true;
                    DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(dt.Rows[0][0].ToString()));
                    lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();

                    hfProjId.Value = dt.Rows[0][0].ToString();
                    //ddlFinancialTrans.Items.Remove(ddlFinancialTrans.Items.FindByValue("26552"));
                }
            }
            else
            {
                lblProjNameText.Visible = false;
                lblProjName.Text = "";
            }
        }

        //protected void BindFinancialTrans()
        //{
        //    try
        //    {
        //        ddlFinancialTrans.DataSource = FinancialTransactions.GetBoardFinancialTrans();
        //        ddlFinancialTrans.DataValueField = "TypeID";
        //        ddlFinancialTrans.DataTextField = "Description";
        //        ddlFinancialTrans.DataBind();
        //        ddlFinancialTrans.Items.Insert(0, new ListItem("Select Financial Transaction", "0"));
        //        ddlFinancialTrans.Items.Insert(1, new ListItem("All", "-1"));
        //    }
        //    catch (Exception ex)
        //    {
        //        lblErrorMsg.Text = ex.Message;
        //    }
        //}

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DateTime tranFromDate;
            DateTime tranToDate;

            #region Validation
            //if (ddlProjFilter.Items.Count > 1 && ddlProjFilter.SelectedIndex == 0)
            //{
            //    lblErrorMsg.Text = "Select Project";
            //    ddlProjFilter.Focus();
            //    return;
            //}
            //            else
            if (txtTransDateFrom.Text.Trim() == "")
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
                if (tranFromDate > DateTime.Today)
                {
                    lblErrorMsg.Text = "From Transaction date should be less than or equal to today";
                    txtTransDateFrom.Focus();
                    return;
                }
                if (tranFromDate > tranToDate)
                {
                    lblErrorMsg.Text = "From Transaction date should be less than End date";
                    txtTransDateFrom.Focus();
                    return;
                }
            }
            #endregion

            ViewState["FromDate"] = tranFromDate;
            ViewState["EndDate"] = tranToDate;

            lblProjNameText.Visible = true;
            lblProjName.Text = "";

            if (hfProjId.Value != "")
            {
                PopulateTransactions(Convert.ToInt32(hfProjId.Value), tranFromDate, tranToDate);
                DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(hfProjId.Value));
                lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                //lbtnShowAll.Visible = true;
            }
            else
            {
                lblProjName.Text = "All";
                PopulateTransactions(-1, tranFromDate, tranToDate);
                //lbtnShowAll.Visible = false;
            }
        }

        private void PopulateTransactions(int Projectid, DateTime TranFromDate, DateTime TranToDate)
        {
            DataTable dtable = FinancialTransactions.GetDisbursementTransactionDetails(Projectid, TranFromDate, TranToDate);

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

        protected void gvTransactions_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int LoanImportID = Convert.ToInt32(gvTransactions.DataKeys[e.Row.RowIndex].Value.ToString());

                var dd = e.Row.Cells[7].Controls[1] as DropDownList;
                if (null != dd)
                {
                    BindLoanId(dd, LoanImportID);
                }
            }
        }

        private void BindLoanId(DropDownList ddList, int LoanImportID)
        {
            try
            {
                DataTable dt = FinancialTransactions.GetLoanIdForProject(LoanImportID);
                ddList.Items.Clear();
                ddList.DataSource = dt;
                ddList.DataValueField = "LoanID";
                ddList.DataTextField = "LoanIDFundType";
                ddList.DataBind();

                if(dt.Rows.Count > 1)
                    ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error in loading loan Id's";
            }
        }

        protected void btnTranSubmit_Click(object sender, EventArgs e)
        {
            bool IsValidData = true;

            foreach (GridViewRow row in gvTransactions.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkTrans") as CheckBox);
                    if (chkRow.Checked)
                    {
                        DropDownList ddlLoanId = (row.Cells[0].FindControl("ddlLoanId") as DropDownList);
                        if (ddlLoanId.SelectedIndex == -1)
                        {
                            lblErrorMsg.Text = "All disbursements need an identified Loan Id";
                            IsValidData = false;
                            break;
                        }
                    }
                }
            }

            if (IsValidData)
            {
                foreach (GridViewRow row in gvTransactions.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkRow = (row.Cells[0].FindControl("chkTrans") as CheckBox);

                        if (chkRow.Checked)
                        {
                            DropDownList ddlLoanId = (row.Cells[0].FindControl("ddlLoanId") as DropDownList);

                            if (ddlLoanId.SelectedIndex != -1)
                            {
                                int LoanId = Convert.ToInt32(ddlLoanId.SelectedValue);
                                int LoanImportID = Convert.ToInt32(gvTransactions.DataKeys[row.RowIndex].Value.ToString());

                                FinancialTransactions.UpdateLoanImportTransactionStatus(LoanImportID, LoanId);
                            }
                        }
                    }
                }

                if (hfProjId.Value != "")
                {
                    PopulateTransactions(Convert.ToInt32(hfProjId.Value), DateTime.Parse(ViewState["FromDate"].ToString()), DateTime.Parse(ViewState["EndDate"].ToString()));
                    lblErrorMsg.Text = "Transaction finalized successfully";
                }
                else
                {
                    lblProjName.Text = "All";
                    PopulateTransactions(-1, DateTime.Parse(ViewState["FromDate"].ToString()), DateTime.Parse(ViewState["EndDate"].ToString()));
                    lblErrorMsg.Text = "Transaction finalized successfully";
                }
            }
        }

        protected void chkTrans_CheckedChanged(object sender, EventArgs e)
        {
            GridViewRow row = ((GridViewRow)((CheckBox)sender).NamingContainer);
            int index = row.RowIndex;
            CheckBox cb1 = (CheckBox)gvTransactions.Rows[index].FindControl("chkTrans");
            DropDownList ddlLoanId = (DropDownList)gvTransactions.Rows[index].FindControl("ddlLoanId");

            if (cb1.Checked)
                ddlLoanId.Enabled = true;
            else
            {
                ddlLoanId.SelectedIndex = -1;
                ddlLoanId.Enabled = false;
            }
        }

        protected void chkboxSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvTransactions.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkTrans") as CheckBox);
                    DropDownList ddlLoanId = (row.Cells[0].FindControl("ddlLoanId") as DropDownList);

                    if (chkRow.Checked)
                        ddlLoanId.Enabled = true;
                    else
                    {
                        ddlLoanId.SelectedIndex = -1;
                        ddlLoanId.Enabled = false;
                    }
                }
            }
        }
    }
}