using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class ConservationAct250 : System.Web.UI.Page
    {
        string Pagename = "ConservationAct250";
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg.Text = "";

            ifProjectNotes.Src = "ProjectNotes.aspx";

            var ctrlName = Request.Params[Page.postEventSourceID];
            var args = Request.Params[Page.postEventArgumentID];

            HandleCustomPostbackEvent(ctrlName, args);

            if (!IsPostBack)
            {
                BindControls();
                BindGrids();
            }
        }
        protected void Page_PreInit(Object sender, EventArgs e)
        {
            DataTable dt = UserSecurityData.GetUserId(Context.User.Identity.Name);
            if (dt.Rows.Count > 0)
            {
                //this.MasterPageFile = "SiteNonAdmin.Master";
            }
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            var onBlurScript = Page.ClientScript.GetPostBackEventReference(txtPotentialProjNum, "OnBlur");
            txtPotentialProjNum.Attributes.Add("onblur", onBlurScript);
        }
        private void BindControls()
        {
            //BindLookUP(ddlFarmType, 34);
            BindLookUP(ddlTown, 89);
            BindApplicants(ddlDeveloper);
            //BindProjects(ddlProjects);
            //BindLookUP(ddlConservationTown, 89);
        }

        protected void BindProjects(DropDownList ddList)
        {
            try
            {
                DataTable dt = ProjectCheckRequestData.GetData("getprojectslist");
                //DataView dv = dt.DefaultView;
                //dv.Sort = "description asc";
                //DataTable sortedDT = dv.ToTable();

                ddList.Items.Clear();
                ddList.DataSource = dt; // sortedDT;
                ddList.DataValueField = "projectid";
                ddList.DataTextField = "project_num_name";
                ddList.DataBind();
                ddList.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
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

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindGrids();
        }

        private void BindGrids()
        {
            BindAct250InfoGrid();
        }

        private void BindAct250InfoGrid()
        {
            dvNewDeveloperPayments.Visible = false;
            dvNewlandUsePermitFinancials.Visible = false;
            dvNewVHCBProjects.Visible = false;

            try
            {
                DataTable dt = ConservationAct250Data.GetAct250FarmsList(cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAct250InfoGrid.Visible = true;
                    gvAct250Info.DataSource = dt;
                    gvAct250Info.DataBind();
                }
                else
                {
                    dvAct250InfoGrid.Visible = false;
                    gvAct250Info.DataSource = null;
                    gvAct250Info.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindAct250InfoGrid", "", ex.Message);
            }
        }

        protected void btnAddAct250Info_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtLandUsePermit.Text.ToString()) == true)
            {
                LogMessage("Enter Land Use Permit");
                txtLandUsePermit.Focus();
                return;
            }

            string URL = txtURL.Text;

            if (URL != "")
            {
                if (!URL.Contains("http"))
                    URL = "http://" + URL;
            }

            if (btnAddAct250Info.Text == "Submit")
            {
                ConservationAct250Result objConservationAct250Result = ConservationAct250Data.AddAct250Farm(txtLandUsePermit.Text,
                    DataUtils.GetInt(ddlTown.SelectedValue.ToString()), DataUtils.GetInt(txtDistrictNo.Text),
                    DataUtils.GetInt(ddlFarmType.SelectedValue.ToString()), txtDevname.Text, DataUtils.GetInt(txtPrimeSoilsAcresLost.Text),
                    DataUtils.GetInt(txtStateSoilsAcresLost.Text), DataUtils.GetInt(txtTotAcresLost.Text), DataUtils.GetInt(txtAcresDeveloped.Text),
                    DataUtils.GetInt(ddlDeveloper.SelectedValue.ToString()),
                    DataUtils.GetDecimal(Regex.Replace(txtAnticipatedFunds.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDate(txtMitigationDate.Text), URL);

                BindGrids();
                ClearAct250InfoForm();

                if (objConservationAct250Result.IsDuplicate && !objConservationAct250Result.IsActive)
                    LogMessage("Act250 Info already exist as in-active");
                else if (objConservationAct250Result.IsDuplicate)
                    LogMessage("Act250 Info already exist");
                else
                    LogMessage("Act250 Info added successfully");
            }
            else
            {
                ConservationAct250Data.UpdateAct250Farm(DataUtils.GetInt(hfAct250FarmID.Value), DataUtils.GetInt(ddlTown.SelectedValue.ToString()),
                    DataUtils.GetInt(txtDistrictNo.Text), DataUtils.GetInt(ddlFarmType.SelectedValue.ToString()), txtDevname.Text,
                    DataUtils.GetInt(txtPrimeSoilsAcresLost.Text), DataUtils.GetInt(txtStateSoilsAcresLost.Text), DataUtils.GetInt(txtTotAcresLost.Text),
                    DataUtils.GetInt(txtAcresDeveloped.Text), DataUtils.GetInt(ddlDeveloper.SelectedValue.ToString()),
                    DataUtils.GetDecimal(Regex.Replace(txtAnticipatedFunds.Text, "[^0-9a-zA-Z.]+", "")),
                    DataUtils.GetDate(txtMitigationDate.Text), URL, chkAct250Active.Checked);

                gvAct250Info.EditIndex = -1;
                ClearAct250InfoForm();
                BindGrids();
                btnAddAct250Info.Text = "Submit";
                LogMessage("Act250 Info Updated Successfully");
            }
        }

        private void ClearAct250InfoForm()
        {
            cbAddAct250Info.Checked = false;
            txtLandUsePermit.Text = "";
            ddlTown.SelectedIndex = -1;
            ddlFarmType.SelectedIndex = -1;
            ddlDeveloper.SelectedIndex = -1;
            txtDevname.Text = "";
            txtDistrictNo.Text = "";
            txtPrimeSoilsAcresLost.Text = "";
            txtStateSoilsAcresLost.Text = "";
            txtTotAcresLost.Text = "";
            txtAcresDeveloped.Text = "";
            txtAnticipatedFunds.Text = "";
            txtMitigationDate.Text = "";
            txtURL.Text = "";

            txtLandUsePermit.Enabled = true;
            chkAct250Active.Enabled = false;
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

        protected void gvAct250Info_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAct250Info.EditIndex = e.NewEditIndex;
            BindAct250InfoGrid();
        }

        protected void gvAct250Info_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAct250Info.EditIndex = -1;
            BindAct250InfoGrid();
            ClearAct250InfoForm();
            hfAct250FarmID.Value = "";
            btnAddAct250Info.Text = "Submit";
        }

        protected void gvAct250Info_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    btnAddAct250Info.Text = "Update";
                    cbAddAct250Info.Checked = true;

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[6].Controls[0].Visible = false;

                        Label lblAct250FarmID = e.Row.FindControl("lblAct250FarmID") as Label;
                        hfAct250FarmID.Value = lblAct250FarmID.Text;
                        PopulateAct250Form(DataUtils.GetInt(lblAct250FarmID.Text));
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvBldgInfo_RowDataBound", "", ex.Message);
            }
        }

        private void PopulateAct250Form(int FarmId)
        {
            DataRow dr = ConservationAct250Data.GetAct250FarmById(FarmId);
            txtLandUsePermit.Text = dr["UsePermit"].ToString();
            PopulateDropDown(ddlTown, dr["LkTownDev"].ToString());
            PopulateDropDown(ddlFarmType, dr["Type"].ToString());
            PopulateDropDown(ddlDeveloper, dr["Developer"].ToString());
            txtDevname.Text = dr["DevName"].ToString();
            txtDistrictNo.Text = dr["CDist"].ToString();
            txtPrimeSoilsAcresLost.Text = dr["Primelost"].ToString();
            txtStateSoilsAcresLost.Text = dr["Statelost"].ToString();
            txtTotAcresLost.Text = dr["TotalAcreslost"].ToString();
            txtAcresDeveloped.Text = dr["AcresDevelop"].ToString();
            txtAnticipatedFunds.Text = dr["AntFunds"].ToString();
            txtMitigationDate.Text = dr["MitDate"].ToString() == "" ? "" : Convert.ToDateTime(dr["MitDate"].ToString()).ToShortDateString();
            txtURL.Text = dr["URL"].ToString();
            chkAct250Active.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());

            txtLandUsePermit.Enabled = false;
            chkAct250Active.Enabled = true;
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

        protected void rdBtnSelectAct250Info_CheckedChanged(object sender, EventArgs e)
        {
            hfAct250FarmID.Value = GetAct250InfoSelectedRecordID(gvAct250Info);

            //Act250Info Form Also Populate
            btnAddAct250Info.Text = "Update";
            cbAddAct250Info.Checked = true;
            PopulateAct250Form(DataUtils.GetInt(hfAct250FarmID.Value));
            ////////////////////////

            dvNewDeveloperPayments.Visible = true;
            BindDeveloperPaymentsGrid();

            BindLandUsePermitFinancialsGrid();

            dvNewVHCBProjects.Visible = true;
            BindVHCBProjectsGrid();
        }

        private string GetAct250InfoSelectedRecordID(GridView gvAct250Info)
        {
            string Act250FarmID = null;

            for (int i = 0; i < gvAct250Info.Rows.Count; i++)
            {
                RadioButton rbAct250Info = (RadioButton)gvAct250Info.Rows[i].Cells[0].FindControl("rdBtnSelectAct250Info");
                if (rbAct250Info != null)
                {
                    if (rbAct250Info.Checked)
                    {
                        HiddenField hf = (HiddenField)gvAct250Info.Rows[i].Cells[0].FindControl("HiddenAct250FarmID");
                        HiddenField hfPermit = (HiddenField)gvAct250Info.Rows[i].Cells[0].FindControl("HiddenUsePermit");

                        if (hf != null)
                        {
                            Act250FarmID = hf.Value;
                            hfUsePermit.Value = hfPermit.Value;
                        }
                        break;
                    }
                }
            }
            return Act250FarmID;
        }

        private void BindDeveloperPaymentsGrid()
        {
            try
            {
                hfTotalDevPayments.Value = "0";

                DataTable dt = ConservationAct250Data.GetAct250DevPayList(DataUtils.GetInt(hfAct250FarmID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvDeveloperPaymentsGrid.Visible = true;
                    gvDeveloperPayments.DataSource = dt;
                    gvDeveloperPayments.DataBind();

                    Label lblFooterTotalAmt = (Label)gvDeveloperPayments.FooterRow.FindControl("lblFooterTotalAmtRec");
                    decimal totAmt = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totAmt += Convert.ToDecimal(dt.Rows[i]["AmtRec"].ToString());
                    }
                    hfTotalDevPayments.Value = totAmt.ToString();
                    lblFooterTotalAmt.Text = CommonHelper.myDollarFormat(totAmt);
                }
                else
                {
                    dvDeveloperPaymentsGrid.Visible = false;
                    gvDeveloperPayments.DataSource = null;
                    gvDeveloperPayments.DataBind();
                }
                BindLandUsePermitFinancialsGrid();
                BindVHCBProjectsGrid();
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindDeveloperPaymentsGrid", "", ex.Message);
            }

        }

        private void BindLandUsePermitFinancialsGrid()
        {
            //DataTable dtLandUsePermitFinacials = ConservationAct250Data.GetLandUsePermitFinancialsList(hfUsePermit.Value);
            //As per Dan per Dan detail.LandUsePermitId = act250Farm.Act250FarmId
            DataTable dtLandUsePermitFinacials = ConservationAct250Data.GetLandUsePermitFinancialsList(DataUtils.GetInt(hfAct250FarmID.Value));

            hfLandUsePermitFinancialsBalance.Value = "0";

            if (dtLandUsePermitFinacials.Rows.Count > 0)
            {
                dvNewlandUsePermitFinancials.Visible = true;
                headingForLandUsePermitFinancials.InnerHtml = "Commitments from Mitigation Fund - Permit #: " + hfUsePermit.Value;

                dvLandUsePermitFinancialsGrid.Visible = true;
                gvLandUsePermitFinancials.DataSource = dtLandUsePermitFinacials;
                gvLandUsePermitFinancials.DataBind();

                Label lblFooterTotalAmount = (Label)gvLandUsePermitFinancials.FooterRow.FindControl("lblFooterTotalAmount");
                Label lblFooterBalanceAmount = (Label)gvLandUsePermitFinancials.FooterRow.FindControl("lblFooterBalanceAmount");

                decimal totAmount = 0;

                for (int i = 0; i < dtLandUsePermitFinacials.Rows.Count; i++)
                {
                    totAmount += Convert.ToDecimal(dtLandUsePermitFinacials.Rows[i]["Amount"].ToString());
                }

                lblFooterTotalAmount.Text = CommonHelper.myDollarFormat(totAmount);
                lblFooterBalanceAmount.Text = CommonHelper.myDollarFormat(DataUtils.GetDecimal(hfTotalDevPayments.Value) - totAmount);
                hfLandUsePermitFinancialsBalance.Value = (DataUtils.GetDecimal(hfTotalDevPayments.Value) - totAmount).ToString();
            }
            else
            {
                dvNewlandUsePermitFinancials.Visible = false;

                dvLandUsePermitFinancialsGrid.Visible = false;
                gvLandUsePermitFinancials.DataSource = null;
                gvLandUsePermitFinancials.DataBind();
            }
        }

        protected void gvDeveloperPayments_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDeveloperPayments.EditIndex = e.NewEditIndex;
            BindDeveloperPaymentsGrid();
        }

        protected void gvDeveloperPayments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDeveloperPayments.EditIndex = -1;
            BindDeveloperPaymentsGrid();
            ClearDeveloperPaymentsForm();
        }

        protected void gvDeveloperPayments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlMjrDispositionE = (e.Row.FindControl("ddlMjrDispositionE") as DropDownList);
                    TextBox txtLkConsMajAmend = (e.Row.FindControl("txtLkConsMajAmend") as TextBox);

                    if (txtLkConsMajAmend != null)
                    {
                        BindLookUP(ddlMjrDispositionE, 68);

                        string itemToCompare = string.Empty;
                        foreach (ListItem item in ddlMjrDispositionE.Items)
                        {
                            itemToCompare = item.Value.ToString();
                            if (txtLkConsMajAmend.Text.ToLower() == itemToCompare.ToLower())
                            {
                                ddlMjrDispositionE.ClearSelection();
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }

        protected void btnAddDevPayments_Click(object sender, EventArgs e)
        {
            ConservationAct250Result objConservationAct250Result = ConservationAct250Data.AddAct250DevPay(DataUtils.GetInt(hfAct250FarmID.Value),
                DataUtils.GetDecimal(Regex.Replace(txtDevPaymentAmount.Text, "[^0-9a-zA-Z.]+", "")),
                DataUtils.GetDate(txtDevPaymentReceived.Text));

            ClearDeveloperPaymentsForm();
            BindDeveloperPaymentsGrid();

            if (objConservationAct250Result.IsDuplicate && !objConservationAct250Result.IsActive)
                LogMessage("Developer Payment already exist as in-active");
            else if (objConservationAct250Result.IsDuplicate)
                LogMessage("Developer Payment already exist");
            else
                LogMessage("Developer Payment Added Successfully");
        }

        private void ClearDeveloperPaymentsForm()
        {
            cbAddDeveloperPayment.Checked = false;
            txtDevPaymentAmount.Text = "";
            txtDevPaymentReceived.Text = "";
        }

        protected void gvDeveloperPayments_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int Act250PayID = DataUtils.GetInt(((Label)gvDeveloperPayments.Rows[rowIndex].FindControl("lblAct250PayID")).Text);
            decimal PaymentAmount = DataUtils.GetDecimal(Regex.Replace(((TextBox)gvDeveloperPayments.Rows[rowIndex].FindControl("txtpaymentAmount")).Text, "[^0-9a-zA-Z.]+", ""));
            DateTime PayReceivedDate = DataUtils.GetDate(((TextBox)gvDeveloperPayments.Rows[rowIndex].FindControl("txtDevPayReceived")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvDeveloperPayments.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAct250Data.UpdateAct250DevPay(Act250PayID, PaymentAmount, PayReceivedDate, RowIsActive);

            gvDeveloperPayments.EditIndex = -1;

            BindDeveloperPaymentsGrid();

            LogMessage("Developer Payment updated successfully");
        }

        protected void btnAddVHCBProject_Click(object sender, EventArgs e)
        {
            ConservationAct250Result objConservationAct250Result = ConservationAct250Data.AddAct250Projects(DataUtils.GetInt(hfAct250FarmID.Value),
                GetProjectID(txtPotentialProjNum.Text), DataUtils.GetInt(ddlConservationTown.SelectedValue.ToString()),
                DataUtils.GetDecimal(Regex.Replace(txtAntFunds.Text, "[^0-9a-zA-Z.]+", "")));

            ClearVHCBProjectsForm();
            BindVHCBProjectsGrid();

            if (objConservationAct250Result.IsDuplicate && !objConservationAct250Result.IsActive)
                LogMessage("Potential VHCB Project already exist as in-active");
            else if (objConservationAct250Result.IsDuplicate)
                LogMessage("Potential VHCB Project already exist");
            else
                LogMessage("Potential VHCB Project Added Successfully");

            cbAddVHCBProjects.Checked = false;
        }

        private void BindVHCBProjectsGrid()
        {
            try
            {
                DataTable dt = ConservationAct250Data.GetAct250ProjectsList(DataUtils.GetInt(hfAct250FarmID.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvVHCBProjectsgrid.Visible = true;
                    gvVHCBProjects.DataSource = dt;
                    gvVHCBProjects.DataBind();

                    Label lblFooterAnticipatedFunds = (Label)gvVHCBProjects.FooterRow.FindControl("lblFooterAnticipatedFunds");
                    decimal totAnticipatedFunds = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (DataUtils.GetBool(dt.Rows[i]["RowIsActive"].ToString()))
                            totAnticipatedFunds += DataUtils.GetDecimal(dt.Rows[i]["AmtFunds"].ToString());
                    }

                    lblFooterAnticipatedFunds.Text = CommonHelper.myDollarFormat(totAnticipatedFunds);

                    hfProjectsWarning.Value = "0";

                    if (totAnticipatedFunds > DataUtils.GetDecimal(hfLandUsePermitFinancialsBalance.Value))
                    {
                        hfProjectsWarning.Value = "1";
                        WarningMessage(dvVHCBProjectsWarning, lblVHCBProjectsWarning, "Total of Anticpated funds cannot be greater than "
                            + CommonHelper.myDollarFormat(hfLandUsePermitFinancialsBalance.Value));
                    }
                    else
                    {
                        dvVHCBProjectsWarning.Visible = false;
                        lblVHCBProjectsWarning.Text = "";
                    }
                }
                else
                {
                    dvVHCBProjectsgrid.Visible = false;
                    gvVHCBProjects.DataSource = null;
                    gvVHCBProjects.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindVHCBProjectsGrid", "", ex.Message);
            }
        }

        private void ShowWarnings()
        {
            if (hfProjectsWarning.Value != "1")
            {
                dvVHCBProjectsWarning.Visible = false;
                lblVHCBProjectsWarning.Text = "";
            }
        }

        private void WarningMessage(HtmlGenericControl div, Label label, string message)
        {
            div.Visible = true;
            label.Text = message;
        }

        private void ClearVHCBProjectsForm()
        {
            //ddlProjects.SelectedIndex = -1;
            ddlConservationTown.SelectedIndex = -1;
            txtAntFunds.Text = "";
            //txtDateClosed.Text = "";
        }

        protected void gvVHCBProjects_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvVHCBProjects.EditIndex = e.NewEditIndex;
            BindVHCBProjectsGrid();
        }

        protected void gvVHCBProjects_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvVHCBProjects.EditIndex = -1;
            BindVHCBProjectsGrid();
        }

        protected void gvVHCBProjects_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;

            int Act250ProjectID = DataUtils.GetInt(((Label)gvVHCBProjects.Rows[rowIndex].FindControl("lblAct250ProjectID")).Text);
            decimal AnticipatedFunds = DataUtils.GetDecimal(Regex.Replace(((TextBox)gvVHCBProjects.Rows[rowIndex].FindControl("txtAnticipatedFunds1")).Text, "[^0-9a-zA-Z.]+", ""));

            //DateTime ProjectDateClosed = DataUtils.GetDate(((TextBox)gvVHCBProjects.Rows[rowIndex].FindControl("txtProjectDateClosed")).Text);
            bool RowIsActive = Convert.ToBoolean(((CheckBox)gvVHCBProjects.Rows[rowIndex].FindControl("chkActive")).Checked); ;

            ConservationAct250Data.UpdateAct250Projects(Act250ProjectID, AnticipatedFunds, RowIsActive);

            gvVHCBProjects.EditIndex = -1;

            BindVHCBProjectsGrid();

            LogMessage("Potential VHCB Project updated successfully");
        }

        //protected void ddlProjects_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    LoadConservationTown(ddlProjects.SelectedValue.ToString());
        //}

        private int GetProjectID(string ProjectNum)
        {
            return ProjectMaintenanceData.GetProjectId(ProjectNum);
        }

        private void LoadConservationTown(string ProjectId)
        {
            try
            {
                DataTable dt = ConservationAct250Data.GetConservationTownList(GetProjectID(txtPotentialProjNum.Text));
                ddlConservationTown.Items.Clear();
                ddlConservationTown.DataSource = dt;
                ddlConservationTown.DataValueField = "TypeID";
                ddlConservationTown.DataTextField = "town";
                ddlConservationTown.DataBind();

                if (dt.Rows.Count > 1)
                    ddlConservationTown.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "LoadConservationTown", "", ex.Message);
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumber(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbers(prefixText);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        private void HandleCustomPostbackEvent(string ctrlName, string args)
        {
            if (ctrlName == txtPotentialProjNum.UniqueID && args == "OnBlur")
            {
                LoadConservationTown(GetProjectID(txtPotentialProjNum.Text).ToString());
            }
        }
    }
}