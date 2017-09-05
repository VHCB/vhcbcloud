using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class QAManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindYearQuarterGrid(true);
            }
        }

        protected void gvYrQrtrDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                string YearQrtrId = ((HiddenField)gvYrQrtrDetails.Rows[rowIndex].FindControl("hdnYrQrtrId")).Value.Trim();
                if (YearQrtrId.ToString() != "")
                {
                    YearQuarterData.DeleteYearQuarterDetails(Convert.ToInt32(YearQrtrId));
                    BindYearQuarterGrid(true);
                    lblErrorMsg.Text = "Year/Quarter details was successfully deleted.";
                    txtYear.Text = string.Empty;
                    ddlQuarter.SelectedIndex = 0;
                    cbAddNew.Checked = false;
                    dvDataSetUp.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        //Bind Year Quarter Grid
        protected void BindYearQuarterGrid(bool isGrid)
        {
            DataTable dtable = default(DataTable);

            try
            {
                dtable = new DataTable();
                lblQuestionErrorMsg.Text = string.Empty;
                if (isGrid)
                {
                    dtable = YearQuarterData.GetAllYearQuarterDetails();
                    if (dtable.Rows.Count > 0)
                    {

                        pnlYrQrtrDetails.Visible = true;
                        gvYrQrtrDetails.DataSource = dtable;
                        gvYrQrtrDetails.DataBind();
                    }
                    else
                        pnlYrQrtrDetails.Visible = false;
                }
                else
                {
                    dtable = YearQuarterData.GetAllYearQuarterDetailsForImport();
                    if (dtable.Rows.Count > 0)
                    {
                        pnlDataSetupForm.Visible = true;
                        ddlYearQrtr.DataTextField = "YEARQTR";
                        ddlYearQrtr.DataValueField = "ACYrQtrID";
                        ddlYearQrtr.DataSource = dtable;
                        ddlYearQrtr.DataBind();
                     
                    }
                    else
                        pnlDataSetupForm.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                YearQrtrResult obYearQrtrResult = YearQuarterData.AddYearQuarter(DataUtils.GetInt(txtYear.Text.Trim()),
                DataUtils.GetInt(ddlQuarter.SelectedValue.ToString()));
                BindYearQuarterGrid(true);
                if (obYearQrtrResult.IsDuplicate)
                {
                    LogMessage("Year/Quarter details already exist.");
                    cbAddNew.Checked = false;
                }
                else
                    LogMessage("Year/Quarter details added successfully.");
                txtYear.Text = string.Empty;
                ddlQuarter.SelectedIndex = 0;
                cbAddNew.Checked = false;
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = ex.Message;
            }
        }

        private void LogMessage(string message)
        {
            //dvMessage.Visible = true;
            lblErrorMsg.Text = message;
        }

        protected void rdBtnSelect_CheckedChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            lblQuestionErrorMsg.Text = string.Empty;
            cbAddNewQuestion.Checked = false;
            pnlAQManagementForm.Visible = false;
            cbActive.Checked = true;
            gvQuestionAnswer.EditIndex = -1;
            BindQuestionAnswerGrid();
           
           
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            string YearQrtrId = default(string);
            try
            {
                for (int i = 0; i < gvYrQrtrDetails.Rows.Count; i++)
                {
                    RadioButton rb = (gvYrQrtrDetails.Rows[i].FindControl("rdBtnSelect") as RadioButton);
                    if (rb.Checked == true)
                    {
                        YearQrtrId = ((HiddenField)gvYrQrtrDetails.Rows[i].FindControl("hdnYrQrtrId")).Value.Trim();
                        break;
                    }
                }
                YearQuarterData.AddPerformanceMaster(Convert.ToInt32(ddlYearQrtr.SelectedValue.Trim()), Convert.ToInt32(YearQrtrId));
                BindQuestionAnswerGrid();
                lblQuestionErrorMsg.Text = "Question information imported successfully.";
            }
            catch (Exception ex)
            {
                lblQuestionErrorMsg.Text = ex.Message;
            }
        }

        protected void gvQuestionAnswer_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            lblQuestionErrorMsg.Text = string.Empty;
            gvQuestionAnswer.EditIndex = -1;
            pnlAQManagementForm.Visible = false;
            BindQuestionAnswerGrid();
        }

        protected void gvQuestionAnswer_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            lblQuestionErrorMsg.Text = string.Empty;
            gvQuestionAnswer.EditIndex = e.NewEditIndex;
            cbAddNewQuestion.Checked = false;
            btnQuestionDetails.Text = "Update";
            pnlAQManagementForm.Visible = true;
            BindQuestionAnswerGrid();
        }

        protected void gvQuestionAnswer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    CommonHelper.GridViewSetFocus(e.Row);
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        e.Row.Cells[5].Controls[0].Visible = false;
                        hfQuestionId.Value = (e.Row.FindControl("lblPerformanceMasterId") as Label).Text.Trim();
                        txtQuestionNum.Text = (e.Row.FindControl("lblQuestionNum") as Label).Text.Trim();
                        txtQuestionDesc.Text = (e.Row.FindControl("lblLabelDefinition") as Label).Text.Trim();
                        ddlResultType.ClearSelection();
                        ddlResultType.Items.FindByText((e.Row.FindControl("lblResulType") as Label).Text.Trim()).Selected = true;// (e.Row.FindControl("lblResulType") as Label).Text.Trim();
                        chkFormActive.Checked = (e.Row.FindControl("chkActive") as CheckBox).Checked;
                    }
                }
            }
            catch (Exception ex)
            {
                lblQuestionErrorMsg.Text = ex.Message;
            }
        }

        protected void BindQuestionAnswerGrid()
        {
            DataTable dtable = default(DataTable);
            string YearQrtrId = default(string);
            try
            {
               
                for (int i = 0; i < gvYrQrtrDetails.Rows.Count; i++)
                {
                    RadioButton rb = (gvYrQrtrDetails.Rows[i].FindControl("rdBtnSelect") as RadioButton);
                    if (rb.Checked == true)
                    {
                        YearQrtrId = ((HiddenField)gvYrQrtrDetails.Rows[i].FindControl("hdnYrQrtrId")).Value.Trim();
                        break;
                    }
                }

                dtable = new DataTable();
                dtable = YearQuarterData.GetQuestionAnswerList(Convert.ToInt32(YearQrtrId), cbActive.Checked);
                dvDataSetUp.Visible = true;
                if (dtable.Rows.Count > 0)
                {
                    pnlDataSetupForm.Visible = false;
                    pnlQuestionAnswerGrid.Visible = true;
                    cbActive.Enabled = true;
                    gvQuestionAnswer.DataSource = dtable;
                    gvQuestionAnswer.DataBind();
                    cbAddNewQuestion.Enabled = true;
                }
                else
                {
                    pnlDataSetupForm.Visible = true;
                    pnlQuestionAnswerGrid.Visible = false;
                    cbAddNewQuestion.Enabled = false;
                    BindYearQuarterGrid(false);
                    cbActive.Enabled = false;
                }
                    
                
            }
            catch (Exception ex)
            {
                lblQuestionErrorMsg.Text = ex.Message;
            }
        }

        protected void btnQuestionDetails_Click(object sender, EventArgs e)
        {
            try
            {
                int questionId= hfQuestionId.Value != string.Empty ? Convert.ToInt32(hfQuestionId.Value) : 0;
                string YearQrtrId = default(string);
                for (int i = 0; i < gvYrQrtrDetails.Rows.Count; i++)
                {
                    RadioButton rb = (gvYrQrtrDetails.Rows[i].FindControl("rdBtnSelect") as RadioButton);
                    if (rb.Checked == true)
                    {
                        YearQrtrId = ((HiddenField)gvYrQrtrDetails.Rows[i].FindControl("hdnYrQrtrId")).Value.Trim();
                        break;
                    }
                }
                YearQuarterData.UpdateQuestions(ACPerformanceMasterID: questionId, QuestionNum: DataUtils.GetInt(txtQuestionNum.Text.Trim()), Question: txtQuestionDesc.Text.Trim(), ResultType: DataUtils.GetInt(ddlResultType.SelectedValue.Trim()), IsActive: chkFormActive.Checked, IsUpdate: (btnQuestionDetails.Text == "Update"), ACYrQtrID:DataUtils.GetInt(YearQrtrId));
                hfQuestionId.Value = "";
                gvQuestionAnswer.EditIndex = -1;
                pnlAQManagementForm.Visible = false;
                cbAddNewQuestion.Checked = false;
                BindQuestionAnswerGrid();
                lblQuestionErrorMsg.Text = (btnQuestionDetails.Text == "Update") ? "Question Details updated successfully." : "Question Details inserted successfully.";
            }
            catch (Exception ex)
            {
                   lblQuestionErrorMsg.Text = ex.Message;
            }
        }

        protected void cbAddNewQuestion_CheckedChanged(object sender, EventArgs e)
        {
            lblQuestionErrorMsg.Text = string.Empty;
            if(cbAddNewQuestion.Checked)
            {
                pnlAQManagementForm.Visible = true;
                gvQuestionAnswer.EditIndex = -1;
                BindQuestionAnswerGrid();
                btnQuestionDetails.Text = "Submit";
                txtQuestionNum.Text = (gvQuestionAnswer.Rows.Count + 1).ToString();
                txtQuestionDesc.Text = string.Empty;
                ddlResultType.ClearSelection();
                chkFormActive.Checked = true;
            }
            else
            {
                pnlAQManagementForm.Visible = false;
                btnQuestionDetails.Text = "Update";
            }
        }

        protected void cbActive_CheckedChanged(object sender, EventArgs e)
        {
            BindQuestionAnswerGrid();
        }

    }
}