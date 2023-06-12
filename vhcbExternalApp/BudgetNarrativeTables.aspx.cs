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
                DataRow drPage1tDetails = ViabilityApplicationData.GetViabilityApplicationData(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtSupportingFunds.Text = drPage1tDetails["SupportingFunds"].ToString();
                    //txtNRCSExpensesandStatus.Text = drPage1tDetails["NRCSExpensesandStatus"].ToString();
                    txtWaverRequest.Text = drPage1tDetails["WaverRequest"].ToString();

                    rdBtnBMP.SelectedValue = drPage1tDetails["BMP"].ToString();

                    txtBMPYes.Text = drPage1tDetails["BMPYes"].ToString();

                    //txtBMPAmount.Text = drPage1tDetails["BMPAmount"].ToString();
                    //txtBMPGAN.Text = drPage1tDetails["BMPGAN"].ToString();

                    rdBtnCEAP.SelectedValue = drPage1tDetails["CEAP"].ToString();
                    txtCEAPYes.Text = drPage1tDetails["CEAPYes"].ToString();

                    //txtCEAPAmount.Text = drPage1tDetails["CEAPAmount"].ToString();
                    //txtCEAPGAN.Text = drPage1tDetails["CEAPGAN"].ToString();

                    rdBtnEQIP.SelectedValue = drPage1tDetails["EQIP"].ToString();
                    //txtEQIPAmount.Text = drPage1tDetails["EQIPAmount"].ToString();
                    //txtEQIPGAN.Text = drPage1tDetails["EQIPGAN"].ToString();
                    txtEQIPYes.Text = drPage1tDetails["EQIPYes"].ToString();

                    rdbtnOtherYN.SelectedValue = drPage1tDetails["OtherYN"].ToString();
                    txtOtherYes.Text = drPage1tDetails["OtherYes"].ToString();

                    //txtOtherPrograms.Text = drPage1tDetails["OtherPrograms"].ToString();
                    //txtOtherAmount.Text = drPage1tDetails["OtherAmount"].ToString();
                    //txtOtherOtherGAN.Text = drPage1tDetails["OtherGAN"].ToString();
                }
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("WaterQualityGrantsProgramPage4.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("Page7.aspx");
        }

        protected void saveData()
        {
            if (projectNumber != "")
            {
                string BMPYes = "";
                string CEAPYes = "";
                string EQIPYes = "";
                string OtherYes = "";

                //string BMPAmount = "";
                //string BMPGAN = "";
                if (rdBtnBMP.Text.ToLower() == "yes")
                {
                    BMPYes = txtBMPYes.Text;
                }

                //string CEAPAmount = "";
                //string CEAPGAN = "";
                if (rdBtnCEAP.Text.ToLower() == "yes")
                {
                    CEAPYes = txtCEAPYes.Text;
                }

                //string EQIPAmount = "";
                //string EQIPGAN = "";
                if (rdBtnEQIP.Text.ToLower() == "yes")
                {
                    EQIPYes = txtEQIPYes.Text;
                }

                //string OtherProgramss = "";
                //string OtherAmount = "";
                //string OtherGAN = "";
                if (rdbtnOtherYN.Text.ToLower() == "yes")
                {
                    OtherYes = txtOtherYes.Text;
                }



                ViabilityApplicationData.ViabilityApplicationPage6(projectNumber, txtSupportingFunds.Text, "", txtWaverRequest.Text, 
                    rdBtnBMP.Text, BMPYes, rdBtnCEAP.Text, CEAPYes, rdBtnEQIP.Text, EQIPYes, rdbtnOtherYN.Text, OtherYes);

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
            saveData();
            Response.Redirect(ddlGoto.SelectedItem.Value);
        }
    }
}