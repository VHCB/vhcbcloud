using System;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Data;
using VHCBCommon.DataAccessLayer;
using DataAccessLayer;

namespace VHCBConservationFarm
{
    public partial class Login : Page
    {
        private bool IsValidUser;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            GeneralLogin();
        }
        private void GeneralLogin()
        {

            IsLoginValid(ddlProjectNumber.SelectedValue, UserId.Text, Password.Text);

            if (IsValidUser)
            {
                Session["UserId"] = UserId.Text;
                Session["ProjectNumber"] = ddlProjectNumber.SelectedValue;
                //Session.Timeout = 30;

                FormsAuthentication.SetAuthCookie(UserId.Text, true);
                string url = "";

                url = FormsAuthentication.DefaultUrl;
                if (Request["ReturnUrl"] != null)
                    url = Request["ReturnUrl"];
                else
                    url = "FirstPage.aspx";


                string script = "window.open('" + url + "', '" + "_self" + "', '');";
                this.ClientScript.RegisterClientScriptBlock(this.GetType(), "_self", script, true);
            }
            else
            {
                Session["UserId"] = "";
                Session["ProjectNumber"] = "";
                FailureText.Text = "Invalid login attempt";
                ErrorMessage.Visible = true;
            }
        }

        private void IsLoginValid(string ProjectNumber, string UserName, string Password)
        {
            IsValidUser = AccountData.CheckExternalUserLogin(ProjectNumber, UserName, Password, 40004);

        }

        private void LoadProjects()
        { 
                DataTable dt = ProjectMaintenanceData.GetProjectNumbersByLoginName(UserId.Text, 40004);

                ddlProjectNumber.Items.Clear();
                ddlProjectNumber.DataSource = dt;
                ddlProjectNumber.DataValueField = "ProjectNumber";
                ddlProjectNumber.DataTextField = "ProjectName";
                ddlProjectNumber.DataBind();
                ddlProjectNumber.Items.Insert(0, new ListItem("Select", "NA"));

        }

        protected void UserId_TextChanged(object sender, EventArgs e)
        {
            LoadProjects();
        }
    }
}   