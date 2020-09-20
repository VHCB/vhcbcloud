using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] Dashboards = Directory.GetFiles("C:\\Reports\\organization\\Dashboard", "*.*")
                                     .Select(Path.GetFileName)
                                     .ToArray();
                for (int i = 0; i < Dashboards.Length; i++)
                {
                    ddlDashBoard.Items.Insert(i, new ListItem(Dashboards[i], Dashboards[i]));
                }

                DataTable dtUserDetails = YearQuarterData.GetUserDetailsByUserName(Context.User.Identity.Name);
                hfUserId.Value = dtUserDetails.Rows[0]["UserId"].ToString().Trim();

                DataRow dr = AccountData.GetUserInfoById(DataUtils.GetInt(hfUserId.Value));
                PopulateDropDown(ddlDashBoard, dr["DashboardName"].ToString());
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            AccountData.UpdateDashboard(DataUtils.GetInt(hfUserId.Value), ddlDashBoard.SelectedValue.ToString());
            lblErrorMsg.Text = "Dashboard updated successfully.";
        }
    }
}