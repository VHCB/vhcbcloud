using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Conservation;
using VHCBCommon.DataAccessLayer.Housing;

namespace vhcbcloud.Housing
{
    public partial class HousingSourcesUses : System.Web.UI.Page
    {
        string Pagename = "HousingSourcesUses";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            if (Request.QueryString["ProjectId"] != null)
                hfProjectId.Value = Request.QueryString["ProjectId"];

            GenerateTabs();
            if (!IsPostBack)
            {
                hfHousingId.Value = HousingSourcesUsesData.GetHousingID(DataUtils.GetInt(hfProjectId.Value)).ToString();
                PopulateProjectDetails();

                dvImport.Visible = false;
                BindControls();

                dvNewSource.Visible = false;
                dvConsevationSourcesGrid.Visible = false;

                dvNewUse.Visible = false;
                dvConsevationUsesGrid.Visible = false;

                ddlBudgetPeriod.SelectedValue = HousingSourcesUsesData.GetLatestHousingBudgetPeriod(DataUtils.GetInt(hfProjectId.Value)).ToString();
                BudgetPeriodSelectionChanged();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlBudgetPeriod, 141);
            BindLookUP(ddlSource, 110);
            BindUsesLookUP(ddlVHCBUses, "VHCB");
            BindUsesLookUP(ddlOtherUses, "Other");
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

        private void BindUsesLookUP(DropDownList ddList, string UseType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = HousingSourcesUsesData.GetHouseUses(UseType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindUsesLookUP", "Control ID:" + ddList.ID, ex.Message);
            }
        }

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
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
                if (dr["URL"].ToString().Contains("HousingSourcesUses.aspx"))
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

        private void BudgetPeriodSelectionChanged()
        {
            if (ddlBudgetPeriod.SelectedIndex != 0)
            {
                //Sources
                ClearAddSourceForm();
                dvNewSource.Visible = true;
                BindSourcegrid();
                cbAddSource.Checked = false;

                //Uses
                dvNewUse.Visible = true;
                BindUsesgrid();
                cbAddUse.Checked = false;

                dvImport.Visible = false;

                DataTable dtImportBudgetPeriods = HousingSourcesUsesData.PopulateHousingImportBudgetPeriodDropDown(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()));

                if (dtImportBudgetPeriods.Rows.Count > 0)
                {
                    dvImport.Visible = true;
                    ddlImportFrom.Items.Clear();
                    ddlImportFrom.DataSource = dtImportBudgetPeriods;
                    ddlImportFrom.DataValueField = "typeid";
                    ddlImportFrom.DataTextField = "description";
                    ddlImportFrom.DataBind();
                    ddlImportFrom.Items.Insert(0, new ListItem("Select", "NA"));

                }
            }
            else
            {
                //Sources
                dvNewSource.Visible = false;
                dvConsevationSourcesGrid.Visible = false;

                //Uses
                dvNewUse.Visible = false;
                dvConsevationUsesGrid.Visible = false;

                //Import From
                dvImport.Visible = false;
            }
        }

        private void BindSourcegrid()
        {
            try
            {
                DataTable dtSources = HousingSourcesUsesData.GetHousingSourcesList(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()), cbActiveOnly.Checked);

                if (dtSources.Rows.Count > 0)
                {
                    dvConsevationSourcesGrid.Visible = true;
                    gvHousingSources.DataSource = dtSources;
                    gvHousingSources.DataBind();

                    Label lblFooterTotalAmt = (Label)gvHousingSources.FooterRow.FindControl("lblFooterTotalAmount");
                    decimal totAmt = 0;

                    for (int i = 0; i < dtSources.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dtSources.Rows[i]["RowIsActive"].ToString()))
                            totAmt += Convert.ToDecimal(dtSources.Rows[i]["Total"].ToString());
                    }

