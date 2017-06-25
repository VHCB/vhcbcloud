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
using System.IO;
using Microsoft.AspNet.Identity;

namespace vhcbcloud.Conservation
{
    public partial class ConservationStewardship : System.Web.UI.Page
    {
        string Pagename = "ConservationStewardship";
        string ProgramId = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";

            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();

                BindControls();
                BindGrids();
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
        private void ProjectNotesSetUp()
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));

            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"] +
                    "&PageId=" + PageId;
                if (ProjectNotesData.IsNotesExist(PageId, DataUtils.GetInt(hfProjectId.Value)))
                    btnProjectNotes.ImageUrl = "~/Images/currentpagenotes.png";
            }
        }

        private void GenerateTabs()
        {
            //string ProgramId = null;

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
            //BindLookUP(ddlEvent, 146);
            BindLookUP(ddlProgramMilestone, 159);
        }

        private void BindGrids()
        {
            BindMajorGrid();
            BindMinorGrid();
            BindViolationsGrid();
            BindApprovalsGrid();
            BindPlansGrid();
            //BindEventGrid();
            BindMilestoneGrid();
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

            string URL = txtMajorURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnAddMajor.Text.ToLower() == "update")
            {
                int ConserveMajAmendID = Convert.ToInt32(hfConserveMajAmendID.Value);

                ConservationStewardshipData.UpdateConservationMajorAmend(ConserveMajAmendID, DataUtils.GetDate(txtMjrReqDate.Text), DataUtils.GetInt(ddlMjrDisposition.SelectedValue.ToString()),
                DataUtils.GetDate(txtMjrDispositionDate.Text), cbMajorActive.Checked, URL, txtMajorComments.Text);

                hfConserveMajAmendID.Value = "";
                btnAddMajor.Text = "Add";
                cbMajorActive.Checked = true;
                cbMajorActive.Enabled = false;
                LogMessage("Major Amendment updated successfully");

                gvMajor.EditIndex = -1;

                BindMajorGrid();
                ClearMajorAmendmentForm();
                cbAddMajor.Checked = false;
            }
            else
            {
                ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConservationMajorAmend(
                DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlMjrAmendment.SelectedValue.ToString()),
                DataUtils.GetDate(txtMjrReqDate.Text), DataUtils.GetInt(ddlMjrDisposition.SelectedValue.ToString()),
                DataUtils.GetDate(txtMjrDispositionDate.Text), URL, txtMajorComments.Text);

                ClearMajorAmendmentForm();

                BindMajorGrid();

                if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                    LogMessage("New Major Amendment already exist as in-active");
                else if (objAddConsAmend.IsDuplicate)
                    LogMessage("New Major Amendment already exist");
                else
                    LogMessage("New Major Amendment added successfully");
            }
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
            txtMajorURL.Text = "";
            txtMajorComments.Text = "";
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
            ClearMajorAmendmentForm();
            cbAddMajor.Checked = false;
        }

        //protected void gvMajor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int rowIndex = e.RowIndex;

        //    int ConserveMajAmendID = DataUtils.GetInt(((Label)gvMajor.Rows[rowIndex].FindControl("lblConserveMajAmendID")).Text);
        //    DateTime ReqDate = Convert.ToDateTime(((TextBox)gvMajor.Rows[rowIndex].FindControl("txtReqDate")).Text);
        //    int LkDisp = DataUtils.GetInt(((DropDownList)gvMajor.Rows[rowIndex].FindControl("ddlMjrDispositionE")).SelectedValue.ToString());
        //    DateTime DispDate = Convert.ToDateTime(((TextBox)gvMajor.Rows[rowIndex].FindControl("txtDispDate")).Text);
        //    bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMajor.Rows[rowIndex].FindControl("chkActive")).Checked); ;

        //    ConservationStewardshipData.UpdateConservationMajorAmend(ConserveMajAmendID, ReqDate, LkDisp, DispDate, RowIsActive);
        //    gvMajor.EditIndex = -1;

        //    BindMajorGrid();

        //    LogMessage("Major Amendment updated successfully");
        //}

        protected void gvMajor_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddMajor.Text = "Update";
                    cbAddMajor.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblConserveMajAmendID = e.Row.FindControl("lblConserveMajAmendID") as Label;
                        DataRow dr = ConservationStewardshipData.GetMajorAmendmentsById(Convert.ToInt32(lblConserveMajAmendID.Text));

                        PopulateDropDown(ddlMjrAmendment, dr["LkConsMajAmend"].ToString());
                        txtMjrReqDate.Text = dr["ReqDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["ReqDate"].ToString()).ToShortDateString();
                        PopulateDropDown(ddlMjrDisposition, dr["LkDisp"].ToString());
                        txtMjrDispositionDate.Text = dr["DispDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DispDate"].ToString()).ToShortDateString();
                        txtMajorURL.Text = dr["URL"].ToString();
                        txtMajorComments.Text = dr["Comments"].ToString();
                        cbMajorActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbMajorActive.Enabled = true;
                        hfConserveMajAmendID.Value = lblConserveMajAmendID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvSurfaceWaters_RowDataBound", "", ex.Message);
            }

            //if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            //    CommonHelper.GridViewSetFocus(e.Row);
            //{
            //    if (e.Row.RowType == DataControlRowType.DataRow)
            //    {
            //        DropDownList ddlMjrDispositionE = (e.Row.FindControl("ddlMjrDispositionE") as DropDownList);
            //        TextBox txtLkConsMajAmend = (e.Row.FindControl("txtLkConsMajAmend") as TextBox);

            //        if (txtLkConsMajAmend != null)
            //        {
            //            BindLookUP(ddlMjrDispositionE, 68);

            //            string itemToCompare = string.Empty;
            //            foreach (ListItem item in ddlMjrDispositionE.Items)
            //            {
            //                itemToCompare = item.Value.ToString();
            //                if (txtLkConsMajAmend.Text.ToLower() == itemToCompare.ToLower())
            //                {
            //                    ddlMjrDispositionE.ClearSelection();
            //                    item.Selected = true;
            //                }
            //            }
            //        }
            //    }
            //}
        }

        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue == item.Value.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
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

            string URL = txtMinorURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnAddMinor.Text.ToLower() == "update")
            {
                int ConserveMinAmendID = Convert.ToInt32(hfConserveMinAmendID.Value);

                ConservationStewardshipData.UpdateConservationMinorAmend(ConserveMinAmendID, DataUtils.GetDate(txtMinorReqDate.Text), DataUtils.GetInt(ddlMinorDisposition.SelectedValue.ToString()),
                DataUtils.GetDate(txtMinorDispositionDate.Text), cbMinorActive.Checked, URL, txtMinorComments.Text);

                hfConserveMinAmendID.Value = "";
                btnAddMinor.Text = "Add";
                cbMinorActive.Checked = true;
                cbMinorActive.Enabled = false;
                LogMessage("Minor Amendment updated successfully");

                gvMinor.EditIndex = -1;

                ClearMinorAmendmentForm();

                BindMinorGrid();
                cbAddMinor.Checked = false;
            }
            else
            {
                ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConservationMinorAmend(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlMinorAmendment.SelectedValue.ToString()), DataUtils.GetDate(txtMinorReqDate.Text),
                DataUtils.GetInt(ddlMinorDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtMinorDispositionDate.Text),
                URL, txtMinorComments.Text);

                ClearMinorAmendmentForm();

                BindMinorGrid();

                if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                    LogMessage("New Minor Amendment already exist as in-active");
                else if (objAddConsAmend.IsDuplicate)
                    LogMessage("New Minor Amendment already exist");
                else
                    LogMessage("New Minor Amendment added successfully");
            }
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
            ClearMinorAmendmentForm();
            cbAddMinor.Checked = false;
        }

        protected void gvMinor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //int rowIndex = e.RowIndex;

            //int ConserveMinAmendID = DataUtils.GetInt(((Label)gvMinor.Rows[rowIndex].FindControl("lblConserveMinAmendID")).Text);
            //DateTime ReqDate = Convert.ToDateTime(((TextBox)gvMinor.Rows[rowIndex].FindControl("txtMinorReqDate")).Text);
            //int LkDisp = DataUtils.GetInt(((DropDownList)gvMinor.Rows[rowIndex].FindControl("ddlMinorDispositionE")).SelectedValue.ToString());
            //DateTime DispDate = Convert.ToDateTime(((TextBox)gvMinor.Rows[rowIndex].FindControl("txtMinorDispDate")).Text);
            //bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMinor.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            //ConservationStewardshipData.UpdateConservationMinorAmend(ConserveMinAmendID, ReqDate, LkDisp, DispDate, RowIsActive);
            //gvMinor.EditIndex = -1;

            //BindMinorGrid();

            //LogMessage("Minor Amendment updated successfully");
        }

        protected void gvMinor_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddMinor.Text = "Update";
                    cbAddMinor.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblConserveMinAmendID = e.Row.FindControl("lblConserveMinAmendID") as Label;
                        DataRow dr = ConservationStewardshipData.GetMinorAmendmentsById(Convert.ToInt32(lblConserveMinAmendID.Text));

                        PopulateDropDown(ddlMinorAmendment, dr["LkConsMinAmend"].ToString());
                        txtMinorReqDate.Text = dr["ReqDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["ReqDate"].ToString()).ToShortDateString();
                        PopulateDropDown(ddlMinorDisposition, dr["LkDisp"].ToString());
                        txtMinorDispositionDate.Text = dr["DispDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DispDate"].ToString()).ToShortDateString();
                        txtMinorURL.Text = dr["URL"].ToString();
                        txtMinorComments.Text = dr["Comments"].ToString();
                        cbMinorActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbMinorActive.Enabled = true;
                        hfConserveMinAmendID.Value = lblConserveMinAmendID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvMinor_RowDataBound", "", ex.Message);
            }

            //if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            //    CommonHelper.GridViewSetFocus(e.Row);
            //{
            //    if (e.Row.RowType == DataControlRowType.DataRow)
            //    {
            //        DropDownList ddlMinorDispositionE = (e.Row.FindControl("ddlMinorDispositionE") as DropDownList);
            //        TextBox txtLkConsMinorAmend = (e.Row.FindControl("txtLkConsMinorAmend") as TextBox);

            //        if (txtLkConsMinorAmend != null)
            //        {
            //            BindLookUP(ddlMinorDispositionE, 68);

            //            string itemToCompare = string.Empty;
            //            foreach (ListItem item in ddlMinorDispositionE.Items)
            //            {
            //                itemToCompare = item.Value.ToString();
            //                if (txtLkConsMinorAmend.Text.ToLower() == itemToCompare.ToLower())
            //                {
            //                    ddlMinorDispositionE.ClearSelection();
            //                    item.Selected = true;
            //                }
            //            }
            //        }
            //    }
            //}
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
                LogError(Pagename, "BindMinorGrid", "", ex.Message);
            }
        }

        private void ClearMinorAmendmentForm()
        {
            ddlMinorAmendment.SelectedIndex = -1;
            txtMinorReqDate.Text = "";
            ddlMinorDisposition.SelectedIndex = -1;
            txtMinorDispositionDate.Text = "";
            txtMinorComments.Text = "";
            txtMinorURL.Text = "";
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
            txtViolationComments.Text = "";
            txtViolationURL.Text = "";
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

            string URL = txtViolationURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnAddViolation.Text.ToLower() == "update")
            {
                int ConserveViolationsID = Convert.ToInt32(hfConserveViolationsID.Value);

                ConservationStewardshipData.UpdateConserveViolations(ConserveViolationsID, DataUtils.GetDate(txtViolationReqDate.Text),
                    DataUtils.GetInt(ddlViolationDisposition.SelectedValue.ToString()),
                DataUtils.GetDate(txtViolationDispDate.Text), cbViolationActive.Checked, URL, txtViolationComments.Text);

                hfConserveViolationsID.Value = "";
                btnAddViolation.Text = "Add";
                cbViolationActive.Checked = true;
                cbViolationActive.Enabled = false;
                LogMessage("Violation updated successfully");

                gvViolation.EditIndex = -1;

                ClearViolationForm();

                BindViolationsGrid();
                cbAddViolation.Checked = false;
            }
            else
            {
                ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConserveViolations(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlViolations.SelectedValue.ToString()), DataUtils.GetDate(txtViolationReqDate.Text),
                DataUtils.GetInt(ddlViolationDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtViolationDispDate.Text), URL, txtViolationComments.Text);

                ClearViolationForm();

                BindViolationsGrid();

                if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                    LogMessage("New Violation already exist as in-active");
                else if (objAddConsAmend.IsDuplicate)
                    LogMessage("New Violation already exist");
                else
                    LogMessage("New Violation added successfully");
            }
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
            ClearViolationForm();
            cbAddViolation.Checked = false;
        }

        protected void gvViolation_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddViolation.Text = "Update";
                    cbAddViolation.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblConserveViolationsID = e.Row.FindControl("lblConserveViolationsID") as Label;
                        DataRow dr = ConservationStewardshipData.GetConserveViolationsById(Convert.ToInt32(lblConserveViolationsID.Text));

                        PopulateDropDown(ddlViolations, dr["LkConsViol"].ToString());
                        txtViolationReqDate.Text = dr["ReqDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["ReqDate"].ToString()).ToShortDateString();
                        PopulateDropDown(ddlViolationDisposition, dr["LkDisp"].ToString());
                        txtViolationDispDate.Text = dr["DispDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DispDate"].ToString()).ToShortDateString();
                        txtViolationURL.Text = dr["URL"].ToString();
                        txtViolationComments.Text = dr["Comments"].ToString();
                        cbViolationActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbViolationActive.Enabled = true;
                        hfConserveViolationsID.Value = lblConserveViolationsID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvViolation_RowDataBound", "", ex.Message);
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

            string URL = txtApprovalURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnAddApproval.Text.ToLower() == "update")
            {
                int ConserveApprovalID = Convert.ToInt32(hfConserveApprovalID.Value);

                ConservationStewardshipData.UpdateConserveApprovals(ConserveApprovalID, DataUtils.GetDate(txtApprovalReqdate.Text),
                    DataUtils.GetInt(ddlApprovalDisposition.SelectedValue.ToString()),
                DataUtils.GetDate(txtApprovalDispositionDate.Text), cbApprovalActive.Checked, URL, txtApprovalComments.Text);

                hfConserveApprovalID.Value = "";
                btnAddApproval.Text = "Add";
                cbApprovalActive.Checked = true;
                cbApprovalActive.Enabled = false;
                LogMessage("Approval updated successfully");

                gvApproval.EditIndex = -1;

                ClearApprovalForm();

                BindApprovalsGrid();
                cbAddApproval.Checked = false;
            }
            else
            {
                ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConserveApprovals(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlApproval.SelectedValue.ToString()), DataUtils.GetDate(txtApprovalReqdate.Text),
                DataUtils.GetInt(ddlApprovalDisposition.SelectedValue.ToString()), DataUtils.GetDate(txtApprovalDispositionDate.Text),
                URL, txtApprovalComments.Text);

                ClearApprovalForm();

                BindApprovalsGrid();

                if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                    LogMessage("New Approval already exist as in-active");
                else if (objAddConsAmend.IsDuplicate)
                    LogMessage("New Approval already exist");
                else
                    LogMessage("New Approval added successfully");
            }
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
            ClearApprovalForm();
            cbAddApproval.Checked = false;
        }

        protected void gvApproval_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddApproval.Text = "Update";
                    cbAddApproval.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblConserveApprovalID = e.Row.FindControl("lblConserveApprovalID") as Label;
                        DataRow dr = ConservationStewardshipData.GetConserveApprovalsById(Convert.ToInt32(lblConserveApprovalID.Text));

                        PopulateDropDown(ddlApproval, dr["LKApproval"].ToString());
                        txtApprovalReqdate.Text = dr["ReqDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["ReqDate"].ToString()).ToShortDateString();
                        PopulateDropDown(ddlApprovalDisposition, dr["LkDisp"].ToString());
                        txtApprovalDispositionDate.Text = dr["DispDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DispDate"].ToString()).ToShortDateString();
                        txtApprovalURL.Text = dr["URL"].ToString();
                        txtApprovalComments.Text = dr["Comments"].ToString();
                        cbApprovalActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbApprovalActive.Enabled = true;
                        hfConserveApprovalID.Value = lblConserveApprovalID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvApproval_RowDataBound", "", ex.Message);
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
            txtApprovalComments.Text = "";
            txtApprovalURL.Text = "";
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
            ClearPlansForm();
            cbAddPlan.Checked = false;
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
            txtPlanURL.Text = "";
            txtPlanComments.Text = "";
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

            string URL = txtPlanURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnAddPlan.Text.ToLower() == "update")
            {
                int ConservePlanID = Convert.ToInt32(hfConservePlanID.Value);

                ConservationStewardshipData.UpdateConservePlans(ConservePlanID, DataUtils.GetDate(txtPlanDate.Text),
                    URL, txtPlanComments.Text, cbPlanActive.Checked);

                hfConserveApprovalID.Value = "";
                btnAddApproval.Text = "Add";
                cbPlanActive.Checked = true;
                cbPlanActive.Enabled = false;
                LogMessage("Plan updated successfully");

                gvPlan.EditIndex = -1;

                ClearPlansForm();

                BindPlansGrid();
                cbAddPlan.Checked = false;
            }
            else
            {
                ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConservePlans(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlPlan.SelectedValue.ToString()), DataUtils.GetDate(txtPlanDate.Text), URL, txtPlanComments.Text);

                ClearPlansForm();

                BindPlansGrid();

                if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
                    LogMessage("New Plan already exist as in-active");
                else if (objAddConsAmend.IsDuplicate)
                    LogMessage("New Plan already exist");
                else
                    LogMessage("New Plan added successfully");
            }
        }

        protected void gvPlan_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddPlan.Text = "Update";
                    cbAddPlan.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblConservePlanID = e.Row.FindControl("lblConservePlanID") as Label;
                        DataRow dr = ConservationStewardshipData.GetConservePlansById(Convert.ToInt32(lblConservePlanID.Text));

                        PopulateDropDown(ddlPlan, dr["LKManagePlan"].ToString());
                        txtPlanDate.Text = dr["DispDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["DispDate"].ToString()).ToShortDateString();
                        txtPlanURL.Text = dr["URL"].ToString();
                        txtPlanComments.Text = dr["Comments"].ToString();
                        cbPlanActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbPlanActive.Enabled = true;
                        hfConservePlanID.Value = lblConservePlanID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvPlan_RowDataBound", "", ex.Message);
            }
        }

        protected void ddlProgramMilestone_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProgramMilestoneChanged();
        }

        private void ProgramMilestoneChanged()
        {
            if (ddlProgramMilestone.SelectedIndex != 0)
            {
                dvProgram.Visible = true;
                BindSubLookUP(ddlProgramSubMilestone, DataUtils.GetInt(ddlProgramMilestone.SelectedValue.ToString()));

                if (ddlProgramSubMilestone.Items.Count > 1)
                    dvSubProgram.Visible = true;
                else
                    dvSubProgram.Visible = false;
            }
        }

        private void BindSubLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.GetSubLookupValues(LookupType);
                ddList.DataValueField = "SubTypeID";
                ddList.DataTextField = "SubDescription";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
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

        protected void btnAddMilestone_Click(object sender, EventArgs e)
        {
            string URL = txtURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            MilestoneData.MilestoneResult obMilestoneResult = MilestoneData.AddMilestone(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ProgramId),
                null,
                0, 0,
                DataUtils.GetInt(ddlProgramMilestone.SelectedValue.ToString()), DataUtils.GetInt(ddlProgramSubMilestone.SelectedValue.ToString()),
                0, 0,
                DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, URL, GetUserId());

            //ClearForm();
            ClearEntityAndCommonForm();
            cbAddMilestone.Checked = false;
            BindMilestoneGrid();

            if (obMilestoneResult.IsDuplicate && !obMilestoneResult.IsActive)
                LogMessage("Milestone Event already exist as in-active");
            else if (obMilestoneResult.IsDuplicate)
                LogMessage("Milestone already exist");
            else
                LogMessage("New milestone added successfully");
        }

        private void ClearEntityAndCommonForm()
        {
            ddlProgramMilestone.SelectedIndex = -1;
            ddlProgramSubMilestone.SelectedIndex = -1;
            txtEventDate.Text = "";
            txtURL.Text = "";
            txtNotes.Text = "";
            ProgramMilestoneChanged();
        }

        protected void gvMilestone_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMilestone.EditIndex = -1;
            BindMilestoneGrid();
        }

        protected void gvMilestone_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMilestone.EditIndex = e.NewEditIndex;
            BindMilestoneGrid();
        }

        protected void gvMilestone_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectEventID = DataUtils.GetInt(((Label)gvMilestone.Rows[rowIndex].FindControl("lblProjectEventID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvMilestone.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            MilestoneData.UpdateMilestone(ProjectEventID, RowIsActive);
            gvMilestone.EditIndex = -1;

            BindMilestoneGrid();

            LogMessage("Milestone updated successfully");
        }

        private void BindMilestoneGrid()
        {
            try
            {
                DataTable dtMilestones = null;
                int RecCount = 0;

                dtMilestones = MilestoneData.GetProgramMilestonesList(DataUtils.GetInt(hfProjectId.Value), false, false, true, cbActiveOnly.Checked);
                RecCount = dtMilestones.Rows.Count;

                if (RecCount > 0)
                {
                    //dvPMFilter.Visible = true;
                    dvMilestoneGrid.Visible = true;
                    gvMilestone.DataSource = dtMilestones;
                    gvMilestone.DataBind();
                }
                else
                {
                    //dvPMFilter.Visible = false;
                    dvMilestoneGrid.Visible = false;
                    gvMilestone.DataSource = null;
                    gvMilestone.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindMilestoneGrid", "", ex.Message);
            }
        }

        protected void ImgConservationManagementPlans_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
            "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Management Plans"));
        }

        protected void ImgeConservationApprovals_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
            "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Approvals"));
        }

        protected void ImgConservationViolations_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
            "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Violations"));
        }

        protected void ImgConservationMinorAmendments_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
            "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Minor Amendments"));
        }

        protected void ImgConservationMajorAmendments_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
            "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Major Amendments"));
        }

        //protected void btnAddEvent_Click(object sender, EventArgs e)
        //{
        //    if (ddlEvent.SelectedIndex == 0)
        //    {
        //        LogMessage("Select Event");
        //        ddlEvent.Focus();
        //        return;
        //    }

        //    if (txtEventDate.Text.Trim() == "")
        //    {
        //        LogMessage("Enter Date");
        //        txtEventDate.Focus();
        //        return;
        //    }
        //    else
        //    {
        //        if (!DataUtils.IsDateTime(txtEventDate.Text.Trim()))
        //        {
        //            LogMessage("Enter Valid Date");
        //            txtEventDate.Focus();
        //            return;
        //        }
        //    }

        //    ConservationStewardshipData.AddConsAmend objAddConsAmend = ConservationStewardshipData.AddConserveEvent(DataUtils.GetInt(hfProjectId.Value),
        //        DataUtils.GetInt(ddlEvent.SelectedValue.ToString()), DataUtils.GetDate(txtEventDate.Text));

        //    ClearEventForm();

        //    BindEventGrid();

        //    if (objAddConsAmend.IsDuplicate && !objAddConsAmend.IsActive)
        //        LogMessage("New Event already exist as in-active");
        //    else if (objAddConsAmend.IsDuplicate)
        //        LogMessage("New Event already exist");
        //    else
        //        LogMessage("New Event added successfully");
        //}

        //private void BindEventGrid()
        //{
        //    try
        //    {
        //        DataTable dtEvent = ConservationStewardshipData.GetConserveEventList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

        //        if (dtEvent.Rows.Count > 0)
        //        {
        //            dvEventGrid.Visible = true;
        //            gvEvent.DataSource = dtEvent;
        //            gvEvent.DataBind();
        //        }
        //        else
        //        {
        //            dvEventGrid.Visible = false;
        //            gvEvent.DataSource = null;
        //            gvEvent.DataBind();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindEventGrid", "", ex.Message);
        //    }
        //}

        //private void ClearEventForm()
        //{
        //    ddlEvent.SelectedIndex = -1;
        //    txtEventDate.Text = "";
        //    cbAddEvent.Checked = false;
        //}

        //protected void gvEvent_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvEvent.EditIndex = e.NewEditIndex;
        //    BindEventGrid();
        //}

        //protected void gvEvent_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvEvent.EditIndex = -1;
        //    BindEventGrid();
        //}

        //protected void gvEvent_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int rowIndex = e.RowIndex;

        //    int ConserveEventID = DataUtils.GetInt(((Label)gvEvent.Rows[rowIndex].FindControl("lblConserveEventID")).Text);
        //    DateTime DispDate = Convert.ToDateTime(((TextBox)gvEvent.Rows[rowIndex].FindControl("txtEventDate")).Text);
        //    bool RowIsActive = Convert.ToBoolean(((CheckBox)gvEvent.Rows[rowIndex].FindControl("chkActive")).Checked); ;

        //    ConservationStewardshipData.UpdateConserveEvent(ConserveEventID, DispDate, RowIsActive);
        //    gvEvent.EditIndex = -1;

        //    BindEventGrid();

        //    LogMessage("Plan updated successfully");
        //}
    }
}