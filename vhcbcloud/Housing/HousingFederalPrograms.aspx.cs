using DataAccessLayer;
using System;
using Microsoft.AspNet.Identity;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Housing;
using VHCBCommon.DataAccessLayer.Lead;

namespace vhcbcloud.Housing
{
    public partial class HousingFederalPrograms : System.Web.UI.Page
    {
        string Pagename = "HousingFederalPrograms";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"];
            }

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
                if (dr["URL"].ToString().Contains("HousingFederalPrograms.aspx"))
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

            int TotalHousingUnits = HousingFederalProgramsData.GetTotalHousingUnits(DataUtils.GetInt(hfProjectId.Value));
            TotalUnits.InnerText = TotalHousingUnits.ToString();
        }

        private void BindControls()
        {
            BindLookUP(ddlFederalProgram, 105);
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

        private void BindGrids()
        {
            BindFederalProgramsGrid();
        }

        #region Logs
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
        #endregion Logs

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected void AddFederalProgram_Click(object sender, EventArgs e)
        {
            HousingFederalProgramsResult objHousingFederalProgramsResult = HousingFederalProgramsData.AddProjectFederal(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlFederalProgram.SelectedValue.ToString()), DataUtils.GetInt(txtTotFedProgUnits.Text));

            BindGrids();
            ClearFederalProgramsForm();

            if (objHousingFederalProgramsResult.IsDuplicate && !objHousingFederalProgramsResult.IsActive)
                LogMessage("Program Setup already exist as in-active");
            else if (objHousingFederalProgramsResult.IsDuplicate)
                LogMessage("Program Setup already exist");
            else
                LogMessage("Program Setup added successfully");
        }

        protected void gvFedProgram_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFedProgram.EditIndex = e.NewEditIndex;
            BindFederalProgramsGrid();
        }

        protected void gvFedProgram_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFedProgram.EditIndex = -1;
            BindFederalProgramsGrid();
            ClearFederalProgramsForm();
        }

        private void ClearFederalProgramsForm()
        {
            cbAddFedProgram.Checked = false;
            ddlFederalProgram.SelectedIndex = -1;
            txtTotFedProgUnits.Text = "";
        }

        protected void rdBtnSelectFederalProgram_CheckedChanged(object sender, EventArgs e)
        {
            hfProjectFedProgram.Value = "";
            hfProjectFederalID.Value = "";
            dvFedProgramHome.Visible = false;

            hfProjectFederalID.Value = GetFederalProgramSelectedRecordID(gvFedProgram);

            if(hfProjectFedProgram.Value.ToLower() == "home")
            {
                dvFedProgramHome.Visible = true;
            }
        }

        private string GetFederalProgramSelectedRecordID(GridView gvFedProgram)
        {
            string ProjectFederalID = null;

            for (int i = 0; i < gvFedProgram.Rows.Count; i++)
            {
                RadioButton rdBtnFederalProgram = (RadioButton)gvFedProgram.Rows[i].Cells[0].FindControl("rdBtnSelectFederalProgram");
                if (rdBtnFederalProgram != null)
                {
                    if (rdBtnFederalProgram.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFedProgram.Rows[i].Cells[0].FindControl("HiddenProjectFederalID");
                        HiddenField hfFedProgram = (HiddenField)gvFedProgram.Rows[i].Cells[0].FindControl("HiddenFedProgram");

                        if (hf != null)
                        {
                            ProjectFederalID = hf.Value;
                            hfProjectFedProgram.Value = hfFedProgram.Value;
                        }
                        break;
                    }
                }
            }
            return ProjectFederalID;
        }

        protected void gvFedProgram_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ProjectFederalID = DataUtils.GetInt(((Label)gvFedProgram.Rows[rowIndex].FindControl("lblProjectFederalID")).Text);
            int NumUnits = DataUtils.GetInt(((TextBox)gvFedProgram.Rows[rowIndex].FindControl("txtNumUnits")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvFedProgram.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            HousingFederalProgramsData.UpdateProjectFederal(ProjectFederalID, NumUnits, RowIsActive);

            gvFedProgram.EditIndex = -1;

            BindFederalProgramsGrid();

            LogMessage("Program Setup updated successfully");
        }

        private void BindFederalProgramsGrid()
        {
            dvFedProgramHome.Visible = false;
            try
            {
                DataTable dt = HousingFederalProgramsData.GetProjectFederalList(DataUtils.GetInt(hfProjectFederalID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvFedProgramGrid.Visible = true;
                    gvFedProgram.DataSource = dt;
                    gvFedProgram.DataBind();
                }
                else
                {
                    dvFedProgramGrid.Visible = false;
                    gvFedProgram.DataSource = null;
                    gvFedProgram.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindFederalProgramsGrid", "", ex.Message);
            }
        }
    }
}