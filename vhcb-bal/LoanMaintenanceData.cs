using System;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VHCBCommon.DataAccessLayer;


namespace VHCBCommon.DataAccessLayer
{
    public class LoanMaintenanceData
    {
        public static DataTable GetLoanDetailsIdList(int ProjectId)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanDetailsIdList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static DataTable GetLoanTransferList(int LoanID)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanTransferList";
                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static DataTable GetLoanMasterListByProject(int ProjectId, bool IsActiveOnly)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanMasterListByProject";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static DataRow GetLoanMasterDetailsByLoanID(int LoanId)
        {
            DataRow dr = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanMasterDetailsByLoanID";
                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count != 0)
                        {
                            dr = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dr;
        }

        public static DataRow GetProjectLoanMasterDetails(int ProjectId)
        {
            DataRow dr = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetProjectLoanMasterDetails";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count != 0)
                        {
                            dr = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dr;
        }

        public static void AddLoanMaster(int ProjectId, int TaxCreditPartner, int NoteOwner,
            decimal NoteAmt, int FundGroup, int ApplicantId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddLoanMaster";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        
                        command.Parameters.Add(new SqlParameter("TaxCreditPartner", TaxCreditPartner));
                        command.Parameters.Add(new SqlParameter("NoteOwner", NoteOwner));
                        command.Parameters.Add(new SqlParameter("NoteAmt", NoteAmt));
                        command.Parameters.Add(new SqlParameter("FundGroup", FundGroup));
                        
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateLoanMaster(int LoanId, int TaxCreditPartner, int NoteOwner,
            decimal NoteAmt, int FundGroup, int ApplicantId, bool RowIsActive)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "UpdateLoanMaster";

                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                        //command.Parameters.Add(new SqlParameter("Descriptor", Descriptor));
                        command.Parameters.Add(new SqlParameter("TaxCreditPartner", TaxCreditPartner));
                        command.Parameters.Add(new SqlParameter("NoteOwner", NoteOwner));
                        command.Parameters.Add(new SqlParameter("NoteAmt", NoteAmt));
                        command.Parameters.Add(new SqlParameter("FundGroup", FundGroup));
                        //command.Parameters.Add(new SqlParameter("FundID", FundID));
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataRow GetLatestLoanDetailsByLoanId(int LoanID)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLatestLoanDetailsByLoanId";
                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static DataRow GetLoanDetailsByLoanDetailId(int LoanDetailID)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanDetailsByLoanDetailId";
                        command.Parameters.Add(new SqlParameter("LoanDetailID", LoanDetailID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static LoadDetailsResult AddLoanDetail(int LoanId, int LegalDoc, int LoanCat, DateTime NoteDate, DateTime MaturityDate,
            decimal IntRate, int Compound, int Frequency, int PaymentType, DateTime WatchDate, string URL, 
            DateTime EffectiveDate, DateTime BoardApproveDate, decimal? NoteAmt)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddLoanDetail";

                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                        command.Parameters.Add(new SqlParameter("LegalDoc", LegalDoc));
                        command.Parameters.Add(new SqlParameter("LoanCat", LoanCat));
                        command.Parameters.Add(new SqlParameter("NoteDate", NoteDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : NoteDate));
                        command.Parameters.Add(new SqlParameter("MaturityDate", MaturityDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MaturityDate));
                        command.Parameters.Add(new SqlParameter("IntRate", IntRate));
                        command.Parameters.Add(new SqlParameter("Compound", Compound));
                        command.Parameters.Add(new SqlParameter("Frequency", Frequency));
                        command.Parameters.Add(new SqlParameter("PaymentType", PaymentType));
                        command.Parameters.Add(new SqlParameter("WatchDate", WatchDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : WatchDate));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("EffectiveDate", EffectiveDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EffectiveDate));
                        command.Parameters.Add(new SqlParameter("BoardApproveDate", BoardApproveDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : BoardApproveDate));
                        command.Parameters.Add(new SqlParameter("NoteAmt", NoteAmt));

                        SqlParameter parmMessage = new SqlParameter("@IsExist", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@LoanDetailId", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);
                        

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LoadDetailsResult ap = new LoadDetailsResult();

                        ap.IsExist = DataUtils.GetBool(command.Parameters["@IsExist"].Value.ToString());
                        ap.LoanDetailId = DataUtils.GetInt(command.Parameters["@LoanDetailId"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateLoanDetail(int LoanDetailID, int LegalDoc, int LoanCat, DateTime NoteDate, DateTime MaturityDate,
            decimal IntRate, int Compound, int Frequency, int PaymentType, DateTime WatchDate, string URL,
            DateTime EffectiveDate, DateTime BoardApproveDate, decimal? NoteAmt, bool RowIsActive)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "UpdateLoanDetail";

                        command.Parameters.Add(new SqlParameter("LoanDetailID", LoanDetailID));
                        command.Parameters.Add(new SqlParameter("LegalDoc", LegalDoc));
                        command.Parameters.Add(new SqlParameter("LoanCat", LoanCat));
                        command.Parameters.Add(new SqlParameter("NoteDate", NoteDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : NoteDate));
                        command.Parameters.Add(new SqlParameter("MaturityDate", MaturityDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MaturityDate));
                        command.Parameters.Add(new SqlParameter("IntRate", IntRate));
                        command.Parameters.Add(new SqlParameter("Compound", Compound));
                        command.Parameters.Add(new SqlParameter("Frequency", Frequency));
                        command.Parameters.Add(new SqlParameter("PaymentType", PaymentType));
                        command.Parameters.Add(new SqlParameter("WatchDate", WatchDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : WatchDate));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("EffectiveDate", EffectiveDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EffectiveDate));
                        command.Parameters.Add(new SqlParameter("BoardApproveDate", BoardApproveDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : BoardApproveDate));
                        command.Parameters.Add(new SqlParameter("NoteAmt", NoteAmt));

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable GetLoanDetailListByLoanId(int LoanId, bool IsActiveOnly)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanDetailListByLoanId";
                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static DataRow GetLoanMasterNoteAmount(int LoanDetailID)
        {
            DataRow dr = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanMasterNoteAmount";
                        command.Parameters.Add(new SqlParameter("LoanDetailID", LoanDetailID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count != 0)
                        {
                            dr = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dr;
        }

        #region LoanEvents
        public static DataTable GetLoanEventsListByLoanID(int LoanID, bool IsActiveOnly)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanEventsListByLoanID";
                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static DataRow GetLoanEventsByLoanEventID(int LoanEventID)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanEventsByLoanEventID";
                        command.Parameters.Add(new SqlParameter("LoanEventID", LoanEventID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static LoanResult AddLoanEvent(int LoanID, string Description, DateTime EventDate, int Event, string URL)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddLoanEvent";

                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));
                        command.Parameters.Add(new SqlParameter("Description", Description));
                        command.Parameters.Add(new SqlParameter("EventDate", EventDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EventDate));
                        command.Parameters.Add(new SqlParameter("Event", Event));
                        command.Parameters.Add(new SqlParameter("URL", URL));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LoanResult ap = new LoanResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateLoanEvent(int LoanEventID, string Description, bool IsRowIsActive, DateTime EventDate, int Event, string URL)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "UpdateLoanEvent";

                        command.Parameters.Add(new SqlParameter("LoanEventID", LoanEventID));
                        command.Parameters.Add(new SqlParameter("Description", Description));
                        command.Parameters.Add(new SqlParameter("EventDate", EventDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EventDate));
                        command.Parameters.Add(new SqlParameter("Event", Event));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        
                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion LoanEvents

        #region LoanNotes
        public static DataTable GetLoanNotesListByLoanID(int LoanID, bool IsActiveOnly)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanNotesListByLoanID";
                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static LoanResult AddLoanNotes(int LoanID, string LoanNote, string FHLink)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddLoanNotes";

                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));
                        command.Parameters.Add(new SqlParameter("LoanNote", LoanNote));
                        command.Parameters.Add(new SqlParameter("FHLink", FHLink));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LoanResult ap = new LoanResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateLoanNotes(int LoanNoteID, string LoanNote, string FHLink, bool IsRowIsActive)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "UpdateLoanNotes";

                        command.Parameters.Add(new SqlParameter("LoanNoteID", LoanNoteID));
                        command.Parameters.Add(new SqlParameter("LoanNote", LoanNote));
                        command.Parameters.Add(new SqlParameter("FHLink", FHLink));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataRow GetLoanNotesByLoanID(int LoanNoteID)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanNotesByLoanID";
                        command.Parameters.Add(new SqlParameter("LoanNoteID", LoanNoteID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }
        #endregion LoanNotes

        #region LoanTransactions
        public static DataTable GetLoanTransactionsList(int LoanId, bool IsActiveOnly)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanTransactionsList";
                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static void AddLoanTransactions(int LoanId, int TransType, DateTime TransDate, decimal? IntRate, 
            int? Compound, int? Freq, int? PayType, DateTime MatDate, DateTime StartDate,
            decimal? Amount, DateTime StopDate, decimal? Principal, decimal? Interest, string Description, 
            int? TransferTo, int? ConvertFrom, DateTime EffectiveDate, bool Adjustment, string URL, 
            int? FundID, int ToLoanID)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddLoanTransactions";

                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                        command.Parameters.Add(new SqlParameter("TransType", TransType));
                        command.Parameters.Add(new SqlParameter("TransDate", TransDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : TransDate));
                        command.Parameters.Add(new SqlParameter("IntRate", IntRate));
                        command.Parameters.Add(new SqlParameter("Compound", Compound));
                        command.Parameters.Add(new SqlParameter("Freq", Freq));
                        command.Parameters.Add(new SqlParameter("PayType", PayType));
                        command.Parameters.Add(new SqlParameter("MatDate", MatDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MatDate));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("StopDate", StopDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StopDate));
                        command.Parameters.Add(new SqlParameter("Principal", Principal));
                        command.Parameters.Add(new SqlParameter("Interest", Interest));
                        command.Parameters.Add(new SqlParameter("Description", Description));
                        command.Parameters.Add(new SqlParameter("TransferTo", TransferTo));
                        command.Parameters.Add(new SqlParameter("ConvertFrom", ConvertFrom));
                        command.Parameters.Add(new SqlParameter("EffectiveDate", EffectiveDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EffectiveDate));
                        command.Parameters.Add(new SqlParameter("Adjustment", Adjustment));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        if (FundID == 0) FundID = null;
                        command.Parameters.Add(new SqlParameter("FundID", FundID));
                        command.Parameters.Add(new SqlParameter("ToLoanID", ToLoanID));
                        
                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateLoanTransactions(int LoanTransId, int TransType, DateTime TransDate, decimal? IntRate,
            int? Compound, int? Freq, int? PayType, DateTime MatDate, DateTime StartDate,
            decimal? Amount, DateTime StopDate, decimal? Principal, decimal? Interest, string Description, 
            int? TransferTo, int? ConvertFrom, DateTime EffectiveDate, bool RowIsActive, bool Adjustment, string URL, int? FundID)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "UpdateLoanTransactions";

                        command.Parameters.Add(new SqlParameter("LoanTransId", LoanTransId));
                        command.Parameters.Add(new SqlParameter("TransType", TransType));
                        command.Parameters.Add(new SqlParameter("TransDate", TransDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : TransDate));
                        command.Parameters.Add(new SqlParameter("IntRate", IntRate));
                        command.Parameters.Add(new SqlParameter("Compound", Compound));
                        command.Parameters.Add(new SqlParameter("Freq", Freq));
                        command.Parameters.Add(new SqlParameter("PayType", PayType));
                        command.Parameters.Add(new SqlParameter("MatDate", MatDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MatDate));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("StopDate", StopDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StopDate));
                        command.Parameters.Add(new SqlParameter("Principal", Principal));
                        command.Parameters.Add(new SqlParameter("Interest", Interest));
                        command.Parameters.Add(new SqlParameter("Description", Description));
                        command.Parameters.Add(new SqlParameter("TransferTo", TransferTo));
                        command.Parameters.Add(new SqlParameter("ConvertFrom", ConvertFrom));
                        command.Parameters.Add(new SqlParameter("EffectiveDate", EffectiveDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EffectiveDate));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));
                        command.Parameters.Add(new SqlParameter("Adjustment", Adjustment));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        if (FundID == 0) FundID = null;
                        command.Parameters.Add(new SqlParameter("FundID", FundID));

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataRow GetLoanTransByLoanID(int LoanTransID)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetLoanTransByLoanID";
                        command.Parameters.Add(new SqlParameter("LoanTransID", LoanTransID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }
        #endregion LoanTransactions

        public static DataTable GetAllEntities()
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllEntities";

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtProjects = ds.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
            return dtProjects;
        }

        public static DataTable GetPartnershipByProjectId(int ProjectId)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetPartnershipByProjectId";

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtProjects = ds.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
            return dtProjects;
        }
        #region Fund
        public static DataTable GetFundDetailsByLoanId(int LoanId, bool IsActiveOnly)
        {
            DataTable dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetFundDetailsByLoanId";
                        command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public static LoanResult AddLoanFund(int LoanID, int FundId, decimal Amount)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddLoanFund";

                        command.Parameters.Add(new SqlParameter("LoanID", LoanID));
                        command.Parameters.Add(new SqlParameter("FundId", FundId));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LoanResult ap = new LoanResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateLoanFund(int LoanFundID, int FundId, decimal Amount, bool IsRowIsActive)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "UpdateLoanFund";

                        command.Parameters.Add(new SqlParameter("LoanFundID", LoanFundID));
                        command.Parameters.Add(new SqlParameter("FundId", FundId));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        public static DataTable GetLoanMasterDetails(int ProjectId, int LoanId)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLoanMasterDetails";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("LoanId", LoanId));
                
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtProjects = ds.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
            return dtProjects;
        }

        public static DataSet GetLoanSummaryDetails(int LoanId)
        {
            DataSet ds = new DataSet();
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "getLoanSummaryDetails";
                command.Parameters.Add(new SqlParameter("LoanId", LoanId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    SqlDataAdapter da = new SqlDataAdapter(command);
                    da.Fill(ds);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
            return ds;
        }
    }

    public class LoanResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }

    public class LoadDetailsResult
    {
        public bool IsExist { set; get; }
        public int LoanDetailId { set; get; }
    }
}
