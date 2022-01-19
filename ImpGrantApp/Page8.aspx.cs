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
    public partial class Page8 : System.Web.UI.Page
    {
        string Pagename = "Page8";
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
                DataRow drPage1tDetails = ImpGrantApplicationData.GetViabilityImpGrantApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtProjectOutcomes.Text = drPage1tDetails["ProjectOutcomes"].ToString();
                    txtProjectTimeline.Text = drPage1tDetails["ProjectTimeline"].ToString();
                    txtContingencies.Text = drPage1tDetails["Contingencies"].ToString();
                }
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("Page7.aspx");
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

                ImpGrantApplicationData.ViabilityImpGrantApplicationPage8(projectNumber, txtProjectOutcomes.Text, txtProjectTimeline.Text, txtContingencies.Text);

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