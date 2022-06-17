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
using VHCBCommon.DataAccessLayer.Conservation;
using VHCBCommon.DataAccessLayer.Viability;

namespace vhcbcloud.Viability
{
    public partial class EnterpriseInfo : System.Web.UI.Page
    {
        string Pagename = "EnterpriseInfo";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                ce_txtEventDate.SelectedDate = DateTime.Today;
                CalendarExtender1.SelectedDate = DateTime.Today;
                BindControls();
                GetRoleAccess();
                PopulateProjectDetails();
                BindProductGrid();
                BindAttributeGrid();
                BindWatershedGrid();
            }
            //GetRoleAuth();
        }

        protected bool GetIsVisibleBasedOnRole()
        {
            return DataUtils.GetBool(hfIsVisibleBasedOnRole.Value);
        }

        protected void GetRoleAccess()
        {

            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(DataUtils.GetInt(hfProjectId.Value));

            if (dr != null)
            {
                bool IsUserHasSameProgram = UserSecurityData.IsUserHasSameProgramId(DataUtils.GetInt(dr["userid"].ToString()), DataUtils.GetInt(Request.QueryString["ProjectId"]));

                if (dr["usergroupid"].ToString() == "0") // Admin Only
                {
                    hfIsVisibleBasedOnRole.Value = "true";
                }
                else if (dr["usergroupid"].ToString() == "1") // Program Admin Only
                {
                    //if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    if (!IsUserHasSameProgram)
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
                    //if (dr["dfltprg"].ToString() != drProjectDetails["LkProgram"].ToString())
                    if (!IsUserHasSameProgram)
                    {
                        RoleViewOnly();
                        hfIsVisibleBasedOnRole.Value = "false";
                    }
                    else
                    {
                        if (Convert.ToBoolean(drProjectDetails["verified"].ToString()))
                        {
                            RoleViewOnlyExceptAddNewItem();
                            hfIsVisibleBasedOnRole.Value = "false";
                        }
                        else
                        {
                            hfIsVisibleBasedOnRole.Value = "true";
                        }
                    }
                }
                else if (dr["usergroupid"].ToString() == "3") // View Only
                {
                    RoleViewOnly();
                    hfIsVisibleBasedOnRole.Value = "false";
                }
            }
        }

        protected void RoleViewOnlyExceptAddNewItem()
        {
            cbAddAttribute.Enabled = true;
            cbAddProduct.Enabled = true;

            btnAddAcres.Visible = false;
            btnAddEntInfo.Visible = false;
        }

        protected void RoleViewOnly()
        {
            btnAddAcres.Visible = false;
            btnAddAttribute.Visible = false;
            btnAddEntInfo.Visible = false;
            btnAddProducts.Visible = false;

            cbAddAttribute.Enabled = false;
            cbAddProduct.Enabled = false;
        }

        //protected bool GetRoleAuth()
        //{
        //    bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
        //    if (!checkAuth)
        //        RoleReadOnly();
        //    return checkAuth;
        //}

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
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

        private void PopulateProjectDetails()
        {
            int TypeId = 0;
            int ProjectTypeId = 0;
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();

            int EnterpriseTypeId;
            int AttributeTypeId;
            string EnterpriseType;

            spnEnterPriseType.Visible = false;
            ddlEnterPriseType.Visible = false;
            btnEntePriseType.Visible = false;
            if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26598)
            {
                ddlEnterPriseType.Visible = true;
                btnEntePriseType.Visible = true;
            }
            else
                spnEnterPriseType.Visible = true;

            GetEnterpriseTypeId(DataUtils.GetInt(dr["LkProjectType"].ToString()), out EnterpriseTypeId, out AttributeTypeId, out EnterpriseType);

            spnEnterPriseType.InnerText = EnterpriseType;

            if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26851)//Farm
                TypeId = 375;
            else if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26852)//Food
                TypeId = 376;
            else if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26402)//Land Owner
                TypeId = 377;
            else if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26401)//Forest
                TypeId = 378;
            else
                TypeId = 0;

            BindSubLookUP(ddlPrimaryProduct, TypeId);

            if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26851)
                ProjectTypeId = 106;
            else if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26852)
                ProjectTypeId = 265;
            else if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26402)
                ProjectTypeId = 264;
            else if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26401)
                ProjectTypeId = 263;
            else
                ProjectTypeId = 0;

            BindLookUP(ddlProducts, ProjectTypeId);

            BindLookUP(ddlAttribute, AttributeTypeId);

            DataRow drow = EnterpriseInfoData.GetEnterprisePrimeProduct(DataUtils.GetInt(hfProjectId.Value));

            if(drow != null)
            {
                PopulateDropDown(ddlEnterPriseType, drow["AssocEnterprise"].ToString());
                //PopulateDropDown(ddlPrimaryProduct, drow["PrimaryProduct"].ToString());
                PopulateDropDown(ddlHearViability, drow["HearAbout"].ToString());
                txtYearMangBusiness.Text = drow["YrManageBus"].ToString();
                btnAddEntInfo.Text = "Update";
                txtOtherNames.Text = drow["OtherNames"].ToString();
                PopulateDropDown(ddlFarmSize, drow["FarmSize"].ToString());

                if (DataUtils.GetInt(drow["YrManageBus"].ToString()) > 0)
                {
                    int noOfYears = DateTime.Now.Year - DataUtils.GetInt(drow["YrManageBus"].ToString());
                    spnYearsManagedBusiness.InnerHtml = noOfYears.ToString();
                }

                if (DataUtils.GetInt(dr["LkProjectType"].ToString()) == 26598)
                {
                    int EnterpriseTypeId1 = DataUtils.GetInt(drow["AssocEnterprise"].ToString());
                    if (EnterpriseTypeId1 == 375)
                    {
                        ProjectTypeId = 106;
                        AttributeTypeId = 169;
                    }
                    else if (EnterpriseTypeId1 == 376)
                    {
                        ProjectTypeId = 265;
                        AttributeTypeId = 202;
                    }
                    else if (EnterpriseTypeId1 == 378)
                    {
                        ProjectTypeId = 263;
                        AttributeTypeId = 204;
                    }
                    else if (EnterpriseTypeId1 == 377)
                    {
                        ProjectTypeId = 264;
                        AttributeTypeId = 203;
                    }

                    BindSubLookUP(ddlPrimaryProduct, EnterpriseTypeId1);
                    BindLookUP(ddlAttribute, AttributeTypeId);
                    BindLookUP(ddlProducts, ProjectTypeId);
                }
                PopulateDropDown(ddlPrimaryProduct, drow["PrimaryProduct"].ToString());
            }

            if (EnterpriseType != "Viability Farm Enterprise")
            {
                dvAcres.Visible = false;
                tblAcres.Visible = false;
            }

            if (EnterpriseType == "Forest Landowner" || EnterpriseType == "Forest Products")
            {
                dvAcres.Visible = true;
                tblForectAcres.Visible = true;
            }

            LoadAcresForm();
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

        private void GetEnterpriseTypeId(int LkProjectType, 
            out int EnterpriseTypeId, out int AttributeTypeId, out string EnterpriseType)
        {
            EnterpriseTypeId = 0;
            AttributeTypeId = 0;
            EnterpriseType = "";

            if (LkProjectType == 26851)
            {
                AttributeTypeId = 169;
                EnterpriseTypeId = 375;
                EnterpriseType = "Viability Farm Enterprise";
            }
            else if (LkProjectType == 26852)
            {
                AttributeTypeId = 202;
                EnterpriseTypeId = 376;
                EnterpriseType = "Viability Food Enterprise";
            }
            else if (LkProjectType == 26401)
            {
                AttributeTypeId = 204;
                EnterpriseTypeId = 378;
                EnterpriseType = "Forest Products";
            }
            else if (LkProjectType == 26402)
            {
                AttributeTypeId = 203;
                EnterpriseTypeId = 377;
                EnterpriseType = "Forest Landowner";
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlHearViability, 215);
            BindLookUP(ddlFarmSize, 2277);
            BindLookUP(ddlWaterShedNew, 143);
            BindHUC12CheckBoxList();
            BindLookUP(ddlEnterPriseType, 72); 
        }

        private void BindLookupSubWatershed(int TypeId)
        {
            try
            {
                ddlSubWatershedNew.Items.Clear();
                ddlSubWatershedNew.DataSource = LookupMaintenanceData.GetLkLookupSubValues(TypeId, cbActiveOnly.Checked);
                ddlSubWatershedNew.DataValueField = "subtypeid";
                ddlSubWatershedNew.DataTextField = "SubDescription";
                ddlSubWatershedNew.DataBind();
                ddlSubWatershedNew.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        private void BindSubLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.GetSubLookupValues(LookupType);
                ddList.DataValueField = "SubTypeID";
                ddList.DataTextField = "SubDescription";
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

            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + hfProjectId.Value);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabsForViability(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(ProgramId));
            bool isGrants = false;
            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString().Contains("EnterpriseInfo.aspx"))
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                else
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
                        li1.Attributes.Add("class", "RoundedCornerTop");
                        Tabs.Controls.Add(li1);
                        HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                        anchor1.Attributes.Add("href", "EnterpriseGrantEvaluations.aspx?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                        anchor1.Attributes.Add("class", "RoundedCornerTop");
                        anchor1.InnerText = "Evaluations";
                        li1.Controls.Add(anchor1);
                    }
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindProductGrid();
            BindAttributeGrid();
        }

        protected void btnAddProducts_Click(object sender, EventArgs e)
        {
            if (ddlProducts.SelectedIndex == 0)
            {
                LogMessage("Select Product");
                ddlProducts.Focus();
                return;
            }

            ViabilityMaintResult objViabilityMaintResult = EnterpriseInfoData.AddEnterpriseProducts(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlProducts.SelectedValue.ToString()), DataUtils.GetDate(txtStartDate.Text));

            ddlProducts.SelectedIndex = -1;
            cbAddProduct.Checked = false;
            txtStartDate.Text = "";

            BindProductGrid();

            if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                LogMessage("Product already exist as in-active");
            else if (objViabilityMaintResult.IsDuplicate)
                LogMessage("Product already exist");
            else
                LogMessage("New Product added successfully");

        }

        protected void gvProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            BindProductGrid();
        }

        private void BindProductGrid()
        {
            try
            {
                DataTable dt = EnterpriseInfoData.GetEnterpriseProductsList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvProductsGrid.Visible = true;
                    gvProducts.DataSource = dt;
                    gvProducts.DataBind();
                }
                else
                {
                    dvProductsGrid.Visible = false;
                    gvProducts.DataSource = null;
                    gvProducts.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindProductGrid", "", ex.Message);
            }
        }

        protected void gvProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            BindProductGrid();
        }

        protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int EnterpriseProductsID = DataUtils.GetInt(((Label)gvProducts.Rows[rowIndex].FindControl("lblEnterpriseProductsID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvProducts.Rows[rowIndex].FindControl("chkActive")).Checked);
            DateTime StartDate = DataUtils.GetDate(((TextBox)gvProducts.Rows[rowIndex].FindControl("txtGridStartDate")).Text);

            EnterpriseInfoData.UpdateEnterpriseProducts(EnterpriseProductsID, StartDate, RowIsActive);
            gvProducts.EditIndex = -1;

            BindProductGrid();

            LogMessage("Product updated successfully");
        }

        protected void btnAddAcres_Click(object sender, EventArgs e)
        {
            try
            {
                int ProjectId = DataUtils.GetInt(hfProjectId.Value);

                if (btnAddAcres.Text.ToLower() == "update")
                {
                    int EnterpriseAcresId = DataUtils.GetInt(hfEnterpriseAcresId.Value);
                    EnterpriseInfoData.UpdateEnterpriseAcres(EnterpriseAcresId, DataUtils.GetInt(txtAcresInProd.Text),
                        DataUtils.GetInt(txtAcresOwned.Text), DataUtils.GetInt(txtAcresLeased.Text),
                        DataUtils.GetInt(txtForestAcres.Text), DataUtils.GetInt(txtTotalAcres.Text),
                        DataUtils.GetInt(txtAccAcres.Text));

                    LogMessage("Acres updated successfully");
                }
                else //add
                {
                    ViabilityMaintResult objViabilityMaintResult = EnterpriseInfoData.AddEnterpriseAttributes(ProjectId, 
                        DataUtils.GetInt(txtAcresInProd.Text),
                        DataUtils.GetInt(txtAcresOwned.Text), DataUtils.GetInt(txtAcresLeased.Text),
                        DataUtils.GetInt(txtForestAcres.Text), DataUtils.GetInt(txtTotalAcres.Text),
                        DataUtils.GetInt(txtAccAcres.Text));

                    if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                        LogMessage("Acres already exist as in-active");
                    else if (objViabilityMaintResult.IsDuplicate)
                        LogMessage("Acres already exist");
                    else
                        LogMessage("Acres added successfully");
                }
                LoadAcresForm();
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddGrantApplication_Click", "", ex.Message);
            }
        }

        private void LoadAcresForm()
        {
            DataRow drEntImpGrant = EnterpriseInfoData.GetEnterpriseAcresById(DataUtils.GetInt(hfProjectId.Value));
            //DataRow drTotalAcres = ConservationAppraisalsData.GetConserveTotalAcres(DataUtils.GetInt(hfProjectId.Value));

            //txtAccAcres.Text = drTotalAcres != null ? drTotalAcres["TotAcres"].ToString() : "0";

            if (drEntImpGrant != null)
            {
                hfEnterpriseAcresId.Value = drEntImpGrant["EnterpriseAcresId"].ToString();
                
                txtAcresInProd.Text = drEntImpGrant["AcresInProduction"].ToString();
                txtAcresLeased.Text = drEntImpGrant["AcresLeased"].ToString();
                txtAcresOwned.Text = drEntImpGrant["AcresOwned"].ToString();
                spnTotalAcres.InnerText = drEntImpGrant["TotalAcres"].ToString();
                txtAccAcres.Text = drEntImpGrant["AccessAcres"].ToString(); 
                btnAddAcres.Text = "Update";
            }
            else
            {
                btnAddAcres.Text = "Add";
            }
        }

        private void BindAttributeGrid()
        {
            try
            {
                DataTable dt = EnterpriseInfoData.GetEnterpriseAttributesList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAttributeGrid.Visible = true;
                    gvAttribute.DataSource = dt;
                    gvAttribute.DataBind();
                }
                else
                {
                    dvAttributeGrid.Visible = false;
                    gvAttribute.DataSource = null;
                    gvAttribute.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAttributeGrid", "", ex.Message);
            }
        }

        protected void btnAddAttribute_Click(object sender, EventArgs e)
        {
            if (ddlAttribute.SelectedIndex == 0)
            {
                LogMessage("Select Attribute");
                ddlAttribute.Focus();
                return;
            }

            ViabilityMaintResult objViabilityMaintResult = EnterpriseInfoData.AddEnterpriseAttributes(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlAttribute.SelectedValue.ToString()), DataUtils.GetDate(txtDate.Text));

            ddlAttribute.SelectedIndex = -1;
            cbAddAttribute.Checked = false;
            txtDate.Text = "";

            BindAttributeGrid();

            if (objViabilityMaintResult.IsDuplicate && !objViabilityMaintResult.IsActive)
                LogMessage("Attribute already exist as in-active");
            else if (objViabilityMaintResult.IsDuplicate)
                LogMessage("Attribute already exist");
            else
                LogMessage("New Attribute added successfully");
        }

        protected void gvAttribute_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAttribute.EditIndex = e.NewEditIndex;
            BindAttributeGrid();
        }

        protected void gvAttribute_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAttribute.EditIndex = -1;
            BindAttributeGrid();
        }

        protected void gvAttribute_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int EnterpriseAttributeID = DataUtils.GetInt(((Label)gvAttribute.Rows[rowIndex].FindControl("lblEnterpriseAttributeID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAttribute.Rows[rowIndex].FindControl("chkActive")).Checked);
            DateTime Date = DataUtils.GetDate(((TextBox)gvAttribute.Rows[rowIndex].FindControl("txtGridDate")).Text);

            EnterpriseInfoData.UpdateEnterpriseAttributes(EnterpriseAttributeID, Date, RowIsActive);
            gvAttribute.EditIndex = -1;

            BindAttributeGrid();

            LogMessage("Attribute updated successfully");
        }

        protected void ddlPrimaryProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            //EnterpriseInfoData.SubmitEnterprisePrimeProduct(DataUtils.GetInt(hfProjectId.Value), 
            //    DataUtils.GetInt(ddlPrimaryProduct.SelectedValue.ToString()), txtYearMangBusiness.Text, DataUtils.GetInt(ddlHearViability.SelectedValue.ToString()));
        }

        protected void btnAddEntInfo_Click(object sender, EventArgs e)
        {
            EnterpriseInfoData.SubmitEnterprisePrimeProduct(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlPrimaryProduct.SelectedValue.ToString()), txtYearMangBusiness.Text, 
                DataUtils.GetInt(ddlHearViability.SelectedValue.ToString()), txtOtherNames.Text);

            spnYearsManagedBusiness.InnerHtml = "";
            if (DataUtils.GetInt(txtYearMangBusiness.Text) > 0)
            {
                int noOfYears = DateTime.Now.Year - DataUtils.GetInt(txtYearMangBusiness.Text);
                spnYearsManagedBusiness.InnerHtml = noOfYears.ToString();
            }
        }

        protected void btnAddFarmSize_Click(object sender, EventArgs e)
        {
            EnterpriseInfoData.UpdateEnterprisePrimeProductFarmSize(DataUtils.GetInt(hfProjectId.Value),
               DataUtils.GetInt(ddlFarmSize.SelectedValue.ToString()));

            LogMessage("Farm Size updated successfully");
        }

        protected void rdHUC12order_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindHUC12CheckBoxList();
        }

        protected void btnWatershed_Click(object sender, EventArgs e)
        {
            if (ddlWaterShedNew.SelectedIndex == 0)
            {
                LogMessage("Select Watershed");
                ddlWaterShedNew.Focus();
                return;
            }
            if (!cblHUC12.Items.Cast<ListItem>().Any(i => i.Selected))
            {
                LogMessage("Select HUC12");
                cblHUC12.Focus();
                return;
            }

            foreach (ListItem item in cblHUC12.Items)
            {
                if (item.Selected)
                {
                    EnterpriseInfoData.AddEnterpriseWatershed(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlWaterShedNew.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSubWatershedNew.SelectedValue.ToString()),
                    DataUtils.GetInt(item.Value));
                }
            }
            LogMessage("Watershed added successfully");
            gvWatershed.EditIndex = -1;
            BindWatershedGrid();
            ClearWatershedForm();
            cbAddWatershed.Checked = false;
        }

        protected void gvWatershed_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvWatershed.EditIndex = e.NewEditIndex;
            BindWatershedGrid();
        }

        protected void gvWatershed_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int EnterpriseWaterShedID = DataUtils.GetInt(((Label)gvWatershed.Rows[rowIndex].FindControl("lblEnterpriseWaterShedID")).Text);
            int EntetrpriseHUCID = DataUtils.GetInt(((Label)gvWatershed.Rows[rowIndex].FindControl("lblEntetrpriseHUCID")).Text);

            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvWatershed.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            EnterpriseInfoData.UpdatEnterpriseWatershed(EntetrpriseHUCID, RowIsActive);
            gvWatershed.EditIndex = -1;

            BindWatershedGrid();

            LogMessage("Watershed updated successfully");
        }

        private void ClearWatershedForm()
        {
            ddlSubWatershedNew.SelectedIndex = -1;
            ddlWaterShedNew.SelectedIndex = -1;
            cbAddWatershed.Checked = false;
            foreach (ListItem item in cblHUC12.Items)
            {
                if (item.Selected)
                {
                    item.Selected = false;
                }
            }
        }

        protected void gvWatershed_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            cbWatershedActive.Checked = true;
            cbWatershedActive.Enabled = false;
            cbAddWatershed.Checked = false;
            ClearWatershedForm();
            btnWatershed.Text = "Add";

            gvWatershed.EditIndex = -1;
            BindWatershedGrid();

            btnWatershed.Visible = true;
        }

        private void BindWatershedGrid()
        {
            try
            {
                DataTable dtWatershed = EnterpriseInfoData.GetEnterpriseWatershedList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dtWatershed.Rows.Count > 0)
                {
                    dvWatershedGrid.Visible = true;
                    gvWatershed.DataSource = dtWatershed;
                    gvWatershed.DataBind();
                }
                else
                {
                    dvWatershedGrid.Visible = false;
                    gvWatershed.DataSource = null;
                    gvWatershed.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindWatershedGrid", "", ex.Message);
            }
        }

        protected void ddlWaterShedNew_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWaterShedNew.SelectedIndex > 0)
                BindLookupSubWatershed(DataUtils.GetInt(ddlWaterShedNew.SelectedValue));
            else
                ddlSubWatershedNew.Items.Clear();
        }

        private void BindHUC12CheckBoxList()
        {
            string order = "";
            try
            {
                if (rdHUC12order.SelectedItem != null)
                    order = rdHUC12order.SelectedItem.Text;

                cblHUC12.Items.Clear();
                cblHUC12.DataSource = LookupValuesData.GetHUCList(order);
                cblHUC12.DataValueField = "HUCID";
                cblHUC12.DataTextField = "HUC12Name";
                cblHUC12.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnEntePriseType_Click(object sender, EventArgs e)
        {
            EnterpriseInfoData.SubmitEnterpriseType(DataUtils.GetInt(hfProjectId.Value),
                DataUtils.GetInt(ddlEnterPriseType.SelectedValue.ToString()), txtOtherNames.Text);

            LogMessage("Enterprise Type Updated");
            Response.Redirect(Request.RawUrl);
        }
    }
}