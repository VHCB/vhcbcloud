using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Conservation;

namespace vhcbcloud.Conservation
{
    public partial class ConservationSummary : System.Web.UI.Page
    {
        string Pagename = "ConservationSummary";
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
                BindConConserveForm();
            }
        }

        private void ProjectNotesSetUp()
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));
            if (ProjectNotesData.IsNotesExist(PageId))
                btnProjectNotes.ImageUrl = "~/Images/currentpagenotes.png";

            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"] +
                    "&PageId=" + PageId;
            }
        }

        private void BindConConserveForm()
        {
            DataRow drConserve = ConservationSummaryData.GetConserveDetailsById(DataUtils.GetInt(hfProjectId.Value));
            hfConserveId.Value = "";
            dvNewEasementHolder.Visible = false;
            dvNewAcreage.Visible = false;
            dvNewSurfaceWaters.Visible = false;

            if (drConserve != null)
            {
                hfConserveId.Value = drConserve["ConserveID"].ToString();
                PopulateDropDown(ddlConservationTrack, drConserve["LkConsTrack"].ToString());
                txtEasements.Text = drConserve["NumEase"].ToString();
                PopulateDropDown(ddlPSO, drConserve["PrimStew"].ToString());
                //txtTotProjAcres.Text = drConserve["TotalAcres"].ToString();
                txtWooded.Text = drConserve["Wooded"].ToString();
                txtPrime.Text = drConserve["Prime"].ToString();
                txtStateWide.Text = drConserve["Statewide"].ToString();
                txtTillable.Text = drConserve["Tillable"].ToString();
                txtUnManaged.Text = drConserve["Unmanaged"].ToString();
                txtPasture.Text = drConserve["Pasture"].ToString();
                txtFarmResident.Text= drConserve["FarmResident"].ToString();
                pctWooded.InnerText = "0";
                //pctPrime.InnerText = "0";
                //pctState.InnerText = "0";
                //otherAcres.InnerText = "0";

                //if (DataUtils.GetInt(txtTotProjAcres.Text) != 0)
                //{
                //    //                    pctWooded.InnerText = (Math.Round(DataUtils.GetDecimal(txtWooded.Text) / DataUtils.GetInt(txtTotProjAcres.Text) * 100, 2)).ToString();
                //    pctWooded.InnerText = (Math.Round(DataUtils.GetDecimal(txtWooded.Text) / DataUtils.GetInt(txtTotProjAcres.Text) * 100)).ToString();
                //    pctPrime.InnerText = (Math.Round(DataUtils.GetDecimal(txtPrime.Text) / DataUtils.GetInt(txtTotProjAcres.Text) * 100)).ToString();
                //    pctState.InnerText = (Math.Round(DataUtils.GetDecimal(txtStateWide.Text) / DataUtils.GetInt(txtTotProjAcres.Text) * 100)).ToString();
                //    otherAcres.InnerText = (DataUtils.GetInt(txtTotProjAcres.Text) - (DataUtils.GetDecimal(txtWooded.Text) + DataUtils.GetDecimal(txtPrime.Text)
                //    + DataUtils.GetDecimal(txtStateWide.Text))).ToString();
                //}
                var Total = DataUtils.GetDecimal(txtTillable.Text) + DataUtils.GetDecimal(txtPasture.Text) + DataUtils.GetDecimal(txtWooded.Text) 
                    + DataUtils.GetDecimal(txtUnManaged.Text) + DataUtils.GetDecimal(txtFarmResident.Text);
                spnTotalProject.InnerText = Total.ToString();

                var TotalPS = DataUtils.GetDecimal(txtPrime.Text) + DataUtils.GetDecimal(txtStateWide.Text);

                pctPrimeStateWide.InnerText = Math.Round(TotalPS * 100 / Total).ToString();

                pctWooded.InnerText = (Math.Round(DataUtils.GetDecimal(txtWooded.Text) / Total * 100)).ToString();

                btnSubmit.Text = "Update";
                dvNewEasementHolder.Visible = true;
                dvNewAcreage.Visible = true;
                dvNewSurfaceWaters.Visible = true;
                BindGrids();
            }
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
                if (dr["URL"].ToString().Contains("ConservationSummary.aspx"))
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
            BindLookUP(ddlConservationTrack, 7);
            BindPrimaryStewardOrganization();
            BindEasementHolder(ddlEasementHolder);
            BindLookUP(ddlAcreageDescription, 97);
            BindLookUP(ddlWatershed, 143);
            BindLookUP(ddlWaterBody, 140);
        }

        private void BindPrimaryStewardOrganization()
        {
            try
            {
                ddlPSO.Items.Clear();
                ddlPSO.DataSource = ConservationSummaryData.GetPrimaryStewardOrg();
                ddlPSO.DataValueField = "applicantid";
                ddlPSO.DataTextField = "ApplicantName";
                ddlPSO.DataBind();
                ddlPSO.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
            }
        }

        private void BindEasementHolder(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ConservationSummaryData.GetEasementHolder();
                ddList.DataValueField = "applicantid";
                ddList.DataTextField = "ApplicantName";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindEasementHolder", "", ex.Message);
            }
        }

        private void BindGrids()
        {
            BindEasementHolderGrid();
            BindAcreageGrid();
            BindSurfacewatersGrid();
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ConservationSummaryData.SubmitConserve(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlConservationTrack.SelectedValue.ToString()),
                DataUtils.GetInt(txtEasements.Text), DataUtils.GetInt(ddlPSO.SelectedValue.ToString()), 0,//DataUtils.GetInt(txtTotProjAcres.Text),
                DataUtils.GetInt(txtWooded.Text), DataUtils.GetInt(txtPrime.Text), DataUtils.GetInt(txtStateWide.Text),
                DataUtils.GetInt(txtTillable.Text), DataUtils.GetInt(txtPasture.Text), DataUtils.GetInt(txtUnManaged.Text), 
                DataUtils.GetInt(txtFarmResident.Text), GetUserId());

            BindConConserveForm();

            if (btnSubmit.Text.ToLower() == "update")
                LogMessage("Conservation updated successfully");
            else
                LogMessage("Conservation added successfully");
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

        protected void AddEasementHolder_Click(object sender, EventArgs e)
        {
            if (ddlEasementHolder.SelectedIndex == 0)
            {
                LogMessage("Select Easement Holder");
                ddlEasementHolder.Focus();
                return;
            }

            Result objResult = ConservationSummaryData.AddConserveEholder(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlEasementHolder.SelectedValue.ToString()));
            CleaEasementHolderForm();

            BindEasementHolderGrid();

            if (objResult.IsDuplicate && !objResult.IsActive)
                LogMessage("Easement Holder already exist as in-active");
            else if (objResult.IsDuplicate)
                LogMessage("Easement Holder already exist");
            else
                LogMessage("New Easement Holder added successfully");
        }

        private void BindEasementHolderGrid()
        {
            try
            {
                DataTable dtMajor = ConservationSummaryData.GetConserveEholderList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtMajor.Rows.Count > 0)
                {
                    dvEasementHolderGrid.Visible = true;
                    gvEasementHolder.DataSource = dtMajor;
                    gvEasementHolder.DataBind();
                }
                else
                {
                    dvEasementHolderGrid.Visible = false;
                    gvEasementHolder.DataSource = null;
                    gvEasementHolder.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindEasementHolderGrid", "", ex.Message);
            }
        }

        private void CleaEasementHolderForm()
        {
            ddlEasementHolder.SelectedIndex = -1;
            cbAddEasementHolder.Checked = false;
        }

        protected void gvEasementHolder_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEasementHolder.EditIndex = e.NewEditIndex;
            BindEasementHolderGrid();
        }

        protected void gvEasementHolder_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEasementHolder.EditIndex = -1;
            BindEasementHolderGrid();
        }

        protected void gvEasementHolder_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveEholderID = DataUtils.GetInt(((Label)gvEasementHolder.Rows[rowIndex].FindControl("lblConserveEholderID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvEasementHolder.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationSummaryData.UpdateConserveEholder(ConserveEholderID, RowIsActive);
            gvEasementHolder.EditIndex = -1;

            BindEasementHolderGrid();

            LogMessage("Easement Holder updated successfully");
        }

        protected void btnAddAcreage_Click(object sender, EventArgs e)
        {
            if (ddlAcreageDescription.SelectedIndex == 0)
            {
                LogMessage("Select Description");
                ddlAcreageDescription.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtAcres.Text.ToString()) == true)
            {
                LogMessage("Enter Acres");
                txtAcres.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtAcres.Text) <= 0)
            {
                LogMessage("Enter valid Acres");
                txtAcres.Focus();
                return;
            }

            Result objResult = ConservationSummaryData.AddConserveAcres(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlAcreageDescription.SelectedValue.ToString()), DataUtils.GetInt(txtAcres.Text));
            CleaAcreageForm();

            BindAcreageGrid();

            if (objResult.IsDuplicate && !objResult.IsActive)
                LogMessage("Acreage already exist as in-active");
            else if (objResult.IsDuplicate)
                LogMessage("Acreage Holder already exist");
            else
                LogMessage("New Acreage added successfully");
        }

        private void CleaAcreageForm()
        {
            ddlAcreageDescription.SelectedIndex = -1;
            cbAddAcreage.Checked = false;
        }

        private void BindAcreageGrid()
        {
            try
            {
                DataTable dtAcreage = ConservationSummaryData.GetConserveAcresList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtAcreage.Rows.Count > 0)
                {
                    dvAcreageGrid.Visible = true;
                    gvAcreage.DataSource = dtAcreage;
                    gvAcreage.DataBind();

                    Label lblFooterTotal = (Label)gvAcreage.FooterRow.FindControl("lblFooterTotal");
                    int totAcres = 0;

                    for (int i = 0; i < dtAcreage.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dtAcreage.Rows[i]["RowIsActive"].ToString()))
                            totAcres += DataUtils.GetInt(dtAcreage.Rows[i]["Acres"].ToString());
                    }

                    lblFooterTotal.Text = totAcres.ToString();
                }
                else
                {
                    dvAcreageGrid.Visible = false;
                    gvAcreage.DataSource = null;
                    gvAcreage.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAcreageGrid", "", ex.Message);
            }
        }

        protected void gvAcreage_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAcreage.EditIndex = e.NewEditIndex;
            BindAcreageGrid();
        }

        protected void gvAcreage_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAcreage.EditIndex = -1;
            BindAcreageGrid();
        }

        protected void gvAcreage_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            string strAcres = ((TextBox)gvAcreage.Rows[rowIndex].FindControl("txtAcres")).Text;

            if (string.IsNullOrWhiteSpace(strAcres) == true)
            {
                LogMessage("Enter Acres");
                return;
            }
            if (DataUtils.GetDecimal(strAcres) <= 0)
            {
                LogMessage("Enter valid Acres");
                return;
            }

            int ConserveAcresID = DataUtils.GetInt(((Label)gvAcreage.Rows[rowIndex].FindControl("lblConserveAcresID")).Text);
            int Acres = DataUtils.GetInt(strAcres);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAcreage.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationSummaryData.UpdateConserveAcres(ConserveAcresID, Acres, RowIsActive);
            gvAcreage.EditIndex = -1;

            BindAcreageGrid();

            LogMessage("Acreage updated successfully");
        }

        private void BindSurfacewatersGrid()
        {
            try
            {
                DataTable dtSurfaceWaters = ConservationSummaryData.GetSurfaceWatersList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtSurfaceWaters.Rows.Count > 0)
                {
                    dvSurfaceWatersGrid.Visible = true;
                    gvSurfaceWaters.DataSource = dtSurfaceWaters;
                    gvSurfaceWaters.DataBind();
                }
                else
                {
                    dvSurfaceWatersGrid.Visible = false;
                    gvSurfaceWaters.DataSource = null;
                    gvSurfaceWaters.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSurfacewatersGrid", "", ex.Message);
            }
        }

        protected void btnAddSurfaceWaters_Click(object sender, EventArgs e)
        {
            if (ddlWaterBody.SelectedIndex == 0)
            {
                LogMessage("Select Watershed");
                ddlWaterBody.Focus();
                return;
            }

            if (ddlWaterBody.SelectedIndex == 0)
            {
                LogMessage("Select Water Body");
                ddlWaterBody.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtFrontageFeet.Text.ToString()) == true)
            {
                LogMessage("Enter Frontage");
                txtFrontageFeet.Focus();
                return;
            }
            if (DataUtils.GetDecimal(txtFrontageFeet.Text) <= 0)
            {
                LogMessage("Enter valid Frontage");
                txtFrontageFeet.Focus();
                return;
            }

            if (btnAddSurfaceWaters.Text.ToLower() == "update")
            {
                int SurfaceWatersId = Convert.ToInt32(hfSurfaceWatersId.Value);

                ConservationSummaryData.UpdateProjectSurfaceWaters(SurfaceWatersId, txtSubwatershed.Text, DataUtils.GetInt(ddlWaterBody.SelectedValue.ToString()),
                    DataUtils.GetInt(txtFrontageFeet.Text), txtOtherStream.Text, cbActive.Checked);

                hfSurfaceWatersId.Value = "";
                btnAddSurfaceWaters.Text = "Add";
                cbActive.Checked = true;
                cbActive.Enabled = false;
                LogMessage("Surface Waters updated successfully");
            }
            else
            {
                Result objResult = ConservationSummaryData.AddProjectSurfaceWaters(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlWatershed.SelectedValue.ToString()), txtSubwatershed.Text,
                DataUtils.GetInt(ddlWaterBody.SelectedValue.ToString()), DataUtils.GetInt(txtFrontageFeet.Text), txtOtherStream.Text);

                if (objResult.IsDuplicate && !objResult.IsActive)
                    LogMessage("Surface Waters already exist as in-active");
                else if (objResult.IsDuplicate)
                    LogMessage("Surfac eWaters already exist");
                else
                    LogMessage("New Surface Waters added successfully");
            }

            gvSurfaceWaters.EditIndex = -1;
            BindSurfacewatersGrid();
            ClearSurfaceWatersForm();
            //dvSurfaceWatersGrid.Visible = true;
            cbAddSurfaceWaters.Checked = false;
        }

        private void ClearSurfaceWatersForm()
        {
            ddlWatershed.SelectedIndex = -1;
            ddlWaterBody.SelectedIndex = -1;
            txtOtherStream.Text = "";
            txtFrontageFeet.Text = "";
            txtSubwatershed.Text = "";
            cbAddSurfaceWaters.Checked = false;
        }

        protected void gvSurfaceWaters_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddSurfaceWaters.Text = "Update";
                    cbAddSurfaceWaters.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        Label lblSurfaceWatersID = e.Row.FindControl("lblSurfaceWatersID") as Label;
                        DataRow dr = ConservationSummaryData.GetProjectSurfaceWatersById(Convert.ToInt32(lblSurfaceWatersID.Text));

                        PopulateDropDown(ddlWatershed, dr["LKWaterShed"].ToString());
                        txtSubwatershed.Text = dr["SubWaterShed"].ToString();
                        PopulateDropDown(ddlWaterBody, dr["LKWaterBody"].ToString());
                        txtFrontageFeet.Text = dr["FrontageFeet"].ToString();
                        txtOtherStream.Text = dr["OtherWater"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbActive.Enabled = true;
                        hfSurfaceWatersId.Value = lblSurfaceWatersID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvSurfaceWaters_RowDataBound", "", ex.Message);
            }
        }

        protected void gvSurfaceWaters_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSurfaceWaters.EditIndex = e.NewEditIndex;
            BindSurfacewatersGrid();
        }

        protected void gvSurfaceWaters_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbActive.Checked = true;
            cbActive.Enabled = false;
            cbAddSurfaceWaters.Checked = false;
            ClearSurfaceWatersForm();
            btnAddSurfaceWaters.Text = "Add";

            gvSurfaceWaters.EditIndex = -1;
            BindSurfacewatersGrid();
        }
    }
}