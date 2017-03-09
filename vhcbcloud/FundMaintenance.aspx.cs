using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vhcbcloud
{
    public partial class FundMaintenance : System.Web.UI.Page
    {
        string Pagename = "FundMaintenance";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnFundSearch_Click(object sender, EventArgs e)
        {

        }
    }
}