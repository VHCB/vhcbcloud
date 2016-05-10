using DataAccessLayer;
using VHCBCommon.DataAccessLayer.Conservation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud.Conservation
{
    public partial class ConservationStewardship : System.Web.UI.Page
    {
        string Pagename = "ConservationStewardship";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            if (Request.QueryString["ProjectId"] != null)
                hfProjectId.Value = Request.QueryString["ProjectId"];

            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();

                BindControls();
                BindGrids();
            }
        }

        private void GenerateTabs()
        {
            string ProgramId = null;

            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

            //Active Tab
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + hfProjectId.Value);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabs(DataUtils.GetInt(ProgramId));

            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString().Contains("ConservationStewardship.aspx"))
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                else
                    li1.Attributes.Add("class", "RoundedCornerTop");

                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", "../" + dr["URL"].ToString() + "?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                anchor1.InnerText = dr["TabName"].ToString();
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                li1.Controls.Add(anchor1);
            }
        }

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void LogError(string pagename, string method, string message, string error)
        {
            dvMessage.Visible = true;
            if (message == "")
            {
                lblErrorMsg.Text = Pagename + ": " + method + ": Error Message: " + error;
            }
            else
                lblErrorMsg.Text = Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error;
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        private void BindControls()
        {
            BindLookUP(ddlMjrAmendment, 43);
            BindLookUP(ddlMjrDisposition, 68);

            BindLookUP(ddlMinorAmendment, 44);
            BindLookUP(ddlMinorDisposition, 68);

            BindLookUP(ddlViolations, 48);
            BindLookUP(ddlViolationDisposition, 68);

            BindLookUP(ddlApproval, 42);
            BindLookUP(ddlApprovalDisposition, 68);

            BindLookUP(ddlPlan, 142);
            BindLookUP(ddlEvent, 146);
        }

        private void BindGrids()
        {
            BindMajorGrid();
            BindMinorGrid();
            BindViolationsGrid();
            BindApprovalsGrid();
            BindPlansGrid();
            BindEventGrid();
        }

        private void BindLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected void btnAddMajor_Click(object sender, EventArgs e)
        {
            if (ddlMjrAmendment.SelectedIndex == 0)
            {
                LogMessage("Select Amendment");
                ddlMjrAmendment.Focus();
                return;
            }

            if (txtMjrReqDate.Text.Trim() == "")
            {
                LogMessage("Enter Request Date");
                txtMjrReqDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtMjrReqDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Request Date");
                    txtMjrReqDate.Focus();
                    return;
                }
            }

            if (ddlMjrDisposition.SelectedIndex == 0)
            {
                LogMessage("Select Disposition");
                ddlMjrDisposition.Focus();
                return;
            }

            if (txtMjrDispositionDate.Text.Trim() == "")
            {
                LogMessage("Enter Disposition Date");
                txtMjrDispositionDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtMjrDispositionDate.Text.Trim()))
                {
                    LogMessage("Enter Disposition Date");
                    txtMjrDispositionDate.Focus();
                    return;
                }
            }

            ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConservationMajorAmend(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlMjrAmendment.SelectedValue.ToString()),
                DataUtils.GetDate(txtMjrReqDate.Text), DataUtils.GetInt(ddlMjrDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtMjrDispositionDate.Text));

            ClearMajorAmendmentForm();

            BindMajorGrid();

            if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                LogMessage("New Major Amendment already exist as in-active");
            else if (objAddConsAmend.IsDuplicate)
                LogMessage("New Major Amendment already exist");
            else
                LogMessage("New Major Amendment added successfully");
        }

        private void BindMajorGrid()
        {
            try
            {
                DataTable dtMajor = ConservationStewardshipData.GetMajorAmendmentsList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtMajor.Rows.Count > 0)
                {
                    dvMajorGrid.Visible = true;
                    gvMajor.DataSource = dtMajor;
                    gvMajor.DataBind();
                }
                else
                {
                    dvMajorGrid.Visible = false;
                    gvMajor.DataSource = null;
                    gvMajor.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMajorGrid", "", ex.Message);
            }
        }

        private void ClearMajorAmendmentForm()
        {
            ddlMjrAmendment.SelectedIndex = -1;
            txtMjrReqDate.Text = "";
            ddlMjrDisposition.SelectedIndex = -1;
            txtMjrDispositionDate.Text = "";
            cbAddMajor.Checked = false;
        }

        protected void gvMajor_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMajor.EditIndex = e.NewEditIndex;
            BindMajorGrid();
        }

        protected void gvMajor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMajor.EditIndex = -1;
            BindMajorGrid();
        }

        protected void gvMajor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveMajAmendID = DataUtils.GetInt(((Label)gvMajor.Rows[rowIndex].FindControl("lblConserveMajAmendID")).Text);
            DateTime ReqDate = Convert.ToDateTime(((TextBox)gvMajor.Rows[rowIndex].FindControl("txtReqDate")).Text);
            int LkDisp = DataUtils.GetInt(((DropDownList)gvMajor.Rows[rowIndex].FindControl("ddlMjrDispositionE")).SelectedValue.ToString());
            DateTime DispDate = Convert.ToDateTime(((TextBox)gvMajor.Rows[rowIndex].FindControl("txtDispDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMajor.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationStewardshipData.UpdateConservationMajorAmend(ConserveMajAmendID, ReqDate, LkDisp, DispDate, RowIsActive);
            gvMajor.EditIndex = -1;

            BindMajorGrid();
           
            LogMessage("Major Amendment updated successfully");
        }

        protected void gvMajor_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlMjrDispositionE = (e.Row.FindControl("ddlMjrDispositionE") as DropDownList);
                    TextBox txtLkConsMajAmend = (e.Row.FindControl("txtLkConsMajAmend") as TextBox);

                    if (txtLkConsMajAmend != null)
                    {
                        BindLookUP(ddlMjrDispositionE, 68);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlMjrDispositionE.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkConsMajAmend.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlMjrDispositionE.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }

        protected void btnAddMinor_Click(object sender, EventArgs e)
        {
            if (ddlMinorAmendment.SelectedIndex == 0)
            {
                LogMessage("Select Amendment");
                ddlMinorAmendment.Focus();
                return;
            }

            if (txtMinorReqDate.Text.Trim() == "")
            {
                LogMessage("Enter Request Date");
                txtMinorReqDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtMinorReqDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Request Date");
                    txtMinorReqDate.Focus();
                    return;
                }
            }

            if (ddlMinorDisposition.SelectedIndex == 0)
            {
                LogMessage("Select Disposition");
                ddlMinorDisposition.Focus();
                return;
            }

            if (txtMinorDispositionDate.Text.Trim() == "")
            {
                LogMessage("Enter Disposition Date");
                txtMinorDispositionDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtMinorDispositionDate.Text.Trim()))
                {
                    LogMessage("Enter Disposition Date");
                    txtMinorDispositionDate.Focus();
                    return;
                }
            }

            ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConservationMinorAmend(DataUtils.GetInt(hfProjectId.Value), 
                DataUtils.GetInt(ddlMinorAmendment.SelectedValue.ToString()), DataUtils.GetDate(txtMinorReqDate.Text), 
                DataUtils.GetInt(ddlMinorDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtMinorDispositionDate.Text));

            ClearMinorAmendmentForm();

            BindMinorGrid();

            if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                LogMessage("New Minor Amendment already exist as in-active");
            else if (objAddConsAmend.IsDuplicate)
                LogMessage("New Minor Amendment already exist");
            else
                LogMessage("New Minor Amendment added successfully");
        }

        protected void gvMinor_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMinor.EditIndex = e.NewEditIndex;
            BindMinorGrid();
        }

        protected void gvMinor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMinor.EditIndex = -1;
            BindMinorGrid();
        }

        protected void gvMinor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveMinAmendID = DataUtils.GetInt(((Label)gvMinor.Rows[rowIndex].FindControl("lblConserveMinAmendID")).Text);
            DateTime ReqDate = Convert.ToDateTime(((TextBox)gvMinor.Rows[rowIndex].FindControl("txtMinorReqDate")).Text);
            int LkDisp = DataUtils.GetInt(((DropDownList)gvMinor.Rows[rowIndex].FindControl("ddlMinorDispositionE")).SelectedValue.ToString());
            DateTime DispDate = Convert.ToDateTime(((TextBox)gvMinor.Rows[rowIndex].FindControl("txtMinorDispDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMinor.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationStewardshipData.UpdateConservationMinorAmend(ConserveMinAmendID, ReqDate, LkDisp, DispDate, RowIsActive);
            gvMinor.EditIndex = -1;

            BindMinorGrid();

            LogMessage("Minor Amendment updated successfully");
        }

        protected void gvMinor_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlMinorDispositionE = (e.Row.FindControl("ddlMinorDispositionE") as DropDownList);
                    TextBox txtLkConsMinorAmend = (e.Row.FindControl("txtLkConsMinorAmend") as TextBox);

                    if (txtLkConsMinorAmend != null)
                    {
                        BindLookUP(ddlMinorDispositionE, 68);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlMinorDispositionE.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkConsMinorAmend.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlMinorDispositionE.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }

        private void BindMinorGrid()
        {
            try
            {
                DataTable dtMinor = ConservationStewardshipData.GetMinorAmendmentsList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtMinor.Rows.Count > 0)
                {
                    dvMinorGrid.Visible = true;
                    gvMinor.DataSource = dtMinor;
                    gvMinor.DataBind();
                }
                else
                {
                    dvMinorGrid.Visible = false;
                    gvMinor.DataSource = null;
                    gvMinor.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMajorGrid", "", ex.Message);
            }
        }

        private void ClearMinorAmendmentForm()
        {
            ddlMinorAmendment.SelectedIndex = -1;
            txtMinorReqDate.Text = "";
            ddlMinorDisposition.SelectedIndex = -1;
            txtMinorDispositionDate.Text = "";
            cbAddMinor.Checked = false;
        }

        private void BindViolationsGrid()
        {
            try
            {
                DataTable dtViolation = ConservationStewardshipData.GetConserveViolationsList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtViolation.Rows.Count > 0)
                {
                    dvViolationGrid.Visible = true;
                    gvViolation.DataSource = dtViolation;
                    gvViolation.DataBind();
                }
                else
                {
                    dvViolationGrid.Visible = false;
                    gvViolation.DataSource = null;
                    gvViolation.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMajorGrid", "", ex.Message);
            }
        }

        private void ClearViolationForm()
        {
            ddlMinorAmendment.SelectedIndex = -1;
            txtViolationReqDate.Text = "";
            ddlViolationDisposition.SelectedIndex = -1;
            txtViolationDispDate.Text = "";
            cbAddViolation.Checked = false;
        }

        protected void btnAddViolation_Click(object sender, EventArgs e)
        {
            if (ddlViolations.SelectedIndex == 0)
            {
                LogMessage("Select Violation");
                ddlViolations.Focus();
                return;
            }

            if (txtViolationReqDate.Text.Trim() == "")
            {
                LogMessage("Enter Request Date");
                txtViolationReqDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtViolationReqDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Request Date");
                    txtViolationReqDate.Focus();
                    return;
                }
            }

            if (ddlViolationDisposition.SelectedIndex == 0)
            {
                LogMessage("Select Disposition");
                ddlViolationDisposition.Focus();
                return;
            }

            if (txtViolationDispDate.Text.Trim() == "")
            {
                LogMessage("Enter Disposition Date");
                txtViolationDispDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtViolationDispDate.Text.Trim()))
                {
                    LogMessage("Enter Disposition Date");
                    txtViolationDispDate.Focus();
                    return;
                }
            }

            ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConserveViolations(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlViolations.SelectedValue.ToString()), DataUtils.GetDate(txtViolationReqDate.Text),
                DataUtils.GetInt(ddlViolationDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtViolationDispDate.Text));

            ClearViolationForm();

            BindViolationsGrid();

            if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                LogMessage("New Violation already exist as in-active");
            else if (objAddConsAmend.IsDuplicate)
                LogMessage("New Violation already exist");
            else
                LogMessage("New Violation added successfully");
        }

        protected void gvViolation_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvViolation.EditIndex = e.NewEditIndex;
            BindViolationsGrid();
        }

        protected void gvViolation_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvViolation.EditIndex = -1;
            BindViolationsGrid();
        }

        protected void gvViolation_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveViolationsID = DataUtils.GetInt(((Label)gvViolation.Rows[rowIndex].FindControl("lblConserveViolationsID")).Text);
            DateTime ReqDate = Convert.ToDateTime(((TextBox)gvViolation.Rows[rowIndex].FindControl("txtViolationsReqDate")).Text);
            int LkDisp = DataUtils.GetInt(((DropDownList)gvViolation.Rows[rowIndex].FindControl("ddlViolationsDispositionE")).SelectedValue.ToString());
            DateTime DispDate = Convert.ToDateTime(((TextBox)gvViolation.Rows[rowIndex].FindControl("txtViolationsDispDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvViolation.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationStewardshipData.UpdateConserveViolations(ConserveViolationsID, ReqDate, LkDisp, DispDate, RowIsActive);
            gvViolation.EditIndex = -1;

            BindViolationsGrid();

            LogMessage("Violation updated successfully");
        }

        protected void gvViolation_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlViolationsDispositionE = (e.Row.FindControl("ddlViolationsDispositionE") as DropDownList);
                    TextBox txtLkConsViol = (e.Row.FindControl("txtLkConsViol") as TextBox);

                    if (txtLkConsViol != null)
                    {
                        BindLookUP(ddlViolationsDispositionE, 68);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlViolationsDispositionE.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkConsViol.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlViolationsDispositionE.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }

        protected void btnAddApproval_Click(object sender, EventArgs e)
        {
            if (ddlApproval.SelectedIndex == 0)
            {
                LogMessage("Select Approval");
                ddlApproval.Focus();
                return;
            }

            if (txtApprovalReqdate.Text.Trim() == "")
            {
                LogMessage("Enter Request Date");
                txtApprovalReqdate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtApprovalReqdate.Text.Trim()))
                {
                    LogMessage("Enter Valid Request Date");
                    txtApprovalReqdate.Focus();
                    return;
                }
            }

            if (ddlApprovalDisposition.SelectedIndex == 0)
            {
                LogMessage("Select Disposition");
                ddlApprovalDisposition.Focus();
                return;
            }

            if (txtApprovalDispositionDate.Text.Trim() == "")
            {
                LogMessage("Enter Disposition Date");
                txtApprovalDispositionDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtApprovalDispositionDate.Text.Trim()))
                {
                    LogMessage("Enter Disposition Date");
                    txtApprovalDispositionDate.Focus();
                    return;
                }
            }

            ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConserveApprovals(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlApproval.SelectedValue.ToString()), DataUtils.GetDate(txtApprovalReqdate.Text),
                DataUtils.GetInt(ddlApprovalDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtApprovalDispositionDate.Text));

            ClearApprovalForm();

            BindApprovalsGrid();

            if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                LogMessage("New Approval already exist as in-active");
            else if (objAddConsAmend.IsDuplicate)
                LogMessage("New Approval already exist");
            else
                LogMessage("New Approval added successfully");
        }

        protected void gvApproval_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvApproval.EditIndex = e.NewEditIndex;
            BindApprovalsGrid();
        }

        protected void gvApproval_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvApproval.EditIndex = -1;
            BindApprovalsGrid();
        }

        protected void gvApproval_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveApprovalID = DataUtils.GetInt(((Label)gvApproval.Rows[rowIndex].FindControl("lblConserveApprovalID")).Text);
            DateTime ReqDate = Convert.ToDateTime(((TextBox)gvApproval.Rows[rowIndex].FindControl("txtApprovalsReqDate")).Text);
            int LkDisp = DataUtils.GetInt(((DropDownList)gvApproval.Rows[rowIndex].FindControl("ddlApprovalsDispositionE")).SelectedValue.ToString());
            DateTime DispDate = Convert.ToDateTime(((TextBox)gvApproval.Rows[rowIndex].FindControl("txtApprovalsDispDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvApproval.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationStewardshipData.UpdateConserveApprovals(ConserveApprovalID, ReqDate, LkDisp, DispDate, RowIsActive);
            gvApproval.EditIndex = -1;

            BindApprovalsGrid();

            LogMessage("Approval updated successfully");
        }

        protected void gvApproval_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlApprovalsDispositionE = (e.Row.FindControl("ddlApprovalsDispositionE") as DropDownList);
                    TextBox LKApproval = (e.Row.FindControl("LKApproval") as TextBox);

                    if (LKApproval != null)
                    {
                        BindLookUP(ddlApprovalsDispositionE, 68);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlApprovalsDispositionE.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (LKApproval.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlApprovalsDispositionE.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }

        }

        private void BindApprovalsGrid()
        {
            try
            {
                DataTable dtApproval = ConservationStewardshipData.GetConserveApprovalsList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtApproval.Rows.Count > 0)
                {
                    dvApprovalGrid.Visible = true;
                    gvApproval.DataSource = dtApproval;
                    gvApproval.DataBind();
                }
                else
                {
                    dvApprovalGrid.Visible = false;
                    gvApproval.DataSource = null;
                    gvApproval.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApprovalsGrid", "", ex.Message);
            }
        }

        private void ClearApprovalForm()
        {
            ddlApproval.SelectedIndex = -1;
            txtApprovalReqdate.Text = "";
            ddlApprovalDisposition.SelectedIndex = -1;
            txtApprovalDispositionDate.Text = "";
            cbAddApproval.Checked = false;
        }

        protected void gvPlan_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPlan.EditIndex = e.NewEditIndex;
            BindPlansGrid();
        }

        protected void gvPlan_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPlan.EditIndex = -1;
            BindPlansGrid();
        }

        protected void gvPlan_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveApprovalID = DataUtils.GetInt(((Label)gvPlan.Rows[rowIndex].FindControl("lblConservePlanID")).Text);
            DateTime DispDate = Convert.ToDateTime(((TextBox)gvPlan.Rows[rowIndex].FindControl("txtPlanDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvPlan.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationStewardshipData.UpdateConservePlans(ConserveApprovalID, DispDate, RowIsActive);
            gvPlan.EditIndex = -1;

            BindPlansGrid();

            LogMessage("Plan updated successfully");
        }

        private void BindPlansGrid()
        {
            try
            {
                DataTable dtPlan = ConservationStewardshipData.GetConservePlansList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtPlan.Rows.Count > 0)
                {
                    dvPlanGrid.Visible = true;
                    gvPlan.DataSource = dtPlan;
                    gvPlan.DataBind();
                }
                else
                {
                    dvPlanGrid.Visible = false;
                    gvPlan.DataSource = null;
                    gvPlan.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPlansGrid", "", ex.Message);
            }
        }

        private void ClearPlansForm()
        {
            ddlPlan.SelectedIndex = -1;
            txtPlanDate.Text = "";
            cbAddApproval.Checked = false;
        }

        protected void btnAddPlan_Click(object sender, EventArgs e)
        {
            if (ddlPlan.SelectedIndex == 0)
            {
                LogMessage("Select Plan");
                ddlPlan.Focus();
                return;
            }

            if (txtPlanDate.Text.Trim() == "")
            {
                LogMessage("Enter Date");
                txtPlanDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtPlanDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Date");
                    txtPlanDate.Focus();
                    return;
                }
            }

            ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConservePlans(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlPlan.SelectedValue.ToString()), DataUtils.GetDate(txtPlanDate.Text));

            ClearPlansForm();

            BindPlansGrid();

            if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                LogMessage("New Plan already exist as in-active");
            else if (objAddConsAmend.IsDuplicate)
                LogMessage("New Plan already exist");
            else
                LogMessage("New Plan added successfully");
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            if (ddlEvent.SelectedIndex == 0)
            {
                LogMessage("Select Event");
                ddlEvent.Focus();
                return;
            }

            if (txtEventDate.Text.Trim() == "")
            {
                LogMessage("Enter Date");
                txtEventDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtEventDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Date");
                    txtEventDate.Focus();
                    return;
                }
            }

            ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConserveEvent(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlEvent.SelectedValue.ToString()), DataUtils.GetDate(txtEventDate.Text));

            ClearEventForm();

            BindEventGrid();

            if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                LogMessage("New Event already exist as in-active");
            else if (objAddConsAmend.IsDuplicate)
                LogMessage("New Event already exist");
            else
                LogMessage("New Event added successfully");
        }

        private void BindEventGrid()
        {
            try
            {
                DataTable dtEvent = ConservationStewardshipData.GetConserveEventList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtEvent.Rows.Count > 0)
                {
                    dvEventGrid.Visible = true;
                    gvEvent.DataSource = dtEvent;
                    gvEvent.DataBind();
                }
                else
                {
                    dvEventGrid.Visible = false;
                    gvEvent.DataSource = null;
                    gvEvent.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindEventGrid", "", ex.Message);
            }
        }

        private void ClearEventForm()
        {
            ddlEvent.SelectedIndex = -1;
            txtEventDate.Text = "";
            cbAddEvent.Checked = false;
        }

        protected void gvEvent_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEvent.EditIndex = e.NewEditIndex;
            BindEventGrid();
        }

        protected void gvEvent_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEvent.EditIndex = -1;
            BindEventGrid();
        }

        protected void gvEvent_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveEventID = DataUtils.GetInt(((Label)gvEvent.Rows[rowIndex].FindControl("lblConserveEventID")).Text);
            DateTime DispDate = Convert.ToDateTime(((TextBox)gvEvent.Rows[rowIndex].FindControl("txtEventDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvEvent.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationStewardshipData.UpdateConserveEvent(ConserveEventID, DispDate, RowIsActive);
            gvEvent.EditIndex = -1;

            BindEventGrid();

            LogMessage("Plan updated successfully");
        }
    }
}