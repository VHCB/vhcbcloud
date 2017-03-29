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
    public partial class LookupMaintenance : System.Web.UI.Page
    {
        private int _recordId = 0;
        
        public int recordId { get { return _recordId; } set { _recordId = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLookupMaintenance();
                BindViewName();
            }
        }

        protected void BindLookupMaintenance()
        {
            try
            {
                DataTable dt = new DataTable();
                recordId = Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString() == "" || ddlLkLookupViewname.SelectedValue.ToString() == "NA" ? "0" : ddlLkLookupViewname.SelectedValue.ToString());
                if (ddlLkLookupViewname.SelectedIndex == 0 || recordId == 0)
                {
                    dt = LookupMaintenanceData.GetLkLookupDetails(0, cbActiveOnly.Checked);
                }
                else
                {
                    dt = LookupMaintenanceData.GetLkLookupDetails(recordId, cbActiveOnly.Checked);
                }
                gvLookup.DataSource = dt;
                gvLookup.DataBind();
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["tiered"].ToString().ToLower() == "false")
                    {
                        gvLookup.Columns[0].Visible = false;
                    }
                    else
                    {
                        gvLookup.Columns[0].Visible = true;
                    }
                    //write code to show the visibility fo the ordering column
                    if (IsOrdered.Value == "true")
                    {
                        gvLookup.Columns[4].Visible = true;
                    }
                    else
                    {
                        gvLookup.Columns[4].Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindLKDescription()
        {
            try
            {
                DataTable dt = new DataTable();

                recordId = Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString() == "" || ddlLkLookupViewname.SelectedValue.ToString() == "NA" ? "0" : ddlLkLookupViewname.SelectedValue.ToString());
                if (recordId == 0)

                    dt = null;
                else
                    dt = LookupMaintenanceData.GetLookupsById(recordId);

                gvLkDescription.DataSource = dt;
                gvLkDescription.DataBind();

                if (dt.Rows[0]["ordered"].ToString().ToLower() == "true")
                {
                    IsOrdered.Value = "true";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvLookup_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLookup.EditIndex = -1;
            BindLookupMaintenance();
        }

        protected void gvLookup_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLookup.EditIndex = e.NewEditIndex;
            BindLookupMaintenance();
        }

        protected void gvLookup_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string strOrder = ((TextBox)gvLookup.Rows[rowIndex].FindControl("txtOrdering")).Text;
                int n;
                bool isInt = int.TryParse(strOrder.Trim(), out n);

                if (!isInt || Convert.ToInt32(strOrder) <= 0)
                {
                    lblErrorMsg.Text = "Please enter numerical values only for ordering";
                }

                  
                int typeId = Convert.ToInt32(((Label)gvLookup.Rows[rowIndex].FindControl("lbltypeid")).Text);
                string lkDescription = ((TextBox)gvLookup.Rows[rowIndex].FindControl("txtDesc")).Text;
                int recordId = Convert.ToInt32(((Label)gvLookup.Rows[rowIndex].FindControl("lblrecordId")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvLookup.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);
                int Ordering = Convert.ToInt32(strOrder);

                LookupMaintenanceData.UpdateLookups(typeId, lkDescription, recordId, isActive, Ordering);
                gvLookup.EditIndex = -1;
                //BindLookupMaintenance();
                BindGrids();
                lblErrorMsg.Text = "Lookup details updated successfully";
                txtDescription.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindViewName()
        {
            try
            {
                ddlLkLookupViewname.DataSource = LookupMaintenanceData.GetLookupsViewName(cbActiveOnly.Checked);
                ddlLkLookupViewname.DataValueField = "RecordId";
                ddlLkLookupViewname.DataTextField = "Viewname";
                ddlLkLookupViewname.DataBind();
                ddlLkLookupViewname.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        public string SortDireaction
        {
            get
            {
                if (ViewState["SortDireaction"] == null)
                    return string.Empty;
                else
                    return ViewState["SortDireaction"].ToString();
            }
            set
            {
                ViewState["SortDireaction"] = value;
            }
        }

        public string SortExpression
        {
            get
            {
                if (ViewState["SortExpression"] == null)
                    return string.Empty;
                else
                    return ViewState["SortExpression"].ToString();
            }
            set
            {
                ViewState["SortExpression"] = value;
            }
        }

        protected void BindGridWithSort()
        {
            recordId = Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString() == "" || ddlLkLookupViewname.SelectedValue.ToString() == "NA" ? "0" : ddlLkLookupViewname.SelectedValue.ToString());

            DataTable dt = new DataTable();
            if (ddlLkLookupViewname.SelectedIndex == 0)
                dt = LookupMaintenanceData.GetLkLookupDetails(0, cbActiveOnly.Checked);
            else
                dt = LookupMaintenanceData.GetLkLookupDetails(recordId, cbActiveOnly.Checked);

            SortDireaction = CommonHelper.GridSorting(gvLookup, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);
        }

        protected void gvLookup_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            BindGridWithSort();
        }

        protected void gvLookup_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvLookup.EditIndex != -1)
            {
                // Use the Cancel property to cancel the paging operation.
                e.Cancel = true;

                // Display an error message.
                int newPageNumber = e.NewPageIndex + 1;
                lblErrorMsg.Text = "Please update the record before moving to page " +
                  newPageNumber.ToString() + ".";
            }
            else
            {
                // Clear the error message.
                lblErrorMsg.Text = "";
                gvLookup.PageIndex = e.NewPageIndex;
                BindGridWithSort();
            }
        }

        protected void gvLookup_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        protected void gvLkDescription_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLkDescription.EditIndex = -1;
            BindLKDescription();

        }

        protected void gvLkDescription_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLkDescription.EditIndex = e.NewEditIndex;
            BindLKDescription();
        }

        protected void gvLkDescription_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string lkDescription = ((TextBox)gvLkDescription.Rows[rowIndex].FindControl("txtlkDesc")).Text;
                int recordId = Convert.ToInt32(((Label)gvLkDescription.Rows[rowIndex].FindControl("lblRecordId")).Text);
                bool isActive = Convert.ToBoolean(((CheckBox)gvLkDescription.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);
                bool isTiered = Convert.ToBoolean(((CheckBox)gvLkDescription.Rows[rowIndex].FindControl("chkStandardEdit")).Checked);
                bool isOrdered = Convert.ToBoolean(((CheckBox)gvLkDescription.Rows[rowIndex].FindControl("chkOrderedEdit")).Checked);

                LookupMaintenanceData.UpdateLkDescription(recordId, lkDescription, isActive, isTiered, isOrdered);
                gvLkDescription.EditIndex = -1;

                //BindViewName(); 
                BindLKDescription();
                BindLookupMaintenance();
                lblErrorMsg.Text = "Lookup description updated successfully";
                txtDescription.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error while updating Lookup data: " + ex.Message;
            }
        }

        protected void ddlLkLookupViewname_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            BindLKDescription();
            BindLookupMaintenance();
            
            pnlAddSubTier.Visible = false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtDescription.Text != "")
                {
                    LookupMaintenanceData.AddLookups(Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString()), txtDescription.Text);
                    lblErrorMsg.Text = "View name details saved successfully";
                }
                else
                {
                    lblErrorMsg.Text = "Please enter description";
                    return;
                }
                gvLookup.PageIndex = 0;
                BindLookupMaintenance();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }
        private void BindGrids()
        {
            //BindViewName();
            BindLKDescription();
            BindLookupMaintenance();
            //BindLookupSubValues();
        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            GetSelectedTransId(gvLookup);
            pnlAddSubTier.Visible = true;
            BindLookupSubValues();
            txtTier1Desc.Text = hfTier1Desc.Value.ToString();
        }

        private void GetSelectedTransId(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rbGInfo = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelect");
                if (rbGInfo != null)
                {
                    if (rbGInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                        HiddenField hfT1Desc = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("hfTier1Desc");
                        if (hf != null)
                        {
                            ViewState["SelectedTransId"] = hf.Value;
                            hfLkpId.Value = hf.Value;
                            hfTier1Desc.Value = hfT1Desc.Value;
                        }
                        break;
                    }
                }
            }
        }

        protected void btnAddSubTier_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtTier2Desc.Text != "")
                {
                    LookupMaintenanceData.AddLookupSubValue(Convert.ToInt32(hfLkpId.Value), txtTier2Desc.Text);
                    lblErrorMsg.Text = "Tier2 desription saved successfully";
                }
                else
                {
                    lblErrorMsg.Text = "Please enter tier 2 description";
                    return;
                }

                BindLookupSubValues();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
        private void BindLookupSubValues()
        {
            try
            {
                DataTable dt = new DataTable();
                int typeid = Convert.ToInt32(hfLkpId.Value);
                if (hfLkpId.Value != null)
                {
                    dt = LookupMaintenanceData.GetLkLookupSubValues(typeid, cbActiveOnly.Checked);
                }
                gvTier.DataSource = dt;
                gvTier.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvTier_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;                
                int subtypeid = Convert.ToInt32(((Label)gvTier.Rows[rowIndex].FindControl("lblsubtypeid")).Text);
                LookupMaintenanceData.DeleteLkSubValues(subtypeid);
                BindLookupSubValues();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}