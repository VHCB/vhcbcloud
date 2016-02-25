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

                SqlParameter parmIsValid = new SqlParameter("@ReturnData", SqlDbType.VarChar, 5);
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

        public static DataTable GetUserInfo()
        {
            DataTable dtUserInfo = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetUserInfo";
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

        public static void AddUserInfo(string firstName, string lastName, string password, string email)
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

        public static void UpdateUserInfo(int UserId, string firstName, string lastName, string password, string email)
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
}