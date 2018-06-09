using Microsoft.AspNet.Identity;
using System;
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
    public partial class Assignments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                rdBtnSelection.SelectedIndex = 0;
                hfReallocateGuid.Value = "";
                BindProjects();
                CheckPageAccess();
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
                //this.MasterPageFile = "SiteNonAdmin.Master";
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
            else if (rdBtnFinancial.SelectedIndex == 3)
                Response.Redirect("Assignments.aspx");
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

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAssignmentProjectslistByFilter(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();
            // dt = Project.GetProjects("GetAssignmentProjectslistByFilter", prefixText);
            dt = Project.GetProjects("GetProjectsByFilter", prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i][0].ToString() != contextKey)
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
                hfProjId.Value = ddlRFromProj.SelectedValue.ToString();

                ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value)); //FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ddlRFromFund.DataValueField = "fundid";
                ddlRFromFund.DataTextField = "name";
                ddlRFromFund.DataBind();
                ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));

                ddlAccountFrom.DataSource = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value)); //FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ddlAccountFrom.DataValueField = "fundid";
                ddlAccountFrom.DataTextField = "account";
                ddlAccountFrom.DataBind();
                ddlAccountFrom.Items.Insert(0, new ListItem("Select", "NA"));

                txtRfromDate.Text = DateTime.Now.ToShortDateString();
                ddlRToProj.SelectedIndex = ddlRFromProj.SelectedIndex;
                BindAllFunds();

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
                    //BindGvReallocate(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                    BindGvReallocate();
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
            ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value)); //FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(hfProjId.Value));
            ddlRFromFund.DataValueField = "fundid";
            ddlRFromFund.DataTextField = "name";
            ddlRFromFund.DataBind();
            ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));

            ddlAccountFrom.DataSource = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value)); //FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(hfProjId.Value));
            ddlAccountFrom.DataValueField = "fundid";
            ddlAccountFrom.DataTextField = "account";
            ddlAccountFrom.DataBind();
            ddlAccountFrom.Items.Insert(0, new ListItem("Select", "NA"));

            txtRfromDate.Text = DateTime.Now.ToShortDateString();
            //ddlRToProj.SelectedIndex = ddlRFromProj.SelectedIndex;
            //txtToProjNum.Text = txtFromProjNum.Text;
            BindAllFunds();

            ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + hfProjId.Value;

            //if (rdBtnSelection.SelectedIndex > 0)
            //{
            //    DataTable dtFund = new DataTable();
            //    DataTable dtRelAmt = new DataTable();
            //    dtFund = FinancialTransactions.GetExistingCommittedFundByProject(Convert.ToInt32(hfProjId.Value));
            //if (dtFund.Rows.Count > 0)
            //{
            //    ddlRFromFund.SelectedItem.Text = dtFund.Rows[0]["name"].ToString();
            //}
            //dtRelAmt = FinancialTransactions.GetReallocationAmtByProjId(Convert.ToInt32(hfProjId.Value));
            //if (dtRelAmt.Rows.Count > 0)
            //{
            //    txtRfromAmt.Text = dtRelAmt.Rows[0]["amount"].ToString();
            //}
            //BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()));
            //}
        }


        protected void hdnToValue_ValueChanged(object sender, EventArgs e)
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
            getToDetails(dt);
        }

        protected void hdnToCommitedProjValue_ValueChanged(object sender, EventArgs e)
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
            getToDetails(dt);
        }


        private void getToDetails(DataTable dt)
        {
            hfToProjId.Value = dt.Rows[0][0].ToString();
            //hfTransId.Value = ""; hfRFromTransId.Value = "";
            /*DO NOT Remove the below code*/
            //if (ddlRToProj.SelectedIndex != ddlRFromProj.SelectedIndex)
            //{
            //    ddlRToFund.DataSource = FinancialTransactions.GetFundByProject(Convert.ToInt32(ddlRToProj.SelectedValue.ToString()));
            //}
            //else
            //{
            //    ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
            //}

            ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
            ddlRToFund.DataValueField = "fundid";
            ddlRToFund.DataTextField = "name";
            ddlRToFund.DataBind();
            ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));

            //ddlAccountFrom.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds"); ;
            //ddlAccountFrom.DataValueField = "fundid";
            //ddlAccountFrom.DataTextField = "account";
            //ddlAccountFrom.DataBind();
            //ddlAccountFrom.Items.Insert(0, new ListItem("Select", "NA"));

            if (txtToProjNum.Text != txtFromProjNum.Text)
            {
                ddlRToFund.SelectedValue = ddlRFromFund.SelectedValue;

                ddlRToFund.Enabled = false;

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
                ddlRtoFundType.SelectedValue = ddlRFromFundType.SelectedValue;
                ddlRtoFundType.Enabled = false;
            }
            else
            {
                ddlRToFund.Enabled = true;
                ddlRtoFundType.Enabled = true;
            }
        }


        protected void ddlRToProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRToProj.SelectedIndex > 0)
            {
                hfTransId.Value = ""; hfRFromTransId.Value = "";
                /*DO NOT Remove the below code*/
                //if (ddlRToProj.SelectedIndex != ddlRFromProj.SelectedIndex)
                //{
                //    ddlRToFund.DataSource = FinancialTransactions.GetFundByProject(Convert.ToInt32(ddlRToProj.SelectedValue.ToString()));
                //}
                //else
                //{
                //    ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
                //}

                ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
                ddlRToFund.DataValueField = "fundid";
                ddlRToFund.DataTextField = "name";
                ddlRToFund.DataBind();
                ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));

                if (ddlRToProj.SelectedIndex != ddlRFromProj.SelectedIndex)
                {
                    ddlRToFund.SelectedValue = ddlRFromFund.SelectedValue;
                    ddlRToFund.Enabled = false;
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
                else
                    ddlRToFund.Enabled = true;
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

        protected void ddlRFromFundType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromFundType.Items.Count > 1)
            {
                if (ddlRFromFundType.SelectedIndex != 0)
                {
                    SetAvailableFundsLabel();

                    //DataTable dtable = FinancialTransactions.GetCommittedFundDetailsByFundTransType(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
                    //if (dtable.Rows.Count > 0)
                    //{
                    //    lblAvailVisibleFund.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(dtable.Rows[0]["balance"].ToString()));
                    //    lblAvailFund.Text = Convert.ToDecimal(dtable.Rows[0]["balance"].ToString()).ToString();
                    //}
                    if (rdBtnSelection.SelectedIndex > 0)
                        BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
                }
            }
        }

        private void SetAvailableFundsLabel()
        {
            DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundAmount(Convert.ToInt32(hfProjId.Value),
                                DataUtils.GetInt(ddlRFromFund.SelectedValue.ToString()),
                                DataUtils.GetInt(ddlRFromFundType.SelectedValue.ToString()),
                                "");

            if (dtAvailFunds != null && dtAvailFunds.Rows.Count > 0)
            {
                lblAvailVisibleFund.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(dtAvailFunds.Rows[0]["Balanced"].ToString()));
                lblAvailFund.Text = Convert.ToDecimal(dtAvailFunds.Rows[0]["Balanced"].ToString()).ToString();
            }
            else
            {
                lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
                lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");
            }
        }

        protected void ddlRToFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlRFromProj.SelectedValue.ToString() != ddlRToProj.SelectedValue.ToString())
            if (txtFromProjNum.Text != txtToProjNum.Text)
            {
                /*Do not Remove below*/
                //if (ddlRToFund.SelectedIndex > 0)
                //{
                //    ddlRtoFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(ddlRToProj.SelectedValue.ToString()), Convert.ToInt32(ddlRToFund.SelectedValue.ToString()));
                //    ddlRtoFundType.DataValueField = "typeid";
                //    ddlRtoFundType.DataTextField = "fundtype";
                //    ddlRtoFundType.DataBind();
                //    if (ddlRtoFundType.Items.Count > 1)
                //        ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));
                //}
            }
            else
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
        }

        private void ClearReallocationToPanel()
        {
            txtToProjNum.Text = "";
            ddlRToProj.SelectedIndex = 0;
            ddlRToFund.DataSource = null;
            ddlRToFund.DataBind();
            ddlRtoFundType.DataSource = null;
            ddlRtoFundType.DataBind();
            txtRToAmt.Text = "";
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

        private void BindGvReallocate()
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                // dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);

                dtFundDet = FinancialTransactions.GetAssignmentByTransId(Convert.ToInt32(hfTransId.Value));

                //if (rdBtnSelection.SelectedIndex > 0)
                //{
                //    dtFundDet = FinancialTransactions.GetAssignmentByTransId(fromProjId);
                //}
                //else
                //{
                //    dtFundDet = FinancialTransactions.GetAssignmentByGuid(fromProjId, hfReallocateGuid.Value);
                //}

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
                        tblReallocateTo.Visible = true;
                        btnReallocateSubmit.Visible = true;
                        lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                        btnNewTransaction.Visible = false;
                        DisableReallocationFromPanel();
                    }
                    if (lblBalAmt.Text == "$0.00")
                    {
                        tblReallocateTo.Visible = false;
                        btnReallocateSubmit.Visible = false;
                        CommonHelper.DisableButton(btnReallocateSubmit);
                        btnNewTransaction.Visible = true;
                        hfReallocateGuid.Value = "";
                        EnableReallocationFromPanel();
                    }
                }
                //else
                //{
                //    btnReallocateSubmit.Visible = false;
                //    btnNewTransaction.Visible = true;
                //}
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

                dtFundDet = FinancialTransactions.GetAssignmentByGuid(fromProjId, reallocateGuid);

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
                        btnReallocateSubmit.Visible = true;
                        tblReallocateTo.Visible = true;
                        //lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                        btnNewTransaction.Visible = false;
                        DisableReallocationFromPanel();
                    }
                    if (lblBalAmt.Text == "$0.00")
                    {
                        btnReallocateSubmit.Visible = false;
                        tblReallocateTo.Visible = false;
                        CommonHelper.DisableButton(btnReallocateSubmit);
                        btnNewTransaction.Visible = true;
                        hfReallocateGuid.Value = "";
                        EnableReallocationFromPanel();
                    }
                }
                else
                {
                    btnReallocateSubmit.Visible = false;
                    btnNewTransaction.Visible = true;
                }
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
                    dtFundDet = FinancialTransactions.GetAssignmentDetailsNewProjFund(fromProjId, fundId);
                }
                else
                {
                    dtFundDet = FinancialTransactions.GetAssignmentByGuid(fromProjId, hfReallocateGuid.Value);
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
                        tblReallocateTo.Visible = true;
                        btnReallocateSubmit.Visible = true;
                        //lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                        btnNewTransaction.Visible = false;
                        if (rdBtnSelection.SelectedIndex == 0)
                            DisableReallocationFromPanel();
                    }
                    if (lblBalAmt.Text == "$0.00")
                    {
                        tblReallocateTo.Visible = false;
                        btnReallocateSubmit.Visible = false;
                        CommonHelper.DisableButton(btnReallocateSubmit);
                        btnNewTransaction.Visible = true;
                        hfReallocateGuid.Value = "";
                        EnableReallocationFromPanel();
                    }
                }
                else
                {
                    btnReallocateSubmit.Visible = false;
                    btnNewTransaction.Visible = true;
                }
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
                    dtFundDet = FinancialTransactions.GetAssignmentDetailsNewProjFundTransType(fromProjId, fundId, transTypeId);
                }
                else
                {
                    dtFundDet = FinancialTransactions.GetAssignmentByGuid(fromProjId, hfReallocateGuid.Value);
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
                        tblReallocateTo.Visible = true;
                        btnReallocateSubmit.Visible = true;
                        // lblRErrorMsg.Text = "The transaction balance amount must be zero prior to leaving this page";
                        btnNewTransaction.Visible = false;
                        if (rdBtnSelection.SelectedIndex == 0)
                            DisableReallocationFromPanel();
                    }
                    if (lblBalAmt.Text == "$0.00")
                    {
                        tblReallocateTo.Visible = false;
                        btnReallocateSubmit.Visible = false;
                        CommonHelper.DisableButton(btnReallocateSubmit);
                        btnNewTransaction.Visible = true;
                        hfReallocateGuid.Value = "";
                        EnableReallocationFromPanel();
                    }
                }
                else
                {
                    btnReallocateSubmit.Visible = false;
                    btnNewTransaction.Visible = true;
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
            ClearReallocationToPanel();
            lblRErrorMsg.Text = "";
            gvReallocate.DataSource = null;
            gvReallocate.DataBind();
            btnNewTransaction.Visible = false;
            if (rdBtnSelection.SelectedIndex == 0)
            {
                btnReallocateSubmit.Visible = true;
                CommonHelper.EnableButton(btnReallocateSubmit);
            }
            else
            {
                Response.Redirect("ExistingAssignments.aspx");
                btnReallocateSubmit.Visible = false;
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
                string str_F = txtRfromAmt.Text;
                string tmp_F = Regex.Replace(str_F, "[^0-9a-zA-Z.]+", "");
                txtRfromAmt.Text = tmp_F.ToString();

                string str_T = txtRToAmt.Text;
                string tmp_T = Regex.Replace(str_T, "[^0-9a-zA-Z.]+", "");
                txtRToAmt.Text = tmp_T.ToString();

                btnNewTransaction.Visible = false;
                #region validations
                //if (ddlRFromProj.SelectedIndex == 0)
                //{
                //    lblRErrorMsg.Text = "Select reallocate from project";
                //    ddlRFromProj.Focus();
                //    return;
                //}
                if (txtFromProjNum.Text == "")
                {
                    lblRErrorMsg.Text = "Select assignment from project";
                    txtFromProjNum.Focus();
                    return;
                }
                if (ddlRFromFund.Items.Count > 1 && ddlRFromFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from assignment from project";
                    ddlRFromFund.Focus();
                    return;
                }
                if (ddlRFromFundType.Items.Count > 1 && ddlRFromFundType.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund type from assignment from project";
                    ddlRFromFundType.Focus();
                    return;
                }
                if (txtRToAmt.Text == "" || txtRfromAmt.Text == "" || Convert.ToDecimal(txtRfromAmt.Text) == 0 || Convert.ToDecimal(txtRToAmt.Text) == 0)
                {
                    lblRErrorMsg.Text = "Please enter a non zero amount before proceed";
                    return;
                }

                //if (ddlRToProj.Items.Count > 1 && ddlRToProj.SelectedIndex == 0)
                //{
                //    lblRErrorMsg.Text = "Select assignment to project";
                //    ddlRToProj.Focus();
                //    return;
                //}
                if (ddlRToFund.Items.Count > 1 && ddlRToFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from assignment to project";
                    ddlRToFund.Focus();
                    return;
                }
                if (ddlRtoFundType.Items.Count > 1 && ddlRtoFundType.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund type from assignment to project";
                    ddlRtoFundType.Focus();
                    return;
                }
                if (Convert.ToDecimal(txtRfromAmt.Text) < Convert.ToDecimal(txtRToAmt.Text))
                {
                    lblRErrorMsg.Text = "Assign to amount can't be more than available Assign from amount";
                    txtRToAmt.Focus();
                    return;
                }
                //if (ddlRFromFund.SelectedValue.ToString() == ddlRToFund.SelectedValue.ToString())
                //{
                //    lblRErrorMsg.Text = "Please select different project with funds assignment.";
                //    return;
                //}
                //if (ddlRFromProj.SelectedValue == ddlRToProj.SelectedValue)
                if (txtFromProjNum.Text == txtToProjNum.Text)
                {
                    lblRErrorMsg.Text = "Please select different assign to project with funds assignment.";
                    return;
                }
                //if (ddlRFromFund.SelectedValue.ToString() == ddlRToFund.SelectedValue.ToString())
                //{
                //    lblRErrorMsg.Text = "Please select different project with funds assignment.";
                //    return;
                //if (ddlRtoFundType.SelectedValue.ToString() == ddlRFromFundType.SelectedValue.ToString())
                //{
                //    lblRErrorMsg.Text = "Fund cannot be assignmentd to same fund type. Reallocate to different fund type.";
                //    ddlRtoFundType.Focus();
                //    return;
                //}
                //}
                //if (hfTransId.Value != "" && hfRFromTransId.Value !="")
                //{
                //    DataTable dtIsDuplicate = new DataTable();
                //    dtIsDuplicate = FinancialTransactions.IsDuplicateReallocation(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(hfRFromTransId.Value), Convert.ToInt32(hfTransId.Value));

                //    if (dtIsDuplicate.Rows.Count > 0)
                //    {
                //        lblRErrorMsg.Text = "A reallocation was already made to this Fund and can not be assignmentd to same fund. Reallocate to different fund";
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
                            lblRErrorMsg.Text = "Assignment is complete, more funds not allowed";
                            return;
                        }
                        // txtRToAmt.Text = hfBalAmt.Value;
                        lblRErrorMsg.Text = "Amount can not be more than available balance amount";
                        return;
                    }
                }
                decimal n;
                bool availFunds = decimal.TryParse(lblAvailFund.Text.Trim(), out n);
                if (!availFunds || Convert.ToDecimal(txtRfromAmt.Text) > Convert.ToDecimal(lblAvailFund.Text))
                {
                    if (!availFunds)
                        lblRErrorMsg.Text = "Amount can't be more than available assignment funds (" + CommonHelper.myDollarFormat(0) + ") for the selected from project";
                    else
                        lblRErrorMsg.Text = "Amount can't be more than available assignment from funds (" + CommonHelper.myDollarFormat(lblAvailFund.Text) + ") for the selected from project";

                    txtRfromAmt.Focus();
                    return;
                }

                DateTime AcctEffectiveDate = FinancialTransactions.GetSetupDate();

                if (AcctEffectiveDate > Convert.ToDateTime(txtRfromDate.Text))
                {
                    lblRErrorMsg.Text = "Trans date should not be lessthan Acct Effective Date " + AcctEffectiveDate.ToShortDateString();
                    txtRfromDate.Focus();
                    return;
                }

                #endregion

                if (hfReallocateGuid.Value == "")
                {
                    hfReallocateGuid.Value = Guid.NewGuid().ToString();
                }

                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.AddStaffAssignment(Convert.ToInt32(hfProjId.Value.ToString()),
                                                                      txtFromProjNum.Text == txtToProjNum.Text ? Convert.ToInt32(hfProjId.Value.ToString()) : Convert.ToInt32(hfToProjId.Value.ToString()),
                                                                      Convert.ToDateTime(txtRfromDate.Text),
                                                                      Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()),
                                                                      Convert.ToDecimal(txtRfromAmt.Text),
                                                                      Convert.ToInt32(ddlRToFund.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRtoFundType.SelectedValue.ToString()),
                                                                      Convert.ToDecimal(txtRToAmt.Text),
                                                                      hfRFromTransId.Value == "" ? nullable : Convert.ToInt32(hfRFromTransId.Value),
                                                                      hfTransId.Value == "" ? nullable : Convert.ToInt32(hfTransId.Value), hfReallocateGuid.Value.ToString(), GetUserId());

                hfRFromTransId.Value = dtable.Rows[0][0].ToString();
                hfTransId.Value = dtable.Rows[0][0].ToString();

                lblRErrorMsg.Text = "Assignment was added successfully";
                //BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()));
                BindGvReallocate();
                ClearReallocationToPanel();
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        protected void btnNewTransaction_Click(object sender, EventArgs e)
        {
            Response.Redirect("assignments.aspx");
        }

        protected void gvReallocate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReallocate.EditIndex = e.NewEditIndex;
            Label lblGuid = (Label)gvReallocate.Rows[e.NewEditIndex].FindControl("lblProjGuid");

            BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()), lblGuid.Text);
            if (btnNewTransaction.Visible == true)
            {
                btnNewTransaction.Visible = false;
            }
        }

        protected void gvReallocate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReallocate.EditIndex = -1;
            Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            //BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()), lblGuid.Text);
            //BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()));
            BindGvReallocate();
        }

        protected void gvReallocate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            FinancialTransactions.DeleteAssignmentDetailByGUID(lblGuid.Text);
            //BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
            BindGvReallocate();
        }

        protected void gvReallocate_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected int GetUserId()
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetUserByUserName(Context.User.Identity.GetUserName());
                return dtUser != null ? Convert.ToInt32(dtUser.Rows[0][0].ToString()) : 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        private void CheckPageAccess()
        {
            DataTable dt = new DataTable();
            dt = UserSecurityData.GetuserPageSecurity(GetUserId());

            foreach (DataRow row in dt.Rows)
            {
                if (row["pageid"].ToString() == "26725")
                    rdBtnFinancial.Items[0].Enabled = false;
                if (row["pageid"].ToString() == "26780")
                    rdBtnFinancial.Items[1].Enabled = false;
                if (row["pageid"].ToString() == "27455")
                    rdBtnFinancial.Items[2].Enabled = false;
                if (row["pageid"].ToString() == "27456")
                    rdBtnFinancial.Items[3].Enabled = false;
            }

            //if (rdBtnFinancial.Items[0].Enabled)
            //    rdBtnFinancial.Items[0].Selected = true;
            //if (rdBtnFinancial.Items[1].Enabled)
            //    rdBtnFinancial.Items[1].Selected = true;
            //if (rdBtnFinancial.Items[2].Enabled)
            //    rdBtnFinancial.Items[2].Selected = true;
            if (rdBtnFinancial.Items[3].Enabled)
                rdBtnFinancial.Items[3].Selected = true;
        }

        protected void ddlRFromFund_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromFund.SelectedIndex > 0)
            {
                ddlAccountFrom.SelectedValue = ddlRFromFund.SelectedValue;

                //ddlRFromFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                ddlRFromFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                ddlRFromFundType.DataValueField = "typeid";
                ddlRFromFundType.DataTextField = "fundtype";
                ddlRFromFundType.DataBind();

                lblAvailVisibleFund.Text = "";
                lblAvailFund.Text = "";

                if (ddlRFromFundType.Items.Count > 1)
                    ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
                else
                {
                    if (ddlRFromFundType.Items.Count < 1)
                    {
                        lblRErrorMsg.Text = "No transaction types found for this fund and hence this fund can't be used for disbursement";
                        return;
                    }
                    lblRErrorMsg.Text = "";

                    SetAvailableFundsLabel();

                    //DataTable dtable = FinancialTransactions.GetCommittedFundDetailsByFundId(Convert.ToInt32(hfProjId.Value), 
                    //    Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));

                    //if (dtable.Rows.Count > 0)
                    //{
                    //    lblAvailVisibleFund.Text = CommonHelper.myDollarFormat(Convert.ToDecimal(dtable.Rows[0]["balance"].ToString()));
                    //    lblAvailFund.Text = Convert.ToDecimal(dtable.Rows[0]["balance"].ToString()).ToString();
                    //}

                    //if (rdBtnSelection.SelectedIndex>0)
                    //    BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                }

                if (txtToProjNum.Text != "")
                    //if (ddlRToProj.SelectedValue != ddlRFromProj.SelectedValue)
                    if (txtToProjNum.Text != txtFromProjNum.Text)
                    {
                        ddlRToFund.SelectedValue = ddlRFromFund.SelectedValue;
                        ddlRToFund.Enabled = false;
                    }
                    else
                        ddlRToFund.Enabled = true;
            }
            else
            {
                ddlAccountFrom.SelectedIndex = 0;

                ddlRFromFundType.Items.Clear();
                ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));

                txtRfromAmt.Text = "";
                lblRErrorMsg.Text = "";
                //ClearDetailSelection();

                lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
                lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");
            }
        }

        protected void ddlAccountFrom_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();

            if (ddlAccountFrom.SelectedIndex > 0)
            {
                ddlRFromFund.SelectedValue = ddlAccountFrom.SelectedValue;

                ddlRFromFundType.DataSource = FinancialTransactions.GetAvailableTransTypesPerProjFundId(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlAccountFrom.SelectedValue.ToString()));
                ddlRFromFundType.DataValueField = "typeid";
                ddlRFromFundType.DataTextField = "fundtype";
                ddlRFromFundType.DataBind();

                lblAvailVisibleFund.Text = "";
                lblAvailFund.Text = "";

                if (ddlRFromFundType.Items.Count > 1)
                {
                    ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else
                {
                    if (ddlRFromFundType.Items.Count < 1)
                    {
                        lblRErrorMsg.Text = "No transaction types found for this fund and hence this fund can't be used for disbursement";
                        return;
                    }
                    lblRErrorMsg.Text = "";

                    SetAvailableFundsLabel();
                }
                if (txtToProjNum.Text != "")
                    //if (ddlRToProj.SelectedValue != ddlRFromProj.SelectedValue)
                    if (txtToProjNum.Text != txtFromProjNum.Text)
                    {
                        ddlRToFund.SelectedValue = ddlRFromFund.SelectedValue;
                        ddlRToFund.Enabled = false;
                    }
                    else
                        ddlRToFund.Enabled = true;
            }
            else
            {
                ddlRFromFund.SelectedIndex = 0;

                ddlRFromFundType.Items.Clear();
                ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));

                txtRfromAmt.Text = "";
                lblRErrorMsg.Text = "";
                //ClearDetailSelection();

                lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
                lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");
            }
        }
    }
}