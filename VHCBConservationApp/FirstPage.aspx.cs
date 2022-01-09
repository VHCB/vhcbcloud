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

namespace VHCBConservationApp
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
                BindCounty(ddlLOCounty);
                BindCounty(ddlFarmerCounty);
                LoadFirstPage();
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
                DataRow drPage1tDetails = ConservationApplicationData.GetConservationApplicationPage1(projectNumber);

                if (drPage1tDetails != null)
                {
                    txtDateSubmitted.Text = drPage1tDetails["Date_Submit"].ToString();
                    txtConservedAcres.Text = drPage1tDetails["ConservedAcres"].ToString();
                    PopulateDropDown(ddlBoardDate, drPage1tDetails["Board_Meet_Date"].ToString());
                    txtFundsRequested.Text = Regex.Replace(drPage1tDetails["Funds_Requested"].ToString(), "[^0-9a-zA-Z.]+", "");
                    txtTotalExpenses.Text = drPage1tDetails["Total_Expenses"].ToString();
                    txtAppOrgan.Text = drPage1tDetails["App_Organ"].ToString();
                    txtProjectManager.Text = drPage1tDetails["Project_Manager"].ToString();
                    txtAppPhone.Text = drPage1tDetails["App_Phone"].ToString();
                    txtAppEmail.Text = drPage1tDetails["App_Email"].ToString();
                    txtLONames.Text = drPage1tDetails["Landowner_Names"].ToString();
                    txtloStreetNo.Text = drPage1tDetails["LOStreet"].ToString();
                    txtLoAddress1.Text = drPage1tDetails["LOAdd1"].ToString();
                    txtLoAddress2.Text = drPage1tDetails["LOAdd2"].ToString();
                    txtLoTown.Text = drPage1tDetails["LOTown"].ToString();
                    txtLOZipCode.Text = drPage1tDetails["LOZip"].ToString();
                    txtLOVillage.Text = drPage1tDetails["LOVillage"].ToString();
                    PopulateDropDown(ddlLOCounty, drPage1tDetails["LOCounty"].ToString());
                    txtLOEmail.Text = drPage1tDetails["LOEmail"].ToString();
                    txtLOHomephone.Text = drPage1tDetails["LOHomephone"].ToString();
                    txtLoCellPhone.Text = drPage1tDetails["LOCell"].ToString();
                    txtFarmerName.Text = drPage1tDetails["FarmerName"].ToString();
                    txtFarmerStreet.Text = drPage1tDetails["FarmerStreet"].ToString();
                    txtFarmerAdd1.Text = drPage1tDetails["FarmerAdd1"].ToString();
                    txtFarmerAdd2.Text = drPage1tDetails["FarmerAdd2"].ToString();
                    txtFarmerTown.Text = drPage1tDetails["FarmerTown"].ToString();
                    txtFarmerZip.Text = drPage1tDetails["FarmerZip"].ToString();
                    txtFarmerVillage.Text = drPage1tDetails["FarmerVillage"].ToString();
                    PopulateDropDown(ddlFarmerCounty, drPage1tDetails["FarmerCounty"].ToString());
                    txtFarmerEmail.Text = drPage1tDetails["FarmerEmail"].ToString();
                    txtFarmerHomePhone.Text = drPage1tDetails["FarmerHomePhone"].ToString();
                    txtFarmerCell.Text = drPage1tDetails["FarmerCell"].ToString();

                    txtPropertyStreet.Text = drPage1tDetails["PropertyStreet"].ToString();
                    txtPropertyAdd1.Text = drPage1tDetails["PropertyAdd1"].ToString();
                    txtPropertyTown.Text = drPage1tDetails["PropertyTown"].ToString();
                    txtPropertyOtherTown.Text = drPage1tDetails["PropertyOtherTown"].ToString();
                    txtPropertyZip.Text = drPage1tDetails["PropertyZip"].ToString();
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

            if (dr != null)
                spnProjectName.InnerText = dr["ProjectName"].ToString();
            else
                spnProjectName.InnerHtml = "No Name";
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

            Response.Redirect("SecondPage.aspx");
        }

        private void saveData()
        {

            if (projectNumber != "")
            {


                ConservationApplicationData.ConservationApplicationPage1(projectNumber, DataUtils.GetDate(txtDateSubmitted.Text), DataUtils.GetDate(ddlBoardDate.Text), DataUtils.GetDecimal(txtConservedAcres.Text),
                    txtFundsRequested.Text,
                    txtTotalExpenses.Text,
                    txtAppOrgan.Text, txtProjectManager.Text, txtAppPhone.Text, txtAppEmail.Text,
                    txtLONames.Text, txtloStreetNo.Text, txtLoAddress1.Text, txtLoAddress2.Text, txtLoTown.Text, txtLOZipCode.Text, txtLOZipCode.Text, ddlLOCounty.Text, txtLOEmail.Text, txtLOHomephone.Text, txtLoCellPhone.Text,
                    txtFarmerName.Text, txtFarmerStreet.Text, txtFarmerAdd1.Text, txtFarmerAdd2.Text, txtFarmerTown.Text, txtFarmerZip.Text, txtFarmerVillage.Text, ddlFarmerCounty.SelectedItem.Text, txtFarmerEmail.Text, txtFarmerHomePhone.Text, txtFarmerCell.Text,
                    txtPropertyStreet.Text, txtPropertyAdd1.Text, txtPropertyTown.Text, txtPropertyOtherTown.Text, txtPropertyZip.Text); 


                LogMessage("Conservation Application Data Added Successfully");
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            saveData();

            ClientScript.RegisterStartupScript(this.GetType(),
                   "script", Helper.GetExagoURL("9999-999-999", "Conservation Online Application"));
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }
    }
}