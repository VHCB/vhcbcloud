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

        public static bool IsDuplicateFundDetailPerTransaction(int transid, int fundid, int fundtranstype)
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


        public static void AddProjectFundDetails(int transid, int fundid, int fundtranstype, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddProjectFundDetails";
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

        public static void AddProjectFundDetails(int transid, int fundid, int fundtranstype, decimal fundamount, string usePermit)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddProjectFundDetailsWithLandPermit";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));
                command.Parameters.Add(new SqlParameter("LandUsePermit", usePermit));

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
        public static DataTable AddBoardReallocationTransaction(int FromProjectId, int ToProjectId, DateTime transDate, int Fromfundid, int Fromfundtranstype,
                                decimal Fromfundamount, int Tofundid, int Tofundtranstype, decimal Tofundamount, Nullable<int> fromTransId, Nullable<int> toTransId)
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

        public static DataTable GetAvailableFundsPerProjAcctFundtype(int projectId, string account, int fundtypeId)
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

        public static DataTable AddBoardFinancialTransaction(int projectId, DateTime transDate, decimal transAmt, Nullable<int> payeeAppl, string CommitmentType, int lkStatus)
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

        public static DataTable GetFundInfoDetails()
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundInfoDetails";
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

        public static DataTable GetFundInfoDetailsByLastModified()
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundInfoDetailsByLastModified";
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

    }
}
