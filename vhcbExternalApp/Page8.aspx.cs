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
                DataRow drPage1tDetails = ViabilityApplicationData.GetViabilityApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtFarmOwners4.Text = drPage1tDetails["FarmOwners4"].ToString();
                    txtSurfaceWaters5.Text = drPage1tDetails["SurfaceWaters5"].ToString();
                    txtMajorGoals6.Text = drPage1tDetails["MajorGoals6"].ToString();
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
            Response.Redirect("Page9.aspx");
        }
        protected void Save()
        {
            if (projectNumber != "")
            {

                ViabilityApplicationData.ViabilityApplicationPage8(projectNumber, txtFarmOwners4.Text, txtSurfaceWaters5.Text, txtMajorGoals6.Text);

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