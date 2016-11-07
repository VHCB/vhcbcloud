using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebReports.Api;
using WebReports.Api.Reports;

namespace vhcbcloud
{
    public partial class TestExago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            anchorId.HRef = GetExagoURL("6588", "Grid Project Address");
            anchorId1.HRef = GetExagoURL("6639", "Grid Project Address");
            //Response.Redirect(URL);
        }

        private string GetExagoURL(string ProjID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            Report report = (Report)api.ReportObjectFactory.LoadFromRepository(@"\Grid Reports\" + ReportName);
            report.ExportType = wrExportType.Html;
            report.ShowStatus = true;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            parameter.Value = ProjID;
            parameter.IsHidden = true;

            api.ReportObjectFactory.SaveToApi(report);
            URL = "/ewebreports/" + api.GetUrlParamString("ExagoHome", true);
            
            return URL;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string url = GetExagoURL("6588", "Grid Project Address");
            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.open('");
            sb.Append(url);
            sb.Append("', '_blank');");
            sb.Append("</script>");
            ClientScript.RegisterStartupScript(this.GetType(),
                    "script", sb.ToString());
        }
    }
}