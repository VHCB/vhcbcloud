using DataAccessLayer;
using NodaTime;
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
using WebReports.Api.Data;
using WebReports.Api.Reports;
using WebReports.Api.Scheduler;

namespace vhcbExternalApp
{
    public partial class Page11 : System.Web.UI.Page
    {
        string Pagename = "Page11";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                if (CommonHelper.IsVPNConnected())
                    UploadLink.HRef = "https://server3.vhcb.org:5001/sharing/hI0aFAloS";
                else
                    UploadLink.HRef = "https://server3.vhcb.org/sharing/hI0aFAloS";
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (projectNumber != "")
            {
                DataRow drData = ViabilityApplicationData.CheckFullValidation(projectNumber);

                if (drData != null)
                {
                    if (drData["ProjTitle"].ToString() == "" || drData["ProjDesc"].ToString() == "" || drData["ProjCost"].ToString() == "0" || drData["Request"].ToString() == "0" ||
                        drData["Budget"].ToString() == "" || drData["FarmBusiness1"].ToString() == "" || drData["FarmProduction2"].ToString() == "" || drData["ProductsProduced3"].ToString() == "" ||
                        drData["FarmOwners4"].ToString() == "" || drData["SurfaceWaters5"].ToString() == "" || drData["MajorGoals6"].ToString() == "" || drData["PositiveImpact7"].ToString() == "" ||
                        drData["TechAdvisors8"].ToString() == "" || drData["LongTermPlans9"].ToString() == "" || drData["NoGrant10"].ToString() == "" || drData["Timeline11"].ToString() == "" ||
                        drData["NoContribution12"].ToString() == "" || drData["NutrientManagementPlan13"].ToString() == "" || drData["Permits14"].ToString() == "" ||
                        drData["Confident_Sharing"].ToString() == "" || drData["Confident_Funding"].ToString() == "" || drData["Confident_Signature"].ToString() == "" || drData["Confident_Date"].ToString() == ""
                        )
                        LogMessage("Missing required information, please check the application.");
                    else
                    {
                        ViabilityApplicationData.SubmitApplication(projectNumber);

                        LogMessage("Viability Application Submitted Successfully");

                        List<string> EmailList = ViabilityApplicationData.GetMailAddressesForPDFEmail(projectNumber).Rows.OfType<DataRow>().Select(dr => dr.Field<string>("EmailAddress")).ToList();

                        if(EmailList.Count > 0)
                        GetExagoURLForReport(projectNumber, "Online Application - emailed" , EmailList);
                    }
                }
                else
                {
                    LogMessage("Missing required information, please check the application.");
                }
            }
        }

        private void LogError(string pagename, string method, string message, string error)
        {
            dvMessage.Visible = true;
            if (message == "")
            {
                lblErrorMsg.Text = Pagename + ": " + method + ": Error Message: " + error;
            }
            else
                lblErrorMsg.Text = Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error;
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Page10.aspx");
        }

        protected void btnSaveExit_Click(object sender, EventArgs e)
        {
            Session["ProjectNumber"] = null;
            Response.Redirect("login.aspx");
        }

        public static void GetExagoURLForReport(string Projnum, string ReportName, List<string> EmailList)
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

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Viability\" + ReportName);

            //api.Action = wrApiAction.ExecuteReport;
            //WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            //parameter.Value = "10161";
            //parameter.IsHidden = true;
            //ReportName = "Grid Project Milestone";
            //ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            if (report != null)
                api.ReportObjectFactory.SaveToApi(report);
            // URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);


            // Run-once, immediately save to disk
            string jobId;           // Use to retrieve schedule info later for editing
            int hostIdx;            // Assigned execution host id

            string subject = $"Online Viability Application for Project ({Projnum})";

            ReportScheduleInfo newSchedule = new ReportScheduleInfoOnce()
            {
                ScheduleName = "Online Viability Application",             // Schedule name
                ReportType = wrReportType.Advanced,            // Report type
                RangeStartDate = new LocalDate(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day),                   // Start date
                ScheduleTime = new LocalTime(DateTime.Now.Hour, DateTime.Now.Minute), // Start time
                SendReportInEmail = true,                             // Email or save
                EmailSubject = subject,
                EmailBody = "PDF of your Online Viability Application"
            };
            newSchedule.EmailToList.AddRange(EmailList);

            //newSchedule.EmailToList.Add("dan@vhcb.org");
            //newSchedule.EmailToList.Add("aaron @vhcb.org");
            //newSchedule.EmailToList.Add("b.mcgavisk @vhcb.org");
            //newSchedule.EmailToList.Add("Marcy @vhcb.org");

            // Send to the scheduler; wrap in try/catch to handle exceptions
            try
            {
                api.ReportScheduler.AddReport(
                  new ReportSchedule(api.PageInfo) { ScheduleInfo = newSchedule }, out jobId, out hostIdx);
            }
            catch (Exception) { }
        }
    }
}