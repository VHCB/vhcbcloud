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
    public partial class Fundingsource : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFundingSource();
            }
        }

        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                FundingSourceData.AddFSName(txtFName.Text);
                BindFundingSource();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindFundingSource()
        {
            try
            {
                gvFSource.DataSource = FundingSourceData.GetFundingSource();
                gvFSource.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFSource_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFSource.PageIndex = e.NewPageIndex;
        }

        protected void gvFSource_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFSource.EditIndex = -1;
            BindFundingSource();
        }

        protected void gvFSource_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFSource.EditIndex = e.NewEditIndex;
            BindFundingSource();
        }

        protected void gvFSource_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int nameId = Convert.ToInt32(((Label)gvFSource.Rows[rowIndex].FindControl("lblFundId")).Text);
                string fSourceName = ((TextBox)gvFSource.Rows[rowIndex].FindControl("txtName")).Text;
                FundingSourceData.UpdateFSource(fSourceName, nameId);
                gvFSource.EditIndex = -1;
               
                lblErrorMsg.Text = "Name updated successfully";
                txtFName.Text = "";
                gvFSource.PageIndex = 0;
                BindFundingSource(); ;
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvFSource_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = FundingSourceData.GetFundingSource();
            SortDireaction = CommonHelper.GridSorting(gvFSource, dt, SortExpression, SortDireaction);
        }

        protected void gvFSource_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
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
    }
}