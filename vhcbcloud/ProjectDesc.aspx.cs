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
    public partial class ProjectDesc : System.Web.UI.Page
    {
        string Pagename = "ProjectDesc";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg1.Text = "";

            if (!IsPostBack)
            {
                LoadProjectDesc();
            }
        }

        private void LoadProjectDesc()
        {
           txtDesc.Text =  ProjectMaintenanceData.GetProjectDesc(DataUtils.GetInt(Request.QueryString["ProjectId"]));
        }

        protected void btnSubmitDesc_Click(object sender, EventArgs e)
        {
            ProjectMaintenanceData.UpdateProjectDesc(DataUtils.GetInt(Request.QueryString["ProjectId"]), txtDesc.Text);

            LogMessage("Project Description Updated Successfully");
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
    }
}