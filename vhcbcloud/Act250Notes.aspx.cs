using DataAccessLayer;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class Act250Notes : System.Web.UI.Page
    {
        string Pagename = "Act250Notes";

       /// <summary>
       /// Page Load Event
       /// Loading All dropdowns and required Grid's
       /// </summary>
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindControls();
                txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
                dvProjectNotesGrid.Visible = false;
                BindAct250NotesGrid();
            }
        }

        /// <summary>
        /// Loading Category Lookup drodown
        /// Loading LandUsePermitNum dropdown
        /// </summary>
        private void BindControls()
        {
            LoadLandUsePermitNum();
            BindLookUP(ddlCategory, 254);
        }
        /// <summary>
        /// Loading LandUsePermitNum dropdown
        /// </summary>
        private void LoadLandUsePermitNum()
        {
            try
            {
                DataTable dtable = new DataTable();
                dtable = FinancialTransactions.GetAllLandUsePermitList();
                ddlLandUsePermitNum.DataSource = dtable;
                ddlLandUsePermitNum.DataValueField = "Act250FarmId";
                ddlLandUsePermitNum.DataTextField = "UsePermit";
                ddlLandUsePermitNum.DataBind();
                if (ddlLandUsePermitNum.Items.Count > 1)
                    ddlLandUsePermitNum.Items.Insert(0, new ListItem("Select", "NA"));
            }
            catch (Exception ex)
            {
                LogError(Pagename, "LoadLandUsePermitNum", "", ex.Message);
            }
        }
        /// <summary>
        /// Lookup data loading into dropdown
        /// </summary>
        /// <param name="ddList"></param>
        /// <param name="LookupType"></param>
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
        /// <summary>
        /// Logging Error message on UI
        /// </summary>
        /// <param name="pagename"></param>
        /// <param name="method"></param>
        /// <param name="message"></param>
        /// <param name="error"></param>
        private void LogError(string pagename, string method, string message, string error)
        {
            dvMessage.Visible = true;
            if (message == "")
            {
                lblErrorMsg1.Text = Pagename + ": " + method + ": Error Message: " + error;
            }
            else
                lblErrorMsg1.Text = Pagename + ": " + method + ": Message :" + message + ": Error Message: " + error;
        }
        /// <summary>
        /// Logging Error message on UI
        /// </summary>
        /// <param name="message"></param>
        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg1.Text = message;
        }

        protected void cbActiveOnly_CheckedChanged(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// Inserting or Updating the Notes details. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSubmitNotes_Click(object sender, EventArgs e)
        {
            if (IsProjectNotesValid(btnSubmitNotes.Text.ToLower()))
            {
                string URL = txtURL.Text;

                if (!URL.Contains("http") && !URL.Contains("fda"))
                    URL = "http://" + URL;

                if (btnSubmitNotes.Text.ToLower() == "submit")
                {
                    ProjectNotesData.AddAct250Notes(ddlLandUsePermitNum.SelectedItem.ToString(), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()),
                        Context.User.Identity.GetUserName().Trim(), txtNotes.Text, DataUtils.GetDate(txtProjectNotesDate.Text), URL);
                }
                else
                {
                    ProjectNotesData.UpdateAct250Notes(DataUtils.GetInt(hfAct250NotesID.Value), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()),
                        txtNotes.Text, URL, cbActive.Checked);
                    hfAct250NotesID.Value = "";
                    gvAct250Notes.EditIndex = -1;

                    btnSubmitNotes.Text = "Submit";
                }

                ddlCategory.SelectedIndex = -1;
                txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
                txtNotes.Text = "";
                txtURL.Text = "";
                BindAct250NotesGrid();
            }
        }
        /// <summary>
        /// Loading the Notes Grid
        /// </summary>
        private void BindAct250NotesGrid()
        {
            DataTable dt = ProjectNotesData.GetAct250NotesList(cbActiveOnly.Checked);

            if (dt.Rows.Count > 0)
            {
                dvProjectNotesGrid.Visible = true;
                gvAct250Notes.DataSource = dt;
                gvAct250Notes.DataBind();
            }
            else
            {
                dvProjectNotesGrid.Visible = false;
                gvAct250Notes.DataSource = null;
                gvAct250Notes.DataBind();
            }

        }

        /// <summary>
        /// Notes details validation
        /// </summary>
        /// <param name="Action"></param>
        /// <returns></returns>
        private bool IsProjectNotesValid(string Action)
        {
            if (ddlLandUsePermitNum.SelectedIndex == 0)
            {
                LogMessage("Select Land Use Permit#");
                ddlLandUsePermitNum.Focus();
                return false;
            }

            if (ddlCategory.SelectedIndex == 0)
            {
                LogMessage("Select Category");
                ddlCategory.Focus();
                return false;
            }

            if (Action == "submit")
            {
                //if (txtProjectNotesDate.Text.Trim() == "")
                //{
                //    LogMessage("Enter Date");
                //    txtProjectNotesDate.Focus();
                //    return false;
                //}
                //else
                //{
                //    if (!DataUtils.IsDateTime(txtProjectNotesDate.Text.Trim()))
                //    {
                //        LogMessage("Enter valid Date");
                //        txtProjectNotesDate.Focus();
                //        return false;
                //    }
                //    if (DataUtils.GetDate(txtProjectNotesDate.Text.Trim()) < DataUtils.GetDate(DateTime.Now.ToShortDateString()))
                //    {
                //        LogMessage("Date shouldn't be less than current date");
                //        txtProjectNotesDate.Focus();
                //        return false;
                //    }
                //}
            }
            if (txtNotes.Text.Trim() == "")
            {
                LogMessage("Enter Notes");
                txtNotes.Focus();
                return false;
            }

            return true;
        }
        /// <summary>
        /// Notes Grid editing and after edit loading the Grid
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvAct250Notes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAct250Notes.EditIndex = e.NewEditIndex;
            BindAct250NotesGrid();
        }

        protected void gvAct250Notes_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }
        /// <summary>
        /// Notes grid data bound i.e when edit enabling the fields and load data
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvAct250Notes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Label lblUserName = (Label)e.Row.FindControl("lbluserName");

                    if (lblUserName.Text.ToLower().Trim() != Context.User.Identity.GetUserName().Trim())
                    {
                        LinkButton lnkEdit = (LinkButton)e.Row.FindControl("lnkEdit");
                        lnkEdit.Visible = false;
                    }
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);

                    //Checking whether the Row is Data Row
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        //ddlProject.Enabled = false;
                       
                        txtProjectNotesDate.Enabled = false;

                        //e.Row.Cells[5].Controls[0].Visible = false;
                        btnSubmitNotes.Text = "Update";

                        Label lblProjectNotesID = e.Row.FindControl("lblAct250NotesID") as Label;
                        DataRow dr = ProjectNotesData.GetProjectNotesById(DataUtils.GetInt(lblProjectNotesID.Text));

                        hfAct250NotesID.Value = lblProjectNotesID.Text;

                        txtProjectNotesDate.Text = dr["Date"].ToString() == "" ? "" : Convert.ToDateTime(dr["Date"].ToString()).ToShortDateString();
                        txtNotes.Text = dr["Notes"].ToString();
                        txtURL.Text = dr["URL"].ToString();
                        ddlCategory.SelectedValue = dr["LKProjCategory"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                        ddlLandUsePermitNum.SelectedValue = dr["UsePermit"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvAddress_RowDataBound", "", ex.Message);
            }
        }
        /// <summary>
        /// Canceling the Notes form
        /// clearing the fields.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvAct250Notes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ddlLandUsePermitNum.SelectedIndex = -1;
            txtProjectNotesDate.Enabled = true;
            btnSubmitNotes.Text = "Submit";

            ddlCategory.SelectedIndex = -1;
            txtProjectNotesDate.Text = DateTime.Now.ToShortDateString();
            txtNotes.Text = "";
            txtURL.Text = "";
            hfAct250NotesID.Value = "";

            gvAct250Notes.EditIndex = -1;
            BindAct250NotesGrid();
        }
    }
}