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

namespace vhcbcloud.Conservation
{
    public partial class ConservationAttributes : System.Web.UI.Page
    {
        string Pagename = "ConservationAttributes";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";

            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                hfConserveId.Value = ConservationAttributeData.GetConserveID(DataUtils.GetInt(hfProjectId.Value)).ToString();
                PopulateProjectDetails();

                BindControls();
                BindGrids();
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
                if (dr["URL"].ToString().Contains("ConservationAttributes.aspx"))
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

        private void BindControls()
        {
            BindLookUP(ddlAttribute, 6);
            BindLookUP(ddlAffordability, 54);
            BindLookUP(ddlPA, 28);
            BindLookUP(ddlAltEnergy, 3);
            BindLookUP(ddlBufferType, 5);
            BindLookUP(ddlOT, 45);
            BindLookUP(ddlLegalInterest, 80);
            BindLookUP(ddlLegalMechanism, 24);
        }

        private void BindGrids()
        {
            BindAttributeGrid();
            BindAffordabilityGrid();
            BindPAGrid();
            BindAltEnergyGrid();
            BindBufferTypeGrid();
            BindOTGrid();
            BindLegalIntrestGrid();
            BindLegalMechanismGrid();
        }

        private void BindAttributeGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetConserveAttribList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected void AddAttribute_Click(object sender, EventArgs e)
        {
            if (ddlAttribute.SelectedIndex == 0)
            {
                LogMessage("Select Attribute");
                ddlAttribute.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddConserveAttribute(DataUtils.GetInt(hfConserveId.Value),
                DataUtils.GetInt(ddlAttribute.SelectedValue.ToString()));
            ddlAttribute.SelectedIndex = -1;
            cbAddAttribute.Checked = false;

            BindAttributeGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Attribute already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
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

            int ConserveAttribID = DataUtils.GetInt(((Label)gvAttribute.Rows[rowIndex].FindControl("lblConserveAttribID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAttribute.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateConserveAttribute(ConserveAttribID, RowIsActive);
            gvAttribute.EditIndex = -1;

            BindAttributeGrid();

            LogMessage("Attribute updated successfully");
        }

        protected void btnAddAffordability_Click(object sender, EventArgs e)
        {
            if (ddlAffordability.SelectedIndex == 0)
            {
                LogMessage("Select Affordability Mechanism");
                ddlAffordability.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddAffordabilityMechanism(DataUtils.GetInt(hfConserveId.Value),
                DataUtils.GetInt(ddlAffordability.SelectedValue.ToString()));
            ddlAffordability.SelectedIndex = -1;
            cbAddAffMechanism.Checked = false;

            BindAffordabilityGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Affordability Mechanism already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Affordability Mechanism already exist");
            else
                LogMessage("New Affordability Mechanism added successfully");
        }

        private void BindAffordabilityGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetAffordabilityMechanismsList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAffordabilityGrid.Visible = true;
                    gvAffordability.DataSource = dt;
                    gvAffordability.DataBind();
                }
                else
                {
                    dvAffordabilityGrid.Visible = false;
                    gvAffordability.DataSource = null;
                    gvAffordability.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAffordabilityGrid", "", ex.Message);
            }
        }

        protected void gvAffordability_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAffordability.EditIndex = e.NewEditIndex;
            BindAffordabilityGrid();
        }

        protected void gvAffordability_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAffordability.EditIndex = -1;
            BindAffordabilityGrid();
        }

        protected void gvAffordability_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveAffmechID = DataUtils.GetInt(((Label)gvAffordability.Rows[rowIndex].FindControl("lblConserveAffmechID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAffordability.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateAffordabilityMechanism(ConserveAffmechID, RowIsActive);
            gvAffordability.EditIndex = -1;

            BindAffordabilityGrid();

            LogMessage("Affordability Mechanism updated successfully");
        }

        protected void btnAddPA_Click(object sender, EventArgs e)
        {
            if (ddlPA.SelectedIndex == 0)
            {
                LogMessage("Select Public Access");
                ddlPA.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddPublicAccess(DataUtils.GetInt(hfConserveId.Value),
                DataUtils.GetInt(ddlPA.SelectedValue.ToString()));
            ddlPA.SelectedIndex = -1;
            cbAddPA.Checked = false;

            BindPAGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Public Access already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Public Access already exist");
            else
                LogMessage("New Public Access added successfully");
        }

        private void BindPAGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetPublicAccessList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvPAGrid.Visible = true;
                    gvPA.DataSource = dt;
                    gvPA.DataBind();
                }
                else
                {
                    dvPAGrid.Visible = false;
                    gvPA.DataSource = null;
                    gvPA.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPAGrid", "", ex.Message);
            }
        }

        protected void gvPA_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPA.EditIndex = e.NewEditIndex;
            BindPAGrid();
        }

        protected void gvPA_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPA.EditIndex = -1;
            BindPAGrid();
        }

