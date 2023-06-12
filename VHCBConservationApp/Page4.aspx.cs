using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Conservation;

namespace VHCBConservationApp
{
    public partial class Page4 : System.Web.UI.Page
    {
        string Pagename = "Page4";
        string projectNumber = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                BindLookUP(ddlTrailName, 1270);
                //BindTrailCheckBoxList();
                LoadPage();
                BindTrailMilesGrid();
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

        private void LoadPage()
        {
            if (projectNumber != "")
            {
                DataRow dr = ConservationApplicationData.GetConservationApplicationPage4(projectNumber);

                if (dr != null)
                {
                    hfConserveId.Value = dr["conserveId"].ToString();
                    txtHay.Text = dr["Hay"].ToString();
                    //txtRoundBales.Text = dr["RoundBales"].ToString();
                    //txtSquareBales.Text = dr["SquareBales"].ToString();
                    //txtTonsperacreperYear.Text = dr["TonsperacreperYear"].ToString();
                    txtPasture.Text = dr["Pasture"].ToString();
                    txtVegetables.Text = dr["Vegetables"].ToString();
                    txtVegetableTypes.Text = dr["VegetableTypes"].ToString();
                    txtFruit.Text = dr["Fruit"].ToString();
                    txtFruitTypes.Text = dr["FruitTypes"].ToString();
                    txtLivestock.Text = dr["Livestock"].ToString();
                    txtLivestockTypes.Text = dr["LivestockTypes"].ToString();
                    txtChristmasTrees.Text = dr["ChristmasTrees"].ToString();
                    txtNurseryStock.Text = dr["NurseryStock"].ToString();
                    txtOrganic.Text = dr["Organic"].ToString();
                    txtOrganicAreas.Text = dr["OrganicAreas"].ToString();
                    txtOrganicAreas.Text = dr["OrganicAreas"].ToString();
                    txtSugarbush.Text = dr["SugarBush"].ToString();
                    txtManagedTimber.Text = dr["ManagedTimber"].ToString();
                    txtOtherForest.Text = dr["OtherForest"].ToString();

                    if (DataUtils.GetBool(dr["ManagementPlan"].ToString()))
                        rdbtnManagementPlan.SelectedIndex = 0;
                    else
                        rdbtnManagementPlan.SelectedIndex = 1;

                    txtOtherAgriculture.Text = dr["OtherAgriculture"].ToString();
                    txtOtherAgricultureProduction.Text = dr["OtherAgricultureProduction"].ToString();
                    txtUnmanaged.Text = dr["Unmanaged"].ToString();
                    txtAgritourism.Text = dr["Agritourism"].ToString();

                    if (DataUtils.GetBool(dr["Trails"].ToString()))
                        rdbTrails.SelectedIndex = 0;
                    else
                        rdbTrails.SelectedIndex = 1;

                    txtTrailfeet.Text = dr["TrailFeet"].ToString();

                    txtAgsoils.Text = dr["Agsoils"].ToString();
                    txtPrimeNonFootnoted.Text = dr["PrimeNonNoted"].ToString();
                    txtPrimeNonNotedPCent.Text = dr["PrimeNonNotedPCent"].ToString();
                    txtPrimeNoted.Text = dr["PrimeNoted"].ToString();
                    txtPrimeNotedPCent.Text = dr["PrimeNotedPCent"].ToString();
                    txtStatewideNonNoted.Text = dr["StatewideNonNoted"].ToString();
                    txtStatewideNonNotedPCent.Text = dr["StatewideNonNotedPCent"].ToString();
                    txtStatewideNoted.Text = dr["StatewideNoted"].ToString();
                    txtStatewideNotedPCent.Text = dr["StatewideNotedPCent"].ToString();
                    txtOtherNonAgSoils.Text = dr["OtherNonAgSoils"].ToString();
                    txtOtherNonAgSoilsPCent.Text = dr["OtherNonAgSoilsPCent"].ToString();
                    txtTotal.Text = dr["Total"].ToString();
                    txtTillable.Text = dr["Tillable"].ToString();
                    txtOtherTrail.Text = dr["othertrail"].ToString();
                    txtrecuses.Text = dr["recuses"].ToString();  
                    //foreach (ListItem li in cblTrailName.Items)
                    //{
                    //    if (dr["TrailNames"].ToString().Split(',').ToList().Contains(li.Text))
                    //    {
                    //        li.Selected = true;
                    //    }
                    //}

                }
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("FarmManagement.aspx");
        }

        private void saveData()
        {
            string trailName = string.Empty;
            string trailNameIds = string.Empty;

            //foreach (ListItem listItem in cblTrailName.Items)
            //{
            //    if (listItem.Selected == true)
            //    {
            //        if (trailName == string.Empty)
            //        {
            //            trailName = listItem.Text;
            //            trailNameIds = listItem.Value;
            //        }
            //        else
            //        {
            //            trailName = trailName + ',' + listItem.Text;
            //            trailNameIds = trailNameIds + ',' + listItem.Value;
            //        }
            //    }
            //}


            ConservationApplicationData.ConservationApplicationPage4(projectNumber, DataUtils.GetDecimal(txtHay.Text), DataUtils.GetDecimal(txtPasture.Text), DataUtils.GetDecimal(txtVegetables.Text),
    txtVegetableTypes.Text, DataUtils.GetDecimal(txtFruit.Text), txtFruitTypes.Text, DataUtils.GetDecimal(txtLivestock.Text), txtLivestockTypes.Text, DataUtils.GetDecimal(txtChristmasTrees.Text), DataUtils.GetDecimal(txtNurseryStock.Text), DataUtils.GetDecimal(txtOrganic.Text), 
    txtOrganicAreas.Text, DataUtils.GetDecimal(txtSugarbush.Text), DataUtils.GetDecimal(txtManagedTimber.Text), DataUtils.GetDecimal(txtOtherForest.Text), DataUtils.GetBool(rdbtnManagementPlan.SelectedValue.Trim()), DataUtils.GetDecimal(txtOtherAgriculture.Text),
    txtOtherAgricultureProduction.Text, DataUtils.GetDecimal(txtUnmanaged.Text), txtAgritourism.Text, DataUtils.GetBool(rdbTrails.SelectedValue.Trim()), DataUtils.GetDecimal(txtTrailfeet.Text), trailName,
    DataUtils.GetDecimal(txtPrimeNonFootnoted.Text), DataUtils.GetDecimal(txtPrimeNonNotedPCent.Text), DataUtils.GetDecimal(txtPrimeNoted.Text), DataUtils.GetDecimal(txtPrimeNotedPCent.Text), DataUtils.GetDecimal(txtStatewideNonNoted.Text), DataUtils.GetDecimal(txtStatewideNonNotedPCent.Text),
    DataUtils.GetDecimal(txtStatewideNoted.Text), DataUtils.GetDecimal(txtStatewideNotedPCent.Text), DataUtils.GetDecimal(txtOtherNonAgSoils.Text), DataUtils.GetDecimal(txtOtherNonAgSoilsPCent.Text), DataUtils.GetDecimal(txtTotal.Text), 
    DataUtils.GetDecimal(txtTillable.Text), trailNameIds, txtOtherTrail.Text, txtrecuses.Text);


           // BindTrailCheckBoxList();
            LogMessage("Conservation Application Data Added Successfully");
        }

      
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect("ThirdPage.aspx");
        }

