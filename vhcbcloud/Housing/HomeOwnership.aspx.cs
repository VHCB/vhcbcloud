using DataAccessLayer;
using System;
using Microsoft.AspNet.Identity;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Housing;
using VHCBCommon.DataAccessLayer.Lead;
using System.IO;

namespace vhcbcloud.Housing
{ 
    public partial class HomeOwnership : System.Web.UI.Page
    {
        string Pagename = "HomeOwnership";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";
            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();

                BindControls();
                BindGrids();
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
                if (dr["URL"].ToString().Contains("HomeOwnership.aspx"))
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

        private void BindControls()
        {
            BindAddresses();
            PopulateHomeOwnerDropDown(ddlOwner, "Owner");
            PopulateHomeOwnerDropDown(ddlLender, "Lender");
            //BindLookUP(ddlOwner, 117);
            //BindLookUP(ddlLender, 56);
        }

        private void PopulateHomeOwnerDropDown(DropDownList ddList, string Role)
        {
            try
            {
                DataTable dtProjectEntity = ProjectMaintenanceData.GetProjectApplicantList(DataUtils.GetInt(hfProjectId.Value), true);
                ddList.Items.Clear();
                ddList.DataSource = dtProjectEntity;
                ddList.DataValueField = "ApplicantId";
                ddList.DataTextField = "applicantname";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));

                foreach(DataRow dr in dtProjectEntity.Rows)
                {
                    if (dr["ApplicantRoleDescription"].ToString().ToLower() == Role.ToLower())
                    {
                        ListItem selectedListItem = ddList.Items.FindByValue(dr["ApplicantId"].ToString());
                        if (selectedListItem != null)
                        {
                            selectedListItem.Selected = true;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "PopulateOwnerDropDown", "", ex.Message);
            }

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

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void BindAddresses()
        {
            try
            {
                ddlAddress.Items.Clear();
                ddlAddress.DataSource = ProjectLeadBuildingsData.GetProjectAddressListByProjectID(DataUtils.GetInt(hfProjectId.Value));
                ddlAddress.DataValueField = "AddressId";
                ddlAddress.DataTextField = "Address";
                ddlAddress.DataBind();
                ddlAddress.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAddresses", "Control ID:" + ddlAddress.ID, ex.Message);
            }
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
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

        #region Logs
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
        #endregion Logs

        protected void btnAddAddress_Click(object sender, EventArgs e)
        {
            if (IsAddressFormValid())
            {
                if (btnAddAddress.Text == "Add")
                {
                    HomeOwnershipResult objHomeOwnershipResult = HomeOwnershipData.AddHomeOwnershipAddress((DataUtils.GetInt(hfProjectId.Value)),
                        DataUtils.GetInt(ddlAddress.SelectedValue.ToString()), cbMH.Checked, cbCondo.Checked, cbSFD.Checked);

                    ClearAddressForm();
                    BindGrids();

                    if (objHomeOwnershipResult.IsDuplicate && !objHomeOwnershipResult.IsActive)
                        LogMessage("Address already exist as in-active");
                    else if (objHomeOwnershipResult.IsDuplicate)
                        LogMessage("Address already exist");
                    else
                        LogMessage("Address Added Successfully");
                }
                else
                {
                    HomeOwnershipData.UpdateHouseOwnership((DataUtils.GetInt(hfHomeOwnershipID.Value)), DataUtils.GetInt(ddlAddress.SelectedValue.ToString()),
                      cbMH.Checked, cbCondo.Checked, cbSFD.Checked, chkAddressActive.Checked);

                    gvHOAddress.EditIndex = -1;
                    BindGrids();
                    hfHomeOwnershipID.Value = "";
                    ClearAddressForm();
                    btnAddAddress.Text = "Add";

                    LogMessage("Address Updated Successfully");
                }
            }
        }

        private bool IsAddressFormValid()
        {
            if (ddlAddress.Items.Count > 1 && ddlAddress.SelectedIndex == 0)
            {
                LogMessage("Select Address");
                ddlAddress.Focus();
                return false;
            }

            if (cbMH.Checked == false && cbSFD.Checked == false && cbCondo.Checked == false)
            {
                LogMessage("Please select any one of the Home Type");
                cbMH.Focus();
                return false;
            }
            return true;
        }

        private void BindGrids()
        {
            BindAddressGrid();
            BindHomeOwnersGrid();
        }

        private void ClearAddressForm()
        {
            cbAddAddress.Checked = false;

            ddlAddress.SelectedIndex = -1;
            cbMH.Checked = false;
            cbSFD.Checked = false;
            cbCondo.Checked = false;
            chkAddressActive.Enabled = false;
        }

        private void BindAddressGrid()
        {
            dvNewHomeOwnerInfo.Visible = false;

            try
            {
                DataTable dt = HomeOwnershipData.GetHomeOwnershipList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvHOAddressGrid.Visible = true;
                    gvHOAddress.DataSource = dt;
                    gvHOAddress.DataBind();
                }
                else
                {
                    dvHOAddressGrid.Visible = false;
                    gvHOAddress.DataSource = null;
                    gvHOAddress.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildings", "", ex.Message);
            }
        }

        protected void gvHOAddress_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvHOAddress.EditIndex = e.NewEditIndex;
            BindAddressGrid();
        }

        protected void gvHOAddress_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHOAddress.EditIndex = -1;
            BindAddressGrid();
            ClearAddressForm();
            //    //hfLeadUnitID.Value = "";
            btnAddAddress.Text = "Submit";
        }

