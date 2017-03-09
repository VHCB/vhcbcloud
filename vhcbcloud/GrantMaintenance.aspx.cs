using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vhcbcloud
{
    public partial class GrantMaintenance : System.Web.UI.Page
    {
        string Pagename = "GrantMaintenance";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnGrantSearch_Click(object sender, EventArgs e)
        {

        }
    }
}