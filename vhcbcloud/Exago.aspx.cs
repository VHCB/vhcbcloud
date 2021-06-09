using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using WebReports.Api;
using WebReports.Api.Roles;

namespace vhcbcloud
{
    public partial class Exago : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string URL = string.Empty;
                Api api = new Api(@"/eWebReports");
                api.Action = wrApiAction.Home;

                WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("userId");
                parameter.Value = Context.User.Identity.Name;
                parameter.IsHidden = false;

                api.SetupData.StorageMgmtConfig.SetIdentity("userId", Context.User.Identity.Name);
                api.SetupData.StorageMgmtConfig.SetIdentity("companyId", "VHCB");
                api.SetupData.StorageMgmtConfig.SetIdentity("classId", "VHCB");
                api.SetupData.StorageMgmtConfig.SetIdentity("ownerId", "Dherman");

                WebReports.Api.Common.Parameter parameter1 = api.Parameters.GetParameter("companyId");
                parameter1.Value = "VHCB";
                parameter1.IsHidden = false;

                //WebReports.Api.Common.Parameter parameter2 = api.Parameters.GetParameter("ownerId");
                //parameter2.Value = "Dherman";
                //parameter2.IsHidden = false;

                DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);

                Role role = api.Roles.GetRole(dr["ExagoRole"].ToString());
                role.Activate();

                URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);

                StringBuilder sb = new StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.open('");
                sb.Append(URL);
                //sb.Append("');");
                //sb.Append("', '_blank', 'width=600,height=600');");
                sb.Append("', '_blank');");
                sb.Append("</script>");

                ClientScript.RegisterStartupScript(this.GetType(), "script", sb.ToString());

                //string url = "http://192.168.100.12/ewebreports/ExagoHome.aspx";
                //StringBuilder sb = new StringBuilder();
                //sb.Append("<script type = 'text/javascript'>");
                //sb.Append("window.open('");
                //sb.Append(url);
                //sb.Append("');");
                //sb.Append("</script>");
                //ClientScript.RegisterStartupScript(this.GetType(),
                //        "script", sb.ToString());
            }
        }
    }
}