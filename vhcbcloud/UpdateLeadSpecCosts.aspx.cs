using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Lead;

namespace vhcbcloud
{
    public partial class UpdateLeadSpecCosts : System.Web.UI.Page
    {
        string Pagename = "UpdateLeadSpecCosts";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

          
            if (!IsPostBack)
            {
                PopulateSpecTitles();

            }
            //GetRoleAuth();
        }

        private void PopulateSpecTitles()
        {
            try
            {
                ddlSpecTitles.Items.Clear();
                ddlSpecTitles.DataSource = ProjectLeadBuildingsData.GetLeadSpecsAll();
                ddlSpecTitles.DataValueField = "Spec_ID";
                ddlSpecTitles.DataTextField = "SpecTitle";
                ddlSpecTitles.DataBind();
                ddlSpecTitles.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "PopulateSpecTitles", "Control ID:", ex.Message);
            }
        }

        protected void ddlSpecTitles_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DataUtils.GetInt(ddlSpecTitles.SelectedValue) > 0)
            {
                DataRow dr = ProjectLeadBuildingsData.GetLeadSpecsBySpecId(DataUtils.GetInt(ddlSpecTitles.SelectedValue));

                if (dr != null)
                {
                    txtCost.Text = dr["UnitCost"].ToString();
                    lblSpecId.Text = dr["Spec_ID"].ToString();
                }
            }
            else
            {
                txtCost.Text = "";
                lblSpecId.Text = "";
                ddlSpecTitles.SelectedIndex = -1;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (DataUtils.GetInt(ddlSpecTitles.SelectedValue) > 0)
            {
                ProjectLeadBuildingsData.UpdateLeadSpecCost(DataUtils.GetInt(ddlSpecTitles.SelectedValue), DataUtils.GetDecimal(Regex.Replace(txtCost.Text, "[^0-9a-zA-Z.]+", "")));

                txtCost.Text = "";
                lblSpecId.Text = "";
                ddlSpecTitles.SelectedIndex = -1;

                LogMessage("Lead Spec Cost Updated Successfully");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCost.Text = "";
            lblSpecId.Text = "";
            ddlSpecTitles.SelectedIndex = -1;
        }

        #region Logs
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
        #endregion Logs
    }
}