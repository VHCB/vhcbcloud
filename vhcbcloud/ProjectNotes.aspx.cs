using DataAccessLayer;
using System;
using System.Collections.Generic;
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
            String id = Request.QueryString["ProjectId"].ToString();

            if (!IsPostBack)
            {
                BindControls();
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
            string[] tokens = ddlProject.SelectedValue.ToString().Split('|');
            
            ProjectNotesData.AddProjectNotes(DataUtils.GetInt(tokens[0]), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()), 3, 
                txtNotes.Text, DataUtils.GetDate(txtProjectNotesDate.Text));
            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = "";
            txtNotes.Text = "";
            BindProjectNotesGrid();
        }

        private void BindProjectNotesGrid()
        {
            string[] tokens = ddlProject.SelectedValue.ToString().Split('|');

            gvProjectNotes.DataSource = ProjectNotesData.GetProjectNotesList(DataUtils.GetInt(tokens[0]));
            gvProjectNotes.DataBind();

        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = "";
            txtNotes.Text = "";
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
    }
}