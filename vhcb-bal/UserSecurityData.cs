using DataAccessLayer;
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
    public static class UserSecurityData
    {
        public static DataTable GetData(string ProcName)
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
                throw ex;
            }
            finally
            {
                connection.Close();
            }
            return dtProjects;
        }

        public static DataTable GetPageSecurityBySelection(int RecordId)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetPageSecurityBySelection";
                command.Parameters.Add(new SqlParameter("recordid", RecordId));
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

        public static void AddUserPageSecurity(int userId, int pageid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddUserPageSecurity";
                command.Parameters.Add(new SqlParameter("userid", userId));
                command.Parameters.Add(new SqlParameter("pageid", pageid));

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

        public static DataTable GetuserPageSecurity(int userid)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetuserPageSecurity";
                command.Parameters.Add(new SqlParameter("userid", userid));
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

        public static DataTable GetMasterPageSecurity(int userid)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetMasterPageSecurity";
                command.Parameters.Add(new SqlParameter("userid", userid));
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

        public static void AddUsersToSecurityGroup(int userId, int usergroupId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "AddUsersToSecurityGroup";
                command.Parameters.Add(new SqlParameter("userid", userId));
                command.Parameters.Add(new SqlParameter("usergroupid", usergroupId));

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


        public static bool GetRoleAuth(string username, int projId)
        {
            bool isVerified = false;
            DataTable dtPrg = new DataTable();


            DataRow drProjectDetails = ProjectMaintenanceData.GetprojectDetails(projId);

            if (drProjectDetails != null)
                isVerified = Convert.ToBoolean(drProjectDetails["verified"].ToString());

            DataTable dt = GetUserId(username);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataTable dtGetUserSec = UserSecurityData.GetUserSecurityByUserId(DataUtils.GetInt(dt.Rows[0]["userid"].ToString()));

                if (dtGetUserSec.Rows.Count > 0)
                {
                    if (dtGetUserSec.Rows[0]["usergroupid"].ToString() == "3") // View Only
                    {
                        return false;
                    }
                    else if (dtGetUserSec.Rows[0]["usergroupid"].ToString() == "2") //Program Staff
                    {
                        if (dtGetUserSec.Rows[0]["dfltprg"].ToString() != "") //Default Program
                        {
                            dtPrg = UserSecurityData.GetProjectsByProgram(DataUtils.GetInt(dtGetUserSec.Rows[0]["dfltprg"].ToString()), projId);
                        }
                        if (dtPrg.Rows.Count <= 0)
                        {
                            return false;
                        }
                        else
                        {
                            return isVerified;
                        }
                    }
                    else if (dtGetUserSec.Rows[0]["usergroupid"].ToString() == "1") //Program Admin
                    {
                        if (dtGetUserSec.Rows[0]["dfltprg"].ToString() != "")
                        {
                            dtPrg = UserSecurityData.GetProjectsByProgram(DataUtils.GetInt(dtGetUserSec.Rows[0]["dfltprg"].ToString()), projId);
                        }
                        if (dtPrg.Rows.Count <= 0)
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        public static void DeleteUsersUserSecurityGroup(int usersUserSecurityGrpId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeleteUsersUserSecurityGroup";
                command.Parameters.Add(new SqlParameter("UsersUserSecurityGrpId", usersUserSecurityGrpId));

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
        public static void DeletePageSecurity(int pagesecurityid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "DeletePageSecurity";
                command.Parameters.Add(new SqlParameter("pagesecurityid", pagesecurityid));

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

        public static DataTable GetUserId(string username)
        {
            try
            {
                DataTable dtUser = ProjectCheckRequestData.GetUserByUserName(username);
                //return dtUser != null ? GetMasterPageSecurity(Convert.ToInt32(dtUser.Rows[0][0].ToString())) : null;
                return dtUser;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static DataTable GetProjectsByProgram(int ProgId, int projId)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectsByProgram";
                command.Parameters.Add(new SqlParameter("progId", ProgId));
                command.Parameters.Add(new SqlParameter("projId", projId));
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

        public static DataTable GetUserSecurityByUserId(int userid)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetUserSecurityByUserId";
                command.Parameters.Add(new SqlParameter("userid", userid));

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

        public static DataTable GetManagerByProjId(int projId)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetManagerByProjId";
                command.Parameters.Add(new SqlParameter("projId", projId));
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

        public static string GetMasterPageFileFromSession(int userid)
        {
            DataTable dt = new DataTable();
            dt = GetuserPageSecurity(userid);
            if (dt.Rows.Count > 0)
                return "~/SiteNonAdmin.master";
            else
                return "~/Site.master";
        }
    }
}
