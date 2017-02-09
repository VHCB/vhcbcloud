using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Security;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public class VHCBBasePage: System.Web.UI.Page
    {
        protected override void OnInit(System.EventArgs e)
        {
            base.OnInit(e);
            CheckLogon();
        }



        private void CheckLogon()
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }
        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }
    }
}
