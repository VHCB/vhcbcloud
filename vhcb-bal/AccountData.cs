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
    }
}