using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace ImpGrantApp
{
    public partial class BudgetNarrativeTables : System.Web.UI.Page
    {
        string Pagename = "BudgetNarrativeTables";
        string projectNumber = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                LoadPage();
            }
        }

        private void LoadPage()
        {
            if (projectNumber != "")
            {
                //DataRow drPage1tDetails = ImpGrantApplicationData.GetViabilityImpGrantApplicationData(projectNumber);

                //if (drPage1tDetails != null)
                //{
                //    txtSupportingFunds.Text = drPage1tDetails["SupportingFunds"].ToString();
                //    //txtNRCSExpensesandStatus.Text = drPage1tDetails["NRCSExpensesandStatus"].ToString();
                //    //txtWaverRequest.Text = drPage1tDetails["WaverRequest"].ToString();
                //}
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            //Save();
            Response.Redirect("WaterQualityGrantsProgramPage4.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            //Save();
            Response.Redirect("Eligibility.aspx");
        }

        protected void Save()
        {
            if (projectNumber != "")
            {

                //ImpGrantApplicationData.ViabilityImpGrantApplicationPage6(projectNumber, txtSupportingFunds.Text);

                //LogMessage("Farm Business Information Data Added Successfully");
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
    }
}