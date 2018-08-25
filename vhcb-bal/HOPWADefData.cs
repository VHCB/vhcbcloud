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
    public class HOPWADefData
    {
        public static DataTable GetHOPWADefaultsList(bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWADefaultsList";
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

        public static DataTable GetHOPWADefaults()
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
                        command.CommandText = "GetHOPWADefaults";

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

        public static void AddHOPWADefaults(bool IsCurrent, int CurrentFund, DateTime FundStartDate,
            DateTime FundEndDate, int PreviousFund, int Year, decimal STRMUMaxAmt)
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
                        command.CommandText = "AddHOPWADefaults";

                        //12 Parameters
                        command.Parameters.Add(new SqlParameter("IsCurrent", IsCurrent));
                        command.Parameters.Add(new SqlParameter("CurrentFund", CurrentFund));
                        command.Parameters.Add(new SqlParameter("FundStartDate", FundStartDate));
                        command.Parameters.Add(new SqlParameter("FundEndDate", FundEndDate));
                        command.Parameters.Add(new SqlParameter("PreviousFund", PreviousFund));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("STRMUMaxAmt", STRMUMaxAmt));
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

        public static void UpdateHOPWADefaults(int HOPWADefaultID, 
            bool IsCurrent, int CurrentFund, DateTime FundStartDate,
            DateTime FundEndDate, int PreviousFund, int Year, decimal STRMUMaxAmt)
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
                        command.CommandText = "UpdateHOPWADefaults";

                        //12 Parameters
                        command.Parameters.Add(new SqlParameter("HOPWADefaultID", HOPWADefaultID));
                        command.Parameters.Add(new SqlParameter("IsCurrent", IsCurrent));
                        command.Parameters.Add(new SqlParameter("CurrentFund", CurrentFund));
                        command.Parameters.Add(new SqlParameter("FundStartDate", FundStartDate));
                        command.Parameters.Add(new SqlParameter("FundEndDate", FundEndDate));
                        command.Parameters.Add(new SqlParameter("PreviousFund", PreviousFund));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("STRMUMaxAmt", STRMUMaxAmt));
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
    }
}