        protected void gvHOAddress_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddAddress.Text = "Update";
                    cbAddAddress.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[7].Controls[0].Visible = false;

                        Label lblHomeOwnershipID = e.Row.FindControl("lblHomeOwnershipID") as Label;
                        DataRow dr = HomeOwnershipData.GetHomeOwnershipById(DataUtils.GetInt(lblHomeOwnershipID.Text));

                        hfHomeOwnershipID.Value = lblHomeOwnershipID.Text;
                        PopulateDropDown(ddlAddress, dr["AddressID"].ToString());

                        cbMH.Checked = DataUtils.GetBool(dr["MH"].ToString());
                        cbSFD.Checked = DataUtils.GetBool(dr["SFD"].ToString());
                        cbCondo.Checked = DataUtils.GetBool(dr["Condo"].ToString());

                        chkAddressActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvHOAddress_RowDataBound", "", ex.Message);
            }

        }

        protected void rdBtnSelectAddress_CheckedChanged(object sender, EventArgs e)
        {
            SelectedAddressRecordInfo objSelectedAddressRecordInfo = GetSelectedAddressRecordID(gvHOAddress);

            hfHomeOwnershipID.Value = objSelectedAddressRecordInfo.HomeOwnershipID.ToString();
            dvNewHomeOwnerInfo.Visible = true;
            BindHomeOwnersGrid();

            cbAddOwner.Checked = false;
        }

        private void BindHomeOwnersGrid()
        {
            try
            {
                DataTable dt = HomeOwnershipData.GetProjectHomeOwnershipList(DataUtils.GetInt(hfHomeOwnershipID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvOwnerGrid.Visible = true;
                    gvOwner.DataSource = dt;
                    gvOwner.DataBind();
                }
                else
                {
                    dvOwnerGrid.Visible = false;
                    gvOwner.DataSource = null;
                    gvOwner.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindUnitsGrid", "", ex.Message);
            }
        }

        private SelectedAddressRecordInfo GetSelectedAddressRecordID(GridView gvHOAddress)
        {
            SelectedAddressRecordInfo objSelectedAddressRecordInfo = new SelectedAddressRecordInfo();

            for (int i = 0; i < gvHOAddress.Rows.Count; i++)
            {
                RadioButton rbAddressRecord = (RadioButton)gvHOAddress.Rows[i].Cells[0].FindControl("rdBtnSelectAddress");
                if (rbAddressRecord != null)
                {
                    if (rbAddressRecord.Checked)
                    {
                        HiddenField hf = (HiddenField)gvHOAddress.Rows[i].Cells[0].FindControl("HiddenHomeOwnershipID");
                       // Label lblHomeOwnershipID = (Label)gvHOAddress.Rows[i].Cells[1].FindControl("lblHomeOwnershipID");

                        if (hf != null)
                        {
                            objSelectedAddressRecordInfo.HomeOwnershipID = DataUtils.GetInt(hf.Value);
                            //objSelectedAddressRecordInfo.Building = DataUtils.GetInt(lblHomeOwnershipID.Text);
                        }
                        break;
                    }
                }
            }
            return objSelectedAddressRecordInfo;
        }

        protected void gvOwner_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOwner.EditIndex = e.NewEditIndex;
            BindHomeOwnersGrid();
        }

        protected void gvOwner_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOwner.EditIndex = -1;
            BindHomeOwnersGrid();
            ClearOwnerForm();
            btnAddOwner.Text = "Submit";
        }

        protected void gvOwner_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddOwner.Text = "Update";
                    cbAddOwner.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;

                        Label lblProjectHomeOwnershipID = e.Row.FindControl("lblProjectHomeOwnershipID") as Label;
                        DataRow dr = HomeOwnershipData.GetProjectHomeOwnershipById(DataUtils.GetInt(lblProjectHomeOwnershipID.Text));

                        hfProjectHomeOwnershipID.Value = lblProjectHomeOwnershipID.Text;

                        PopulateDropDown(ddlOwner, dr["Owner"].ToString());
                        PopulateDropDown(ddlLender, dr["LkLender"].ToString());
                        cbVHFAInv.Checked = DataUtils.GetBool(dr["vhfa"].ToString()); ;
                        cbRDLoan.Checked = DataUtils.GetBool(dr["RDLoan"].ToString()); ;

                        txtVHCBGrant.Text = dr["VHCBGrant"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["VHCBGrant"].ToString()).ToString("#.00");
                        txtOwnerAppAtResale.Text = dr["OwnerApprec"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["OwnerApprec"].ToString()).ToString("#.00");
                        txtCapitalImpAtResale.Text = dr["CapImprove"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["CapImprove"].ToString()).ToString("#.00");
                        txtFeeAtPurchase.Text = dr["InitFee"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["InitFee"].ToString()).ToString("#.00");
                        txtFeeAtResale.Text = dr["ResaleFee"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["ResaleFee"].ToString()).ToString("#.00");
                        txtStewardCont.Text = dr["StewFee"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["StewFee"].ToString()).ToString("#.00");
                        txtVHCBAsstLoan.Text = dr["AssistLoan"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["AssistLoan"].ToString()).ToString("#.00");
                        txtVHCBRehabLoan.Text = dr["RehabLoan"].ToString() == "0.0000" ? "" : DataUtils.GetDecimal(dr["RehabLoan"].ToString()).ToString("#.00");

                        chkOwnerActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvOwner_RowDataBound", "", ex.Message);
            }
        }

        protected void btnAddOwner_Click(object sender, EventArgs e)
        {
            if (IsOwnerFormValid())
            {
                if (btnAddOwner.Text == "Submit")
                {
                    HomeOwnershipResult objHomeOwnershipResult = HomeOwnershipData.AddProjectHomeOwnership(DataUtils.GetInt(hfHomeOwnershipID.Value), DataUtils.GetInt(ddlOwner.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlLender.SelectedValue.ToString()), cbVHFAInv.Checked, cbRDLoan.Checked, DataUtils.GetDecimal(txtVHCBGrant.Text), DataUtils.GetDecimal(txtOwnerAppAtResale.Text),
                        DataUtils.GetDecimal(txtCapitalImpAtResale.Text), DataUtils.GetDecimal(txtFeeAtPurchase.Text), DataUtils.GetDecimal(txtFeeAtResale.Text), DataUtils.GetDecimal(txtStewardCont.Text),
                        DataUtils.GetDecimal(txtVHCBAsstLoan.Text), DataUtils.GetDecimal(txtVHCBRehabLoan.Text));

                    ClearOwnerForm();
                    BindHomeOwnersGrid();

                    if (objHomeOwnershipResult.IsDuplicate && !objHomeOwnershipResult.IsActive)
                        LogMessage("Owner already exist as in-active");
                    else if (objHomeOwnershipResult.IsDuplicate)
                        LogMessage("Owner already exist");
                    else
                        LogMessage("Owner Added Successfully");
                }
                else
                {
                    HomeOwnershipData.UpdateProjectHomeOwnership(DataUtils.GetInt(hfProjectHomeOwnershipID.Value), DataUtils.GetInt(ddlOwner.SelectedValue.ToString()),
                        DataUtils.GetInt(ddlLender.SelectedValue.ToString()), cbVHFAInv.Checked, cbRDLoan.Checked, DataUtils.GetDecimal(txtVHCBGrant.Text), DataUtils.GetDecimal(txtOwnerAppAtResale.Text),
                        DataUtils.GetDecimal(txtCapitalImpAtResale.Text), DataUtils.GetDecimal(txtFeeAtPurchase.Text), DataUtils.GetDecimal(txtFeeAtResale.Text), DataUtils.GetDecimal(txtStewardCont.Text),
                        DataUtils.GetDecimal(txtVHCBAsstLoan.Text), DataUtils.GetDecimal(txtVHCBRehabLoan.Text), chkOwnerActive.Checked);

                    gvOwner.EditIndex = -1;
                    BindHomeOwnersGrid();
                    ClearOwnerForm();
                    hfProjectHomeOwnershipID.Value = "";
                    btnAddOwner.Text = "Submit";
                    LogMessage("Owner Updated Successfully");
                }
            }
        }

        private bool IsOwnerFormValid()
        {
            if (ddlOwner.Items.Count > 1 && ddlOwner.SelectedIndex == 0)
            {
                LogMessage("Select Owner");
                ddlOwner.Focus();
                return false;
            }

            return true;
        }

        private void ClearOwnerForm()
        {
            cbAddOwner.Checked = false;

            ddlOwner.SelectedIndex = -1;
            ddlLender.SelectedIndex = -1;
            cbVHFAInv.Checked = false;
            cbRDLoan.Checked = false;
            txtVHCBGrant.Text = "";
            txtOwnerAppAtResale.Text = "";
            txtCapitalImpAtResale.Text = "";
            txtFeeAtPurchase.Text = "";
            txtFeeAtResale.Text = "";
            txtStewardCont.Text = "";
            txtVHCBAsstLoan.Text = "";
            txtVHCBRehabLoan.Text = "";

            chkOwnerActive.Enabled = false;
        }
    }

    public class SelectedAddressRecordInfo
    {
        public int HomeOwnershipID { set; get; }
       // public int Building { set; get; }
    }
}