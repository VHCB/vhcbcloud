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
            //if (!IsPostBack)
            //{
            //    //QuestionsListNextPrevious.SetPageProperties(5, 5, true);
            //    //(lstVwQuestions.FindControl("lblPageNum") as Label).Text = "Page " + QuestionsListNumeric.nu
              
            //}
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
             try
            {
                //pnlUserDetails.Visible = false;
                //pnlQuestions.Visible = true;
                BindUserQuestionAnswerList();
            }
             catch (Exception ex)
             {
                // lblQuestionErrorMsg.Text = ex.Message;
             }
        }

        protected void BindUserQuestionAnswerList()
        {
            DataTable dtable = default(DataTable);
            string YearQrtrId = default(string);
            try
            {
                dtable = new DataTable();
                dtable = YearQuarterData.GetAllQuestionAnswerDetailsByUser(2, 3, true);
                if (dtable.Rows.Count > 0)
                {
                    pnlUserDetails.Visible = false;
                    pnlQuestions.Visible = true;
                   
                    lstVwQuestions.DataSource = dtable;
                    lstVwQuestions.DataBind();
                   
                }
            }
            catch (Exception ex)
            {
                
                //lblQuestionErrorMsg.Text = ex.Message;
            }
        }

        protected void lstVwQuestions_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //set current page startindex, max rows and rebind to false
            QuestionsListNextPrevious.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            //rebind List View
            BindUserQuestionAnswerList();
        }

        protected void lstVwQuestions_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;

            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                DataRowView rowView = (DataRowView)dataItem.DataItem;

            }
        }
        protected void pagerButton_Click(object sender, EventArgs e)
        {
            //DataPager Pager1 = lstVwQuestions.FindControl("QuestionsListNextPrevious") as DataPager;
            //int j = 0;
            //if (QuestionsListNextPrevious.StartRowIndex == 0)
            //    j = QuestionsListNextPrevious.MaximumRows;
            //else
            //    j = QuestionsListNextPrevious.MaximumRows * 2;
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ACPerformanceMasterID", typeof(int)));
            dt.Columns.Add(new DataColumn("Response", typeof(string)));
            dt.Columns.Add(new DataColumn("UserID", typeof(string)));
            dt.Columns.Add(new DataColumn("IsCompleted", typeof(bool)));
            dt.Columns.Add(new DataColumn("RowIsActive", typeof(bool)));

            for (int i = 0; i < QuestionsListNextPrevious.MaximumRows; i++)
            {
                DataRow dr = dt.NewRow();
                dr["ACPerformanceMasterID"] =  DataUtils.GetInt((lstVwQuestions.Items[i].FindControl("hdnACPerformanceMasterID") as HiddenField).Value.Trim());
                dr["Response"] = (lstVwQuestions.Items[i].FindControl("txtAnswer") as TextBox).Text.Trim(); ;
                dr["UserID"] = 3;
                dr["IsCompleted"] = false;
                dr["RowIsActive"] = true;
                dt.Rows.Add(dr);
                dt.AcceptChanges();
            }
            if(dt.Rows.Count > 0)
            YearQuarterData.AddQuestionAnswers(dt);
        }
    }
}