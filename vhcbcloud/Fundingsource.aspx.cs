using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class Fundingsource : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                FundingSourceData.AddFSName(txtFName.Text);
            }
            catch (Exception ex)
            {
                
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}