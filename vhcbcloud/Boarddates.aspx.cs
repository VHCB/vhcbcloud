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
    public partial class Boarddates : System.Web.UI.Page
    {
        /// <summary>
        /// Page loading with Board Dates
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBoardDates();
            }
        }

        /// <summary>
        /// Loading Board Dates
        /// </summary>
        protected void BindBoardDates()
        {
            try
            {
                gvBoardDates.DataSource = BoarddatesData.GetBoardDates();
                gvBoardDates.DataBind();
                txtBDate.Text = "";
                txtMType.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }

        /// <summary>
        /// Board Date Grid Cancel event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBoardDates_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBoardDates.EditIndex = -1;
            BindBoardDates();
        }

        /// <summary>
        /// Board Date Grid row editing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBoardDates_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBoardDates.EditIndex = e.NewEditIndex;
            BindBoardDates();
        }

        /// <summary>
        /// Board Date Grid Row Updating
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBoardDates_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int typeId = Convert.ToInt32(((Label)gvBoardDates.Rows[rowIndex].FindControl("lblTypeId")).Text);
                string mType = ((TextBox)gvBoardDates.Rows[rowIndex].FindControl("txtMeetType")).Text;
                DateTime bDate = Convert.ToDateTime(((TextBox)gvBoardDates.Rows[rowIndex].FindControl("txtBoardDate")).Text);

                BoarddatesData.UpdateBoardDates(mType, bDate, typeId);
                gvBoardDates.EditIndex = -1;
                BindBoardDates();
                lblErrorMsg.Text = "Board details updated successfully";

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error updating the Board deatils: " + ex.Message;
                lblErrorMsg.Visible = true;
            }
        }

        /// <summary>
        /// Board Date Grid Sorting 
        /// </summary>
        protected void BindSortedGrid()
        {
            DataTable dt = BoarddatesData.GetBoardDates();
            SortDireaction = CommonHelper.GridSorting(gvBoardDates, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);
        }

        /// <summary>
        /// Board Date Grid Sorting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBoardDates_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortExpression = e.SortExpression;
            DataTable dt = BoarddatesData.GetBoardDates();
            SortDireaction = CommonHelper.GridSorting(gvBoardDates, dt, SortExpression, SortDireaction);
        }

        /// <summary>
        /// Board Date Grid Row Databound
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBoardDates_RowDataBound(object sender, GridViewRowEventArgs e)
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

        /// <summary>
        /// Board Date Grid Page Index changing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBoardDates_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvBoardDates.EditIndex != -1)
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
                gvBoardDates.PageIndex = e.NewPageIndex;
                BindBoardDates();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime dt = Convert.ToDateTime(txtBDate.Text);
                BoarddatesData.AddBoardDate(txtMType.Text, dt);
                
                txtBDate.Text = "";
                txtMType.Text = "";
                gvBoardDates.PageIndex = 0;
                BindBoardDates();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }
    }
}