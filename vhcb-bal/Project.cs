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
    public static class Project
    {
        public static DataTable GetProjects(string ProcName)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = ProcName;
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
                System.Diagnostics.Debug.WriteLine("Could not connect to Database :" +ex.Message);
            }
            finally
            {
                connection.Close();
            }
            return dtProjects;
        }

        public static void UpdateProjectName(string projName, int nameId)
        {
             var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
             try
             {
                 SqlCommand command = new SqlCommand();
                 command.CommandType = CommandType.StoredProcedure;
                 command.CommandText = "UpdateProject";
                 command.Parameters.Add(new SqlParameter("projName", projName));
                 command.Parameters.Add(new SqlParameter("nameId", nameId));
                 
                 using (connection)
                 {
                     connection.Open();
                     command.Connection = connection;
                     command.ExecuteNonQuery();
                 }
             }
             catch (Exception ex)
             {
                 System.Diagnostics.Debug.WriteLine("Could not connect to Database :" + ex.Message);
             }
             finally
             {
                 connection.Close();
             }
        }

        public static DataTable GetProjectsByProjectId(int projectID)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectsByProjectId";
                command.Parameters.Add(new SqlParameter("projId", projectID));
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
                System.Diagnostics.Debug.WriteLine("Could not connect to Database :" + ex.Message);
            }
            finally
            {
                connection.Close();
            }
            return dtProjects;
        }
    }
}
