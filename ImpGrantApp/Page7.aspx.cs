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
    public partial class Page7 : System.Web.UI.Page
    {
        string Pagename = "Page7";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                LoadPage7();
            }
        }

        private void LoadPage7()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ImpGrantApplicationData.GetViabilityImpGrantApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtBusinessOverview.Text = drPage1tDetails["BusinessOverview"].ToString();
                    txtProjectDesc.Text = drPage1tDetails["ProjectDesc"].ToString();
                    txtPlanCoordination.Text = drPage1tDetails["PlanCoordination"].ToString();
                }
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("BudgetNarrativeTables.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("Page8.aspx");
        }
        protected void Save()
        {
            if (projectNumber != "")
            {

                ImpGrantApplicationData.ViabilityImpGrantApplicationPage7(projectNumber, txtBusinessOverview.Text, txtProjectDesc.Text, txtPlanCoordination.Text );

                LogMessage("Farm Business Information Data Added Successfully");
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