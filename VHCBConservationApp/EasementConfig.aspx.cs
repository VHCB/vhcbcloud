using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using WebReports.Api;
using WebReports.Api.Reports;
using WebReports.Api.Scheduler;
using DataAccessLayer;
using NodaTime;
using System.Configuration;
using System.Text;
using WebReports.Api.Data;

namespace VHCBConservationApp
{
    public partial class EasementConfig : System.Web.UI.Page
    {

        string Pagename = "EasementConfig";
        string projectNumber = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                //BindControls();

                LoadPage();
                UploadLink.HRef = "https://server3.vhcb.org/sharing/iU3AC409A";
            }
        }

        private void LoadPage()
        {
            if (projectNumber != "")
            {
                DataRow dr = ConservationApplicationData.GetEasementConfig(projectNumber);

                if (dr != null)
                {
                    txtNumEase.Text = dr["NumEase"].ToString();
                    //txtEasementTerms.Text = dr["EasementTerms"].ToString();
                    txtBldgComplex.Text = dr["BldgComplex"].ToString();
                    txtSoleDiscretion.Text = dr["SoleDiscretion"].ToString();
                    txtFarmLabor.Text = dr["FarmLabor"].ToString();
                    txtSubdivision.Text = dr["Subdivision"].ToString();
                    txtCampRight.Text = dr["CampRight"].ToString();
                    txtEasementTermsOther.Text = dr["EasementTermsOther"].ToString();
                    cbBldgComplexChk.Checked = DataUtils.GetBool(dr["BldgComplexChk"].ToString());
                    if (!cbBldgComplexChk.Checked)
                        txtBldgComplex.Enabled = false;

                    cbSoleDiscretionChk.Checked = DataUtils.GetBool(dr["SoleDiscretionChk"].ToString());
                    if (!cbSoleDiscretionChk.Checked)
                        txtSoleDiscretion.Enabled = false;

                    cbFarmLaborChk.Checked = DataUtils.GetBool(dr["FarmLaborChk"].ToString());
                    if (!cbFarmLaborChk.Checked)
                        txtFarmLabor.Enabled = false;

                    cbSubdivisionChk.Checked = DataUtils.GetBool(dr["SubdivisionChk"].ToString());
                    if (!cbSubdivisionChk.Checked)
                        txtSubdivision.Enabled = false;

                    cbCampRightChk.Checked = DataUtils.GetBool(dr["CampRightChk"].ToString());
                    if (!cbCampRightChk.Checked)
                        txtCampRight.Enabled = false;

                    cbEasementTermsOtherChk.Checked = DataUtils.GetBool(dr["EasementTermsOtherChk"].ToString());
                    if (!cbEasementTermsOtherChk.Checked)
                        txtEasementTermsOther.Enabled = false;

                    txtEcoZone.Text = dr["EcoZone"].ToString();
                    txtWetlandZone.Text = dr["WetlandZone"].ToString();
                    txtRiparianZone.Text = dr["RiparianZone"].ToString();
                    txtArcheoZone.Text = dr["ArcheoZone"].ToString();
                    txtRiverEasement.Text = dr["RiverEasement"].ToString();
                    txtHistoricProvision.Text = dr["HistoricProvision"].ToString();
                    txtPublicAccessDesc.Text = dr["PublicAccess"].ToString();
                    txtEcoZoneAcres.Text = dr["EcoZoneAcres"].ToString();
                    txtWetlandZoneAcres.Text = dr["WetlandZoneAcres"].ToString();
                    txtRiparianZoneAcres.Text = dr["RiparianZoneAcres"].ToString();
                    txtArcheoZoneAcres.Text = dr["ArcheoZoneAcres"].ToString();
                    txtRiverEasementAcres.Text = dr["RiverEasementAcres"].ToString();
                    txtHistoricProvisionAcres.Text = dr["HistoricProvisionAcres"].ToString();
                    txtPublicAccess.Text = dr["PublicAccessDesc"].ToString();
                    txtEasementTermsOther2.Text = dr["EasementTermsOther2"].ToString();

                    cbEcoZoneChk.Checked = DataUtils.GetBool(dr["EcoZoneChk"].ToString());
                    if (!cbEcoZoneChk.Checked)
                    {
                        txtEcoZone.Enabled = false;
                        txtEcoZoneAcres.Enabled = false;
                    }

                    cbWetlandZoneChk.Checked = DataUtils.GetBool(dr["WetlandZoneChk"].ToString());
                    if (!cbWetlandZoneChk.Checked)
                    {
                        txtWetlandZone.Enabled = false;
                        txtWetlandZoneAcres.Enabled = false;
                    }

                    cbRiparianZoneChk.Checked = DataUtils.GetBool(dr["RiparianZoneChk"].ToString());
                    if (!cbRiparianZoneChk.Checked)
                    {
                        txtRiparianZone.Enabled = true;
                        txtRiparianZoneAcres.Enabled = true;
                    }

                    cbArcheoZoneChk.Checked = DataUtils.GetBool(dr["ArcheoZoneChk"].ToString());
                    if (!cbArcheoZoneChk.Checked)
                    {
                        txtArcheoZone.Enabled = false;
                        txtArcheoZoneAcres.Enabled = false;
                    }

                    cbRiverEasementChk.Checked = DataUtils.GetBool(dr["RiverEasementChk"].ToString());
                    if (!cbRiverEasementChk.Checked)
                    {
                        txtRiverEasement.Enabled = false;
                        txtRiverEasementAcres.Enabled = false;
                    }
                    cbHistoricProvisionChk.Checked = DataUtils.GetBool(dr["HistoricProvisionChk"].ToString());
                    if (!cbHistoricProvisionChk.Checked)
                    {
                        txtHistoricProvision.Enabled = false;
                        txtHistoricProvisionAcres.Enabled = false;
                    }

                    cbPublicAccessChk.Checked = DataUtils.GetBool(dr["PublicAccessChk"].ToString());
                    if (!cbPublicAccessChk.Checked)
                    {
                        txtPublicAccess.Enabled = false;
                        txtPublicAccessDesc.Enabled = false;
                    }

                    cbEasementTermsOther2Chk.Checked = DataUtils.GetBool(dr["EasementTermsOther2Chk"].ToString());
                    if (!cbEasementTermsOther2Chk.Checked)
                        txtEasementTermsOther2.Enabled = false;

                    txtConformancePlans.Text = dr["ConformancePlans"].ToString();
                    txtNoLeverage.Text = dr["NoLeverage"].ToString();
                    txtInformTowns.Text = dr["InformTowns"].ToString();
                    //PopulateDropDownByText(ddlPlanCommisionsInformed, dr["LetterSentTo"].ToString());

                    //txtLetterSentToOther.Text = dr["LetterSentToOther"].ToString();
                    txtEndorsements.Text = dr["Endorsements"].ToString();
                    txtDualGoals.Text = dr["DualGoals"].ToString();
                    txtClarification.Text = dr["Clarification"].ToString();

                    foreach (ListItem li in cblPlanCommisionsInformed.Items)
                    {
                        if (dr["LetterSentTo"].ToString().Split(',').ToList().Contains(li.Value))
                        {
                            li.Selected = true;
                        }
                    }
                }
            }
        }
        private void PopulateDropDownByText(DropDownList ddl, string DBSelectedText)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedText.Trim() == item.Text.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("WaterManagement.aspx");
        }

        private void saveData()
        {
            string LetterSentToList = string.Empty;

            foreach (ListItem listItem in cblPlanCommisionsInformed.Items)
            {
                if (listItem.Selected == true)
                {
                    if (LetterSentToList == string.Empty)
                    {
                        LetterSentToList = listItem.Value;
                    }
                    else
                    {
                        LetterSentToList = LetterSentToList + ',' + listItem.Value;
                    }
                }
            }

            ConservationApplicationData.EasementConfig(projectNumber, DataUtils.GetInt(txtNumEase.Text), "",
                cbBldgComplexChk.Checked, txtBldgComplex.Text, cbSoleDiscretionChk.Checked, txtSoleDiscretion.Text, cbFarmLaborChk.Checked, txtFarmLabor.Text, cbSubdivisionChk.Checked, txtSubdivision.Text, cbCampRightChk.Checked, txtCampRight.Text,
                cbEasementTermsOtherChk.Checked, txtEasementTermsOther.Text, cbEcoZoneChk.Checked, txtEcoZone.Text, DataUtils.GetDecimal(txtEcoZoneAcres.Text), cbWetlandZoneChk.Checked, txtWetlandZone.Text, DataUtils.GetDecimal(txtWetlandZoneAcres.Text),
                cbRiparianZoneChk.Checked, txtRiparianZone.Text, DataUtils.GetDecimal(txtRiparianZoneAcres.Text), cbArcheoZoneChk.Checked, txtArcheoZone.Text, DataUtils.GetDecimal(txtArcheoZoneAcres.Text),
                cbRiverEasementChk.Checked, txtRiverEasement.Text, DataUtils.GetDecimal(txtRiverEasementAcres.Text), cbHistoricProvisionChk.Checked, txtHistoricProvision.Text, DataUtils.GetDecimal(txtHistoricProvisionAcres.Text),
                cbPublicAccessChk.Checked, txtPublicAccessDesc.Text, DataUtils.GetDecimal(txtPublicAccess.Text), txtEasementTermsOther2.Text, cbEasementTermsOther2Chk.Checked, txtConformancePlans.Text, txtNoLeverage.Text,
                txtInformTowns.Text, LetterSentToList, "", txtEndorsements.Text, txtDualGoals.Text, txtClarification.Text);

            LogMessage("Conservation Application Data Added Successfully");

        }

        protected void btnNext_Click(object sender, EventArgs e)
        {

            if (projectNumber != "")
            {
                saveData();

                List<string> EmailList = ViabilityApplicationData.GetMailAddressesForPDFEmail(projectNumber).Rows.OfType<DataRow>().Select(dr => dr.Field<string>("EmailAddress")).ToList();

                if (EmailList.Count > 0)
                    GetExagoURLForReport(projectNumber, "Farm Conservation Online Application", EmailList);

                ViabilityApplicationData.SubmitApplication(projectNumber);

                LogMessage("Conservation Online Application Submitted Successfully");

                Response.Redirect("Login.aspx");
            }

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

            api.SetupData.StorageMgmtConfig.SetIdentity("userId", "Dherman");
            api.SetupData.StorageMgmtConfig.SetIdentity("companyId", "VHCB");

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Conservation\" + ReportName);

            //api.Action = wrApiAction.ExecuteReport;
            //WebReports.Api.Common.Parameter parameter = api.Parameters.GetParameter("ProjID");
            //parameter.Value = "10161";
            //parameter.IsHidden = true;
            //ReportName = "Grid Project Milestone";
            //ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Utility\Grid Reports\" + ReportName);

            if (report != null)
            {
                report.ExportType = wrExportType.Pdf;
                api.ReportObjectFactory.SaveToApi(report);
            }
            // URL = ConfigurationManager.AppSettings["ExagoURL"] + api.GetUrlParamString("ExagoHome", true);


            // Run-once, immediately save to disk
            string jobId;           // Use to retrieve schedule info later for editing
            int hostIdx;            // Assigned execution host id

            string subject = $"Online Conservation Application for Project ({Projnum})";

            ReportScheduleInfo newSchedule = new ReportScheduleInfoOnce()
            {
                ScheduleName = "Online Conservation Application",             // Schedule name
                ReportType = wrReportType.Advanced,            // Report type
                RangeStartDate = new LocalDate(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day),                   // Start date
                ScheduleTime = new LocalTime(DateTime.Now.Hour, DateTime.Now.Minute), // Start time
                SendReportInEmail = true,                             // Email or save
                EmailSubject = subject,
                EmailBody = "PDF of your Online Conservation Application"
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
        }
    }