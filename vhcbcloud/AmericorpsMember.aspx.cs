using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class AmericorpsMember : System.Web.UI.Page
    {
        string Pagename = "AmericorpsMember";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateMemberData();
                PopulateMemberAddress();
                //BindControls();
                //BindGrids();
            }
        }

        private void GenerateTabs()
        {
            string ProgramId = null;

            if (Request.QueryString["ProgramId"] != null)
                ProgramId = Request.QueryString["ProgramId"];

            //Active Tab
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "RoundedCornerTop");
            Tabs.Controls.Add(li);

            HtmlGenericControl anchor = new HtmlGenericControl("a");
            anchor.Attributes.Add("href", "../ProjectMaintenance.aspx?ProjectId=" + hfProjectId.Value);
            anchor.InnerText = "Project Maintenance";
            anchor.Attributes.Add("class", "RoundedCornerTop");

            li.Controls.Add(anchor);

            DataTable dtTabs = TabsData.GetProgramTabs(DataUtils.GetInt(ProgramId));

            foreach (DataRow dr in dtTabs.Rows)
            {
                HtmlGenericControl li1 = new HtmlGenericControl("li");
                if (dr["URL"].ToString().Contains("AmericorpsMember.aspx"))
                    li1.Attributes.Add("class", "RoundedCornerTop selected");
                else
                    li1.Attributes.Add("class", "RoundedCornerTop");

                Tabs.Controls.Add(li1);
                HtmlGenericControl anchor1 = new HtmlGenericControl("a");
                anchor1.Attributes.Add("href", "../" + dr["URL"].ToString() + "?ProjectId=" + hfProjectId.Value + "&ProgramId=" + ProgramId);
                anchor1.InnerText = dr["TabName"].ToString();
                anchor1.Attributes.Add("class", "RoundedCornerTop");
                li1.Controls.Add(anchor1);
            }
        }

        private void ProjectNotesSetUp()
        {
            int PageId = ProjectNotesData.GetPageId(Path.GetFileName(Request.PhysicalPath));

            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"] +
                    "&PageId=" + PageId;
                if (ProjectNotesData.IsNotesExist(PageId, DataUtils.GetInt(hfProjectId.Value)))
                    btnProjectNotes.ImageUrl = "~/Images/currentpagenotes.png";
            }
        }

        private void PopulateMemberData()
        {
            DataRow dr = AmericorpsMemberData.GetAmericopMemberInfo(DataUtils.GetInt(hfProjectId.Value));
            lblEmail.Text = dr["email"].ToString();
            lblMemberName.Text = dr["name"].ToString();
            lblCellPhone.Text = dr["cellphone"].ToString();
            txtDOB.Text = dr["DOB"].ToString();
            hfApplicantId.Value = dr["Applicantid"].ToString();  
        }

        private void PopulateMemberAddress()
        {
            DataRow dr = AmericorpsMemberData.GetApplicantAddress(DataUtils.GetInt(hfApplicantId.Value));
            lblAddressType.Text = dr["AddressType"].ToString();
            lblStreetNo.Text = dr["Street#"].ToString();
            lblAddress1.Text = dr["Address1"].ToString();
            lblAddress2.Text = dr["Address2"].ToString();
            lblCity.Text = dr["Town"].ToString();
            lblState.Text = dr["State"].ToString();
            lblZip.Text = dr["Zip"].ToString();
            lblCountry.Text = dr["Country"].ToString();
            
        }
        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnUpdatememberDOB_Click(object sender, EventArgs e)
        {

        }
    }
}