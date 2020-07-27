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
    public partial class EntityNotes : System.Web.UI.Page
    {
        string Pagename = "EntityNotes";
        string EntityId;
        protected void Page_Load(object sender, EventArgs e)
        {
            dvMessage.Visible = false;
            lblErrorMsg1.Text = "";

            EntityId = Request.QueryString["EntityId"];

            if (!IsPostBack)
            {
                BindControls();
                CurrentDate.InnerHtml = DateTime.Now.ToShortDateString();
                dvProjectNotesGrid.Visible = false;

                if (!string.IsNullOrWhiteSpace(EntityId) && DataUtils.GetInt(EntityId) != 0)
                {
                    DataRow dr = EntityNotesData.GetApplicantNameByApplicantId(DataUtils.GetInt(EntityId));

                    lblEntiryNotes.Text = "Entity Notes: " + dr["Applicantname"].ToString();
                    BindProjectNotesGrid();
                }
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
        private void BindControls()
        {
            BindLookUP(ddlCategory, 2281);
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
            BindProjectNotesGrid();
        }

        private void BindProjectNotesGrid()
        {
            DataTable dt = EntityNotesData.GetEntityNotesList(DataUtils.GetInt(EntityId), cbActiveOnly.Checked);

            if (dt.Rows.Count > 0)
            {
                dvProjectNotesGrid.Visible = true;
                gvProjectNotes.DataSource = dt;
                gvProjectNotes.DataBind();
            }
            else
            {
                dvProjectNotesGrid.Visible = false;
                gvProjectNotes.DataSource = null;
                gvProjectNotes.DataBind();
            }

        }

        protected void btnSubmitNotes_Click(object sender, EventArgs e)
        {
            if (IsProjectNotesValid(btnSubmitNotes.Text.ToLower()))
            {
                string URL = txtURL.Text;

                if (!URL.Contains("http") && !URL.Contains("fda"))
                    URL = "http://" + URL;

                if (btnSubmitNotes.Text.ToLower() == "submit")
                {
                    EntityNotesData.AddEntityNotes(DataUtils.GetInt(EntityId), DataUtils.GetInt(ddlCategory.SelectedValue.ToString()),
                        Context.User.Identity.GetUserName().Trim(), txtNotes.Text, URL);
                }
                else
                {
                    EntityNotesData.UpdateEntityNotes(DataUtils.GetInt(hfEntityNotesId.Value), 
                        DataUtils.GetInt(ddlCategory.SelectedValue.ToString()), txtNotes.Text, URL, cbActive.Checked);
                    hfEntityNotesId.Value = "";
                    gvProjectNotes.EditIndex = -1;

                    btnSubmitNotes.Text = "Submit";
                }

                ddlCategory.SelectedIndex = -1;
                txtNotes.Text = "";
                txtURL.Text = "";
                BindProjectNotesGrid();
            }
        }

        private bool IsProjectNotesValid(string Action)
        {
            if (txtNotes.Text.Trim() == "")
            {
                LogMessage("Enter Notes");
                txtNotes.Focus();
                return false;
            }

            return true;
        }

        private void ClearForm()
        {
            ddlCategory.SelectedIndex = -1;
            txtNotes.Text = "";
            txtURL.Text = "";
        }

        protected void gvProjectNotes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            btnSubmitNotes.Text = "Submit";

            ddlCategory.SelectedIndex = -1;
            txtNotes.Text = "";
            txtURL.Text = "";
            hfEntityNotesId.Value = "";

            gvProjectNotes.EditIndex = -1;
            BindProjectNotesGrid();
        }

        protected void gvProjectNotes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjectNotes.EditIndex = e.NewEditIndex;
            BindProjectNotesGrid();
        }

        protected void gvProjectNotes_RowDataBound(object sender, GridViewRowEventArgs e)
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
                        //e.Row.Cells[5].Controls[0].Visible = false;
                        btnSubmitNotes.Text = "Update";

                        Label lblEntityNotesID = e.Row.FindControl("lblEntityNotesID") as Label;
                        DataRow dr = EntityNotesData.GetProjectNotesById(DataUtils.GetInt(lblEntityNotesID.Text));

                        hfEntityNotesId.Value = lblEntityNotesID.Text;
                        txtNotes.Text = dr["Notes"].ToString();
                        txtURL.Text = dr["URL"].ToString();
                        ddlCategory.SelectedValue = dr["LKProjCategory"].ToString();
                        cbActive.Checked = DataUtils.GetBool(dr["RowIsActive"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(Pagename, "gvProjectNotes_RowDataBound", "", ex.Message);
            }
        }

        protected void gvProjectNotes_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

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

        private void LogMessage(string message)
        {
            dvMessage.Visible = true;
            lblErrorMsg1.Text = message;
        }
    }
}