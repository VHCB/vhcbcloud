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
    public partial class WaterQualityGrants : System.Web.UI.Page
    {
        string Pagename = "WaterQualityGrants";
        string projectNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                BindLookUP(ddlFarmSize, 2277);
                //BindLookUP(ddlWaterShed, 143);
                BindSubLookUP(ddlPrimaryProduct, 375);
                BindCheckBoxList(cblSecProduct, 106);
                //BindLookUP(ddlProduct, 106);
                LoadWaterQualityGrants();
            }
        }

        private void BindCheckBoxList(CheckBoxList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                //ddList.Items.Insert(0, new ListItem("Select", "NA"));
                //ddList.Items.Attributes.Add("onclick", "changeColor(this)");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCheckBoxList", "Control ID:" + ddList.ID, ex.Message);
            }
        }

        private void BindSubLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.GetSubLookupValues(LookupType);
                ddList.DataValueField = "SubTypeID";
                ddList.DataTextField = "SubDescription";
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

        private void LoadWaterQualityGrants()
        {
            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ImpGrantApplicationData.GetImpGrantsWaterQualityGrants(projectNumber);

                if (drPage1tDetails != null)
                {
                    if (drPage1tDetails["CompletePlanning"].ToString() == "True")
                    {
                        rdBtnCompletePlanning.SelectedIndex = 0;
                        lblCompletePlanningMessage.Visible = false;
                    }
                    else
                    {
                        rdBtnCompletePlanning.SelectedIndex = 1;
                        lblCompletePlanningMessage.Visible = true;
                    }

                    rdBtnCompletePlanning.SelectedValue = drPage1tDetails["CompletePlanning"].ToString();

                    PopulateDropDown(ddlFarmSize, drPage1tDetails["Farmsize"].ToString());
                    //PopulateDropDown(ddlWaterShed, drPage1tDetails["LKWatershed"].ToString());
                    PopulateDropDown(ddlPrimaryProduct, drPage1tDetails["PrimaryProduct"].ToString());

                    foreach (ListItem li in cblSecProduct.Items)
                    {
                        if (drPage1tDetails["LKProducts"].ToString().Split(',').ToList().Contains(li.Value))
                        {
                            li.Selected = true;
                        }
                    }
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

        protected void previousButton_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("FarmBusinessInformation.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Save();
            Response.Redirect("Eligibility.aspx");
            //Response.Redirect("WaterQualityGrantsProgramPage4.aspx");
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
        protected void Save()
        {
            if (projectNumber != "")
            {
                string secProduct = string.Empty;
                string secProductNames = string.Empty;
                foreach (ListItem item in cblSecProduct.Items)
                {
                    if (item.Selected)
                    {
                        if (secProduct == string.Empty)
                        {
                            secProduct = item.Value;
                            secProductNames = item.Text;
                        }
                        else
                        {
                            secProduct = secProduct + ',' + item.Value;
                            secProductNames = secProductNames + ",  " + item.Text;
                        }
                    }
                }

                string farmSizeText = ddlFarmSize.SelectedIndex == 0 ? null: ddlFarmSize.SelectedItem.Text;

                ImpGrantApplicationData.ImpGrantsWaterQualityGrants(projectNumber, DataUtils.GetInt(ddlFarmSize.SelectedValue), farmSizeText,  DataUtils.GetInt(ddlPrimaryProduct.SelectedValue), secProduct, secProductNames, DataUtils.GetBool(rdBtnCompletePlanning.SelectedValue));

                LogMessage("Farm Business Information Data Added Successfully");
            }
        }

        protected void rdBtnCompletePlanning_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdBtnCompletePlanning.SelectedValue.ToLower() == "yes")
            {
                lblCompletePlanningMessage.Visible = false;
            }
            else
            {
                lblCompletePlanningMessage.Visible = true;
            }
        }
    }
}