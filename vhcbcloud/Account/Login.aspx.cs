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
using System.Data;

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
        private string FirstName;
        private string DashboardName;
        private bool IsDashboard;

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


        protected void Page_PreInit(Object sender, EventArgs e)
        {
            int userid = GetUserId();
            DataTable dt = UserSecurityData.GetMasterPageSecurity(userid);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }


        protected int GetUserId()
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetUserByUserName(Context.User.Identity.Name);
                return dtUser != null ? Convert.ToInt32(dtUser.Rows[0][0].ToString()) : 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        private void GeneralLogin()
        {
            IsDashboard = false;
            IsLoginValid(UserId.Text, Password.Text);

            if (IsValidUser)
            {
                Session["UserId"] = UserId.Text;
                Session["FirstName"] = FirstName;
                //if (IsFirstTimeUser)
                //    Response.Redirect("SetPassword.aspx");
                //else
                //{

                FormsAuthentication.SetAuthCookie(UserId.Text, RememberMe.Checked);
                string url = "";

                DataRow dr = UserSecurityData.GetUserSecurity(UserId.Text);
                if (dr != null && dr["usergroupid"].ToString() == "7")
                    url = "../Americorps/ProgressReport.aspx";
                else
                {
                    url = FormsAuthentication.DefaultUrl;
                    if (Request["ReturnUrl"] != null)
                        url = Request["ReturnUrl"];
                }

                int i = 0;
                for (int a = 0; a < 2; a++)
                {
                    i += 1;
                    OpenTabs(this, i, url);
                }
            }
            else
            {
                Session["UserId"] = "";
                FailureText.Text = "Invalid login attempt";
                ErrorMessage.Visible = true;
            }
        }

        public void OpenTabs(System.Web.UI.Page page, int i, string URL)
        {
            if (i == 1)
            {
                string script = "window.open('" + URL + "', '" + "_self" + "', '');";
                page.ClientScript.RegisterClientScriptBlock(page.GetType(), "_self", script, true);
            }
            else
            {
                if (IsDashboard)
                {
                    if (DashboardName != null)
                    {
                        string[] tokens = DashboardName.Split('.');
                        DashboardName = tokens[0];
                    }

                    string script = "window.open('" + Helper.GetExagoURLForDashBoard(DashboardName) + "', '" + "abc" + "', '');";
                    page.ClientScript.RegisterClientScriptBlock(page.GetType(), "abc", script, true);
                }
            }
        }
        private void IsLoginValid(string UserName, string Password)
        {
            string[] UserAccountData = AccountData.CheckUserLogin(UserName, Password).Split('|');
            IsValidUser = Convert.ToBoolean(Convert.ToInt16(UserAccountData[0]));
            IsFirstTimeUser = Convert.ToBoolean(Convert.ToInt16(UserAccountData[1]));
            LoginUserId = Convert.ToInt32(UserAccountData[1]);
            FirstName = UserAccountData[3];
            IsDashboard = Convert.ToBoolean(Convert.ToInt16(UserAccountData[4]));
            DashboardName = UserAccountData[5];

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