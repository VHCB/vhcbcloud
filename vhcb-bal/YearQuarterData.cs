using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace VHCBCommon.DataAccessLayer
{
    public static class YearQuarterData
    {
        public static DataTable GetAllYearQuarterDetails()
        {
            DataTable dtYrQtr = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllYearQuarterDetails";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtYrQtr = ds.Tables[0];
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
            return dtYrQtr;
        }

        public static DataTable GetAllYearQuarterDetailsForImport()
        {
            DataTable dtYrQtr = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAllYearQuarterDetailsForImport";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtYrQtr = ds.Tables[0];
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
            return dtYrQtr;
        }
        public static void DeleteYearQuarterDetails(int yrQrtrId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteYearQuarterId";
                command.Parameters.Add(new SqlParameter("yrQrtrId", yrQrtrId));

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

        public static YearQrtrResult AddYearQuarter(int Year, int Qtr)
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
                        command.CommandText = "AddYearQuarter";

                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("Qtr", Qtr));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                      
                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        YearQrtrResult yqr = new YearQrtrResult();

                        yqr.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());

                        return yqr;
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
           
        }

        public static void AddPerformanceMaster(int SourceYearQtrId, int DestinationYearQtrId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                using (connection)
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "AddPerformanceMaster";

                        command.Parameters.Add(new SqlParameter("SourceYearQtrId", SourceYearQtrId));
                        command.Parameters.Add(new SqlParameter("DestinationYearQtrId", DestinationYearQtrId));

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();
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
        }

        public static DataTable GetQuestionAnswerList(int ACYrQtrId)
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
                        command.CommandText = "GetQuestionAnswerList";
                        command.Parameters.Add(new SqlParameter("ACYrQtrID", ACYrQtrId));
                     
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

        public static void UpdateQuestions(int ACPerformanceMasterID, int QuestionNum, string Question, int ResultType,bool IsActive)
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
                        command.CommandText = "UpdateQuestions";
                        command.Parameters.Add(new SqlParameter("ACPerformanceMasterID", ACPerformanceMasterID));
                        command.Parameters.Add(new SqlParameter("QuestionNum", QuestionNum));
                        command.Parameters.Add(new SqlParameter("Question", Question));
                        command.Parameters.Add(new SqlParameter("ResultType", ResultType));
                        command.Parameters.Add(new SqlParameter("IsActive", IsActive));
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }


    public class YearQrtrResult
    {
        public bool IsDuplicate { set; get; }
    }
    
}
