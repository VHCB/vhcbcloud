using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbExternalApp
{
    public partial class WaterQualityGrantsProgramPage4 : System.Web.UI.Page
    {
        string Pagename = "WaterQualityGrantsProgramPage4";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                LoadGrantRequestPage();
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("WaterQualityGrants.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViabilityApplicationData.InsertGrantRequest(projectNumber, txtProjTitle.Text, txtProjDesc.Text,
                DataUtils.GetDecimal(txtProjCost.Text.Replace("$", "")),
                 DataUtils.GetDecimal(txtRequest.Text.Replace("$", "")), txtProjCost.Text, txtRequest.Text);

            LogMessage("Farm Business Information Data Added Successfully");

            Response.Redirect("BudgetNarrativeTables.aspx");
        }

        private void LoadGrantRequestPage()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ViabilityApplicationData.GetGrantRequest(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtProjTitle.Text = drPage1tDetails["ProjTitle"].ToString();
                    txtProjDesc.Text = drPage1tDetails["ProjDesc"].ToString();
                    txtRequest.Text = drPage1tDetails["Request"].ToString();
                    txtProjCost.Text = drPage1tDetails["ProjCost"].ToString();
                    
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
    }
}