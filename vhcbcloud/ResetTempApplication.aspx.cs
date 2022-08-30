using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ResetTempApplication : System.Web.UI.Page
    {
        string Pagename = "ResetTempApplication";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtProjNum.Text != "")
            {
                if(InactiveProjectData.ActivateTempProjectByProjectNum(txtProjNum.Text))
                    LogMessage(String.Format("Project # {0} now ready for Modifications", txtProjNum.Text));
                else
                    LogMessage(String.Format("Project number {0} does not exist", txtProjNum.Text));
            }
            else
                LogMessage("Please enter Project #");
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
    }
}