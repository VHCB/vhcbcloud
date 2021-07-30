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
    public partial class AssignOnlineApplicationEmailAddresses : System.Web.UI.Page
    {
        string Pagename = "AssignOnlineApplicationEmailAddresses";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindControls();
                BindEmailGrid();
            }
            ddlUser.Enabled = true;
        }

        private void BindControls()
        {
            BindUsers();
            BindPrograms();
            BindLookUP(ddlApplicationType, 2283);

        }

        private void BindUsers()
        {
            try
            {
                ddlUser.Items.Clear();
                ddlUser.DataSource = InactiveProjectData.GetPDFEmailReceiveUsers();
                ddlUser.DataValueField = "UserId";
                ddlUser.DataTextField = "Name";
                ddlUser.DataBind();
                ddlUser.Items.Insert(0, new ListItem("External User", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindUsers", "", ex.Message);
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtName1.Text == "")
            {
                lblErrorMsg.Text = "Please select Name";
                return;
            }
            else if (txtEmail1.Text == "")
            {
                lblErrorMsg.Text = "Please select Email";
                return;
            }

            if (btnSubmit.Text.ToLower() == "update")
            {
                InactiveProjectData.UpdateOnlineEmailAddresses(DataUtils.GetInt(hfEmailAddressID.Value), DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName1.Text, txtEmail1.Text, txtProjectNumber.Text, chkEmailActive.Checked);
                
                gvEmail.EditIndex = -1;
            }
            else
            {
                if (txtName1.Text != "" && txtEmail1.Text != "")
                {
                    InactiveProjectData.AddOnlineEmailAddresses(DataUtils.GetInt(ddlProgram.SelectedValue), DataUtils.GetInt(ddlApplicationType.SelectedValue), txtName1.Text, txtEmail1.Text, txtProjectNumber.Text);
                }
            }
            chkEmailActive.Checked = true;
            chkEmailActive.Enabled = false;
            cbAddEmail.Checked = false;
            BindEmailGrid();
            ClearEmailForm();
            hfEmailAddressID.Value = "";
            btnSubmit.Text = "Submit";
            LogMessage("Saved Data Scuccessfully!");
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlProgram.SelectedIndex = -1;
            ddlApplicationType.SelectedIndex = -1;

            txtEmail1.Text = "";

            txtName1.Text = "";
            txtProjectNumber.Text = "";
            dvMessage.Visible = false;

            chkEmailActive.Checked = true;
            chkEmailActive.Enabled = false;
            btnSubmit.Text = "Submit";
        }

        private void BindEmailGrid()
        {
            try
            {
                DataTable dt = InactiveProjectData.GetOnlineEmailAddressesList(true);

                if (dt.Rows.Count > 0)
                {
                    dvEmailGrid.Visible = true;
                    gvEmail.DataSource = dt;
                    gvEmail.DataBind();
                }
                else
                {
                    dvEmailGrid.Visible = false;
                    gvEmail.DataSource = null;
                    gvEmail.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindEmailGrid", "", ex.Message);
            }
        }

        protected void gvEmail_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEmail.EditIndex = e.NewEditIndex;
            BindEmailGrid();
        }

        protected void gvEmail_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEmail.EditIndex = -1;
            BindEmailGrid();
            ClearEmailForm();
            hfEmailAddressID.Value = "";
            btnSubmit.Text = "Submit";
        }

        private void ClearEmailForm()
        {
            txtName1.Text = "";
            txtEmail1.Text = "";
            ddlProgram.SelectedIndex = -1;
            ddlApplicationType.SelectedIndex = -1;
            cbAddEmail.Checked = false;
            txtProjectNumber.Text = "";
            ddlUser.SelectedIndex = -1;
        }

        protected void gvEmail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnSubmit.Text = "Update";
                    cbAddEmail.Checked = true;


                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[1].Visible = false;

                        Label lblEmailAddressID = e.Row.FindControl("lblEmail_AddressID") as Label;
                        DataRow dr = InactiveProjectData.GetOnlineEmailAddressById(DataUtils.GetInt(lblEmailAddressID.Text));

                        hfEmailAddressID.Value = lblEmailAddressID.Text;

                        PopulateDropDown(ddlProgram, dr["Program"].ToString());
                        PopulateDropDown(ddlApplicationType, dr["ApplicationType"].ToString());

                        txtEmail1.Text = dr["Email_Address"].ToString();
                        txtName1.Text = dr["Name"].ToString();
                        txtProjectNumber.Text = dr["Proj_num"].ToString();
                        chkEmailActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        ddlUser.Enabled = false;
                        chkEmailActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvBldgInfo_RowDataBound", "", ex.Message);
            }
        }

        protected void gvEmail_SelectedIndexChanged(object sender, EventArgs e)
        {

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

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();
            dt = InactiveProjectData.GetProjectNumbersFromTempUser(prefixText);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        protected void ddlUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataRow dr = InactiveProjectData.GetUserInfoByUserId(DataUtils.GetInt(ddlUser.SelectedValue));

            if (dr != null)
            {

                txtName1.Text = dr["Name"].ToString();
                txtEmail1.Text = dr["Email"].ToString();
            }
            else
            {
                txtName1.Text = "";
                txtEmail1.Text = "";
            }
        }
    }
}