using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud.SetUp
{
    public partial class AccountSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {               
                PopulateSetUpDetails();
            }
        }

        private void PopulateSetUpDetails()
        {
            DataRow dr = SetupData.GetSetupData();
            txActEffDate.Text = dr["AcctEffectiveDate"].ToString();
            hfSetUpId.Value = dr["SetupID"].ToString();
        }
        protected void btnSetUpSubmit_Click(object sender, EventArgs e)
        {
            SetupData.UpdateAcctEffectiveDateSetup(DataUtils.GetInt(hfSetUpId.Value), DataUtils.GetDate(txActEffDate.Text));

            LogMessage("Setup details updated successfully");
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }
    }
}