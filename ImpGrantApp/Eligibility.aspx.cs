using DataAccessLayer;
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
    public partial class Eligibility : System.Web.UI.Page
    {
        string Pagename = "Eligibility";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
               
                BindLookUP(ddlAdvisorOrg, 2285);
                LoadEligibility();

            }
        }

        private void LoadEligibility()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ImpGrantApplicationData.GetEligibility(projectNumber);

                if (drPage1tDetails != null)
                {
                    //if (drPage1tDetails["CompletePlanning"].ToString() == "True")
                    //{
                    //    rdBtnCompletePlanning.SelectedIndex = 0;
                    //    lblCompletePlanningMessage.Visible = false;
                    //}
                    //else
                    //{
                    //    rdBtnCompletePlanning.SelectedIndex = 1;
                    //    lblCompletePlanningMessage.Visible = true;
                    //}

                    //    rdBtnCompletePlanning.SelectedValue = drPage1tDetails["CompletePlanning"].ToString();
                    txtPrimeAdvisor2.Text = drPage1tDetails["PrimeAdvisor2"].ToString();
                    PopulateDropDown(ddlAdvisorOrg, drPage1tDetails["AdvisorOrg"].ToString());
                    txtOtherAdvisor.Text = drPage1tDetails["OtherAdvisor"].ToString();
                }
            }
        }

        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue.Trim() == item.Text.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }
        private void BindLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
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

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("WaterQualityGrants.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Save();
            
            Response.Redirect("WaterQualityGrantsProgramPage4.aspx");
            //Response.Redirect("Page7.aspx");
        }

        private void Save()
        {
            if (projectNumber != "")
            {

                ImpGrantApplicationData.EligibilitySave(projectNumber, txtPrimeAdvisor2.Text, ddlAdvisorOrg.SelectedItem.Text, txtOtherAdvisor.Text);

                LogMessage("Eligibility Added Successfully");
            }
        }

        //protected void rdBtnCompletePlanning_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //    if (rdBtnCompletePlanning.SelectedValue.ToLower() == "yes")
        //    {
        //        lblCompletePlanningMessage.Visible = false;
        //    }
        //    else
        //    {
        //        lblCompletePlanningMessage.Visible = true;
        //    }
        //}
    }
}