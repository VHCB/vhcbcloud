using DataAccessLayer;
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
                    BindApplicants(DataUtils.GetInt(SelectedRole), ddlEntityName);
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
                dvNewAttribute.Visible = false;
                dvNewProduct.Visible = false;
                dvAttachEntities.Visible = false;
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
                    dvNewAttribute.Visible = false;
                    dvNewProduct.Visible = false;
                    dvAttachEntities.Visible = false;
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
            btnEntitySubmit.Text = "Submit";

            if (SelectedRole.ToLower() == "individual")
            {
                CommonFormHeader.InnerText = "Entity";
                dvIndividual.Visible = true;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
                dvNewAttribute.Visible = false;
                dvAttachEntities.Visible = false;
            }
            else if (SelectedRole.ToLower() == "organization")
            {
                CommonFormHeader.InnerText = "Entity Organization";
                dvIndividual.Visible = false;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
                dvNewAttribute.Visible = false;
                dvAttachEntities.Visible = false;
            }
            else if (SelectedRole.ToLower() == "farm")
            {
                CommonFormHeader.InnerText = "Entity";
                dvIndividual.Visible = false;
                dvFarm.Visible = true;
                dvNewAddress.Visible = false;
                dvNewAttribute.Visible = false;
                dvAttachEntities.Visible = false;
            }
            else
            {
                CommonFormHeader.InnerText = "Entity";
                dvCommonForm.Visible = false;
                dvIndividual.Visible = false;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
                dvNewAttribute.Visible = false;
                dvAttachEntities.Visible = false;
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlEntityRole, 170);
            BindLookUP(ddlEntityType, 103);
            BindLookUP(ddlPosition, 117);
            BindLookUP(ddlFarmType, 106);
            BindLookUP(ddlAddressType, 1);
            BindLookUP(ddlAttribute, 169);
            BindLookUP(ddlProduct, 12);
        }

        protected void BindApplicants(int RoleId, DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = EntityMaintenanceData.GetEntitiesByRole(RoleId);
                ddList.DataValueField = "ApplicantId";
                ddList.DataTextField = "Applicantname";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
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
            dvNewAttribute.Visible = false;
            dvNewProduct.Visible = false;
            dvExistingEntities.Visible = false;
            dvNewEntirySubmit.Visible = false;
            dvAttachEntities.Visible = false;
            ClearForm();
            hfApplicatId.Value = "";

            if (rdBtnAction.SelectedValue.ToLower() == "existing")
            {
                cbActiveOnly.Visible = true;
            }
            else
            {
                cbActiveOnly.Visible = false;
            }
        }

        protected void ddlEntityRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayPanels();
            ClearForm();
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
            if (!IsAddressValid()) return;

            int ApplicantId = Convert.ToInt32(hfApplicatId.Value);

            if (btnAddAddress.Text.ToLower() == "add")
            {
                EntityMaintResult objEntityMaintResult = EntityMaintenanceData.AddNewEntityAddress(ApplicantId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, txtState.Text, txtZip.Text,
                       txtCounty.Text, int.Parse(ddlAddressType.SelectedValue.ToString()), DataUtils.GetDecimal(txtLattitude.Text), DataUtils.GetDecimal(txtLongitude.Text), cbDefaultAddress.Checked);

                btnAddAddress.Text = "Add";

                if (objEntityMaintResult.IsDuplicate && !objEntityMaintResult.IsActive)
                    LogMessage("Address already exist as in-active");
                else if (objEntityMaintResult.IsDuplicate)
                    LogMessage("Address already exist");
                else
                    LogMessage("New Address added successfully");
            }
            else
            {
                int AddressId = Convert.ToInt32(hfAddressId.Value);

                EntityMaintenanceData.UpdateEntityAddress(ApplicantId, AddressId, int.Parse(ddlAddressType.SelectedValue.ToString()), txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text,
                    txtState.Text, txtZip.Text, txtCounty.Text, cbActive.Checked, DataUtils.GetDecimal(txtLattitude.Text), DataUtils.GetDecimal(txtLongitude.Text), cbDefaultAddress.Checked);

                hfAddressId.Value = "";
                btnAddAddress.Text = "Add";
                LogMessage("Address Updated Successfully");
            }
            gvAddress.EditIndex = -1;
            BindAddressGrid();
            ClearAddressForm();
            dvAddressGrid.Visible = true;
            cbAddAddress.Checked = false;
        }

        private void BindGrids()
        {
            BindAddressGrid();
            BindAttributeGrid();
            BindProductGrid();
            BindAttachEntitiesGrid();
        }

        private void BindAddressGrid()
        {
            try
            {
                DataTable dtAddress = EntityMaintenanceData.GetEntityAddressDetailsList(DataUtils.GetInt(hfApplicatId.Value), cbActiveOnly.Checked);

                if (dtAddress.Rows.Count > 0)
                {
                    dvAddressGrid.Visible = true;
                    gvAddress.DataSource = dtAddress;
                    gvAddress.DataBind();
                }
                else
                {
                    dvAddressGrid.Visible = false;
                    gvAddress.DataSource = null;
                    gvAddress.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAddressGrid", "", ex.Message);
            }
        }

        private void ClearAddressForm()
        {
            txtStreetNo.Text = "";
            txtAddress1.Text = "";
            txtAddress2.Text = "";
            txtTown.Text = "";
            //ddlTown.SelectedIndex = -1;
            txtState.Text = "";
            txtZip.Text = "";
            txtCounty.Text = "";
            //ddlCounty.SelectedIndex = -1;
            ddlAddressType.SelectedIndex = -1;
            txtLattitude.Text = "";
            txtLongitude.Text = "";
            cbActive.Checked = true;
            cbActive.Enabled = true;
            cbDefaultAddress.Checked = true;
            cbDefaultAddress.Enabled = true;
        }

        protected bool IsAddressValid()
        {
            if (ddlAddressType.Items.Count > 1 && ddlAddressType.SelectedIndex == 0)
            {
                LogMessage("Select Address Type");
                ddlAddressType.Focus();
                return false;
            }
            if (txtStreetNo.Text.Trim() == "")
            {
                LogMessage("Enter Street#");
                txtStreetNo.Focus();
                return false;
            }
            if (txtAddress1.Text.Trim() == "")
            {
                LogMessage("Enter Address1");
                txtAddress1.Focus();
                return false;
            }
            if (txtZip.Text.Trim() == "")
            {
                LogMessage("Enter Zip");
                txtZip.Focus();
                return false;
            }
            if (txtTown.Text.Trim() == "")
            {
                LogMessage("Enter Town");
                txtTown.Focus();
                return false;
            }
            if (txtState.Text.Trim() == "")
            {
                LogMessage("Enter State");
                txtState.Focus();
                return false;
            }
            return true;
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
            if (IsEntityFormValid())
            {
                if (btnEntitySubmit.Text == "Submit")
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
                        LogMessage("New Entity Added Successfully");
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
                        LogMessage("New Entity Added Successfully");
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
                        LogMessage("New Entity Added Successfully");
                    }
                }
                else
                {
                    string HomePhoneNumber = new string(txtHomePhone.Text.Where(c => char.IsDigit(c)).ToArray());
                    string WorkPhoneNumber = new string(txtWorkPhone.Text.Where(c => char.IsDigit(c)).ToArray());
                    string CellPhoneNumber = new string(txtCellPhone.Text.Where(c => char.IsDigit(c)).ToArray());

                    EntityMaintenanceData.UpdateEntity(DataUtils.GetInt(ddlEntityName.SelectedValue.ToString()), DataUtils.GetInt(ddlEntityType.SelectedValue.ToString()), DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text,
                           txtEmail.Text, HomePhoneNumber, WorkPhoneNumber, CellPhoneNumber, txtStateVendorId.Text, txtApplicantName.Text, txtFirstName.Text, txtLastName.Text, DataUtils.GetInt(ddlPosition.SelectedValue.ToString()),
                           txtTitle.Text, txtFarmName.Text, DataUtils.GetInt(ddlFarmType.SelectedValue.ToString()), DataUtils.GetInt(txtAcresInProduction.Text), DataUtils.GetInt(txtAcresOwned.Text),
                           DataUtils.GetInt(txtAcresLeased.Text), DataUtils.GetInt(txtAcresLeasedOut.Text), DataUtils.GetInt(txtTotalAcres.Text), cbIsNoLongerBusiness.Checked, txtNotes.Text, txtAgrEdu.Text,
                           DataUtils.GetInt(txtYearsManagingForm.Text));
                    ClearForm();
                    PopulateEntity(DataUtils.GetInt(ddlEntityName.SelectedValue.ToString()), DataUtils.GetInt(ddlEntityRole.SelectedValue.ToString()));
                    LogMessage("Entity Updated Successfully");
                }
            }
        }

        private void PopulateEntity(int ApplicantId, int EntityRole)
        {
            rdBtnAction.SelectedIndex = 1;
            RadioButtonSelectionChanged();
            dvExistingEntities.Visible = true;

            PopulateDropDown(ddlEntityRole, EntityRole.ToString());

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
            ClearAddressForm();

            if (ddlEntityName.SelectedIndex != 0)
            {
                DisplayPanelsBasedOnEntityRole();

                hfApplicatId.Value = ddlEntityName.SelectedValue.ToString();

                DataRow drEntityData = EntityMaintenanceData.GetEntityData(DataUtils.GetInt(ddlEntityName.SelectedValue.ToString()));
                if (drEntityData != null)
                {
                    PopulateForm(drEntityData);
                    dvNewAddress.Visible = true;

                    if (ddlEntityRole.SelectedItem.ToString().ToLower() == "farm")
                    {
                        dvNewAttribute.Visible = true;
                        dvNewProduct.Visible = true;
                        dvAttachEntities.Visible = true;
                        BindApplicants(26243, ddlIndividualApplicant);
                    }
                    else
                    {
                        if (ddlEntityRole.SelectedItem.ToString().ToLower() == "organization")
                        {
                            dvAttachEntities.Visible = true;
                            BindApplicants(26243, ddlIndividualApplicant);
                        }
                        else
                        {
                            dvAttachEntities.Visible = false;
                        }

                        dvNewAttribute.Visible = false;
                        dvNewProduct.Visible = false;
                    }

                    BindGrids();
                    btnEntitySubmit.Text = "Update";
                }
            }
            else
            {
                dvCommonForm.Visible = false;
                dvIndividual.Visible = false;
                dvFarm.Visible = false;
                dvNewAddress.Visible = false;
                dvNewEntirySubmit.Visible = false;
                dvNewAttribute.Visible = false;
                dvNewProduct.Visible = false;

                cbAddAddress.Checked = false;
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
            hfFarmId.Value = drEntityData["FarmId"].ToString();
            PopulateDropDown(ddlEntityType, drEntityData["LkEntityType"].ToString());
            txtFiscalYearEnd.Text = drEntityData["FYend"].ToString();
            txtWebsite.Text = drEntityData["website"].ToString();

            if (drEntityData["WorkPhone"].ToString().Trim() == "")
                txtWorkPhone.Text = "";
            else
                txtWorkPhone.Text = String.Format("{0:(###)###-####}", double.Parse(drEntityData["WorkPhone"].ToString()));

            if (drEntityData["CellPhone"].ToString().Trim() == "")
                txtCellPhone.Text = "";
            else
                txtCellPhone.Text = String.Format("{0:(###)###-####}", double.Parse(drEntityData["CellPhone"].ToString()));

            if (drEntityData["HomePhone"].ToString().Trim() == "")
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

        protected void gvAddress_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbAddAddress.Checked = false;
            ClearAddressForm();
            btnAddAddress.Text = "Add";
            gvAddress.EditIndex = -1;
            BindAddressGrid();
        }

        protected void gvAddress_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddAddress.Text = "Update";
                    cbAddAddress.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[10].Controls[0].Visible = false;
                        Label lblAddressId = e.Row.FindControl("lblAddressId") as Label;
                        DataRow dr = EntityMaintenanceData.GetEntityAddressDetailsById(DataUtils.GetInt(hfApplicatId.Value), Convert.ToInt32(lblAddressId.Text));

                        hfAddressId.Value = lblAddressId.Text;

                        PopulateDropDown(ddlAddressType, dr["LkAddressType"].ToString());
                        txtStreetNo.Text = dr["Street#"].ToString();
                        txtAddress1.Text = dr["Address1"].ToString();
                        txtAddress2.Text = dr["Address2"].ToString();
                        txtTown.Text = dr["Town"].ToString(); ;
                        txtState.Text = dr["State"].ToString();
                        txtZip.Text = dr["Zip"].ToString();
                        txtCounty.Text = dr["County"].ToString();
                        txtLattitude.Text= dr["latitude"].ToString();
                        txtLongitude.Text= dr["longitude"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbDefaultAddress.Checked = DataUtils.GetBool(dr["DefAddress"].ToString());

                        if (cbDefaultAddress.Checked)
                        {
                            cbDefaultAddress.Enabled = false;
                            cbActive.Enabled = false;
                        }
                        else
                        {
                            cbDefaultAddress.Enabled = true;
                            cbActive.Enabled = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAddress_RowDataBound", "", ex.Message);
            }
        }

        protected void gvAddress_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAddress.EditIndex = e.NewEditIndex;
            BindAddressGrid();
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected bool IsEntityFormValid()
        {
            if (ddlEntityType.Items.Count > 1 && ddlEntityType.SelectedIndex == 0)
            {
                LogMessage("Select Entity Type");
                ddlEntityType.Focus();
                return false;
            }

            if (ddlEntityRole.SelectedItem.ToString().ToLower() == "individual")
            {
                if (txtFirstName.Text.Trim() == "")
                {
                    LogMessage("Enter First Name");
                    txtFirstName.Focus();
                    return false;
                }
                if (txtLastName.Text.Trim() == "")
                {
                    LogMessage("Enter Last Name");
                    txtLastName.Focus();
                    return false;
                }
            }
            else if (ddlEntityRole.SelectedItem.ToString().ToLower() == "organization")
            {
                if (txtApplicantName.Text.Trim() == "")
                {
                    LogMessage("Enter Applicant Name");
                    txtApplicantName.Focus();
                    return false;
                }
            }
            else if (ddlEntityRole.SelectedItem.ToString().ToLower() == "farm")
            {
                if (ddlFarmType.Items.Count > 1 && ddlFarmType.SelectedIndex == 0)
                {
                    LogMessage("Select Farm Type");
                    ddlFarmType.Focus();
                    return false;
                }
                if (txtFarmName.Text.Trim() == "")
                {
                    LogMessage("Enter Farm Name");
                    txtFarmName.Focus();
                    return false;
                }
            }

            return true;
        }

        protected void AddAttribute_Click(object sender, EventArgs e)
        {
            if (ddlAttribute.SelectedIndex == 0)
            {
                LogMessage("Select Attribute");
                ddlAttribute.Focus();
                return;
            }

            FormAttributeResult obAttributeResult = EntityMaintenanceData.AddFarmAttribute(DataUtils.GetInt(hfFarmId.Value),
                DataUtils.GetInt(ddlAttribute.SelectedValue.ToString()));
            ddlAttribute.SelectedIndex = -1;
            cbAddAttribute.Checked = false;

            BindAttributeGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Attribute already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Attribute already exist");
            else
                LogMessage("New Attribute added successfully");
        }

        private void BindAttributeGrid()
        {
            try
            {
                DataTable dt = EntityMaintenanceData.GetFarmAttributesList(DataUtils.GetInt(hfFarmId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAttributeGrid.Visible = true;
                    gvAttribute.DataSource = dt;
                    gvAttribute.DataBind();
                }
                else
                {
                    dvAttributeGrid.Visible = false;
                    gvAttribute.DataSource = null;
                    gvAttribute.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAttributeGrid", "", ex.Message);
            }
        }

        protected void gvAttribute_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAttribute.EditIndex = e.NewEditIndex;
            BindAttributeGrid();
        }

        protected void gvAttribute_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAttribute.EditIndex = -1;
            BindAttributeGrid();
        }

        protected void gvAttribute_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int FarmAttributeID = DataUtils.GetInt(((Label)gvAttribute.Rows[rowIndex].FindControl("lblFarmAttributeID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAttribute.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            EntityMaintenanceData.UpdateFarmAttribute(FarmAttributeID, RowIsActive);
            gvAttribute.EditIndex = -1;

            BindAttributeGrid();

            LogMessage("Attribute updated successfully");
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            if (ddlProduct.SelectedIndex == 0)
            {
                LogMessage("Select Product");
                ddlProduct.Focus();
                return;
            }

            if (txtStartDate.Text.Trim() == "")
            {
                LogMessage("Enter Start Date");
                txtStartDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtStartDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Start Date");
                    txtStartDate.Focus();
                    return;
                }
            }

            FormAttributeResult obAttributeResult = EntityMaintenanceData.AddFarmProducts(DataUtils.GetInt(hfFarmId.Value),
                DataUtils.GetInt(ddlProduct.SelectedValue.ToString()), DataUtils.GetDate(txtStartDate.Text));
            ddlProduct.SelectedIndex = -1;
            txtStartDate.Text = "";
            cbAddProduct.Checked = false;

            BindProductGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Product already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Product already exist");
            else
                LogMessage("New Product added successfully");
        }

        protected void gvProduct_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProduct.EditIndex = e.NewEditIndex;
            BindProductGrid();
        }

        protected void gvProduct_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProduct.EditIndex = -1;
            BindProductGrid();
        }

        protected void gvProduct_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int FarmProductsID = DataUtils.GetInt(((Label)gvProduct.Rows[rowIndex].FindControl("lblFarmProductsID")).Text);
            DateTime StartDate = Convert.ToDateTime(((TextBox)gvProduct.Rows[rowIndex].FindControl("txtStartDate")).Text);
            //int LkDisp = DataUtils.GetInt(((DropDownList)gvMajor.Rows[rowIndex].FindControl("ddlMjrDispositionE")).SelectedValue.ToString());
            //DateTime DispDate = Convert.ToDateTime(((TextBox)gvMajor.Rows[rowIndex].FindControl("txtDispDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvProduct.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            EntityMaintenanceData.UpdateFarmProducts(FarmProductsID, RowIsActive, StartDate);

            gvProduct.EditIndex = -1;

            BindProductGrid();

            LogMessage("Product Updated successfully");
        }

        private void BindProductGrid()
        {
            try
            {
                DataTable dt = EntityMaintenanceData.GetFarmProductsList(DataUtils.GetInt(hfFarmId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvProductGrid.Visible = true;
                    gvProduct.DataSource = dt;
                    gvProduct.DataBind();
                }
                else
                {
                    dvProductGrid.Visible = false;
                    gvProduct.DataSource = null;
                    gvProduct.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProductGrid", "", ex.Message);
            }
        }

        protected void btnAttachEntities_Click(object sender, EventArgs e)
        {
            if (ddlIndividualApplicant.SelectedIndex == 0)
            {
                LogMessage("Select Applicant");
                ddlIndividualApplicant.Focus();
                return;
            }
            
            FormAttributeResult obAttributeResult = EntityMaintenanceData.AddApplicantApplicant(DataUtils.GetInt(hfApplicatId.Value),
                DataUtils.GetInt(ddlIndividualApplicant.SelectedValue.ToString()));

            ddlIndividualApplicant.SelectedIndex = -1;
            cbAttachEntities.Checked = false;

            BindAttachEntitiesGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Entity already attached as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Entity already attached");
            else
                LogMessage("Entity added successfully");
        }

        private void BindAttachEntitiesGrid()
        {
            try
            {
                DataTable dt = EntityMaintenanceData.GetApplicantApplicantList(DataUtils.GetInt(hfApplicatId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAttachEntitiesGrid.Visible = true;
                    gvAttachEntities.DataSource = dt;
                    gvAttachEntities.DataBind();
                }
                else
                {
                    dvAttachEntitiesGrid.Visible = false;
                    gvAttachEntities.DataSource = null;
                    gvAttachEntities.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAttachEntitiesGrid", "", ex.Message);
            }
        }

        protected void gvAttachEntities_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAttachEntities.EditIndex = -1;
            BindAttachEntitiesGrid();
        }

        protected void gvAttachEntities_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAttachEntities.EditIndex = e.NewEditIndex;
            BindAttachEntitiesGrid();
        }

        protected void gvAttachEntities_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ApplicantApplicantId = DataUtils.GetInt(((Label)gvAttachEntities.Rows[rowIndex].FindControl("lblApplicantApplicantId")).Text);
            //DateTime StartDate = Convert.ToDateTime(((TextBox)gvProduct.Rows[rowIndex].FindControl("txtStartDate")).Text);
            //int LkDisp = DataUtils.GetInt(((DropDownList)gvAttachEntities.Rows[rowIndex].FindControl("ddlMjrDispositionE")).SelectedValue.ToString());
            //DateTime DispDate = Convert.ToDateTime(((TextBox)gvMajor.Rows[rowIndex].FindControl("txtDispDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAttachEntities.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            EntityMaintenanceData.UpdateApplicantApplicant(ApplicantApplicantId, RowIsActive);

            gvAttachEntities.EditIndex = -1;

            BindAttachEntitiesGrid();

            LogMessage("Attached Entity Updated successfully");
        }
    }
}