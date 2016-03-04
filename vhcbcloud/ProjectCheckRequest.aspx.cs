using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vhcbcloud
{
    public partial class ProjectCheckRequest : System.Web.UI.Page
    {
        DataTable dtProjects;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
                BindDate();
                BindApplicantName();
                BindPayee();
                BindProgram();
                BindMatchingGrant();
            }
        }

        protected void BindProjects()
        {
            try
            {
                dtProjects = new DataTable();
                dtProjects = ProjectCheckRequestData.GetData("PCR_Projects");
                ddlProjFilter.DataSource = dtProjects;
                ddlProjFilter.DataValueField = "project_id_name";
                ddlProjFilter.DataTextField = "Proj_num";
                ddlProjFilter.DataBind();
                ddlProjFilter.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindDate()
        {
            try
            {
                DataTable dtdate;
                dtdate = new DataTable();
                dtdate = ProjectCheckRequestData.GetData("PCR_Dates");

                ddlDate.DataSource = dtdate;
                ddlDate.DataValueField = "Date";
                ddlDate.DataTextField = "Date";
                ddlDate.DataBind();
                ddlDate.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }
        
        protected void BindApplicantName()
        {
            try
            {
                DataTable dtApplicantname;
                dtApplicantname = new DataTable();
                dtApplicantname = ProjectCheckRequestData.GetData("PCR_ApplicantName");

                ddlApplicantName.DataSource = dtApplicantname;
                ddlApplicantName.DataValueField = "Applicantname";
                ddlApplicantName.DataTextField = "Applicantname";
                ddlApplicantName.DataBind();
                ddlApplicantName.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void BindPayee()
        {
            try
            {
                DataTable dtPayee;
                dtPayee = new DataTable();
                dtPayee = ProjectCheckRequestData.GetData("PCR_Payee");

                ddlPayee.DataSource = dtPayee;
                ddlPayee.DataValueField = "Applicantname";
                ddlPayee.DataTextField = "Applicantname";
                ddlPayee.DataBind();
                ddlPayee.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void BindProgram()
        {
            try
            {
                DataTable dtProgram;
                dtProgram = new DataTable();
                dtProgram = ProjectCheckRequestData.GetData("PCR_Program");

                ddlProgram.DataSource = dtProgram;
                ddlProgram.DataValueField = "typeid";
                ddlProgram.DataTextField = "Description";
                ddlProgram.DataBind();
                ddlProgram.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

         protected void BindMatchingGrant()
        {
            try
            {
                DataTable dtMatchingGrant;
                dtMatchingGrant = new DataTable();
                dtMatchingGrant = ProjectCheckRequestData.GetData("PCR_MatchingGrant");

                ddlMatchingGrant.DataSource = dtMatchingGrant;
                ddlMatchingGrant.DataValueField = "typeid";
                ddlMatchingGrant.DataTextField = "Description";
                ddlMatchingGrant.DataBind();
                ddlMatchingGrant.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void ddlProjFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProjFilter.SelectedIndex != 0)
            {
                string[] tokens = ddlProjFilter.SelectedValue.ToString().Split('|');
                lblProjName.Text = tokens[1];
            }
            else
            {
                lblProjName.Text = "--";
            }
        }
    }
}