using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using vhcbcloud.Models;
using VHCBCommon.DataAccessLayer;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace vhcbcloud.Account
{
    public partial class Login : Page
    {
        private bool IsValidUser;
        private bool IsFirstTimeUser;
        private string adPath, domainName;
        private int LoginUserId;
        private string _UserName;
        private LdapAuthentication adAuth;

        protected void Page_Load(object sender, EventArgs e)
        {
            adPath = ConfigurationManager.AppSettings["LDAPServer"];
            domainName = ConfigurationManager.AppSettings["DomainName"];
            adAuth = new LdapAuthentication(adPath);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (ConfigurationManager.AppSettings["IsUseLDAP"] == "true")
                LDAPLogin();
            else
                GeneralLogin();
        }

        private void LDAPLogin()
        {
            if (IsADAuthenticated())
            {
                FormsAuthentication.SetAuthCookie(UserId.Text, false);

                string url = FormsAuthentication.DefaultUrl;

                if (Request["page"] != null) url = Request["page"];
                Response.Redirect(url);
            }
        }

        private bool IsADAuthenticated()
        {
            try
            {
                // LDAP Authentication
                if (true == adAuth.IsAuthenticated(domainName, UserId.Text, Password.Text))
                {
                    //Do whatever we want
                    return true;
                }
                else
                {
                    FailureText.Text = "Authentication did not succeed. Check user name and password.";
                    ErrorMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                FailureText.Text = "Error authenticating. " + ex.Message;
                ErrorMessage.Visible = true;
            }
            return false;
        }


        private void GeneralLogin()
        {
            IsLoginValid(UserId.Text, Password.Text);

            if (IsValidUser)
            {
                Session["UserId"] = UserId.Text;

                //if (IsFirstTimeUser)
                //    Response.Redirect("SetPassword.aspx");
                //else
                //{
                FormsAuthentication.SetAuthCookie(UserId.Text, RememberMe.Checked);
                string url = FormsAuthentication.DefaultUrl;
                if (Request["ReturnUrl"] != null) url = Request["ReturnUrl"];
                Response.Redirect(url);
                // }
                //Response.Redirect("../BoardFinancialTransactions.aspx");
            }
            else
            {
                Session["UserId"] = "";
                FailureText.Text = "Invalid login attempt";
                ErrorMessage.Visible = true;
            }
        }

        private void IsLoginValid(string UserName, string Password)
        {
            string[] UserAccountData = AccountData.CheckUserLogin(UserName, Password).Split('|');
            IsValidUser = Convert.ToBoolean(Convert.ToInt16(UserAccountData[0]));
            IsFirstTimeUser = Convert.ToBoolean(Convert.ToInt16(UserAccountData[1]));
            LoginUserId = Convert.ToInt32(UserAccountData[1]);

            MasterPage mPage;
            mPage = Page.Master;

            LinkButton mpMenuLinks;
            mpMenuLinks = (LinkButton)this.Master.FindControl("idAmericorps");
            if (mpMenuLinks != null)
            {
                mpMenuLinks.Visible = false;
                mpMenuLinks.Text = "";
            }
        }
    }
}