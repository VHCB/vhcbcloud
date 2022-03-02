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

namespace ImpGrantApp
{
    public partial class FarmBusinessInformation : System.Web.UI.Page
    {
        string Pagename = "FarmBusinessInformation";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                BindLookUP1(cbOwnLandList, 169);
                BindLookUP(ddlFiscalyr, 76);
                
                LoadViabilityApplicationPage2();
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

        private void LoadViabilityApplicationPage2()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ImpGrantApplicationData.GetViabilityImpGrantApplicationPage2(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtOrgName.Text = drPage1tDetails["OrgName"].ToString();
                    txtWebsite.Text = drPage1tDetails["Website"].ToString();
                    string[] OrgStructure = drPage1tDetails["Org_Structure"].ToString().Split(':');

                    if (OrgStructure[0] == "Other (Specify)")
                    {
                        if(OrgStructure.Length > 1)
                        txtOrgStructureOther.Text = OrgStructure[1];
                    }

                    foreach (ListItem li in rdBtnOrgStructure.Items)
                    {
                        if (li.Value == OrgStructure[0])
                        {
                            li.Selected = true;
                        }
                    }

                    txtCows.Text = drPage1tDetails["Cows"].ToString();
                    txtHogs.Text = drPage1tDetails["Hogs"].ToString();
                    txtPoultry.Text = drPage1tDetails["Poultry"].ToString();
                    txtOtherNonDiaryFarms.Text = drPage1tDetails["Other"].ToString();
                    txtMilkedDaily.Text = drPage1tDetails["Milked_Daily"].ToString();
                    txtPrimaryAnimalTypes.Text = drPage1tDetails["Primary_Animals"].ToString();
                    txtHerd.Text = drPage1tDetails["Herd"].ToString();
                    txtRollingHerd.Text = drPage1tDetails["Rolling_Herd"].ToString();
                    txtMilkPounds.Text = drPage1tDetails["Milk_Pounds"].ToString();
                    txtAvgCullRate.Text = drPage1tDetails["Cull"].ToString();
                    txtSomaticCell.Text = drPage1tDetails["Somatic"].ToString();

                    foreach (ListItem li in lstMilkSold.Items)
                    {
                        if (drPage1tDetails["Milk_Sold"].ToString().Split(',').ToList().Contains(li.Value))
                        {
                            li.Selected = true;
                        }
                    }

                    txtAcresinProduction.Text = drPage1tDetails["AcresInProduction"].ToString();
                    txtAcresOwned.Text = drPage1tDetails["AcresOwned"].ToString();
                    txtAcresLeased.Text = drPage1tDetails["AcresLeased"].ToString();
                    txtPastureAcres.Text = drPage1tDetails["PastureAcres"].ToString();
                    //txtFiscalyr.Text = drPage1tDetails["FiscalYr"].ToString();
                    PopulateDropDown(ddlFiscalyr, drPage1tDetails["FiscalYr"].ToString());

                    txtGrossSales.Text = drPage1tDetails["GrossSales"].ToString();
                    txtNetIncome.Text = drPage1tDetails["Netincome"].ToString();
                    //txtGrossPayroll.Text = drPage1tDetails["GrossPayroll"].ToString();
                    //txtNetWorth.Text = drPage1tDetails["Networth"].ToString();
                    txtFamilyETF.Text = drPage1tDetails["FamilyFTE"].ToString();
                    txtNonFamilyETF.Text = drPage1tDetails["NonFamilyFTE"].ToString();

                    foreach (ListItem li in cbOwnLandList.Items)
                    {
                        if (drPage1tDetails["OwnFarm"].ToString().Split(',').ToList().Contains(li.Value))
                            li.Selected = true;
                    }
                }
            }
        }

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("ProjectDetails.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("WaterQualityGrants.aspx");
        }

        private void Save()
        {
            if (projectNumber != "")
            {
                string MilkSold = string.Empty;

                foreach (ListItem listItem in lstMilkSold.Items)
                {
                    if (listItem.Selected == true)
                    {
                        if (MilkSold == string.Empty)
                            MilkSold = listItem.Value;
                        else
                            MilkSold = MilkSold + ',' + listItem.Value;
                    }
                }

                string LandOwn = string.Empty;
                string LandOwnText = string.Empty;

                foreach (ListItem listItem in cbOwnLandList.Items)
                {
                    if (listItem.Selected == true)
                    {
                        if (LandOwn == string.Empty)
                        {
                            LandOwn = listItem.Value;
                            LandOwnText = listItem.Text;
                        }
                        else
                        {
                            LandOwn = LandOwn + ',' + listItem.Value;
                            LandOwnText = LandOwnText + ',' + listItem.Text;
                        }
                    }
                }

                string orgStruct = rdBtnOrgStructure.SelectedItem == null ? "0" : rdBtnOrgStructure.SelectedItem.ToString();

                if (orgStruct == "Other (Specify)")
                {
                    orgStruct = orgStruct + ":" + txtOrgStructureOther.Text;
                }

                ImpGrantApplicationData.ViabilityImpGrantApplicationPage2(projectNumber, txtOrgName.Text, txtWebsite.Text, orgStruct, txtCows.Text, txtHogs.Text,
                txtPoultry.Text, txtOtherNonDiaryFarms.Text, txtMilkedDaily.Text, txtPrimaryAnimalTypes.Text, txtHerd.Text, txtRollingHerd.Text,
                txtMilkPounds.Text, txtAvgCullRate.Text, txtSomaticCell.Text, MilkSold,
                txtGrossSales.Text,
                txtNetIncome.Text,
                //DataUtils.GetDecimal(Regex.Replace(txtNetIncome.Text, "[^0-9a-zA-Z.]+", "")),
                //DataUtils.GetDecimal(Regex.Replace(txtNetWorth.Text, "[^0-9a-zA-Z.]+", "")),
                DataUtils.GetDecimal(txtFamilyETF.Text),
                DataUtils.GetDecimal(txtNonFamilyETF.Text), DataUtils.GetInt(ddlFiscalyr.SelectedValue), DataUtils.GetDecimal(txtAcresinProduction.Text), DataUtils.GetDecimal(txtAcresOwned.Text),
                DataUtils.GetDecimal(txtAcresLeased.Text), DataUtils.GetDecimal(txtPastureAcres.Text), LandOwn, LandOwnText);

                LogMessage("Farm Business Information Data Added Successfully");
            }
        }
        private void BindLookUP1(CheckBoxList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                DataTable dt = LookupValuesData.Getlookupvalues(LookupType);

                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    if (dr["description"].ToString() == "Transfer")
                        dr.Delete();
                    else if (dr["description"].ToString() == "Out of Business")
                        dr.Delete();
                    else if (dr["description"].ToString() == "On-Farm Processing")
                        dr.Delete();
                }

                ddList.DataSource = dt;
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                //ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
        }

        private void BindLookUP(CheckBoxList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                //ddList.Items.Insert(0, new ListItem("Select", "NA"));
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
    }
}