using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace VHCBCommon.DataAccessLayer
{
    public class InactiveProjectData
    {
        public static InactiveProjectResult AddInactiveProject(string ProjectNumber, string LoginName, string Password, bool RowIsActive)
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
                        command.CommandText = "AddInactiveProject";
                        command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));
                        command.Parameters.Add(new SqlParameter("LoginName", LoginName));
                        command.Parameters.Add(new SqlParameter("Password", Password));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));


                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        InactiveProjectResult ap = new InactiveProjectResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());


                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable BindPrograms()
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
                        command.CommandText = "GetTempProgramTypes";

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

        public static DataTable GetInActivetempProjects(string SufixProjectNumber)
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
                        command.CommandText = "GetInActivetempProjects";
                        command.Parameters.Add(new SqlParameter("SufixProjectNumber", SufixProjectNumber));

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

        public static void ActivateTempProject(int TempUserID)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ActivateTempProject";
                command.Parameters.Add(new SqlParameter("TempUserID", TempUserID));

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

    public class InactiveProjectResult
    {
        public bool IsDuplicate { set; get; }
    }
}
