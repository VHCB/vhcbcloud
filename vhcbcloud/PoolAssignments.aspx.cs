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
    public partial class PoolAssignments : System.Web.UI.Page
    {
        string Pagename = "LoanMaintenance";

        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtProjectNumDDL, "OnBlur");
            txtProjectNumDDL.Attributes.Add("onblur", onBlurScript);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);

            if (!IsPostBack)
            {
                BindPoolGrid();
            }
        }

        private void BindPoolGrid()
        {
            try
            {
                DataTable dtProjects = ProjectMaintenanceData.GetPoolProjects();
                    

                if (dtProjects.Rows.Count > 0)
                {
                    dvPoolsGrid.Visible = true;
                    gvPool.DataSource = dtProjects;
                    gvPool.DataBind();
                }
                else
                {
                    dvPoolsGrid.Visible = false;
                    gvPool.DataSource = null;
                    gvPool.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPoolGrid", "", ex.Message);
            }
        }

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtProjectNumDDL.UniqueID && args == "OnBlur")
            {
                ProjectSelectionChanged();
            }
        }

        private void ProjectSelectionChanged()
        {
            
            hfProjectId.Value = "";
            txtProjName.InnerHtml = "";

            if (txtProjectNumDDL.Text != "")
            {
                lblProjName.Visible = true;
                txtProjName.Visible = true;
                hfProjectId.Value = GetProjectID(txtProjectNumDDL.Text).ToString();
                DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
                txtProjName.InnerText = dr["ProjectName"].ToString();
                btnSubmit.Visible = true;
                cbPooled.Visible = true;
            }
            else
            {
                lblProjName.Visible = false;
                txtProjName.Visible = false;
                cbPooled.Visible = false;
                btnSubmit.Visible = false;
            }
        }

        private int GetProjectID(string ProjectNum)
        {
            return ProjectMaintenanceData.GetProjectId(ProjectNum);
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count)
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ProjectMaintenanceData.AddProjectToPool(Convert.ToInt32(hfProjectId.Value));
            
            BindPoolGrid();
            LogMessage("Project added to Pool!");
            txtProjectNumDDL.Text = "";
            ProjectSelectionChanged();
        }

        protected void gvPool_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvPool_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }


        protected void gvPool_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string lblprojectid = ((Label)gvPool.Rows[rowIndex].FindControl("lblprojectid")).Text.Trim();

                if (lblprojectid.ToString() != "")
                {
                    ProjectMaintenanceData.UpdatePoolProjectData(Convert.ToInt32(lblprojectid));

                    BindPoolGrid();

                    LogMessage("Project updated successfully!");
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}