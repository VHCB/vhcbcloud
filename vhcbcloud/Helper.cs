﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebReports.Api;
using WebReports.Api.Reports;

namespace vhcbcloud
{
    public static class Helper
    {
        public static string GetExagoURL(string ProjID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            parameter.Value = ProjID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"\Grid Reports\" + ReportName);

            //report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            api.ReportObjectFactory.SaveToApi(report);
            URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);

            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.open('");
            sb.Append(URL);
            //sb.Append("');");
            //sb.Append("', '_blank', 'width=600,height=600');");
            sb.Append("', '_blank');");
            sb.Append("</script>");
            return sb.ToString();
        }

        public static string GetExagoURLLookup(string RecID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("RecID");
            parameter.Value = RecID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"\Grid Reports\" + ReportName);

            //report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            api.ReportObjectFactory.SaveToApi(report);
            URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);

            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.open('");
            sb.Append(URL);
            //sb.Append("');");
            //sb.Append("', '_blank', 'width=600,height=600');");
            sb.Append("', '_blank');");
            sb.Append("</script>");
            return sb.ToString();
        }

        public static string GetExagoURLForAwardSummary(string Projnum, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("Proj_num");
            parameter.Value = Projnum;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"\Grid Reports\" + ReportName);

            //report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            api.ReportObjectFactory.SaveToApi(report);
            URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);

            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.open('");
            sb.Append(URL);
            //sb.Append("');");
            //sb.Append("', '_blank', 'width=600,height=600');");
            sb.Append("', '_blank');");
            sb.Append("</script>");
            return sb.ToString();
        }
    }
}
