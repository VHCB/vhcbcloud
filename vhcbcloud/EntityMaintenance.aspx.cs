﻿using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class EntityMaintenance : System.Web.UI.Page
    {
        string Pagename = "EntityMaintenance";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                BindControls();
                DisplayPanels();
            }
        }

        private void DisplayPanels()
        {
            if (rdBtnAction.SelectedValue.ToLower() == "existing")
            {
                if (ddlEntityRole.SelectedIndex != 0)
                {
                    string SelectedRole = ddlEntityRole.SelectedValue.ToString();

                    dvExistingEntities.Visible = true;
                    BindApplicants(DataUtils.GetInt(SelectedRole));
                }
                else
                {
                    dvExistingEntities.Visible = false;
                }

                dvCommonForm.Visible = false;
                dvIndividual.Visible = false;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
                dvNewEntirySubmit.Visible = false;
            }
            else
            {
                if (ddlEntityRole.SelectedIndex == 0)
                {
                    dvCommonForm.Visible = false;
                    dvIndividual.Visible = false;
                    dvFarm.Visible = false;
                    dvNewAddress.Visible = false;
                    dvExistingEntities.Visible = false;
                    dvNewEntirySubmit.Visible = false;
                }
                else
                {
                    DisplayPanelsBasedOnEntityRole();
                }
            }
        }

        private void DisplayPanelsBasedOnEntityRole()
        {
            string SelectedRole = ddlEntityRole.SelectedItem.ToString();
            dvCommonForm.Visible = true;
            dvNewEntirySubmit.Visible = true;

            if (SelectedRole.ToLower() == "individual")
            {
                CommonFormHeader.InnerText = "Entity";
                dvIndividual.Visible = true;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
            }
            else if (SelectedRole.ToLower() == "organization")
            {
                CommonFormHeader.InnerText = "Entity Organization";
                dvIndividual.Visible = false;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
            }
            else if (SelectedRole.ToLower() == "farm")
            {
                CommonFormHeader.InnerText = "Entity";
                dvIndividual.Visible = false;
                dvFarm.Visible = true;
                dvNewAddress.Visible = false;
            }
            else
            {
                CommonFormHeader.InnerText = "Entity";
                dvCommonForm.Visible = false;
                dvIndividual.Visible = false;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlEntityRole, 170);
            BindLookUP(ddlEntityType, 103);
            BindLookUP(ddlPosition, 117);
            BindLookUP(ddlFarmType, 106);
        }

        protected void BindApplicants(int RoleId)
        {
            try
            {
                ddlEntityName.Items.Clear();
                ddlEntityName.DataSource = EntityMaintenanceData.GetEntitiesByRole(RoleId);
                ddlEntityName.DataValueField = "ApplicantId";
                ddlEntityName.DataTextField = "Applicantname";
                ddlEntityName.DataBind();
                ddlEntityName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
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

        protected void rdBtnAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButtonSelectionChanged();
        }

        private void RadioButtonSelectionChanged()
        {
            ddlEntityRole.SelectedIndex = -1;
            dvCommonForm.Visible = false;
            dvIndividual.Visible = false;
            dvFarm.Visible = false;
            dvNewAddress.Visible = false;
            dvExistingEntities.Visible = false;
            dvNewEntirySubmit.Visible = false;
            ClearForm();
        }

        protected void ddlEntityRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayPanels();
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

        protected void btnAddAddress_Click(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetAddress1(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectMaintenanceData.GetAddressDetails(prefixText);

            //List<string> ProjNames = new List<string>();
            List<string> items = new List<string>(count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dt.Rows[i]["Street#"].ToString()
                    + ' ' + dt.Rows[i]["Address1"].ToString() + ' ' + dt.Rows[i]["Town"].ToString(),
                    dt.Rows[i]["Street#"].ToString()
                    + '~' + dt.Rows[i]["Address1"].ToString()
                    + '~' + dt.Rows[i]["Address2"].ToString()
                    + '~' + dt.Rows[i]["State"].ToString()
                    + '~' + dt.Rows[i]["Zip"].ToString()
                    + '~' + dt.Rows[i]["Town"].ToString()
                    + '~' + dt.Rows[i]["County"].ToString()
                    + '~' + dt.Rows[i]["latitude"].ToString()
                    + '~' + dt.Rows[i]["longitude"].ToString()
                    + '~' + dt.Rows[i]["Village"].ToString()
                    );
                items.Add(str);
                //ProjNames.Add(dt.Rows[i][0].ToString());
            }
            //return ProjNames.ToArray();
            return items.ToArray();
        }

        protected void btnEntitySubmit_Click(object sender, EventArgs e)
        {
            string HomePhoneNumber = new string(txtHomePhone.Text.Where(c => char.IsDigit(c)).ToArray());
            string WorkPhoneNumber = new string(txtWorkPhone.Text.Where(c => char.IsDigit(c)).ToArray());
            string CellPhoneNumber = new string(txtCellPhone.Text.Where(c => char.IsDigit(c)).ToArray());

            if (ddlEntityRole.SelectedItem.ToString().ToLower() == "individual")
            {
                EntityMaintResult objEntityMaintResult = EntityMaintenanceData.AddNewEntity(DataUtils.GetInt(ddlEntityType.SelectedValue.ToString()), DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text,
                    txtEmail.Text, HomePhoneNumber, WorkPhoneNumber, CellPhoneNumber, txtStateVendorId.Text, txtApplicantName.Text, txtFirstName.Text, txtLastName.Text, DataUtils.GetInt(ddlPosition.SelectedValue.ToString()),
                    txtTitle.Text, null, 0, 0, 0,
                    0, 0, 0, false, null, null,
                    0);
                ClearForm();
                PopulateEntity(objEntityMaintResult.ApplicantId, DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()));
            }
            else if (ddlEntityRole.SelectedItem.ToString().ToLower() == "organization")
            {
                EntityMaintResult objEntityMaintResult = EntityMaintenanceData.AddNewEntity(DataUtils.GetInt(ddlEntityType.SelectedValue.ToString()), DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text,
                   null, HomePhoneNumber, WorkPhoneNumber, CellPhoneNumber, txtStateVendorId.Text, txtApplicantName.Text, null, null, 0,
                   null, null, 0, 0, 0,
                   0, 0, 0, false, null, null,
                   0);
                ClearForm();
                PopulateEntity(objEntityMaintResult.ApplicantId, DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()));
            }
            else if (ddlEntityRole.SelectedItem.ToString().ToLower() == "farm")
            {
                EntityMaintResult objEntityMaintResult = EntityMaintenanceData.AddNewEntity(DataUtils.GetInt(ddlEntityType.SelectedValue.ToString()), DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text,
                   null, HomePhoneNumber, WorkPhoneNumber, CellPhoneNumber, txtStateVendorId.Text, txtApplicantName.Text, null, null, 0,
                   null, txtFarmName.Text, DataUtils.GetInt(ddlFarmType.SelectedValue.ToString()), DataUtils.GetInt(txtAcresInProduction.Text), DataUtils.GetInt(txtAcresOwned.Text),
                   DataUtils.GetInt(txtAcresLeased.Text), DataUtils.GetInt(txtAcresLeasedOut.Text), DataUtils.GetInt(txtTotalAcres.Text), cbIsNoLongerBusiness.Checked, txtNotes.Text, txtAgrEdu.Text,
                   DataUtils.GetInt(txtYearsManagingForm.Text));
                ClearForm();
                PopulateEntity(objEntityMaintResult.ApplicantId, DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()));
            }
            
        }

        private void PopulateEntity(int ApplicantId, int EntityRole)
        {
            hfApplicantId.Value = ApplicantId.ToString();
            rdBtnAction.SelectedIndex = 1;
            RadioButtonSelectionChanged();
            dvExistingEntities.Visible = true;

            PopulateDropDown(ddlEntityRole, EntityRole.ToString());

            BindApplicants(EntityRole);
            PopulateDropDown(ddlEntityName, ApplicantId.ToString());
            EntityNameChanged();
        }

        protected void ddlEntityName_SelectedIndexChanged(object sender, EventArgs e)
        {
            EntityNameChanged();
        }

        private void EntityNameChanged()
        {
            ClearForm();
            DisplayPanelsBasedOnEntityRole();

            DataRow drEntityData = EntityMaintenanceData.GetEntityData(DataUtils.GetInt(ddlEntityName.SelectedValue.ToString()));
            if (drEntityData != null)
            {
                PopulateForm(drEntityData);
            }
        }

        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue == item.Value.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
        }

        private void PopulateForm(DataRow drEntityData)
        {
            PopulateDropDown(ddlEntityType, drEntityData["LkEntityType"].ToString());
            txtFiscalYearEnd.Text = drEntityData["FYend"].ToString(); 
            txtWebsite.Text = drEntityData["website"].ToString();

            if (drEntityData["WorkPhone"].ToString() == "")
                txtWorkPhone.Text = "";
            else
                txtWorkPhone.Text = String.Format("{0:(###)###-####}", double.Parse(drEntityData["WorkPhone"].ToString()));

            if (drEntityData["CellPhone"].ToString() == "")
                txtCellPhone.Text = "";
            else
                txtCellPhone.Text = String.Format("{0:(###)###-####}", double.Parse(drEntityData["CellPhone"].ToString()));

            if (drEntityData["HomePhone"].ToString() == "")
                txtHomePhone.Text = "";
            else
                txtHomePhone.Text = String.Format("{0:(###)###-####}", double.Parse(drEntityData["HomePhone"].ToString()));

            txtStateVendorId.Text = drEntityData["Stvendid"].ToString();
            txtApplicantName.Text = drEntityData["Applicantname"].ToString();
            txtFirstName.Text = drEntityData["Firstname"].ToString();
            txtLastName.Text = drEntityData["Lastname"].ToString();
            PopulateDropDown(ddlPosition, drEntityData["LkPosition"].ToString());
            txtTitle.Text = drEntityData["Title"].ToString();
            txtEmail.Text = drEntityData["email"].ToString();
            txtFarmName.Text = drEntityData["FarmName"].ToString();
            PopulateDropDown(ddlFarmType, drEntityData["LkFVEnterpriseType"].ToString());
            txtAcresInProduction.Text = drEntityData["AcresInProduction"].ToString(); ;
            txtAcresOwned.Text = drEntityData["AcresOwned"].ToString(); ;
            txtAcresLeased.Text = drEntityData["AcresLeased"].ToString(); ;
            txtAcresLeasedOut.Text = drEntityData["AcresLeasedOut"].ToString(); ;
            txtTotalAcres.Text = drEntityData["TotalAcres"].ToString(); ;
            cbIsNoLongerBusiness.Checked = DataUtils.GetBool(drEntityData["OutOFBiz"].ToString());
            txtNotes.Text = drEntityData["Notes"].ToString();
            txtAgrEdu.Text = drEntityData["AgEd"].ToString();
            txtYearsManagingForm.Text = drEntityData["YearsManagingFarm"].ToString();
        }

        private void ClearForm()
        {
            ddlEntityType.SelectedIndex = -1;
            txtFiscalYearEnd.Text = "";
            txtWebsite.Text = "";
            txtHomePhone.Text = "";
            txtWorkPhone.Text = "";
            txtCellPhone.Text = "";
            txtStateVendorId.Text = "";
            txtApplicantName.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            ddlPosition.SelectedIndex = -1;
            txtTitle.Text = "";
            txtEmail.Text = "";
            txtFarmName.Text = "";
            ddlFarmType.SelectedIndex = -1;
            txtAcresInProduction.Text = "";
            txtAcresOwned.Text = "";
            txtAcresLeased.Text = "";
            txtAcresLeasedOut.Text = "";
            txtTotalAcres.Text = "";
            cbIsNoLongerBusiness.Checked = false;
            txtNotes.Text = "";
            txtAgrEdu.Text = "";
            txtYearsManagingForm.Text = "";
        }
    }
}