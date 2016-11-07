using System;
using System.Collections.Generic;
using System.Configuration;
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
            anchorId.HRef = Helper.GetExagoURL("6588", "Grid Project Address");
            anchorId1.HRef = Helper.GetExagoURL("6639", "Grid Project Address");
            //Response.Redirect(URL); 
        }

        //private string GetExagoURL(string ProjID, string ReportName)
        //{
        //    string URL = string.Empty;
        //    Api api = new Api(@"/eWebReports");

        //    Report report = (Report)api.ReportObjectFactory.LoadFromRepository(@"\Grid Reports\" + ReportName);
        //    report.ExportType = wrExportType.Html;
        //    report.ShowStatus = true;

        //    // Set the action to execute the report
        //    api.Action = wrApiAction.ExecuteReport;
        //    WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
        //    parameter.Value = ProjID;
        //    parameter.IsHidden = true;

        //    api.ReportObjectFactory.SaveToApi(report);
        //    URL = ConfigurationManager.AppSettings["ExagoURL"]+ api.GetUrlParamString("ExagoHome", true);
            
        //    return URL;
        //}

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                    "script", Helper.GetExagoURL("6588", "Grid Project Address"));
        }
    }
}