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
    public partial class HUC12 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindHUC12Grid();
            }
        }

        protected void btnAddHUC12_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtHUC12.Text.ToString()) == true)
            {
                LogMessage("Enter HUC12");
                txtHUC12.Focus();
                return;
            }
            else if (string.IsNullOrWhiteSpace(txtName.Text.ToString()) == true)
            {
                LogMessage("Enter Name");
                txtName.Focus();
                return;
            }

            bool isDuplicate = HUC12Data.AddHUC12(txtHUC12.Text, txtName.Text);

            if (isDuplicate)
            {
                LogMessage("HUC12 already exist");
            }
            else
            {
                txtHUC12.Text = "";
                txtName.Text = "";
                cbAddHUC12.Checked = false;
                BindHUC12Grid();
                LogMessage("New HUC12 added successfully");
            } 
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        private void BindHUC12Grid()
        {
            try
            {
                DataTable dtHUC12 = HUC12Data.GetHUC12List();

                if (dtHUC12.Rows.Count > 0)
                {
                    dvHUC12Grid.Visible = true;
                    gvHUC12.DataSource = dtHUC12;
                    gvHUC12.DataBind();
                }
                else
                {
                    dvHUC12Grid.Visible = false;
                    gvHUC12.DataSource = null;
                    gvHUC12.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogMessage(ex.Message);
            }
        }
        protected void gvHUC12_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHUC12.EditIndex = e.NewEditIndex;
            BindHUC12Grid();
        }

        protected void gvHUC12_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int HUCID = DataUtils.GetInt(((Label)gvHUC12.Rows[rowIndex].FindControl("lblHUCID")).Text);
            string HUC12 = ((TextBox)gvHUC12.Rows[rowIndex].FindControl("txtHUC12")).Text.Trim();
            string Name = ((TextBox)gvHUC12.Rows[rowIndex].FindControl("txtName")).Text.Trim();

            bool isDuplicate = HUC12Data.UpdateHUC12(HUCID, HUC12, Name);
            
            if (isDuplicate)
            {
                LogMessage("HUC12 already exist");
            }
            else
            {
                LogMessage("HUC12 updated successfully");
                gvHUC12.EditIndex = -1;
                BindHUC12Grid();
            }
        }

        protected void gvHUC12_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHUC12.EditIndex = -1;
            BindHUC12Grid();
        }
    }
}