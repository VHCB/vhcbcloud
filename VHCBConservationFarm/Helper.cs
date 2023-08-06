using System.Web;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebReports.Api;
using WebReports.Api.Data;
using WebReports.Api.Reports;

namespace VHCBConservationFarm
{
    public static class Helper 
    {
        public static string GetExagoURL(string Projnum, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("Projnum");
            parameter.Value = Projnum;
            parameter.IsHidden = true;
           
            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Conservation\" + ReportName);

           
            if (report != null)
                api.ReportObjectFactory.SaveToApi(report);

            URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);

            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.open('");
            sb.Append(URL);
            sb.Append("', '_blank');");
            sb.Append("</script>");
            return sb.ToString();
        }
    }
}