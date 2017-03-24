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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rdBtnSelection.SelectedIndex = 1;
                hfReallocateGuid.Value = "";
                BindProjects();
            }
            if (rdBtnSelection.SelectedIndex == 0)
            {
                txtFromProjNum.Visible = true;
                txtFromCommitedProjNum.Visible = false;
            }
            else
            {
                txtFromProjNum.Visible = false;
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
        protected void rdBtnFinancial_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdBtnFinancial.SelectedIndex == 0)
                Response.Redirect("Commitments.aspx");
            else if (rdBtnFinancial.SelectedIndex == 1)
                Response.Redirect("Decommitments.aspx");
            else if (rdBtnFinancial.SelectedIndex == 2)
                Response.Redirect("Reallocations.aspx");
            else
                Response.Redirect("CashRefund.aspx");
        }

        protected void BindProjects()
        {
            try
            {
                DataTable dtProjects = new DataTable();
                dtProjects = ProjectCheckRequestData.GetData("getCommittedProjectslist");
                ddlRFromProj.Items.Clear();

                ddlRFromProj.DataSource = dtProjects;
                ddlRFromProj.DataValueField = "projectId";
                ddlRFromProj.DataTextField = "Proj_num";
                ddlRFromProj.DataBind();
                ddlRFromProj.Items.Insert(0, new ListItem("Select", "NA"));

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
            dt = Project.GetProjects("getCommittedPendingProjectslistByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNames.ToArray();
        }


        protected void ddlRFromProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromProj.SelectedIndex > 0)
            {
                hfReallocateGuid.Value = "";
                hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";

                ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ddlRFromFund.DataValueField = "fundid";
                ddlRFromFund.DataTextField = "name";
                ddlRFromFund.DataBind();
                ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));
                txtRfromDate.Text = DateTime.Now.ToShortDateString();
                hfProjId.Value = ddlRFromProj.SelectedValue.ToString();

                ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    DataTable dtFund = new DataTable();
                    DataTable dtRelAmt = new DataTable();
                    dtFund = FinancialTransactions.GetExistingCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                    if (dtFund.Rows.Count > 0)
                    {
                        ddlRFromFund.SelectedItem.Text = dtFund.Rows[0]["name"].ToString();
                    }
                    dtRelAmt = FinancialTransactions.GetReallocationAmtByProjId(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                    if (dtRelAmt.Rows.Count > 0)
                    {
                        txtRfromAmt.Text = dtRelAmt.Rows[0]["amount"].ToString();
                    }
                    BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                }
            }
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
            else
            {
                if (txtFromProjNum.Text == "")
                {
                    lblRErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }

            ///populate the form based on retrieved data
            getDetails(dt);
        }

        protected void hdnCommitedProjValue_ValueChanged(object sender, EventArgs e)
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
            else
            {
                if (txtFromProjNum.Text == "")
                {
                    lblRErrorMsg.Text = "Please select project number";
                    return;
                }
                dt = Project.GetProjects("GetProjectIdByProjNum", projNum.ToString());
            }

            ///populate the form based on retrieved data
            getDetails(dt);

        }

        private void getDetails(DataTable dt)
        {
            lblAvailFund.Text = "";
            lblAvailVisibleFund.Text = "";
            hfProjId.Value = dt.Rows[0][0].ToString();

            //DataRow dr = ProjectCheckRequestData.GetAvailableFundsByProject(int.Parse(hfProjId.Value));
            //if (dr != null)
            //    if (Convert.ToDecimal(dr["availFund"].ToString()) > 0)
            //    {
            //        lblAvailFund.Text = Convert.ToDecimal(dr["availFund"].ToString()).ToString("#.##");
            //        lblAvailVisibleFund.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(dr["availFund"].ToString()));

            //    }
            //    else
            //    {
            //        lblAvailFund.Text = "0.00";
            //        lblAvailVisibleFund.Text = "0.00";
            //    }

            hfReallocateGuid.Value = "";
            hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";
            txtRfromAmt.Text = "";
            ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(hfProjId.Value));
            ddlRFromFund.DataValueField = "fundid";
            ddlRFromFund.DataTextField = "name";
            ddlRFromFund.DataBind();
            ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));
            txtRfromDate.Text = DateTime.Now.ToShortDateString();

            ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;
        }

        protected void ddlRFromFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromFund.SelectedIndex > 0)
            {
                //ddlRFromFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                ddlRFromFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                ddlRFromFundType.DataValueField = "typeid";
                ddlRFromFundType.DataTextField = "fundtype";
                ddlRFromFundType.DataBind();
                lblAvailVisibleFund.Text = "";
                lblAvailFund.Text = "";
                if (ddlRFromFundType.Items.Count > 1)
                {
                    ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
                    clearGvReallocate();
                }
                else if (ddlRFromFundType.Items.Count == 1)
                {

                    if (rdBtnSelection.SelectedIndex > 0)
                        BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
                    else
                        clearGvReallocate();
                }
            }
        }

        private void clearGvReallocate()
        {
            gvReallocate.DataSource = null;
            gvReallocate.DataBind();
        }

        protected void ddlRFromFundType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromFundType.Items.Count > 1)
            {
                if (ddlRFromFundType.SelectedIndex != 0)
                {
                    if (rdBtnSelection.SelectedIndex > 0)
                        BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
                    else
                        clearGvReallocate();
                }
            }
        }

        private void ClearReallocationFromPanel()
        {
            txtFromCommitedProjNum.Text = "";
            ddlRFromProj.SelectedIndex = 0;
            txtFromProjNum.Text = "";

            ddlRFromFund.DataSource = null;
            ddlRFromFund.DataBind();

            ddlRFromFundType.DataSource = null;
            ddlRFromFundType.DataBind();
            txtRfromDate.Text = "";
            txtRfromAmt.Text = "";
        }

        private void DisableReallocationFromPanel()
        {
            txtFromProjNum.Enabled = false;
            ddlRFromFund.Enabled = false;
            ddlRFromFundType.Enabled = false;
            txtRfromDate.Enabled = false;
            txtRfromAmt.Enabled = false;
        }

        private void EnableReallocationFromPanel()
        {
            txtFromProjNum.Enabled = true;
            ddlRFromFund.Enabled = true;
            ddlRFromFundType.Enabled = true;
            txtRfromDate.Enabled = true;
            txtRfromAmt.Enabled = true;
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
                    if (txtRfromAmt.Text != "")
                    {
                        lblBalAmt.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(txtRfromAmt.Text) - totAmt);
                        hfBalAmt.Value = Convert.ToString(Convert.ToDecimal(txtRfromAmt.Text) - totAmt);
                    }

                    if (lblBalAmt.Text != "$0.00")
                    {
                        lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";

                        DisableReallocationFromPanel();
                    }
                    if (lblBalAmt.Text == "$0.00")
                    {
                        hfReallocateGuid.Value = "";
                        EnableReallocationFromPanel();
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
                // dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    DateTime dtFromDate = Convert.ToDateTime(txtRfromDate.Text);

                    dtFundDet = FinancialTransactions.GetReallocationDetailsProjFund(fromProjId, fundId, dtFromDate);
                }
                else
                {
                    dtFundDet = FinancialTransactions.GetReallocationDetailsByGuid(fromProjId, hfReallocateGuid.Value);
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

        private void BindGvReallocate(int fromProjId, int fundId, int transTypeId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                // dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    if (txtRfromDate.Text != "")
                    {
                        DateTime dtFromDate = Convert.ToDateTime(txtRfromDate.Text);
                        dtFundDet = FinancialTransactions.GetDistinctReallocationGuidsByProjFundTransType(fromProjId, fundId, transTypeId, dtFromDate);
                    }
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


        protected void lbAwardSummary_Click(object sender, EventArgs e)
        {
            //if (ddlRFromProj.SelectedIndex > 0)
            if (txtFromProjNum.Text != "")
            {
                string url = "/awardsummary.aspx?projectid=" + hfProjId.Value.ToString();
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

        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string guid = gvReallocate.DataKeys[e.Row.RowIndex].Value.ToString();

                GridView gvDetails = e.Row.FindControl("gvDetails") as GridView;
                DataTable dtDetails = new DataTable();
                if (txtRfromDate.Text != "")
                {
                    DateTime dtFromDate = Convert.ToDateTime(txtRfromDate.Text);
                    dtDetails = FinancialTransactions.GetReallocationDetailsProjFundTransType(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()),
                        Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()), dtFromDate, guid);
                }
                gvDetails.DataSource = dtDetails;
                gvDetails.DataBind();
            }
        }
        protected void OnDataBound(object sender, EventArgs e, GridView gv)
        {



            //for (int i = gv.Rows.Count - 1; i > 0; i--)
            //{
            //    GridViewRow row = gv.Rows[i];
            //    GridViewRow previousRow = gv.Rows[i - 1];

            //    if (row.Cells[1].Text == previousRow.Cells[1].Text)
            //    {
            //        if (previousRow.Cells[1].RowSpan == 0)
            //        {
            //            if (row.Cells[9].RowSpan == 0)
            //            {
            //                previousRow.Cells[9].RowSpan += 2;
            //            }
            //            else
            //            {
            //                previousRow.Cells[9].RowSpan = row.Cells[9].RowSpan + 1;
            //            }
            //            row.Cells[9].Visible = false;
            //        }
            //    }
            //}



            //for (int rowIndex = gv.Rows.Count - 2; rowIndex >= 0; rowIndex += -1)
            //{
            //    GridViewRow gviewRow = gv.Rows[rowIndex];
            //    GridViewRow gviewPreviousRow = gv.Rows[rowIndex + 1];
            //    for (int cellCount = 0; cellCount <= gviewRow.Cells.Count - 1; cellCount++)
            //    {
            //        if (gviewRow.Cells[cellCount].Text == gviewPreviousRow.Cells[cellCount].Text)
            //        {
            //            if (gviewPreviousRow.Cells[cellCount].RowSpan < 2)
            //            {
            //                gviewRow.Cells[cellCount].RowSpan = 2;
            //            }
            //            else
            //            {
            //                gviewRow.Cells[cellCount].RowSpan = gviewPreviousRow.Cells[cellCount].RowSpan + 1;
            //            }
            //            gviewPreviousRow.Cells[cellCount].Visible = false;
            //        }
            //    }
            //}
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

            Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            FinancialTransactions.DeleteReallocationsByGUID(lblGuid.Text);
            BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
        }

        protected void gvReallocate_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            OnDataBound(sender, e, gvReallocate);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (rdBtnSelection.SelectedIndex > 0)

                BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
        }

        protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //GridView gvDetails = gvreFindControl("gvDetails") as GridView;
            //Label lblGuid = (Label)gvDetails.Rows[e.RowIndex].FindControl("lblProjGuid");

            //FinancialTransactions.DeleteReallocationsByGUID(lblGuid.Text);
            //BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int transId = 0;
            LinkButton lnkDelete = (LinkButton)sender;
            if (lnkDelete != null)
                int.TryParse(lnkDelete.CommandArgument, out transId);
            if (transId != 0)
            {
                FinancialTransactions.DeleteReallocationTrans(transId);
                BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
            }
        }
    }
}