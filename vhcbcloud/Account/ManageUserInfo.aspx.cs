using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud.Account
{
    public partial class ManageUserInfo : System.Web.UI.Page
    {
        private int SECURITY_PAGE = 193;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserInfo();
                BindVHCBProgram();
                BindSecurityGroups();
                BindDDLPage();
                BindLookUP(ddlSecFunctions, 246);

                string[] Dashboards = Directory.GetFiles("C:\\exago\\Reports\\Dashboard", "*.*")
                                     .Select(Path.GetFileName)
                                     .ToArray();
                for (int i = 0; i < Dashboards.Length; i++)
                {
                    ddlDashBoard.Items.Insert(i, new ListItem(Dashboards[i], Dashboards[i]));
                }
            }
        }

        protected void BindVHCBProgram()
        {
            try
            {
                DataTable table = AccountData.GetVHCBProgram();
                ddlVHCBProgram.DataSource = table;
                ddlVHCBProgram.DataValueField = "typeid";
                ddlVHCBProgram.DataTextField = "Description";
                ddlVHCBProgram.DataBind();
                ddlVHCBProgram.Items.Insert(0, new ListItem("Select", "NA"));

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindUserInfo()
        {
            try
            {
                if (Session["SortExp"] == null)
                {
                    gvUserInfo.DataSource = AccountData.GetUserInfo(cbActiveOnly.Checked);
                    gvUserInfo.DataBind();
                }
                else
                {
                    DataTable table = AccountData.GetUserInfo(cbActiveOnly.Checked);
                    DataView view = table.DefaultView;
                    view.Sort = Session["SortExp"].ToString();
                    gvUserInfo.DataSource = view.ToTable();
                    gvUserInfo.DataBind();
                }
                pnlHide.Visible = false;
                pnlSecFunctions.Visible = false;
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void BindDDLPage()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetPageSecurityBySelection(SECURITY_PAGE);
                ddlPage.DataValueField = "typeid";
                ddlPage.DataTextField = "description";
                ddlPage.DataSource = dt;
                ddlPage.DataBind();
                ddlPage.Items.Insert(0, new ListItem("Select", "NA"));

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
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void ClearFields()
        {
            txtFname.Text = "";
            txtLname.Text = "";
            txtPassword.Text = "";
            txtCPassword.Text = "";
            txt1Email.Text = "";
            ddlVHCBProgram.SelectedIndex = -1;
            ddlSecurityGroup.SelectedIndex = -1;
            btnUserInfoSubmit.Text = "Submit";
            cbAddUser.Checked = false;
            ddlDashBoard.SelectedIndex = -1;
            spnPrimaryApplicant.Visible = false;
            spnProjectNum.Visible = false;
            txtPrimaryApplicant.Visible = false;
            txtProjectNum.Visible = false;

            txtPrimaryApplicant.Text = "";
            txtProjectNum.Text = "";
            chkActive.Checked = true;
            cbDashBoard.Checked = false;

        }

        protected void btnUserInfoSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int dfltPrg = 0, dfltSecGrp = 0;

                if (ddlVHCBProgram.SelectedIndex != 0)
                    dfltPrg = Convert.ToInt32(ddlVHCBProgram.SelectedValue.ToString());

                if (ddlSecurityGroup.SelectedIndex == 0)
                {
                    lblErrorMsg.Text = "Please select security group";
                    return;
                }
                dfltSecGrp = Convert.ToInt32(ddlSecurityGroup.SelectedValue.ToString());

                if (btnUserInfoSubmit.Text.ToLower() == "submit")
                {
                    AccountData.AddUserInfo(txtFname.Text, txtLname.Text, txtPassword.Text, txt1Email.Text, dfltPrg, dfltSecGrp, txtProjectNum.Text, txtPrimaryApplicant.Text, cbDashBoard.Checked, ddlDashBoard.SelectedValue.ToString());
                    BindUserInfo();
                    ClearFields();
                    lblErrorMsg.Text = "User Information added successfully";
                }
                else
                {
                    AccountData.UpdateUserInfo(DataUtils.GetInt(hfUserId.Value), txtFname.Text, txtLname.Text, txtPassword.Text, txt1Email.Text, dfltPrg, dfltSecGrp, txtProjectNum.Text, txtPrimaryApplicant.Text, chkActive.Checked, cbDashBoard.Checked, ddlDashBoard.SelectedValue.ToString());

                    gvUserInfo.EditIndex = -1;
                    BindUserInfo();
                    ClearFields();
                    lblErrorMsg.Text = "User information updated successfully.";
                }

            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }

        }

        protected void gvUserInfo_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUserInfo.EditIndex = -1;
            ClearFields();
            BindUserInfo();
        }

        protected void gvUserInfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gvUserInfo_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUserInfo.EditIndex = e.NewEditIndex;
            BindUserInfo();
        }

        protected void gvUserInfo_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;

                int UserlId = Convert.ToInt32(((Label)gvUserInfo.Rows[rowIndex].FindControl("lblUserId")).Text);

                string strFirstName = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtFirstName")).Text.Trim();
                string strLastName = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtLastName")).Text.Trim();
                string strEmail = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtEmail")).Text.Trim();
                string strPassword = ((TextBox)gvUserInfo.Rows[rowIndex].FindControl("txtPassword")).Text.Trim();
                int dfltPgr = ((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditVhcbPrg")).SelectedIndex != 0 ? Convert.ToInt32(((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditVhcbPrg")).SelectedValue.ToString()) : 0;
                int dflSecGrp = ((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditSecGroup")).SelectedIndex != 0 ? Convert.ToInt32(((DropDownList)gvUserInfo.Rows[rowIndex].FindControl("ddlEditSecGroup")).SelectedValue.ToString()) : 0;

                AccountData.UpdateUserInfo(UserlId, strFirstName, strLastName, strPassword, strEmail, dfltPgr, dflSecGrp, "", "", chkActive.Checked, cbDashBoard.Checked, ddlDashBoard.SelectedValue.ToString());

                gvUserInfo.EditIndex = -1;
                BindUserInfo();
                lblErrorMsg.Text = "User information updated successfully.";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvUserInfo_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;
            gvUserInfo.DataSource = SortDataTable(AccountData.GetUserInfo(cbActiveOnly.Checked), false);
            gvUserInfo.DataBind();
            gvUserInfo.PageIndex = pageIndex;
        }

        protected void gvUserInfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                CommonHelper.GridViewSetFocus(e.Row);
                btnUserInfoSubmit.Text = "Update";
                cbAddUser.Checked = true;

                //Checking whether the Row is Data Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[6].Controls[0].Visible = false;

                    HiddenField hfUserId1 = (e.Row.FindControl("HiddenField1") as HiddenField);
                    hfUserId.Value = hfUserId1.Value;
                    DataRow dr = AccountData.GetUserInfoById(DataUtils.GetInt(hfUserId.Value));

                    txtFname.Text = dr["Fname"].ToString();
                    txtLname.Text = dr["Lname"].ToString();
                    txt1Email.Text = dr["email"].ToString();
                    txtPassword.Text = dr["password"].ToString();
                    txtCPassword.Text = dr["password"].ToString();
                    PopulateDropDown(ddlVHCBProgram, dr["DfltPrg"].ToString());
                    PopulateDropDown(ddlSecurityGroup, dr["securityLevel"].ToString());
                    chkActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                    cbDashBoard.Checked = DataUtils.GetBool(dr["Dashboard"].ToString());
                    PopulateDropDown(ddlDashBoard, dr["DashboardName"].ToString());

                    if (ddlSecurityGroup.SelectedItem.ToString() == "Americorps Member")
                    {
                        spnPrimaryApplicant.Visible = true;
                        spnProjectNum.Visible = true;
                        txtPrimaryApplicant.Visible = true;
                        txtProjectNum.Visible = true;
                    }
                    else
                    {
                        spnPrimaryApplicant.Visible = false;
                        spnProjectNum.Visible = false;
                        txtPrimaryApplicant.Visible = false;
                        txtProjectNum.Visible = false;
                    }

                    txtProjectNum.Text = dr["ProjeNumber"].ToString();
                    txtPrimaryApplicant.Text = dr["ApplicantName"].ToString();
                }
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

        protected void rdBtnSelectDetail_CheckedChanged(object sender, EventArgs e)
        {
            GetSelectedUserId(gvUserInfo);
            ShowRemainingGrids();
        }

        private void ShowRemainingGrids()
        {
            BindUserPageSecurity();
            pnlHide.Visible = true;
            BindUserFxnSecurity();
            pnlSecFunctions.Visible = true;
        }

        protected DataView SortDataTable(DataTable dataTable, bool isPageIndexChanging)
        {

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (GridViewSortExpression != string.Empty)
                {
                    if (isPageIndexChanging)
                    {
                        Session["SortExp"] = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
                        dataView.Sort = Session["SortExp"].ToString();
                    }
                    else
                    {
                        Session["SortExp"] = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());
                        dataView.Sort = Session["SortExp"].ToString();
                    }
                }
                return dataView;
            }
            else
            {
                return new DataView();
            }
        } //eof SortDataTable

        private string GridViewSortExpression
        {
            get { return ViewState["SortExpression"] as string ?? string.Empty; }
            set { ViewState["SortExpression"] = value; }
        }

        private string GetSortDirection()
        {
            switch (GridViewSortDirection)
            {
                case "ASC":
                    GridViewSortDirection = "DESC";
                    break;

                case "DESC":
                    GridViewSortDirection = "ASC";
                    break;
            }

            return GridViewSortDirection;
        }

        private string GridViewSortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        private void BindSecurityGroups()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetData("GetUserSecurityGroup");
                ddlSecurityGroup.DataSource = dt;
                ddlSecurityGroup.DataValueField = "usergroupid";
                ddlSecurityGroup.DataTextField = "userGroupName";
                ddlSecurityGroup.DataBind();
                ddlSecurityGroup.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void ddlSecurityGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            spnPrimaryApplicant.Visible = false;
            spnProjectNum.Visible = false;
            txtPrimaryApplicant.Visible = false;
            txtProjectNum.Visible = false;

            if (ddlSecurityGroup.SelectedItem.ToString() == "Americorps Member")
            {
                spnPrimaryApplicant.Visible = true;
                spnProjectNum.Visible = true;
                txtPrimaryApplicant.Visible = true;
                txtProjectNum.Visible = true;
            }
        }
        private void GetSelectedUserId(GridView gvFGM)
        {
            for (int i = 0; i < gvFGM.Rows.Count; i++)
            {
                RadioButton rbGInfo = (RadioButton)gvFGM.Rows[i].Cells[0].FindControl("rdBtnSelectDetail");
                if (rbGInfo != null)
                {
                    if (rbGInfo.Checked)
                    {
                        HiddenField hf = (HiddenField)gvFGM.Rows[i].Cells[0].FindControl("HiddenField1");
                        if (hf != null)
                        {
                            ViewState["SelectedTransId"] = hf.Value;
                            hfUserId.Value = hf.Value;
                        }
                        break;
                    }
                }
            }
        }
        private void BindUserPageSecurity()
        {
            if (hfUserId.Value != null)
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetuserPageSecurity(Convert.ToInt32(hfUserId.Value));
                gvPageSecurity.DataSource = dt;
                gvPageSecurity.DataBind();
            }
            else
            {
                gvPageSecurity.DataSource = null;
                gvPageSecurity.DataBind();
                lblErrorMsg.Text = "Select User to view the user page security permissions";
            }
        }
        protected void btnPageSecurity_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlPage.SelectedIndex <= 0)
                {
                    lblErrorMsg.Text = "Please select page to add an action";
                    return;
                }

                UserSecurityData.AddUserPageSecurity(Convert.ToInt32(hfUserId.Value), Convert.ToInt32(ddlPage.SelectedValue.ToString()));
                BindUserPageSecurity();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }


        protected void gvPageSecurity_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblpagesecurityid = (Label)gvPageSecurity.Rows[rowIndex].FindControl("lblpagesecurityid");
                if (lblpagesecurityid != null)
                {
                    UserSecurityData.DeletePageSecurity(Convert.ToInt32(lblpagesecurityid.Text));
                    lblErrorMsg.Text = "User Page Security was deleted successfully";
                    BindUserPageSecurity();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnSecFunctions_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlSecFunctions.SelectedIndex <= 0)
                {
                    lblErrorMsg.Text = "Please select security function to add an action";
                    return;
                }

                UserSecurityData.AddUserFxnSecurity(Convert.ToInt32(hfUserId.Value), Convert.ToInt32(ddlSecFunctions.SelectedValue.ToString()));
                BindUserFxnSecurity();
                ddlSecFunctions.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void BindUserFxnSecurity()
        {
            if (hfUserId.Value != null)
            {
                DataTable dt = new DataTable();
                dt = UserSecurityData.GetUserFxnSecurity(Convert.ToInt32(hfUserId.Value));
                gvSecFunctions.DataSource = dt;
                gvSecFunctions.DataBind();
            }
            else
            {
                gvSecFunctions.DataSource = null;
                gvSecFunctions.DataBind();
                lblErrorMsg.Text = "Select User to view the user security functions";
            }
        }

        protected void gvSecFunctions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                Label lblUserFxnSecurityId = (Label)gvSecFunctions.Rows[rowIndex].FindControl("lblUserFxnSecurityId");
                if (lblUserFxnSecurityId != null)
                {
                    UserSecurityData.DeleteUserFxnSecurity(Convert.ToInt32(lblUserFxnSecurityId.Text));
                    lblErrorMsg.Text = "User Security Function was deleted successfully";
                    BindUserFxnSecurity();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetProjectNumbersWithPrimaryApplicant(string prefixText, int count)
        {
            DataTable dt = new DataTable();
            dt = ProjectSearchData.GetProjectNumbersWithPrimaryApplicant(prefixText);//.Replace("_","").Replace("-", ""));

            List<string> ProjNumbers = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dt.Rows[i]["proj_num"].ToString(),
                   dt.Rows[i]["PrimaryApplicantName"].ToString());
                ProjNumbers.Add(str);

                //ProjNumbers.Add("'" + dt.Rows[i][0].ToString() + "'");
            }
            return ProjNumbers.ToArray();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string[] GetApplicants(string prefixText, int count)
        {
            DataTable dt = new DataTable();

            dt = EntityData.GetApplicantsEx("GetPrimaryApplicantsAutoEx", prefixText);

            List<string> Applicants = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Applicants.Add("'" + dt.Rows[i][1].ToString() + "'");
            }
            return Applicants.ToArray();

            //ddlPrimaryApplicant.DataValueField = "appnameid";
            //ddlPrimaryApplicant.DataTextField = "Applicantname";
            //ddlPrimaryApplicant.DataBind();
            //ddlPrimaryApplicant.Items.Insert(0, new ListItem("Select", "NA"));
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {
            BindUserInfo();
        }
    }
}