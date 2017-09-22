using DataAccessLayer;
using System;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using VHCBCommon.DataAccessLayer.Conservation;
using VHCBCommon.DataAccessLayer.Lead;

namespace vhcbcloud.Conservation
{
    public partial class ConservationAppraisals : System.Web.UI.Page
    {
        string Pagename = "ConservationAppraisals";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            hfProjectId.Value = "0";

            ProjectNotesSetUp();
            GenerateTabs();

            if (!IsPostBack)
            {
                Session["dtOccupantsList"] = null;
                PopulateProjectDetails();
                BindControls();
                BindAppraisalValueForm();
                BindGrids();
            }
            GetRoleAuth();
        }

        protected bool GetRoleAuth()
        {
            bool checkAuth = UserSecurityData.GetRoleAuth(Context.User.Identity.Name, DataUtils.GetInt(Request.QueryString["ProjectId"]));
            if (!checkAuth)
                RoleReadOnly();
            return checkAuth;
        }

        protected void RoleReadOnly()
        {
            btnAddAppraisalInfo.Visible = false;
            btnAddPay.Visible = false;
            btnSubmit.Visible = false;
            cbAddAppraisalInfo.Enabled = false;
            cbAddAppraisalPay.Enabled = false;
            cbReviewApproved.Enabled = false;
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

        private void BindAppraisalValueForm()
        {
            DataRow drAppraisalValue = ConservationAppraisalsData.GetConservationAppraisalValueById(DataUtils.GetInt(hfProjectId.Value));

            dvNewAppraisalInfo.Visible = false;

            if (drAppraisalValue != null)
            {
                btnSubmit.Text = "Update";
                hfAppraisalID.Value = drAppraisalValue["AppraisalID"].ToString();
                txtFeeValue.Text = drAppraisalValue["FeeValue"].ToString();
                txtTotalAcres.Text = drAppraisalValue["TotAcres"].ToString();
                txtValueBefore.Text = drAppraisalValue["Apbef"].ToString();
                txtValueafter.Text =drAppraisalValue["Apaft"].ToString();
                txtValueofLandWithOption.Text = drAppraisalValue["Aplandopt"].ToString();
                txtEnhancedExclusionValue.Text =drAppraisalValue["Exclusion"].ToString();
                spEasementValue.InnerText = CommonHelper.myDollarFormat(drAppraisalValue["EaseValue"].ToString());// DataUtils.GetDecimal(drAppraisalValue["EaseValue"].ToString()).ToString("#.##");
                spEasementValuePerAcre.InnerText = CommonHelper.myDollarFormat(drAppraisalValue["Valperacre"].ToString());  //DataUtils.GetDecimal(drAppraisalValue["Valperacre"].ToString()).ToString("#.##");
                txtAppraisalValueComments.Text = drAppraisalValue["Comments"].ToString();

                dvNewAppraisalInfo.Visible = true;
                BindGrids();

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
                if (dr["URL"].ToString().Contains("ConservationAppraisals.aspx"))
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

        private void PopulateProjectDetails()
        {
            DataRow dr = ProjectMaintenanceData.GetProjectNameById(DataUtils.GetInt(hfProjectId.Value));
            ProjectNum.InnerText = dr["ProjNumber"].ToString();
            ProjName.InnerText = dr["ProjectName"].ToString();
        }

        private void BindControls()
        {
            BindLookUP(ddlAppraiser, 57);
            BindApplicants(ddlPayParty);
        }

        protected void BindApplicants(DropDownList ddList)
        {
            try
            {
                ddList.Items.Clear();
                ddList.DataSource = ApplicantData.GetSortedApplicants();
                ddList.DataValueField = "appnameid";
                ddList.DataTextField = "Applicantname";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindApplicants", "", ex.Message);
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTotalAcres.Text.ToString()) == true)
            {
                LogMessage("Enter Total Acres");
                txtTotalAcres.Focus();
                return;
            }
            //if (ddlAddress.SelectedIndex == 0)
            //{
            //    LogMessage("Select Address");
            //    ddlAddress.Focus();
            //    return;
            //}

            decimal Easementvalue;

            if (txtFeeValue.Text == "")
                Easementvalue = DataUtils.GetDecimal(Regex.Replace(txtValueBefore.Text, "[^0-9a-zA-Z.]+", "")) - DataUtils.GetDecimal(Regex.Replace(txtValueafter.Text, "[^0-9a-zA-Z.]+", ""));
            else
                Easementvalue = DataUtils.GetDecimal(Regex.Replace(txtFeeValue.Text, "[^0-9a-zA-Z.]+", ""));


            decimal EasementValuePerAcre = Easementvalue / DataUtils.GetInt(txtTotalAcres.Text);

            if (btnSubmit.Text == "Submit")
            {
                ConservationAppraisalsData.AddConservationAppraisalValue(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(txtTotalAcres.Text),
                    DataUtils.GetDecimal(Regex.Replace(txtValueBefore.Text, "[^0-9a-zA-Z.]+", "")), 
                    DataUtils.GetDecimal(Regex.Replace(txtValueafter.Text, "[^0-9a-zA-Z.]+", "")), 
                    DataUtils.GetDecimal(Regex.Replace(txtValueofLandWithOption.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtEnhancedExclusionValue.Text, "[^0-9a-zA-Z.]+", "")),  
                    Easementvalue, EasementValuePerAcre, txtAppraisalValueComments.Text, 
                    DataUtils.GetDecimal(Regex.Replace(txtFeeValue.Text, "[^0-9a-zA-Z.]+", "")));
                BindAppraisalValueForm();
                BindGrids();
                LogMessage("Appraisal Value Added Successfully");
            }
            else
            {
                ConservationAppraisalsData.UpdateConservationAppraisalValue(DataUtils.GetInt(hfProjectId.Value), DataUtils.GetInt(txtTotalAcres.Text),
                   DataUtils.GetDecimal(Regex.Replace(txtValueBefore.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtValueafter.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtValueofLandWithOption.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDecimal(Regex.Replace(txtEnhancedExclusionValue.Text, "[^0-9a-zA-Z.]+", "")),
                   Easementvalue, EasementValuePerAcre, true, txtAppraisalValueComments.Text,
                   DataUtils.GetDecimal(Regex.Replace(txtFeeValue.Text, "[^0-9a-zA-Z.]+", "")));

                gvAppraisalInfo.EditIndex = -1;
                BindAppraisalValueForm();
                BindGrids();
                LogMessage("Appraisal Value Updated Successfully");
            }
        }

        private void BindGrids()
        {
            BindAppaisalInfoGrid();
        }

        private void BindAppaisalInfoGrid()
        {
            dvNewAppraisalPay.Visible = false;

            try
            {
                DataTable dt = ConservationAppraisalsData.GetConservationAppraisalInfoList(DataUtils.GetInt(hfAppraisalID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAppraisalInfoGrid.Visible = true;
                    gvAppraisalInfo.DataSource = dt;
                    gvAppraisalInfo.DataBind();
                    Session["dtAppraisalInfoList"] = dt;
                }
                else
                {
                    dvAppraisalInfoGrid.Visible = false;
                    gvAppraisalInfo.DataSource = null;
                    gvAppraisalInfo.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindOccupantsGrid", "", ex.Message);
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

        protected void gvAppraisalInfo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAppraisalInfo.EditIndex = e.NewEditIndex;
            BindAppaisalInfoGrid();
        }

        protected void gvAppraisalInfo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAppraisalInfo.EditIndex = -1;
            BindAppaisalInfoGrid();
            ClearAppraisalInfoForm();
            hfAppraisalInfoID.Value = "";
            btnAddAppraisalInfo.Text = "Add";
        }

        protected void gvAppraisalInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddAppraisalInfo.Text = "Update";
                    cbAddAppraisalInfo.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[8].Controls[0].Visible = false;

                        Label lblAppraisalInfoID = e.Row.FindControl("lblAppraisalInfoID") as Label;
                        DataRow dr = ConservationAppraisalsData.GetConservationAppraisalInfoById(DataUtils.GetInt(lblAppraisalInfoID.Text));

                        hfAppraisalInfoID.Value = lblAppraisalInfoID.Text;

                        PopulateDropDown(ddlAppraiser, dr["LkAppraiser"].ToString());
                        txtDateOrdered.Text = dr["AppOrdered"].ToString() == "" ? "" : Convert.ToDateTime(dr["AppOrdered"].ToString()).ToShortDateString();
                        txtDateReceived.Text = dr["AppRecd"].ToString() == "" ? "" : Convert.ToDateTime(dr["AppRecd"].ToString()).ToShortDateString();
                        txtEffectiveDate.Text = dr["EffDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["EffDate"].ToString()).ToShortDateString();
                        txtTotalCost.Text = dr["AppCost"].ToString();
                        txtNotes.Text = dr["Comment"].ToString();
                        txtDateNRCS.Text = dr["NRCSSent"].ToString() == "" ? "" : Convert.ToDateTime(dr["NRCSSent"].ToString()).ToShortDateString();
                        cbReviewApproved.Checked = DataUtils.GetBool(dr["RevApproved"].ToString());
                        txtReviewApprovedDate.Text = dr["ReviewDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["ReviewDate"].ToString()).ToShortDateString();
                        txtURL.Text = dr["URL"].ToString();
                        chkAppraisalInfoActive.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAppraisalInfo_RowDataBound", "", ex.Message);
            }
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
        protected void rdBtnSelectAppraisalInfo_CheckedChanged(object sender, EventArgs e)
        {
            int AppraisalInfoID = GetAppraisalInfoSelectedRecordID(gvAppraisalInfo);
            hfAppraisalInfoID.Value = AppraisalInfoID.ToString();
            dvNewAppraisalPay.Visible = true;
            BindPayGrid();
        }

        private int GetAppraisalInfoSelectedRecordID(GridView gvAppraisalInfo)
        {
            int AppraisalInfoID = 0;
            hfSelectedAppraisalTotalCost.Value = "";

            for (int i = 0; i < gvAppraisalInfo.Rows.Count; i++)
            {
                RadioButton rbAppraisalInfo = (RadioButton)gvAppraisalInfo.Rows[i].Cells[0].FindControl("rdBtnSelectAppraisalInfo");
                if (rbAppraisalInfo != null)
                {
                    if (rbAppraisalInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvAppraisalInfo.Rows[i].Cells[0].FindControl("HiddenAppraisalInfoID");
                        HiddenField hf1 = (HiddenField)gvAppraisalInfo.Rows[i].Cells[0].FindControl("HiddenAppraisalTotalCost");
                        
                        if (hf != null)
                        {
                            AppraisalInfoID = DataUtils.GetInt(hf.Value);
                            hfSelectedAppraisalTotalCost.Value = hf1.Value;
                        }
                        break;
                    }
                }
            }
            return AppraisalInfoID;
        }

        protected void btnAddAppraisalInfo_Click(object sender, EventArgs e)
        {
            if (ddlAppraiser.SelectedIndex == 0)
            {
                LogMessage("Select Appraiser");
                ddlAppraiser.Focus();
                return;
            }

            if (txtDateOrdered.Text.Trim() == "")
            {
                LogMessage("Enter Date Ordered");
                txtDateOrdered.Focus();
                return;
            }
            else
            {
                if (!DataUtils.IsDateTime(txtDateOrdered.Text.Trim()))
                {
                    LogMessage("Enter valid Date Ordered");
                    txtDateOrdered.Focus();
                    return;
                }
            }

            string URL = txtURL.Text;

            if (!URL.Contains("http"))
                URL = "http://" + URL;

            if (btnAddAppraisalInfo.Text == "Add")
            {
                AppraisalResult objAppraisalResult = ConservationAppraisalsData.AddConservationAppraisalInfo((DataUtils.GetInt(hfAppraisalID.Value)),
                    DataUtils.GetInt(ddlAppraiser.SelectedValue.ToString()), DataUtils.GetDate(txtDateOrdered.Text), DataUtils.GetDate(txtDateReceived.Text),
                    DataUtils.GetDate(txtEffectiveDate.Text), DataUtils.GetDecimal(Regex.Replace(txtTotalCost.Text, "[^0-9a-zA-Z.]+", "")), txtNotes.Text, DataUtils.GetDate(txtDateNRCS.Text),
                    cbReviewApproved.Checked, DataUtils.GetDate(txtReviewApprovedDate.Text), URL);

                ClearAppraisalInfoForm();
                BindGrids();

                if (objAppraisalResult.IsDuplicate && !objAppraisalResult.IsActive)
                    LogMessage("Appraisal Info already exist as in-active");
                else if (objAppraisalResult.IsDuplicate)
                    LogMessage("Appraisal Info already exist");
                else
                    LogMessage("Appraisal Info Added Successfully");
            }
            else
            {
                ConservationAppraisalsData.UpdateConservationAppraisalInfo((DataUtils.GetInt(hfAppraisalInfoID.Value)),
                   DataUtils.GetInt(ddlAppraiser.SelectedValue.ToString()), DataUtils.GetDate(txtDateOrdered.Text), DataUtils.GetDate(txtDateReceived.Text),
                   DataUtils.GetDate(txtEffectiveDate.Text), DataUtils.GetDecimal(Regex.Replace(txtTotalCost.Text, "[^0-9a-zA-Z.]+", "")), txtNotes.Text, DataUtils.GetDate(txtDateNRCS.Text),
                   cbReviewApproved.Checked, DataUtils.GetDate(txtReviewApprovedDate.Text), chkAppraisalInfoActive.Checked, URL);

                gvAppraisalInfo.EditIndex = -1;
                BindGrids();
                //hfLeadBldgID.Value = "";
                ClearAppraisalInfoForm();
                btnAddAppraisalInfo.Text = "Add";

                LogMessage("Appraisal Info Updated Successfully");
            }
        }

        private void ClearAppraisalInfoForm()
        {
            cbAddAppraisalInfo.Checked = false;

            hfAppraisalInfoID.Value = "";
            ddlAppraiser.SelectedIndex = -1;
            txtDateOrdered.Text = "";
            txtDateReceived.Text = "";
            txtEffectiveDate.Text = "";
            txtTotalCost.Text = "";
            txtNotes.Text = "";
            txtDateNRCS.Text = "";
            txtNotes.Text = "";
            cbReviewApproved.Checked = false;
            txtReviewApprovedDate.Text = "";
            txtURL.Text = "";
            chkAppraisalInfoActive.Enabled = false;
        }

        protected void btnAddPay_Click(object sender, EventArgs e)
        {
            if (ddlPayParty.SelectedIndex == 0)
            {
                LogMessage("Select Responsible Party");
                ddlPayParty.Focus();
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPayAmount.Text.ToString()) == true)
            {
                LogMessage("Enter Amount");
                txtPayAmount.Focus();
                return;
            }

            ConservationAppraisalsData.AddConservationAppraisalPay((DataUtils.GetInt(hfAppraisalInfoID.Value)),
                DataUtils.GetDecimal(txtPayAmount.Text), DataUtils.GetInt(ddlPayParty.SelectedValue.ToString()));

            ClearPayForm();
            BindPayGrid();
            LogMessage("Payment Added Successfully");

        }

        private void ClearPayForm()
        {
            cbAddAppraisalPay.Checked = false;

            txtPayAmount.Text = "";
            ddlPayParty.SelectedIndex = -1;
        }

        private void BindPayGrid()
        {
            try
            {
                DataTable dt = ConservationAppraisalsData.GetConservationAppraisalPayList(DataUtils.GetInt(hfAppraisalInfoID.Value),
                    cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAppraisalPayGrid.Visible = true;
                    gvAppraisalPay.DataSource = dt;
                    gvAppraisalPay.DataBind();

                    Label lblFooterTotalPayAmount = (Label)gvAppraisalPay.FooterRow.FindControl("lblFooterTotalPayAmount");
                    decimal totPayAmountFromDB = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totPayAmountFromDB += DataUtils.GetDecimal(dt.Rows[i]["PayAmt"].ToString());
                    }

                    lblFooterTotalPayAmount.Text = CommonHelper.myDollarFormat(totPayAmountFromDB);

                    decimal TotalCost = DataUtils.GetDecimal(hfSelectedAppraisalTotalCost.Value);

                    hfPayWarning.Value = "0";
                    if (TotalCost - totPayAmountFromDB != 0)
                    {
                        hfPayWarning.Value = "1";
                        WarningMessage(dvPayWarning, lblPayWarning, "The Responsible Parties' amount(s) must equal the Total Cost of the Appraisal " + CommonHelper.myDollarFormat(TotalCost));
                    }
                    else
                    {
                        dvPayWarning.Visible = false;
                        lblPayWarning.Text = "";
                    }
                }
                else
                {
                    dvAppraisalPayGrid.Visible = false;
                    gvAppraisalPay.DataSource = null;
                    gvAppraisalPay.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindPayGrid", "", ex.Message);
            }
        }

        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }

        protected void gvAppraisalPay_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAppraisalPay.EditIndex = e.NewEditIndex;
            BindPayGrid();
        }

        protected void gvAppraisalPay_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAppraisalPay.EditIndex = -1;
            BindPayGrid();
        }

        protected void gvAppraisalPay_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int AppraisalPayID = DataUtils.GetInt(((Label)gvAppraisalPay.Rows[rowIndex].FindControl("lblAppraisalPayID")).Text);
            int WhoPaid = DataUtils.GetInt(((DropDownList)gvAppraisalPay.Rows[rowIndex].FindControl("ddlPayParty")).SelectedValue.ToString());
            decimal Amount = DataUtils.GetDecimal(((TextBox)gvAppraisalPay.Rows[rowIndex].FindControl("txtPayAmount")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvAppraisalPay.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAppraisalsData.UpdateConservationAppraisalPay(AppraisalPayID, Amount, WhoPaid, RowIsActive);

            gvAppraisalPay.EditIndex = -1;

            BindPayGrid();

            LogMessage("Payment Updated successfully");
        }

        protected void gvAppraisalPay_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlPayParty = (e.Row.FindControl("ddlPayParty") as DropDownList);
                    TextBox txtWhoPaid = (e.Row.FindControl("txtWhoPaid") as TextBox);

                    if (txtWhoPaid != null)
                    {
                        BindApplicants(ddlPayParty);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlPayParty.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtWhoPaid.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlPayParty.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }
    }
}