        protected void gvPA_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConservePAcessID = DataUtils.GetInt(((Label)gvPA.Rows[rowIndex].FindControl("lblConservePAcessID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvPA.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdatePublicAccess(ConservePAcessID, RowIsActive);
            gvPA.EditIndex = -1;

            BindPAGrid();

            LogMessage("Public Access updated successfully");
        }

        protected void btnAddAltEnergy_Click(object sender, EventArgs e)
        {
            if (ddlAltEnergy.SelectedIndex == 0)
            {
                LogMessage("Select Alternative Energy");
                ddlAltEnergy.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddAltEnergy(DataUtils.GetInt(hfConserveId.Value),
               DataUtils.GetInt(ddlAltEnergy.SelectedValue.ToString()));
            ddlAltEnergy.SelectedIndex = -1;
            cbAddAltEnergy.Checked = false;

            BindAltEnergyGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Alternative Energy already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Alternative Energy already exist");
            else
                LogMessage("New Alternative Energy added successfully");
        }

        protected void gvAltEnergy_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAltEnergy.EditIndex = e.NewEditIndex;
            BindAltEnergyGrid();
        }

        protected void gvAltEnergy_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAltEnergy.EditIndex = -1;
            BindAltEnergyGrid();
        }

        protected void gvAltEnergy_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConsserveAltEnergyID = DataUtils.GetInt(((Label)gvAltEnergy.Rows[rowIndex].FindControl("lblConsserveAltEnergyID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAltEnergy.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateAltEnergy(ConsserveAltEnergyID, RowIsActive);
            gvAltEnergy.EditIndex = -1;

            BindAltEnergyGrid();

            LogMessage("Alternative Energy updated successfully");
        }

        private void BindAltEnergyGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetAltEnergyList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAltEnergyGrid.Visible = true;
                    gvAltEnergy.DataSource = dt;
                    gvAltEnergy.DataBind();
                }
                else
                {
                    dvAltEnergyGrid.Visible = false;
                    gvAltEnergy.DataSource = null;
                    gvAltEnergy.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAltEnergyGrid", "", ex.Message);
            }
        }

        protected void btnAddBuffer_Click(object sender, EventArgs e)
        {
            if (ddlBufferType.SelectedIndex == 0)
            {
                LogMessage("Select Buffer Type");
                ddlBufferType.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddBuffers(DataUtils.GetInt(hfConserveId.Value),
                          DataUtils.GetInt(ddlBufferType.SelectedValue.ToString()));
            ddlBufferType.SelectedIndex = -1;
            cbAddBuffer.Checked = false;

            BindBufferTypeGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Buffer Type already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Buffer Type already exist");
            else
                LogMessage("New Buffer Type added successfully");
        }

        protected void gvBuffer_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBuffer.EditIndex = e.NewEditIndex;
            BindBufferTypeGrid();
        }

        protected void gvBuffer_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBuffer.EditIndex = -1;
            BindBufferTypeGrid();
        }

        protected void gvBuffer_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveBufferID = DataUtils.GetInt(((Label)gvBuffer.Rows[rowIndex].FindControl("lblConserveBufferID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvBuffer.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateBuffers(ConserveBufferID, RowIsActive);
            gvBuffer.EditIndex = -1;

            BindBufferTypeGrid();

            LogMessage("Buffer Type updated successfully");
        }

        private void BindBufferTypeGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetBuffersList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvBufferGrid.Visible = true;
                    gvBuffer.DataSource = dt;
                    gvBuffer.DataBind();
                }
                else
                {
                    dvBufferGrid.Visible = false;
                    gvBuffer.DataSource = null;
                    gvBuffer.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBufferTypeGrid", "", ex.Message);
            }
        }

        protected void btnAddOT_Click(object sender, EventArgs e)
        {
            if (ddlOT.SelectedIndex == 0)
            {
                LogMessage("Select Owner Type");
                ddlOT.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddOwnerType(DataUtils.GetInt(hfConserveId.Value),
                         DataUtils.GetInt(ddlOT.SelectedValue.ToString()));
            ddlOT.SelectedIndex = -1;
            cbAddOT.Checked = false;

            BindOTGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Owner Type already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Owner Type already exist");
            else
                LogMessage("New Owner Type added successfully");
        }

        protected void gvOT_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOT.EditIndex = e.NewEditIndex;
            BindOTGrid();
        }

        protected void gvOT_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOT.EditIndex = -1;
            BindOTGrid();
        }

