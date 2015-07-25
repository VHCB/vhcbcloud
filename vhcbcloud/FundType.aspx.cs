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
    public partial class FundType : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFundTypeData();
                BindfundType();
            }
        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (ddlLkLookupViewname.SelectedIndex != 0 && txtDescription.Text != "")
                {
                    FundTypeData.AddFundType(txtDescription.Text, Convert.ToInt32(ddlLkLookupViewname.SelectedValue.ToString()));
                    lblErrorMsg.Text = "Fund Type saved successfully";
                    BindFundTypeData();
                    txtDescription.Text = "";
                }
                else
                    lblErrorMsg.Text = "Please select fund type source and add description";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindfundType()
        {
            try
            {
                ddlLkLookupViewname.DataSource = FundTypeData.GetFundType("GetFundType");
                ddlLkLookupViewname.DataValueField = "TypeId";
                ddlLkLookupViewname.DataTextField = "Description";
                ddlLkLookupViewname.DataBind();
                ddlLkLookupViewname.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindFundTypeData()
        {
            try
            {
                gvLkDescription.DataSource = FundTypeData.GetFundType("GetFundTypeData");
                gvLkDescription.DataBind();
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
                    return ViewState["SortDireaction"].ToString() == "ASC" ? "DESC" : "ASC";
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
            DataTable dt = new DataTable();
            dt = FundTypeData.GetFundType("GetFundTypeData");
            SortDireaction = CommonHelper.GridSorting(gvLkDescription, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);
        }

        protected void gvLookup_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = FundTypeData.GetFundType("GetFundTypeData");
            SortDireaction = CommonHelper.GridSorting(gvLkDescription, dt, SortExpression, SortDireaction);
        }


        protected void gvLkDescription_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLkDescription.EditIndex = -1;
            BindFundTypeData();

        }

        protected void gvLkDescription_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLkDescription.EditIndex = e.NewEditIndex;
            BindFundTypeData();
        }

        protected void gvLkDescription_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string lkDescription = ((TextBox)gvLkDescription.Rows[rowIndex].FindControl("txtDesc")).Text;
            int typeid = Convert.ToInt32(((Label)gvLkDescription.Rows[rowIndex].FindControl("lbltypeid")).Text);
            bool isActive = Convert.ToBoolean(((CheckBox)gvLkDescription.Rows[rowIndex].FindControl("chkActiveEdit")).Checked);

            FundTypeData.UpdateFundType(lkDescription, typeid, isActive);
            gvLkDescription.EditIndex = -1;

            BindFundTypeData();
            lblErrorMsg.Text = "FundType description updated successfully";
            txtDescription.Text = "";
        }

        protected void gvLkDescription_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = FundTypeData.GetFundType("GetFundTypeData");
            SortDireaction = CommonHelper.GridSorting(gvLkDescription, dt, SortExpression, SortDireaction);
        }

        protected void gvLkDescription_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvLkDescription.EditIndex != -1)
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
                gvLkDescription.PageIndex = e.NewPageIndex;
                BindGridWithSort();
            }
        }

    }
}