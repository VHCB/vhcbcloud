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
    public partial class LoanSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string projId = Request.QueryString["projectid"].ToString();
                string loanId = Request.QueryString["loanid"].ToString();

                DataTable dtProjects = GetProjects();
                //BindProjects(dtProjects);

                if (projId != "")
                {
                    lblProjectName.Text = GetProjectName(dtProjects, projId);
                    lblLoanID.Text = loanId;
                    //ddlProj.Items.FindByValue(projId).Selected = true;
                    //txtFromCommitedProjNum.Text = ddlProj.SelectedItem.Text;
                    hfProjId.Value = projId;
                    DataRow drLoanMasterDetails = LoanMaintenanceData.GetLoanMasterDetailsByLoanID(Convert.ToInt32(lblLoanID.Text));

                    decimal BalForward = 0.00M;

                    if (drLoanMasterDetails != null)
                    {
                        if (drLoanMasterDetails["NoteAmt"].ToString() != "")
                            lblNoteAmount.Text = CommonHelper.myDollarFormat(drLoanMasterDetails["NoteAmt"].ToString());

                        if (drLoanMasterDetails["BalForward"].ToString() != "")
                        {
                            lblBegBalance.Text = CommonHelper.myDollarFormat(drLoanMasterDetails["BalForward"].ToString());
                            BalForward = DataUtils.GetDecimal(drLoanMasterDetails["BalForward"].ToString());
                        }
                        BindLoanSummary(Convert.ToInt32(loanId), BalForward);
                    }
                }
            }
            
            //ddlProj.Visible = false;

        }

        private void getLoanMasterDetails(string projId, string loanId)
        {
            
        }

        //private void BindProjects(DataTable dtProjects)
        //{
        //    ddlProj.DataSource = dtProjects;
        //    ddlProj.DataValueField = "projectId";
        //    ddlProj.DataTextField = "Proj_num";
        //    ddlProj.DataBind();
        //    ddlProj.Items.Insert(0, new ListItem("Select", "NA"));
        //}

        protected void hdnValue_ValueChanged(object sender, EventArgs e)
        {
            string projNum = ((HiddenField)sender).Value;

            DataTable dt = new DataTable();

            dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());

            ///populate the form based on retrieved data
            if (dt.Rows.Count > 0)
            {
                DataTable dtProjects = GetProjects();
                int projId = Convert.ToInt32(dt.Rows[0][0].ToString());
                lblProjectName.Text = GetProjectName(dtProjects, projId.ToString());
                //txtFromCommitedProjNum.Text = projNum;
                hdnValue.Value = projId.ToString();
                hfProjId.Value = projId.ToString();
                //BindLoanSummary(projId);
            }
        }

        protected void ddlProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlProj.SelectedIndex > 0)
            //{
            //    DataTable dtProjects = GetProjects();
            //    lblProjectName.Text = GetProjectName(dtProjects, ddlProj.SelectedValue.ToString());// +" - " + ddlProj.SelectedValue.ToString();
            //    BindLoanSummary(Convert.ToInt32(ddlProj.SelectedValue.ToString()));
            //}
        }

        private string GetProjectName(DataTable dtProjects, string projId)
        {
            DataRow[] dr = dtProjects.Select("projectid = '" + projId + "'");
            return dr[0]["Description"].ToString();
        }

        private DataTable GetProjects()
        {
            DataTable dtProjects = new DataTable();
            dtProjects = Project.GetProjects("GetProjects");
            return dtProjects;
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

        protected void gvLoanSummary_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        private void BindLoanSummary(int LoanId, decimal BalForward)
        {
            try
            {
                lblErrorMsg.Text = ""; DataTable dtLoanSummary = null; DataTable dtLoanDetail = null;
                dtLoanSummary = LoanMaintenanceData.GetLoanSummaryDetails(LoanId).Tables[0];
                //dtLoanDetail = LoanMaintenanceData.GetLoanSummaryDetails(LoanId).Tables[1];

                if (dtLoanSummary.Rows.Count > 0)
                    hfRecordCount.Value = dtLoanSummary.Rows.Count.ToString();
                else
                    hfRecordCount.Value = "0";

                gvLoanSummary.DataSource = dtLoanSummary;
                gvLoanSummary.DataBind();

                //DataView detailView = dtLoanDetail.DefaultView;
                //detailView.Sort = "DetailId DESC";

                //gvTransDetail.DataSource = detailView;
                //gvTransDetail.DataBind();
                SetSummaryGridTotals(dtLoanSummary, BalForward);

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void SetSummaryGridTotals(DataTable dtLoanSummary, decimal BalForward)
        {
            decimal totDisbursement = 0;
            decimal totModifications = 0;
            decimal totReceipts = 0;

            if (dtLoanSummary.Rows.Count > 0)
            {
                Label lblDisbursementTotal = (Label)gvLoanSummary.FooterRow.FindControl("lblDisbursementTotal");
                Label lblModificationsTotal = (Label)gvLoanSummary.FooterRow.FindControl("lblModificationsTotal");
                Label lblReceiptsTotal = (Label)gvLoanSummary.FooterRow.FindControl("lblReceiptsTotal");
                Label lblBalanceTotal = (Label)gvLoanSummary.FooterRow.FindControl("lblBalanceTotal");

                if (dtLoanSummary.Rows.Count > 0)
                {
                    for (int i = 0; i < dtLoanSummary.Rows.Count; i++)
                    {
                        if (Convert.ToDecimal(dtLoanSummary.Rows[i]["Disbursement"].ToString()) != 0)
                            totDisbursement += Convert.ToDecimal(dtLoanSummary.Rows[i]["Disbursement"].ToString());

                        if (Convert.ToDecimal(dtLoanSummary.Rows[i]["Modifications"].ToString()) != 0)
                            totModifications += Convert.ToDecimal(dtLoanSummary.Rows[i]["Modifications"].ToString());

                        if (Convert.ToDecimal(dtLoanSummary.Rows[i]["Receipts"].ToString()) != 0)
                            totReceipts += Convert.ToDecimal(dtLoanSummary.Rows[i]["Receipts"].ToString());

                    }
                }

                lblDisbursementTotal.Text = CommonHelper.myDollarFormat(totDisbursement);
                lblModificationsTotal.Text = CommonHelper.myDollarFormat(totModifications);
                lblReceiptsTotal.Text = CommonHelper.myDollarFormat(totReceipts);
                lblBalanceTotal.Text = CommonHelper.myDollarFormat(BalForward + totDisbursement + totModifications + totReceipts);
            }
        }

        protected void gvLoanSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            CommonHelper.GridViewSetFocus(e.Row);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int numberOfRows = DataUtils.GetInt(hfRecordCount.Value);

                if (numberOfRows > 0 && e.Row.RowIndex == numberOfRows -1)
                {
                    Label lblStar = e.Row.FindControl("lblStar") as Label;
                    lblStar.Text = "*";
                }
                
            }
        }

        protected void ImgLoanSummaryReport_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURLForLoanSummary(lblLoanID.Text, "Loan Summary Detail"));
        }
    }
}