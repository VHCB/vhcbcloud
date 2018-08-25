using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud.SetUp
{
    public partial class HOPWASetup : System.Web.UI.Page
    {
        string Pagename = "HOPWASetup";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
                LoadFundNames();
                PopulateHOPWADefaults();
                //BindHOPWADefGrid();
            }
        }

        private void PopulateHOPWADefaults()
        {
            DataTable dtHopwa = HOPWADefData.GetHOPWADefaults();

            if (dtHopwa.Rows.Count > 0)
            {
                hfHOPWADefaultID.Value = dtHopwa.Rows[0]["HOPWADefaultID"].ToString();
                txtYear.Text = dtHopwa.Rows[0]["Year"].ToString();
                txtStartDate.Text = Convert.ToDateTime(dtHopwa.Rows[0]["FundStartDate"].ToString()).ToShortDateString();
                txtEndDate.Text = Convert.ToDateTime(dtHopwa.Rows[0]["FundEndDate"].ToString()).ToShortDateString();
                txtSTRMUMaxAmt.Text = dtHopwa.Rows[0]["STRMUMaxAmt"].ToString();
                PopulateDropDown(ddlFund, dtHopwa.Rows[0]["CurrentFund"].ToString());
                PopulateDropDown(ddlPrevFund, dtHopwa.Rows[0]["PreviousFund"].ToString());
                cbIsCurrent.Checked = DataUtils.GetBool(dtHopwa.Rows[0]["IsCurrent"].ToString());
                AddHOPWADef.Text = "Update";
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
        protected void AddHOPWADef_Click(object sender, EventArgs e)
        {
            try
            {
                if (AddHOPWADef.Text.ToLower() == "add")
                {
                    HOPWADefData.AddHOPWADefaults(cbIsCurrent.Checked, DataUtils.GetInt(ddlFund.SelectedValue.ToString()), DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text),
                        DataUtils.GetInt(ddlPrevFund.SelectedValue.ToString()), DataUtils.GetInt(txtYear.Text),
                        DataUtils.GetDecimal(Regex.Replace(txtSTRMUMaxAmt.Text, "[^0-9a-zA-Z.]+", "")));

                    //ClearForm();
                    //cbAddHopwaDef.Checked = false;
                    //BindHOPWADefGrid();
                    PopulateHOPWADefaults();
                    LogMessage("HOPWA Defaults added successfully");
                }
                else
                {
                    HOPWADefData.UpdateHOPWADefaults(DataUtils.GetInt(hfHOPWADefaultID.Value), 
                        cbIsCurrent.Checked, DataUtils.GetInt(ddlFund.SelectedValue.ToString()), DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text),
                        DataUtils.GetInt(ddlPrevFund.SelectedValue.ToString()), DataUtils.GetInt(txtYear.Text),
                        DataUtils.GetDecimal(Regex.Replace(txtSTRMUMaxAmt.Text, "[^0-9a-zA-Z.]+", "")));

                    PopulateHOPWADefaults();
                    LogMessage("HOPWA Defaults updated successfully");
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddProjectName_Click", "", ex.Message);
            }
        }

        private void LoadFundNames()
        {
            try
            {
                DataTable dtFund = FundMaintenanceData.GetFundName(true);

                ddlFund.DataSource = dtFund;
                ddlFund.DataValueField = "fundid";
                ddlFund.DataTextField = "name";
                ddlFund.DataBind();
                ddlFund.Items.Insert(0, new ListItem("Select", "NA"));

                ddlPrevFund.DataSource = dtFund;
                ddlPrevFund.DataValueField = "fundid";
                ddlPrevFund.DataTextField = "name";
                ddlPrevFund.DataBind();
                ddlPrevFund.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindHOPWADefGrid()
        {
            try
            {
                DataTable dtAddress = HOPWADefData.GetHOPWADefaultsList(true);

                if (dtAddress.Rows.Count > 0)
                {
                    dvHOPWADefFormGrid.Visible = true;
                    gvHOPWADefForm.DataSource = dtAddress;
                    gvHOPWADefForm.DataBind();
                }
                else
                {
                    dvHOPWADefFormGrid.Visible = false;
                    gvHOPWADefForm.DataSource = null;
                    gvHOPWADefForm.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindHOPWADefGrid", "", ex.Message);
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

        private void ClearForm()
        {
            cbIsCurrent.Checked = false;
            txtYear.Text = "";
            ddlFund.SelectedIndex = -1;
            ddlPrevFund.SelectedIndex = -1;
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtSTRMUMaxAmt.Text = "";
        }

        protected void gvHOPWADefForm_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gvHOPWADefForm_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvHOPWADefForm_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvHOPWADefForm_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }
    }
}