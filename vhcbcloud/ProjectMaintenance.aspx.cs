using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
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
                BindControls();
                DisplayControlsbasedOnSelection();
            }
        }

        #region Bind Controls
        private void BindControls()
        {
            BindLookUP(ddlAppStatus, 83);
            BindLookUP(ddlProgram, 34);
            BindLookUP(ddlProjectType, 119);
            BindBoardDate();
            BindManagers();
            BindPrimaryApplicants();
            BindProjects();

        }

        protected void BindProjects()
        {
            try
            {
                ddlProject.Items.Clear();
                ddlProject.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddlProject.DataValueField = "project_id_name";
                ddlProject.DataTextField = "Proj_num";
                ddlProject.DataBind();
                ddlProject.Items.Insert(0, new ListItem("Select", "NA"));
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
                ddlBoardDate.DataTextField = "MeetingType";
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
            ddlAppStatus.SelectedIndex = -1;
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
            try
            {
                ClearForm();

                hfProjectId.Value = "";
                if (ddlProject.SelectedIndex != 0)
                {
                    string[] tokens = ddlProject.SelectedValue.ToString().Split('|');
                    txtProjectName.Text = tokens[1];
                    hfProjectId.Value = tokens[0];

                    BindProjectInfoForm(int.Parse(hfProjectId.Value));

                    //ProjectNames
                    dvNewProjectName.Visible = true;
                    dvProjectName.Visible = false;
                    dvProjectNamesGrid.Visible = true;
                    BindProjectNamesGrid();

                    //Address
                    dvNewAddress.Visible = true;
                    dvAddress.Visible = false;
                    dvAddressGrid.Visible = true;
                    BindAddressGrid();
                }

            }
            catch (Exception ex)
            {
                LogError(Pagename, "ddlProject_SelectedIndexChanged", "", ex.Message);
            }
        }

        private void BindProjectNamesGrid()
        {
            try
            {
                DataTable dtProjectNames = ProjectMaintenanceData.GetProjectNames(DataUtils.GetInt(hfProjectId.Value));

                if (dtProjectNames.Rows.Count > 1)
                {
                    dvProjectNamesGrid.Visible = true;
                    gvProjectNames.DataSource = dtProjectNames;
                    gvProjectNames.DataBind();
                }
                else
                    dvProjectNamesGrid.Visible = false;
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
                DataTable dtAddress = new DataTable(); //ProjectMaintenanceData.GetProjectNames(DataUtils.GetInt(hfProjectId.Value));

                if (dtAddress.Rows.Count > 1)
                {
                    dvAddressGrid.Visible = true;
                    gvAddress.DataSource = dtAddress;
                    gvAddress.DataBind();
                }
                else
                    dvAddressGrid.Visible = false;
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectNamesGrid", "", ex.Message);
            }
        }

        private void BindProjectInfoForm(int ProjectId)
        {
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(ProjectId);
            PopulateDropDown(ddlProgram, drProjectDetails["LkProgram"].ToString());
            PopulateDropDown(ddlAppStatus, drProjectDetails["LkAppStatus"].ToString());
            PopulateDropDown(ddlManager, drProjectDetails["Manager"].ToString());
            PopulateDropDown(ddlBoardDate, drProjectDetails["LkBoardDate"].ToString());
            PopulateDropDown(ddlPrimaryApplicant, drProjectDetails["AppNameId"].ToString());
            PopulateDropDown(ddlProjectType, drProjectDetails["LkProjectType"].ToString());

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
            ddlProject.SelectedIndex = -1;
            DisplayControlsbasedOnSelection();

            //ProjectNames
            dvNewProjectName.Visible = false;
            dvProjectName.Visible = false;
            dvProjectNamesGrid.Visible = false;

            //ProjectNames
            dvNewAddress.Visible = false;
            dvAddress.Visible = false;
            dvAddressGrid.Visible = false;
        }

        private void DisplayControlsbasedOnSelection()
        {
            ClearForm();
            if (rdBtnSelection.SelectedValue.ToLower().Trim() == "new")
            {
                txtProjNum.Visible = true;
                ddlProject.Visible = false;
                btnProjectUpdate.Visible = false;
                btnProjectSubmit.Visible = true;
            }
            else
            {
                txtProjNum.Visible = false;
                ddlProject.Visible = true;
                btnProjectUpdate.Visible = true;
                btnProjectSubmit.Visible = false;

                //ProjectNames
                dvNewProjectName.Visible = false;
                dvProjectName.Visible = false;
                dvProjectNamesGrid.Visible = false;

                //Address
                dvNewAddress.Visible = false;
                dvAddress.Visible = false;
                dvAddressGrid.Visible = false;
            }
        }

        protected void btnProjectSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string isDuplicate = ProjectMaintenanceData.AddProject(txtProjNum.Text, DataUtils.GetInt(ddlProjectType.SelectedValue.ToString()), DataUtils.GetInt(ddlProgram.SelectedValue.ToString()),
                     DateTime.Parse(txtApplicationReceived.Text), DataUtils.GetInt(ddlAppStatus.SelectedValue.ToString()), DataUtils.GetInt(ddlManager.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBoardDate.SelectedValue.ToString()), DateTime.Parse(txtClosingDate.Text), DateTime.Parse(txtGrantExpirationDate.Text), cbVerified.Checked,
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()), txtProjectName.Text);

                if (isDuplicate.ToLower() == "true")
                    LogMessage("Project already exist");
                else
                    LogMessage("Project added successfully");

                ClearForm();
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnProjectSubmit_Click", "", ex.Message);
            }
        }

        protected void btnProjectUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string[] tokens = ddlProject.SelectedValue.ToString().Split('|');
                txtProjectName.Text = tokens[1];

                ProjectMaintenanceData.UpdateProject(DataUtils.GetInt(tokens[0]), DataUtils.GetInt(ddlProjectType.SelectedValue.ToString()), DataUtils.GetInt(ddlProgram.SelectedValue.ToString()),
                     txtApplicationReceived.Text, DataUtils.GetInt(ddlAppStatus.SelectedValue.ToString()), DataUtils.GetInt(ddlManager.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBoardDate.SelectedValue.ToString()), txtClosingDate.Text, txtGrantExpirationDate.Text, cbVerified.Checked,
                    DataUtils.GetInt(ddlPrimaryApplicant.SelectedValue.ToString()), txtProjectName.Text);

                LogMessage("Project updated successfully");

                ClearForm();
                ddlProject.SelectedIndex = -1;

                //ProjectNames
                dvNewProjectName.Visible = false;
                dvProjectName.Visible = false;
                dvProjectNamesGrid.Visible = false;

                //Address
                dvNewAddress.Visible = false;
                dvAddress.Visible = false;
                dvAddressGrid.Visible = false;
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
                string[] tokens = ddlProject.SelectedValue.ToString().Split('|');

                ProjectMaintenanceData.AddProjectName(DataUtils.GetInt(tokens[0]), txtProject_Name.Text, cbDefName.Checked);

                ClearProjectNameForm();
                dvProjectName.Visible = false;
                dvProjectNamesGrid.Visible = true;
                cbAddProjectName.Checked = false;
                BindProjectNamesGrid();
                LogMessage("Project name added successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        private void ClearProjectNameForm()
        {
            txtProject_Name.Text = "";
            cbDefName.Checked = true;
        }

        protected void cbProjectName_CheckedChanged(object sender, EventArgs e)
        {
            if (cbAddProjectName.Checked)
                dvProjectName.Visible = true;
            else
                dvProjectName.Visible = false;
        }

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
            bool isDefName = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkDefName")).Checked);

            ProjectMaintenanceData.UpdateProjectname(typeid, projectName, isDefName);
            gvProjectNames.EditIndex = -1;

            BindProjectNamesGrid();

            LogMessage("Project Name updated successfully");
        }

        protected void gvProjectNames_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProjectNames.EditIndex = -1;
            BindProjectNamesGrid();
        }
        #endregion

        protected void cbAddAddress_CheckedChanged(object sender, EventArgs e)
        {
            if (cbAddAddress.Checked)
                dvAddress.Visible = true;
            else
                dvAddress.Visible = false;
        }

        private void ClearAddressForm()
        {
            
        }

        protected void gvAddress_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAddress.EditIndex = -1;
            BindAddressGrid();
        }

        protected void gvAddress_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAddress.EditIndex = e.NewEditIndex;
            BindAddressGrid();
        }

        protected void gvAddress_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string projectName = ((TextBox)gvProjectNames.Rows[rowIndex].FindControl("txtDescription")).Text;
            int typeid = Convert.ToInt32(((Label)gvProjectNames.Rows[rowIndex].FindControl("lblTypeId")).Text);
            bool isDefName = Convert.ToBoolean(((CheckBox)gvProjectNames.Rows[rowIndex].FindControl("chkDefName")).Checked);

            //ProjectMaintenanceData.UpdateProjectname(typeid, projectName, isDefName);
            gvAddress.EditIndex = -1;

            BindAddressGrid();

            LogMessage("Address updated successfully");
        }

        protected void btnAddAddress_Click(object sender, EventArgs e)
        {

        }
    }
}