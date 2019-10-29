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
                BindControls();
                PopulateMemberData();
                PopulateMemberAddress();

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
            //BindLookUP(ddlFormGroup, 238);
            BindLookUP(ddlGroup, 238);

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
            hfACMemberId.Value = string.Empty;
            hfContactId.Value = string.Empty;

            DataRow dr = AmericorpsMemberData.GetAmericopMemberInfo(DataUtils.GetInt(hfProjectId.Value));
            lblEmail.Text = dr["email"].ToString();
            lblMemberName.Text = dr["name"].ToString();
            lblCellPhone.Text = dr["cellphone"].ToString();
            txtDOB.Text = dr["DOB"].ToString();
            hfApplicantId.Value = dr["Applicantid"].ToString();
            hfContactId.Value = dr["ContactId"].ToString();

            DataRow drow = AmericorpsMemberData.GetACMember(DataUtils.GetInt(hfApplicantId.Value));

            if (drow != null)
            {
                hfACMemberId.Value = drow["ACMemberID"].ToString();
                txtStartDate.Text = drow["StartDate"].ToString();
                txtEndDate.Text = drow["EndDate"].ToString();

                PopulateDropDown(ddlSlotFullFilled, drow["LkSlot"].ToString());
                PopulateDropDown(ddlServiceType, drow["LkServiceType"].ToString());
                PopulateDropDown(ddlDietryPref, drow["DietPref"].ToString());
                PopulateDropDown(ddlTShirtSize, drow["Tshirt"].ToString());
                PopulateDropDown(ddlSwatShirtSize, drow["SweatShirt"].ToString());
                txtMedConcern.Text = drow["MedConcerns"].ToString();
                txtNotes.Text = drow["MedConcerns"].ToString();

                btnAddmemberData.Text = "Update";
            }
            BindACMemberFormDataGrid();
        }

        private void PopulateDropDown(DropDownList ddl, string DBSelectedvalue)
        {
            foreach (ListItem item in ddl.Items)
            {
                if (DBSelectedvalue == item.Value.ToString())
                {
                    ddl.ClearSelection();
                    item.Selected = true;
                }
            }
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
            BindACMemberFormDataGrid();
        }

        protected void btnUpdatememberDOB_Click(object sender, EventArgs e)
        {
            AmericorpsMemberData.UpdateContactDOB(DataUtils.GetInt(hfApplicantId.Value), DataUtils.GetDate(txtDOB.Text));
            LogMessage("Contact DOB updated successfully");
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
            if (btnAddmemberData.Text.ToLower() == "update")
            {

                AmericorpsMemberData.UpdateACMember(DataUtils.GetInt(hfACMemberId.Value),
                    DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text), DataUtils.GetInt(ddlSlotFullFilled.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlServiceType.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlTShirtSize.SelectedValue.ToString()), DataUtils.GetInt(ddlSwatShirtSize.SelectedValue.ToString()), DataUtils.GetInt(ddlDietryPref.SelectedValue.ToString()), txtMedConcern.Text, txtNotes.Text);

                LogMessage("AC Member data updated successfully");
            }
            else //add
            {
                AmericorpMemberResult objAmericorpMemberResult = AmericorpsMemberData.AddACMember(DataUtils.GetInt(hfApplicantId.Value), DataUtils.GetInt(hfContactId.Value),
                    DataUtils.GetDate(txtStartDate.Text), DataUtils.GetDate(txtEndDate.Text), DataUtils.GetInt(ddlSlotFullFilled.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlServiceType.SelectedValue.ToString()),
                    DataUtils.GetInt(ddlTShirtSize.SelectedValue.ToString()), DataUtils.GetInt(ddlSwatShirtSize.SelectedValue.ToString()), DataUtils.GetInt(ddlDietryPref.SelectedValue.ToString()), txtMedConcern.Text, txtNotes.Text);

                btnAddmemberData.Text = "Update";

                if (objAmericorpMemberResult.IsDuplicate && !objAmericorpMemberResult.IsActive)
                    LogMessage("AC Member already exist as in-active");
                else if (objAmericorpMemberResult.IsDuplicate)
                    LogMessage("AC Member already exist");
                else
                    LogMessage("AC Member added successfully");

            }
        }

        //protected void ddlFormGroup_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    BindACMemberFormDataGrid();
        //}

        private void BindACMemberFormDataGrid()
        {
            try
            {
                DataView dtACMemberFormData = AmericorpsMemberData.GetACMemberFormData(DataUtils.GetInt(hfACMemberId.Value), DataUtils.GetInt(ddlGroup.SelectedValue.ToString()), cbActiveOnly.Checked);

                if (dtACMemberFormData.Count > 0)
                {
                    dvMemberFormGrid.Visible = true;
                    gvACMemberForm.DataSource = dtACMemberFormData;
                    gvACMemberForm.DataBind();
                }
                else
                {
                    dvMemberFormGrid.Visible = false;
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
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);

                    dvNewMemberForm.Visible = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        //e.Row.Cells[8].Controls[0].Visible = false;
                        Label lblACmemberformID = e.Row.FindControl("lblACmemberformID") as Label;
                        if (lblACmemberformID.Text != "-99")
                        {
                            btnSubmitACForm.Text = "Update";
                            DataRow dr = AmericorpsMemberData.GetACMemberFormDataById(DataUtils.GetInt(lblACmemberformID.Text));
                            hfACMemberFormId.Value = lblACmemberformID.Text;

                            lblFormName.Text = dr["FormName"].ToString();
                            txtURL.Text = dr["URL"].ToString();
                            txtACMemberFormNotes.Text = dr["Notes"].ToString();
                            txtReceivedDate.Text = dr["ReceivedDate"].ToString();
                            cbReceived.Checked = DataUtils.GetBool(dr["Received"].ToString());
                            cbACFormActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                            //cbReceived.Enabled = true;
                            //cbACFormActive.Enabled = true;
                        }
                        else
                        {
                            btnSubmitACForm.Text = "Submit";
                            Label lblACFormID = e.Row.FindControl("lblACFormID") as Label;
                            hfACFormID.Value = lblACFormID.Text;
                            Label lblFormName1 = e.Row.FindControl("lblFormName") as Label;
                            lblFormName.Text = lblFormName1.Text;

                           cbReceived.Checked = true;
                            cbACFormActive.Checked = true;
                            //cbReceived.Enabled = false;
                            //cbACFormActive.Enabled = false; 

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvACMemberForm_RowDataBound", "", ex.Message);
            }
        }

        protected void gvACMemberForm_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvACMemberForm.EditIndex = -1;
            hfACMemberFormId.Value = "";
            hfACFormID.Value = "";
            txtReceivedDate.Text = "";
            txtURL.Text = "";
            txtACMemberFormNotes.Text = "";

            BindACMemberFormDataGrid();
            dvNewMemberForm.Visible = false;
        }

        //protected void ddlFormGroup_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        ddlFormName.Items.Clear();
        //        if (ddlFormGroup.SelectedIndex != 0)
        //        {
        //            ddlFormName.DataSource = AmericorpsMemberData.GetACForms(DataUtils.GetInt(ddlFormGroup.SelectedValue.ToString()));
        //            ddlFormName.DataValueField = "ACFormID";
        //            ddlFormName.DataTextField = "Name";
        //            ddlFormName.DataBind();
        //            ddlFormName.Items.Insert(0, new ListItem("Select", "NA"));
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogError(Pagename, "BindLookUP", "Control ID:", ex.Message);
        //    }
        //}

        protected void btnSubmitACForm_Click(object sender, EventArgs e)
        {
            string URL = txtURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnSubmitACForm.Text.ToLower() == "update")
            {
                AmericorpsMemberData.UpdateACMemberForm(DataUtils.GetInt(hfACMemberFormId.Value),
                                cbReceived.Checked, DataUtils.GetDate(txtReceivedDate.Text), URL,
                                txtACMemberFormNotes.Text, cbACFormActive.Checked);
                LogMessage("AC Member Form data updated successfully");

                dvNewMemberForm.Visible = false;

                hfACMemberFormId.Value = "";
                txtReceivedDate.Text = "";
                txtURL.Text = "";
                txtACMemberFormNotes.Text = "";

                gvACMemberForm.EditIndex = -1;
                BindACMemberFormDataGrid();
            }
            else //add
            {
                AmericorpMemberResult objAmericorpMemberResult = AmericorpsMemberData.AddACMemberForm(DataUtils.GetInt(hfACMemberId.Value),
                                DataUtils.GetInt(hfACFormID.Value), cbReceived.Checked, DataUtils.GetDate(txtReceivedDate.Text), URL,
                                txtACMemberFormNotes.Text);

                dvNewMemberForm.Visible = false;

                hfACFormID.Value = "";
                txtReceivedDate.Text = "";
                txtURL.Text = "";
                txtACMemberFormNotes.Text = "";

                if (objAmericorpMemberResult.IsDuplicate && !objAmericorpMemberResult.IsActive)
                    LogMessage("AC Member form already exist as in-active");
                else if (objAmericorpMemberResult.IsDuplicate)
                    LogMessage("AC Member form already exist");
                else
                    LogMessage("AC Member form added successfully");

                gvACMemberForm.EditIndex = -1;
                BindACMemberFormDataGrid();

            }
        }

        protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindACMemberFormDataGrid();
        }
    }
}