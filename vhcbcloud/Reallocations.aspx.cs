using System;
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
    public partial class Reallocations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
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
                ddlRToFund.Items.Clear();

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
                hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";
                DataTable dtFund = new DataTable();
                ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ddlRFromFund.DataValueField = "fundid";
                ddlRFromFund.DataTextField = "name";
                ddlRFromFund.DataBind();
                ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));
                txtRfromDate.Text = DateTime.Now.ToShortDateString();
                ddlRToProj.SelectedIndex = ddlRFromProj.SelectedIndex;
                BindAllFunds();
                hfProjId.Value = ddlRFromProj.SelectedValue.ToString();

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    dtFund =FinancialTransactions.GetExistingCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                    if (dtFund.Rows.Count > 0)
                    {
                        txtRfromAmt.Text = dtFund.Rows[0]["amount"].ToString();
                        ddlRFromFund.SelectedItem.Text = dtFund.Rows[0]["name"].ToString();
                    }
                    BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                }
            }
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

        protected void BindAllFunds()
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetDataTableByProcName("GetAllFunds");

                ddlRToFund.DataSource = dtable;
                ddlRToFund.DataValueField = "fundid";
                ddlRToFund.DataTextField = "name";
                ddlRToFund.DataBind();
                ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));
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
                ddlRFromFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                ddlRFromFundType.DataValueField = "typeid";
                ddlRFromFundType.DataTextField = "fundtype";
                ddlRFromFundType.DataBind();
                if (ddlRFromFundType.Items.Count > 1)
                    ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        protected void ddlRToFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRToFund.SelectedIndex > 0)
            {
                ddlRtoFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(ddlRToProj.SelectedValue.ToString()), Convert.ToInt32(ddlRToFund.SelectedValue.ToString()));
                ddlRtoFundType.DataValueField = "typeid";
                ddlRtoFundType.DataTextField = "fundtype";
                ddlRtoFundType.DataBind();
                if (ddlRtoFundType.Items.Count > 1)
                    ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));

            }
        }
              
        public void ClearReallocationToPanel()
        {
            ddlRToProj.SelectedIndex = 0;

            txtRToAmt.Text = "";
        }

        public void ClearReallocationFromPanel()
        {
            ddlRFromProj.SelectedIndex = 0;
            ddlRFromFund.DataSource = null;
            ddlRFromFund.DataBind();
            txtRfromDate.Text = "";
            txtRfromAmt.Text = "";
        }

        private void BindGvReallocate(int fromProjId)
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
                        lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                    else if (lblBalAmt.Text == "$0.00")
                        CommonHelper.DisableButton(btnReallocateSubmit);

                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
                throw;
            }
        }


        protected void lbAwardSummary_Click(object sender, EventArgs e)
        {
            if (ddlRFromProj.SelectedIndex > 0)
            {
                string url = "/awardsummary.aspx?projectid=" + ddlRFromProj.SelectedValue.ToString() + "&Reallocations=true";
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
            ClearReallocationFromPanel();
            ClearReallocationToPanel();

            if (rdBtnSelection.SelectedIndex==0)
            {
                gvReallocate.DataSource = null;
                gvReallocate.DataBind();
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnReallocateSubmit_Click(object sender, EventArgs e)
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
                if (ddlRFromFund.Items.Count > 1 && ddlRFromFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from reallocate from project";
                    ddlRFromFund.Focus();
                    return;
                }
                if (ddlRFromFundType.Items.Count > 1 && ddlRFromFundType.SelectedIndex == 0)
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

                if (ddlRToProj.Items.Count > 1 && ddlRToProj.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select reallocate to project";
                    ddlRToProj.Focus();
                    return;
                }
                if (ddlRToFund.Items.Count > 1 && ddlRToFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from reallocate to project";
                    ddlRToFund.Focus();
                    return;
                }
                if (ddlRtoFundType.Items.Count > 1 && ddlRtoFundType.SelectedIndex == 0)
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

                DataTable dtable = new DataTable();
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
                BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ClearReallocationToPanel();
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }
    }
}