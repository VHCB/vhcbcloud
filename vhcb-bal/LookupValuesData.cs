using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace DataAccessLayer
{
    public class LookupValuesData
    {
        public static DataTable Getlookupvalues(int LookupType)
        {
            DataTable dtLookupvalues = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "get_lookup_values";
                        command.Parameters.Add(new SqlParameter("lookuptype", LookupType));
                        
                        command.CommandTimeout = 60 * 5;

                        var ds = new DataSet();
                        var da = new SqlDataAdapter(command);

                        da.Fill(ds);

                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dtLookupvalues = ds.Tables[0];
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

            return dtLookupvalues;
        }

        public static DataTable GetManagers()
        {
            DataTable dtManagers = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "get_managers";
                        
                        command.CommandTimeout = 60 * 5;

                        var ds = new DataSet();
                        var da = new SqlDataAdapter(command);

                        da.Fill(ds);

                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dtManagers = ds.Tables[0];
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

            return dtManagers;
        }

        public static DataTable GetBoardDates()
        {
            DataTable dtBoardDates = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "get_boardDates";

                        command.CommandTimeout = 60 * 5;

                        var ds = new DataSet();
                        var da = new SqlDataAdapter(command);

                        da.Fill(ds);

                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dtBoardDates = ds.Tables[0];
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

            return dtBoardDates;
        }
    }
}
