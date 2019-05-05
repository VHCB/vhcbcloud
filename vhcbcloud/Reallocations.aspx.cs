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
    public partial class Reallocations : System.Web.UI.Page
    {
        /// <summary>
        /// Loading Projects
        /// Check user can access page or not
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// Filter projects by prefix project number text
        /// </summary>
        /// <param name="prefixText"></param>
        /// <param name="count"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Select Reallocation radio checkbox
        /// Redirect to corresponding selected pages
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// Load Projects
        /// </summary>
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

        /// <summary>
        /// Get Pending Projects
        /// </summary>
        /// <param name="prefixText"></param>
        /// <param name="count"></param>
        /// <returns></returns>
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlRFromProj_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRFromProj.SelectedIndex > 0)
            {
                hfReallocateGuid.Value = "";
                hfTransId.Value = ""; hfRFromTransId.Value = ""; hfBalAmt.Value = ""; hfTransAmt.Value = "";

                ddlRFromFund.DataSource = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value));
                //FinancialTransactions.GetCommittedFundByProject(Convert.ToInt32(ddlRFromProj.SelectedValue.ToString()));
                ddlRFromFund.DataValueField = "fundid";
                ddlRFromFund.DataTextField = "name";
                ddlRFromFund.DataBind();
                ddlRFromFund.Items.Insert(0, new ListItem("Select", "NA"));

                ddlAccountFrom.DataValueField = "fundid";
                ddlAccountFrom.DataTextField = "account";
                ddlAccountFrom.DataBind();
                ddlAccountFrom.Items.Insert(0, new ListItem("Select", "NA"));

                //txtRfromDate.Text = DateTime.Now.ToShortDateString();
                ddlRToProj.SelectedIndex = ddlRFromProj.SelectedIndex;
                BindAllFunds();
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

        /// <summary>
        /// Populate Project Name and details based on Project Number
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// Get Project Details
        /// </summary>
        /// <param name="dt"></param>
        private void getDetails(DataTable dt)
        {
            lblAvailFund.Text = "";
            lblAvailVisibleFund.Text = "";
            hfProjId.Value = dt.Rows[0][0].ToString();

            DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(hfProjId.Value));

            lblProjName.Text = dtProjects.Rows.Count > 0 ? dtProjects.Rows[0]["Description"].ToString() : "";

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

            ddlAccountFrom.DataSource = FinancialTransactions.GetCommittedFundNames(Convert.ToInt32(hfProjId.Value));
            ddlAccountFrom.DataValueField = "fundid";
            ddlAccountFrom.DataTextField = "account";
            ddlAccountFrom.DataBind();
            ddlAccountFrom.Items.Insert(0, new ListItem("Select", "NA"));

            //txtRfromDate.Text = DateTime.Now.ToShortDateString();
            //ddlRToProj.SelectedIndex = ddlRFromProj.SelectedIndex;
            txtToProjNum.Text = txtFromProjNum.Text;
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

        /// <summary>
        /// Get Project To details
        /// </summary>
        /// <param name="dt"></param>
        private void getToDetails(DataTable dt)
        {
            hfToProjId.Value = dt.Rows[0][0].ToString();
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

            //ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
            DataTable dtable = new DataTable();
            dtable = FinancialTransactions.GetAllFundsByProjectProgram(DataUtils.GetInt(hfProjId.Value));

            ddlRToFund.DataSource = dtable;
            ddlRToFund.DataValueField = "fundid";
            ddlRToFund.DataTextField = "name";
            ddlRToFund.DataBind();
            ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));

            ddlAcctNum.DataSource = dtable;
            ddlAcctNum.DataValueField = "fundid";
            ddlAcctNum.DataTextField = "account";
            ddlAcctNum.DataBind();
            ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));

            if (txtToProjNum.Text != txtFromProjNum.Text)
            {
                ddlRToFund.SelectedValue = ddlRFromFund.SelectedValue;
                ddlRToFund.Enabled = false;
                //if (ddlRToFund.SelectedItem.Text.ToLower().Contains("hopwa"))
                //{
                //    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                //}
                //else
                //{
                //    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                //}
                ////ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                //ddlRtoFundType.DataValueField = "typeid";
                //ddlRtoFundType.DataTextField = "Description";
                //ddlRtoFundType.DataBind();
                //ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            else
                ddlRToFund.Enabled = true;
        }

        /// <summary>
        /// Project To selection changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

                //ddlRToFund.DataSource = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetAllFundsByProjectProgram(DataUtils.GetInt(hfProjId.Value));
                ddlRToFund.DataSource = dtable;
                ddlRToFund.DataValueField = "fundid";
                ddlRToFund.DataTextField = "name";
                ddlRToFund.DataBind();
                ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));

                ddlAcctNum.DataSource = dtable;
                ddlAcctNum.DataValueField = "fundid";
                ddlAcctNum.DataTextField = "account";
                ddlAcctNum.DataBind();
                ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));

                if (ddlRToProj.SelectedIndex != ddlRFromProj.SelectedIndex)
                {
                    ddlRToFund.SelectedValue = ddlRFromFund.SelectedValue;
                    ddlRToFund.Enabled = false;
                    //if (ddlRToFund.SelectedItem.Text.ToLower().Contains("hopwa"))
                    //{
                    //    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                    //}
                    //else
                    //{
                    //    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                    //}
                    ////ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                    //ddlRtoFundType.DataValueField = "typeid";
                    //ddlRtoFundType.DataTextField = "Description";
                    //ddlRtoFundType.DataBind();
                    //ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else
                    ddlRToFund.Enabled = true;
            }
        }

        /// <summary>
        /// Bind Fund Details
        /// </summary>
        protected void BindAllFunds()
        {
            try
            {
                DataTable dtable = new DataTable();
                //dtable = FinancialTransactions.GetDataTableByProcName("GetAllFunds");
                dtable = FinancialTransactions.GetAllFundsByProjectProgram(DataUtils.GetInt(hfProjId.Value));
                ddlRToFund.DataSource = dtable;
                ddlRToFund.DataValueField = "fundid";
                ddlRToFund.DataTextField = "name";
                ddlRToFund.DataBind();
                ddlRToFund.Items.Insert(0, new ListItem("Select", "NA"));

                ddlAcctNum.DataSource = dtable;
                ddlAcctNum.DataValueField = "fundid";
                ddlAcctNum.DataTextField = "account";
                ddlAcctNum.DataBind();
                ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        //protected void BindToUsePermit(int projId)
        //{
        //    try
        //    {
        //        DataTable dtable = new DataTable();
        //        //dtable = FinancialTransactions.GetLandUsePermit(projId);
        //        dtable = FinancialTransactions.GetAllLandUsePermit(projId);
        //        ddlToUsePermit.DataSource = dtable;
        //        ddlToUsePermit.DataValueField = "Act250FarmId";
        //        ddlToUsePermit.DataTextField = "UsePermit";
        //        ddlToUsePermit.DataBind();

        //        if (ddlToUsePermit.Items.Count > 1)
        //            ddlToUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
        //        else
        //        {
        //            SetAvailableFundsLabel();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        lblRErrorMsg.Text = ex.Message;
        //    }
        //}

        /// <summary>
        /// Populate usePermit dropdown
        /// </summary>
        /// <param name="projId"></param>
        protected void BindToUsePermit(int projId)
        {
            try
            {

                DataTable dtable = new DataTable();
                //dtable = FinancialTransactions.GetLandUsePermit(projId);
                dtable = FinancialTransactions.GetAllLandUsePermit(projId);

                foreach (DataRow dr in dtable.Rows)
                {
                    if (ddlUsePermit.SelectedItem != null &&
                        dr["UsePermit"].ToString() == ddlUsePermit.SelectedItem.ToString())
                        dr.Delete();
                }
                dtable.AcceptChanges();

                ddlToUsePermit.DataSource = dtable;
                ddlToUsePermit.DataValueField = "Act250FarmId";
                ddlToUsePermit.DataTextField = "UsePermit";
                ddlToUsePermit.DataBind();

                if (ddlToUsePermit.Items.Count > 1)
                    ddlToUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Populate UsePermit
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <param name="AccountId"></param>
        /// <param name="FundTransType"></param>
        protected void PopulateUsePermit(int ProjectId, string AccountId, int FundTransType)
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetLandUsePermit(ProjectId, AccountId, FundTransType);
                ddlUsePermit.DataSource = dtable;
                ddlUsePermit.DataValueField = "Act250FarmId";
                ddlUsePermit.DataTextField = "UsePermit";
                ddlUsePermit.DataBind();

                if (ddlUsePermit.Items.Count > 1)
                    ddlUsePermit.Items.Insert(0, new ListItem("Select", "NA"));
                else
                {
                    SetAvailableFundsLabel();
                }
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }

        }

        /// <summary>
        /// Set Available Funds amount Label
        /// </summary>
        private void SetAvailableFundsLabel()
        {
            DataTable dtAvailFunds = FinancialTransactions.GetAvailableFundAmount(Convert.ToInt32(hfProjId.Value),
                                DataUtils.GetInt(ddlRFromFund.SelectedValue.ToString()),
                                DataUtils.GetInt(ddlRFromFundType.SelectedValue.ToString()),
                                ddlUsePermit.SelectedValue.ToString());

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

        /// <summary>
        /// From Fund Type changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlRFromFundType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
            lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");

            if (ddlRFromFundType.Items.Count > 1)
            {
                if (ddlRFromFundType.SelectedIndex != 0)
                {
                    txtRtoFundType.Text = ddlRFromFundType.SelectedItem.ToString();

                    DataTable dtable = FinancialTransactions.GetFundDetailsByFundId(DataUtils.GetInt(ddlRFromFund.SelectedValue.ToString()));

                    if (dtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        lblUsePermit.Visible = true;
                        ddlUsePermit.Visible = true;
                        string account = FinancialTransactions.GetAccountNumberByFundId(DataUtils.GetInt(ddlRFromFund.SelectedValue.ToString()));
                        PopulateUsePermit(DataUtils.GetInt(hfProjId.Value), account,
                            DataUtils.GetInt(ddlRFromFundType.SelectedValue.ToString()));
                    }
                    else
                    {
                        ddlUsePermit.Items.Clear();
                        lblUsePermit.Visible = false;
                        ddlUsePermit.Visible = false;

                        if (ddlRFromFundType.SelectedIndex > 0)
                        {
                            SetAvailableFundsLabel();
                        }
                    }

                    if (rdBtnSelection.SelectedIndex > 0)
                        BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()), Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()));
                }
                else
                {
                    txtRtoFundType.Text = "";
                    ddlUsePermit.Items.Clear();
                    lblUsePermit.Visible = false;
                    ddlUsePermit.Visible = false;
                    lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
                    lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");
                }
            }
        }

        /// <summary>
        /// Fund Type To changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
                    //if (ddlRToFund.SelectedItem.Text.ToLower().Contains("hopwa"))
                    //{
                    //    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransHopwa");
                    //}
                    //else
                    //{
                    //    ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                    //}
                    ////ddlRtoFundType.DataSource = FinancialTransactions.GetDataTableByProcName("GetLKTransNonHopwa");
                    //ddlRtoFundType.DataValueField = "typeid";
                    //ddlRtoFundType.DataTextField = "Description";
                    //ddlRtoFundType.DataBind();
                    //ddlRtoFundType.Items.Insert(0, new ListItem("Select", "NA"));

                    DataTable dtFundDet = new DataTable();
                    dtFundDet = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlRToFund.SelectedValue.ToString()));

                    ddlAcctNum.SelectedValue = ddlRToFund.SelectedValue;
                   
                    if (dtFundDet.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        lblToUsePermit.Visible = true;
                        ddlToUsePermit.Visible = true;
                        BindToUsePermit((DataUtils.GetInt(hfProjId.Value)));
                    }
                    else
                    {
                        lblToUsePermit.Visible = false;
                        ddlToUsePermit.Visible = false;
                    }
                }
            }
        }

        /// <summary>
        /// Clear Reallocation form
        /// </summary>
        private void ClearReallocationToPanel()
        {
            txtToProjNum.Text = txtFromProjNum.Text;
            txtRToAmt.Text = "";
            //ddlRToProj.SelectedIndex = 0;
            ddlRToFund.SelectedIndex = -1;
            ddlRToFund.DataSource = null;
            ddlRToFund.DataBind();
            lblToUsePermit.Visible = false;
            ddlToUsePermit.Visible = false;
            ddlToUsePermit.Items.Clear();

        }

        /// <summary>
        /// Clear Reallocation form Panel
        /// </summary>
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

        /// <summary>
        /// Disable Reallocation From Panel
        /// </summary>
        private void DisableReallocationFromPanel()
        {
            txtFromProjNum.Enabled = false;
            ddlRFromFund.Enabled = false;
            ddlRFromFundType.Enabled = false;
            txtRfromDate.Enabled = false;
            txtRfromAmt.Enabled = false;
        }

        /// <summary>
        /// Enable Reallocation From Panel
        /// </summary>
        private void EnableReallocationFromPanel()
        {
            txtFromProjNum.Enabled = true;
            ddlRFromFund.Enabled = true;
            ddlRFromFundType.Enabled = true;
            txtRfromDate.Enabled = true;
            txtRfromAmt.Enabled = true;
        }
        
        /// <summary>
        /// Bind Reallocate Grid
        /// </summary>
        /// <param name="fromProjId"></param>
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="fromProjId"></param>
        /// <param name="reallocateGuid"></param>
        private void BindGvReallocate(int fromProjId, string reallocateGuid)
        {
            try
            {
                DataTable dtFundDet = new DataTable();

                dtFundDet = FinancialTransactions.GetReallocationDetailsByGuid(fromProjId, reallocateGuid);

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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="fromProjId"></param>
        /// <param name="fundId"></param>
        private void BindGvReallocate(int fromProjId, int fundId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                // dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    dtFundDet = FinancialTransactions.GetReallocationDetailsNewProjFund(fromProjId, fundId);
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="fromProjId"></param>
        /// <param name="fundId"></param>
        /// <param name="transTypeId"></param>
        private void BindGvReallocate(int fromProjId, int fundId, int transTypeId)
        {
            try
            {
                DataTable dtFundDet = new DataTable();
                // dtFundDet = FinancialTransactions.GetReallocationDetailsTransId(fromProjId);

                if (rdBtnSelection.SelectedIndex > 0)
                {
                    dtFundDet = FinancialTransactions.GetReallocationDetailsNewProjFundTransType(fromProjId, fundId, transTypeId);
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

        /// <summary>
        /// Award Summary link
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
                Response.Redirect("existingreallocations.aspx");
                btnReallocateSubmit.Visible = false;
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Submit Reallocate details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
                    lblRErrorMsg.Text = "Select reallocate from project";
                    txtFromProjNum.Focus();
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

                //if (ddlRToProj.Items.Count > 1 && ddlRToProj.SelectedIndex == 0)
                //{
                //    lblRErrorMsg.Text = "Select reallocate to project";
                //    ddlRToProj.Focus();
                //    return;
                //}
                if (ddlRToFund.Items.Count > 1 && ddlRToFund.SelectedIndex == 0)
                {
                    lblRErrorMsg.Text = "Select fund from reallocate to project";
                    ddlRToFund.Focus();
                    return;
                }
                //if (ddlRtoFundType.Items.Count > 1 && ddlRtoFundType.SelectedIndex == 0)
                //{
                //    lblRErrorMsg.Text = "Select fund type from reallocate to project";
                //    ddlRtoFundType.Focus();
                //    return;
                //}
                if (Convert.ToDecimal(txtRfromAmt.Text) < Convert.ToDecimal(txtRToAmt.Text))
                {
                    lblRErrorMsg.Text = "Reallocate to amount can't be more than available reallocation from amount";
                    txtRToAmt.Focus();
                    return;
                }
                //if (ddlRFromProj.SelectedValue == ddlRToProj.SelectedValue)
                if (txtFromProjNum.Text == txtToProjNum.Text)
                    if (ddlRFromFund.SelectedValue.ToString() == ddlRToFund.SelectedValue.ToString())
                    {
                        //if (ddlRtoFundType.SelectedValue.ToString() == ddlRFromFundType.SelectedValue.ToString())
                        //{
                        //    lblRErrorMsg.Text = "Fund cannot be reallocated to same fund type. Reallocate to different fund type.";
                        //    ddlRtoFundType.Focus();
                        //    return;
                        //}
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
                        lblRErrorMsg.Text = "Amount can't be more than available reallocate funds (" + CommonHelper.myDollarFormat(0) + ") for the selected from project";
                    else
                        lblRErrorMsg.Text = "Amount can't be more than available reallocate from funds (" + CommonHelper.myDollarFormat(lblAvailFund.Text) + ") for the selected from project";

                    txtRfromAmt.Focus();
                    return;
                }
                DataTable dFromtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                if (dFromtable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                {
                    if (ddlUsePermit.Items.Count > 1 && ddlUsePermit.SelectedIndex == 0)
                    {
                        lblRErrorMsg.Text = "Select reallocate from Use Permit";
                        ddlUsePermit.Focus();
                        return;
                    }
                }
                DataTable dTotable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlRToFund.SelectedValue.ToString()));
                if (dTotable.Rows[0]["mitfund"].ToString().ToLower() == "true")
                {
                    if (ddlToUsePermit.Items.Count > 1 && ddlToUsePermit.SelectedIndex == 0)
                    {
                        lblRErrorMsg.Text = "Select reallocate to Use Permit";
                        ddlToUsePermit.Focus();
                        return;
                    }
                }

                if (txtRfromDate.Text == "")
                {
                    lblRErrorMsg.Text = "Please enter transaction date";
                    txtRfromDate.Focus();
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
                dtable = FinancialTransactions.AddBoardReallocationTransaction(Convert.ToInt32(hfProjId.Value.ToString()),
                                                                      txtFromProjNum.Text == txtToProjNum.Text ? Convert.ToInt32(hfProjId.Value.ToString()) : Convert.ToInt32(hfToProjId.Value.ToString()),
                                                                      Convert.ToDateTime(txtRfromDate.Text),
                                                                      Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()),
                                                                      Convert.ToDecimal(txtRfromAmt.Text),
                                                                      Convert.ToInt32(ddlRToFund.SelectedValue.ToString()),
                                                                      Convert.ToInt32(ddlRFromFundType.SelectedValue.ToString()),
                                                                      Convert.ToDecimal(txtRToAmt.Text),
                                                                      hfRFromTransId.Value == "" ? nullable : Convert.ToInt32(hfRFromTransId.Value),
                                                                      hfTransId.Value == "" ? nullable : Convert.ToInt32(hfTransId.Value),
                                                                      DataUtils.GetInt(ddlUsePermit.SelectedValue.ToString()),
                                                                      DataUtils.GetInt(ddlToUsePermit.SelectedValue.ToString()),
                                                                      hfReallocateGuid.Value.ToString(), GetUserId());

                hfRFromTransId.Value = dtable.Rows[0][0].ToString();
                hfTransId.Value = dtable.Rows[0][1].ToString();

                lblRErrorMsg.Text = "Reallocation was added successfully";
                BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()));
                ClearReallocationToPanel();
            }
            catch (Exception ex)
            {
                lblRErrorMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// Redirecting Page to New Reallocation Page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnNewTransaction_Click(object sender, EventArgs e)
        {
            Response.Redirect("reallocations.aspx");
        }

        /// <summary>
        /// Reallocate Row Editing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// Reallocating Cancel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvReallocate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReallocate.EditIndex = -1;
            Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()), lblGuid.Text);
            BindGvReallocate(Convert.ToInt32(hfProjId.Value.ToString()));
        }

        /// <summary>
        /// Reallocate Row Deleting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvReallocate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            Label lblGuid = (Label)gvReallocate.Rows[e.RowIndex].FindControl("lblProjGuid");

            FinancialTransactions.DeleteReallocationsByGUID(lblGuid.Text);
            BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
            btnReallocateSubmit.Visible = true;
        }

        protected void gvReallocate_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        /// <summary>
        /// Get User Id
        /// </summary>
        /// <returns></returns>
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

        /// <summary>
        /// UserPermit Selection changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlUsePermit_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlRFromFundType.SelectedIndex > 0)
            //{
            SetAvailableFundsLabel();
            //}
            ddlRToFund.SelectedIndex = -1;
            ddlToUsePermit.Items.Clear();
            lblToUsePermit.Visible = false;
            ddlToUsePermit.Visible = false;
        }

        /// <summary>
        /// Check login user has access to this page
        /// </summary>
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
            if (rdBtnFinancial.Items[2].Enabled)
                rdBtnFinancial.Items[2].Selected = true;
            else if (rdBtnFinancial.Items[3].Enabled)
                Response.Redirect("Assignments.aspx");
        }

        /// <summary>
        /// When Account number changed select Fund Name
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtable = new DataTable();

            if (ddlAcctNum.SelectedIndex != 0)
            {
                dtable = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlAcctNum.SelectedValue.ToString()));
                
                ddlRToFund.SelectedValue = ddlAcctNum.SelectedValue;

                if (DataUtils.GetBool(dtable.Rows[0]["mitfund"].ToString()))
                {
                    lblToUsePermit.Visible = true;
                    ddlToUsePermit.Visible = true;
                    BindToUsePermit((DataUtils.GetInt(hfProjId.Value)));
                }
                else
                {
                    lblToUsePermit.Visible = false;
                    ddlToUsePermit.Visible = false;
                }
            }
        }

        /// <summary>
        /// When From Fund Type changed update fund details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
                {
                    txtRtoFundType.Text = "";
                    ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else if (ddlRFromFundType.Items.Count == 1)
                {
                    txtRtoFundType.Text = ddlRFromFundType.SelectedItem.ToString();

                    DataTable dtFundDet = new DataTable();
                    dtFundDet = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));

                    if (dtFundDet.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        lblUsePermit.Visible = true;
                        ddlUsePermit.Visible = true;
                        string account = FinancialTransactions.GetAccountNumberByFundId(DataUtils.GetInt(ddlRFromFund.SelectedValue.ToString()));
                        PopulateUsePermit(DataUtils.GetInt(hfProjId.Value), account,
                            DataUtils.GetInt(ddlRFromFundType.SelectedValue.ToString()));
                    }
                    else
                    {
                        ddlUsePermit.Items.Clear();
                        lblUsePermit.Visible = false;
                        ddlUsePermit.Visible = false;
                        SetAvailableFundsLabel();
                    }

                    if (rdBtnSelection.SelectedIndex > 0)
                        BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                }

                //BindUsePermit(hfProjId.Value != "" ? Convert.ToInt32(hfProjId.Value) : 0);
                //BindToUsePermit(hfProjId.Value != "" ? Convert.ToInt32(hfProjId.Value) : 0);

                if (txtToProjNum.Text != "")
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
                //txtRtoFundType.Text = "";
                ddlRFromFundType.Items.Clear();

                txtRtoFundType.Text = "";

                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;

                ddlToUsePermit.Items.Clear();
                lblToUsePermit.Visible = false;
                ddlToUsePermit.Visible = false;

                lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
                lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");
            }
        }

        /// <summary>
        /// When From account changed update fund details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
                    txtRtoFundType.Text = "";
                    ddlRFromFundType.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else if (ddlRFromFundType.Items.Count == 1)
                {
                    txtRtoFundType.Text = ddlRFromFundType.SelectedItem.ToString();
                    DataTable dtFundDet = new DataTable();

                    dtFundDet = FinancialTransactions.GetFundDetailsByFundId(Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));

                    if (dtFundDet.Rows[0]["mitfund"].ToString().ToLower() == "true")
                    {
                        lblUsePermit.Visible = true;
                        ddlUsePermit.Visible = true;
                        string account = FinancialTransactions.GetAccountNumberByFundId(DataUtils.GetInt(ddlRFromFund.SelectedValue.ToString()));
                        PopulateUsePermit(DataUtils.GetInt(hfProjId.Value), account,
                            DataUtils.GetInt(ddlRFromFundType.SelectedValue.ToString()));
                    }
                    else
                    {
                        ddlUsePermit.Items.Clear();
                        lblUsePermit.Visible = false;
                        ddlUsePermit.Visible = false;
                        SetAvailableFundsLabel();
                    }
                    if (rdBtnSelection.SelectedIndex > 0)
                        BindGvReallocate(Convert.ToInt32(hfProjId.Value), Convert.ToInt32(ddlRFromFund.SelectedValue.ToString()));
                }

                if (txtToProjNum.Text != "")
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
                //txtRtoFundType.Text = "";
                ddlRFromFundType.Items.Clear();

                txtRtoFundType.Text = "";

                ddlUsePermit.Items.Clear();
                lblUsePermit.Visible = false;
                ddlUsePermit.Visible = false;

                ddlToUsePermit.Items.Clear();
                lblToUsePermit.Visible = false;
                ddlToUsePermit.Visible = false;

                lblAvailVisibleFund.Text = CommonHelper.myDollarFormat("0.00");
                lblAvailFund.Text = CommonHelper.myDollarFormat("0.00");
            }
        }
    }
}