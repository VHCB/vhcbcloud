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
            if (Request.QueryString["ProjectId"] != null)
            {
                hfProjectId.Value = Request.QueryString["ProjectId"];
                ifProjectNotes.Src = "../ProjectNotes.aspx?ProjectId=" + Request.QueryString["ProjectId"];
            }

            GenerateTabs();

            if (!IsPostBack)
            {
                PopulateProjectDetails();

                BindControls();
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

        protected void gvAddressForm_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAddressForm.EditIndex = e.NewEditIndex;
            BindAddresses();
        }

        protected void gvAddressForm_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAddressForm.EditIndex = -1;
            BindAddresses();
            ClearAddressForm();
            //hfLeadUnitID.Value = "";
            btnAddAddress.Text = "Submit";
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

        protected void gvAddressForm_SelectedIndexChanged(object sender, EventArgs e)
        {

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

        private void BindGrids()
        {
            BindAddressGrid();
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
            //dvNewUnitInfo.Visible = false;

            try
            {
                DataTable dt = HomeOwnershipData.GetHomeOwnershipList(DataUtils.GetInt(hfProjectId.Value), cbActiveOnly.Checked);

                if (dt.Rows.Count > 0)
                {
                    dvAddressFormGrid.Visible = true;
                    gvAddressForm.DataSource = dt;
                    gvAddressForm.DataBind();
                }
                else
                {
                    dvAddressFormGrid.Visible = false;
                    gvAddressForm.DataSource = null;
                    gvAddressForm.DataBind();
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "BindBuildings", "", ex.Message);
            }
        }

        protected void rdBtnSelectAddress_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void gvAddressForm_RowDataBound(object sender, GridViewRowEventArgs e)
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
                        //e.Row.Cells[5].Controls[0].Visible = false;

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
                LogError(Pagename, "gvAddressForm_RowDataBound", "", ex.Message);
            }
        }
    }
}