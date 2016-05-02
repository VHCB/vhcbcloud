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

namespace vhcbcloud
{
    public partial class ConservationSourcesUses : System.Web.UI.Page
    {
        string Pagename = "ConservationSourcesUses";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            GenerateTabs();

            if (!IsPostBack)
            {
                dvImport.Visible = false;
                BindControls();

                dvNewSource.Visible = false;
                dvConsevationSourcesGrid.Visible = false;

                dvNewUse.Visible = false;
                dvConsevationUsesGrid.Visible = false;
            }
        }

        private void BindControls()
        {
            BindProjects(ddlProject);
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
                ddList.DataSource = ConservationSourcesUsesData.GetConserveUsesTypes(UseType);
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

        protected void BindProjects(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ProjectCheckRequestData.GetData("getprojectslist"); ;
                ddList.DataValueField = "project_id_name";
                ddList.DataTextField = "Proj_num";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindSourcegrid();
            BindUsesgrid();
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

        protected void btnAddSources_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlProject.SelectedIndex == 0)
                {
                    LogMessage("Select Project");
                    ddlProject.Focus();
                    return;
                }
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

                ConservationSourcesUsesData.AddConSource objAddConSource = ConservationSourcesUsesData.AddConservationSource(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSource.SelectedValue.ToString()), DataUtils.GetDecimal(txtSourceTotal.Text));

                ClearAddSourceForm();
                BindSourcegrid();

