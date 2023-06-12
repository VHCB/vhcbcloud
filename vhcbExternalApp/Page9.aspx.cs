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
    public partial class Page9 : System.Web.UI.Page
    {
        string Pagename = "Page9";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                LoadPage8();
            }
        }

        private void LoadPage8()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ViabilityApplicationData.GetViabilityApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtPositiveImpact7.Text = drPage1tDetails["PositiveImpact7"].ToString();
                    txtTechAdvisors8.Text = drPage1tDetails["TechAdvisors8"].ToString();
                    txtLongTermPlans9.Text = drPage1tDetails["LongTermPlans9"].ToString();
                    txtNoGrant10.Text = drPage1tDetails["NoGrant10"].ToString();
                    txtTimeline11.Text = drPage1tDetails["Timeline11"].ToString();
                    //txtNoContribution12.Text = drPage1tDetails["NoContribution12"].ToString();
                    txtNutrientManagementPlan13.Text = drPage1tDetails["NutrientManagementPlan13"].ToString();
                    txtPermits14.Text = drPage1tDetails["Permits14"].ToString();

                }
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("Page8.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("Page11.aspx");
        }

        protected void Save()
        {
            if (projectNumber != "")
            {

                ViabilityApplicationData.ViabilityApplicationPage9(projectNumber, txtPositiveImpact7.Text, txtTechAdvisors8.Text, txtLongTermPlans9.Text, txtNoGrant10.Text, 
                    txtTimeline11.Text, txtNutrientManagementPlan13.Text, txtPermits14.Text);

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

        protected void ddlGoto_SelectedIndexChanged(object sender, EventArgs e)
        {
            Save();
            Response.Redirect(ddlGoto.SelectedItem.Value);
        }
    }
}