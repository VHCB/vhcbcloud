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
    public partial class ProgressReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (DataPagerFieldItem dpfItem in QuestionsListNextPrevious.Controls)
            {
                foreach (Control cPagerControls in dpfItem.Controls)
                {
                    if (cPagerControls is Button)
                    {
                        Button pagerButton = cPagerControls as Button;
                        pagerButton.Click += new EventHandler(pagerButton_Click);

                    }
                }
            }
            foreach (DataPagerFieldItem dpfItem in QuestionsListNumeric.Controls)
            {
                foreach (Control cPagerControls in dpfItem.Controls)
                {
                    if (cPagerControls is Button)
                    {
                        Button pagerButton = cPagerControls as Button;
                        pagerButton.Click += new EventHandler(numericpagerButton_Click);

                    }
                }
            }

            if (!IsPostBack)
            {
                DataTable dtable = YearQuarterData.GetAllYearQuarterDetailsForUserQA();
                ddlYearQrtr.DataTextField = "Quarter";
                ddlYearQrtr.DataValueField = "ACYrQtrID";
                ddlYearQrtr.DataSource = dtable;
                ddlYearQrtr.DataBind();
                DataTable dtUserDetails = YearQuarterData.GetUserDetailsByUserName(Context.User.Identity.Name);
                txtFirstName.Text = dtUserDetails.Rows[0]["FName"].ToString().Trim();
                txtLastName.Text = dtUserDetails.Rows[0]["LName"].ToString().Trim();
                txtEmail.Text = dtUserDetails.Rows[0]["email"].ToString().Trim();
                txtProjectNumber.Text = dtUserDetails.Rows[0]["NumbProj"].ToString().Trim();
                txtHostSite.Text = dtUserDetails.Rows[0]["Hostsite"].ToString().Trim();
                hfUserId.Value = dtUserDetails.Rows[0]["UserId"].ToString().Trim();
               // hdnAllIsCompleted.Value = string.Empty;
            }
                btnSubmit.Visible = false;
            lblQuestionAnswerErrorMsg.Text = string.Empty;
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
             try
            {
                YearQuarterData.SubmitOtherMembers(DataUtils.GetInt(hfUserId.Value.Trim()), DataUtils.GetInt(ddlYearQrtr.SelectedValue.Trim()), txtOtherUsers.Text.ToString().Trim());
                BindUserQuestionAnswerList();
            }
             catch (Exception ex)
             {
                 lblQuestionAnswerErrorMsg.Text = ex.Message;
             }
        }

        protected void BindUserQuestionAnswerList()
        {
            DataTable dtable = default(DataTable);
            try
            {
                dtable = new DataTable();
                dtable = YearQuarterData.GetAllQuestionAnswerDetailsByUser(DataUtils.GetInt(ddlYearQrtr.SelectedValue.Trim()), DataUtils.GetInt(hfUserId.Value.Trim()), true);
                if (dtable.Rows.Count > 0)
                {
                    pnlUserDetails.Visible = false;
                    pnlQuestions.Visible = true;
                    DataRow dr = dtable.Select("IsCompleted = True").FirstOrDefault();
                    if(dr != null)
                        hdnAllIsCompleted.Value = dr["IsCompleted"].ToString();
                    lstVwQuestions.DataSource = dtable;
                    lstVwQuestions.DataBind();
                   
                    //if (DataUtils.GetBool(dtable.Rows[0]["IsCompleted"].ToString()))
                    if (DataUtils.GetBool(hdnAllIsCompleted.Value.ToString()))
                    {
                        btnSubmit.Visible = false;
                        lblQuestionAnswerErrorMsg.Text = "Question Answer information is already submitted.";
                    }
                    else if (QuestionsListNextPrevious.TotalRowCount == QuestionsListNextPrevious.PageSize && !DataUtils.GetBool(dtable.Rows[0]["IsCompleted"].ToString()))
                    {
                        btnSubmit.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {

                lblQuestionAnswerErrorMsg.Text = ex.Message;
            }
        }

        protected void lstVwQuestions_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            try
            {
                QuestionsListNextPrevious.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
                QuestionsListNumeric.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
                int CurrentPage = ((e.StartRowIndex) / e.MaximumRows) + 1;
                int totalPages = QuestionsListNextPrevious.TotalRowCount / QuestionsListNextPrevious.PageSize;
                if (CurrentPage == totalPages)
                    btnSubmit.Visible = true;
                BindUserQuestionAnswerList();
            }
            catch (Exception ex)
            {

                lblQuestionAnswerErrorMsg.Text = ex.Message;
            }
        }

        protected void lstVwQuestions_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            try
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                if (e.Item.ItemType == ListViewItemType.DataItem)
                {
                    DataRowView rowView = (DataRowView)dataItem.DataItem;
                    TextBox txtAnswr = (e.Item.FindControl("txtAnswer") as TextBox);
                    //if (DataUtils.GetBool(rowView.Row["IsCompleted"].ToString()))
                    if (DataUtils.GetBool(hdnAllIsCompleted.Value.ToString().Trim()))
                    {
                        txtAnswr.ReadOnly = true;
                    }
                    if (DataUtils.GetInt(rowView.Row["ResultType"].ToString()) == 2)
                    {
                        txtAnswr.Attributes.Add("onKeyUp", "toQuestionNumericControl('" + txtAnswr.ClientID.Trim() + "');");
                        txtAnswr.Attributes.Add("style", "width:40px;");
                        txtAnswr.MaxLength = 3;
                    }
                    else
                    {
                        txtAnswr.Attributes.Remove("onKeyUp");
                        txtAnswr.TextMode = TextBoxMode.MultiLine;
                        txtAnswr.Attributes.Add("style", "height:80px;width:100%;");
                    }

                }
            }
            catch (Exception ex)
            {

                lblQuestionAnswerErrorMsg.Text = ex.Message;
            }
        }
        protected void pagerButton_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("ACPerformanceMasterID", typeof(int)));
                dt.Columns.Add(new DataColumn("Response", typeof(string)));
                dt.Columns.Add(new DataColumn("UserID", typeof(string)));
                dt.Columns.Add(new DataColumn("IsCompleted", typeof(bool)));
                dt.Columns.Add(new DataColumn("RowIsActive", typeof(bool)));

                for (int i = 0; i < QuestionsListNextPrevious.MaximumRows; i++)
                {

                    DataRow dr = dt.NewRow();
                    dr["ACPerformanceMasterID"] = DataUtils.GetInt((lstVwQuestions.Items[i].FindControl("hdnACPerformanceMasterID") as HiddenField).Value.Trim());
                    dr["Response"] = (lstVwQuestions.Items[i].FindControl("txtAnswer") as TextBox).Text.Trim(); ;
                    dr["UserID"] = DataUtils.GetInt(hfUserId.Value.Trim());
                    dr["IsCompleted"] = false;
                    dr["RowIsActive"] = true;
                    dt.Rows.Add(dr);
                    dt.AcceptChanges();
                }
                //if (!DataUtils.GetBool((lstVwQuestions.Items[0].FindControl("hdnIsCompleted") as HiddenField).Value.Trim()))
                if (!DataUtils.GetBool(hdnAllIsCompleted.Value.ToString().Trim()))
                {
                    if (dt.Rows.Count > 0)
                        YearQuarterData.AddQuestionAnswers(dt);
                }
            }
            catch (Exception ex)
            {

                lblQuestionAnswerErrorMsg.Text = ex.Message;
            }
        }

        protected void numericpagerButton_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("ACPerformanceMasterID", typeof(int)));
                dt.Columns.Add(new DataColumn("Response", typeof(string)));
                dt.Columns.Add(new DataColumn("UserID", typeof(string)));
                dt.Columns.Add(new DataColumn("IsCompleted", typeof(bool)));
                dt.Columns.Add(new DataColumn("RowIsActive", typeof(bool)));

                for (int i = 0; i < QuestionsListNumeric.MaximumRows; i++)
                {
                    DataRow dr = dt.NewRow();
                    dr["ACPerformanceMasterID"] = DataUtils.GetInt((lstVwQuestions.Items[i].FindControl("hdnACPerformanceMasterID") as HiddenField).Value.Trim());
                    dr["Response"] = (lstVwQuestions.Items[i].FindControl("txtAnswer") as TextBox).Text.Trim(); ;
                    dr["UserID"] = DataUtils.GetInt(hfUserId.Value.Trim());
                    dr["IsCompleted"] = false;
                    dr["RowIsActive"] = true;
                    dt.Rows.Add(dr);
                    dt.AcceptChanges();
                }
                //if (!DataUtils.GetBool((lstVwQuestions.Items[0].FindControl("hdnIsCompleted") as HiddenField).Value.Trim()))
                if (!DataUtils.GetBool(hdnAllIsCompleted.Value.ToString().Trim()))
                {
                    if (dt.Rows.Count > 0)
                        YearQuarterData.AddQuestionAnswers(dt);
                }
            }
            catch (Exception ex)
            {

                 lblQuestionAnswerErrorMsg.Text = ex.Message;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("ACPerformanceMasterID", typeof(int)));
                dt.Columns.Add(new DataColumn("Response", typeof(string)));
                dt.Columns.Add(new DataColumn("UserID", typeof(string)));
                dt.Columns.Add(new DataColumn("IsCompleted", typeof(bool)));
                dt.Columns.Add(new DataColumn("RowIsActive", typeof(bool)));

                for (int i = 0; i < QuestionsListNextPrevious.MaximumRows; i++)
                {

                    DataRow dr = dt.NewRow();
                    dr["ACPerformanceMasterID"] = DataUtils.GetInt((lstVwQuestions.Items[i].FindControl("hdnACPerformanceMasterID") as HiddenField).Value.Trim());
                    dr["Response"] = (lstVwQuestions.Items[i].FindControl("txtAnswer") as TextBox).Text.Trim(); ;
                    dr["UserID"] = DataUtils.GetInt(hfUserId.Value.Trim());
                    dr["IsCompleted"] = false;
                    dr["RowIsActive"] = true;
                    dt.Rows.Add(dr);
                    dt.AcceptChanges();
                }
                //if (!DataUtils.GetBool((lstVwQuestions.Items[0].FindControl("hdnIsCompleted") as HiddenField).Value.Trim()))
                if (!DataUtils.GetBool(hdnAllIsCompleted.Value.ToString().Trim()))
                {
                    if (dt.Rows.Count > 0)
                        YearQuarterData.AddQuestionAnswers(dt);
                }
                YearQuarterData.SubmitUserQuestionAnswers(DataUtils.GetInt(hfUserId.Value.Trim()),DataUtils.GetInt(ddlYearQrtr.SelectedValue.Trim()));
                BindUserQuestionAnswerList();
                lblQuestionAnswerErrorMsg.Text = "Question Answer information submitted successfully.";
            }
            catch (Exception ex)
            {
                 lblQuestionAnswerErrorMsg.Text = ex.Message;
            }
        }
        
    }
}