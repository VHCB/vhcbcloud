using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Housing;

namespace vhcbcloud
{
    public partial class ResetTempApplication : System.Web.UI.Page
    {
        string Pagename = "ResetTempApplication";

        protected void Page_Load(object sender, EventArgs e)
        {
            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtProjNum, "OnBlur");
            txtProjNum.Attributes.Add("onblur", onBlurScript);
        }

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtProjNum.UniqueID && args == "OnBlur")
            {
                ddlyear.SelectedIndex = -1;
                ddlPortfolioType.SelectedIndex = -1;
                ddlPortfolioType.Items.Clear();
                PopulateYear();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtProjNum.Text != "")
            {
                int Year = DataUtils.GetInt(ddlyear.SelectedValue.ToString());
                int PortfolioTypeID = DataUtils.GetInt(ddlPortfolioType.SelectedValue.ToString());

                if (InactiveProjectData.ActivateTempProjectByProjectNum(txtProjNum.Text,Year, PortfolioTypeID))
                    LogMessage(String.Format("Project # {0} now ready for Modifications", txtProjNum.Text));
                else
                    LogMessage(String.Format("Project number {0} does not exist", txtProjNum.Text));
            }
            else
                LogMessage("Please enter Project #");
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

        private void PopulateYear()
        {
            try
            {
                ddlyear.Items.Clear();
                ddlyear.DataSource = PortfolioDataData.GetPortfolioYearsbyProj(txtProjNum.Text);
                ddlyear.DataValueField = "Year";
                ddlyear.DataTextField = "Year";
                ddlyear.DataBind();
                ddlyear.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "PopulateYear", "Control ID:" + ddlyear.ID, ex.Message);
            }

        }

        protected void ddlyear_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlPortfolioType.SelectedIndex = -1;
            ddlPortfolioType.Items.Clear();
            if (ddlyear.SelectedIndex != 0)
                PopulatePortfolioTypes();
        }

        private void PopulatePortfolioTypes()
        {
            try
            {
                ddlPortfolioType.Items.Clear();
                ddlPortfolioType.DataSource = PortfolioDataData.GetPopulatePortfolioTypesByProj(txtProjNum.Text, ddlyear.SelectedValue);
                ddlPortfolioType.DataValueField = "PortfolioTypeID";
                ddlPortfolioType.DataTextField = "PortfolioType";
                ddlPortfolioType.DataBind();
                ddlPortfolioType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "PopulatePortfolioTypes", "Control ID:" + ddlPortfolioType.ID, ex.Message);
            }
        }
        protected void ddlPortfolioType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}