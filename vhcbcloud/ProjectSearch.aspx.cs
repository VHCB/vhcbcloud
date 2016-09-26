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
                ifProjectNotes.Src = "ProjectNotes.aspx?ProjectId=";
            }
            if (cbPrimaryApplicant.Checked)
                gvSearchresults.Columns[4].HeaderText = "Applicant Name";
            else
                gvSearchresults.Columns[4].HeaderText = "Entity Name";
        }

        private void BindControls()
        {
            BindLookUP(ddlProgram, 34);
            BindLookUP(ddlProjectType, 119);
            BindPrimaryApplicants();
            BindProjectTowns();
            BindCounties();
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

        private void BindPrimaryApplicants()
        {
            try
            {
                ddlPrimaryApplicant.Items.Clear();

                if (cbPrimaryApplicant.Checked)
                    ddlPrimaryApplicant.DataSource = EntityData.GetApplicants("GetPrimaryApplicants");
                else
                    ddlPrimaryApplicant.DataSource = EntityData.GetApplicants("GetApplicant");

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

        protected void cbPrimaryApplicant_CheckedChanged(object sender, EventArgs e)
        {
            BindPrimaryApplicants();
        }

        protected void btnProjectSearch_Click(object sender, EventArgs e)
        {
            dvSearchResults.Visible = true;
            DataTable dtSearchResults = ProjectSearchData.ProjectSearch(txtProjNum.Text, txtProjectName.Text, ddlPrimaryApplicant.SelectedValue.ToString(),
                ddlProgram.SelectedValue.ToString(), ddlProjectType.SelectedValue.ToString(), ddlTown.SelectedValue.ToString(),
                ddlCounty.SelectedValue.ToString(), cbPrimaryApplicant.Checked);

            Session["dtSearchResults"] = dtSearchResults;
            lblSearcresultsCount.Text = dtSearchResults.Rows.Count.ToString();
            gvSearchresults.DataSource = dtSearchResults;
            gvSearchresults.DataBind();
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
            ddlPrimaryApplicant.SelectedIndex = -1;
            cbPrimaryApplicant.Checked = true;
            ddlProgram.SelectedIndex = -1;
            ddlTown.SelectedIndex = -1;
            ddlCounty.SelectedIndex = -1;
            ddlProjectType.SelectedIndex = -1;
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
    }
}