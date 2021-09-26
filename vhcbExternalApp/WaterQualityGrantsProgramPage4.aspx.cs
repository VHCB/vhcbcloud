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
            string strGrantMatch = "";
            string ENtGrantMatch = "";

            if (txtFederalGrant.Text != "")
            {
                strGrantMatch += "Federal Grant - " + txtFederalGrant.Text + ";";
                ENtGrantMatch += "26620-" + txtFederalGrant.Text.Replace("$", "").Replace(",", "") + ";";
            }
            if (txtStateGrant.Text != "")
            {
                strGrantMatch += "State Grant - " + txtStateGrant.Text + ";";
                ENtGrantMatch += "26621-" + txtStateGrant.Text.Replace("$", "").Replace(",", "") + ";";
            }
            if (txtLoan.Text != "")
            {
                strGrantMatch += "Loan - " + txtLoan.Text + ";";
                ENtGrantMatch += "26685-" + txtLoan.Text.Replace("$", "").Replace(",", "") + ";";
            }
            if (txtCash.Text != "")
            {
                strGrantMatch += "Cash - " + txtCash.Text + ";";
                ENtGrantMatch += "26686-" + txtCash.Text.Replace("$", "").Replace(",", "") + ";";
            }
            if (txtKind.Text != "")
            {
                strGrantMatch += "Kind - " + txtKind.Text + ";";
                ENtGrantMatch += "26687-" + txtKind.Text.Replace("$", "").Replace(",", "") + ";";
            }
            if (txtOther.Text != "")
            {
                strGrantMatch += "Other - " + txtOther.Text;
                ENtGrantMatch += "26688-" + txtOther.Text.Replace("$", "").Replace(",","") + ";";
            }

            ViabilityApplicationData.InsertGrantRequest(projectNumber, txtProjTitle.Text, txtProjDesc.Text,
                DataUtils.GetDecimal(txtProjCost.Text.Replace("$", "")),
                 DataUtils.GetDecimal(txtRequest.Text.Replace("$", "")), txtProjCost.Text, txtRequest.Text, strGrantMatch.TrimEnd(';'), ENtGrantMatch.TrimEnd(';'));

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
                    string GrantMatch = drPage1tDetails["GrantMatch"].ToString();

                    foreach(var grantMatchDetails in GrantMatch.Split(';').ToList())
                    {
                        var grant = grantMatchDetails.Split('-');
                            
                        if (grant[0].Trim() == "Federal Grant")
                            txtFederalGrant.Text = grant[1].Trim();
                        else if (grant[0].Trim() == "State Grant")
                            txtStateGrant.Text = grant[1].Trim();
                        else if (grant[0].Trim() == "Loan")
                            txtLoan.Text = grant[1].Trim();
                        else if (grant[0].Trim() == "Cash")
                            txtCash.Text = grant[1].Trim();
                        else if (grant[0].Trim() == "Kind")
                            txtKind.Text = grant[1].Trim();
                        else if (grant[0].Trim() == "Other")
                            txtOther.Text = grant[1].Trim();
                    }
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