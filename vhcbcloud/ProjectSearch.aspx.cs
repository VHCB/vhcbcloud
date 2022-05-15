using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ProjectSearch : System.Web.UI.Page
    {
        string Pagename = "ProjectSearch";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            if (!IsPostBack)
            {
                Session["dtSearchResults"] = null;
                dvSearchResults.Visible = false;
                BindControls();
                //ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=";
                ProjectNotesSetUp();
                BindKeyStaff();
            }
            if (cbPrimaryApplicant.Checked)
                gvSearchresults.Columns[4].HeaderText = "Applicant Name";
            else
                gvSearchresults.Columns[4].HeaderText = "Entity Name";

            CheckNewProjectAccess();
        }

        private void ProjectNotesSetUp()
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));
            //if (ProjectNotesData.IsNotesExist(PageId))
            //    btnProjectNotes1.ImageUrl = "~/Images/currentpagenotes.png";

            ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"] +
                "&PageId=" + PageId;
        }

        private void BindControls()
        {
            BindLookUP(ddlProgram, 34);
            BindLookUP(ddlProjectType, 119);
            BindLookUP(ddlTargetYear, 2272);

            //BindPrimaryApplicants();
            BindProjectTowns();
            BindCounties();

            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            if (dr != null)
            {
                if (dr["dfltprg"].ToString() != "26170") //Skip Admin
                    PopulateDropDown(ddlProgram, dr["dfltprg"].ToString());
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

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
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

        //private void BindPrimaryApplicants()
        //{
        //    try
        //    {
        //        ddlPrimaryApplicant.Items.Clear();

        //        if (cbPrimaryApplicant.Checked)
        //            ddlPrimaryApplicant.DataSource = EntityData.GetApplicants("GetPrimaryApplicants");
        //        else
        //            ddlPrimaryApplicant.DataSource = EntityData.GetApplicants("GetApplicant");

        //        ddlPrimaryApplicant.DataValueField = "appnameid";
        //        ddlPrimaryApplicant.DataTextField = "Applicantname";
        //        ddlPrimaryApplicant.DataBind();
        //        ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindPrimaryApplicants", "", ex.Message);
        //    }
        //}

        private void BindProjectTowns()
        {
            try
            {
                ddlTown.Items.Clear();
                ddlTown.DataSource = Project.GetProjectTowns();
                ddlTown.DataValueField = "Town";
                ddlTown.DataTextField = "Town";
                ddlTown.DataBind();
                ddlTown.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProjectTowns", "", ex.Message);
            }
        }

        private void BindCounties()
        {
            try
            {
                ddlCounty.Items.Clear();
                ddlCounty.DataSource = Project.GetCounties();
                ddlCounty.DataValueField = "county";
                ddlCounty.DataTextField = "county";
                ddlCounty.DataBind();
                ddlCounty.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounties", "", ex.Message);
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

        protected void gvSearchresults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectProject")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                string ProjectId = ((Label)gvSearchresults.Rows[index].FindControl("lblProjectId")).Text;
                Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + ProjectId);
            }
        }

        protected void gvSearchresults_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;
            gvSearchresults.DataSource = SortDataTable((DataTable)Session["dtSearchResults"], false);
            gvSearchresults.DataBind();
            gvSearchresults.PageIndex = pageIndex;
        }

        //protected void cbPrimaryApplicant_CheckedChanged(object sender, EventArgs e)
        //{
        //    BindPrimaryApplicants();
        //}

        protected void btnProjectSearch_Click(object sender, EventArgs e)
        {
            string ddlMilestoneSelectedValue = HttpContext.Current.Request.Form["ctl00$MainContent$ddlMilestone"];

            dvSearchResults.Visible = true;
            DataTable dtSearchResults = ProjectSearchData.ProjectSearch(txtProjNum.Text, txtProjectName.Text.Replace("'", "''"), txtPrimaryApplicant.Text.Replace("'","''"),
                ddlProgram.SelectedValue.ToString(), ddlProjectType.SelectedValue.ToString(), ddlTown.SelectedValue.ToString(),
                ddlCounty.SelectedValue.ToString(), cbPrimaryApplicant.Checked, cbProjectActive.Checked, 
                ddlTargetYear.SelectedValue.ToString(), rbMilestone.SelectedValue, ddlMilestoneSelectedValue,
                txtMilestoneFromDate.Text, txtMilestoneToDate.Text, 
                Context.User.Identity.GetUserName(), ddlKeyStaff.SelectedValue.ToString());

            List<int> lstProjectId = new List<int>();
            Session["lstSearchResultProjectId"] = lstProjectId;
            foreach (DataRow dr in dtSearchResults.Rows)
            {
                lstProjectId.Add(DataUtils.GetInt(dr["ProjectId"].ToString()));
            }

            Session["lstSearchResultProjectId"] = lstProjectId;

            if (dtSearchResults.Rows.Count > 0 &&
                ((txtProjNum.Text.IndexOf('-', 0) > -1 && txtProjNum.Text.Length == 12) ||
                (txtProjNum.Text.IndexOf('-', 0) == -1 && txtProjNum.Text.Length == 10)))
                Response.Redirect("ProjectMaintenance.aspx?ProjectId=" + dtSearchResults.Rows[0]["ProjectId"].ToString());

            Session["dtSearchResults"] = dtSearchResults;
            lblSearcresultsCount.Text = dtSearchResults.Rows.Count.ToString();

            if (dtSearchResults.Rows.Count > 0 &&
                dtSearchResults.Rows.Count <= ProjectSearchData.GetSearchRecordCount())
            {
                ImgSearchResultReport.Visible = true;
            }
            else
                ImgSearchResultReport.Visible = false;

            gvSearchresults.DataSource = dtSearchResults;
            gvSearchresults.DataBind();

            if(ddlMilestoneSelectedValue != null)
                PopulateMilestone(rbMilestone.SelectedItem.ToString(), ddlMilestoneSelectedValue);
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

        protected void btnProjectClear_Click(object sender, EventArgs e)
        {
            dvSearchResults.Visible = false;
            txtProjNum.Text = "";
            txtProjectName.Text = "";
            txtPrimaryApplicant.Text = "";
            //ddlPrimaryApplicant.SelectedIndex = -1;
            cbPrimaryApplicant.Checked = true;
            ddlProgram.SelectedIndex = -1;
            ddlTown.SelectedIndex = -1;
            ddlCounty.SelectedIndex = -1;
            ddlProjectType.SelectedIndex = -1;
            cbProjectActive.Checked = true;
            ddlMilestone.SelectedIndex = -1;
            ddlMilestone.Items.Clear();
            rbMilestone.SelectedIndex = -1;
            txtMilestoneFromDate.Text = "";
            txtMilestoneToDate.Text = "";
            ddlTargetYear.SelectedIndex = -1;
            ddlKeyStaff.SelectedIndex = -1;
        }

        protected void gvSearchresults_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (cbPrimaryApplicant.Checked)
                    //    e.Row.Cells[4].Text = "Entity Name";
                    //else
                    //    e.Row.Cells[4].Text = "Applicant Name";

                    gvSearchresults.Columns[4].HeaderText = "Applicant Name";
                else
                    gvSearchresults.Columns[4].HeaderText = "Entity Name";

            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbers(prefixText);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetApplicants(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbers(prefixText);

            if (bool.Parse(contextKey))
                dt = EntityData.GetApplicantsEx("GetPrimaryApplicantsAutoEx", prefixText);
            else
                dt = EntityData.GetApplicantsEx("GetApplicantAutoEx", prefixText);

            List<string> Applicants = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //Applicants.Add("'" + dt.Rows[i][1].ToString() + "'");
                Applicants.Add(dt.Rows[i][1].ToString());
            }
            return Applicants.ToArray();

            //ddlPrimaryApplicant.DataValueField = "appnameid";
            //ddlPrimaryApplicant.DataTextField = "Applicantname";
            //ddlPrimaryApplicant.DataBind();
            //ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
        }

        private void CheckNewProjectAccess()
        {
            DataTable dt = new DataTable();
            dt = UserSecurityData.GetUserFxnSecurity(GetUserId());

            foreach (DataRow row in dt.Rows)
            {
                if (row["FxnID"].ToString() == "27454")
                    btnNewProject1.Enabled = true;
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

        //protected void rbMilestone_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    ddlMilestone.Enabled = true;

        //    if (rbMilestone.SelectedValue.ToLower().Trim() == "admin")
        //    {
        //        BindLookUP(ddlMilestone, 163);
        //    }
        //    else
        //    {
        //        if (ddlProgram.SelectedValue.ToString() == "NA")
        //            ddlMilestone.Enabled = false;
        //        else
        //            BindProgramMilestone();
        //    }
        //}

        private void BindProgramMilestone(string programvalue)
        {
            if (programvalue == "144") //Housing
                BindLookUP(ddlMilestone, 160);
            else if (programvalue == "145") //Conservation
                BindLookUP(ddlMilestone, 159);
            else if (programvalue == "148") //Viability
                BindLookUP(ddlMilestone, 162);
            else if (programvalue == "146") //Lead
                BindLookUP(ddlMilestone, 154);
            else if (programvalue == "147") //Americorps
                BindLookUP(ddlMilestone, 161);
            else
                ddlMilestone.Items.Clear();
        }

        //protected void ddlProgram_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlProgram.SelectedValue.ToString() != "NA")
        //        ddlMilestone.Enabled = true;

        //    if (rbMilestone.SelectedValue.ToLower().Trim() == "program")
        //    {
        //        BindProgramMilestone();
        //    }
        //}

        //[WebMethod]
        //public void PopulateMilestone()
        //{
        //    ddlMilestone.Enabled = true;

        //    if (rbMilestone.SelectedValue.ToLower().Trim() == "admin")
        //    {
        //        BindLookUP(ddlMilestone, 163);
        //    }
        //    else
        //    {
        //        if (ddlProgram.SelectedValue.ToString() == "NA")
        //            ddlMilestone.Enabled = false;
        //        else
        //            BindProgramMilestone();
        //    }

        //    //DataTable dt = ProjectMaintenanceData.GetVillages(DataUtils.GetInt(zip));

        //    //List<KeyVal> listVillages = new List<KeyVal>();

        //    //KeyVal objKeyVal0 = new KeyVal();
        //    //objKeyVal0.ID = "";
        //    //objKeyVal0.Name = "Select";
        //    //listVillages.Insert(0, objKeyVal0);

        //    //if (dt.Rows.Count > 0)
        //    //{
        //    //    for (int i = 0; i < dt.Rows.Count; i++)
        //    //    {
        //    //        KeyVal objKeyVal = new KeyVal();
        //    //        objKeyVal.ID = dt.Rows[i]["village"].ToString();
        //    //        objKeyVal.Name = dt.Rows[i]["village"].ToString();
        //    //        listVillages.Insert(i + 1, objKeyVal);
        //    //    }

        //    //}
        //    //JavaScriptSerializer jscript = new JavaScriptSerializer();
        //    //return jscript.Serialize(listVillages);
        //}

        private void PopulateMilestone(string rbMilestoneSelectedItem, string ddlMilestoneSelectedValue)
        {
            if (rbMilestoneSelectedItem.ToLower().Trim() == "admin")
            {
                BindLookUP(ddlMilestone, 163);
            }
            else
            {
                BindProgramMilestone(ddlProgram.SelectedValue);
            }

            if (ddlMilestoneSelectedValue != "NA")
                PopulateDropDown(ddlMilestone, ddlMilestoneSelectedValue);
        }

        [WebMethod]
        public static string PopulateMilestone(MileStoneInput input)
        {
            DataTable dt = null;

            if (input.MileStoneType.ToLower().Trim() == "admin")
            {
                dt = LookupValuesData.Getlookupvalues(163);
            }
            else
            {
                if (input.Programvalue.ToString() == "144") //Housing
                    dt = LookupValuesData.Getlookupvalues(160);
                else if (input.Programvalue.ToString() == "145") //Conservation
                    dt = LookupValuesData.Getlookupvalues(159);
                else if (input.Programvalue.ToString() == "148") //Viability
                    dt = LookupValuesData.Getlookupvalues(162);
                else if (input.Programvalue.ToString() == "146") //Lead
                    dt = LookupValuesData.Getlookupvalues(154);
                else if (input.Programvalue.ToString() == "147") //Americorps
                    dt = LookupValuesData.Getlookupvalues(161);
                else
                    dt = null;
            }

            List<KeyVal> listMileStones = new List<KeyVal>();

            KeyVal objKeyVal0 = new KeyVal();
            objKeyVal0.ID = "";
            objKeyVal0.Name = "Select";
            listMileStones.Insert(0, objKeyVal0);

            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    KeyVal objKeyVal = new KeyVal();
                    objKeyVal.ID = dt.Rows[i]["typeid"].ToString();
                    objKeyVal.Name = dt.Rows[i]["description"].ToString();
                    listMileStones.Insert(i + 1, objKeyVal);
                }
            }
            JavaScriptSerializer jscript = new JavaScriptSerializer();
            return jscript.Serialize(listMileStones);
        }

        protected void ImgSearchResultReport_Click(object sender, ImageClickEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetSerachResults(Context.User.Identity.GetUserName(), "Search Results"));
        }

        protected void BindKeyStaff()
        {
            try
            {
                ddlKeyStaff.Items.Clear();
                ddlKeyStaff.DataSource = LookupValuesData.GetManagers();
                ddlKeyStaff.DataValueField = "UserId";
                ddlKeyStaff.DataTextField = "Name";
                ddlKeyStaff.DataBind();
                ddlKeyStaff.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindKeyStaff", "", ex.Message);
            }
        }
    }
    public class MileStoneInput
    {
        public string MileStoneType { get; set; }
        public string Programvalue { get; set; }
    }
}