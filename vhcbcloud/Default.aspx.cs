using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                GetAllProjects();
                BindSelectedProjects(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
            }
        }

        private void GetAllProjects()
        {
            try
            {
                ddlProjFilter.DataSource = Project.GetProjects("GetGroupProjects");
                ddlProjFilter.DataValueField= "ProjectId";
                ddlProjFilter.DataTextField = "proj_num";
                ddlProjFilter.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindSelectedProjects( int projId)
        {
            try 
	        {
                gvProject.DataSource = Project.GetProjects("GetAllProjects");
                gvProject.DataBind();

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSelectedProjects(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
        }

        protected void gvProject_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProject.EditIndex = -1;
            BindSelectedProjects(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));
        }

        protected void gvProject_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvProject_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProject.EditIndex = e.NewEditIndex;
            BindSelectedProjects(Convert.ToInt32(ddlProjFilter.SelectedValue.ToString()));


        }
    }
}