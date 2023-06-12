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
                DataRow drPage1tDetails = ViabilityApplicationData.GetViabilityApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtFarmBusiness1.Text = drPage1tDetails["FarmBusiness1"].ToString();
                    txtFarmProduction2.Text = drPage1tDetails["FarmProduction2"].ToString();
                    txtProductsProduced3.Text = drPage1tDetails["ProductsProduced3"].ToString();
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

                ViabilityApplicationData.ViabilityApplicationPage7(projectNumber, txtFarmBusiness1.Text, txtFarmProduction2.Text, txtProductsProduced3.Text );

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