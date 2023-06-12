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
    public partial class AddNewInactiveProject : System.Web.UI.Page
    {

        string Pagename = "AddNewInactiveProject";
        protected void Page_Load(object sender, EventArgs e)
        {
            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);

            if (!IsPostBack)
            {
                BindControls();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtprojectNumber, "OnBlur");
            txtprojectNumber.Attributes.Add("onblur", onBlurScript);
        }

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtprojectNumber.UniqueID && args == "OnBlur")
            {
                SetProjectName();
            }
        }

        private void SetProjectName()
        {
            DataRow dr = InactiveProjectData.GetProjectNameByProjectNumber(txtprojectNumber.Text);

            if (dr != null)
                spnProjectName.InnerText = dr["ProjectName"].ToString();
            else
            {

                if (ddlProgram.SelectedValue != "NA")
                    spnProjectName.InnerHtml = ddlProgram.SelectedItem.Text;
                else
                    spnProjectName.InnerHtml = "";
            }
        }

        private void BindControls()
        {

            BindPrograms();
            BindLookUP(ddlApplication, 2283);
            BindLookUP(ddlPortfolio, 2287);
            
        }

        private void BindYearLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                DataView dvYears = new DataView(LookupValuesData.Getlookupvalues(LookupType));
                dvYears.Sort = "description desc";

                ddList.DataSource = dvYears;
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindYearLookUP", "Control ID:" + ddList.ID, ex.Message);
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
                ddlProgram.DataValueField = "ProgramType";
                ddlProgram.DataTextField = "Description";
                ddlProgram.DataBind();
                ddlProgram.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindManagers", "", ex.Message);
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtprojectNumber.Text == "")
            {
                LogMessage("Enter Project Number");
                txtprojectNumber.Focus();
            }
            else
            {
                if (ddlProgram.SelectedValue == "8888") //Conservation
                {
                    InactiveConservationProjectResult objInactiveProjectResult = InactiveProjectData.AddInactiveConservationProject(txtprojectNumber.Text, txtLoginName.Text, txtPassword.Text,
                        DataUtils.GetInt(ddlApplication.SelectedValue), DataUtils.GetInt(ddlPortfolio.SelectedValue), true);

                    if (objInactiveProjectResult.IsProjectNotExist)
                        LogMessage("Conservation Project not exist");
                    else if(objInactiveProjectResult.IsDuplicate)
                         LogMessage("This record already exist");
                    else
                        LogMessage("Project added successfully");
                }
                else if (ddlProgram.SelectedValue == "7777" && ddlApplication.SelectedValue == "39365") //Housing && Portfolio Data
                {
                    if (ddlPortfolio.SelectedIndex == 0)
                    {
                        LogMessage("Select Portfolio Type");
                        ddlPortfolio.Focus();
                    }
                    else if (DataUtils.GetInt(ddlYear.SelectedItem.Text) == 0)
                    {
                        LogMessage("Select Year");
                        ddlYear.Focus();
                    }
                    else
                    {
                        InactiveProjectResult objInactiveProjectResult = InactiveProjectData.AddInactiveHousingProject(txtprojectNumber.Text, txtLoginName.Text, txtPassword.Text,
                           DataUtils.GetInt(ddlApplication.SelectedValue), DataUtils.GetInt(ddlPortfolio.SelectedValue), DataUtils.GetInt(ddlYear.SelectedItem.Text), true);

                        if (objInactiveProjectResult.IsDuplicate)
                            LogMessage("Project already exist");

                        else
                            LogMessage("Project added successfully");
                    }
                }
                else
                {
                    string ProjNumber = string.Empty;

                    if (ddlProgram.SelectedValue == "9999")
                        ProjNumber = "9999-001-" + txtprojectNumber.Text;
                    else
                        ProjNumber = txtprojectNumber.Text;

                    InactiveProjectResult objInactiveProjectResult = InactiveProjectData.AddInactiveProject(ProjNumber, txtLoginName.Text, txtPassword.Text, 
                        DataUtils.GetInt(ddlApplication.SelectedValue),0, 0, true);

                    if (objInactiveProjectResult.IsDuplicate)
                        LogMessage("Project already exist");

                    else
                        LogMessage("Project added successfully");
                }
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtprojectNumber.Text = "";
            txtLoginName.Text = "";
            txtPassword.Text = "";
            //cbActive.Checked = false;
        }

        protected void ddlProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProgram.SelectedValue == "9999") //Viability
                spnViabilityProjectPrefix.Visible = true;
            else
                spnViabilityProjectPrefix.Visible = false;

            SetProjectName();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count, string contextKey)
        {
            DataTable dt = new DataTable();

            if (contextKey == null)
                contextKey = "7777";

            dt = InactiveProjectData.GetConservationProjectNumbers(prefixText, contextKey);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        protected void ddlApplication_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlApplication.SelectedValue == "39365")
            {

                    spnPortfolioType.Visible = true;
                    ddlPortfolio.Visible = true;
                    spnYear.Visible = true;
                    ddlYear.Visible = true;
                    BindYearLookUP(ddlYear, 76);
            }
            else
            {
                spnPortfolioType.Visible = false;
                ddlPortfolio.Visible = false;
                spnYear.Visible = false;
                ddlYear.Visible = false;
            }
        }
    }
}