                    lblFooterTotalAmt.Text = CommonHelper.myDollarFormat(totAmt);
                }
                else
                {
                    dvConsevationSourcesGrid.Visible = false;
                    gvHousingSources.DataSource = null;
                    gvHousingSources.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSourcegrid", "", ex.Message);
            }
        }

        private void BindUsesgrid()
        {
            try
            {
                DataTable dtSources = HousingSourcesUsesData.GetHousingUsesList(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()), cbActiveOnly.Checked);

                if (dtSources.Rows.Count > 0)
                {
                    dvConsevationUsesGrid.Visible = true;
                    gvHousingUsesGrid.DataSource = dtSources;
                    gvHousingUsesGrid.DataBind();

                    Label lblFooterVHCBTotalAmt = (Label)gvHousingUsesGrid.FooterRow.FindControl("lblFooterVHCBTotalAmount");
                    Label lblFooterOtherTotalAmt = (Label)gvHousingUsesGrid.FooterRow.FindControl("lblFooterOtherTotalAmount");
                    Label lblFooterGrandTotalAmt = (Label)gvHousingUsesGrid.FooterRow.FindControl("lblFooterGrandTotalAmount");

                    decimal totVHCBAmt = 0;
                    decimal totOtherAmt = 0;
                    decimal totGrantAmt = 0;

                    for (int i = 0; i < dtSources.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dtSources.Rows[i]["RowIsActive"].ToString()))
                        {
                            totVHCBAmt += Convert.ToDecimal(dtSources.Rows[i]["VHCBTotal"].ToString());
                            totOtherAmt += Convert.ToDecimal(dtSources.Rows[i]["OtherTotal"].ToString());
                            totGrantAmt += Convert.ToDecimal(dtSources.Rows[i]["Total"].ToString());
                        }
                    }

                    lblFooterVHCBTotalAmt.Text = CommonHelper.myDollarFormat(totVHCBAmt);
                    lblFooterOtherTotalAmt.Text = CommonHelper.myDollarFormat(totOtherAmt);
                    lblFooterGrandTotalAmt.Text = CommonHelper.myDollarFormat(totGrantAmt);
                }
                else
                {
                    dvConsevationUsesGrid.Visible = false;
                    gvHousingUsesGrid.DataSource = null;
                    gvHousingUsesGrid.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindUsesgrid", "", ex.Message);
            }
        }

        private void ClearAddSourceForm()
        {
            txtSourceTotal.Text = "";
            ddlSource.SelectedIndex = -1;
            cbAddSource.Checked = false;
        }

        private void ClearAddUsesForm()
        {
            ddlVHCBUses.SelectedIndex = -1;
            txtVHCBUseAmount.Text = "";
            ddlOtherUses.SelectedIndex = -1;
            txtOtherUseAmount.Text = "";
            cbAddUse.Checked = false;
            //txtUsesTotal.Text = "";
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindSourcegrid();
            BindUsesgrid();
        }

        protected void ddlBudgetPeriod_SelectedIndexChanged(object sender, EventArgs e)
        {
            BudgetPeriodSelectionChanged();
        }

        protected void ddlImportFrom_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                HousingSourcesUsesData.ImportHousingBudgetPeriodData(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ddlImportFrom.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()));

                //Sources
                ClearAddSourceForm();
                dvNewSource.Visible = true;
                BindSourcegrid();
                cbAddSource.Checked = false;

                //Uses
                dvNewUse.Visible = true;
                BindUsesgrid();
                cbAddUse.Checked = false;

                dvImport.Visible = false;

                LogMessage("Successfully Imported Budget Period");
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Invalid Import"))
                    LogMessage("Invalid Import, No Data Exist for this Budget Period");
                else
                    LogError(Pagename, "ddlImportFrom_SelectedIndexChanged", "", ex.Message);
            }
        }

        protected void btnAddSources_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlSource.SelectedIndex == 0)
                {
                    LogMessage("Select Source");
                    ddlSource.Focus();
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtSourceTotal.Text.ToString()) == true)
                {
                    LogMessage("Enter source total");
                    txtSourceTotal.Focus();
                    return;
                }
                if (DataUtils.GetDecimal(txtSourceTotal.Text) <= 0)
                {
                    LogMessage("Enter valid source total");
                    txtSourceTotal.Focus();
                    return;
                }

                HousingSourcesUsesData.HouseResult objHouseResult = HousingSourcesUsesData.AddHouseSource(DataUtils.GetInt(hfHousingId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSource.SelectedValue.ToString()), DataUtils.GetDecimal(txtSourceTotal.Text));

                ClearAddSourceForm();
                BindSourcegrid();

                if (objHouseResult.IsDuplicate && !objHouseResult.IsActive)
                    LogMessage("Source already exist as in-active");
                else if (objHouseResult.IsDuplicate)
                    LogMessage("Source already exist");
                else
                    LogMessage("New Source added successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddSources_Click", "", ex.Message);
            }
        }

        protected void btnAddOtherUses_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlVHCBUses.SelectedIndex == 0)
                {
                    LogMessage("Select VHCb Use");
                    ddlVHCBUses.Focus();
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtVHCBUseAmount.Text.ToString()) == true)
                {
                    LogMessage("Enter VHCb use Total");
                    txtVHCBUseAmount.Focus();
                    return;
                }

                if (DataUtils.GetDecimal(txtVHCBUseAmount.Text) <= 0)
                {
                    LogMessage("Enter Valid VHCB Use Total");
                    txtVHCBUseAmount.Focus();
                    return;
                }

                if (ddlOtherUses.SelectedIndex == 0)
                {
                    LogMessage("Select Other Use");
                    ddlOtherUses.Focus();
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtOtherUseAmount.Text.ToString()) == true)
                {
                    LogMessage("Enter Other Use total");
                    txtOtherUseAmount.Focus();
                    return;
                }

                if (DataUtils.GetDecimal(txtOtherUseAmount.Text) <= 0)
                {
                    LogMessage("Enter Valid Other Use total");
                    txtOtherUseAmount.Focus();
                    return;
                }

                HousingSourcesUsesData.HouseResult objHouseResult = HousingSourcesUsesData.AddHouseUse(DataUtils.GetInt(hfHousingId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlVHCBUses.SelectedValue.ToString()), DataUtils.GetDecimal(txtVHCBUseAmount.Text),
                    DataUtils.GetInt(ddlOtherUses.SelectedValue.ToString()), DataUtils.GetDecimal(txtOtherUseAmount.Text));

                ClearAddUsesForm();
                BindUsesgrid();

                if (objHouseResult.IsDuplicate && !objHouseResult.IsActive)
                    LogMessage("VHCB Uses already exist as in-active");
                else if (objHouseResult.IsDuplicate)
                    LogMessage("VHCB Uses already exist");
                else
                    LogMessage("New Use added successfully");


            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddOtherUses_Click", "", ex.Message);
            }
        }

        protected void gvHousingUsesGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHousingUsesGrid.EditIndex = e.NewEditIndex;
            BindUsesgrid();
        }

        protected void gvHousingUsesGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHousingUsesGrid.EditIndex =-1;
            BindUsesgrid();
        }

        protected void gvHousingUsesGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                string strVHCBTotal = ((TextBox)gvHousingUsesGrid.Rows[rowIndex].FindControl("txtVHCBTotal")).Text;
                string strOtherTotal = ((TextBox)gvHousingUsesGrid.Rows[rowIndex].FindControl("txtOtherTotal")).Text;

                if (string.IsNullOrWhiteSpace(strVHCBTotal) == true)
                {
                    LogMessage("Enter VHCB Total");
                    return;
                }

                if (DataUtils.GetDecimal(strVHCBTotal) <= 0)
                {
                    LogMessage("Enter valid VHCB Total");
                    return;
                }

                if (string.IsNullOrWhiteSpace(strOtherTotal) == true)
                {
                    LogMessage("Enter Other Total");
                    return;
                }

                if (DataUtils.GetDecimal(strOtherTotal) <= 0)
                {
                    LogMessage("Enter valid Other Total");
                    return;
                }

                int HouseUseID = DataUtils.GetInt(((Label)gvHousingUsesGrid.Rows[rowIndex].FindControl("lblHouseUseID")).Text);
                decimal VHCBTotal = DataUtils.GetDecimal(strVHCBTotal);
                decimal OtherTotal = DataUtils.GetDecimal(strOtherTotal);
                bool isActive = Convert.ToBoolean(((CheckBox)gvHousingUsesGrid.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);

                HousingSourcesUsesData.UpdateHouseUse(HouseUseID, VHCBTotal, OtherTotal, isActive);

                gvHousingUsesGrid.EditIndex = -1;
                BindUsesgrid();

                LogMessage("House Uses updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvHousingUsesGrid_RowUpdating", "", ex.Message);
            }
        }

        protected void gvHousingSources_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHousingSources.EditIndex = e.NewEditIndex;
            BindSourcegrid();
        }

        protected void gvHousingSources_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHousingSources.EditIndex = -1;
            BindSourcegrid();
        }

        protected void gvHousingSources_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                string strTotal = ((TextBox)gvHousingSources.Rows[rowIndex].FindControl("txtTotal")).Text;

                if (string.IsNullOrWhiteSpace(strTotal) == true)
                {
                    LogMessage("Enter Total");
                    return;
                }

                if (DataUtils.GetDecimal(strTotal) <= 0)
                {
                    LogMessage("Enter valid Total");
                    return;
                }

                int HouseSourceID = DataUtils.GetInt(((Label)gvHousingSources.Rows[rowIndex].FindControl("lblHouseSourceID")).Text);
                decimal Total = DataUtils.GetDecimal(strTotal);
                bool isActive = Convert.ToBoolean(((CheckBox)gvHousingSources.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);

                HousingSourcesUsesData.UpdateHouseSource(HouseSourceID, Total, isActive);

                gvHousingSources.EditIndex = -1;
                BindSourcegrid();

                LogMessage("House Source updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvHousingSources_RowUpdating", "", ex.Message);
            }
        }
    }
}