        protected void gvOT_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveOTypeID = DataUtils.GetInt(((Label)gvOT.Rows[rowIndex].FindControl("lblConserveOTypeID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvOT.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateOwnerType(ConserveOTypeID, RowIsActive);
            gvOT.EditIndex = -1;

            BindOTGrid();

            LogMessage("Owner Type updated successfully");
        }

        private void BindOTGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetOwnerTypesList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvOTGrid.Visible = true;
                    gvOT.DataSource = dt;
                    gvOT.DataBind();
                }
                else
                {
                    dvOTGrid.Visible = false;
                    gvOT.DataSource = null;
                    gvOT.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBufferTypeGrid", "", ex.Message);
            }
        }

        protected void btnAddLegalInterest_Click(object sender, EventArgs e)
        {
            if (ddlLegalInterest.SelectedIndex == 0)
            {
                LogMessage("Select Legal Interest");
                ddlLegalInterest.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddLegalInterest(DataUtils.GetInt(hfConserveId.Value),
                                     DataUtils.GetInt(ddlLegalInterest.SelectedValue.ToString()));
            ddlLegalInterest.SelectedIndex = -1;
            cbAddLegalInterest.Checked = false;

            BindLegalIntrestGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Legal Intrest already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Legal Intrest already exist");
            else
                LogMessage("New Legal Intrest added successfully");
        }

        private void BindLegalIntrestGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetLegalInterestsList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvLegalInterestGrid.Visible = true;
                    gvLegalInterest.DataSource = dt;
                    gvLegalInterest.DataBind();
                }
                else
                {
                    dvLegalInterestGrid.Visible = false;
                    gvLegalInterest.DataSource = null;
                    gvLegalInterest.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLegalIntrestGrid", "", ex.Message);
            }
        }

        protected void gvLegalInterest_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLegalInterest.EditIndex = e.NewEditIndex;
            BindLegalIntrestGrid();
        }

        protected void gvLegalInterest_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLegalInterest.EditIndex = -1;
            BindLegalIntrestGrid();
        }

        protected void gvLegalInterest_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveLegInterestID = DataUtils.GetInt(((Label)gvLegalInterest.Rows[rowIndex].FindControl("lblConserveLegInterestID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvLegalInterest.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateLegalInterest(ConserveLegInterestID, RowIsActive);
            gvLegalInterest.EditIndex = -1;

            BindLegalIntrestGrid();

            LogMessage("Legal Intrest updated successfully");
        }

        protected void btnAddLegalMechanism_Click(object sender, EventArgs e)
        {
            if (ddlLegalMechanism.SelectedIndex == 0)
            {
                LogMessage("Select Legal Mechanism");
                ddlLegalMechanism.Focus();
                return;
            }

            AttributeResult obAttributeResult = ConservationAttributeData.AddLegalMechanism(DataUtils.GetInt(hfConserveId.Value),
                                     DataUtils.GetInt(ddlLegalMechanism.SelectedValue.ToString()));
            ddlLegalMechanism.SelectedIndex = -1;
            cbAddLegalMechanism.Checked = false;

            BindLegalMechanismGrid();

            if (obAttributeResult.IsDuplicate && !obAttributeResult.IsActive)
                LogMessage("Legal Mechanism already exist as in-active");
            else if (obAttributeResult.IsDuplicate)
                LogMessage("Legal Mechanism already exist");
            else
                LogMessage("New Legal Mechanism added successfully");
        }

        protected void gvLegalMechanism_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLegalMechanism.EditIndex = e.NewEditIndex;
            BindLegalMechanismGrid();
        }

        protected void gvLegalMechanism_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLegalMechanism.EditIndex = -1;
            BindLegalMechanismGrid();
        }

        protected void gvLegalMechanism_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int ConserveLegMechID = DataUtils.GetInt(((Label)gvLegalMechanism.Rows[rowIndex].FindControl("lblConserveLegMechID")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvLegalMechanism.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAttributeData.UpdateLegalMechanism(ConserveLegMechID, RowIsActive);
            gvLegalMechanism.EditIndex = -1;

            BindLegalMechanismGrid();

            LogMessage("Legal Mechanism updated successfully");
        }

        private void BindLegalMechanismGrid()
        {
            try
            {
                DataTable dt = ConservationAttributeData.GetLegalMechanismList(DataUtils.GetInt(hfConserveId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvLegalMechanismGrid.Visible = true;
                    gvLegalMechanism.DataSource = dt;
                    gvLegalMechanism.DataBind();
                }
                else
                {
                    dvLegalMechanismGrid.Visible = false;
                    gvLegalMechanism.DataSource = null;
                    gvLegalMechanism.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLegalMechanismGrid", "", ex.Message);
            }
        }
    }
}
