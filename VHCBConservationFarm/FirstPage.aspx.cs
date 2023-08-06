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
    public partial class FirstPage : System.Web.UI.Page
    {
        string Pagename = "ProjectDetails";
        string projectNumber = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectNumber"] == null)
                Response.Redirect("Login.aspx");
            else
                projectNumber = Session["ProjectNumber"].ToString();

            if (!IsPostBack)
            {
                BindBoardDates(ddlBoardDate);
                BindTown(ddlLoTown);
                //BindTown(ddlFarmerTown);
                BindTown(ddlPropertyTown);
                BindTown(ddlProposedTown);
                LoadFirstPage();
            }
        }

        private void BindLoCounty(DropDownList ddl, string town)
        {
            try
            {
                DataTable dt = ProjectMaintenanceData.GetCountysByTown(town);

                ddl.Items.Clear();
                ddl.DataSource = dt;
                ddl.DataValueField = "County";
                ddl.DataTextField = "County";
                ddl.DataBind();
                ddl.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounty", "Control ID:" + ddl.ID, ex.Message);
            }
        }

        private void BindTown(DropDownList ddlTown)
        {
            try
            {
                DataTable dt = ProjectMaintenanceData.GetTowns();

                ddlTown.Items.Clear();
                ddlTown.DataSource = dt;
                ddlTown.DataValueField = "Town";
                ddlTown.DataTextField = "Town";
                ddlTown.DataBind();
                ddlTown.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounty", "Control ID:" + ddlTown.ID, ex.Message);
            }
        }

        private void BindBoardDates(DropDownList ddlBoardDate)
        {
            try
            {
                DataTable dt = ConservationApplicationData.GetBoardDates();

                ddlBoardDate.Items.Clear();
                ddlBoardDate.DataSource = dt;
                ddlBoardDate.DataValueField = "BoardDate";
                ddlBoardDate.DataTextField = "BoardDate";
                ddlBoardDate.DataBind();
                ddlBoardDate.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBoardDates", "Control ID:" + ddlBoardDate.ID, ex.Message);
            }
        }

        private void LoadFirstPage()
        {
            SetProjectName();

            if (projectNumber != "")
            {
                DataRow drPage1tDetails = ConservationApplicationData.GetConservationFarmApplicationPage1(projectNumber);

                if (drPage1tDetails != null)
                {
                    lblProjectName.Text = drPage1tDetails["Proj_Name"].ToString();
                    txtApplicationDate.Text = drPage1tDetails["App_date"].ToString();
                    txtConservedAcres.Text = drPage1tDetails["ConservedAcres"].ToString();
                    PopulateDropDown(ddlBoardDate, drPage1tDetails["Board_Meet_Date"].ToString());
                    txtFundsRequested.Text = Regex.Replace(drPage1tDetails["Funds_Requested"].ToString(), "[^0-9a-zA-Z.]+", "");
                    txtTotalExpenses.Text = drPage1tDetails["Total_Expenses"].ToString();
                    txtAppOrgan.Text = drPage1tDetails["App_Organ"].ToString();
                    txtProjectManager.Text = drPage1tDetails["Project_Manager"].ToString();
                    txtAppPhone.Text = drPage1tDetails["App_Phone"].ToString();
                    txtAppEmail.Text = drPage1tDetails["App_Email"].ToString();
                    txtAppCellPhone.Text = drPage1tDetails["AppCellPhone"].ToString();
                    txtLONames.Text = drPage1tDetails["Landowner_Name"].ToString();
                    txtloStreetNo.Text = drPage1tDetails["LOStreet"].ToString();
                    txtLoAddress1.Text = drPage1tDetails["LOAdd1"].ToString();
                    txtLoAddress2.Text = drPage1tDetails["LOAdd2"].ToString();
                    //txtLoTown.Text = drPage1tDetails["LOTown"].ToString();
                    PopulateDropDown(ddlLoTown, drPage1tDetails["LOTown"].ToString());

                    //BindLoCounty(ddlLOCounty, drPage1tDetails["LOTown"].ToString());
                    lblLoCounty.Text = drPage1tDetails["LOCounty"].ToString();
                    //PopulateDropDown(ddlLOCounty, drPage1tDetails["LOCounty"].ToString());
                    txtLOZipCode.Text = drPage1tDetails["LOZip"].ToString();
                    //txtLOVillage.Text = drPage1tDetails["LOVillage"].ToString();
                    
                    txtLOEmail.Text = drPage1tDetails["LOEmail"].ToString();
                    txtLOHomephone.Text = drPage1tDetails["LOHomephone"].ToString();
                    txtLoCellPhone.Text = drPage1tDetails["LOCell"].ToString();
                    txtFarmerName.Text = drPage1tDetails["FarmerName"].ToString();
                    //txtFarmerStreet.Text = drPage1tDetails["FarmerStreet"].ToString();
                    //txtFarmerAdd1.Text = drPage1tDetails["FarmerAdd1"].ToString();
                    //txtFarmerAdd2.Text = drPage1tDetails["FarmerAdd2"].ToString();
                    //txtFarmerTown.Text = drPage1tDetails["FarmerTown"].ToString();
                    //PopulateDropDown(ddlFarmerTown, drPage1tDetails["FarmerTown"].ToString());
                    //txtFarmerZip.Text = drPage1tDetails["FarmerZip"].ToString();
                    //txtFarmerVillage.Text = drPage1tDetails["FarmerVillage"].ToString();

                    //BindLoCounty(ddlFarmerCounty, drPage1tDetails["FarmerTown"].ToString());
                    //PopulateDropDown(ddlFarmerCounty, drPage1tDetails["FarmerCounty"].ToString());
                    //lblFarmerCounty.Text = drPage1tDetails["FarmerCounty"].ToString();

                    txtFarmerEmail.Text = drPage1tDetails["FarmerEmail"].ToString();
                    txtFarmerHomePhone.Text = drPage1tDetails["FarmerHomePhone"].ToString();
                    txtFarmerCell.Text = drPage1tDetails["FarmerCell"].ToString();

                    txtPropertyStreet.Text = drPage1tDetails["PropertyStreet"].ToString();
                    txtPropertyAdd1.Text = drPage1tDetails["PropertyAdd1"].ToString();
                    PopulateDropDown(ddlPropertyTown, drPage1tDetails["PropertyTown"].ToString());
                    //txtPropertyOtherTown.Text = drPage1tDetails["PropertyOtherTown"].ToString();
                    txtPropertyZip.Text = drPage1tDetails["PropertyZip"].ToString();
                    lblPropertyCounty.Text = getCounty(ddlPropertyTown.SelectedItem.Text);

                    txtProposedStreet.Text = drPage1tDetails["ProposedStreet"].ToString(); 
                    txtProposedAdd1.Text = drPage1tDetails["ProposedAdd1"].ToString();
                    txtProposedAdd2.Text = drPage1tDetails["ProposedAdd2"].ToString();
                    PopulateDropDown(ddlProposedTown, drPage1tDetails["ProposedTown"].ToString());
                    txtProposedZIP.Text = drPage1tDetails["ProposedZIP"].ToString();
                    lblProposedCounty.Text = drPage1tDetails["ProposedCounty"].ToString();
                    txtProposedContact.Text = drPage1tDetails["ProposedContact"].ToString(); 
                    txtProposedEmail.Text = drPage1tDetails["ProposedEmail"].ToString();
                    txtProposedHomePhone.Text = drPage1tDetails["ProposedHomePhone"].ToString(); 
                    txtProposedCellPhone.Text = drPage1tDetails["ProposedCellPhone"].ToString(); 
                    txtProposedRelation.Text = drPage1tDetails["ProposedRelation"].ToString();

                    if (DataUtils.GetBool(drPage1tDetails["Notify"].ToString()))
                        rdbtNotify.SelectedIndex = 0;
                    else
                        rdbtNotify.SelectedIndex = 1;

                    foreach (ListItem li in cblFarmerTransfer.Items)
                    {
                        if (drPage1tDetails["FarmerTransfer"].ToString().Split(',').ToList().Contains(li.Text))
                        {
                            li.Selected = true;
                        }
                    }
                }
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
        private void SetProjectName()
        {
            DataRow dr = InactiveProjectData.GetProjectNameByProjectNumber(projectNumber);

            //if (dr != null)
            //    spnProjectName.InnerText = dr["ProjectName"].ToString();
            //else
            //    spnProjectName.InnerHtml = "No Name";
        }

        private void BindCounty(DropDownList ddlCounty)
        {
            try
            {
                DataTable dt = ProjectMaintenanceData.GetCountys();

                ddlCounty.Items.Clear();
                ddlCounty.DataSource = dt;
                ddlCounty.DataValueField = "County";
                ddlCounty.DataTextField = "County";
                ddlCounty.DataBind();
                ddlCounty.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCounty", "Control ID:" + ddlCounty.ID, ex.Message);
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

        protected void btnNext_Click(object sender, EventArgs e)
        {
            saveData();

            Response.Redirect("ThirdPage.aspx");
        }

        private void saveData()
        {

            if (projectNumber != "")
            {
                string FarmTransferList = string.Empty;

                foreach (ListItem listItem in cblFarmerTransfer.Items)
                {
                    if (listItem.Selected == true)
                    {
                        if (FarmTransferList == string.Empty)
                        {
                            FarmTransferList = listItem.Text;
                        }
                        else
                        {
                            FarmTransferList = FarmTransferList + ',' + listItem.Text;
                        }
                    }
                }

                ConservationApplicationData.ConservationFarmApplicationPage1(projectNumber, DataUtils.GetDate(ddlBoardDate.Text), DataUtils.GetDecimal(txtConservedAcres.Text),
                    txtFundsRequested.Text,
                    txtTotalExpenses.Text,
                    txtAppOrgan.Text, txtProjectManager.Text, txtAppPhone.Text, txtAppEmail.Text,
                    txtLONames.Text, txtloStreetNo.Text, txtLoAddress1.Text, txtLoAddress2.Text, ddlLoTown.Text, txtLOZipCode.Text, lblLoCounty.Text, txtLOEmail.Text, txtLOHomephone.Text, txtLoCellPhone.Text,
                    txtFarmerName.Text, "","","","", "", "", txtFarmerEmail.Text, txtFarmerHomePhone.Text, txtFarmerCell.Text,
                    txtPropertyStreet.Text, txtPropertyAdd1.Text, ddlPropertyTown.Text, txtPropertyZip.Text,
                    txtProposedStreet.Text, txtProposedAdd1.Text, txtProposedAdd2.Text, ddlProposedTown.Text, txtProposedZIP.Text, lblProposedCounty.Text,
                    txtProposedContact.Text, txtProposedEmail.Text,  txtProposedHomePhone.Text, txtProposedCellPhone.Text, txtProposedRelation.Text,
                    DataUtils.GetBool(rdbtNotify.SelectedValue.Trim()), DataUtils.GetDate(txtApplicationDate.Text), FarmTransferList, txtAppCellPhone.Text);
                
                LogMessage("Conservation Farm Application Data Added Successfully");
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            saveData();

            ConservationApplicationData.InsertDefaultDataForConserveApp(projectNumber);

            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL(projectNumber, "Farm Conservation Online Application"));
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void ddlLoTown_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblLoCounty.Text = getCounty(ddlLoTown.SelectedItem.Text);
        }

        protected void ddlFarmerTown_SelectedIndexChanged(object sender, EventArgs e)
        {
            //lblFarmerCounty.Text = getCounty(ddlFarmerTown.SelectedItem.Text);
        }

        private string getCounty(string town)
        {
            try
            {
                string county = ProjectMaintenanceData.GetCountyByTown(town);

                return county;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void ddlPropertyTown_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblPropertyCounty.Text = getCounty(ddlPropertyTown.SelectedItem.Text);
        }

        protected void ddlGoto_SelectedIndexChanged(object sender, EventArgs e)
        {
            saveData();
            Response.Redirect(ddlGoto.SelectedItem.Value);
        }

        protected void ddlProposedTown_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblProposedCounty.Text = getCounty(ddlProposedTown.SelectedItem.Text);
        }
    }
}