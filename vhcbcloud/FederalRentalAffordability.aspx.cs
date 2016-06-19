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
    public partial class FederalRentalAffordability : System.Web.UI.Page
    {
        string Pagename = "FederalRentalAffordability";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            ifProjectNotes.Src = "ProjectNotes.aspx";


            if (!IsPostBack)
            {

                BindControls();
                BindGrids();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlFedProgram, 105);
            BindLookUP(ddlCounty, 100);
            BindLookUP(ddlUnitType, 166);
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

        private void BindGrids()
        {
            BindCountyRentsGrid();
        }

        private void BindCountyRentsGrid()
        {
            dvNewCountyUnitRent.Visible = false;

            try
            {
                DataTable dt = FederalRentalAffordabilityData.GetCountyRentsList(cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvCountyRentsGrid.Visible = true;
                    gvCountyRents.DataSource = dt;
                    gvCountyRents.DataBind();
                }
                else
                {
                    dvCountyRentsGrid.Visible = false;
                    gvCountyRents.DataSource = null;
                    gvCountyRents.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCountyRentsGrid", "", ex.Message);
            }
        }

        protected void btnAddCountyRent_Click(object sender, EventArgs e)
        {
            if (ddlFedProgram.SelectedIndex == 0)
            {
                LogMessage("Select Fed Program");
                ddlFedProgram.Focus();
                return;
            }
            if (ddlCounty.SelectedIndex == 0)
            {
                LogMessage("Select County");
                ddlCounty.Focus();
                return;
            }
            if (txtStartDate.Text.Trim() == "")
            {
                LogMessage("Enter Start Date");
                txtStartDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtStartDate.Text.Trim()))
                {
                    LogMessage("Enter Valid Start Date");
                    txtStartDate.Focus();
                    return;
                }
            }

            if (txtEndDate.Text.Trim() == "")
            {
                LogMessage("Enter End Date");
                txtEndDate.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtEndDate.Text.Trim()))
                {
                    LogMessage("Enter Valid End Date");
                    txtEndDate.Focus();
                    return;
                }
            }

            FederalRentalAffordabilityData.AddCountyRent(DataUtils.GetInt(ddlFedProgram.SelectedValue.ToString()), DataUtils.GetInt(ddlCounty.SelectedValue.ToString()),
                DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text));
            ClearCountyRentForm();
            BindGrids();
            LogMessage("County Rent Added Successfully");

        }

        private void ClearCountyRentForm()
        {
            ddlCounty.SelectedIndex = -1;
            ddlFedProgram.SelectedIndex = -1;
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            cbAddCountyRent.Checked = false;
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

        protected void gvCountyRents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCountyRents.EditIndex = e.NewEditIndex;
            BindCountyRentsGrid();
        }

        protected void gvCountyRents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCountyRents.EditIndex = -1;
            BindCountyRentsGrid();
        }

        protected void gvCountyRents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int CountyRentId = DataUtils.GetInt(((Label)gvCountyRents.Rows[rowIndex].FindControl("lblCountyRentId")).Text);
            int FedProgram = DataUtils.GetInt(((DropDownList)gvCountyRents.Rows[rowIndex].FindControl("ddlFedProgram")).SelectedValue.ToString());
            int County = DataUtils.GetInt(((DropDownList)gvCountyRents.Rows[rowIndex].FindControl("ddlCounty")).SelectedValue.ToString());
            DateTime StartDate = DataUtils.GetDate(((TextBox)gvCountyRents.Rows[rowIndex].FindControl("txtStartDate")).Text);
            DateTime EndDate = DataUtils.GetDate(((TextBox)gvCountyRents.Rows[rowIndex].FindControl("txtEndDate")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvCountyRents.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            FederalRentalAffordabilityData.UpdateCountyRent(CountyRentId, FedProgram, County, StartDate, EndDate, RowIsActive);

            gvCountyRents.EditIndex = -1;

            BindCountyRentsGrid();

            LogMessage("County Rent Updated successfully");
        }

        protected void gvCountyRents_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlFedProgram = (e.Row.FindControl("ddlFedProgram") as DropDownList);
                    TextBox txtFedProgID = (e.Row.FindControl("txtFedProgID") as TextBox);

                    DropDownList ddlCounty = (e.Row.FindControl("ddlCounty") as DropDownList);
                    TextBox txtCounty = (e.Row.FindControl("txtCounty") as TextBox);

                    if (txtFedProgID != null)
                    {
                        BindLookUP(ddlFedProgram, 105);
                        BindLookUP(ddlCounty, 100);

                        PopulateDropDown(ddlFedProgram, txtFedProgID.Text.ToLower());
                        PopulateDropDown(ddlCounty, txtCounty.Text.ToLower());
                    }
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

        protected void rdBtnSelectCountyRent_CheckedChanged(object sender, EventArgs e)
        {
            int CountyRentId = GetCountyRentSelectedRecordID(gvCountyRents);
            hfCountyRentId.Value = CountyRentId.ToString();
            dvNewCountyUnitRent.Visible = true;
            BindCountyUnitRentGrid();
        }

        private int GetCountyRentSelectedRecordID(GridView gvCountyRents)
        {
            int CountyRentId = 0;
            
            for (int i = 0; i < gvCountyRents.Rows.Count; i++)
            {
                RadioButton rdBtnSelectCountyRent = (RadioButton)gvCountyRents.Rows[i].Cells[0].FindControl("rdBtnSelectCountyRent");
                if (rdBtnSelectCountyRent != null)
                {
                    if (rdBtnSelectCountyRent.Checked)
                    {
                        HiddenField hf = (HiddenField)gvCountyRents.Rows[i].Cells[0].FindControl("HiddenCountyRentId");

                        if (hf != null)
                        {
                            CountyRentId = DataUtils.GetInt(hf.Value);
                        }
                        break;
                    }
                }
            }
            return CountyRentId;
        }

        private void BindCountyUnitRentGrid()
        {
            try
            {
                DataTable dt = FederalRentalAffordabilityData.GetCountyUnitRentsList(DataUtils.GetInt(hfCountyRentId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvCountyUnitRentGrid.Visible = true;
                    gvCountyUnitRent.DataSource = dt;
                    gvCountyUnitRent.DataBind();
                }
                else
                {
                    dvCountyUnitRentGrid.Visible = false;
                    gvCountyUnitRent.DataSource = null;
                    gvCountyUnitRent.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindCountyUnitRentGrid", "", ex.Message);
            }
        }

        protected void gvCountyUnitRent_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCountyUnitRent.EditIndex = e.NewEditIndex;
            BindCountyUnitRentGrid();
        }

        protected void gvCountyUnitRent_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCountyUnitRent.EditIndex = -1;
            BindCountyUnitRentGrid();
        }

        protected void gvCountyUnitRent_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int CountyUnitRentID = DataUtils.GetInt(((Label)gvCountyUnitRent.Rows[rowIndex].FindControl("lblCountyUnitRentID")).Text);
            //int UnitType = DataUtils.GetInt(((DropDownList)gvCountyUnitRent.Rows[rowIndex].FindControl("ddlUnitType")).SelectedValue.ToString());
            decimal LowRent = DataUtils.GetDecimal(((TextBox)gvCountyUnitRent.Rows[rowIndex].FindControl("txtLowRent")).Text);
            decimal HighRent = DataUtils.GetDecimal(((TextBox)gvCountyUnitRent.Rows[rowIndex].FindControl("txtHighRent")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvCountyUnitRent.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            FederalRentalAffordabilityData.UpdateCountyUnitRent(CountyUnitRentID, HighRent, LowRent, RowIsActive);

            gvCountyUnitRent.EditIndex = -1;

            BindCountyUnitRentGrid();

            LogMessage("County Unit Rent Updated successfully");
        }

        protected void gvCountyUnitRent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                //if (e.Row.RowType == DataControlRowType.DataRow)
                //{
                //    DropDownList ddlUnitType = (e.Row.FindControl("ddlUnitType") as DropDownList);
                //    TextBox txtUnitType = (e.Row.FindControl("txtUnitType") as TextBox);

                //    if (txtUnitType != null)
                //    {
                //        BindLookUP(ddlUnitType, 166);

                //        PopulateDropDown(ddlUnitType, txtUnitType.Text.ToLower());
                //    }
                //}
            }
        }

        protected void btnAddUnitRent_Click(object sender, EventArgs e)
        {
            if (ddlUnitType.SelectedIndex == 0)
            {
                LogMessage("Select Unit Type");
                ddlUnitType.Focus();
                return;
            }
           
            if (txtLowRent.Text.Trim() == "")
            {
                LogMessage("Enter Low Rent");
                txtLowRent.Focus();
                return;
            }

            if (txtHighRent.Text.Trim() == "")
            {
                LogMessage("Enter High Rent");
                txtHighRent.Focus();
                return;
            }

            FederalRentalAffordabilityData.AddCountyUnitRent(DataUtils.GetInt(hfCountyRentId.Value), DataUtils.GetInt(ddlUnitType.SelectedValue.ToString()),
                DataUtils.GetDecimal(txtHighRent.Text), DataUtils.GetDecimal(txtLowRent.Text));
            ClearCountyUnitRentForm();
            BindCountyUnitRentGrid();
            LogMessage("County Unit Rent Added Successfully");
        }

        private void ClearCountyUnitRentForm()
        {
            ddlUnitType.SelectedIndex = -1;
            txtLowRent.Text = "";
            txtHighRent.Text = "";
            cbAddCountyUnitRent.Checked = false;
        }
    }
}