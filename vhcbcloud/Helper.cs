using System.Web;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebReports.Api;
using WebReports.Api.Data;
using WebReports.Api.Reports;
using System.Runtime.Remoting.Contexts;

namespace vhcbcloud
{
    public static class Helper
    {
        public static string GetExagoURL(string ProjID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            //string newConnString = "server=192.168.100.12;uid=pete;pwd=pete123!;database=VHCBsandbox";
            //DataSource ds = api.DataSources.GetDataSource("VHCBSandBox");
            //ds.DataConnStr = newConnString;

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            parameter.Value = ProjID;
            parameter.IsHidden = true;
            //api.SetupData.StorageMgmtConfig.Identity("dherman");
            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            //ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\Grid Project Names");
            //Report report = (Report)api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\Grid Project Names");

            //report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            if (report != null)
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

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("RecID");
            parameter.Value = RecID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

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

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("Projnum");
            parameter.Value = Projnum;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            //report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            if (report != null)
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

        public static string GetExagoURLForPCR(string ProjectCheckRequestID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("PCRID");
            parameter.Value = ProjectCheckRequestID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Financial\Check Request\" + ReportName);

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

        public static string GetExagoURLForDashBoard(string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            //string newConnString = "server=192.168.100.12;uid=pete;pwd=pete123!;database=VHCBsandbox";
            //DataSource ds = api.DataSources.GetDataSource("VHCBSandBox");
            //ds.DataConnStr = newConnString;

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            //WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            //parameter.Value = ProjID;
            //parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Organization\Dashboard\" + ReportName);

            report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            if (report != null)
                api.ReportObjectFactory.SaveToApi(report);

            URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);

            return URL;
        }

        public static string GetExagoURLForLoanSummary(string LoanId, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("LoanID");
            parameter.Value = LoanId;
            parameter.IsHidden = true;

            WebReports.Api.Common.Parameter parameter1 = api.Parameters.GetParameter("BeginDate");
            parameter1.Value = "01/01/1900";
            parameter1.IsHidden = true;

            WebReports.Api.Common.Parameter parameter2 = api.Parameters.GetParameter("EndDate");
            parameter2.Value = "01/01/2050";
            parameter2.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"\Financial Keepers\Loans\" + ReportName);

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

        public static string GetSerachResults(string userid, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("userId");
            parameter.Value = userid;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            report.ExportType = wrExportType.Excel;
            //report.ShowStatus = true;
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

        public static string GetExagoURLForProjectNotes(string ProjID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            //string newConnString = "server=192.168.100.12;uid=pete;pwd=pete123!;database=VHCBsandbox";
            //DataSource ds = api.DataSources.GetDataSource("VHCBSandBox");
            //ds.DataConnStr = newConnString;

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            parameter.Value = ProjID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            //report.ExportType = wrExportType.Html;
            //report.ShowStatus = true;
            if (report != null)
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

        public static string GetAttachedProjectsReport(string ApplicantID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ApplicantID");
            parameter.Value = ApplicantID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            report.ExportType = wrExportType.Excel;
            //report.ShowStatus = true;
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

        public static string GetAttachedProjectsReportPDF(string ApplicantID, string ReportName)
        {
            string URL = string.Empty;
            Api api = new Api(@"/eWebReports");

            DataSource ds = api.DataSources.GetDataSource("VHCB");
            ds.DataConnStr = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            // Set the action to execute the report
            api.Action = wrApiAction.ExecuteReport;
            WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ApplicantID");
            parameter.Value = ApplicantID;
            parameter.IsHidden = true;

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            report.ExportType = wrExportType.Pdf;
            //report.ShowStatus = true;
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
