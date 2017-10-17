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
    public partial class HOPWAManagement : System.Web.UI.Page
    {
        string Pagename = "HOPWAManagement";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                BindControls();
                BindGrids();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlPrimaryASO, 232);
            BindLookUP(ddlEthnicity, 190);
            BindLookUP(ddlRace, 191);
            BindLookUP(ddlGMI, 192);
            BindLookUP(ddlAMI, 178);
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
            
        }

        private void BindGrids()
        {
            BindHOPWAanMasterGrid();
        }

        protected void btnHOPWAMaster_Click(object sender, EventArgs e)
        {
            if (btnHOPWAMaster.Text == "Add")
            {
                HOPWAmainttResult objHOPWAmainttResult = HOPWAMaintenanceData.AddHOPWAMaster(txtUUID.Text, txtHHIncludes.Text, DataUtils.GetInt(ddlPrimaryASO.SelectedValue.ToString()), DataUtils.GetInt(txtWithHIV.Text),
                    DataUtils.GetInt(txtInHouseHold.Text), DataUtils.GetInt(txtMinors.Text), DataUtils.GetInt(txtGender.Text), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()), 
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), DataUtils.GetInt(ddlGMI.SelectedValue.ToString()), DataUtils.GetInt(ddlAMI.SelectedValue.ToString()), DataUtils.GetInt(txtBeds.Text), txtNotes.Text);

                if (objHOPWAmainttResult.IsDuplicate && !objHOPWAmainttResult.IsActive)
                    LogMessage("HOPWA UUID already exist as in-active");
                else if (objHOPWAmainttResult.IsDuplicate)
                    LogMessage("HOPWA UUID already exist");
                else
                    LogMessage("HOPWA UUID added successfully");

                gvHOPWAMaster.EditIndex = -1;
                dvHOPWAMaster.Visible = true;
                cbAddHOPWAMaster.Checked = false;
            }
            else
            {
                HOPWAMaintenanceData.UpdateHOPWAMaster(DataUtils.GetInt(hfHOPWAId.Value), txtHHIncludes.Text, DataUtils.GetInt(ddlPrimaryASO.SelectedValue.ToString()), DataUtils.GetInt(txtWithHIV.Text),
                    DataUtils.GetInt(txtInHouseHold.Text), DataUtils.GetInt(txtMinors.Text), DataUtils.GetInt(txtGender.Text), DataUtils.GetInt(txtAge.Text), DataUtils.GetInt(ddlEthnicity.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlRace.SelectedValue.ToString()), DataUtils.GetInt(ddlGMI.SelectedValue.ToString()), DataUtils.GetInt(ddlAMI.SelectedValue.ToString()), DataUtils.GetInt(txtBeds.Text), txtNotes.Text, 
                    cbHOPWAMaster.Checked);

                LogMessage("HOPWA Master updated successfully");

                hfHOPWAId.Value = "";
                btnHOPWAMaster.Text = "Add";
                cbAddHOPWAMaster.Checked = false;
                gvHOPWAMaster.EditIndex = -1;
            }
            ClearHOPWAMasterForm();
            BindHOPWAanMasterGrid();
        }

        private void BindHOPWAanMasterGrid()
        {
            //dvHOPWAMaster.Visible = false;
            //dvNewEvent.Visible = false;
            //dvTransaction.Visible = false;
            //dvNotes.Visible = false;

            try
            {
                DataTable dtLoanMasterDetails = HOPWAMaintenanceData.GetHOPWAMasterList(cbActiveOnly.Checked);

                if (dtLoanMasterDetails.Rows.Count > 0)
                {
                    dvHOPWAMasterGrid.Visible = true;
                    gvHOPWAMaster.DataSource = dtLoanMasterDetails;
                    gvHOPWAMaster.DataBind();
                }
                else
                {
                    dvHOPWAMasterGrid.Visible = false;
                    gvHOPWAMaster.DataSource = null;
                    gvHOPWAMaster.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWAanMasterGrid", "", ex.Message);
            }
        }

        private void ClearHOPWAMasterForm()
        {
            txtUUID.Text = "";
            txtHHIncludes.Text = "";
            ddlPrimaryASO.SelectedIndex = -1;
            txtWithHIV.Text = "";
            txtInHouseHold.Text = "";
            txtMinors.Text = "";
            txtGender.Text = "";
            txtAge.Text = "";
            ddlEthnicity.SelectedIndex = -1;
            ddlRace.SelectedIndex = -1;
            ddlGMI.SelectedIndex = -1;
            ddlAMI.SelectedIndex = -1;
            txtBeds.Text = "";
            txtNotes.Text = "";
        }

        protected void gvHOPWAMaster_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvHOPWAMaster_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gvHOPWAMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvHOPWAMaster_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void rdBtnSelectHOPWA_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}