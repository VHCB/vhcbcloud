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
    public partial class SetTemporaryProjectToActive : System.Web.UI.Page
    {
        string Pagename = "SetTemporaryProjectToActive";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindControls();
            }
        }

        private void BindControls()
        {
           
            BindPrograms();
            
        }

        protected void BindPrograms()
        {
            try
            {
                ddlProgram.Items.Clear();
                ddlProgram.DataSource = InactiveProjectData.BindPrograms();
                ddlProgram.DataValueField = "ProgramType";
                ddlProgram.DataTextField = "Description";
                ddlProgram.DataBind();
                ddlProgram.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindManagers", "", ex.Message);
            }
        }

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
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

        protected void ddlProgram_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bindprojects();
        }

        protected void Bindprojects()
        {
            DataTable dt = InactiveProjectData.GetInActivetempProjects(ddlProgram.SelectedValue);

            if (dt.Rows.Count > 0)
            {
                gvProjects.DataSource = dt;
                gvProjects.DataBind();
                dvMessage.Visible = false;
                btnTranSubmit.Visible = true;
            }
            else
            {
                gvProjects.DataSource = null;
                gvProjects.DataBind();
                LogMessage("No Data Found!");
                btnTranSubmit.Visible = false;
            }
        }

        protected void gvProjects_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btnTranSubmit_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvProjects.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkTrans") as CheckBox);
                    if (chkRow.Checked)
                    {
                        int TempUserID = Convert.ToInt32(gvProjects.DataKeys[row.RowIndex].Value.ToString());

                        InactiveProjectData.ActivateTempProject(TempUserID);
                    }
                }
            }
            Bindprojects();
        }
    }
}