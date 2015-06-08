using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class Boarddates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBoardDates();
            }
        }

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


        protected void btnSubmit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                DateTime dt = Convert.ToDateTime(txtBDate.Text);
                BoarddatesData.AddBoardDate(txtMType.Text, dt);
                BindBoardDates();
                txtBDate.Text = "";
                txtMType.Text = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvBoardDates_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBoardDates.EditIndex = -1;
            BindBoardDates();
        }

        protected void gvBoardDates_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBoardDates.EditIndex = e.NewEditIndex;
            BindBoardDates();
        }

        protected void gvBoardDates_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int typeId = Convert.ToInt32(((Label)gvBoardDates.Rows[rowIndex].FindControl("lblcontId")).Text);
                string mType = ((TextBox)gvBoardDates.Rows[rowIndex].FindControl("txtMeetType")).Text;
                DateTime bDate = Convert.ToDateTime(((TextBox)gvBoardDates.Rows[rowIndex].FindControl("txtMeetType")).Text);

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
    }
}