using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using System.Data;

namespace vhcbcloud
{
    public partial class BoardDecommitment : System.Web.UI.Page
    {
        DataTable dtProjects;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
                BindLkStatus();
                BindLkTransType();
            }
            GetSelectedRecord();
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
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        private void BindFundDetails(int projectid)
        {
            try
            {
                DataTable dtFundDet = FinancialTransactions.GetFundDetailsByProjectId(projectid);
                gvBCommit.DataSource = dtFundDet;
                gvBCommit.DataBind();
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

                    DataTable dtProjects = FinancialTransactions.GetBoardCommitmentsByProject(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));

                    lblProjName.Text = dtProjects.Rows[0]["Description"].ToString();
                    //txtGrantee.Text = dtProjects.Rows[0]["Applicantname"].ToString();
                    BindGranteeByProject();
                    DataTable dtTrans = FinancialTransactions.GetBoardCommitmentTrans(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), "Board Decommitment");
                    if (dtTrans.Rows.Count > 0)
                    {
                        gvPTrans.DataSource = dtTrans;
                        gvPTrans.DataBind();
                        txtTransDate.Text = Convert.ToDateTime(dtTrans.Rows[0]["Date"].ToString()).ToShortDateString();
                        txtTotAmt.Text = dtTrans.Rows[0]["TransAmt"].ToString();
                        ddlStatus.SelectedValue = dtTrans.Rows[0]["lkStatus"].ToString();
                        if (dtTrans.Rows.Count == 1)
                        {
                            BindFundDetails(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
                        }
                        else
                        {
                            gvBCommit.DataSource = null;
                            gvBCommit.DataBind();
                        }
                    }
                    else
                    {
                        txtTransDate.Text = DateTime.Now.ToShortDateString();
                        txtTotAmt.Text = "";
                        ddlStatus.SelectedIndex = 1;
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
            BindSelectedProjects();
        }

        protected void gvBCommit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvBCommit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBCommit.EditIndex = -1;
            BindSelectedProjects();
        }

        protected void gvBCommit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvBCommit_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        protected void gvBCommit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBCommit.EditIndex = e.NewEditIndex;
            BindSelectedProjects();
        }

        protected void gvBCommit_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                //FinancialTransactions.AddProjectFundDetails();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvPTrans_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvPTrans_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPTrans.EditIndex = -1;
            BindSelectedProjects();
        }

        protected void gvPTrans_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPTrans.EditIndex = e.NewEditIndex;
            BindSelectedProjects();
        }

        protected void gvPTrans_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int transId = Convert.ToInt32(((HiddenField)gvPTrans.Rows[rowIndex].FindControl("HiddenField1")).Value);
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
                int transType = Convert.ToInt32(((DropDownList)gvPTrans.Rows[rowIndex].FindControl("ddlTransType")).SelectedValue.ToString());
                FinancialTransactions.UpdateBoardCommitmentTransaction(transId, dtTrans, transAmt, "Board Decommitment", transType);
                gvPTrans.EditIndex = -1;
                BindSelectedProjects();
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
                dtTrans = FinancialTransactions.GetBoardCommitmentTrans(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), "Board Decommitment");
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
            Label lblProjectId = new Label();
            lblProjectId.Text = ((Label)gvPTrans.Rows[e.NewSelectedIndex].Cells[4].FindControl("lblProjId")).Text;
            BindFundDetails(Convert.ToInt32(lblProjectId.Text));
        }

        protected void gvPTrans_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetSelectedRecord();
        }

        protected void btnTransSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                FinancialTransactions.AddBoardCommitmentTransaction(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()), Convert.ToDateTime(txtTransDate.Text), Convert.ToDecimal(txtTotAmt.Text),
                    Convert.ToInt32(ddlGrantee.SelectedValue.ToString()), "Board Decommitment", Convert.ToInt32(ddlStatus.SelectedValue.ToString()));
                BindSelectedProjects();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void GetSelectedRecord()
        {
            for (int i = 0; i < gvPTrans.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)gvPTrans.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rb != null)
                {
                    if (rb.Checked)
                    {
                        HiddenField hf = (HiddenField)gvPTrans.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedContact"] = hf.Value;
                        }
                        break;
                    }
                }
            }
        }

        private void SetSelectedRecord()
        {
            for (int i = 0; i < gvPTrans.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)gvPTrans.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rb != null)
                {
                    HiddenField hf = (HiddenField)gvPTrans.Rows[i].Cells[0].FindControl("HiddenField1");
                    if (hf != null && ViewState["SelectedContact"] != null)
                    {
                        if (hf.Value.Equals(ViewState["SelectedContact"].ToString()))
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
                BindSelectedProjects();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}