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
    public partial class ConservationSourcesUses : System.Web.UI.Page
    {
        string Pagename = "ConservationSourcesUses";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            if (!IsPostBack)
            {
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

                ConservationSourcesUsesData.AddConservationSource(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlSource.SelectedValue.ToString()), DataUtils.GetDecimal(txtSourceTotal.Text));

                ClearAddSourceForm();
                BindSourcegrid();
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
            }
            else
            {
                //Sources
                dvNewSource.Visible = false;
                dvConsevationSourcesGrid.Visible = false;

                //Uses
                dvNewUse.Visible = false;
                dvConsevationUsesGrid.Visible = false;
            }
            }

        private void BindSourcegrid()
        {
            try
            {
                DataTable dtSources = ConservationSourcesUsesData.GetConserveSourcesList(DataUtils.GetInt(hfProjectId.Value), 
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()));

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
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()));

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

                ConservationSourcesUsesData.AddConservationUse(DataUtils.GetInt(hfProjectId.Value),
                    DataUtils.GetInt(ddlBudgetPeriod.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlVHCBUses.SelectedValue.ToString()), DataUtils.GetDecimal(txtVHCBUseAmount.Text),
                    DataUtils.GetInt(ddlOtherUses.SelectedValue.ToString()), DataUtils.GetDecimal(txtOtherUseAmount.Text));

                ClearAddUsesForm();
                BindUsesgrid();
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
            txtUsesTotal.Text = "";
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
                int LkConSource = DataUtils.GetInt(((DropDownList)gvConsevationSources.Rows[rowIndex].FindControl("ddlSource")).SelectedValue.ToString());
                decimal  Total = DataUtils.GetDecimal(((TextBox)gvConsevationSources.Rows[rowIndex].FindControl("txtTotal")).Text);
                //bool isActive = Convert.ToBoolean(((CheckBox)gvConsevationSources.Rows[rowIndex].FindControl("chkActiveEditPS")).Checked);

                ConservationSourcesUsesData.UpdateConservationSource(ConserveSourcesID, LkConSource, Total);
                
                gvConsevationSources.EditIndex = -1;
                BindSourcegrid();

                LogMessage("Conservation Source updated successfully");
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectStatus_RowUpdating", "", ex.Message);
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
                    DropDownList ddlSource = (e.Row.FindControl("ddlSource") as DropDownList);
                    TextBox txtLkConSource = (e.Row.FindControl("txtLkConSource") as TextBox);

                    if (txtLkConSource != null)
                    {
                        BindLookUP(ddlSource, 110);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlSource.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkConSource.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlSource.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }
    }
}