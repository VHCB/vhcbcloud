using System;
using System.Collections.Generic;
using System.Data;
using System.Security.Claims;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected override void OnPreRender(EventArgs e)
        {
           
            //foreach (var link in this.Master.FindDescendants<LinkButton>())
            //{
            //    string linkId = link.ID;
            //    foreach (DataRow dRow in dt.Rows)
            //    {
            //        if(dRow["PageDescription"].ToString().ToLower() == linkId.ToLower())
            //        {
            //            ((LinkButton)Master.FindControl(linkId)).Visible = false;
            //        }
            //    }
            //}            
            //base.OnPreRender(e);
        }

        protected void Page_PreInit(Object sender, EventArgs e)
        {
            int userid = GetUserId();
            DataTable dt = UserSecurityData.GetMasterPageSecurity(userid);
            if (dt.Rows.Count > 0)
            {
                this.MasterPageFile = "SiteNonAdmin.Master";
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
        public String strMenuText = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dtable = default(DataTable);
            var sb = new StringBuilder();
            
            DataRow dr = UserSecurityData.GetUserSecurity(Context.User.Identity.Name);
            if (dr != null && dr["usergroupid"].ToString() == "7")
            {
                Session["UserMenuDetails"] = null;
                logoURL.HRef = "";
            }
            else
            {
                if (Session["UserMenuDetails"] == null)
                {
                    dtable = UserSecurityData.GetMenuDetailsByUser(GetUserId());
                    //dtable = UserSecurityData.GetMenuDetailsByUser(7);
                    Session["UserMenuDetails"] = dtable;
                }
                else
                    dtable = (DataTable)Session["UserMenuDetails"];
                DataRow[] parentMenus = dtable.Select("ParentID = 0");
                strMenuText = GenerateUL(parentMenus, dtable, sb, false);
            }
        }
        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Session.Remove("UserMenuDetails");
            Session.Remove("FirstName");
            Context.GetOwinContext().Authentication.SignOut();
        }

        private string GenerateUL(DataRow[] menu, DataTable table, StringBuilder sb,bool isSubmenu)
        {
            if (!isSubmenu)
                sb.AppendLine(@"<ul class=""nav navbar-nav"">");
            else
                sb.AppendLine(@"<ul class=""dropdown-menu"">");
            if (menu.Length > 0)
            {
                foreach (DataRow dr in menu)
                {
                    string handler = dr["Handler"].ToString();
                    string menuText = dr["MenuText"].ToString();
                    string pid = dr["MenuID"].ToString();
                    string parentId = dr["ParentID"].ToString();
                    string line;
                    DataRow[] subMenu = table.Select(String.Format("ParentID = {0}", pid));
                        if (!isSubmenu)
                        {
                            if (DataUtils.GetBool(dr["IsDropDownToggle"].ToString()))
                                line = String.Format(@"<li class=""menu-item dropdown""><a href=""{0}"" class=""dropdown-toggle"" data-toggle=""dropdown"">{1}<b class=""caret""></b></a>", ResolveUrl(@"~/" + handler), menuText);
                            else
                                line = String.Format(@"<li><a href=""{0}"" >{1}</a>", ResolveUrl(@"~/" + handler), menuText);
                        }
                        else
                        {
                            if (DataUtils.GetBool(dr["IsDropDownToggle"].ToString()))
                                line = String.Format(@"<li class=""menu-item dropdown dropdown-submenu""><a href=""{0}"" class=""dropdown-toggle"" data-toggle=""dropdown"">{1}</a>", ResolveUrl(@"~/" + handler), menuText);
                            else
                                line = String.Format(@"<li><a href=""{0}"" >{1}</a>", ResolveUrl(@"~/" + handler), menuText);
                        }
                        sb.Append(line);
                        if (subMenu.Length > 0 && !pid.Equals(parentId))
                        {
                            var subMenuBuilder = new StringBuilder();
                            sb.Append(GenerateUL(subMenu, table, subMenuBuilder, true));
                        }
                        sb.Append("</li>");
                    
                }
            }
            sb.Append("</ul>");
            return sb.ToString();
        }

       
    }

}