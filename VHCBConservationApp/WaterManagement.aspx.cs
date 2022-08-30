using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace VHCBConservationApp
{
    public partial class WaterManagement : System.Web.UI.Page
    {
        string Pagename = "WaterManagement";
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
            BindLookUP(ddlWatershed, 143);
            //BindLookUP(ddlSecWatershed, 143);
            BindHUC12(ddlHUC12);
            BindHUC12(ddlSecHUC12);
            // BindLookUP(ddlSubWatershed, 261);
            BindLookUP(ddlTacticalBasin, 2284);
            

        }

        private void BindHUC12(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = HUC12Data.GetHUC12ListForApp();
                ddList.DataValueField = "HUCID";
                ddList.DataTextField = "Name";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHUC12", "Control ID:" + ddList.ID, ex.Message);
            }

        }

        private void BindLookupSubWatershed(DropDownList ddList, int TypeId)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupMaintenanceData.GetLkLookupSubValues(TypeId, true);
                ddList.DataValueField = "subtypeid";
                ddList.DataTextField = "SubDescription";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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
        private void LoadPage()
        {
            if (projectNumber != "")
            {
                DataRow dr = ConservationApplicationData.GetWaterManagement(projectNumber);

                if (dr != null)
                {
                    txtWetlands.Text = dr["Wetlands"].ToString();
                    txtPonds.Text = dr["Ponds"].ToString();
                    txtFloodplain.Text = dr["FloodPlain"].ToString();
                    txtStreamfeet.Text = dr["StreamFeet"].ToString();
                    txtPondFeet.Text = dr["PondFeet"].ToString();
                    txtWaterBodies.Text = dr["WaterBodies"].ToString();
                    //PopulateWaterShed(dr["Watershed"].ToString());
                    PopulateWaterShedByText(ddlWatershed, dr["DrainageBasin"].ToString());
                    PopulateDropDownByText(ddlSubWatershed, dr["SubBasinHUC8"].ToString());
                    PopulateDropDownByText(ddlSecSubWatershed, dr["SubBasin2HUC8"].ToString());

                    txtWaterBodies.Text = dr["WaterBodies"].ToString();

                    PopulateDropDownByText(ddlTacticalBasin, dr["TacticalBasin"].ToString());

                    PopulateDropDownByText(ddlDrainageDitches, dr["DrainageDitches"].ToString());
                    PopulateDropDownByText(ddlDrainageTiles, dr["DrainageTiles"].ToString());

                    txtWasteInfrastucture.Text = dr["WasteInfrastructure"].ToString();
                    txtProtectWater.Text = dr["ProtectWater"].ToString();

                    if (DataUtils.GetBool(dr["ParticipateWaterGrant"].ToString()))
                        rdbtParticipateWaterGrant.SelectedIndex = 0;
                    else
                        rdbtParticipateWaterGrant.SelectedIndex = 1;


                    txtParticipateWaterGrant.Text = dr["ParticipateWaterGrantDiscussion"].ToString();

                    txtWaterQualityConcerns.Text = dr["WaterQualityConcerns"].ToString();
                    PopulateDropDownByText(ddlLivestockExcluded, dr["LivestockExcluded"].ToString());
                    PopulateDropDownByText(ddlHUC12, dr["SubWatershedHUC12"].ToString());
                    PopulateDropDownByText(ddlSecHUC12, dr["SubWatershed2HUC12"].ToString());
                }
            }
        }

        private void PopulateWaterShed(string waterShedDetails)
        {
            var waterShedSubwatershedArray = waterShedDetails.Split(';');
            var waterShedArray = waterShedSubwatershedArray[0].Split('~');

            if (waterShedArray.Length == 2)
            {
                PopulateWaterShedByText(ddlWatershed, waterShedArray[0]);
                PopulateDropDownByText(ddlSubWatershed, waterShedArray[1]);
            }
            else
            {
                PopulateWaterShedByText(ddlWatershed, waterShedArray[0]);
            }

            if (waterShedSubwatershedArray.Length == 2)
            {
                var secWaterShedArray = waterShedSubwatershedArray[1].Split('~');
                if (secWaterShedArray.Length == 2)
                {
                    //PopulateSecWaterShedByText(ddlSecWatershed, secWaterShedArray[0]);
                    PopulateDropDownByText(ddlSecSubWatershed, secWaterShedArray[1]);
                }
                else
                {
                    //PopulateSecWaterShedByText(ddlSecWatershed, secWaterShedArray[0]);
                }
            }

          
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("EasementConfig.aspx");
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("FarmManagement.aspx");
        }

        private void saveData()
        {
            string waterShed = string.Empty;
            string subWaterShed = string.Empty;
            string secWaterShed = string.Empty;
            string SecSubWaterShed = string.Empty;

            string waterSheds = string.Empty;
            string subWaterSheds = string.Empty;
            string finalWatershed = string.Empty;
            string finalSecWatershed = string.Empty;

            if (ddlWatershed.SelectedItem.Text.ToLower() != "select")
            {
                waterShed = ddlWatershed.SelectedItem.Text;
                finalWatershed = waterShed;
            }
            if (ddlSubWatershed.SelectedItem != null && ddlSubWatershed.SelectedItem.Text.ToLower() != "select")
            {
                subWaterShed = ddlSubWatershed.SelectedItem.Text;
                finalWatershed = finalWatershed + '~' + subWaterShed;
            }

            //if (ddlSecWatershed.SelectedItem.Text.ToLower() != "select")
            //{
            //    secWaterShed = ddlSecWatershed.SelectedItem.Text;

            //    finalSecWatershed = secWaterShed;
            //}
            if (ddlSecSubWatershed.SelectedItem != null && ddlSecSubWatershed.SelectedItem.Text.ToLower() != "select")
            {
                SecSubWaterShed = ddlSecSubWatershed.SelectedItem.Text;
                finalSecWatershed = finalSecWatershed + "~" + SecSubWaterShed;
            }

            string waterShedInfo = string.Empty;
            if (finalWatershed != string.Empty && finalSecWatershed != string.Empty)
                waterShedInfo = finalWatershed + ";" + finalSecWatershed;
            else if (finalWatershed != string.Empty)
                waterShedInfo = finalWatershed;
            else if (finalSecWatershed != string.Empty)
                waterShedInfo = finalSecWatershed;

            //string acreTypeAcres = string.Empty;
            //acreTypeAcres = "wetlands" + "-" + txtWetlands.Text;
            //acreTypeAcres += ";pond(s)" + "-" + txtPonds.Text;
            //acreTypeAcres += ";floodplain" + "-" + txtFloodplain.Text;

            int LKWatershed;
            if (ddlWatershed.SelectedItem == null)
                LKWatershed = 0;
            else
                LKWatershed = DataUtils.GetInt(ddlWatershed.SelectedItem.Value);

            int LKSUBWatershed;
            if (ddlSubWatershed.SelectedItem == null)
                LKSUBWatershed = 0;
            else
                LKSUBWatershed = DataUtils.GetInt(ddlSubWatershed.SelectedItem.Value);

            int LKSecSUBWatershed;
            if (ddlSecSubWatershed.SelectedItem == null)
                LKSecSUBWatershed = 0;
            else
                LKSecSUBWatershed = DataUtils.GetInt(ddlSecSubWatershed.SelectedItem.Value);

            ConservationApplicationData.WaterManagement(projectNumber, DataUtils.GetDecimal(txtWetlands.Text), DataUtils.GetDecimal(txtPonds.Text), DataUtils.GetDecimal(txtFloodplain.Text), 
                DataUtils.GetDecimal(txtStreamfeet.Text), DataUtils.GetDecimal(txtPondFeet.Text),
                    txtWaterBodies.Text, waterShed, subWaterShed, ddlTacticalBasin.SelectedItem.Text, ddlDrainageDitches.SelectedItem.Text, ddlDrainageTiles.SelectedItem.Text,
                    txtWasteInfrastucture.Text, txtProtectWater.Text, DataUtils.GetBool(rdbtParticipateWaterGrant.SelectedValue), txtParticipateWaterGrant.Text, ddlLivestockExcluded.SelectedItem.Text, txtWaterQualityConcerns.Text,
                    LKWatershed, LKSUBWatershed, LKSecSUBWatershed, DataUtils.GetInt(ddlHUC12.SelectedItem.Value), DataUtils.GetInt(ddlSecHUC12.SelectedItem.Value), 
                    ddlHUC12.SelectedItem.Text, ddlSecHUC12.SelectedItem.Text,
                     DataUtils.GetInt(ddlTacticalBasin.Text), SecSubWaterShed);

            LogMessage("Conservation Application Data Added Successfully");
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

        protected void ddlWatershed_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWatershed.SelectedIndex > 0)
            {
                BindLookupSubWatershed(ddlSubWatershed, DataUtils.GetInt(ddlWatershed.SelectedValue));
                BindLookupSubWatershed(ddlSecSubWatershed, DataUtils.GetInt(ddlWatershed.SelectedValue));
            }

            else
            {
                ddlSubWatershed.Items.Clear();
                ddlSecSubWatershed.Items.Clear();
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

        private void PopulateWaterShedByText(DropDownList ddl, string DBSelectedText)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedText.Trim() == item.Text.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                    BindLookupSubWatershed(ddlSubWatershed, DataUtils.GetInt(item.Value));
                    BindLookupSubWatershed(ddlSecSubWatershed, DataUtils.GetInt(item.Value));
                }
            }
        }
        private void PopulateSecWaterShedByText(DropDownList ddl, string DBSelectedText)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedText.Trim() == item.Text.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                    BindLookupSubWatershed(ddlSecSubWatershed, DataUtils.GetInt(item.Value));
                }
            }
        }
        protected void ddlSecWatershed_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlSecWatershed.SelectedIndex > 0)
            //    BindLookupSubWatershed(ddlSecSubWatershed, DataUtils.GetInt(ddlSecWatershed.SelectedValue));
            //else
            //    ddlSecSubWatershed.Items.Clear();
        }
    }
}