        //private void BindTrailCheckBoxList()
        //{
        //    try
        //    {
        //        cblTrailName.Items.Clear();
        //        cblTrailName.DataSource = LookupValuesData.Getlookupvalues(1270);
        //        cblTrailName.DataValueField = "typeid";
        //        cblTrailName.DataTextField = "description";
        //        cblTrailName.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        lblErrorMsg.Text = ex.Message;
        //    }
        //}

        protected void btnTrails_Click(object sender, EventArgs e)
        {
            Result objResult = ConservationSummaryData.AddConserveTrailsFromApp(DataUtils.GetInt(hfConserveId.Value),
              DataUtils.GetInt(ddlTrailName.SelectedValue.ToString()), DataUtils.GetInt(txtTrailFeets.Text),
              true);

            if (objResult.IsDuplicate && !objResult.IsActive)
                LogMessage("Trail Miles already exist as in-active");
            else if (objResult.IsDuplicate)
                LogMessage("Trail Miles already exist");
            else
                LogMessage("New Trail Miles added successfully");

            ddlTrailName.SelectedIndex = -1;
            txtTrailFeets.Text = "";
            cbAddTrail.Checked = false;
            BindTrailMilesGrid();
        }
        private void BindTrailMilesGrid()
        {
            try
            {
                DataTable dtTrails = ConservationSummaryData.GetConserveTrailsList(DataUtils.GetInt(hfConserveId.Value), true);

                if (dtTrails.Rows.Count > 0)
                {
                    dvTrailMileageGrid.Visible = true;
                    gvTrailMileage.DataSource = dtTrails;
                    gvTrailMileage.DataBind();
                }
                else
                {
                    dvTrailMileageGrid.Visible = false;
                    gvTrailMileage.DataSource = null;
                    gvTrailMileage.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindTrailMilesGrid", "", ex.Message);
            }
        }

        protected void gvTrailMileage_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTrailMileage.EditIndex = e.NewEditIndex;
            BindTrailMilesGrid();
        }

        protected void gvTrailMileage_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTrailMileage.EditIndex = -1;
            BindTrailMilesGrid();
        }

        protected void gvTrailMileage_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            string strFeet = ((TextBox)gvTrailMileage.Rows[rowIndex].FindControl("txtFeet")).Text;

            if (string.IsNullOrWhiteSpace(strFeet) == true)
            {
                LogMessage("Enter Miles");
                return;
            }
            if (DataUtils.GetInt(strFeet) <= 0)
            {
                LogMessage("Enter valid Feet");
                return;
            }

            int ConserveTrailsID = DataUtils.GetInt(((Label)gvTrailMileage.Rows[rowIndex].FindControl("lblConserveTrailsID")).Text);
            int Feet = DataUtils.GetInt(strFeet);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvTrailMileage.Rows[rowIndex].FindControl("chkActive")).Checked);
          

            ConservationSummaryData.UpdateConserveTrailsFromApp(ConserveTrailsID, Feet, true, RowIsActive);
            gvTrailMileage.EditIndex = -1;

            BindTrailMilesGrid();

            LogMessage("Trail Miles updated successfully");
        }

        protected void ddlGoto_SelectedIndexChanged(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect(ddlGoto.SelectedItem.Value);
        }
    }
}