                if (objAddConSource.IsDuplicate && !objAddConSource.IsActive)
                    LogMessage("New Conservation Source already exist as in-active");
                else if (objAddConSource.IsDuplicate)
                    LogMessage("New Conservation Source already exist");
                else
                    LogMessage("New Conservation Source added successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddSources_Click", "", ex.Message);
            }
        }

        private void ClearAddSourceForm()
        {
            txtSourceTotal.Text = "";
            ddlSource.SelectedIndex = -1;
            cbAddSource.Checked = false;
        }

        protected void ddlBudgetPeriod_SelectedIndexChanged(object sender, EventArgs e)
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

                if (ddlBudgetPeriod.SelectedIndex == 1 
                    || (gvConsevationSources.Rows.Count > 0 || gvConservationUsesGrid.Rows.Count > 0))
                    dvImport.Visible = false;
                else if (ddlBudgetPeriod.SelectedIndex == 2)
                {
                    dvImport.Visible = true;
                    ddlImportFrom.Items.Clear();
                    ddlImportFrom.Items.Insert(0, new ListItem("Select", "NA"));
                    ddlImportFrom.Items.Insert(1, new ListItem("Budget Period 1", "26083"));
                }
                else if (ddlBudgetPeriod.SelectedIndex == 3)
                {
                    dvImport.Visible = true;
                    ddlImportFrom.Items.Clear();
                    ddlImportFrom.Items.Insert(0, new ListItem("Select", "NA"));
                    ddlImportFrom.Items.Insert(1, new ListItem("Budget Period 2", "26084"));
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
                DataTable dtSources = ConservationSourcesUsesData.GetConserveSourcesList(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()), cbActiveOnly.Checked);

                if (dtSources.Rows.Count > 0)
                {
                    dvConsevationSourcesGrid.Visible = true;
                    gvConsevationSources.DataSource = dtSources;
                    gvConsevationSources.DataBind();
                }
                else
                {
                    dvConsevationSourcesGrid.Visible = false;
                    gvConsevationSources.DataSource = null;
                    gvConsevationSources.DataBind();
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
                DataTable dtSources = ConservationSourcesUsesData.GetConserveUsesList(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()), cbActiveOnly.Checked);

                if (dtSources.Rows.Count > 0)
                {
                    dvConsevationUsesGrid.Visible = true;
                    gvConservationUsesGrid.DataSource = dtSources;
                    gvConservationUsesGrid.DataBind();
                }
                else
                {
                    dvConsevationUsesGrid.Visible = false;
                    gvConservationUsesGrid.DataSource = null;
                    gvConservationUsesGrid.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindSourcegrid", "", ex.Message);
            }
        }

        protected void btnAddOtherUses_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlProject.SelectedIndex == 0)
                {
                    LogMessage("Select Project");
                    ddlProject.Focus();
                    return;
                }

                if (ddlVHCBUses.SelectedIndex == 0)
                {
                    LogMessage("Select VHCb Use");
                    ddlVHCBUses.Focus();
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtVHCBUseAmount.Text.ToString()) == true)
                {
                    LogMessage("Enter vhcb use total");
                    txtVHCBUseAmount.Focus();
                    return;
                }

                if (DataUtils.GetDecimal(txtVHCBUseAmount.Text) <= 0)
                {
                    LogMessage("Enter valid vhcb use total");
                    txtVHCBUseAmount.Focus();
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtOtherUseAmount.Text.ToString()) == true)
                {
                    LogMessage("Enter other use total");
                    txtOtherUseAmount.Focus();
                    return;
                }

                if (DataUtils.GetDecimal(txtOtherUseAmount.Text) <= 0)
                {
                    LogMessage("Enter valid other use total");
                    txtOtherUseAmount.Focus();
                    return;
                }

                ConservationSourcesUsesData.AddConUse objAddConUse = ConservationSourcesUsesData.AddConservationUse(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlVHCBUses.SelectedValue.ToString()), DataUtils.GetDecimal(txtVHCBUseAmount.Text),
                    DataUtils.GetInt(ddlOtherUses.SelectedValue.ToString()), DataUtils.GetDecimal(txtOtherUseAmount.Text));

                ClearAddUsesForm();
                BindUsesgrid();

                if (objAddConUse.IsDuplicate && !objAddConUse.IsActive)
                    LogMessage("Selected VHCB Conservation Uses already exist as in-active");
                else if (objAddConUse.IsDuplicate)
                    LogMessage("Selected VHCB Conservation Uses already exist");
                else
                    LogMessage("New Conservation Uses added successfully");


            }
            catch (Exception ex)
            {
                LogError(Pagename, "btnAddSources_Click", "", ex.Message);
            }
        }

        private void ClearAddUsesForm()
        {
            ddlVHCBUses.SelectedIndex = -1;
            txtVHCBUseAmount.Text = "";
            ddlOtherUses.SelectedIndex = -1;
            txtOtherUseAmount.Text = "";
            //txtUsesTotal.Text = "";
        }

        protected void gvConsevationSources_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvConsevationSources.EditIndex = e.NewEditIndex;
            BindSourcegrid();
        }

        protected void gvConsevationSources_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvConsevationSources.EditIndex = -1;
            BindSourcegrid();
        }

        protected void gvConsevationSources_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                int ConserveSourcesID = DataUtils.GetInt(((Label)gvConsevationSources.Rows[rowIndex].FindControl("lblConserveSourcesID")).Text);
                //int LkConSource = DataUtils.GetInt(((DropDownList)gvConsevationSources.Rows[rowIndex].FindControl("ddlSource")).SelectedValue.ToString());
                decimal Total = DataUtils.GetDecimal(((TextBox)gvConsevationSources.Rows[rowIndex].FindControl("txtTotal")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvConsevationSources.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);

                ConservationSourcesUsesData.UpdateConservationSource(ConserveSourcesID, Total, isActive);

                gvConsevationSources.EditIndex = -1;
                BindSourcegrid();

                LogMessage("Conservation Source updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvConsevationSources_RowUpdating", "", ex.Message);
            }
        }

        protected void gvConsevationSources_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //DropDownList ddlSource = (e.Row.FindControl("ddlSource") as DropDownList);
                    //TextBox txtLkConSource = (e.Row.FindControl("txtLkConSource") as TextBox);

                    //if (txtLkConSource != null)
                    //{
                    //    BindLookUP(ddlSource, 110);

                    //    string itemToCompare = string.Empty;
                    //    foreach (ListItem item in ddlSource.Items)
                    //    {
                    //        itemToCompare = item.Value.ToString();
                    //        if (txtLkConSource.Text.ToLower() == itemToCompare.ToLower())
                    //        {
                    //            ddlSource.ClearSelection();
                    //            item.Selected = true;
                    //        }
                    //    }
                    //}
                }
            }
        }

        private void GenerateTabs()
        {
            string NavigatedProjectId = null;
            string ProgramId = null;

            if (Request.QueryString["ProjectId"] != null)
                NavigatedProjectId = Request.QueryString["ProjectId"];

            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];


            //Active Tab
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "ProjectMaintenance.aspx?ProjectId=" + NavigatedProjectId);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabs(DataUtils.GetInt(ProgramId));

            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString() == "ConservationSourcesUses.aspx")
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                else
                    li1.Attributes.Add("class", "RoundedCornerTop");

                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", dr["URL"].ToString() + "?ProjectId=" + NavigatedProjectId + "&ProgramId=" + ProgramId);
                anchor1.InnerText = dr["TabName"].ToString();
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                li1.Controls.Add(anchor1);
            }

            //if (ProgramId == "144")
            //{
            //    HtmlGenericControl li1 = new HtmlGenericControl("li");
            //    Tabs.Controls.Add(li1);
            //    HtmlGenericControl anchor1 = new HtmlGenericControl("a");
            //    anchor1.Attributes.Add("href", "www.google.com");
            //    anchor1.InnerText = "Housing Tab1";
            //    li1.Controls.Add(anchor1);

            //    HtmlGenericControl li2 = new HtmlGenericControl("li");
            //    Tabs.Controls.Add(li2);
            //    HtmlGenericControl anchor2 = new HtmlGenericControl("a");
            //    anchor2.Attributes.Add("href", "www.google.com");
            //    anchor2.InnerText = "Housing Tab2";
            //    li2.Controls.Add(anchor2);

            //    HtmlGenericControl li3 = new HtmlGenericControl("li");
            //    Tabs.Controls.Add(li3);
            //    HtmlGenericControl anchor3 = new HtmlGenericControl("a");
            //    anchor3.Attributes.Add("href", "www.google.com");
            //    anchor3.InnerText = "Housing Tab3";
            //    li3.Controls.Add(anchor3);
            //}
            //else if (ProgramId == "145")
            //{
            //    HtmlGenericControl li1 = new HtmlGenericControl("li");
            //    li1.Attributes.Add("class", "active");
            //    Tabs.Controls.Add(li1);
            //    HtmlGenericControl anchor1 = new HtmlGenericControl("a");
            //    anchor1.Attributes.Add("href", "#");
            //    anchor1.InnerText = "Conservation Sources Uses";
            //    anchor1.Attributes.Add("class", "active");
            //    li1.Controls.Add(anchor1);
            //}
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlBudgetPeriod.SelectedIndex = -1;
            //gvConsevationSources.DataSource = null;
            //gvConsevationSources.SelectedIndex = -1;
            //gvConservationUsesGrid.DataSource = null;
            //gvConservationUsesGrid.SelectedIndex = -1;

            dvNewSource.Visible = false;
            dvConsevationSourcesGrid.Visible = false;
            cbAddSource.Checked = false;

            dvNewUse.Visible = false;
            dvConsevationUsesGrid.Visible = false;
            cbAddUse.Checked = false;
        }

        protected void gvConservationUsesGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvConservationUsesGrid.EditIndex = e.NewEditIndex;
            BindUsesgrid();
        }

        protected void gvConservationUsesGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvConservationUsesGrid.EditIndex = -1;
            BindUsesgrid();
        }

        protected void gvConservationUsesGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                int ConserveUsesID = DataUtils.GetInt(((Label)gvConservationUsesGrid.Rows[rowIndex].FindControl("lblConserveUsesID")).Text);
                //int LkConSource = DataUtils.GetInt(((DropDownList)gvConservationUsesGrid.Rows[rowIndex].FindControl("ddlSource")).SelectedValue.ToString());
                decimal VHCBTotal = DataUtils.GetDecimal(((TextBox)gvConservationUsesGrid.Rows[rowIndex].FindControl("txtVHCBTotal")).Text);
                decimal OtherTotal = DataUtils.GetDecimal(((TextBox)gvConservationUsesGrid.Rows[rowIndex].FindControl("txtOtherTotal")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvConservationUsesGrid.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);

                ConservationSourcesUsesData.UpdateConservationUse(ConserveUsesID, VHCBTotal, OtherTotal, isActive);

                gvConservationUsesGrid.EditIndex = -1;
                BindUsesgrid();

                LogMessage("Conservation Uses updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvConservationUsesGrid_RowUpdating", "", ex.Message);
            }
        }
    }
}