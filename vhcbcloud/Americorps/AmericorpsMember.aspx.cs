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

namespace vhcbcloud.Americorps
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
                BindControls();
                //BindGrids();
            }
        }

        private void BindControls()
        {
            BindLookUP(ddlSlotFullFilled, 241);
            BindLookUP(ddlServiceType, 122);
            BindLookUP(ddlDietryPref, 240);
            BindLookUP(ddlTShirtSize, 239);
            BindLookUP(ddlSwatShirtSize, 239); 
                BindLookUP(ddlFormGroup, 238);
        }

        private void BindLookUP(DropDownList ddList, int LookupType)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = LookupValuesData.Getlookupvalues(LookupType);
                ddList.DataValueField = "typeid";
                ddList.DataTextField = "description";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindLookUP", "Control ID:" + ddList.ID, ex.Message);
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

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void btnAddmemberData_Click(object sender, EventArgs e)
        {

        }

        protected void ddlFormGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindACMemberFormDataGrid();
        }

        private void BindACMemberFormDataGrid()
        {
            try
            {
                DataTable dtACMemberFormData = AmericorpsMemberData.GetACMemberFormData(DataUtils.GetInt(hfApplicantId.Value), 
                    DataUtils.GetInt(ddlFormGroup.SelectedValue.ToString()), true);

                if (dtACMemberFormData.Rows.Count > 0)
                {
                    gvACMemberForm.DataSource = dtACMemberFormData;
                    gvACMemberForm.DataBind();
                }
                else
                {
                    gvACMemberForm.DataSource = null;
                    gvACMemberForm.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindACMemberFormDataGrid", "", ex.Message);
            }
        }

        protected void gvACMemberForm_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvACMemberForm.EditIndex = e.NewEditIndex;
            BindACMemberFormDataGrid();
        }

        protected void gvACMemberForm_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvACMemberForm_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void gvACMemberForm_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvACMemberForm.EditIndex = -1;
            BindACMemberFormDataGrid();
        }
    }
}