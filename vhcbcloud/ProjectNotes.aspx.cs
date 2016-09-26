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
    public partial class ProjectNotes : System.Web.UI.Page
    {
        string Pagename = "ProjectNotes";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg1.Text = "";

            String ProjectId = Request.QueryString["ProjectId"];

            ddlProject.Enabled = true;
            txtProjectName.Enabled = true;
            txtProjectNotesDate.Enabled = true;

            if (!IsPostBack)
            {
                BindControls();
                txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
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
                lblErrorMsg1.Text = ex.Message;
            }
        }

        private void LogError(string pagename, string method, string message, string error)
        {
            dvMessage.Visible = true;
            if (message == "")
            {
                lblErrorMsg1.Text = Pagename + ": " + method + ": Error Message: " + error;
            }
            else
                lblErrorMsg1.Text = Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error;
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg1.Text = message;
        }

        protected void btnSubmitNotes_Click(object sender, EventArgs e)
        {
            if (IsProjectNotesValid(btnSubmitNotes.Text.ToLower()))
            {
                if (btnSubmitNotes.Text.ToLower() == "submit")
                {
                    ProjectNotesData.AddProjectNotes(DataUtils.GetInt(ddlProject.SelectedValue.ToString()), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()), 
                        Context.User.Identity.GetUserName().Trim(), txtNotes.Text, txtURL.Text, DataUtils.GetDate(txtProjectNotesDate.Text));
                }
                else
                {
                    ProjectNotesData.UpdateProjectNotes(DataUtils.GetInt(hfProjectNotesId.Value), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()), 
                        txtNotes.Text, txtURL.Text, cbActive.Checked);
                    hfProjectNotesId.Value = "";
                    gvProjectNotes.EditIndex = -1;

                    btnSubmitNotes.Text = "Submit";
                }

                ddlCategory.SelectedIndex = -1;
                txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
                txtNotes.Text = "";
                BindProjectNotesGrid();
            }
        }

        private bool IsProjectNotesValid(string Action)
        { 
            if (ddlProject.SelectedIndex == 0)
            {
                LogMessage("Select Project Number");
                ddlProject.Focus();
                return false;
            }

            if (ddlCategory.SelectedIndex == 0)
            {
                LogMessage("Select Category");
                ddlCategory.Focus();
                return false;
            }

            if (Action == "submit")
            {
                if (txtProjectNotesDate.Text.Trim() == "")
                {
                    LogMessage("Enter Date");
                    txtProjectNotesDate.Focus();
                    return false;
                }
                else
                {
                    if (!DataUtils.IsDateTime(txtProjectNotesDate.Text.Trim()))
                    {
                        LogMessage("Enter valid Date");
                        txtProjectNotesDate.Focus();
                        return false;
                    }
                    if (DataUtils.GetDate(txtProjectNotesDate.Text.Trim()) < DataUtils.GetDate(DateTime.Now.ToShortDateString()))
                    {
                        LogMessage("Date shouldn't be less than current date");
                        txtProjectNotesDate.Focus();
                        return false;
                    }
                }
            }
            if (txtNotes.Text.Trim() == "")
            {
                LogMessage("Enter Notes");
                txtNotes.Focus();
                return false;
            }

            return true;
        }

        private void BindProjectNotesGrid()
        {
            DataTable dt = ProjectNotesData.GetProjectNotesList(DataUtils.GetInt(ddlProject.SelectedValue.ToString()), cbActiveOnly.Checked);

            if (dt.Rows.Count > 0)
            {
                dvProjectNotesGrid.Visible = true;
                gvProjectNotes.DataSource = dt;
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
            txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
            txtNotes.Text = "";
            txtProjectName.Text = "";

            if (ddlProject.SelectedIndex != 0)
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
            txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
            txtNotes.Text = "";
            txtURL.Text = "";
        }

        protected void gvProjectNotes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ddlProject.Enabled = true;
            txtProjectName.Enabled = true;
            txtProjectNotesDate.Enabled = true;
            btnSubmitNotes.Text = "Submit";

            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
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

                    if (lblUserName.Text.ToLower().Trim() != Context.User.Identity.GetUserName().Trim())
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
                        txtNotes.Text = dr["Notes"].ToString();
                        txtURL.Text = dr["URL"].ToString();
                        ddlCategory.SelectedValue = dr["LKProjCategory"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindProjectNotesGrid();
        }
    }
}