using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;
using System.Data;

namespace vhcbcloud
{
    public partial class Applicant : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindApplicants();
            }
        }

        protected void rdBtnIndividual_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlappl.Visible=true;
            if (rdBtnIndividual.SelectedItem.Text == "Yes")
            {
                tblIndividual.Visible = true;
                tblCorporate.Visible = false;
            }
            else
            {
                tblIndividual.Visible = false;
                tblCorporate.Visible = true;
            }
        }

        protected void BindApplicants()
        {
            try
            {
                if (Session["SortExp"] == null)
                {
                    gvApplicant.DataSource = ApplicantData.GetApplicants();
                    gvApplicant.DataBind();
                }
                else
                {
                    DataTable table = ApplicantData.GetApplicants();
                    DataView view = table.DefaultView;
                    view.Sort = Session["SortExp"].ToString();
                    gvApplicant.DataSource = view.ToTable();
                    gvApplicant.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void gvApplicant_RowEditing(object sender, GridViewEditEventArgs e)
        {          
            gvApplicant.EditIndex = e.NewEditIndex;
            BindApplicants();
        }

        protected void gvApplicant_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvApplicant.EditIndex = -1;
            BindApplicants();
        }

        protected void gvApplicant_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int ApplId = Convert.ToInt32(((Label)gvApplicant.Rows[rowIndex].FindControl("lblApplId")).Text);
                string applName = ((TextBox)gvApplicant.Rows[rowIndex].FindControl("txtApplName")).Text;
                ApplicantData.UpdateApplicantName(ApplId, applName);
                gvApplicant.EditIndex = -1;
                BindApplicants();
                lblErrorMsg.Text = "Applicant updated successfully";
                txtApplicantName.Text = "";
                txtFName.Text = "";
                txtLName.Text = "";
                pnlappl.Visible = false;
            }
            catch (Exception)
            {
                lblErrorMsg.Text = "Error updating the project name";
                lblErrorMsg.Visible = true;
            }
        }

        //protected void gvApplicant_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    if (gvApplicant.EditIndex != -1)
        //    {
        //        // Use the Cancel property to cancel the paging operation.
        //        e.Cancel = true;

        //        // Display an error message.
        //        int newPageNumber = e.NewPageIndex + 1;
        //        lblErrorMsg.Text = "Please update the record before moving to page " +
        //          newPageNumber.ToString() + ".";
        //    }
        //    else
        //    {
        //        // Clear the error message.
        //        lblErrorMsg.Text = "";
        //        gvApplicant.PageIndex = e.NewPageIndex;
        //        BindGridWithSort();
        //    }
        //}

        //protected void BindGridWithSort ()
        //{
        //   DataTable dt = ApplicantData.GetApplicants();
        //   SortDireaction = CommonHelper.GridSorting(gvApplicant, dt, SortExpression, SortDireaction != "" ? ViewState["SortDireaction"].ToString() : SortDireaction);
        //}

        protected void gvApplicant_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                CommonHelper.GridViewSetFocus(e.Row);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (rdBtnPayee.SelectedIndex < 0)
                {
                    lblErrorMsg.Text = "Select payee or not.";
                    rdBtnPayee.Focus();
                    return;
                }
                if (rdBtnIndividual.SelectedIndex < 0)
                {
                    lblErrorMsg.Text = "Select individual or not.";
                    rdBtnIndividual.Focus();
                    return;
                }

                bool isPayee = rdBtnPayee.SelectedItem.Text == "Yes" ? true : false;
                bool isIndividual = rdBtnIndividual.SelectedItem.Text == "Yes" ? true : false;
                if (isIndividual)
                    ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, txtLName.Text + ", " + txtFName.Text, isPayee, isIndividual);
                else
                    ApplicantData.AddNewApplicant(txtFName.Text, txtLName.Text, txtApplicantName.Text, isPayee, isIndividual);

                lblErrorMsg.Text = "Applicant added successfully";
                txtApplicantName.Text = "";
                txtFName.Text = "";
                txtLName.Text = "";
                pnlappl.Visible = false;
                gvApplicant.PageIndex = 0;
                BindApplicants();

                rdBtnIndividual.ClearSelection();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        #region GridView Sorting Functions
        protected void gvApplicant_Sorting(object sender, GridViewSortEventArgs e)
        {

            GridViewSortExpression = e.SortExpression;
            int pageIndex = 0;
            gvApplicant.DataSource = SortDataTable(ApplicantData.GetApplicants(), false);
            gvApplicant.DataBind();
            gvApplicant.PageIndex = pageIndex;
        }

        //======================================== GRIDVIEW EventHandlers END

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

        //===========================SORTING PROPERTIES START
        private string GridViewSortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

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

        //===========================SORTING PROPERTIES END
        #endregion
    }
}