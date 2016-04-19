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
    public partial class ProjectNotes : System.Web.UI.Page
    {
        string Pagename = "ProjectNotes";

        protected void Page_Load(object sender, EventArgs e)
        {
            String ProjectId = Request.QueryString["ProjectId"];

            ddlProject.Enabled = true;
            txtProjectName.Enabled = true;
            txtProjectNotesDate.Enabled = true;

            if (!IsPostBack)
            {
                BindControls();
                dvProjectNotesGrid.Visible = false;
                if (!string.IsNullOrWhiteSpace(ProjectId))
                {
                    ddlProject.SelectedValue = ProjectId;

                    DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(ProjectId));
                    txtProjectName.Text = dr["ProjectName"].ToString();

                    BindProjectNotesGrid();
                }
            }


        }

        private void BindControls()
        {
            BindLookUP(ddlCategory, 35);
            BindProjects(ddlProject);
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

        protected void BindProjects(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddList.DataValueField = "projectid"; // "project_id_name";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        protected void btnSubmitNotes_Click(object sender, EventArgs e)
        {
            if (btnSubmitNotes.Text.ToLower() == "submit")
            {
                ProjectNotesData.AddProjectNotes(DataUtils.GetInt(ddlProject.SelectedValue.ToString()), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()), 3,
                    txtNotes.Text, DataUtils.GetDate(txtProjectNotesDate.Text));
            }
            else
            {
                ProjectNotesData.UpdateProjectNotes(DataUtils.GetInt(hfProjectNotesId.Value), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()), txtNotes.Text);
                hfProjectNotesId.Value = "";
                gvProjectNotes.EditIndex = -1;

                btnSubmitNotes.Text = "Submit";
            }

            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = "";
            txtNotes.Text = "";
            BindProjectNotesGrid();
        }

        private void BindProjectNotesGrid()
        {
            DataTable dt = ProjectNotesData.GetProjectNotesList(DataUtils.GetInt(ddlProject.SelectedValue.ToString()));

            if (dt.Rows.Count > 0)
            {
                dvProjectNotesGrid.Visible = true;
                gvProjectNotes.DataSource = ProjectNotesData.GetProjectNotesList(DataUtils.GetInt(ddlProject.SelectedValue.ToString()));
                gvProjectNotes.DataBind();
            }
            else
            {
                dvProjectNotesGrid.Visible = false;
                gvProjectNotes.DataSource = null;
                gvProjectNotes.DataBind();
            }

        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = "";
            txtNotes.Text = "";
            txtProjectName.Text = "";

            if (ddlProject.SelectedIndex != -1)
            {
                DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(ddlProject.SelectedValue.ToString()));
                txtProjectName.Text = dr["ProjectName"].ToString();
            }

            BindProjectNotesGrid();
        }

        private void ClearForm()
        {
            ddlProject.SelectedIndex = -1;
            txtProjectName.Text = "";
            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = "";
            txtNotes.Text = "";
        }

        protected void gvProjectNotes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ddlProject.Enabled = true;
            txtProjectName.Enabled = true;
            txtProjectNotesDate.Enabled = true;
            btnSubmitNotes.Text = "Submit";

            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = "";
            txtNotes.Text = "";
            hfProjectNotesId.Value = "";

            gvProjectNotes.EditIndex = -1;
            BindProjectNotesGrid();
        }

        protected void gvProjectNotes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectNotes.EditIndex = e.NewEditIndex;
            BindProjectNotesGrid();
        }

        protected void gvProjectNotes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Label lblUserName = (Label)e.Row.FindControl("lbluserName");

                    if (lblUserName.Text.ToLower().Trim() != "aduffy")
                    {
                        LinkButton lnkEdit = (LinkButton)e.Row.FindControl("lnkEdit");
                        lnkEdit.Visible = false;
                    }
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        ddlProject.Enabled = false;
                        txtProjectName.Enabled = false;
                        txtProjectNotesDate.Enabled = false;

                        //e.Row.Cells[5].Controls[0].Visible = false;
                        btnSubmitNotes.Text = "Update";

                        Label lblProjectNotesID = e.Row.FindControl("lblProjectNotesID") as Label;
                        DataRow dr = ProjectNotesData.GetProjectNotesById(DataUtils.GetInt(lblProjectNotesID.Text));

                        hfProjectNotesId.Value = lblProjectNotesID.Text;

                        txtProjectNotesDate.Text = dr["Date"].ToString() == "" ? "" : Convert.ToDateTime(dr["Date"].ToString()).ToShortDateString();
                        txtNotes.Text= dr["Notes"].ToString();
                        ddlCategory.SelectedValue = dr["LKProjCategory"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAddress_RowDataBound", "", ex.Message);
            }
        }

        protected void gvProjectNotes_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }
    }
}