using DataAccessLayer;
using Microsoft.AspNet.Identity;
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
    public partial class EventMaintenance : System.Web.UI.Page
    {
        string Pagename = "EventMaintenance";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                BindControls();
               
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
        private void BindControls()
        {
            BindLookUP(ddlEventProgram, 34);
            BindProjects(ddlEventProject);
            BindLookUP(ddlEventSubCategory, 163);
            BindApplicantsForCurrentProject(ddlEventEntity);
            BindPrjectEventGrid();
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

        private void BindApplicantsForCurrentProject(DropDownList ddlEventEntity)
        {
            try
            {
                ddlEventEntity.Items.Clear();

                if((DataUtils.GetInt(hfProjectId.Value) == 0 ))
                ddlEventEntity.DataSource = ApplicantData.GetApplicants();
                else
                    ddlEventEntity.DataSource = ProjectMaintenanceData.GetCurrentProjectApplicants(DataUtils.GetInt(hfProjectId.Value));

                ddlEventEntity.DataValueField = "appnameid";
                ddlEventEntity.DataTextField = "applicantname";
                ddlEventEntity.DataBind();
                ddlEventEntity.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicantsForCurrentProject", "", ex.Message);
            }
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

        protected void btnAddProjectName_Click(object sender, EventArgs e)
        {

        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            if (IsProjectEventFormValid())
            {
                if (btnAddEvent.Text == "Add")
                {
                    ProjectMaintResult obProjectMaintResult = ProjectMaintenanceData.AddProjectEvent(DataUtils.GetInt(ddlEventProject.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlEventProgram.SelectedValue.ToString()), DataUtils.GetInt(ddlEventEntity.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlEvent.SelectedValue.ToString()), DataUtils.GetInt(ddlEventSubCategory.SelectedValue.ToString()),
                        DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, GetUserId());

                    ClearProjectEventForm();
                    cbAddProjectEvent.Checked = false;

                    BindPrjectEventGrid();

                    if (obProjectMaintResult.IsDuplicate && !obProjectMaintResult.IsActive)
                        LogMessage("Project Event already exist as in-active");
                    else if (obProjectMaintResult.IsDuplicate)
                        LogMessage("Project Event already exist");
                    else
                        LogMessage("New Project Milestone added successfully");
                }
                else
                {
                    ProjectMaintenanceData.UpdateProjectEvent(DataUtils.GetInt(hfProjectEventID.Value), DataUtils.GetInt(ddlEventProject.SelectedValue.ToString()),
                      DataUtils.GetInt(ddlEventProgram.SelectedValue.ToString()), DataUtils.GetInt(ddlEventEntity.SelectedValue.ToString()),
                      DataUtils.GetInt(ddlEvent.SelectedValue.ToString()), DataUtils.GetInt(ddlEventSubCategory.SelectedValue.ToString()),
                      DataUtils.GetDate(txtEventDate.Text), txtNotes.Text, GetUserId(), chkProjectEventActive.Checked);

                    gvProjectEvent.EditIndex = -1;
                    BindPrjectEventGrid();
                    ClearProjectEventForm();
                    btnAddEvent.Text = "Add";
                    LogMessage("Project Milestone Updated Successfully");
                }
            }
        }

        protected void ddlEventProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            EventProgramSelection();
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            this.BindPrjectEventGrid();
        }

        private void EventProgramSelection()
        {
            if (ddlEventProgram.SelectedItem.ToString() == "Admin")
                BindLookUP(ddlEvent, 157);
            else if (ddlEventProgram.SelectedItem.ToString() == "Housing")
                BindLookUP(ddlEvent, 160);
            else if (ddlEventProgram.SelectedItem.ToString() == "Conservation")
                BindLookUP(ddlEvent, 159);
            else if (ddlEventProgram.SelectedItem.ToString() == "Lead")
                BindLookUP(ddlEvent, 158);
            else if (ddlEventProgram.SelectedItem.ToString() == "Americorps")
                BindLookUP(ddlEvent, 161);
            else if (ddlEventProgram.SelectedItem.ToString() == "Viability")
                BindLookUP(ddlEvent, 162);
            //else if (ddlEventProgram.SelectedItem.ToString() == "Healthy Homes")
            //    BindLookUP(ddlEvent, 159);
            else
            {
                ddlEvent.Items.Clear();
                ddlEvent.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        private void ClearProjectEventForm()
        {
            cbAddProjectEvent.Checked = false;

            //SetEventProjectandProgram();
            ddlEventEntity.SelectedIndex = -1;
            ddlEvent.SelectedIndex = -1;
            ddlEventSubCategory.SelectedIndex = -1;
            txtEventDate.Text = "";
            txtNotes.Text = "";
            ddlEventProgram.Enabled = true;
            ddlEventProject.Enabled = true;
            chkProjectEventActive.Enabled = false;
        }

        private void BindPrjectEventGrid()
        {
            try
            {
                DataTable dtProjectEvents = ProjectMaintenanceData.GetProjectEventList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);
                Session["dtProjectEvents"] = dtProjectEvents;

                if (dtProjectEvents.Rows.Count > 0)
                {
                    dvProjectEventGrid.Visible = true;
                    gvProjectEvent.DataSource = dtProjectEvents;
                    gvProjectEvent.DataBind();
                }
                else
                {
                    dvProjectEventGrid.Visible = false;
                    gvProjectEvent.DataSource = null;
                    gvProjectEvent.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPrjectEventGrid", "", ex.Message);
            }
        }

        private bool IsProjectEventFormValid()
        {
            if (ddlEventProgram.Items.Count > 1 && ddlEventProgram.SelectedIndex == 0)
            {
                LogMessage("Select Event Program");
                ddlEventProgram.Focus();
                return false;
            }
            

            if (ddlEvent.Items.Count > 1 && ddlEvent.SelectedIndex == 0)
            {
                LogMessage("Select Event");
                ddlEvent.Focus();
                return false;
            }

            if (txtEventDate.Text.Trim() == "")
            {
                LogMessage("Enter Event Date");
                txtEventDate.Focus();
                return false;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtEventDate.Text.Trim()))
                {
                    LogMessage("Enter valid Event Date");
                    txtEventDate.Focus();
                    return false;
                }
            }
            return true;
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

        protected void ddlEventProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfProjectId.Value = "";
            if (ddlEventProject.SelectedIndex != 0)
            {
                hfProjectId.Value = ddlEventProject.SelectedValue.ToString();
            }

            BindApplicantsForCurrentProject(ddlEventEntity);
        }

        protected void gvProjectEvent_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectEvent.EditIndex = e.NewEditIndex;
            BindPrjectEventGrid();
        }

        protected void gvProjectEvent_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProjectEvent.EditIndex = -1;
            BindPrjectEventGrid();
            ClearProjectEventForm();
            hfProjectEventID.Value = "";
            btnAddEvent.Text = "Add";
            cbAddProjectEvent.Checked = false;
        }

        protected void gvProjectEvent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddEvent.Text = "Update";
                    cbAddProjectEvent.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[7].Controls[0].Visible = false;

                        Label lblProjectEventID = e.Row.FindControl("lblProjectEventID") as Label;
                        DataRow dr = ProjectMaintenanceData.GetProjectEventById(DataUtils.GetInt(lblProjectEventID.Text));

                        hfProjectEventID.Value = lblProjectEventID.Text;

                        PopulateDropDown(ddlEventProject, dr["ProjectID"].ToString());
                        PopulateDropDown(ddlEventProgram, dr["Prog"].ToString());
                        PopulateDropDown(ddlEventEntity, dr["ApplicantID"].ToString());
                        PopulateDropDown(ddlEvent, dr["EventID"].ToString());
                        PopulateDropDown(ddlEventSubCategory, dr["SubEventID"].ToString());
                        txtEventDate.Text = dr["Date"].ToString() == "" ? "" : Convert.ToDateTime(dr["Date"].ToString()).ToShortDateString();
                        txtNotes.Text = dr["Note"].ToString();
                        chkProjectEventActive.Enabled = true;

                        ddlEventProgram.Enabled = false;
                        ddlEventProject.Enabled = false;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAppraisalInfo_RowDataBound", "", ex.Message);
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

        protected void gvProjectEvent_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;
            gvProjectEvent.DataSource = SortDataTable((DataTable)Session["dtProjectEvents"], false);
            gvProjectEvent.DataBind();
            gvProjectEvent.PageIndex = pageIndex;
        }

        #region GridView Sorting Functions

        //======================================== GRIDVIEW EventHandlers END

        protected DataView SortDataTable(DataTable dataTable, bool isPageIndexChanging)
        {

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (GridViewSortExpression != string.Empty)
                {
                    if (isPageIndexChanging)
                    {
                        Session["SortExp"] = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
                        dataView.Sort = Session["SortExp"].ToString();
                    }
                    else
                    {
                        Session["SortExp"] = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());
                        dataView.Sort = Session["SortExp"].ToString();
                    }
                }
                return dataView;
            }
            else
            {
                return new DataView();
            }
        } //eof SortDataTable
        //===========================SORTING PROPERTIES START
        private string GridViewSortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        private string GridViewSortExpression
        {
            get { return ViewState["SortExpression"] as string ?? string.Empty; }
            set { ViewState["SortExpression"] = value; }
        }

        private string GetSortDirection()
        {
            switch (GridViewSortDirection)
            {
                case "ASC":
                    GridViewSortDirection = "DESC";
                    break;

                case "DESC":
                    GridViewSortDirection = "ASC";
                    break;
            }

            return GridViewSortDirection;
        }

        //===========================SORTING PROPERTIES END
        #endregion

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetPrimaryApplicant(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ApplicantData.GetSortedApplicants(prefixText);

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }
    }
}