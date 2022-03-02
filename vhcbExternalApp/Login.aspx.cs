using System;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Data;
using VHCBCommon.DataAccessLayer;

namespace vhcbExternalApp
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

            IsLoginValid(ProjectNumber.Text, UserId.Text, Password.Text);

            if (IsValidUser)
            {
                Session["UserId"] = UserId.Text;
                Session["ProjectNumber"] = ProjectNumber.Text;

                FormsAuthentication.SetAuthCookie(UserId.Text, true);
                string url = "";

                url = FormsAuthentication.DefaultUrl;
                if (Request["ReturnUrl"] != null)
                    url = Request["ReturnUrl"];

              
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
            IsValidUser = AccountData.CheckExternalUserLogin(ProjectNumber, UserName, Password, 38774);

        }

       
    }
}