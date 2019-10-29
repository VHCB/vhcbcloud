using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud.SetUp
{
    public partial class AmericorpsSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dtable = YearQuarterData.GetAllYearQuarterDetailsForUserQA();
                DataRow dr = dtable.NewRow();
                dr["Quarter"] = "Select";
                dr["ACYrQtrID"] = "0";
                dtable.Rows.InsertAt(dr, 0);
                ddlYearQrtr.DataTextField = "Quarter";
                ddlYearQrtr.DataValueField = "ACYrQtrID";
                ddlYearQrtr.DataSource = dtable;
                ddlYearQrtr.DataBind();
                PopulateSetUpDetails();
            }
        }

        private void PopulateSetUpDetails()
        {
            DataRow dr = SetupData.GetSetupData();
           
            PopulateDropDown(ddlYearQrtr, dr["ACReportQtr"].ToString());
            hfSetUpId.Value = dr["SetupID"].ToString();
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

        protected void btnSetUpSubmit_Click(object sender, EventArgs e)
        {
            SetupData.UpdateAmericorpsSetup(DataUtils.GetInt(hfSetUpId.Value),
                DataUtils.GetInt(ddlYearQrtr.SelectedValue.ToString()));

            LogMessage("Setup details updated successfully");
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }
    }
}