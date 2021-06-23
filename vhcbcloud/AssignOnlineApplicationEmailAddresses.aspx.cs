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
    public partial class AssignOnlineApplicationEmailAddresses : System.Web.UI.Page
    {
        string Pagename = "AssignOnlineApplicationEmailAddresses";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindControls();
            }
        }

        private void BindControls()
        {

            BindPrograms();
        }

        protected void BindPrograms()
        {
            try
            {
                ddlProgram.Items.Clear();
                ddlProgram.DataSource = InactiveProjectData.BindPrograms();
                ddlProgram.DataValueField = "TypeId";
                ddlProgram.DataTextField = "Description";
                ddlProgram.DataBind();
                ddlProgram.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindManagers", "", ex.Message);
            }
        }

        protected void BindApplicationType(int Program)
        {
            try
            {
                ddlApplicationType.Items.Clear();
                ddlApplicationType.DataSource = InactiveProjectData.GetTempApplicationTypes(Program);
                ddlApplicationType.DataValueField = "ApplicationType";
                ddlApplicationType.DataTextField = "ApplicationType";
                ddlApplicationType.DataBind();
                ddlApplicationType.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicationType", "", ex.Message);
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

        protected void ddlProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindApplicationType(DataUtils.GetInt(ddlProgram.SelectedValue));
            ddlApplicationType.SelectedIndex = -1;

            txtEmail1.Text = "";
            txtEmail2.Text = "";
            txtEmail3.Text = "";
            txtEmail4.Text = "";
            txtEmail5.Text = "";
            txtEmail6.Text = "";

            txtName1.Text = "";
            txtName2.Text = "";
            txtName3.Text = "";
            txtName4.Text = "";
            txtName5.Text = "";
            txtName6.Text = "";

            dvMessage.Visible = false;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            InactiveProjectData.DeleteOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue));

            if (txtName1.Text != "" && txtEmail1.Text != "")
            {
                InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName1.Text, txtEmail1.Text);
            }

            if (txtName2.Text != "" && txtEmail2.Text != "")
            {
                InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName2.Text, txtEmail2.Text);
            }

            if (txtName3.Text != "" && txtEmail3.Text != "")
            {
                InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName3.Text, txtEmail3.Text);
            }

            if (txtName4.Text != "" && txtEmail4.Text != "")
            {
                InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName4.Text, txtEmail4.Text);
            }

            if (txtName5.Text != "" && txtEmail5.Text != "")
            {
                InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName5.Text, txtEmail5.Text);
            }

            if (txtName6.Text != "" && txtEmail6.Text != "")
            {
                InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName6.Text, txtEmail6.Text);
            }

            LogMessage("Saved Data Scuccessfully!");
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void ddlApplicationType_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dt = InactiveProjectData.GetOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue));

            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                i = i + 1;
                if (i == 1)
                {
                    txtName1.Text = dr["Name"].ToString();
                    txtEmail1.Text = dr["Email_Address"].ToString();
                }
                else if (i == 2)
                {
                    txtName2.Text = dr["Name"].ToString();
                    txtEmail2.Text = dr["Email_Address"].ToString();
                }
                else if (i == 3)
                {
                    txtName3.Text = dr["Name"].ToString();
                    txtEmail3.Text = dr["Email_Address"].ToString();
                }
                else if (i == 4)
                {
                    txtName4.Text = dr["Name"].ToString();
                    txtEmail4.Text = dr["Email_Address"].ToString();
                }
                else if (i == 5)
                {
                    txtName5.Text = dr["Name"].ToString();
                    txtEmail5.Text = dr["Email_Address"].ToString();
                }
                else if (i == 6)
                {
                    txtName6.Text = dr["Name"].ToString();
                    txtEmail6.Text = dr["Email_Address"].ToString();
                }
            }

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlProgram.SelectedIndex = -1;
            ddlApplicationType.SelectedIndex = -1;

            txtEmail1.Text = "";
            txtEmail2.Text = "";
            txtEmail3.Text = "";
            txtEmail4.Text = "";
            txtEmail5.Text = "";
            txtEmail6.Text = "";

            txtName1.Text = "";
            txtName2.Text = "";
            txtName3.Text = "";
            txtName4.Text = "";
            txtName5.Text = "";
            txtName6.Text = "";

            dvMessage.Visible = false;
        }
    }
}