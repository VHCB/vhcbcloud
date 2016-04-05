using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class ProjectMaintenanceData
    {
        public static string AddProject(string ProjNum, int LkProjectType, int LkProgram, DateTime AppRec, int LkAppStatus, int Manager, int LkBoardDate, 
            DateTime ClosingDate, DateTime ExpireDate, bool verified, int appNameId, string projName)
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
                        command.CommandText = "add_new_project";

                        //12 Parameters 
                        command.Parameters.Add(new SqlParameter("projNum", ProjNum));
                        command.Parameters.Add(new SqlParameter("LkProjectType", LkProjectType));
                        command.Parameters.Add(new SqlParameter("LkProgram", LkProgram));
                        command.Parameters.Add(new SqlParameter("AppRec", AppRec));
                        command.Parameters.Add(new SqlParameter("LkAppStatus", LkAppStatus));
                        command.Parameters.Add(new SqlParameter("Manager", Manager));
                        command.Parameters.Add(new SqlParameter("LkBoardDate", LkBoardDate));
                        command.Parameters.Add(new SqlParameter("ClosingDate", ClosingDate));
                        command.Parameters.Add(new SqlParameter("GrantClosingDate", ExpireDate));
                        command.Parameters.Add(new SqlParameter("verified", verified));
                        command.Parameters.Add(new SqlParameter("appNameId", appNameId));
                        command.Parameters.Add(new SqlParameter("projName", projName));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return command.Parameters["@isDuplicate"].Value.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateProject(int ProjId, int LkProjectType, int LkProgram, string AppRec, int LkAppStatus, int Manager, int LkBoardDate,
           string ClosingDate, string ExpireDate, bool verified, int appNameId, string projName)
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
                        command.CommandText = "UpdateProjectInfo";

                        //12 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjId));
                        command.Parameters.Add(new SqlParameter("LkProjectType", LkProjectType));
                        command.Parameters.Add(new SqlParameter("LkProgram", LkProgram));
                        command.Parameters.Add(new SqlParameter("AppRec", AppRec == "" ? System.Data.SqlTypes.SqlDateTime.Null : DateTime.Parse(AppRec)));
                        command.Parameters.Add(new SqlParameter("LkAppStatus", LkAppStatus));
                        command.Parameters.Add(new SqlParameter("Manager", Manager));
                        command.Parameters.Add(new SqlParameter("LkBoardDate", LkBoardDate));
                        command.Parameters.Add(new SqlParameter("ClosingDate", ClosingDate == "" ? System.Data.SqlTypes.SqlDateTime.Null : DateTime.Parse(ClosingDate)));
                        command.Parameters.Add(new SqlParameter("GrantClosingDate", ExpireDate == "" ? System.Data.SqlTypes.SqlDateTime.Null : DateTime.Parse(ExpireDate)));
                        command.Parameters.Add(new SqlParameter("verified", verified));
                        command.Parameters.Add(new SqlParameter("appNameId", appNameId));
                       // command.Parameters.Add(new SqlParameter("projName", projName));
                        
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

        public static DataRow GetprojectDetails(int ProjectId)
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
                        command.CommandText = "getProjectDetails";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
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

        public static void AddProjectName(int ProjectId, string ProjectName, bool DefName)
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
                        command.CommandText = "AddProjectName";

                        //12 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("projName", ProjectName));
                        command.Parameters.Add(new SqlParameter("DefName", DefName));
                       
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

        public static void UpdateProjectname(int ProjectId, int TypeID, string ProjectName, bool DefName)
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
                        command.CommandText = "UpdateProjectName";

                        //4 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("TypeId", TypeID));
                        command.Parameters.Add(new SqlParameter("ProjectName", ProjectName));
                        command.Parameters.Add(new SqlParameter("DefName", DefName));
                       
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

        public static DataTable GetProjectNames(int ProjectId)
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
                        command.CommandText = "GetProjectNames";
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
    }
}