using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace VHCBConservationFarm
{
    public partial class Page5 : System.Web.UI.Page
    {
        string Pagename = "FarmManagement";
        string projectNumber = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                BindControls();

                LoadPage();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlFarmSize, 2277);

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
        private void LoadPage()
        {
            if (projectNumber != "")
            {
                DataRow dr = ConservationApplicationData.GetFarmManagement(projectNumber);

                if (dr != null)
                {
                    PopulateDropDownByText(ddlFarmSize, dr["FarmSize"].ToString());
                    PopulateDropDownByText(ddlRAPCompliance, dr["RAPCompliance"].ToString());
                    txtRentedLand.Text = dr["RentedLand"].ToString();
                    txtFullTime.Text = dr["FullTime"].ToString();
                    txtPartTime.Text = dr["PartTime"].ToString();
                    txtGrossIncome.Text = Regex.Replace(dr["GrossIncome"].ToString(), "[^0-9a-zA-Z.]+", ""); 
                    txtGrossIncomeDescription.Text = dr["GrossIncomeDescription"].ToString();

                    txtFullTimeSeasonal.Text = dr["FullTimeSeasonal"].ToString();
                    txtPartTimeSeasonal.Text = dr["PartTimeSeasonal"].ToString();

                    if (DataUtils.GetBool(dr["WrittenLease"].ToString()))
                        rdbtWrittenLease.SelectedIndex = 0;
                    else
                        rdbtWrittenLease.SelectedIndex = 1;

                    if (DataUtils.GetBool(dr["CompletedBusinessPlan"].ToString()))
                    {
                        rdbtCompletedBusinessPlan.SelectedIndex = 0;
                        tblOptinalQuestions.Visible = false;
                    }
                    else
                    {
                        rdbtCompletedBusinessPlan.SelectedIndex = 1;
                        tblOptinalQuestions.Visible = true;
                    }

                        if (DataUtils.GetBool(dr["ShareBusinessPlan"].ToString()))
                        rdbtShareBusinessPlan.SelectedIndex = 0;
                    else
                        rdbtShareBusinessPlan.SelectedIndex = 1;

                    txtMitigateClimate.Text = dr["MitigateClimate"].ToString();

                    PopulateDropDown(ddlHEL, dr["HEL"].ToString());
                    PopulateDropDown(ddlNutrientPlan, dr["NutrientPlan"].ToString());
                    PopulateDropDown(ddlDumps, dr["Dumps"].ToString());

                    if (DataUtils.GetBool(dr["ExistingInfastructure"].ToString()))
                        rdbExistingInfrastructure.SelectedIndex = 0;
                    else
                        rdbExistingInfrastructure.SelectedIndex = 1;
                    txtInfrastructureDescription.Text = dr["InfrastuctureDescription"].ToString();
                    txtOtherConservationMeasures.Text = dr["OtherConservationMeasures"].ToString();
                    txtFarmOperation.Text = dr["FarmOperation"].ToString();

                    if (DataUtils.GetBool(dr["OtherTechnicalAdvisors"].ToString()))
                        rdbtOtherTechnicalAdvisors.SelectedIndex = 0;
                    else
                        rdbtOtherTechnicalAdvisors.SelectedIndex = 1;

                    if (DataUtils.GetBool(dr["CurrentBusinessPlan"].ToString()))
                        rdbtnCurrentBusinessPlan.SelectedIndex = 0;
                    else
                        rdbtnCurrentBusinessPlan.SelectedIndex = 1;


                    foreach (ListItem li in cblConservationMeasures.Items)
                    {
                        if (dr["ConservationMeasures"].ToString().Split(',').ToList().Contains(li.Text))
                        {
                            li.Selected = true;
                        }
                    }

                }
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("Page4.aspx");
        }

        private void saveData()
        {
            string conservationMeasuresList = string.Empty;

            foreach (ListItem listItem in cblConservationMeasures.Items)
            {
                if (listItem.Selected == true)
                {
                    if (conservationMeasuresList == string.Empty)
                    {
                        conservationMeasuresList = listItem.Text;
                    }
                    else
                    {
                        conservationMeasuresList = conservationMeasuresList + ',' + listItem.Text;
                    }
                }
            }


            ConservationApplicationData.FarmManagement(projectNumber, ddlFarmSize.SelectedItem.Text, ddlRAPCompliance.SelectedValue, DataUtils.GetDecimal(txtRentedLand.Text), DataUtils.GetDecimal(txtFullTime.Text), DataUtils.GetDecimal(txtPartTime.Text),
                txtGrossIncome.Text,
                txtGrossIncomeDescription.Text, DataUtils.GetBool(rdbtWrittenLease.SelectedValue), DataUtils.GetBool(rdbtCompletedBusinessPlan.SelectedValue),
                DataUtils.GetBool(rdbtShareBusinessPlan.SelectedValue), txtMitigateClimate.Text, ddlHEL.SelectedValue, ddlNutrientPlan.SelectedValue, ddlDumps.SelectedValue, DataUtils.GetBool(rdbExistingInfrastructure.SelectedValue),
                txtInfrastructureDescription.Text, conservationMeasuresList,
                txtOtherConservationMeasures.Text, txtFarmOperation.Text, DataUtils.GetBool(rdbtOtherTechnicalAdvisors.SelectedValue.Trim()), DataUtils.GetBool(rdbtnCurrentBusinessPlan.SelectedValue.Trim()), DataUtils.GetDecimal(txtFullTimeSeasonal.Text), DataUtils.GetDecimal(txtPartTimeSeasonal.Text));

            LogMessage("Conservation Application Data Added Successfully");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("WaterManagement.aspx");
        }
        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue.Trim() == item.Value.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }
        private void PopulateDropDownByText(DropDownList ddl, string DBSelectedText)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedText.Trim() == item.Text.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
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

        protected void rdbtCompletedBusinessPlan_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdbtCompletedBusinessPlan.SelectedValue.Trim() == "No")
                tblOptinalQuestions.Visible = true;
            else
                tblOptinalQuestions.Visible = false;
        }

        protected void ddlGoto_SelectedIndexChanged(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect(ddlGoto.SelectedItem.Value);
        }
    }
}