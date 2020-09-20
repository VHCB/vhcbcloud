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
using VHCBCommon.DataAccessLayer.Viability;

namespace vhcbcloud.Viability
{
    public partial class EnterpriseGrantEvaluations : System.Web.UI.Page
    {
        string Pagename = "EnterpriseGrantEvaluations";
        bool isWaterQualityGrant = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            hfProjectId.Value = "0";
            hfEnterImpGrantID.Value = "0";
            if (Request.QueryString["ProjectId"] != null)
                hfProjectId.Value = Request.QueryString["ProjectId"];

            GenerateTabs();

            if (!IsPostBack)
            {
                if (isWaterQualityGrant)
                {
                    dvWaterQualityGrants.Visible = true;
                    BindWhatAreaImproveCheckBoxList();
                    BindWhatAreaImproveGrid();
                    BindQuestions();
                    PopulateQuestions();
                }
            } 
        }

        private void PopulateQuestions()
        {
            btnQuestionsAdd.Text = "Add";
            DataRow dr = GrantEvaluationsData.getEnterpriseGrantQuestions(DataUtils.GetInt(hfEnterImpGrantID.Value));
            if (dr != null)
            {
                btnQuestionsAdd.Text = "Update";
                txtFarmViability.Text = dr["FarmViability"].ToString(); ;
                txtNutrientManagement.Text = dr["NutrientManagement"].ToString(); ;
                txtCompliance.Text = dr["Compliance"].ToString(); ;
                txtOperationalEfficiency.Text = dr["OperationalEfficiency"].ToString(); ;
                txtQualityofLife.Text = dr["QualityofLife"].ToString(); ;
                txtEquipmentHrs.Text = dr["EquipmentHrs"].ToString(); ;
                txtAcres.Text = dr["Acres"].ToString();

                PopulateDropDown(ddlStewardship, dr["Balance"].ToString());
                PopulateDropDown(ddlSoil, dr["Soil"].ToString());
                PopulateDropDown(ddlManure, dr["Manure"].ToString());
                PopulateDropDown(ddlCrop, dr["Crop"].ToString());
                PopulateDropDown(ddlMilk, dr["Milk"].ToString());
                PopulateDropDown(ddlHealth, dr["Health"].ToString());
                PopulateDropDown(ddlEfficiency, dr["Efficiency"].ToString());
                PopulateDropDown(ddlWorkEnvironment, dr["WorkEnvironment"].ToString());
                PopulateDropDown(ddlFinancial, dr["Financial"].ToString());
                PopulateDropDown(ddlIncome, dr["Income"].ToString());
                PopulateDropDown(ddlBalance, dr["Balance"].ToString());
                cbPermission.Checked = DataUtils.GetBool(dr["Permission"].ToString());
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
        private void BindQuestions()
        {
            DataTable dt = LookupValuesData.Getlookupvalues(219);
            BindLookUP(ddlStewardship, dt);
            BindLookUP(ddlSoil, dt);
            BindLookUP(ddlManure, dt);
            BindLookUP(ddlCrop, dt);
            BindLookUP(ddlMilk, dt);
            BindLookUP(ddlHealth, dt);
            BindLookUP(ddlEfficiency, dt);
            BindLookUP(ddlWorkEnvironment, dt);
            BindLookUP(ddlFinancial, dt);
            BindLookUP(ddlIncome, dt);
            BindLookUP(ddlBalance, dt);
        }

        private void BindLookUP(DropDownList ddList, DataTable datatable)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = datatable;
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
        private void GenerateTabs()
        {
            string ProgramId = null;
            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

            if (Request.QueryString["ProjectId"] != null)
                hfProjectId.Value = Request.QueryString["ProjectId"];

            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + hfProjectId.Value);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            bool isGrants = false;
            DataTable dtTabs = TabsData.GetProgramTabsForViability(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ProgramId));
            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                li1.Attributes.Add("class", "RoundedCornerTop");
                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", "../" + dr["URL"].ToString() + "?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                anchor1.InnerText = dr["TabName"].ToString();
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                
                li1.Controls.Add(anchor1);

                if (dr["TabName"].ToString() == "Viability Grants")
                    isGrants = true;
            }
            if (isGrants)
            {
                DataRow drEntImpGrant = EnterpriseImpGrantData.GetEnterpriseImpGrantsById(DataUtils.GetInt(hfProjectId.Value));
                if (drEntImpGrant != null)
                {
                    if (drEntImpGrant["FYGrantRound"].ToString() != "")
                    {
                        HtmlGenericControl li1 = new HtmlGenericControl("li");
                        li1.Attributes.Add("class", "RoundedCornerTop selected");
                        Tabs.Controls.Add(li1);
                        HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                        anchor1.Attributes.Add("href", "EnterpriseGrantEvaluations.aspx?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                        anchor1.Attributes.Add("class", "RoundedCornerTop");
                        anchor1.InnerText = "Evaluations";
                        li1.Controls.Add(anchor1);
                    }
                    hfEnterImpGrantID.Value = drEntImpGrant["EnterImpGrantID"].ToString();

                    if(drEntImpGrant["FYGrantRoundDescription"].ToString().Contains("Water Quality Grants"))
                    {
                        isWaterQualityGrant = true;
                    }
                }
            }
        }
        private void BindWhatAreaImproveCheckBoxList()
        {
            try
            {
                cblWhatAreaImprove.Items.Clear();
                cblWhatAreaImprove.DataSource = LookupValuesData.Getlookupvalues(2282);
                cblWhatAreaImprove.DataValueField = "typeid";
                cblWhatAreaImprove.DataTextField = "description";
                cblWhatAreaImprove.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnWhatAreaImprove_Click(object sender, EventArgs e)
        {
            if (!cblWhatAreaImprove.Items.Cast<ListItem>().Any(i => i.Selected))
            {
                LogMessage("Please Select");
                cblWhatAreaImprove.Focus();
                return;
            }

            foreach (ListItem item in cblWhatAreaImprove.Items)
            {
                if (item.Selected)
                {
                    GrantEvaluationsData.AddEnterpriseGrantImprovedBusiness(DataUtils.GetInt(hfEnterImpGrantID.Value),
                    DataUtils.GetInt(item.Value));
                }
            }
            LogMessage("Grant Questions added successfully");
            //gvWatershed.EditIndex = -1;
            BindWhatAreaImproveGrid();
            ClearWhatAreaImproveForm();
            cbAddWhatAreaImprove.Checked = false;
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        private void BindWhatAreaImproveGrid()
        {
            try
            {
                DataTable dtWatershed = GrantEvaluationsData.GetEnterpriseGrantImprovedBusinessList(DataUtils.GetInt(hfEnterImpGrantID.Value), true);

                if (dtWatershed.Rows.Count > 0)
                {
                    dvAddWhatAreaImproveGrid.Visible = true;
                    gvAddWhatAreaImprove.DataSource = dtWatershed;
                    gvAddWhatAreaImprove.DataBind();
                }
                else
                {
                    dvAddWhatAreaImproveGrid.Visible = false;
                    gvAddWhatAreaImprove.DataSource = null;
                    gvAddWhatAreaImprove.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindWhatAreaImproveGrid", "", ex.Message);
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
        private void ClearWhatAreaImproveForm()
        {
            cbAddWhatAreaImprove.Checked = false;
            foreach (ListItem item in cblWhatAreaImprove.Items)
            {
                if (item.Selected)
                {
                    item.Selected = false;
                }
            }
        }

        protected void btnQuestionsAdd_Click(object sender, EventArgs e)
        {
            if (btnQuestionsAdd.Text.ToLower() == "add")
            {
                GrantEvaluationsData.AddEnterpriseGrantQuestions(DataUtils.GetInt(hfEnterImpGrantID.Value),
                    txtFarmViability.Text,
                    txtNutrientManagement.Text,
                    txtCompliance.Text,
                    txtOperationalEfficiency.Text,
                    txtQualityofLife.Text,
                    DataUtils.GetDecimal(txtEquipmentHrs.Text),
                    DataUtils.GetDecimal(txtAcres.Text),
                    DataUtils.GetInt(ddlStewardship.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSoil.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlManure.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlCrop.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlMilk.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlHealth.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlEfficiency.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlWorkEnvironment.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlFinancial.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlIncome.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBalance.SelectedValue.ToString()),
                    cbPermission.Checked);

                LogMessage("Successfully added questions");
            }
            else
            {
                GrantEvaluationsData.UpdateEnterpriseGrantQuestions(DataUtils.GetInt(hfEnterImpGrantID.Value),
                    txtFarmViability.Text,
                    txtNutrientManagement.Text,
                    txtCompliance.Text,
                    txtOperationalEfficiency.Text,
                    txtQualityofLife.Text,
                    DataUtils.GetDecimal(txtEquipmentHrs.Text),
                    DataUtils.GetDecimal(txtAcres.Text),
                    DataUtils.GetInt(ddlStewardship.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSoil.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlManure.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlCrop.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlMilk.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlHealth.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlEfficiency.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlWorkEnvironment.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlFinancial.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlIncome.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlBalance.SelectedValue.ToString()),
                    cbPermission.Checked);

                LogMessage("Successfully updated questions");
            }
        }
    }
}