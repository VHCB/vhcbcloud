using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VHCBCommon.DataAccessLayer;

namespace DataAccessLayer
{
    public class ProjectSearchData
    {
        public static DataTable ProjectSearch(string ProjNum, string ProjectName, string AppName, string LKProgram,
            string LKProjectType, string Town, string County, bool IsPrimaryApplicant)
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
                        command.CommandText = "ProjectSearch";

                        //7 Parameters 
                        if (ProjNum != "____-___")
                            command.Parameters.Add(new SqlParameter("ProjNum", ProjNum));
                        if (string.IsNullOrWhiteSpace(ProjectName) == false)
                            command.Parameters.Add(new SqlParameter("ProjectName", ProjectName));
                        if (AppName != "")
                            command.Parameters.Add(new SqlParameter("AppName", AppName));
                        if (LKProgram != "NA")
                            command.Parameters.Add(new SqlParameter("LKProgram", DataUtils.GetInt(LKProgram)));
                        if (LKProjectType != "NA")
                            command.Parameters.Add(new SqlParameter("LKProjectType", DataUtils.GetInt(LKProjectType)));
                        if (Town != "NA")
                            command.Parameters.Add(new SqlParameter("Town", Town));
                        if (County != "NA")
                            command.Parameters.Add(new SqlParameter("County", County));

                        command.Parameters.Add(new SqlParameter("IsPrimaryApplicant", IsPrimaryApplicant));

                        command.CommandTimeout = 60 * 5;

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


        public static DataTable GetProjectNumbers(string ProjectNumPrefix)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectNumbers";
                command.Parameters.Add(new SqlParameter("ProjectNum", ProjectNumPrefix));
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

        public static DataTable GetProjectNumbersWithName(string ProjectNumPrefix)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectNumbersWithName";
                command.Parameters.Add(new SqlParameter("ProjectNum", ProjectNumPrefix));
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

        public static DataTable GetProjectNumbersWithNameAndProjectType(string ProjectNumPrefix)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectNumbersWithNameAndProjectType";
                command.Parameters.Add(new SqlParameter("ProjectNum", ProjectNumPrefix));
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
    }
}
