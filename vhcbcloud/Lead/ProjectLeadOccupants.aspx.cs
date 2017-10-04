using DataAccessLayer;
using System;
using System.Data;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Lead;



namespace vhcbcloud.Lead
{
    public partial class ProjectLeadOccupants : System.Web.UI.Page
    {
        string Pagename = "ProjectLeadOccupants";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                Session["dtOccupantsList"] = null;
                PopulateProjectDetails();
                BindControls();
                BindGrids();
            }
            GetRoleAuth();
        }
        protected bool GetRoleAuth()
        {
            bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
            if (!checkAuth)
                RoleReadOnly();
            return checkAuth;
        }
        protected void RoleReadOnly()
        {
            btnSubmit.Visible = false;           
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
                if (dr["URL"].ToString().Contains("ProjectLeadOccupants.aspx"))
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

        private void BindControls()
        {
            BindBuildingNumbers();
            BindLookUP(ddlRace, 10);
            BindLookUP(ddlEthnicity, 149);
            BindLookUP(ddlAge, 156);
        }

        private void BindBuildingNumbers()
        {
            try
            {
                ddlBldgNumber.Items.Clear();
                ddlBldgNumber.DataSource = ProjectLeadOccupantsData.GetBuildingNumbers(DataUtils.GetInt(hfProjectId.Value));
                ddlBldgNumber.DataValueField = "LeadBldgID";
                ddlBldgNumber.DataTextField = "Building";
                ddlBldgNumber.DataBind();
                ddlBldgNumber.Items.Insert(0, new ListItem("Select", "NA"));
                
                //Unit Number Drop Down
                ddlUnitNumber.Items.Clear();
                ddlUnitNumber.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildingNumbers", "", ex.Message);
            }
        }

        protected void ddlBldgNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBuildingUnitNumbers(DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()));
        }

        private void BindBuildingUnitNumbers(int BuildingNo)
        {
            try
            {
                DataTable dt = ProjectLeadOccupantsData.GetBuildingUnitNumbers(BuildingNo);
                if (dt.Rows.Count > 0)
                {
                    ddlUnitNumber.Items.Clear();
                    ddlUnitNumber.DataSource = dt;
                    ddlUnitNumber.DataValueField = "LeadUnitID";
                    ddlUnitNumber.DataTextField = "Unit";
                    ddlUnitNumber.DataBind();
                    ddlUnitNumber.Items.Insert(0, new ListItem("Select", "NA"));
                }
                else
                {
                    ddlUnitNumber.Items.Clear();
                    ddlUnitNumber.Items.Insert(0, new ListItem("No Units Found", "NA"));
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildingNumbers", "", ex.Message);
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddlBldgNumber.SelectedIndex == 0)
            {
                LogMessage("Select Building #");
                ddlBldgNumber.Focus();
                return;
            }
            if (ddlUnitNumber.SelectedIndex == 0)
            {
                LogMessage("Select Unit #");
                ddlUnitNumber.Focus();
                return;
            }

            if (btnSubmit.Text == "Submit")
            {
                OccupantsResult objOccupantsResult = ProjectLeadOccupantsData.AddProjectLeadOccupants((DataUtils.GetInt(hfProjectId.Value)),
                    DataUtils.GetInt(ddlBldgNumber.SelectedValue.ToString()), DataUtils.GetInt(ddlUnitNumber.SelectedValue.ToString()),
                    txtOccupantName.Text, DataUtils.GetInt(ddlAge.SelectedValue.ToString()), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()));

                ClearOccupantForm();
                BindGrids();

                if (objOccupantsResult.IsDuplicate && !objOccupantsResult.IsActive)
                    LogMessage("Occupant Info already exist for tihs Bldg# and Unit# as in-active");
                else if (objOccupantsResult.IsDuplicate)
                    LogMessage("Occupant Info already exist for tihs Bldg# and Unit#");
                else
                    LogMessage("Occupant Info Added Successfully");
            }
            else
            {
                ProjectLeadOccupantsData.UpdateProjectLeadOccupants(DataUtils.GetInt(hfLeadOccupantID.Value), txtOccupantName.Text, DataUtils.GetInt(ddlAge.SelectedValue.ToString()), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), chkOccupantActive.Checked);
                //ProjectLeadBuildingsData.UpdateProjectLeadBldg((DataUtils.GetInt(hfLeadBldgID.Value)), DataUtils.GetInt(txtBldgnumber.Text), DataUtils.GetInt(ddlAddress.SelectedValue.ToString()),
                // DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlType.SelectedValue.ToString()), DataUtils.GetInt(txtLHCUnits.Text), cbFloodHazardArea.Checked, cbFloodInsurance.Checked,
                // DataUtils.GetInt(ddlverifiedBy.SelectedValue.ToString()), txtInsuredby.Text, DataUtils.GetInt(ddlHistoricStatus.SelectedValue.ToString()),
                // DataUtils.GetInt(ddlAppendixA.SelectedValue.ToString()), chkBldgActive.Checked);

                gvOccupant.EditIndex = -1;
                BindGrids();
                hfLeadOccupantID.Value = "";
                ClearOccupantForm();
                btnSubmit.Text = "Submit";

                LogMessage("Occupant Info Updated Successfully");
            }
        }

        private void ClearOccupantForm()
        {
            ddlBldgNumber.SelectedIndex = -1;
            ddlUnitNumber.SelectedIndex = -1;
            txtOccupantName.Text = "";
            ddlAge.SelectedIndex = -1;
            ddlEthnicity.SelectedIndex = -1;
            ddlRace.SelectedIndex = -1;

            ddlBldgNumber.Enabled = true;
            ddlUnitNumber.Enabled = true;

            chkOccupantActive.Checked = true;
            chkOccupantActive.Enabled = false;
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

        private void BindGrids()
        {
            BindOccupantsGrid();
        }

        private void BindOccupantsGrid()
        {
            try
            {
                DataTable dt = ProjectLeadOccupantsData.GetProjectLeadOccupantList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvOccupantGrid.Visible = true;
                    gvOccupant.DataSource = dt;
                    gvOccupant.DataBind();
                    Session["dtOccupantsList"] = dt;
                }
                else
                {
                    dvOccupantGrid.Visible = false;
                    gvOccupant.DataSource = null;
                    gvOccupant.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindOccupantsGrid", "", ex.Message);
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected void gvOccupant_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOccupant.EditIndex = e.NewEditIndex;
            BindOccupantsGrid();
        }

        protected void gvOccupant_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOccupant.EditIndex = -1;
            BindOccupantsGrid();
            ClearOccupantForm();
            hfLeadOccupantID.Value = "";
            btnSubmit.Text = "Submit";
        }

        protected void gvOccupant_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnSubmit.Text = "Update";
                    
                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[0].Visible = false;

                        Label lblLeadOccupantID = e.Row.FindControl("lblLeadOccupantID") as Label;
                        DataRow dr = ProjectLeadOccupantsData.GetProjectLeadOccupantById(DataUtils.GetInt(lblLeadOccupantID.Text));

                        hfLeadOccupantID.Value = lblLeadOccupantID.Text;

                        PopulateDropDown(ddlBldgNumber, dr["LeadBldgID"].ToString());
                        BindBuildingUnitNumbers(DataUtils.GetInt(dr["LeadBldgID"].ToString()));
                        PopulateDropDown(ddlUnitNumber, dr["LeadUnitID"].ToString());
                        PopulateDropDown(ddlAge, dr["LKAge"].ToString());
                        PopulateDropDown(ddlEthnicity, dr["LKEthnicity"].ToString());
                        PopulateDropDown(ddlRace, dr["LKRace"].ToString());
                        txtOccupantName.Text = dr["Name"].ToString();
                        chkOccupantActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());

                        ddlBldgNumber.Enabled = false;
                        ddlUnitNumber.Enabled = false;
                        chkOccupantActive.Enabled = true;

                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvOccupant_RowDataBound", "", ex.Message);
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

        protected void gvOccupant_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;
            gvOccupant.DataSource = SortDataTable((DataTable)Session["dtOccupantsList"], false);
            gvOccupant.DataBind();
            gvOccupant.PageIndex = pageIndex;
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
    }
}