using DataAccessLayer;
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

namespace ImpGrantApp
{
    public partial class ProjectDetails : System.Web.UI.Page
    {
        string Pagename = "ProjectDetails";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                BindCounty();
                BindCounty2();
                BindLookUP(ddlHearAbout, 215);
                LoadViabilityApplicationPage1();

            }
        }

        private void BindLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
        }

        private void BindCounty()
        {
            try
            {
                DataTable dt = ProjectMaintenanceData.GetCountys();

                ddlCounty.Items.Clear();
                ddlCounty.DataSource = dt;
                ddlCounty.DataValueField = "County";
                ddlCounty.DataTextField = "County";
                ddlCounty.DataBind();
                ddlCounty.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounty", "Control ID:" + ddlCounty.ID, ex.Message);
            }
        }
        private void BindCounty2()
        {
            try
            {
                DataTable dt = ProjectMaintenanceData.GetCountys();

                ddlPhyCounty.Items.Clear();
                ddlPhyCounty.DataSource = dt;
                ddlPhyCounty.DataValueField = "County";
                ddlPhyCounty.DataTextField = "County";
                ddlPhyCounty.DataBind();
                ddlPhyCounty.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounty", "Control ID:" + ddlCounty.ID, ex.Message);
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

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (projectNumber != "")
            {
                ImpGrantApplicationData.ViabilityImpGrantApplicationPage1(projectNumber, txtPrimaryContact.Text, txtOwners.Text,
                txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtCity.Text, txtZipCode.Text, txtVillage.Text, ddlCounty.SelectedValue,
                txtPhyStreet1.Text, txtPhyAddress1.Text, txtPhyAddress2.Text, txtPhyCity.Text, txtPhyZip.Text, txtPhyVillage.Text, ddlPhyCounty.SelectedValue,
                txtWorkPhone.Text, txtCellPhone.Text, txtHomePhone.Text, txtEmail.Text, DataUtils.GetInt(ddlHearAbout.SelectedValue));

                LogMessage("Viability Application Data Added Successfully");

                Response.Redirect("FarmBusinessInformation.aspx");
            }

        }

        private void LoadViabilityApplicationPage1()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ImpGrantApplicationData.GetViabilityImpGrantApplicationPage1(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtPrimaryContact.Text = drPage1tDetails["PrimContact"].ToString();
                    txtOwners.Text = drPage1tDetails["AllOwners"].ToString();
                    //rdBtnProjType.SelectedValue = getProjectType(drPage1tDetails["ProjType"].ToString());
                    //txtAddressName.Text = drPage1tDetails["MAContact"].ToString();
                    txtStreetNo.Text = drPage1tDetails["MAStreet"].ToString();
                    txtAddress1.Text = drPage1tDetails["MAAdd1"].ToString();
                    txtAddress2.Text = drPage1tDetails["MAAdd2"].ToString();
                    txtCity.Text = drPage1tDetails["MACity"].ToString();
                    txtZipCode.Text = drPage1tDetails["MAZip"].ToString();
                    txtVillage.Text = drPage1tDetails["MAVillage"].ToString();
                    PopulateDropDown(ddlCounty, drPage1tDetails["MACounty"].ToString());

                    txtPhyStreet1.Text = drPage1tDetails["PAStreet"].ToString();
                    txtPhyAddress1.Text = drPage1tDetails["PAAdd1"].ToString();
                    txtPhyAddress2.Text = drPage1tDetails["PAAdd2"].ToString();
                    txtPhyCity.Text = drPage1tDetails["PACity"].ToString();
                    txtPhyZip.Text = drPage1tDetails["PAZip"].ToString();
                    txtPhyVillage.Text = drPage1tDetails["PAVillage"].ToString();
                    PopulateDropDown(ddlPhyCounty, drPage1tDetails["PACounty"].ToString());

                    txtWorkPhone.Text = drPage1tDetails["WorkPhone"].ToString();
                    txtCellPhone.Text = drPage1tDetails["CellPhone"].ToString();
                    txtHomePhone.Text = drPage1tDetails["HomePhone"].ToString();
                    txtEmail.Text = drPage1tDetails["Email"].ToString();
                    //rdBtnPriorParticipation.SelectedValue = drPage1tDetails["PriorParticipation"].ToString();
                    //txtPrimeAdvisor.Text = drPage1tDetails["PrimeAdvisor"].ToString();
                    PopulateDropDown(ddlHearAbout, drPage1tDetails["HearAbout"].ToString());


                    //lblPrimeAdvisor.Visible = true;
                    //txtPrimeAdvisor.Visible = true;
                }
            }
        }

        private string getProjectType(string projType)
        {
            if (projType == "375")
                return "Farm Enterprise";
            else if (projType == "376")
                return "Food Enterprise";
            else if (projType == "377")
                return "Forest Landowner";
            else if (projType == "378")
                return "Forest Products Enterprise";
            else return "";
        }

        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue.Trim() == item.Value.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }


        protected void btnPrint_Click(object sender, EventArgs e)
        {
            ImpGrantApplicationData.InsertDefaultDataForImpGrants(projectNumber);

            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", GetExagoURL(projectNumber, "Online Application - Implementation Grant"));
        }

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

            ReportObject report = api.ReportObjectFactory.LoadFromRepository(@"Viability\" + ReportName);


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