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
    public partial class FundMaintenance : System.Web.UI.Page
    {
        string Pagename = "FundMaintenance";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                BindControls();
            }
        }

        private void BindControls()
        {
            LoadFundNames();
            LoadFundNumbers();

            BindLookUP(ddlSOVFundCode, 207); 
            BindLookUP(ddlAcctMethod, 129);
            BindLookUP(ddlSOVDeptId, 209); 

            BindFundType();
        }

        private void BindFundType()
        {
            try
            {
                ddlFundType.DataSource = FundTypeData.GetFundType("GetFundTypeData");
                ddlFundType.DataValueField = "typeid";
                ddlFundType.DataTextField = "description";
                ddlFundType.DataBind();
                ddlFundType.Items.Insert(0, new ListItem("Select", "NA"));
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

        private void LoadFundNumbers()
        {
            try
            {
                ddlAcctNum.DataSource = FundMaintenanceData.GetFundNumbers(cbActiveOnly.Checked);
                ddlAcctNum.DataValueField = "fundid";
                ddlAcctNum.DataTextField = "account";
                ddlAcctNum.DataBind();
                ddlAcctNum.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void LoadFundNames()
        {
            try
            {
                ddlFundName.DataSource = FundMaintenanceData.GetFundName(cbActiveOnly.Checked);
                ddlFundName.DataValueField = "fundid";
                ddlFundName.DataTextField = "name";
                ddlFundName.DataBind();
                ddlFundName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            ClearForm();
            BindControls();
            cbAddFund.Checked = false;
        }

        protected void btnFundSearch_Click(object sender, EventArgs e)
        {
            if (ddlFundName.SelectedIndex == 0 && ddlAcctNum.SelectedIndex == 0)
            {
                LogMessage("Please select Fund name or Fund Number");
            }
            else
            {
                DataRow dt = null;
                ClearForm();

                if (ddlFundName.SelectedIndex != 0)
                    PopulateForm(FundMaintenanceData.SearchFund(Convert.ToInt32(ddlFundName.SelectedValue.ToString())));
                else if (ddlAcctNum.SelectedIndex != 0)
                    PopulateForm(FundMaintenanceData.SearchFund(Convert.ToInt32(ddlAcctNum.SelectedValue.ToString())));
            }
        }

        private void PopulateForm(DataRow dr)
        {
            if(dr != null)
            {
                ClearForm();

                cbAddFund.Checked = true;
                txtFundName.Text = dr["name"].ToString();
                txtAbbrev.Text = dr["abbrv"].ToString();
                PopulateDropDown(ddlFundType, dr["LkFundType"].ToString());
                txtFundNum.Text = dr["account"].ToString();
                PopulateDropDown(ddlSOVFundCode, dr["VHCBCode"].ToString());
                PopulateDropDown(ddlAcctMethod, dr["LkAcctMethod"].ToString());
                PopulateDropDown(ddlSOVDeptId, dr["DeptID"].ToString());
                cbFundActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                cbFundActive.Enabled = true;

                txtFundName.Enabled = false;

                btnSubmitFund.Text = "Update";
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

        private void ClearForm()
        {
            txtFundName.Enabled = true;
            txtFundName.Text = "";
            txtAbbrev.Text = "";
            ddlFundType.SelectedIndex = -1;
            txtFundNum.Text = "";
            ddlSOVFundCode.SelectedIndex = -1;
            ddlAcctMethod.SelectedIndex = -1;
            ddlSOVDeptId.SelectedIndex = -1;
            cbFundActive.Checked = true;
            cbFundActive.Enabled = false;
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

        protected void btnSubmitFund_Click(object sender, EventArgs e)
        {
            if (txtFundName.Text == "")
            {
                LogMessage("Please Enter Fund Name");
                txtFundName.Focus();
                return;
            }
            if (ddlFundType.SelectedIndex == 0)
            {
                LogMessage("Please Select Fund Type");
                ddlFundType.Focus();
                return;
            }
            if (txtFundNum.Text == "")
            {
                LogMessage("Please Enter Fund Number");
                txtFundNum.Focus();
                return;
            }

            if (btnSubmitFund.Text.ToLower() == "update")
            {
                FundMaintenanceData.UpdateFund(Convert.ToInt32(ddlFundName.SelectedValue.ToString()), txtAbbrev.Text,
                    Convert.ToInt32(ddlFundType.SelectedValue.ToString()),
                    txtFundNum.Text, ddlAcctMethod.SelectedValue == "NA" ? 0 : Convert.ToInt32(ddlAcctMethod.SelectedValue?.ToString()),
                    ddlSOVDeptId.SelectedValue.ToString(), ddlSOVFundCode.SelectedValue?.ToString(), cbFundActive.Checked);

                LogMessage("Fund updated successfully");
            }
            else
            {
                AddFund objAddFund = FundMaintenanceData.AddFund(txtFundName.Text, txtAbbrev.Text,
                    Convert.ToInt32(ddlFundType.SelectedValue?.ToString()),
                    txtFundNum.Text, ddlAcctMethod.SelectedValue == "NA" ? 0 : Convert.ToInt32(ddlAcctMethod.SelectedValue?.ToString()),
                    ddlSOVDeptId.SelectedValue.ToString(), ddlSOVFundCode.SelectedValue?.ToString());

                if (objAddFund.IsDuplicate && !objAddFund.IsActive)
                    LogMessage("Fund already exist as in-active");
                else if (objAddFund.IsDuplicate)
                    LogMessage("Fund already exist");
                else
                    LogMessage("New Fund added successfully");

                ClearForm();
                btnSubmitFund.Text = "Add";
            }
            BindControls();
            cbAddFund.Checked = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ddlFundName.SelectedIndex = -1;
            ddlAcctNum.SelectedIndex = -1;
            btnSubmitFund.Text = "Add";
            ClearForm();
            BindControls();
            cbAddFund.Checked = false;
        }

        protected void ddlFundName_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateDropDown(ddlAcctNum, ddlFundName.SelectedValue);
            ClearForm();
            cbAddFund.Checked = false;
        }

        protected void ddlAcctNum_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateDropDown(ddlFundName, ddlAcctNum.SelectedValue);
            ClearForm();
            cbAddFund.Checked = false;
        }
    }
}