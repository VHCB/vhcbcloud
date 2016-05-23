using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Lead;

namespace vhcbcloud.Lead
{
    public partial class ProjectLeadData : System.Web.UI.Page
    {
        string Pagename = "ProjectLeadData";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"];
            }

            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();

                BindControls();
                BindForm();
            }
        }

        private void GenerateTabs()
        {
            string ProgramId = null;

            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

            //Active Tab
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + hfProjectId.Value);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabs(DataUtils.GetInt(ProgramId));

            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString().Contains("ProjectLeadData.aspx"))
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                else
                    li1.Attributes.Add("class", "RoundedCornerTop");

                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", "../" + dr["URL"].ToString() + "?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                anchor1.InnerText = dr["TabName"].ToString();
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                li1.Controls.Add(anchor1);
            }
        }

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void BindControls()
        {
            BindLookUP(ddlPBContractor, 148);
            BindLookUP(ddlTestingConsultant, 148);
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

        private void BindForm()
        {
            DataRow dr = ProjectLeadDataData.GetProjectLeadDataById(DataUtils.GetInt(hfProjectId.Value));

            if (dr != null)
            {
                btnSubmit.Text = "Update";

                txtProjStartDate.Text = dr["StartDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["StartDate"].ToString()).ToShortDateString();
                txtAllUnitsClrDate.Text = dr["UnitsClearDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["UnitsClearDate"].ToString()).ToShortDateString();
                txtGrantAmt.Text =  Decimal.Parse(dr["Grantamt"].ToString()).ToString("#.00");
                txtHHIntAmt.Text = Decimal.Parse(dr["HHIntervention"].ToString()).ToString("#.00");
                txtLoanAmt.Text = Decimal.Parse(dr["Loanamt"].ToString()).ToString("#.00");
                txtRelocationAmt.Text = Decimal.Parse(dr["Relocation"].ToString()).ToString("#.00");
                txtClearanceDeCommit.Text = Decimal.Parse(dr["ClearDecom"].ToString()).ToString("#.00");
                txtTotalAwardAmt.Text = Decimal.Parse(dr["TotAward"].ToString()).ToString("#.00");
                PopulateDropDown(ddlPBContractor, dr["PBCont"].ToString());
                PopulateDropDown(ddlTestingConsultant, dr["Testconsult"].ToString());
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
            //if (ddlHousingType.SelectedIndex == 0)
            //{
            //    LogMessage("Select Housing Type");
            //    ddlHousingType.Focus();
            //    return;
            //}

            //if (string.IsNullOrWhiteSpace(txtTotalUnits.Text.ToString()) == true)
            //{
            //    LogMessage("Enter Total Units");
            //    txtTotalUnits.Focus();
            //    return;
            //}
            //if (DataUtils.GetDecimal(txtTotalUnits.Text) <= 0)
            //{
            //    LogMessage("Enter valid Total Units");
            //    txtTotalUnits.Focus();
            //    return;
            //}
            if (btnSubmit.Text.ToLower() == "update")
            {
                ProjectLeadDataData.UpdateProjectLeadData((DataUtils.GetInt(hfProjectId.Value)), DataUtils.GetDate(txtProjStartDate.Text), DataUtils.GetDate(txtAllUnitsClrDate.Text),
                   DataUtils.GetDecimal(txtGrantAmt.Text), DataUtils.GetDecimal(txtHHIntAmt.Text), DataUtils.GetDecimal(txtLoanAmt.Text), DataUtils.GetDecimal(txtRelocationAmt.Text),
                    DataUtils.GetDecimal(txtClearanceDeCommit.Text), DataUtils.GetInt(ddlTestingConsultant.SelectedValue.ToString()), DataUtils.GetInt(ddlPBContractor.SelectedValue.ToString()),
                    DataUtils.GetDecimal(txtTotalAwardAmt.Text), true);

                LogMessage("Project Lead Data updated successfully");
            }
            else
            {
                ProjectLeadDataData.AddProjectLeadData((DataUtils.GetInt(hfProjectId.Value)), DataUtils.GetDate(txtProjStartDate.Text), DataUtils.GetDate(txtAllUnitsClrDate.Text),
                    DataUtils.GetDecimal(txtGrantAmt.Text), DataUtils.GetDecimal(txtHHIntAmt.Text), DataUtils.GetDecimal(txtLoanAmt.Text), DataUtils.GetDecimal(txtRelocationAmt.Text),
                     DataUtils.GetDecimal(txtClearanceDeCommit.Text), DataUtils.GetInt(ddlTestingConsultant.SelectedValue.ToString()), DataUtils.GetInt(ddlPBContractor.SelectedValue.ToString()),
                     DataUtils.GetDecimal(txtTotalAwardAmt.Text));

                LogMessage("Project Lead Data added successfully");
            }
            BindForm();
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