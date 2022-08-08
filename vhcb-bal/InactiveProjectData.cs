using DataAccessLayer;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace VHCBCommon.DataAccessLayer
{
    public class InactiveProjectData
    {
        public static InactiveProjectResult AddInactiveProject(string ProjectNumber, string LoginName, string Password, int ApplicationID, int PortfolioTypeId, int Year, bool RowIsActive)
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
                        command.Parameters.Add(new SqlParameter("ApplicationID", ApplicationID));
                        command.Parameters.Add(new SqlParameter("PortfolioTypeId", PortfolioTypeId));
                        command.Parameters.Add(new SqlParameter("Year", Year));
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

        public static InactiveProjectResult AddInactiveHousingProject(string ProjectNumber, string LoginName, string Password, int ApplicationID, int PortfolioTypeId, int Year, bool RowIsActive)
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
                        command.CommandText = "AddInactiveHousingProject";
                        command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));
                        command.Parameters.Add(new SqlParameter("LoginName", LoginName));
                        command.Parameters.Add(new SqlParameter("Password", Password));
                        command.Parameters.Add(new SqlParameter("ApplicationID", ApplicationID));
                        command.Parameters.Add(new SqlParameter("PortfolioTypeId", PortfolioTypeId));
                        command.Parameters.Add(new SqlParameter("Year", Year));
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

        public static DataTable GetPDFEmailReceiveUsers()
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
                        command.CommandText = "GetPDFEmailReceiveUsers";

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

        public static DataTable GetTempApplicationTypes(int Program)
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
                        command.CommandText = "GetTempApplicationTypes";
                        command.Parameters.Add(new SqlParameter("Program", Program));

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

        public static ProjectMaintResult AddOnlineEmailAddresses(int Program, int ApplicationType, string Name, string Email_Address, string ProjectNumber)
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
                        command.CommandText = "AddOnlineEmailAddresses";
                        command.Parameters.Add(new SqlParameter("Program", Program));
                        command.Parameters.Add(new SqlParameter("ApplicationType", ApplicationType));
                        command.Parameters.Add(new SqlParameter("Name", Name));
                        command.Parameters.Add(new SqlParameter("Email_Address", Email_Address));
                        command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Bit);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        ProjectMaintResult objResult = new ProjectMaintResult();



                        objResult.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objResult.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objResult;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateOnlineEmailAddresses(int Email_AddressID, int Program, int ApplicationType, string Name, string Email_Address, string ProjectNumber, bool RowIsActive)
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
                        command.CommandText = "UpdateOnlineEmailAddresses";
                        command.Parameters.Add(new SqlParameter("Email_AddressID", Email_AddressID));
                        command.Parameters.Add(new SqlParameter("Program", Program));
                        command.Parameters.Add(new SqlParameter("ApplicationType", ApplicationType));
                        command.Parameters.Add(new SqlParameter("Name", Name));
                        command.Parameters.Add(new SqlParameter("Email_Address", Email_Address));
                        command.Parameters.Add(new SqlParameter("Proj_num", ProjectNumber));
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

        public static DataTable GetOnlineEmailAddressesList(bool ActiveOnly)
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
                        command.CommandText = "GetOnlineEmailAddressesList";


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

        public static DataRow GetOnlineEmailAddressById(int EmailAddressId)
        {
            DataRow dt = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetOnlineEmailAddressById";
                        command.Parameters.Add(new SqlParameter("EmailAddressId", EmailAddressId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0].Rows[0];
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

        public static DataTable GetOnlineEmailAddresses(int Program, int ApplicationType)
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
                        command.CommandText = "GetOnlineEmailAddresses";
                        command.Parameters.Add(new SqlParameter("Program", Program));
                        command.Parameters.Add(new SqlParameter("ApplicationType", ApplicationType));

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

        public static void DeleteOnlineEmailAddresses(int Program, int ApplicationType)
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
                        command.CommandText = "DeleteOnlineEmailAddresses";
                        command.Parameters.Add(new SqlParameter("Program", Program));
                        command.Parameters.Add(new SqlParameter("ApplicationType", ApplicationType));

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


        public static DataTable GetProjectNumbersFromTempUser(string ProjectNumPrefix)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectNumbersFromTempUser";
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

        public static DataRow GetProjectNameByProjectNumber(string proj_num)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetProjectNameByProjectNumber";
                        command.Parameters.Add(new SqlParameter("proj_num", proj_num));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
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

        public static DataRow GetUserInfoByUserId(int UserId)
        {
            DataRow dt = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetUserInfoByUserId";
                        command.Parameters.Add(new SqlParameter("UserId", UserId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
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

        public static InactiveConservationProjectResult AddInactiveConservationProject(string ProjectNumber, string LoginName, string Password, int ApplicationID, int PortfolioTypeId, bool RowIsActive)
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
                        command.CommandText = "AddInactiveConservationProject";
                        command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));
                        command.Parameters.Add(new SqlParameter("LoginName", LoginName));
                        command.Parameters.Add(new SqlParameter("Password", Password));
                        command.Parameters.Add(new SqlParameter("ApplicationID", ApplicationID));
                        command.Parameters.Add(new SqlParameter("PortfolioTypeId", PortfolioTypeId));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));


                        SqlParameter parmMessage = new SqlParameter("@isProjectNotExist", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        InactiveConservationProjectResult ap = new InactiveConservationProjectResult();

                        ap.IsProjectNotExist = DataUtils.GetBool(command.Parameters["@isProjectNotExist"].Value.ToString());


                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable GetConservationProjectNumbers(string ProjectNumPrefix)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetConservationProjectNumbers";
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
    public class InactiveProjectResult
    {
        public bool IsDuplicate { set; get; }
    }

    public class InactiveConservationProjectResult
    {
        public bool IsProjectNotExist { set; get; }
    }
}

