using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vhcbcloud
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                txtAwardAmt.Text = "12343345.67";
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string str = txtAwardAmt.Text;
            string tmp = Regex.Replace(str, "[^0-9a-zA-Z.]+", "");
            Response.Write("Value store in database is: " + tmp);
        }
    }
}