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
    public partial class LoanSummaryTemp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string projId = Request.QueryString["projectid"].ToString();
                DataTable dt = LoanMaintenanceData.GetLoanDetailsIdList(DataUtils.GetInt(projId));

                if(dt.Rows.Count == 1)
                    Response.Redirect("loansummary.aspx?projectid=" + Request.QueryString["projectid"].ToString() + "&loanid=" + dt.Rows[0][0].ToString());

                BindLoanDetails(dt);
            }
        }

        private void BindLoanDetails(DataTable dt)
        {
            try
            {
                ddlLoanDetails.Items.Clear();
                ddlLoanDetails.DataSource = dt;
                ddlLoanDetails.DataValueField = "LoanId";
                ddlLoanDetails.DataTextField = "LoanIdNoteAmount";
                ddlLoanDetails.DataBind();
                //ddlLoanDetails.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                //LogError(Pagename, "BindTown", "Control ID:" + ddlTown.ID, ex.Message);
            }
        }
        protected void ddlLoanDetails_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void LoanSummaryReport_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("loansummary.aspx?projectid=" + Request.QueryString["projectid"].ToString() +"&loanid=" + ddlLoanDetails.SelectedValue.ToString());
        }
    }
}