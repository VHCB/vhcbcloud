using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class AddNewInactiveProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            InactiveProjectResult objInactiveProjectResult = InactiveProjectData.AddInactiveProject(txtprojectNumber.Text, txtLoginName.Text, txtPassword.Text, cbActive.Checked);

            if (objInactiveProjectResult.IsDuplicate)
                LogMessage("Project already exist");
           
            else
                LogMessage("New Project added successfully");
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtprojectNumber.Text = "";
            txtLoginName.Text = "";
            txtPassword.Text = "";
            cbActive.Checked = false;
        }
    }
}