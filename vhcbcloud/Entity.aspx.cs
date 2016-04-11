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
    public partial class Entity : System.Web.UI.Page
    {
        string Pagename = "Entity";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if(cbInd.Checked)
                this.txtApplicantName.Text = this.txtLastName.Text + ", " + this.txtFirstName.Text;

            if (!IsPostBack)
            {
                DisplayControls();
                BindApplicants();
                BindControls();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlEntityType, 103);
            BindLookUP(ddlPhoneType, 29);
            BindLookUP(ddlPosition, 117);
            //BindLookUP(ddlTown, 89);
            BindLookUP(ddlAddressType, 1);
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

        protected void rdBtnIndividual_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindApplicants();
            DisplayControls();
            CleanForms();
        }

        protected void DisplayControls()
        {
            dvAddressGrid.Visible = false;
            cbInd.Enabled = true;

            if (rdBtnIndividual.SelectedValue.ToLower() == "existing")
            {
                //dvGrid.Visible = true;
                dvExistingSearch.Visible = true;
                dvCommonForm.Visible = false;
                dvIndividual.Visible = false;
                dvAddress.Visible = false;

                dvSubmit.Visible = false;
                btnEntitySubmit.Text = "Update";

                dvAddressButton.Visible = true;
                btnAddAddress.Visible = true;
                //BindApplicants();
            }
            else
            {
                dvCommonForm.Visible = true;
                dvIndividual.Visible = true;
                dvAddress.Visible = true;

                dvSubmit.Visible = true;
                btnEntitySubmit.Text = "Submit";

                //dvGrid.Visible = false;
                dvExistingSearch.Visible = false;
                dvAddressButton.Visible = false;
                btnAddAddress.Visible = false;
            }
        }

        private void CleanForms()
        {
            cbInd.Checked = false;
            ddlEntityType.SelectedIndex = -1;
            txtFiscalYearEnd.Text = "";
            txtWebsite.Text = "";
            txtStateVendorId.Text = "";
            ddlPhoneType.SelectedIndex = -1;
            ddlPhoneType.SelectedIndex = -1; ;
            txtPhone.Text = "";
            txtApplicantName.Text = "";

            txtFirstName.Text = "";
            txtLastName.Text = "";
            ddlPosition.SelectedIndex = -1;
            txtTitle.Text = "";
            txtEmail.Text = "";

            ClearaddressInfo();
        }

        protected void BindApplicants()
        {
            try
            {
                ddlApplicantNameSearch.Items.Clear();
                ddlApplicantNameSearch.DataSource = ApplicantData.GetSortedApplicants();
                ddlApplicantNameSearch.DataValueField = "appnameid";
                ddlApplicantNameSearch.DataTextField = "Applicantname";
                ddlApplicantNameSearch.DataBind();
                ddlApplicantNameSearch.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
            }
        }

        private void BindApplicantAddressGrid()
        {
            try
            {
                DataTable dtAddress = EntityData.GetApplicantAddressDetails(int.Parse(ddlApplicantNameSearch.SelectedValue.ToString()));

                if (dtAddress.Rows != null)
                    FillAddressDetailsWithExistingData(dtAddress);
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicantAddressGrid", "", ex.Message);
            }
        }

        private void FillAddressDetailsWithExistingData(DataTable dataTable)
        {
            if (dataTable.Rows.Count > 0)
            {
                dvAddressGrid.Visible = true;
                gvAddress.DataSource = dataTable;
                gvAddress.DataBind();
            }
            else
                dvAddressGrid.Visible = false;
        }

        private void FillFormsWithExistingData(DataRow dr)
        {
            try
            {
                hfApplicatId.Value = dr["ApplicantID"].ToString();

                cbInd.Checked = DataUtils.GetBool(dr["Individual"].ToString());

                if (!cbInd.Checked)
                    cbInd.Enabled = false;
                else
                    cbInd.Enabled = true;

                if (DataUtils.GetBool(dr["Individual"].ToString()))
                {
                    dvIndividual.Visible = true;
                    txtFirstName.Text = dr["Firstname"].ToString();
                    txtLastName.Text = dr["Lastname"].ToString();

                    ddlPosition.ClearSelection();
                    foreach (ListItem item in ddlPosition.Items)
                    {
                        if (dr["LkPosition"].ToString() == item.Value.ToString())
                        {
                            item.Selected = true;
                            break;
                        }
                    }
                    txtTitle.Text = dr["Title"].ToString();
                    txtEmail.Text = dr["email"].ToString();
                }
                else
                    dvIndividual.Visible = false;

                ddlEntityType.ClearSelection();
                //ddlEntityType.SelectedValue = dr["LkEntityType"].ToString();
                foreach (ListItem item in ddlEntityType.Items)
                {
                    if (dr["LkEntityType"].ToString() == item.Value.ToString())
                    {
                        item.Selected = true;
                        break;
                    }
                }
                txtFiscalYearEnd.Text = dr["FYend"].ToString();
                txtWebsite.Text = dr["website"].ToString();
                txtStateVendorId.Text = dr["Stvendid"].ToString();
                ddlPhoneType.ClearSelection();
                foreach (ListItem item in ddlPhoneType.Items)
                {
                    if (dr["LkPhoneType"].ToString() == item.Value.ToString())
                    {
                        item.Selected = true;
                        break;
                    }
                }

                if(dr["Phone"].ToString() == "")
                    txtPhone.Text = "";
                else
                    txtPhone.Text = String.Format("{0:(###)###-####}", double.Parse(dr["Phone"].ToString()));

                
                txtApplicantName.Text = dr["applicantname"].ToString();

                //txtStreetNo.Text = "";
                //txtAddress1.Text = "";
                //txtAddress2.Text = "";
                //ddlTown.SelectedIndex = -1;
                //txtState.Text = "";
                //txtZip.Text = "";
                //ddlCounty.SelectedIndex = -1;
                //ddlAddressType.SelectedIndex = -1;
                //cbIsActive.Checked = false;
                //cbIsDefault.Checked = false;
            }
            catch (Exception ex)
            {
                LogError(Pagename, "FillFormsWithExistingData", "", ex.Message);
            }
        }

        protected void gvAddress_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);

                    dvAddress.Visible = true;
                    btnAddress.Text = "Update";
                    btnAddAddress.Visible = false;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        Label lblAddressId = e.Row.FindControl("lblAddressId") as Label;
                        DataRow dr = EntityData.GetAddressDetailsByAddressId(Convert.ToInt32(lblAddressId.Text));

                        hfAddressId.Value = lblAddressId.Text;

                        txtStreetNo.Text = dr["Street#"].ToString();
                        txtAddress1.Text = dr["Address1"].ToString();
                        txtAddress2.Text = dr["Address2"].ToString();
                        txtTown.Text = dr["Town"].ToString(); ;
                        //ddlTown.SelectedIndex = -1;
                        txtState.Text = dr["State"].ToString();
                        txtZip.Text = dr["Zip"].ToString();
                        txtCounty.Text = dr["County"].ToString();
                        // ddlCounty.SelectedIndex = -1;

                        ddlAddressType.ClearSelection();
                        foreach (ListItem item in ddlAddressType.Items)
                        {
                            if (dr["LkAddressType"].ToString() == item.Value.ToString())
                            {
                                item.Selected = true;
                                break;
                            }
                        }

                        cbIsActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        cbIsDefault.Checked = DataUtils.GetBool(dr["Defaddress"].ToString());

                        if (cbIsDefault.Checked)
                        {
                            cbIsDefault.Enabled = false;
                            cbIsActive.Enabled = false;
                        }
                        else
                        {
                            cbIsDefault.Enabled = true;
                            cbIsActive.Enabled = true;
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
            BindApplicantAddressGrid();
        }

        protected void gvAddress_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ClearaddressInfo();
            btnAddress.Text = "Add";
            dvAddress.Visible = false;
            gvAddress.EditIndex = -1;
            BindApplicantAddressGrid();
        }

        private void ClearaddressInfo()
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
            cbIsActive.Checked = true;
            cbIsDefault.Checked = true;

            cbIsActive.Enabled = true;
            cbIsDefault.Enabled = true;
        }

        protected bool IsAddressValid()
        {
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
            if (ddlAddressType.Items.Count > 1 && ddlAddressType.SelectedIndex == 0)
            {
                LogMessage("Select Address Type");
                ddlAddressType.Focus();
                return false;
            }
            return true;
        }

        protected bool IsEntiryFormValid(bool isAddressRequired)
        {
            if (ddlEntityType.Items.Count > 1 && ddlEntityType.SelectedIndex == 0)
            {
                LogMessage("Select Entity Type");
                ddlEntityType.Focus();
                return false;
            }

            if (!cbInd.Checked)
            {
                if (txtApplicantName.Text.Trim() == "")
                {
                    LogMessage("Enter Applicant Name");
                    txtApplicantName.Focus();
                    return false;
                }
            }

            if (cbInd.Checked)
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

            if (isAddressRequired)
                return IsAddressValid();
            else return true;
        }

        //protected void btnApplicantSearch_Click(object sender, EventArgs e)
        //{
            //try
            //{
            //    hfApplicatId.Value = "";

            //    if (ddlApplicantNameSearch.Items.Count > 1 && ddlApplicantNameSearch.SelectedIndex == 0)
            //    {
            //        LogMessage("Select Applicant Name");
            //        ddlApplicantNameSearch.Focus();
            //        return;
            //    }

            //    DataTable dt = EntityData.GetApplicantDetails(int.Parse(ddlApplicantNameSearch.SelectedValue.ToString()));

            //    if (dt.Rows != null)
            //        FillFormsWithExistingData(dt.Rows[0]);

            //    dvCommonForm.Visible = true;
            //    dvIndividual.Visible = true;
            //    dvAddress.Visible = false;
            //    dvAddressButton.Visible = true;
            //    gvAddress.EditIndex = -1;
            //    BindApplicantAddressGrid();
            //    dvSubmit.Visible = true;
                
            //    btnAddAddress.Visible = true;
            //}
            //catch (Exception ex)
            //{
            //    LogError(Pagename, "btnApplicantSearch_Click", "", ex.Message);
            //}
        //}

        protected void btnAddress_Click(object sender, EventArgs e)
        {
            try
            {
                if (!IsAddressValid()) return;

                int applicantId = Convert.ToInt32(hfApplicatId.Value);

                if (btnAddress.Text.ToLower() == "update")
                {
                    int addressId = Convert.ToInt32(hfAddressId.Value);

                    EntityData.UpdateApplicantAddress(applicantId, addressId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, //ddlTown.SelectedItem.Text, 
                        txtState.Text, txtZip.Text, txtCounty.Text,
                        int.Parse(ddlAddressType.SelectedValue.ToString()), cbIsActive.Checked, cbIsDefault.Checked);

                    hfAddressId.Value = "";
                    btnAddress.Text = "Add";
                    LogMessage("Address updated successfully");
                }

                else //Add
                {
                    EntityData.AddApplicantAddress(applicantId, txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, //ddlTown.SelectedItem.Text, 
                        txtState.Text, txtZip.Text,
                        txtCounty.Text, //ddlCounty.SelectedValue.ToString(), 
                        int.Parse(ddlAddressType.SelectedValue.ToString()), cbIsActive.Checked, cbIsDefault.Checked);

                   // hfApplicatId.Value = "";
                    btnAddress.Text = "Add";
                    LogMessage("New Address added successfully");
                }
                BindApplicantAddressGrid();
                ClearAddressPanel();
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddress_Click", "", ex.Message);
            }
        }

        protected void btnEntitySubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (btnEntitySubmit.Text.ToLower() == "submit")
                {
                    if (IsEntiryFormValid(true))
                    {
                        string PhoneNumber = new string(txtPhone.Text.Where(c => char.IsDigit(c)).ToArray());

                        if (cbInd.Checked)
                            EntityData.AddEntity(cbInd.Checked, int.Parse(ddlEntityType.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text, txtStateVendorId.Text,
                               DataUtils.GetInt(ddlPhoneType.SelectedValue.ToString()), PhoneNumber, txtApplicantName.Text, 
                               txtFirstName.Text, txtLastName.Text, DataUtils.GetInt(ddlPosition.SelectedValue.ToString()), txtTitle.Text, txtEmail.Text,
                               txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, 
                               txtState.Text, txtZip.Text, txtCounty.Text,
                               DataUtils.GetInt(ddlAddressType.SelectedValue.ToString()),
                               cbIsActive.Checked, cbIsDefault.Checked);
                        else
                            EntityData.AddEntity(cbInd.Checked, int.Parse(ddlEntityType.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text, txtStateVendorId.Text,
                               DataUtils.GetInt(ddlPhoneType.SelectedValue.ToString()), PhoneNumber, txtApplicantName.Text, null,
                               null, 0, null, null,
                               txtStreetNo.Text, txtAddress1.Text, txtAddress2.Text, txtTown.Text, 
                               txtState.Text, txtZip.Text, txtCounty.Text, DataUtils.GetInt(ddlAddressType.SelectedValue.ToString()),
                               cbIsActive.Checked, cbIsDefault.Checked);

                        LogMessage("New Entity added successfully");
                        CleanForms();
                    }
                }
                else
                {
                    if (hfApplicatId.Value != null && hfApplicatId.Value != "")
                    {
                        //lblErrorMsg.Text = "Applicant ID:" + hfApplicatId.Value;
                        if (IsEntiryFormValid(false))
                        {
                            int ApplicantId = DataUtils.GetInt(hfApplicatId.Value);

                            string PhoneNumber = new string(txtPhone.Text.Where(c => char.IsDigit(c)).ToArray());

                            EntityData.UpdateApplicantDetails(ApplicantId, cbInd.Checked, int.Parse(ddlEntityType.SelectedValue.ToString()), txtFiscalYearEnd.Text, txtWebsite.Text, txtStateVendorId.Text,
                              DataUtils.GetInt(ddlPhoneType.SelectedValue.ToString()), PhoneNumber, txtApplicantName.Text, 
                              txtFirstName.Text, txtLastName.Text, DataUtils.GetInt(ddlPosition.SelectedValue.ToString()), txtTitle.Text, txtEmail.Text);

                            LogMessage("Applicant updated successfully");
                            TurnOffExistingFormControls();
                        }
                    }
                    else
                        LogMessage("Inavlid Applicant ID");
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnEntitySubmit_Click", "", ex.Message);
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

        protected void btnAddAddress_Click(object sender, EventArgs e)
        {
            dvAddress.Visible = true;
            btnAddAddress.Visible = false;
            ClearaddressInfo();
        }

        protected void btnAddressCancel_Click(object sender, EventArgs e)
        {
            ClearAddressPanel();
        }

        private void ClearAddressPanel()
        {
            ClearaddressInfo();
            btnAddress.Text = "Add";
            dvAddress.Visible = false;
            gvAddress.EditIndex = -1;
            BindApplicantAddressGrid();
            btnAddAddress.Visible = true;
        }

        protected void ddlApplicantNameSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                hfApplicatId.Value = "";

                if (ddlApplicantNameSearch.Items.Count > 1 && ddlApplicantNameSearch.SelectedIndex == 0)
                {
                    ddlApplicantNameSearch.Focus();
                    TurnOffExistingFormControls();
                    return;
                }

                DataTable dt = EntityData.GetApplicantDetails(int.Parse(ddlApplicantNameSearch.SelectedValue.ToString()));

                if (dt.Rows != null)
                    FillFormsWithExistingData(dt.Rows[0]);

                dvCommonForm.Visible = true;
                dvIndividual.Visible = true;
                dvAddress.Visible = false;
                dvAddressButton.Visible = true;
                gvAddress.EditIndex = -1;
                BindApplicantAddressGrid();
                dvSubmit.Visible = true;

                btnAddAddress.Visible = true;
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnApplicantSearch_Click", "", ex.Message);
            }
        }

        private void TurnOffExistingFormControls()
        {
            CleanForms();
            ddlApplicantNameSearch.SelectedIndex = -1;
            dvCommonForm.Visible = false;
            dvIndividual.Visible = false;
            dvAddress.Visible = false;
            dvSubmit.Visible = false;
            gvAddress.DataSource = null;
            gvAddress.DataBind();
            dvAddressGrid.Visible = false;
        }
    }
}