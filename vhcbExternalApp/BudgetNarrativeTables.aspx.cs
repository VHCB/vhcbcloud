using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbExternalApp
{
    public partial class BudgetNarrativeTables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (CommonHelper.IsVPNConnected())
                //    UploadLink.HRef = "https://server3.vhcb.org:5001/sharing/hI0aFAloS";
                //else
                //    UploadLink.HRef = "https://server3.vhcb.org/sharing/hI0aFAloS";
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("WaterQualityGrantsProgramPage4.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Response.Redirect("Page6.aspx");
        }
    }
}