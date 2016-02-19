using VHCBCommon.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vhcbcloud.Account
{
    public partial class SetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PasswordSet_Click(object sender, EventArgs e)
        {
            AccountData.SetPassword(Session["UserId"].ToString(), password.Text);

            Response.Redirect("../BoardFinancialTransactions.aspx");
        }
    }
}