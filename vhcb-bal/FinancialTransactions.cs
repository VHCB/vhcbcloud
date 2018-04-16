using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VHCBCommon.DataAccessLayer
{
    public static class FinancialTransactions
    {
        public static DataTable GetBoardCommitmentsByProject(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetBoardCommitmentsByProject";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                //

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetFundByProject(int projectId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundByProject";
                command.Parameters.Add(new SqlParameter("projId", projectId));
                //

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetBoardFinancialTrans()
        {
            DataTable dtBoardFinancialTrans = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetBoardFinancialTrans";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBoardFinancialTrans = ds.Tables[0];
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
            return dtBoardFinancialTrans;
        }

        public static DataTable GetAssignmentTransactionsByProject(int ProjectId, int TransactionType, bool ActiveOnly)
        {
            DataSet ds = new DataSet();
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAssignmentTransactionsByProject";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("TransactionType", TransactionType));
                command.Parameters.Add(new SqlParameter("ActiveOnly", ActiveOnly));

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
            return ds.Tables[0];
        }

        public static DataSet GetFinancialFundDetailsByProjectId(int projectId, bool isReallocation)
        {
            DataSet ds = new DataSet();
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinancialFundDetailsByProjectId";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("isReallocation", isReallocation));

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

        public static DataSet GetAwardSummary(int projectId)
        {
            DataSet ds = new DataSet();
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "getAwardSummary";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
               
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

        public static DataTable GetCommittedFundByProject(int projectId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCommittedFundByProject";
                command.Parameters.Add(new SqlParameter("projId", projectId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetExistingCommittedFundByProject(int projectId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetExistingCommittedFundByProject";
                command.Parameters.Add(new SqlParameter("projId", projectId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetReallocationAmtByProjId(int projectId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationAmtByProjId";
                command.Parameters.Add(new SqlParameter("fromProjId", projectId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static bool IsDuplicateFundDetailPerTransaction(int transid, int fundid, int fundtranstype, string UsePermit = "")
        {
            bool isDuplicate = false;
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "IsDuplicateFundDetailPerTransaction";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("UsePermit", UsePermit));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
                        if (dtable.Rows.Count > 0)
                            isDuplicate = true;
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

            return isDuplicate;
        }

        public static bool IsDuplicateFundDetail(int detailId, int fundid, int fundtranstype)
        {
            bool isDuplicate = false;
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "IsDuplicateFundDetail";
                command.Parameters.Add(new SqlParameter("detailId", detailId));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
                        if (dtable.Rows.Count > 0)
                            isDuplicate = true;
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

            return isDuplicate;
        }


        public static void AddDeCommitmentTransDetails(int transid, int fundid, int fundtranstype, int ProjectID, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddDeCommitmentTransDetails";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddDeCommitmentTransDetailsWithLandPermit(int transid, int fundid, int fundtranstype, int ProjectID, 
            decimal fundamount, string usePermit, string useFarmId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddDeCommitmentTransDetailsWithLandPermit";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));
                command.Parameters.Add(new SqlParameter("LandUsePermit", usePermit));
                command.Parameters.Add(new SqlParameter("LandUseFarmId", Convert.ToInt32(useFarmId)));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddCommitmentTransDetails(int transid, int fundid, int fundtranstype, int ProjectID, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddCommitmentTransDetails";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddCommitmentTransDetailsWithLandPermit(int transid, int fundid, int fundtranstype, int ProjectID, 
            decimal fundamount, string usePermit, string useFarmId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddCommitmentTransDetailsWithLandPermit";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));
                command.Parameters.Add(new SqlParameter("LandUsePermit", usePermit));
                command.Parameters.Add(new SqlParameter("LandUseFarmId", Convert.ToInt32(useFarmId)));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddProjectFundDetails(int ProjectId, int transid, int fundid, int fundtranstype, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddProjectFundDetails";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddProjectFundDetailsReallocation(int ProjectId, int transid, int fundid, int fundtranstype, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddProjectFundDetailsReallocation";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }
        public static void AddProjectFundDetails(int ProjectId, int transid, int fundid, int fundtranstype, decimal fundamount, string usePermit, string useFarmId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddProjectFundDetailsWithLandPermit";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));
                command.Parameters.Add(new SqlParameter("LandUsePermit", usePermit));
                command.Parameters.Add(new SqlParameter("LandUseFarmId", Convert.ToInt32(useFarmId)));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }


        public static DataTable AddStaffAssignment(int FromProjectId, int ToProjectId, DateTime transDate, int Fromfundid, int Fromfundtranstype,
                          decimal Fromfundamount, int Tofundid, int Tofundtranstype, decimal Tofundamount, Nullable<int> fromTransId, Nullable<int> toTransId, 
                          string transGuid, int UserId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtable = null;
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddStaffAssignmentNew"; // "AddStaffAssignment";
                command.Parameters.Add(new SqlParameter("FromProjectId", FromProjectId));
                command.Parameters.Add(new SqlParameter("ToProjectId", ToProjectId));
                command.Parameters.Add(new SqlParameter("transDate", transDate));
                command.Parameters.Add(new SqlParameter("Fromfundid", Fromfundid));
                command.Parameters.Add(new SqlParameter("Fromfundtranstype", Fromfundtranstype));
                command.Parameters.Add(new SqlParameter("Fromfundamount", Fromfundamount));
                command.Parameters.Add(new SqlParameter("Tofundid", Tofundid));
                command.Parameters.Add(new SqlParameter("Tofundtranstype", Tofundtranstype));
                command.Parameters.Add(new SqlParameter("Tofundamount", Tofundamount));
                command.Parameters.Add(new SqlParameter("fromTransId", fromTransId));
                command.Parameters.Add(new SqlParameter("toTransId", toTransId));
                command.Parameters.Add(new SqlParameter("transGuid", transGuid)); 
                    command.Parameters.Add(new SqlParameter("UserId", UserId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }


        public static DataTable AddBoardReallocationTransaction(int FromProjectId, int ToProjectId, DateTime transDate, int Fromfundid, int Fromfundtranstype,
                                decimal Fromfundamount, int Tofundid, int Tofundtranstype, decimal Tofundamount, Nullable<int> fromTransId, Nullable<int> toTransId,
                                int fromUsePermit, int toUsePermit, string transGuid, int UserId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtable = null;
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddBoardReallocationTransaction";
                command.Parameters.Add(new SqlParameter("FromProjectId", FromProjectId));
                command.Parameters.Add(new SqlParameter("ToProjectId", ToProjectId));
                command.Parameters.Add(new SqlParameter("transDate", transDate));
                command.Parameters.Add(new SqlParameter("Fromfundid", Fromfundid));
                command.Parameters.Add(new SqlParameter("Fromfundtranstype", Fromfundtranstype));
                command.Parameters.Add(new SqlParameter("Fromfundamount", Fromfundamount));
                command.Parameters.Add(new SqlParameter("Tofundid", Tofundid));
                command.Parameters.Add(new SqlParameter("Tofundtranstype", Tofundtranstype));
                command.Parameters.Add(new SqlParameter("Tofundamount", Tofundamount));
                command.Parameters.Add(new SqlParameter("fromTransId", fromTransId));
                command.Parameters.Add(new SqlParameter("toTransId", toTransId));
                command.Parameters.Add(new SqlParameter("transGuid", transGuid));
                command.Parameters.Add(new SqlParameter("UserId", UserId));

                if (fromUsePermit != 0)
                command.Parameters.Add(new SqlParameter("fromUsePermit", fromUsePermit));

                if (toUsePermit != 0)
                    command.Parameters.Add(new SqlParameter("toUsePermit", toUsePermit));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetReallocationDetailsTransId(int fromProjId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationDetailsTransId";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                //command.Parameters.Add(new SqlParameter("toTransId", toTransId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }


        public static DataTable GetAssignmentByTransId(int TransID)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAssignmentByTransId";
                command.Parameters.Add(new SqlParameter("TransID", TransID));
                //command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                //command.Parameters.Add(new SqlParameter("toTransId", toTransId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static void InsertAssignmentDetail(int TransID, int ProjectId, decimal Amount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "InsertAssignmentDetail";
                command.Parameters.Add(new SqlParameter("TransID", TransID));
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("Amount", Amount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetReallocationDetailsProjFund(int fromProjId, int fundId, DateTime dtModified)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationDetailsProjFund";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("datemodified", dtModified));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetReallocationDetailsProjFundTransType(int fromProjId, int fundId, int transTypeId, DateTime dtModified, string Guid)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationDetailsProjFundTransType";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("transTypeId", transTypeId));
                command.Parameters.Add(new SqlParameter("datemodified", dtModified));
                command.Parameters.Add(new SqlParameter("guid", Guid));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetDistinctReallocationGuidsByProjFundTransType(int fromProjId, int fundId, int transTypeId, DateTime dtModified)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetDistinctReallocationGuidsByProjFundTransType";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("transTypeId", transTypeId));
                command.Parameters.Add(new SqlParameter("datemodified", dtModified));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetAssignmentDetailsNewProjFund(int fromProjId, int fundId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAssignmentDetailsNewProjFund";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }


        public static DataTable GetReallocationDetailsNewProjFund(int fromProjId, int fundId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationDetailsNewProjFund";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetReallocationDetailsNewProjFundTransType(int fromProjId, int fundId, int transTypeId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationDetailsNewProjFundTransType";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("transTypeId", transTypeId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetAssignmentDetailsNewProjFundTransType(int fromProjId, int fundId, int transTypeId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAssignmentDetailsNewProjFundTransType";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("transTypeId", transTypeId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }


        public static DataTable GetReallocationDetailsByGuid(int fromProjId, string reallocateGuid)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetReallocationDetailsByGuid";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("reallocateGuid", reallocateGuid));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static DataTable GetAssignmentByGuid(int fromProjId, string reallocateGuid)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAssignmentByGuid";
                command.Parameters.Add(new SqlParameter("fromProjId", fromProjId));
                command.Parameters.Add(new SqlParameter("reallocateGuid", reallocateGuid));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }


        public static DataTable IsDuplicateReallocation(int FromProjectId, int fromTransId, int toTransId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "IsDuplicateReallocation";
                command.Parameters.Add(new SqlParameter("FromProjectId", FromProjectId));
                command.Parameters.Add(new SqlParameter("fromTransId", fromTransId));
                command.Parameters.Add(new SqlParameter("toTransId", toTransId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
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
            return dtable;
        }

        public static void DeleteReallocationsByGUID(string reallocateGuid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteReallocationsByGUID";
                command.Parameters.Add(new SqlParameter("reallocateGUID", reallocateGuid));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteAssignmentDetailByGUID(string DetailGuId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteAssignmentDetailByGUID";
                command.Parameters.Add(new SqlParameter("DetailGuId", DetailGuId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteReallocationTrans(int transId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteReallocationTrans";
                command.Parameters.Add(new SqlParameter("transId", transId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateTransDetails(int detailId, int fundtranstype, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateTransDetails";
                command.Parameters.Add(new SqlParameter("detailId", detailId));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateTransDetailsWithFund(int detailId, int fundtranstype, decimal fundamount, int fundId, string useFarmId = null)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateTransDetailsWithFund";
                command.Parameters.Add(new SqlParameter("detailId", detailId));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("useFarmId", useFarmId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateAssignmentDetails(int DetailId, int Projectid, decimal Amount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateAssignmentDetails";
                command.Parameters.Add(new SqlParameter("DetailId", DetailId));
                command.Parameters.Add(new SqlParameter("Projectid", Projectid));
                command.Parameters.Add(new SqlParameter("Amount", Amount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetTransDetails(int detailId)
        {
            DataTable dtable = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetTransDetails";
                command.Parameters.Add(new SqlParameter("detailId", detailId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtable = ds.Tables[0];
                    }
                }
                return dtable;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
        }

        public static void UpdateReallocationTransDetails(int detailId, int FromProjId, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateReallocationTransDetails";
                command.Parameters.Add(new SqlParameter("detailId", detailId));
                command.Parameters.Add(new SqlParameter("FromProjId", FromProjId));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteProjectFund(int transid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteProjectFund";
                command.Parameters.Add(new SqlParameter("transid", transid));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }


        public static DataSet GetFinancialFundDetailsByProjectId(int projectId)
        {
            DataSet ds = new DataSet();
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinancialFundDetailsByProjectId";
                command.Parameters.Add(new SqlParameter("projectId", projectId));

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

        public static DataTable GetBoardCommitmentTrans(int projectId, string commitmentType)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetBoardCommitmentTrans";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("commitmentType", commitmentType));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetLastFinancialTransaction(int projectId, string commitmentType)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLastFinancialTransaction";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("commitmentType", commitmentType));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetLookupDetailsByName(string lookupName)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("lookupname", lookupName));
                command.CommandText = "GetLookupDetailsByName";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetAllFundsByProjectProgram(int ProjectId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.CommandText = "GetAllFundsByProjectProgram";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetDataTableByProcName(string procName)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = procName;
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataSet GetDataSetByProcName(string procName)
        {
            DataSet ds = new DataSet();
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = procName;
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var da = new SqlDataAdapter(command);
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

        public static DataTable GetFundDetailsByProjectId(int transId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("transId", transId));
                command.CommandText = "GetFundDetailsByProjectId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }
        public static DataTable GetCommitmentFundDetailsByProjectId(int transId, int commitmentType, int activeOnly)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("transId", transId));
                command.Parameters.Add(new SqlParameter("commitmentType", commitmentType));
                command.Parameters.Add(new SqlParameter("activeOnly", activeOnly));
                command.CommandText = "GetCommitmentFundDetailsByProjectId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetCommittedFundAccounts(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCommittedFundAccounts";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAllLandUsePermitList()
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllLandUsePermitList";
                
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAllLandUsePermit(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllLandUsePermit";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAllLandUsePermitNew(int FundId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllLandUsePermitNew";
                command.Parameters.Add(new SqlParameter("FundId", FundId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAllLandUsePermitForDecommitment(int ProjectId, int FundId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllLandUsePermitForDecommitment";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("FundId", FundId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetLandUsePermit(int ProjectId, string AccountId, int FundTransType)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLandUsePermitNew";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                command.Parameters.Add(new SqlParameter("AccountId", AccountId));
                command.Parameters.Add(new SqlParameter("FundTransType", FundTransType));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetLandUsePermit(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLandUsePermit";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAvailableTransTypesPerProjFundId(int projectId, int fundId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAvailableTransTypesPerProjFundId";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAvailableTransTypesPerProjAcct(int projectId, string account)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAvailableTransTypesPerProjAcct";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("account", account));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAvailableFundsPerProjAcctFundtype(int projectId, string account, int fundtypeId, string LandUsePermitID = "")
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAvailableFundsPerProjAcctFundtype";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("account", account));
                command.Parameters.Add(new SqlParameter("fundtypeId", fundtypeId));
                command.Parameters.Add(new SqlParameter("LandUsePermitID", LandUsePermitID));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAvailableFundAmount(int projectId, int fundId, int fundTransType, string LandUsePermitID)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAvailableFundAmount";
                command.Parameters.Add(new SqlParameter("projectId", projectId));

                if (fundId != 0)
                    command.Parameters.Add(new SqlParameter("fundId", fundId));

                if (fundTransType != 0)
                    command.Parameters.Add(new SqlParameter("fundTransType", fundTransType));

                if (LandUsePermitID != "NA" && LandUsePermitID != "")
                command.Parameters.Add(new SqlParameter("LandUsePermitID", LandUsePermitID));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetCurrentTranAvailableFundAmount(int TransId, int fundId, int fundTransType, string LandUsePermitID)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCurrentTranAvailableFundAmount";
                command.Parameters.Add(new SqlParameter("TransId", TransId));

                if (fundId != 0)
                    command.Parameters.Add(new SqlParameter("fundId", fundId));

                if (fundTransType != 0)
                    command.Parameters.Add(new SqlParameter("fundTransType", fundTransType));

                if (LandUsePermitID != "NA" && LandUsePermitID != "")
                    command.Parameters.Add(new SqlParameter("LandUsePermitID", LandUsePermitID));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetAvailableFundAmountByProjectId(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAvailableFundAmountByProjectId";
                command.Parameters.Add(new SqlParameter("projectId", projectId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetCommittedFundNames(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCommittedFundNames";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetCommittedCRFundAccounts(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCommittedCRFundAccounts";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetCommittedCRFundNames(int projectId)
        {
            DataTable dtBCommit = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCommittedCRFundNames";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtBCommit = ds.Tables[0];
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
            return dtBCommit;
        }

        public static DataTable GetCommittedFundDetailsByFundId(int projectId, int fundId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.CommandText = "GetCommittedFundDetailsByFundId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetCommittedFundDetailsByFundTransType(int projectId, int fundId, int transtype)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("transtype", transtype));
                command.CommandText = "GetCommittedFundDetailsByFundTransType";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetFundDetailsByFundId(int fundId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.CommandText = "GetFundDetailsByFundId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }
        public static DataTable GetFundDetailsByFundAcct(string fundAcct)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("fundAcct", fundAcct));
                command.CommandText = "GetFundDetailsByFundAcct";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }


        public static DataTable GetCommittedFundPerProject(string proj_num)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("proj_num", proj_num));
                command.CommandText = "GetCommittedFundPerProject";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetGrantInfoDetailsByGrantInfoId(int GrantInfoId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                command.CommandText = "GetGrantInfoDetailsByGrantInfoId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static void AddFundType(string description, int typeid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddFundType";
                command.Parameters.Add(new SqlParameter("description", description));
                command.Parameters.Add(new SqlParameter("lkSource", typeid));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateFundType(string description, int typeId, Boolean active)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateFundType";
                command.Parameters.Add(new SqlParameter("description", description));
                command.Parameters.Add(new SqlParameter("active", active));
                command.Parameters.Add(new SqlParameter("typeid", typeId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddBoardCommitmentTransaction(int projectId, DateTime transDate, decimal transAmt, int payeeAppl, string CommitmentType, int lkStatus)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddBoardCommitmentTransaction";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("transDate", transDate));
                command.Parameters.Add(new SqlParameter("transAmt", transAmt));
                command.Parameters.Add(new SqlParameter("payeeApplicant", payeeAppl));
                command.Parameters.Add(new SqlParameter("commitmentType", CommitmentType));
                command.Parameters.Add(new SqlParameter("lkStatus", lkStatus));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetFinancialTransByTransId(int TransId, int activeOnly)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtTrans = new DataTable();
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinancialTransByTransId";
                command.Parameters.Add(new SqlParameter("transId", TransId));
                command.Parameters.Add(new SqlParameter("activeOnly", activeOnly));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTrans = ds.Tables[0];
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
            return dtTrans;
        }

        public static DataTable GetFinancialTransByProjId(int projId, int activeOnly, int transType)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtTrans = new DataTable();
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinancialTransByProjId";
                command.Parameters.Add(new SqlParameter("projId", projId));
                command.Parameters.Add(new SqlParameter("activeOnly", activeOnly));
                command.Parameters.Add(new SqlParameter("transType", transType));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTrans = ds.Tables[0];
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
            return dtTrans;
        }

        public static DataTable AddBoardFinancialTransaction(int projectId, DateTime transDate, decimal transAmt, Nullable<int> payeeAppl, string CommitmentType,
            int lkStatus, int UserId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtStatus = new DataTable();
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddBoardFinancialTransaction";
                command.Parameters.Add(new SqlParameter("projectId", projectId));
                command.Parameters.Add(new SqlParameter("transDate", transDate));
                command.Parameters.Add(new SqlParameter("transAmt", transAmt));
                command.Parameters.Add(new SqlParameter("payeeApplicant", payeeAppl));
                command.Parameters.Add(new SqlParameter("commitmentType", CommitmentType));
                command.Parameters.Add(new SqlParameter("lkStatus", lkStatus));
                command.Parameters.Add(new SqlParameter("UserId", UserId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static void UpdateBoardCommitmentTransaction(int transId, DateTime transDate, decimal transAmt, string CommitmentType, int lkStatus)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateBoardCommitmentTransaction";
                command.Parameters.Add(new SqlParameter("transId", transId));
                command.Parameters.Add(new SqlParameter("transDate", transDate));
                command.Parameters.Add(new SqlParameter("transAmt", transAmt));
                command.Parameters.Add(new SqlParameter("commitmentType", CommitmentType));
                command.Parameters.Add(new SqlParameter("lkStatus", lkStatus));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetGranteeByProject(int ProjectId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projectid", ProjectId));
                command.CommandText = "GetGranteeByProject";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static void AddFundInfo(string name, string abbr, int lkFundTypeId, string acct, string vHCBCode, int lkAcctMethod, string deptId, bool drawDown)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddFundInfo";
                command.Parameters.Add(new SqlParameter("name", name));
                command.Parameters.Add(new SqlParameter("abbr", abbr));
                command.Parameters.Add(new SqlParameter("lkFundTypeId", lkFundTypeId));
                command.Parameters.Add(new SqlParameter("acct", acct));
                command.Parameters.Add(new SqlParameter("vHCBCode", vHCBCode));
                command.Parameters.Add(new SqlParameter("lkAcctMethod", lkAcctMethod));
                command.Parameters.Add(new SqlParameter("deptId", deptId));
                command.Parameters.Add(new SqlParameter("drawDown", drawDown));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void InactivateFinancialTransByTransId(int transId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "InactivateFinancialTransByTransId";
                command.Parameters.Add(new SqlParameter("transId", transId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void ActivateFinancialTransByTransId(int transId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ActivateFinancialTransByTransId";
                command.Parameters.Add(new SqlParameter("transId", transId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void InactivateFinancialDetailByDetailId(int detailId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "InactivateFinancialDetailByDetailId";
                command.Parameters.Add(new SqlParameter("detailId", detailId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteFundInfo(int fundId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteFund";
                command.Parameters.Add(new SqlParameter("fundId", fundId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void ActivateFundInfo(int fundId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ActivateFund";
                command.Parameters.Add(new SqlParameter("fundId", fundId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateFundInfo(int fundid, string fAcct, string fName, string fAbbrv, int fFundsType,
                                            string vhcbCode, int lkAcctMethod, string deptId, bool drawDown)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateFundInfo";
                command.Parameters.Add(new SqlParameter("fundId", fundid));
                command.Parameters.Add(new SqlParameter("fAccount", fAcct));
                command.Parameters.Add(new SqlParameter("fName", fName));
                command.Parameters.Add(new SqlParameter("fAbbrv", fAbbrv));
                command.Parameters.Add(new SqlParameter("fFundsType", fFundsType));

                command.Parameters.Add(new SqlParameter("vHCBCode", vhcbCode));
                command.Parameters.Add(new SqlParameter("lkAcctMethod", lkAcctMethod));
                command.Parameters.Add(new SqlParameter("deptId", deptId));
                command.Parameters.Add(new SqlParameter("drawDown", drawDown));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetFundInfoDetails(bool IsActiveOnly)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundInfoDetails";
                command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetFundInfoDetailsByLastModified(bool IsActiveOnly)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundInfoDetailsByLastModified";
                command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetGrantInfoDetailsByFund(int FundId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetGrantInfoDetailsByFund";
                command.Parameters.Add(new SqlParameter("FundId", FundId));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static void AddGrantInfo(int fundId,
            string GrantName
           , string VHCBName
           , int LkGrantor
           , Nullable<int> LkGrantSource
           , string AwardNum
           , decimal AwardAmt
           , Nullable<DateTime> BeginDate
           , Nullable<DateTime> EndDate
           , Nullable<int> Staff
           , Nullable<int> ContactID
           , string CFDA
           , bool SignAgree
           , bool FedFunds
           , bool Match
           , bool Fundsrec
           , bool Admin)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddGrantInfo";
                command.Parameters.Add(new SqlParameter("fundId", fundId));
                command.Parameters.Add(new SqlParameter("GrantName", GrantName));
                command.Parameters.Add(new SqlParameter("VHCBName", VHCBName));
                command.Parameters.Add(new SqlParameter("LkGrantor", LkGrantor));
                command.Parameters.Add(new SqlParameter("LkGrantSource", LkGrantSource));
                command.Parameters.Add(new SqlParameter("AwardNum", AwardNum));
                command.Parameters.Add(new SqlParameter("AwardAmt", AwardAmt));
                command.Parameters.Add(new SqlParameter("BeginDate", BeginDate));
                command.Parameters.Add(new SqlParameter("EndDate", EndDate));
                command.Parameters.Add(new SqlParameter("Staff", Staff));
                command.Parameters.Add(new SqlParameter("ContactID", ContactID));
                command.Parameters.Add(new SqlParameter("CFDA", CFDA));
                command.Parameters.Add(new SqlParameter("SignAgree", SignAgree));
                command.Parameters.Add(new SqlParameter("FedFunds", FedFunds));
                command.Parameters.Add(new SqlParameter("Match", Match));
                command.Parameters.Add(new SqlParameter("Fundsrec", Fundsrec));
                command.Parameters.Add(new SqlParameter("Admin", Admin));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateGrantInfo(int GrantInfoId,
                                            string GrantName,
                                            string VHCBName,
                                            int LkGrantor
                                            , Nullable<int> LkGrantSource
                                            , string AwardNum
                                            , decimal AwardAmt
                                            , Nullable<DateTime> BeginDate
                                            , Nullable<DateTime> EndDate
                                            , Nullable<int> Staff
                                            , Nullable<int> ContactID
                                            , string CFDA
                                            , bool SignAgree
                                            , bool FedFunds
                                            , bool Match
                                            , bool Fundsrec
                                            , bool Admin)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateGrantInfo";
                command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                command.Parameters.Add(new SqlParameter("GrantName", GrantName));
                command.Parameters.Add(new SqlParameter("VHCBName", VHCBName));
                command.Parameters.Add(new SqlParameter("LkGrantor", LkGrantor));
                command.Parameters.Add(new SqlParameter("LkGrantSource", LkGrantSource));
                command.Parameters.Add(new SqlParameter("AwardNum", AwardNum));
                command.Parameters.Add(new SqlParameter("AwardAmt", AwardAmt));
                command.Parameters.Add(new SqlParameter("BeginDate", BeginDate));
                command.Parameters.Add(new SqlParameter("EndDate", EndDate));
                command.Parameters.Add(new SqlParameter("Staff", Staff));
                command.Parameters.Add(new SqlParameter("ContactID", ContactID));
                command.Parameters.Add(new SqlParameter("CFDA", CFDA));
                command.Parameters.Add(new SqlParameter("SignAgree", SignAgree));
                command.Parameters.Add(new SqlParameter("FedFunds", FedFunds));
                command.Parameters.Add(new SqlParameter("Match", Match));
                command.Parameters.Add(new SqlParameter("Fundsrec", Fundsrec));
                command.Parameters.Add(new SqlParameter("Admin", Admin));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteGrantInfo(int GrantInfoId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteGrantInfo";
                command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetGrantInfoFYAmount(int GrantInfoId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetGrantInfoFYAmount";
                command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static void AddGrantInfoFyAmt(int GrantInfoId, int LkYear, decimal Amount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddGrantInfoFyAmt";
                command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                command.Parameters.Add(new SqlParameter("LkYear", LkYear));
                command.Parameters.Add(new SqlParameter("Amount", Amount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void UpdateGrantInfoFYAmt(int GrantInfoFy, int LkYear, decimal Amount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateGrantInfoFYAmt";
                command.Parameters.Add(new SqlParameter("GrantInfoFy", GrantInfoFy));
                command.Parameters.Add(new SqlParameter("LkYear", LkYear));
                command.Parameters.Add(new SqlParameter("Amount", Amount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteGrantInfoFyAmt(int GrantInfoFy)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteGrantInfoFyAmt";
                command.Parameters.Add(new SqlParameter("GrantInfoFy", GrantInfoFy));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetFinancialTransactions(int projectId, DateTime transStartDate, DateTime transEndDate, int financial_tran_action_id)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtTrans = new DataTable();
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinancialTransactionDetails";
                command.Parameters.Add(new SqlParameter("project_id", projectId));
                command.Parameters.Add(new SqlParameter("tran_start_date", transStartDate));
                command.Parameters.Add(new SqlParameter("tran_end_date", transEndDate));
                command.Parameters.Add(new SqlParameter("financial_transaction_action_id", financial_tran_action_id));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTrans = ds.Tables[0];
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
            return dtTrans;
        }

        public static DataTable GetFinancialTransactionDetails(int TransId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtTrans = new DataTable();
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinancialTransactionDetailDetails";
                command.Parameters.Add(new SqlParameter("transId", TransId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTrans = ds.Tables[0];
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
            return dtTrans;
        }


        public static void UpdateFinancialTransactionStatus(int TransId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateFinancialTransactionStatus";
                command.Parameters.Add(new SqlParameter("transId", TransId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void DeleteTransactionDetail(int DetailId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteTransactionDetail";
                command.Parameters.Add(new SqlParameter("detailId", DetailId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataRow GetTransactionDetailsByDetailId(int DetailID)
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
                        command.CommandText = "GetTransactionDetailsByDetailId";
                        command.Parameters.Add(new SqlParameter("DetailID", DetailID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
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

        // VOID
        public static DataTable GetFinalizeTransactions(int ProjectId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtTrans = new DataTable();
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFinalizeTransactions";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTrans = ds.Tables[0];
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
            return dtTrans;
        }

        public static void SubmitVoidTransaction(int TransId, int UserId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "SubmitVoidTransaction";
                command.Parameters.Add(new SqlParameter("transId", TransId));
                command.Parameters.Add(new SqlParameter("UserId", UserId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataTable GetExistingAdjustmentByProjId(string ProjId)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projId", Convert.ToInt32(ProjId)));
                command.CommandText = "GetExistingAdjustmentByProjId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static AdjustmentResult SubmitAdjustmentTransaction(int ProjId, decimal TransAmt,
            int FundId, int FundTtransType, string Comment, int UserID, int LkTransaction, int LandUsePermitId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "SubmitAdjustmentTransaction";

                command.Parameters.Add(new SqlParameter("ProjId", ProjId));
                command.Parameters.Add(new SqlParameter("TransAmt", TransAmt));
                command.Parameters.Add(new SqlParameter("FundId", FundId));
                command.Parameters.Add(new SqlParameter("FundTtransType", FundTtransType));
                //command.Parameters.Add(new SqlParameter("LandUsePermitID", LandUsePermitID));
                command.Parameters.Add(new SqlParameter("Comment", Comment));
                command.Parameters.Add(new SqlParameter("UserID", UserID));
                command.Parameters.Add(new SqlParameter("LkTransaction", LkTransaction));

                if(LandUsePermitId !=0)
                command.Parameters.Add(new SqlParameter("LandUsePermitId", LandUsePermitId));

                SqlParameter parmMessage = new SqlParameter("@TransId", SqlDbType.Int);
                parmMessage.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmMessage);

                SqlParameter parmMessage1 = new SqlParameter("@DetailId", SqlDbType.Int);
                parmMessage1.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmMessage1);

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();

                    AdjustmentResult objAdjustmentResult = new AdjustmentResult();
                    objAdjustmentResult.TransId = DataUtils.GetInt(command.Parameters["@TransId"].Value.ToString());
                    objAdjustmentResult.DetailId = DataUtils.GetInt(command.Parameters["@DetailId"].Value.ToString());

                    return objAdjustmentResult;
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
        }

        public static void UpdaeAdjustmentTransaction(int Transid, int DetailId, int ProjId, decimal TransAmt,
            int FundId, int FundTtransType, string Comment, int UserID, int LkTransaction, int LandUsePermitId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdaeAdjustmentTransaction";

                command.Parameters.Add(new SqlParameter("Transid", Transid));
                command.Parameters.Add(new SqlParameter("DetailId", DetailId));
                command.Parameters.Add(new SqlParameter("ProjId", ProjId));
                command.Parameters.Add(new SqlParameter("TransAmt", TransAmt));
                command.Parameters.Add(new SqlParameter("FundId", FundId));
                command.Parameters.Add(new SqlParameter("FundTtransType", FundTtransType));
                //command.Parameters.Add(new SqlParameter("LandUsePermitID", LandUsePermitID));
                command.Parameters.Add(new SqlParameter("Comment", Comment));
                command.Parameters.Add(new SqlParameter("UserID", UserID));
                command.Parameters.Add(new SqlParameter("LkTransaction", LkTransaction));

                if (LandUsePermitId != 0)
                    command.Parameters.Add(new SqlParameter("LandUsePermitId", LandUsePermitId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static string GetAccountNumberByFundId(int fundid)
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
                        command.CommandText = "GetAccountNumberByFundId";

                        command.Parameters.Add(new SqlParameter("fundid", fundid));


                        SqlParameter parmMessage = new SqlParameter("@account", SqlDbType.NVarChar, 20);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                        return  command.Parameters["@account"].Value.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DateTime GetSetupDate()
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
                        command.CommandText = "getSetupDate";

                        SqlParameter parmMessage = new SqlParameter("@AcctEffectiveDate", SqlDbType.DateTime);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
                        return DateTime.Parse(command.Parameters["@AcctEffectiveDate"].Value.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    public class AdjustmentResult
    {
        public int TransId { set; get; }
        public int DetailId { set; get; }
    }
}
