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
                GetRoleAccess();
                BindConConserveForm();
            }
            //GetRoleAuth();
        }

        protected bool GetIsVisibleBasedOnRole()
        {
            return DataUtils.GetBool(hfIsVisibleBasedOnRole.Value);
        }

        protected void GetRoleAccess()
        {

            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(DataUtils.GetInt(hfProjectId.Value));

            if (dr != null)
            {
                if (dr["usergroupid"].ToString() == "0") // Admin Only
                {
                    hfIsVisibleBasedOnRole.Value = "true";
                }
                else if (dr["usergroupid"].ToString() == "1") // Program Admin Only
                {
                    if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        hfIsVisibleBasedOnRole.Value = "true";
                    }
                }
                else if (dr["usergroupid"].ToString() == "2") //2. Program Staff  
                {
                    if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        if (Convert.ToBoolean(drProjectDetails["verified"].ToString()))
                        {
                            RoleViewOnlyExceptAddNewItem();
                            hfIsVisibleBasedOnRole.Value = "false";
                        }
                        else
                        {
                            hfIsVisibleBasedOnRole.Value = "true";
                        }
                    }
                }
                else if (dr["usergroupid"].ToString() == "3") // View Only
                {
                    RoleViewOnly();
                    hfIsVisibleBasedOnRole.Value = "false";
                }
            }
        }

        protected void RoleViewOnlyExceptAddNewItem()
        {
            btnSubmit.Visible = false;
            cbAddAcreage.Enabled = true;
            cbAddEasementHolder.Enabled = true;
            cbAddSurfaceWaters.Enabled = true;
        }

        protected void RoleViewOnly()
        {
            btnAddAcreage.Visible = false;
            btnAddSurfaceWaters.Visible = false;
            btnSubmit.Visible = false;

            cbAddAcreage.Enabled = false;
            cbAddEasementHolder.Enabled = false;
            cbAddSurfaceWaters.Enabled = false;
        }

        //protected bool GetRoleAuth()
        //{
        //    bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
        //    if (!checkAuth)
        //        RoleReadOnly();
        //    return checkAuth;
        //}
        //protected void RoleReadOnly()
        //{
        //    btnAddAcreage.Visible = false;
        //    btnAddSurfaceWaters.Visible = false;
        //    btnSubmit.Visible = false;
        //    cbAddAcreage.Enabled = false;
        //    cbAddEasementHolder.Enabled = false;
        //    cbAddSurfaceWaters.Enabled = false;
        //}

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
                //PopulateDropDown(ddlPSO, drConserve["PrimStew"].ToString());
                //txtTotProjAcres.Text = drConserve["TotalAcres"].ToString();
                txtWooded.Text = drConserve["Wooded"].ToString();
                txtPrime.Text = drConserve["Prime"].ToString();
                txtStateWide.Text = drConserve["Statewide"].ToString();
                txtTillable.Text = drConserve["Tillable"].ToString();
                txtUnManaged.Text = drConserve["Unmanaged"].ToString();
                txtPasture.Text = drConserve["Pasture"].ToString();
                txtFarmResident.Text= drConserve["FarmResident"].ToString();
                txtNaturalRec.Text = drConserve["NaturalRec"].ToString();
                pctWooded.InnerText = "0";
                PopulateDropDown(ddlGeoSignificance, drConserve["GeoSignificance"].ToString());
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
                    + DataUtils.GetDecimal(txtUnManaged.Text) + DataUtils.GetDecimal(txtFarmResident.Text) + DataUtils.GetDecimal(txtNaturalRec.Text);
                spnTotalProject.InnerText = Total.ToString();

                var TotalPS = DataUtils.GetDecimal(txtPrime.Text) + DataUtils.GetDecimal(txtStateWide.Text);

                if (Total != 0)
                {
                    pctPrimeStateWide.InnerText = (Math.Round(TotalPS * 100 / Total).ToString()).ToString() + " %";
                    pctWooded.InnerText = (Math.Round(DataUtils.GetDecimal(txtWooded.Text) / Total * 100)).ToString() + " %";
                }

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
            //BindPrimaryStewardOrganization();
            BindEasementHolder(ddlEasementHolder);
            BindLookUP(ddlAcreageDescription, 97);
            BindLookUP(ddlWatershed, 143);
            BindLookUP(ddlWaterShedNew, 143);
            BindLookUP(ddlWaterBody, 140);
            BindLookUP(ddlGeoSignificance, 255);
            BindLookUP(ddlSubwatershed, 261);
        }

        private void BindLookupSubWatershed(int TypeId)
        {
            try
            {
                ddlSubWatershedNew.Items.Clear();
                ddlSubWatershedNew.DataSource = LookupMaintenanceData.GetLkLookupSubValues(TypeId, cbActiveOnly.Checked);
                ddlSubWatershedNew.DataValueField = "subtypeid";
                ddlSubWatershedNew.DataTextField = "SubDescription";
                ddlSubWatershedNew.DataBind();
                ddlSubWatershedNew.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindPrimaryStewardOrganization()
        {
            try
            {
                //ddlPSO.Items.Clear();
                //ddlPSO.DataSource = ConservationSummaryData.GetPrimaryStewardOrg();
                //ddlPSO.DataValueField = "applicantid";
                //ddlPSO.DataTextField = "ApplicantName";
                //ddlPSO.DataBind();
                //ddlPSO.Items.Insert(0, new ListItem("Select", "NA"));
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
            BindWatershedGrid();
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
                DataUtils.GetInt(txtEasements.Text), //DataUtils.GetInt(ddlPSO.SelectedValue.ToString()), 
                0,//DataUtils.GetInt(txtTotProjAcres.Text),
                DataUtils.GetDecimal(txtWooded.Text), DataUtils.GetDecimal(txtPrime.Text), DataUtils.GetDecimal(txtStateWide.Text),
                DataUtils.GetDecimal(txtTillable.Text), DataUtils.GetDecimal(txtPasture.Text), DataUtils.GetDecimal(txtUnManaged.Text), 
                DataUtils.GetDecimal(txtFarmResident.Text), DataUtils.GetDecimal(txtNaturalRec.Text), GetUserId(),
                DataUtils.GetInt(ddlGeoSignificance.SelectedValue.ToString()));

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

            Result objResult = ConservationSummaryData.AddConserveEholder(DataUtils.GetInt(hfProjectId.Value), 
                DataUtils.GetInt(ddlEasementHolder.SelectedValue.ToString()), cbPrimarySteward.Checked);
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
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvEasementHolder.Rows[rowIndex].FindControl("chkActive")).Checked);
            bool PrimarySteward = Convert.ToBoolean(((CheckBox)gvEasementHolder.Rows[rowIndex].FindControl("chkPrimarySteward")).Checked); ;

            ConservationSummaryData.UpdateConserveEholder(ConserveEholderID, RowIsActive, PrimarySteward);
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

                ConservationSummaryData.UpdateProjectSurfaceWaters(SurfaceWatersId, 
                    DataUtils.GetInt(ddlSubwatershed.SelectedValue.ToString()), 
                    DataUtils.GetInt(ddlWaterBody.SelectedValue.ToString()),
                    DataUtils.GetInt(txtFrontageFeet.Text), txtOtherStream.Text, DataUtils.GetInt(txtRiparianBuffer.Text), cbActive.Checked);

                hfSurfaceWatersId.Value = "";
                btnAddSurfaceWaters.Text = "Add";
                cbActive.Checked = true;
                cbActive.Enabled = false;
                LogMessage("Surface Waters updated successfully");
            }
            else
            {
                Result objResult = ConservationSummaryData.AddProjectSurfaceWaters(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlWatershed.SelectedValue.ToString()),
                DataUtils.GetInt(ddlSubwatershed.SelectedValue.ToString()),
                DataUtils.GetInt(ddlWaterBody.SelectedValue.ToString()), DataUtils.GetInt(txtFrontageFeet.Text), txtOtherStream.Text,
                DataUtils.GetInt(txtRiparianBuffer.Text));

                if (objResult.IsDuplicate && !objResult.IsActive)
                    LogMessage("Surface Waters already exist as in-active");
                else if (objResult.IsDuplicate)
                    LogMessage("Surface Waters already exist");
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
            ddlSubwatershed.SelectedIndex = -1;
            txtRiparianBuffer.Text = "";
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

                    if (DataUtils.GetBool(hfIsVisibleBasedOnRole.Value))
                        btnAddSurfaceWaters.Visible = true;
                    else
                        btnAddSurfaceWaters.Visible = false;

                    cbAddSurfaceWaters.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[1].Visible = false;
                        Label lblSurfaceWatersID = e.Row.FindControl("lblSurfaceWatersID") as Label;
                        DataRow dr = ConservationSummaryData.GetProjectSurfaceWatersById(Convert.ToInt32(lblSurfaceWatersID.Text));

                        PopulateDropDown(ddlWatershed, dr["LKWaterShed"].ToString());
                        PopulateDropDown(ddlSubwatershed, dr["SubWaterShed"].ToString());
                        PopulateDropDown(ddlWaterBody, dr["LKWaterBody"].ToString());
                        txtFrontageFeet.Text = dr["FrontageFeet"].ToString();
                        txtOtherStream.Text = dr["OtherWater"].ToString();
                        txtRiparianBuffer.Text = dr["Riparian"].ToString();
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

            btnAddSurfaceWaters.Visible = true;
        }

        protected void ImgEasementHoldersReport_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Easement Holders"));
        }

        protected void ImgAcreage_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Acres"));
        }

        protected void ImgSurfaceWaters_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL(hfProjectId.Value, "Grid Conservation Surface Waters"));
        }

        protected void ImgWatershed_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btnWatershed_Click(object sender, EventArgs e)
        {
            if (ddlWaterShedNew.SelectedIndex == 0)
            {
                LogMessage("Select Watershed");
                ddlWaterShedNew.Focus();
                return;
            }

            if (ddlSubWatershedNew.SelectedIndex == 0)
            {
                LogMessage("Select Sub-Watershed");
                ddlSubWatershedNew.Focus();
                return;
            }

            
            if (btnWatershed.Text.ToLower() == "update")
            {
                int ConserveWatershedID = Convert.ToInt32(hfConserveWatershedID.Value);

                ConservationSummaryData.UpdateWatershed(ConserveWatershedID,
                    DataUtils.GetInt(ddlWaterShedNew.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSubWatershedNew.SelectedValue.ToString()),
                    cbWatershedActive.Checked);

                hfConserveWatershedID.Value = "";
                btnWatershed.Text = "Add";
                cbWatershedActive.Checked = true;
                cbWatershedActive.Enabled = false;
                LogMessage("Watershed updated successfully");
            }
            else
            {
                Result objResult = ConservationSummaryData.AddWatershed(DataUtils.GetInt(hfConserveId.Value),
                DataUtils.GetInt(ddlWaterShedNew.SelectedValue.ToString()),
                DataUtils.GetInt(ddlSubWatershedNew.SelectedValue.ToString()));

                if (objResult.IsDuplicate && !objResult.IsActive)
                    LogMessage("Watershed already exist as in-active");
                else if (objResult.IsDuplicate)
                    LogMessage("Watershed already exist");
                else
                    LogMessage("New Watershed added successfully");
            }

            gvWatershed.EditIndex = -1;
            BindWatershedGrid();
            ClearWatershedForm();
            //dvSurfaceWatersGrid.Visible = true;
            cbAddWatershed.Checked = false;
        }

        private void BindWatershedGrid()
        {
            try
            {
                DataTable dtWatershed = ConservationSummaryData.GetWatershedList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dtWatershed.Rows.Count > 0)
                {
                    dvWatershedGrid.Visible = true;
                    gvWatershed.DataSource = dtWatershed;
                    gvWatershed.DataBind();
                }
                else
                {
                    dvWatershedGrid.Visible = false;
                    gvWatershed.DataSource = null;
                    gvWatershed.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindWatershedGrid", "", ex.Message);
            }
        }

        private void ClearWatershedForm()
        {
            ddlSubWatershedNew.SelectedIndex = -1;
            ddlWaterShedNew.SelectedIndex = -1;
            cbAddWatershed.Checked = false;
        }

        protected void ddlWaterShedNew_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWaterShedNew.SelectedIndex > 0)
                BindLookupSubWatershed(DataUtils.GetInt(ddlWaterShedNew.SelectedValue));
            else
                ddlSubWatershedNew.Items.Clear();
        }

        protected void gvWatershed_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvWatershed.EditIndex = e.NewEditIndex;
            BindWatershedGrid();
        }

        protected void gvWatershed_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbWatershedActive.Checked = true;
            cbWatershedActive.Enabled = false;
            cbAddWatershed.Checked = false;
            ClearWatershedForm();
            btnWatershed.Text = "Add";

            gvWatershed.EditIndex = -1;
            BindWatershedGrid();

            btnWatershed.Visible = true;
        }

        protected void gvWatershed_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnWatershed.Text = "Update";

                    //if (DataUtils.GetBool(hfIsVisibleBasedOnRole.Value))
                    //    btnAddSurfaceWaters.Visible = true;
                    //else
                    //    btnAddSurfaceWaters.Visible = false;

                    cbAddWatershed.Checked = true;

                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[4].Controls[1].Visible = false;
                        Label lblConserveWatershedID = e.Row.FindControl("lblConserveWatershedID") as Label;
                        DataRow dr = ConservationSummaryData.GetWatershedById(Convert.ToInt32(lblConserveWatershedID.Text));

                        PopulateDropDown(ddlWaterShedNew, dr["LKWatershed"].ToString());
                        BindLookupSubWatershed(DataUtils.GetInt(dr["LKWatershed"].ToString()));
                        PopulateDropDown(ddlSubWatershedNew, dr["LkSubWatershed"].ToString());
                        cbWatershedActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbWatershedActive.Enabled = true;
                        hfConserveWatershedID.Value = lblConserveWatershedID.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvWatershed_RowDataBound", "", ex.Message);
            }
        }
    }
}