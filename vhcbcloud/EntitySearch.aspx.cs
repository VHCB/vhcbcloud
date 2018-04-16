using DataAccessLayer;
using Microsoft.AspNet.Identity;
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
    public partial class EntitySearch : System.Web.UI.Page
    {
        string Pagename = "EntitySearch";

        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            if (!IsPostBack)
            {
                BindControls();
                dvIndiSearchResultsGrid.Visible = false;
                dvOrgSearchResultsGrid.Visible = false;
            }
            CheckNewEntityAccess();
        }

        private void BindControls()
        {
            BindLookUP(ddlEntityRole, 170);
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
        protected void btnEntitySearch_Click(object sender, EventArgs e)
        {
            dvOrgSearchResultsGrid.Visible = false;
            dvIndiSearchResultsGrid.Visible = false;

            DataTable dtTable = EntityMaintenanceData.EntitySearchByRole(DataUtils.GetInt(ddlEntityRole.SelectedValue), txtEntityName.Text);

            if (ddlEntityRole.SelectedValue == "26242") //Organization
            {
                dvOrgSearchResultsGrid.Visible = true;
                gvOrgSearchresults.DataSource = dtTable;
                gvOrgSearchresults.DataBind();
            }
            if (ddlEntityRole.SelectedValue == "26243") //Individual
            {
                dvIndiSearchResultsGrid.Visible = true;
                gvIndSearchresults.DataSource = dtTable;
                gvIndSearchresults.DataBind();
            }
            
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlEntityRole.SelectedIndex = -1;
            txtEntityName.Text = "";
            dvIndiSearchResultsGrid.Visible = false;
            dvOrgSearchResultsGrid.Visible = false;
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

        protected void gvOrgSearchresults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectProject")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                string ApplicantId = ((Label)gvOrgSearchresults.Rows[index].FindControl("lblApplicantId")).Text;
                string EntityRole = ((Label)gvOrgSearchresults.Rows[index].FindControl("lblEntityRole")).Text;

                Response.Redirect("EntityMaintenance.aspx?IsSearch=true&ApplicantId=" + ApplicantId + "&Role=" + EntityRole);
            }
        }

        protected void gvIndSearchresults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectProject")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                string ApplicantId = ((Label)gvIndSearchresults.Rows[index].FindControl("lblApplicantId")).Text;
                string EntityRole = ((Label)gvIndSearchresults.Rows[index].FindControl("lblEntityRole")).Text;

                Response.Redirect("EntityMaintenance.aspx?IsSearch=true&ApplicantId=" + ApplicantId + "&Role=" + EntityRole);
            }
        }


        protected void rdBtnAction1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdBtnAction1.SelectedValue.ToLower() == "existing")
            {

            }
            else
            {
                Response.Redirect("EntityMaintenance.aspx", true);
            }
        }

        private void CheckNewEntityAccess()
        {
            DataTable dt = new DataTable();
            dt = UserSecurityData.GetUserFxnSecurity(GetUserId());

            foreach (DataRow row in dt.Rows)
            {
                if (row["FxnID"].ToString() == "27453")
                    rdBtnAction1.Items[0].Enabled = true;
            }
        }

        protected int GetUserId()
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetUserByUserName(Context.User.Identity.GetUserName());
                return dtUser != null ? Convert.ToInt32(dtUser.Rows[0][0].ToString()) : 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}