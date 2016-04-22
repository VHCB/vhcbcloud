using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ProjectMaintenance : System.Web.UI.Page
    {
        string Pagename = "ProjectMaintenance";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                if (Request.QueryString["Type"] == "new")
                {
                    rdBtnSelection.SelectedIndex = 0;
                    RadioButtonSelectionChanged();
                }


                BindControls();
                DisplayControlsbasedOnSelection();
                if (Request.QueryString["ProjectId"] != null)
                {
                    ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"];

                    PopulateForm(DataUtils.GetInt(Request.QueryString["ProjectId"]));
                }
            }
        }

        #region Bind Controls
        private void BindControls()
        {
            BindLookUP(ddlProgram, 34);
            BindLookUP(ddlProjectType, 119);
            BindBoardDate();
            BindManagers();
            BindPrimaryApplicants();
            BindProjects(ddlProject);
            BindApplicants();
            BindLookUP(ddlApplicantRole, 56);
            ddlApplicantRole.Items.Remove(ddlApplicantRole.Items.FindByValue("358"));
        }

        protected void BindProjects(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddList.DataValueField = "projectid";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindRelatedProjects(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddList.DataValueField = "project_id_name";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindBoardDate()
        {
            try
            {
                ddlBoardDate.Items.Clear();
                ddlBoardDate.DataSource = LookupValuesData.GetBoardDates();
                ddlBoardDate.DataValueField = "TypeID";
                ddlBoardDate.DataTextField = "BoardDate1";
                ddlBoardDate.DataBind();
                ddlBoardDate.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
            }
        }

        private void BindPrimaryApplicants()
        {
            try
            {
                ddlPrimaryApplicant.Items.Clear();
                ddlPrimaryApplicant.DataSource = ApplicantData.GetSortedApplicants();
                ddlPrimaryApplicant.DataValueField = "appnameid";
                ddlPrimaryApplicant.DataTextField = "Applicantname";
                ddlPrimaryApplicant.DataBind();
                ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
            }
        }

        protected void BindManagers()
        {
            try
            {
                ddlManager.Items.Clear();
                ddlManager.DataSource = LookupValuesData.GetManagers();
                ddlManager.DataValueField = "UserId";
                ddlManager.DataTextField = "Name";
                ddlManager.DataBind();
                ddlManager.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindManagers", "", ex.Message);
            }
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

        protected void BindApplicants()
        {
            try
            {
                ddlApplicantName.Items.Clear();
                ddlApplicantName.DataSource = ApplicantData.GetSortedApplicants();
                ddlApplicantName.DataValueField = "appnameid";
                ddlApplicantName.DataTextField = "Applicantname";
                ddlApplicantName.DataBind();
                ddlApplicantName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
            }
        }
        #endregion

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

        private void ClearForm()
        {
            txtProjNum.Text = "";
            ddlProjectType.SelectedIndex = -1;
            ddlProgram.SelectedIndex = -1;
            txtApplicationReceived.Text = "";
            //ddlAppStatus.SelectedIndex = -1;
            ddlManager.SelectedIndex = -1;
            ddlBoardDate.SelectedIndex = -1;
            txtClosingDate.Text = "";
            txtGrantExpirationDate.Text = "";
            cbVerified.Checked = false;
            ddlPrimaryApplicant.SelectedIndex = -1;
            txtProjectName.Text = "";
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProjectSelectionChanged();
        }

        private void ProjectSelectionChanged()
        {
            try
            {
                ClearForm();

                hfProjectId.Value = "";
                if (ddlProject.SelectedIndex != 0)
                {
                    dvUpdate.Visible = true;
                    //string[] tokens = ddlProject.SelectedValue.ToString().Split('|');
                    //txtProjectName.Text = tokens[1];
                    hfProjectId.Value = ddlProject.SelectedValue.ToString();
                    ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + ddlProject.SelectedValue.ToString();

                    BindProjectInfoForm(DataUtils.GetInt(hfProjectId.Value));

                    //ProjectNames
                    dvNewProjectName.Visible = true;
                    //dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = true;
                    BindProjectNamesGrid();
                    cbAddProjectName.Checked = false;

                    //Address
                    dvNewAddress.Visible = true;
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = true;
                    BindAddressGrid();
                    cbAddAddress.Checked = false;

                    //Entity
                    dvNewEntity.Visible = true;
                    //dvEntity.Visible = false;
                    dvEntityGrid.Visible = true;
                    BindProjectEntityGrid();
                    cbAttachNewEntity.Checked = false;

                    //RelatedProjects
                    dvNewRelatedProjects.Visible = true;
                    //dvRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = true;
                    BindRelatedProjects(ddlRelatedProjects);
                    BindRelatedProjectsGrid();
                    cbRelatedProjects.Checked = false;

                    //ProjectStatus
                    dvNewProjectStatus.Visible = true;
                    //dvProjectStatus.Visible = false;
                    dvProjectStatusGrid.Visible = true;
                    BindLookUP(ddlProjectStatus, 4);
                    BindProjectStatusGrid();
                    cbAddProjectStatus.Checked = false;
                }
                else
                {
                    dvUpdate.Visible = false;

                    //ProjectNames
                    dvNewProjectName.Visible = false;
                    //dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = false;

                    //Address
                    dvNewAddress.Visible = false;
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = false;

                    //Entity
                    dvNewEntity.Visible = false;
                   // dvEntity.Visible = false;
                    dvEntityGrid.Visible = false;

                    //RelatedProjects
                    dvNewRelatedProjects.Visible = false;
                    //dvRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = false;

                    //ProjectStatus
                    dvNewProjectStatus.Visible = false;
                    //dvProjectStatus.Visible = false;
                    dvProjectStatusGrid.Visible = false;
                }

            }
            catch (Exception ex)
            {
                LogError(Pagename, "ProjectSelectionChanged", "", ex.Message);
            }
        }

        private void BindProjectNamesGrid()
        {
            try
            {
                DataTable dtProjectNames = ProjectMaintenanceData.GetProjectNames(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtProjectNames.Rows.Count > 1)
                {
                    dvProjectNamesGrid.Visible = true;
                    gvProjectNames.DataSource = dtProjectNames;
                    gvProjectNames.DataBind();
                }
                else
                {
                    dvProjectNamesGrid.Visible = false;
                    gvProjectNames.DataSource = null;
                    gvProjectNames.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectNamesGrid", "", ex.Message);
            }
        }

        private void BindAddressGrid()
        {
            try
            {
                DataTable dtAddress = ProjectMaintenanceData.GetProjectAddressList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtAddress.Rows.Count > 0)
                {
                    dvAddressGrid.Visible = true;
                    gvAddress.DataSource = dtAddress;
                    gvAddress.DataBind();
                }
                else
                {
                    dvAddressGrid.Visible = false;
                    gvAddress.DataSource = null;
                    gvAddress.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAddressGrid", "", ex.Message);
            }
        }

        private void BindProjectInfoForm(int ProjectId)
        {
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(ProjectId);
            PopulateDropDown(ddlProgram, drProjectDetails["LkProgram"].ToString());
            //PopulateDropDown(ddlAppStatus, drProjectDetails["LkAppStatus"].ToString());
            PopulateDropDown(ddlManager, drProjectDetails["Manager"].ToString());
            PopulateDropDown(ddlBoardDate, drProjectDetails["LkBoardDate"].ToString());
            PopulateDropDown(ddlPrimaryApplicant, drProjectDetails["AppNameId"].ToString());
            PopulateDropDown(ddlProjectType, drProjectDetails["LkProjectType"].ToString());

            txtProjectName.Text = drProjectDetails["projectName"].ToString();
            txtApplicationReceived.Text = drProjectDetails["AppRec"].ToString() == "" ? "" : Convert.ToDateTime(drProjectDetails["AppRec"].ToString()).ToShortDateString();
            txtClosingDate.Text = drProjectDetails["ClosingDate"].ToString() == "" ? "" : Convert.ToDateTime(drProjectDetails["ClosingDate"].ToString()).ToShortDateString();
            txtGrantExpirationDate.Text = drProjectDetails["ExpireDate"].ToString() == "" ? "" : Convert.ToDateTime(drProjectDetails["ExpireDate"].ToString()).ToShortDateString();
            cbVerified.Checked = DataUtils.GetBool(drProjectDetails["verified"].ToString());
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

        protected void rdBtnSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButtonSelectionChanged();
        }

        private void RadioButtonSelectionChanged()
        {
            ddlProject.SelectedIndex = -1;
            DisplayControlsbasedOnSelection();

            dvUpdate.Visible = false;

            //ProjectNames
            dvNewProjectName.Visible = false;
            //dvProjectName.Visible = false;
            dvProjectNamesGrid.Visible = false;

            //Address
            dvNewAddress.Visible = false;
            //dvAddress.Visible = false;
            dvAddressGrid.Visible = false;

            //Entity
            dvNewEntity.Visible = false;
            //dvEntity.Visible = false;
            dvEntityGrid.Visible = false;

            //RelatedProjects
            dvNewRelatedProjects.Visible = false;
            //dvRelatedProjects.Visible = false;
            dvRelatedProjectsGrid.Visible = false;

            //ProjectStatus
            dvNewProjectStatus.Visible = false;
            //dvProjectStatus.Visible = false;
            dvProjectStatusGrid.Visible = false;
        }

        private void DisplayControlsbasedOnSelection()
        {
            ClearForm();
            if (rdBtnSelection.SelectedValue.ToLower().Trim() == "new")
            {
                txtProjNum.Visible = true;
                ddlProject.Visible = false;
                btnProjectUpdate.Visible = false;
                dvSubmit.Visible = true;
                cbActiveOnly.Visible = false;
            }
            else
            {
                txtProjNum.Visible = false;
                ddlProject.Visible = true;
                btnProjectUpdate.Visible = true;
                dvSubmit.Visible = false;
                cbActiveOnly.Visible = true;
                cbActiveOnly.Checked = true;

                //ProjectNames
                dvNewProjectName.Visible = false;
               // dvProjectName.Visible = false;
                dvProjectNamesGrid.Visible = false;

                //Address
                dvNewAddress.Visible = false;
                //dvAddress.Visible = false;
                dvAddressGrid.Visible = false;

                //Entity
                dvNewEntity.Visible = false;
                //dvEntity.Visible = false;
                dvEntityGrid.Visible = false;

                //RelatedProjects
                dvNewRelatedProjects.Visible = false;
                //dvRelatedProjects.Visible = false;
                dvRelatedProjectsGrid.Visible = false;

                //ProjectStatus
                dvNewProjectStatus.Visible = false;
                //dvProjectStatus.Visible = false;
                dvProjectStatusGrid.Visible = false;
            }
        }

        protected void btnProjectSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsProjectInfoFormValid(false))
                {
                    AddProject ap = ProjectMaintenanceData.AddProject(txtProjNum.Text, DataUtils.GetInt(ddlProjectType.SelectedValue.ToString()), DataUtils.GetInt(ddlProgram.SelectedValue.ToString()),
                         DataUtils.GetDate(txtApplicationReceived.Text), DataUtils.GetInt(ddlManager.SelectedValue.ToString()),
                       DataUtils.GetInt(ddlBoardDate.SelectedValue.ToString()), DataUtils.GetDate(txtClosingDate.Text), DataUtils.GetDate(txtGrantExpirationDate.Text), cbVerified.Checked,
                        DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()), txtProjectName.Text);

                    if (ap.IsDuplicate)
                        LogMessage("Project already exist");
                    else
                    {
                        LogMessage("Project added successfully");
                        PopulateForm(ap.ProjectId);
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnProjectSubmit_Click", "", ex.Message);
            }
        }

        private void PopulateForm(int ProjectId)
        {
            ClearForm();
            BindProjects(ddlProject);
            rdBtnSelection.SelectedIndex = 1;
            RadioButtonSelectionChanged();
            ddlProject.SelectedValue = ProjectId.ToString();
            ProjectSelectionChanged();
        }

        protected void btnProjectUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsProjectInfoFormValid(true))
                {
                    ProjectMaintenanceData.UpdateProject((DataUtils.GetInt(hfProjectId.Value)), DataUtils.GetInt(ddlProjectType.SelectedValue.ToString()), DataUtils.GetInt(ddlProgram.SelectedValue.ToString()),
                     txtApplicationReceived.Text, DataUtils.GetInt(ddlManager.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBoardDate.SelectedValue.ToString()), txtClosingDate.Text, txtGrantExpirationDate.Text, cbVerified.Checked,
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()), txtProjectName.Text);

                    LogMessage("Project updated successfully");

                    ClearForm();
                    ddlProject.SelectedIndex = -1;

                    dvUpdate.Visible = false;

                    //ProjectNames
                    dvNewProjectName.Visible = false;
                    //dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = false;

                    //Address
                    dvNewAddress.Visible = false;
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = false;

                    //Entity
                    dvNewEntity.Visible = false;
                   // dvEntity.Visible = false;
                    dvEntityGrid.Visible = false;

                    //RelatedProjects
                    dvNewRelatedProjects.Visible = false;
                    //dvRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = false;

                    //ProjectStatus
                    dvNewProjectStatus.Visible = false;
                    //dvProjectStatus.Visible = false;
                    dvProjectStatusGrid.Visible = false;
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnProjectUpdate_Click", "", ex.Message);
            }
        }

        protected void btnAddProjectName_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsProjectNameFormValid())
                {
                    ProjectMaintenanceData.AddProjectName(DataUtils.GetInt(hfProjectId.Value), txtProject_Name.Text, cbDefName.Checked);

                    ClearProjectNameForm();
                   // dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = true;
                    cbAddProjectName.Checked = false;
                    BindProjectNamesGrid();
                    BindProjectInfoForm(DataUtils.GetInt(hfProjectId.Value));
                    LogMessage("Project name added successfully");
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        private bool IsProjectNameFormValid()
        {
            if (txtProject_Name.Text.Trim() == "")
            {
                LogMessage("Enter Project Name");
                txtProject_Name.Focus();
                return false;
            }

            return true;
        }

        private void ClearProjectNameForm()
        {
            txtProject_Name.Text = "";
            cbDefName.Checked = true;
        }

        //protected void cbProjectName_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbAddProjectName.Checked)
        //        dvProjectName.Visible = true;
        //    else
        //        dvProjectName.Visible = false;
        //}

        #region gvProjectNames
        protected void gvProjectNames_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectNames.EditIndex = e.NewEditIndex;
            BindProjectNamesGrid();
        }

        protected void gvProjectNames_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string projectName = ((TextBox)gvProjectNames.Rows[rowIndex].FindControl("txtDescription")).Text;
            int typeid = Convert.ToInt32(((Label)gvProjectNames.Rows[rowIndex].FindControl("lblTypeId")).Text);
            bool isDefName = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkDefNamePN")).Checked);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkActiveEditPN")).Checked); ;

            ProjectMaintenanceData.UpdateProjectname(DataUtils.GetInt(hfProjectId.Value), typeid, projectName, isDefName, RowIsActive);
            gvProjectNames.EditIndex = -1;

            BindProjectNamesGrid();
            BindProjectInfoForm(DataUtils.GetInt(hfProjectId.Value));
            LogMessage("Project Name updated successfully");
        }

        protected void gvProjectNames_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProjectNames.EditIndex = -1;
            BindProjectNamesGrid();
        }

        protected void gvProjectNames_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkDefNamePN = e.Row.FindControl("chkDefNamePN") as CheckBox;
                        CheckBox chkActiveEditPN = e.Row.FindControl("chkActiveEditPN") as CheckBox;

                        if (chkDefNamePN.Checked)
                        {
                            chkDefNamePN.Enabled = false;
                            chkActiveEditPN.Enabled = false;
                        }
                        else
                        {
                            chkDefNamePN.Enabled = true;
                            chkActiveEditPN.Enabled = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectNames_RowDataBound", "", ex.Message);
            }
        }

        #endregion

        //protected void cbAddAddress_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbAddAddress.Checked)
        //        dvAddress.Visible = true;
        //    else
        //        dvAddress.Visible = false;
        //}

        //protected void gvAddress_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvAddress.EditIndex = -1;
        //    BindAddressGrid();
        //}

        //protected void gvAddress_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvAddress.EditIndex = e.NewEditIndex;
        //    BindAddressGrid();
        //}

        //protected void gvAddress_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int rowIndex = e.RowIndex;
        //    string projectName = ((TextBox)gvProjectNames.Rows[rowIndex].FindControl("txtDescription")).Text;
        //    int typeid = Convert.ToInt32(((Label)gvProjectNames.Rows[rowIndex].FindControl("lblTypeId")).Text);
        //    bool isDefName = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkDefName")).Checked);

        //    gvAddress.EditIndex = -1;
        //    BindAddressGrid();
        //    LogMessage("Address updated successfully");
        //}

        protected void btnAddAddress_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsAddressValid())
                {
                    int ProjectId = DataUtils.GetInt(hfProjectId.Value);
                    string Village = this.hfVillage.Value;
                    var value = HttpContext.Current.Request.Form["ctl00$MainContent$ddlVillages"];

                    if (btnAddAddress.Text.ToLower() == "update")
                    {
                        int addressId = Convert.ToInt32(hfAddressId.Value);

                        ProjectMaintenanceData.UpdateProjectAddress(ProjectId, addressId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, Village,
                            txtState.Text, txtZip.Text, txtCounty.Text, DataUtils.GetDecimal(txtLattitude.Text), DataUtils.GetDecimal(txtLongitude.Text),
                            cbActive.Checked, cbDefaultAddress.Checked);

                        hfAddressId.Value = "";
                        btnAddAddress.Text = "Add";
                        LogMessage("Address updated successfully");
                    }
                    else //add
                    {
                        ProjectMaintenanceData.AddProjectAddress(ProjectId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, Village,
                            txtState.Text, txtZip.Text, txtCounty.Text, DataUtils.GetDecimal(txtLattitude.Text), DataUtils.GetDecimal(txtLongitude.Text),
                            cbActive.Checked, cbDefaultAddress.Checked);

                        btnAddAddress.Text = "Add";
                        LogMessage("New Address added successfully");
                    }

                    gvAddress.EditIndex = -1;
                    BindAddressGrid();
                    ClearAddressForm();
                    //dvAddress.Visible = false;
                    dvAddressGrid.Visible = true;
                    cbAddAddress.Checked = false;
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddAddress_Click", "", ex.Message);
            }
        }

        private void ClearAddressForm()
        {
            txtStreetNo.Text = "";
            txtAddress1.Text = "";
            txtAddress2.Text = "";
            txtTown.Text = "";
            txtState.Text = "";
            txtZip.Text = "";
            txtCounty.Text = "";
            txtLattitude.Text = "";
            txtLongitude.Text = "";
            cbActive.Checked = true;
            cbActive.Enabled = true;
            cbDefaultAddress.Checked = true;
            cbDefaultAddress.Enabled = true;
            ddlVillages.Items.Clear();
        }

        protected void gvAddress_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            //gvAddress.EditIndex = -1;
            //BindAddressGrid();
            cbAddAddress.Checked = false;

            ClearAddressForm();
            btnAddAddress.Text = "Add";
            //dvAddress.Visible = false;
            gvAddress.EditIndex = -1;
            BindAddressGrid();
        }

        protected void gvAddress_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            gvAddress.EditIndex = e.NewEditIndex;
            BindAddressGrid();
        }

        protected void gvAddress_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvAddress_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddAddress.Text = "Update";
                    //dvAddress.Visible = true;
                    cbAddAddress.Checked = true;
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[9].Controls[0].Visible = false;
                        Label lblAddressId = e.Row.FindControl("lblAddressId") as Label;
                        DataRow dr = ProjectMaintenanceData.GetProjectAddressDetailsById(DataUtils.GetInt(hfProjectId.Value), Convert.ToInt32(lblAddressId.Text));

                        hfAddressId.Value = lblAddressId.Text;

                        txtStreetNo.Text = dr["Street#"].ToString();
                        txtAddress1.Text = dr["Address1"].ToString();
                        txtAddress2.Text = dr["Address2"].ToString();
                        txtTown.Text = dr["Town"].ToString(); ;
                        txtState.Text = dr["State"].ToString();
                        txtZip.Text = dr["Zip"].ToString();
                        txtCounty.Text = dr["County"].ToString();
                        txtLattitude.Text = dr["latitude"].ToString();
                        txtLongitude.Text = dr["longitude"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbDefaultAddress.Checked = DataUtils.GetBool(dr["PrimaryAdd"].ToString());

                        ddlVillages.Items.Clear();
                        ddlVillages.DataSource = ProjectMaintenanceData.GetVillages(DataUtils.GetInt(dr["Zip"].ToString()));
                        ddlVillages.DataValueField = "village";
                        ddlVillages.DataTextField = "village";
                        ddlVillages.DataBind();
                        ddlVillages.Items.Insert(0, new ListItem("Select", ""));
                        PopulateDropDown(ddlVillages, dr["village"].ToString());

                        //ddlVillages.Items.Insert(0, dr["village"].ToString());
                        //this.hfVillage.Value = dr["village"].ToString();

                        if (cbDefaultAddress.Checked)
                        {
                            cbDefaultAddress.Enabled = false;
                            cbActive.Enabled = false;
                        }
                        else
                        {
                            cbDefaultAddress.Enabled = true;
                            cbActive.Enabled = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAddress_RowDataBound", "", ex.Message);
            }
        }

        protected void btnAddEntity_Click(object sender, EventArgs e)
        {
            if (IsProjectEntityFormValid())
            {
                bool isApplicant = false;

                if (ddlApplicantRole.SelectedItem.ToString() == "Primary Applicant" || ddlApplicantRole.SelectedItem.ToString() == "Secondary Applicant")
                    isApplicant = true;

                ProjectMaintenanceData.AddProjectApplicant(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlApplicantName.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlApplicantRole.SelectedValue.ToString()), isApplicant);

                ddlApplicantName.SelectedIndex = -1;

                LogMessage("Entity Attached Successfully");

                gvEntity.EditIndex = -1;
                BindProjectEntityGrid();
               // dvEntity.Visible = false;
                dvEntityGrid.Visible = true;
                cbAttachNewEntity.Checked = false;
            }
        }

        private bool IsProjectEntityFormValid()
        {

            if (ddlApplicantName.Items.Count > 1 && ddlApplicantName.SelectedIndex == 0)
            {
                LogMessage("Select Entity Applicant Name");
                ddlApplicantName.Focus();
                return false;
            }

            if (ddlApplicantRole.Items.Count > 1 && ddlApplicantRole.SelectedIndex == 0)
            {
                LogMessage("Select Applicant Role");
                ddlApplicantRole.Focus();
                return false;
            }
            return true;
        }

        private void BindProjectEntityGrid()
        {
            try
            {
                DataTable dtProjectEntity = ProjectMaintenanceData.GetProjectApplicantList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtProjectEntity.Rows.Count > 0)
                {
                    dvEntityGrid.Visible = true;
                    gvEntity.DataSource = dtProjectEntity;
                    gvEntity.DataBind();
                }
                else
                {
                    dvEntityGrid.Visible = false;
                    gvEntity.DataSource = null;
                    gvEntity.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectEntityGrid", "", ex.Message);
            }
        }

        //protected void cbAttachNewEntity_CheckedChanged(object sender, EventArgs e)
        //{
        //    BindLookUP(ddlApplicantRole, 56);
        //    if (cbAttachNewEntity.Checked)
        //        dvEntity.Visible = true;
        //    else
        //        dvEntity.Visible = false;
        //}

        protected bool IsProjectInfoFormValid(bool isUpdate)
        {
            if (isUpdate)
            {
                if (ddlProject.SelectedIndex == 0)
                {
                    LogMessage("Select Project Number");
                    ddlProject.Focus();
                    return false;
                }
            }
            else
            {
                if (txtProjNum.Text.Trim() == "____-___-___")
                {
                    LogMessage("Enter Project Number");
                    txtProjNum.Focus();
                    return false;
                }
                else
                {
                    string ProjectNumber = new string(txtProjNum.Text.Where(c => char.IsDigit(c)).ToArray());
                    if (ProjectNumber.Length != 10)
                    {
                        LogMessage("Enter Valid Project Number");
                        txtProjNum.Focus();
                        return false;
                    }
                }
            }
            if (txtProjectName.Text.Trim() == "")
            {
                LogMessage("Enter Project Name");
                txtProjectName.Focus();
                return false;
            }

            if (ddlPrimaryApplicant.Items.Count > 1 && ddlPrimaryApplicant.SelectedIndex == 0)
            {
                LogMessage("Select Primary Applicant");
                ddlPrimaryApplicant.Focus();
                return false;
            }

            if (ddlProgram.Items.Count > 1 && ddlProgram.SelectedIndex == 0)
            {
                LogMessage("Select Program");
                ddlProgram.Focus();
                return false;
            }

            if (ddlProjectType.Items.Count > 1 && ddlProjectType.SelectedIndex == 0)
            {
                LogMessage("Select Type");
                ddlProjectType.Focus();
                return false;
            }

            if (txtApplicationReceived.Text.Trim() == "")
            {
                LogMessage("Enter Application Rec'd Date");
                txtApplicationReceived.Focus();
                return false;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtApplicationReceived.Text.Trim()))
                {
                    LogMessage("Enter valid Application Rec'd Date");
                    txtApplicationReceived.Focus();
                    return false;
                }
            }

            if (txtClosingDate.Text.Trim() != "")
            {
                if (!DataUtils.IsDateTime(txtClosingDate.Text.Trim()))
                {
                    LogMessage("Enter valid Closing Date");
                    txtClosingDate.Focus();
                    return false;
                }
            }

            if (txtGrantExpirationDate.Text.Trim() != "")
            {
                if (!DataUtils.IsDateTime(txtGrantExpirationDate.Text.Trim()))
                {
                    LogMessage("Enter valid Closing Date");
                    txtGrantExpirationDate.Focus();
                    return false;
                }
            }
            return true;
        }

        protected void gvEntity_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEntity.EditIndex = -1;
            BindProjectEntityGrid();
        }

        protected void gvEntity_RowEditing(object sender, GridViewEditEventArgs e)
        {

            gvEntity.EditIndex = e.NewEditIndex;
            BindProjectEntityGrid();
        }

        protected void gvEntity_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectApplicantId = DataUtils.GetInt(((Label)gvEntity.Rows[rowIndex].FindControl("lblProjectApplicantID")).Text);
            bool isApplicant = Convert.ToBoolean(((CheckBox)gvEntity.Rows[rowIndex].FindControl("chkIsApplicant")).Checked);
            bool isFinLegal = Convert.ToBoolean(((CheckBox)gvEntity.Rows[rowIndex].FindControl("chkFinLegal")).Checked);
            int LkApplicantRole = DataUtils.GetInt(((DropDownList)gvEntity.Rows[rowIndex].FindControl("ddlLkApplicantRoleEntity")).SelectedValue.ToString());
            string LkApplicantRoleText = ((DropDownList)gvEntity.Rows[rowIndex].FindControl("ddlLkApplicantRoleEntity")).SelectedItem.ToString();
            bool isRowIsActive = Convert.ToBoolean(((CheckBox)gvEntity.Rows[rowIndex].FindControl("chkActiveEditEntity")).Checked);

            if (LkApplicantRoleText == "Primary Applicant" || LkApplicantRoleText == "Secondary Applicant")
                isApplicant = true;

            ProjectMaintenanceData.UpdateProjectApplicant(ProjectApplicantId, isApplicant, isFinLegal, LkApplicantRole, isRowIsActive);
            gvEntity.EditIndex = -1;

            BindProjectEntityGrid();

            LogMessage("Entity updated successfully");
        }

        protected void gvEntity_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlLkApplicantRoleEntity = (e.Row.FindControl("ddlLkApplicantRoleEntity") as DropDownList);
                    TextBox txtLkApplicantRoleEntity = (e.Row.FindControl("txtLkApplicantRoleEntity") as TextBox);
                    CheckBox chkIsApplicantEntity = e.Row.FindControl("chkIsApplicant") as CheckBox;
                    CheckBox chkActiveEditEntity = e.Row.FindControl("chkActiveEditEntity") as CheckBox;
                    
                    if (txtLkApplicantRoleEntity != null)
                    {
                        BindLookUP(ddlLkApplicantRoleEntity, 56);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlLkApplicantRoleEntity.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkApplicantRoleEntity.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlLkApplicantRoleEntity.ClearSelection();
                                item.Selected = true;
                            }
                        }

                        if (txtLkApplicantRoleEntity.Text.ToLower() == "358")
                        {
                            ddlLkApplicantRoleEntity.Enabled = false;
                            chkIsApplicantEntity.Enabled = false;
                            chkActiveEditEntity.Enabled = false;
                        }
                        else
                        {
                            ddlLkApplicantRoleEntity.Enabled = true;
                            chkIsApplicantEntity.Enabled = true;
                            chkActiveEditEntity.Enabled = true;
                            ddlLkApplicantRoleEntity.Items.Remove(ddlLkApplicantRoleEntity.Items.FindByValue("358"));
                        }
                    }
                }
            }
        }

        protected void btnAddRelatedProject_Click(object sender, EventArgs e)
        {
            if (IsRelatedProjectFormValid())
            {
                string[] tokens = ddlRelatedProjects.SelectedValue.ToString().Split('|');
                //txtProjectName.Text = tokens[1];

                if (hfProjectId.Value == tokens[0])
                {
                    LogMessage("Related Project can't be same Project");
                    return;
                }

                bool isDuplicate = ProjectMaintenanceData.AddRelatedProject(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(tokens[0]));

                if (!isDuplicate)
                {
                    LogMessage("New Related Project added successfully");

                    gvRelatedProjects.EditIndex = -1;
                    BindRelatedProjectsGrid();
                    ClearRelatedProjectsForm();
                    // dvRelatedProjects.Visible = false;
                    dvRelatedProjectsGrid.Visible = true;
                    cbRelatedProjects.Checked = false;
                }
                else
                {
                    LogMessage("Related Project already exist");
                }
            }
        }

        private bool IsRelatedProjectFormValid()
        {
            if (ddlRelatedProjects.Items.Count > 1 && ddlRelatedProjects.SelectedIndex == 0)
            {
                LogMessage("Select Related Project");
                ddlRelatedProjects.Focus();
                return false;
            }
            return true;
        }

        private void BindRelatedProjectsGrid()
        {
            try
            {
                DataTable dtRelatedProjects = ProjectMaintenanceData.GetRelatedProjectList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtRelatedProjects.Rows.Count > 0)
                {
                    dvRelatedProjectsGrid.Visible = true;
                    gvRelatedProjects.DataSource = dtRelatedProjects;
                    gvRelatedProjects.DataBind();
                }
                else
                {
                    dvRelatedProjectsGrid.Visible = false;
                    gvRelatedProjects.DataSource = null;
                    gvRelatedProjects.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindRelatedProjectsGrid", "", ex.Message);
            }
        }

        private void ClearRelatedProjectsForm()
        {
            ddlRelatedProjects.SelectedIndex = -1;
            txtRelatedProjectName.Text = "";
        }

        //protected void cbRelatedProjects_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbRelatedProjects.Checked)
        //        dvRelatedProjects.Visible = true;
        //    else
        //        dvRelatedProjects.Visible = false;
        //}

        //protected void ddlRelatedProjects_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    txtRelatedProjectName.Text = "";
        //    DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(ddlRelatedProjects.SelectedValue.ToString()));
        //    txtRelatedProjectName.Text = dr["ProjectName"].ToString();
        //}

        //protected void cbAddProjectStatus_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbAddProjectStatus.Checked)
        //        dvProjectStatus.Visible = true;
        //    else
        //        dvProjectStatus.Visible = false;
        //}

        protected void btnAddProjectStatus_Click(object sender, EventArgs e)
        {
            if (IsProjectStatusFormValid())
            {
                ProjectMaintenanceData.AddProjectStatus(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlProjectStatus.SelectedValue.ToString()), DataUtils.GetDate(txtStatusDate.Text));
                LogMessage("New Project Status added successfully");

                gvProjectStatus.EditIndex = -1;
                BindProjectStatusGrid();
                ClearProjectStatusForm();
               // dvProjectStatus.Visible = false;
                dvProjectStatusGrid.Visible = true;
                cbAddProjectStatus.Checked = false;
            }
        }

        private bool IsProjectStatusFormValid()
        {
            if (ddlProjectStatus.Items.Count > 1 && ddlProjectStatus.SelectedIndex == 0)
            {
                LogMessage("Select Project Status");
                ddlProjectStatus.Focus();
                return false;
            }

            if (txtStatusDate.Text.Trim() == "")
            {
                LogMessage("Enter Project Status Date");
                txtStatusDate.Focus();
                return false;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtStatusDate.Text.Trim()))
                {
                    LogMessage("Enter valid Project Status Date");
                    txtStatusDate.Focus();
                    return false;
                }
            }
            return true;
        }

        private void ClearProjectStatusForm()
        {
            ddlProjectStatus.SelectedIndex = -1;
            txtStatusDate.Text = "";
        }

        private void BindProjectStatusGrid()
        {
            try
            {
                DataTable dtProjectStatus = ProjectMaintenanceData.GetProjectStatusList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtProjectStatus.Rows.Count > 0)
                {
                    dvProjectStatusGrid.Visible = true;
                    gvProjectStatus.DataSource = dtProjectStatus;
                    gvProjectStatus.DataBind();
                }
                else
                {
                    dvProjectStatusGrid.Visible = false;
                    gvProjectStatus.DataSource = null;
                    gvProjectStatus.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectStatusGrid", "", ex.Message);
            }
        }

        protected bool IsAddressValid()
        {
            if (txtStreetNo.Text.Trim() == "")
            {
                LogMessage("Enter Street#");
                txtStreetNo.Focus();
                return false;
            }
            if (txtAddress1.Text.Trim() == "")
            {
                LogMessage("Enter Address1");
                txtAddress1.Focus();
                return false;
            }
            if (txtZip.Text.Trim() == "")
            {
                LogMessage("Enter Zip");
                txtZip.Focus();
                return false;
            }
            if (txtTown.Text.Trim() == "")
            {
                LogMessage("Enter Town");
                txtTown.Focus();
                return false;
            }
            if (txtState.Text.Trim() == "")
            {
                LogMessage("Enter State");
                txtState.Focus();
                return false;
            }
            return true;
        }

        protected void gvProjectStatus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProjectStatus.EditIndex = -1;
            BindProjectStatusGrid();

        }

        protected void gvProjectStatus_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectStatus.EditIndex = e.NewEditIndex;
            BindProjectStatusGrid();
        }

        protected void gvProjectStatus_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlProjectStatusPS = (e.Row.FindControl("ddlProjectStatusPS") as DropDownList);
                    TextBox txtLKProjStatusPS = (e.Row.FindControl("txtLKProjStatusPS") as TextBox);

                    if (txtLKProjStatusPS != null)
                    {
                        BindLookUP(ddlProjectStatusPS, 4);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlProjectStatusPS.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLKProjStatusPS.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlProjectStatusPS.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }

        protected void gvProjectStatus_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                int ProjectStatusId = DataUtils.GetInt(((Label)gvProjectStatus.Rows[rowIndex].FindControl("lblProjectStatusIDPS")).Text);
                int LKProjStatus = DataUtils.GetInt(((DropDownList)gvProjectStatus.Rows[rowIndex].FindControl("ddlProjectStatusPS")).SelectedValue.ToString());
                DateTime StatusDate = DataUtils.GetDate(((TextBox)gvProjectStatus.Rows[rowIndex].FindControl("txtStatusDatePS")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvProjectStatus.Rows[rowIndex].FindControl("chkActiveEditPS")).Checked);

                ProjectMaintenanceData.UpdateProjectStatus(ProjectStatusId, LKProjStatus, StatusDate, isActive);
                gvProjectStatus.EditIndex = -1;

                BindProjectStatusGrid();

                LogMessage("Status updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectStatus_RowUpdating", "", ex.Message);
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectName(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = Project.GetProjectName(prefixText);

            List<string> ProjNames = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNames.Add(dt.Rows[i][0].ToString());
            }
            return ProjNames.ToArray();
        }

        [WebMethod]
        public static bool LookupProduct()
        {
            return true;
        }

        [WebMethod]
        public static string BindDropdownlist(string zip)
        {
            DataTable dt = ProjectMaintenanceData.GetVillages(DataUtils.GetInt(zip));

            List<KeyVal> listVillages = new List<KeyVal>();

            KeyVal objKeyVal0 = new KeyVal();
            objKeyVal0.ID = "";
            objKeyVal0.Name = "Select";
            listVillages.Insert(0, objKeyVal0);

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    KeyVal objKeyVal = new KeyVal();
                    objKeyVal.ID = dt.Rows[i]["village"].ToString();
                    objKeyVal.Name = dt.Rows[i]["village"].ToString();
                    listVillages.Insert(i + 1, objKeyVal);

                    //liststudent.Add(dt.Rows[i]["village"].ToString());
                    //liststudent.Add("Ramakrishna");
                }

            }
            JavaScriptSerializer jscript = new JavaScriptSerializer();
            return jscript.Serialize(listVillages);
        }

        protected void gvRelatedProjects_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRelatedProjects.EditIndex = -1;
            BindRelatedProjectsGrid();
        }

        protected void gvRelatedProjects_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                int RelProjectId = DataUtils.GetInt(((Label)gvRelatedProjects.Rows[rowIndex].FindControl("lblRelProjectId")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvRelatedProjects.Rows[rowIndex].FindControl("chkActiveEditPR")).Checked);

                ProjectMaintenanceData.UpdateRelatedProject(DataUtils.GetInt(hfProjectId.Value), RelProjectId, isActive);

                gvRelatedProjects.EditIndex = -1;

                BindRelatedProjectsGrid();

                LogMessage("Related Projects updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvRelatedProjects_RowUpdating", "", ex.Message);
            }

        }

        protected void gvRelatedProjects_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRelatedProjects.EditIndex = e.NewEditIndex;
            BindRelatedProjectsGrid();
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            if (hfProjectId.Value == "") return;

            this.BindProjectNamesGrid();
            this.BindAddressGrid();
            this.BindProjectEntityGrid();
            this.BindProjectStatusGrid();
            this.BindRelatedProjectsGrid();
        }

        [WebMethod]
        public static bool IsProjectNumberExist(string ProjectNumber)
        {
            bool isExist = ProjectMaintenanceData.IsProjectNumberExist(ProjectNumber);

            return isExist;
        }
    }

    public class KeyVal
    {
        public string ID { get; set; }
        public string Name { get; set; }

    }
}