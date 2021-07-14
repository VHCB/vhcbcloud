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
    public static class AccountData
    {  
        public static string CheckUserLogin(string UserName, string Password)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "IsValidUser";
                command.Parameters.Add(new SqlParameter("Username", UserName));
                command.Parameters.Add(new SqlParameter("Password", Password));

                SqlParameter parmIsValid = new SqlParameter("@ReturnData", SqlDbType.VarChar, 110);
                parmIsValid.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmIsValid);

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();

                    return command.Parameters["@ReturnData"].Value.ToString();
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

        public static void SetPassword(string UserName, string NewPassword)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "SetPassword";
                command.Parameters.Add(new SqlParameter("Username", UserName));
                command.Parameters.Add(new SqlParameter("NewPassword", NewPassword));

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

        public static DataTable GetUserInfo(bool IsActiveOnly)
        {
            DataTable dtUserInfo = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetUserInfo";
                command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtUserInfo = ds.Tables[0];
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
            return dtUserInfo;
        }

        public static DataTable GetVHCBProgram()
        {
            DataTable dtUserInfo = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetVHCBProgram";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtUserInfo = ds.Tables[0];
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
            return dtUserInfo;
        }

        public static void AddUserInfo(string firstName, string lastName, string password, 
            string email, int DfltPrg, int dfltSecGrp, string NumbProj, string HostSite, bool Dashboard, string DashboardName, bool isReceivePDF)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddUserInfo";
                command.Parameters.Add(new SqlParameter("Fname", firstName));
                command.Parameters.Add(new SqlParameter("Lname", lastName));
                command.Parameters.Add(new SqlParameter("password", password));
                command.Parameters.Add(new SqlParameter("email", email));
                command.Parameters.Add(new SqlParameter("DfltPrg", DfltPrg));
                command.Parameters.Add(new SqlParameter("dfltSecGrp", dfltSecGrp));
                command.Parameters.Add(new SqlParameter("NumbProj", NumbProj));
                command.Parameters.Add(new SqlParameter("HostSite", HostSite));
                command.Parameters.Add(new SqlParameter("Dashboard", Dashboard));
                command.Parameters.Add(new SqlParameter("DashboardName", DashboardName));
                command.Parameters.Add(new SqlParameter("isReceivePDF", isReceivePDF));
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

        public static void UpdateUserInfo(int UserId, string firstName, string lastName, string password, 
            string email, int DfltPrg, int dfltSecGrp, string NumbProj, string HostSite, bool RowIsActive, 
            bool Dashboard, string DashboardName, bool isReceivePDF)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateUserInfo";
                command.Parameters.Add(new SqlParameter("UserId", UserId));
                command.Parameters.Add(new SqlParameter("Fname", firstName));
                command.Parameters.Add(new SqlParameter("Lname", lastName));
                command.Parameters.Add(new SqlParameter("password", password));
                command.Parameters.Add(new SqlParameter("email", email));
                command.Parameters.Add(new SqlParameter("DfltPrg", DfltPrg));
                command.Parameters.Add(new SqlParameter("dfltSecGrp", dfltSecGrp));
                command.Parameters.Add(new SqlParameter("NumbProj", NumbProj));
                command.Parameters.Add(new SqlParameter("HostSite", HostSite));
                command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));
                command.Parameters.Add(new SqlParameter("Dashboard", Dashboard));
                command.Parameters.Add(new SqlParameter("DashboardName", DashboardName));
                command.Parameters.Add(new SqlParameter("isReceivePDF", isReceivePDF));

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

        public static void UpdateDashboard(int UserId, string DashboardName)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "UpdateDashboard";
                command.Parameters.Add(new SqlParameter("UserId", UserId));
                command.Parameters.Add(new SqlParameter("DashboardName", DashboardName));

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
        public static DataRow GetUserInfoById(int UserId)
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
                        command.CommandText = "GetUserInfoById";
                        command.Parameters.Add(new SqlParameter("UserId", UserId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
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

        public static bool CheckExternalUserLogin(string ProjectNumber, string UserName, string Password)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "IsValidExternalUser";
                command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));
                command.Parameters.Add(new SqlParameter("Username", UserName));
                command.Parameters.Add(new SqlParameter("Password", Password));

                SqlParameter parmIsValid = new SqlParameter("@IsValidUser", SqlDbType.Bit);
                parmIsValid.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmIsValid);

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();

                    return DataUtils.GetBool(command.Parameters["@IsValidUser"].Value.ToString());
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