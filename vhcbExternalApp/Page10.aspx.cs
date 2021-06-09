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
    public partial class Page10 : System.Web.UI.Page
    {
        string Pagename = "Page10";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                LoadPage10();
            }
        }

        private void LoadPage10()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ViabilityApplicationData.GetViabilityApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    if (DataUtils.GetBool(drPage1tDetails["Confident_Sharing"].ToString()))
                        rdBtnConfidentSharing.SelectedIndex = 0;
                    else
                        rdBtnConfidentSharing.SelectedIndex = 1;

                    if (drPage1tDetails["Confident_Funding"].ToString().ToLower() == "yes")
                        rdbtnConfidentFunding.SelectedIndex = 0;
                    else
                        rdbtnConfidentFunding.SelectedIndex = 1;

                    txtConfidentSignature.Text = drPage1tDetails["Confident_Signature"].ToString();
                    txtConfidentDate.Text = drPage1tDetails["Confident_Date"].ToString();
                   
                }
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("Page9.aspx");
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

                bool IsConfident_Sharing = rdBtnConfidentSharing.SelectedItem.Text == "Yes" ? true : false;

                ViabilityApplicationData.ViabilityApplicationPage10(projectNumber, IsConfident_Sharing, rdbtnConfidentFunding.SelectedItem.Text, txtConfidentSignature.Text, DataUtils.GetDate( txtConfidentDate.Text));

                LogMessage("Successfully Saved Data");
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