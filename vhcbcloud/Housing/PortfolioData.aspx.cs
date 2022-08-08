using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Housing;

namespace vhcbcloud.Housing
{
    public partial class PortfolioData : System.Web.UI.Page
    {
        string Pagename = "PortfolioData";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();
                BindControls();
                GetRoleAccess();
                //BindHousingUnitsForm();
            }
        }

        protected void GetRoleAccess()
        {

            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(DataUtils.GetInt(hfProjectId.Value));

            if (dr != null)
            {
                if (dr["usergroupid"].ToString() == "0") // Admin Only
                {
                    hfIsVisibleBasedOnRole.Value = "true";
                }
                else if (dr["usergroupid"].ToString() == "1") // Program Admin Only
                {
                    if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        hfIsVisibleBasedOnRole.Value = "true";
                    }
                }
                else if (dr["usergroupid"].ToString() == "2") //2. Program Staff  
                {
                    if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        //    if (Convert.ToBoolean(drProjectDetails["verified"].ToString()))
                        //    {
                        //        RoleViewOnlyExceptAddNewItem();
                        //        hfIsVisibleBasedOnRole.Value = "false";
                        //    }
                        //    else
                        //    {
                        hfIsVisibleBasedOnRole.Value = "true";
                        //    }
                    }
                }
                else if (dr["usergroupid"].ToString() == "3") // View Only
                {
                    RoleViewOnly();
                    hfIsVisibleBasedOnRole.Value = "false";
                }


                if (Convert.ToBoolean(drProjectDetails["verified"].ToString()))
                {
                    RoleViewOnlyExceptAddNewItem();
                    hfIsVisibleBasedOnRole.Value = "false";
                }
            }
        }

        protected void RoleViewOnlyExceptAddNewItem()
        {
            btnSubmit.Visible = false;

        }

        protected void RoleViewOnly()
        {

            btnSubmit.Visible = false;
        }

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }
        private void ProjectNotesSetUp()
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));

            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"] +
                    "&PageId=" + PageId;
                if (ProjectNotesData.IsNotesExist(PageId, DataUtils.GetInt(hfProjectId.Value)))
                    btnProjectNotes.ImageUrl = "~/Images/currentpagenotes.png";
            }
        }

        private void GenerateTabs()
        {
            string ProgramId = null;
            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

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
                if (dr["URL"].ToString().Contains("PortfolioData.aspx"))
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

        private void BindControls()
        {
            BindYearLookUP(ddlyear, 76);
            BindLookUP(ddlPortfolioType, 2287);
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
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                    if (btnSubmit.Text.ToLower() == "save")
                    {
                        PortfolioDataData.AddProjectPortfolio(DataUtils.GetInt(ddlPortfolioType.SelectedValue), ddlyear.SelectedItem.Text, DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(txtTotalUnits.Text),
                            DataUtils.GetInt(txtMGender.Text), DataUtils.GetInt(txtFGender.Text), DataUtils.GetInt(txtUGender.Text), DataUtils.GetInt(txtWhite.Text),
                            DataUtils.GetInt(txtBlack.Text), DataUtils.GetInt(txtAsian.Text), DataUtils.GetInt(txtIndian.Text), DataUtils.GetInt(txtHawaiian.Text),
                            DataUtils.GetInt(txtUnknownRace.Text), DataUtils.GetInt(txtHispanic.Text), DataUtils.GetInt(txtNonHisp.Text), DataUtils.GetInt(txtUnknownEthnicity.Text),
                            DataUtils.GetInt(txtHomeless.Text), DataUtils.GetInt(txtMarketRate.Text), DataUtils.GetInt(txtI100.Text), DataUtils.GetInt(txtI80.Text),
                            DataUtils.GetInt(txtI75.Text), DataUtils.GetInt(txtI60.Text), DataUtils.GetInt(txtI50.Text), DataUtils.GetInt(txtI30.Text), DataUtils.GetInt(txtI20.Text), false);
                        ClearForm();
                    ddlyear.SelectedIndex = -1;
                        LogMessage("Portfolio data added successfully");
                        btnSubmit.Text = "Update";
                    }
                    else
                    {
                    PortfolioDataData.UpdateProjectPortfolio(DataUtils.GetInt(hfProjectPortfolioID.Value), DataUtils.GetInt(ddlPortfolioType.SelectedValue), ddlyear.SelectedItem.Text, DataUtils.GetInt(txtTotalUnits.Text),
                       DataUtils.GetInt(txtMGender.Text), DataUtils.GetInt(txtFGender.Text), DataUtils.GetInt(txtUGender.Text), DataUtils.GetInt(txtWhite.Text),
                       DataUtils.GetInt(txtBlack.Text), DataUtils.GetInt(txtAsian.Text), DataUtils.GetInt(txtIndian.Text), DataUtils.GetInt(txtHawaiian.Text),
                       DataUtils.GetInt(txtUnknownRace.Text), DataUtils.GetInt(txtHispanic.Text), DataUtils.GetInt(txtNonHisp.Text), DataUtils.GetInt(txtUnknownEthnicity.Text),
                       DataUtils.GetInt(txtHomeless.Text), DataUtils.GetInt(txtMarketRate.Text), DataUtils.GetInt(txtI100.Text), DataUtils.GetInt(txtI80.Text),
                       DataUtils.GetInt(txtI75.Text), DataUtils.GetInt(txtI60.Text), DataUtils.GetInt(txtI50.Text), DataUtils.GetInt(txtI30.Text), DataUtils.GetInt(txtI20.Text));

                    LogMessage("Portfolio data updated successfully");
                    }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnSubmit_Click", "", ex.Message);
            }
        }

        private void ClearForm()
        {
            ddlPortfolioType.SelectedIndex = -1;
            txtTotalUnits.Text = "";
            txtMGender.Text = ""; txtFGender.Text = ""; txtUGender.Text = ""; txtWhite.Text = "";
            txtBlack.Text = ""; txtAsian.Text = ""; txtIndian.Text = ""; txtHawaiian.Text = "";
            txtUnknownRace.Text = ""; txtHispanic.Text = ""; txtNonHisp.Text = ""; txtUnknownEthnicity.Text = "";
            txtHomeless.Text = ""; txtMarketRate.Text = ""; txtI100.Text = ""; txtI80.Text = "";
            txtI75.Text = ""; txtI60.Text = ""; txtI50.Text = ""; txtI30.Text = ""; txtI20.Text = "";

            spnAsian.InnerHtml = "";
            spnBlack.InnerHtml = "";
            spnFeMale.InnerHtml = "";
            spnHawaiian.InnerHtml = "";
            spnHispanic.InnerHtml = "";
            spnHomeless.InnerHtml = "";
            spnI100.InnerHtml = "";
            spnI20.InnerHtml = "";
            spnI30.InnerHtml = "";
            spnI60.InnerHtml = "";
            spnI50.InnerHtml = "";
            spnI75.InnerHtml = "";
            spnI80.InnerHtml = "";
            spnIndian.InnerHtml = "";
            spnMale.InnerHtml = "";
            spnNonHisp.InnerHtml = "";
            spntMarketRate.InnerHtml = "";
            spnUgender.InnerHtml = "";
            spnUnknownEthnicity.InnerHtml = "";
            spnUnknownRace.InnerHtml = "";
            spnWhite.InnerHtml = "";
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

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

        protected void ddlyear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string year = ddlyear.SelectedItem.Text.ToString();
            hfProjectPortfolioID.Value = "";
            btnSubmit.Text = "Save";
            ClearForm();

            if (ddlyear.SelectedIndex != 0)
            {
                DataRow drPortfolioData = PortfolioDataData.GetPortfolioData(DataUtils.GetInt(hfProjectId.Value), year);

                if (drPortfolioData != null)
                {
                    hfProjectPortfolioID.Value = drPortfolioData["ProjectPortfolioID"].ToString();
                    int Totalunits = DataUtils.GetInt(drPortfolioData["TotalUnits"].ToString());
                    PopulateDropDown(ddlPortfolioType, drPortfolioData["PortfolioType"].ToString());
                    txtTotalUnits.Text = drPortfolioData["TotalUnits"].ToString();

                    txtMGender.Text = drPortfolioData["MGender"].ToString();
                    decimal perMale = Math.Round((DataUtils.GetDecimal(drPortfolioData["MGender"].ToString()) / Totalunits) * 100, 2);
                    spnMale.InnerText = perMale.ToString()+" %";

                    txtFGender.Text = drPortfolioData["FGender"].ToString();
                    decimal perFeMale = Math.Round((DataUtils.GetDecimal(drPortfolioData["FGender"].ToString()) / Totalunits) * 100, 2);
                    spnFeMale.InnerText = perFeMale.ToString() + " %";

                    txtUGender.Text = drPortfolioData["UGender"].ToString();
                    decimal perUGender = Math.Round((DataUtils.GetDecimal(drPortfolioData["UGender"].ToString()) / Totalunits) * 100, 2);
                    spnUgender.InnerText = perUGender.ToString() + " %";

                    txtWhite.Text = drPortfolioData["White"].ToString();
                    decimal perWhite = Math.Round((DataUtils.GetDecimal(drPortfolioData["White"].ToString()) / Totalunits) * 100, 2);
                    spnWhite.InnerText = perWhite.ToString() + " %";

                    txtBlack.Text = drPortfolioData["Black"].ToString();
                    decimal perBlack = Math.Round((DataUtils.GetDecimal(drPortfolioData["Black"].ToString()) / Totalunits) * 100, 2);
                    spnBlack.InnerText = perBlack.ToString() + " %";

                    txtAsian.Text = drPortfolioData["Asian"].ToString();
                    decimal perAsian = Math.Round((DataUtils.GetDecimal(drPortfolioData["Asian"].ToString()) / Totalunits) * 100, 2);
                    spnAsian.InnerText = perAsian.ToString() + " %";

                    txtIndian.Text = drPortfolioData["Indian"].ToString();
                    decimal perIndian = Math.Round((DataUtils.GetDecimal(drPortfolioData["Indian"].ToString()) / Totalunits) * 100, 2);
                    spnIndian.InnerText = perIndian.ToString() + " %";

                    txtHawaiian.Text = drPortfolioData["Hawaiian"].ToString();
                    decimal perHawaiian = Math.Round((DataUtils.GetDecimal(drPortfolioData["Hawaiian"].ToString()) / Totalunits) * 100, 2);
                    spnHawaiian.InnerText = perHawaiian.ToString() + " %";

                    txtUnknownRace.Text = drPortfolioData["UnknownRace"].ToString();
                    decimal perUnknownRace = Math.Round((DataUtils.GetDecimal(drPortfolioData["UnknownRace"].ToString()) / Totalunits) * 100, 2);
                    spnUnknownRace.InnerText = perUnknownRace.ToString() + " %";

                    txtHispanic.Text = drPortfolioData["Hispanic"].ToString();
                    decimal perHispanic = Math.Round((DataUtils.GetDecimal(drPortfolioData["Hispanic"].ToString()) / Totalunits) * 100, 2);
                    spnHispanic.InnerText = perHispanic.ToString() + " %";

                    txtNonHisp.Text = drPortfolioData["NonHisp"].ToString();
                    decimal perNonHisp = Math.Round((DataUtils.GetDecimal(drPortfolioData["NonHisp"].ToString()) / Totalunits) * 100, 2);
                    spnNonHisp.InnerText = perNonHisp.ToString() + " %";

                    txtUnknownEthnicity.Text = drPortfolioData["UnknownEthnicity"].ToString();
                    decimal perUnknownEthnicity = Math.Round((DataUtils.GetDecimal(drPortfolioData["UnknownEthnicity"].ToString()) / Totalunits) * 100, 2);
                    spnUnknownEthnicity.InnerText = perUnknownEthnicity.ToString() + " %";

                    txtHomeless.Text = drPortfolioData["Homeless"].ToString();
                    decimal perHomeless = Math.Round((DataUtils.GetDecimal(drPortfolioData["Homeless"].ToString()) / Totalunits) * 100, 2);
                    spnHomeless.InnerText = perHomeless.ToString() + " %";

                    txtMarketRate.Text = drPortfolioData["MarketRate"].ToString();
                    decimal perMarketRate = Math.Round((DataUtils.GetDecimal(drPortfolioData["MarketRate"].ToString()) / Totalunits) * 100, 2);
                    spntMarketRate.InnerText = perMarketRate.ToString() + " %";

                    txtI100.Text = drPortfolioData["I100"].ToString();
                    decimal perI100 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I100"].ToString()) / Totalunits) * 100, 2);
                    spnI100.InnerText = perI100.ToString() + " %";

                    txtI80.Text = drPortfolioData["I80"].ToString();
                    decimal perI80 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I80"].ToString()) / Totalunits) * 100, 2);
                    spnI80.InnerText = perI80.ToString() + " %";

                    txtI75.Text = drPortfolioData["I75"].ToString();
                    decimal perI75 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I75"].ToString()) / Totalunits) * 100, 2);
                    spnI75.InnerText = perI75.ToString() + " %";

                    txtI60.Text = drPortfolioData["I60"].ToString();
                    decimal perI60 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I60"].ToString()) / Totalunits) * 100, 2);
                    spnI60.InnerText = perI60.ToString() + " %";

                    txtI50.Text = drPortfolioData["I50"].ToString();
                    decimal perI50 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I50"].ToString()) / Totalunits) * 100, 2);
                    spnI50.InnerText = perI50.ToString() + " %";

                    txtI30.Text = drPortfolioData["I30"].ToString();
                    decimal perI30 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I30"].ToString()) / Totalunits) * 100, 2);
                    spnI30.InnerText = perI30.ToString() + " %";

                    txtI20.Text = drPortfolioData["I120"].ToString();
                    decimal perI120 = Math.Round((DataUtils.GetDecimal(drPortfolioData["I120"].ToString()) / Totalunits) * 100, 2);
                    spnI20.InnerText = perI120.ToString() + " %";

                    btnSubmit.Text = "Update";
                }
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
    }
}