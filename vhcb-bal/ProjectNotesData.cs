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
    public class ProjectNotesData
    {
        public static void AddProjectNotes(int ProjectID, int LkCategory, string UserName, string Notes, 
            DateTime Date, string URL, int? pcrid = null, int? PageId = null)
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
                        command.CommandText = "AddProjectNotes";

                        //5 Parameters 
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LkCategory", LkCategory));
                        command.Parameters.Add(new SqlParameter("UserName", UserName));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("pcrid", pcrid));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("PageId", PageId));
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


        public static void UpdateProjectNotes(int ProjectNotesID, int LkCategory, string Notes, string URL, bool RowIsActive)
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
                        command.CommandText = "UpdateProjectNotes";

                        //12 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectNotesID", ProjectNotesID));
                        command.Parameters.Add(new SqlParameter("LkCategory", LkCategory));
                        //command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("URL", URL));
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

        public static DataTable GetProjectNotesList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectNotesList";
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

        public static DataRow GetProjectNotesById(int ProjectNotesId)
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
                        command.CommandText = "GetProjectNotesById";
                        command.Parameters.Add(new SqlParameter("ProjectNotesId", ProjectNotesId));

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
            return dt.Rows[0];
        }

        public static int GetPageId(string PageName)
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
                        command.CommandText = "GetPageId";
                        command.Parameters.Add(new SqlParameter("PageName", PageName));

                        SqlParameter parmMessage1 = new SqlParameter("@PageId", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return DataUtils.GetInt(command.Parameters["@PageId"].Value.ToString()); ;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static bool IsNotesExist(int PageId, int ProjectId)
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
                        command.CommandText = "IsNotesExist";
                        command.Parameters.Add(new SqlParameter("PageId", PageId));
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        SqlParameter parmMessage = new SqlParameter("@IsNotesExist", SqlDbType.Int);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return DataUtils.GetBool(command.Parameters["@IsNotesExist"].Value.ToString()); ;

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
