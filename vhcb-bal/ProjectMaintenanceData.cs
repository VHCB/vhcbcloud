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
    public class ProjectMaintenanceData
    {
        public static AddProject AddProject(string ProjNum, int LkProjectType, int LkProgram, int Manager, DateTime ClosingDate, 
            int appNameId, string projName)
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

                        //11 Parameters 
                        command.Parameters.Add(new SqlParameter("projNum", ProjNum));
                        command.Parameters.Add(new SqlParameter("LkProjectType", LkProjectType));
                        command.Parameters.Add(new SqlParameter("LkProgram", LkProgram));
                        //command.Parameters.Add(new SqlParameter("LkAppStatus", LkAppStatus == 0 ? System.Data.SqlTypes.SqlInt32.Null : LkAppStatus));
                        command.Parameters.Add(new SqlParameter("Manager", Manager == 0 ? System.Data.SqlTypes.SqlInt32.Null : Manager));
                        //command.Parameters.Add(new SqlParameter("LkBoardDate", LkBoardDate == 0 ? System.Data.SqlTypes.SqlInt32.Null : LkBoardDate));
                        command.Parameters.Add(new SqlParameter("ClosingDate", ClosingDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ClosingDate));
                        //command.Parameters.Add(new SqlParameter("GrantClosingDate", GrantClosingDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : GrantClosingDate));
                        //command.Parameters.Add(new SqlParameter("verified", verified));
                        command.Parameters.Add(new SqlParameter("appNameId", appNameId));
                        command.Parameters.Add(new SqlParameter("projName", projName));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@ProjectId", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddProject ap = new AddProject();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.ProjectId = DataUtils.GetInt(command.Parameters["@ProjectId"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateProject(int ProjId, int LkProjectType, int LkProgram, int Manager, string ClosingDate, 
            int appNameId, string projName)
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

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjId));
                        command.Parameters.Add(new SqlParameter("LkProjectType", LkProjectType));
                        command.Parameters.Add(new SqlParameter("LkProgram", LkProgram));
                        //command.Parameters.Add(new SqlParameter("LkAppStatus", LkAppStatus));
                        command.Parameters.Add(new SqlParameter("Manager", Manager));
                        command.Parameters.Add(new SqlParameter("ClosingDate", ClosingDate == "" ? System.Data.SqlTypes.SqlDateTime.Null : DateTime.Parse(ClosingDate)));
                        //command.Parameters.Add(new SqlParameter("GrantClosingDate", ExpireDate == "" ? System.Data.SqlTypes.SqlDateTime.Null : DateTime.Parse(ExpireDate)));
                        //command.Parameters.Add(new SqlParameter("verified", verified));
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

        public static void UpdateProjectname(int ProjectId, int TypeID, string ProjectName, bool DefName, bool RowIsActive)
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

        public static DataTable GetProjectNames(int ProjectId, bool IsActiveOnly)
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

        public static DataRow GetProjectNameById(int ProjectId)
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
                        command.CommandText = "GetProjectNameById";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

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

        #region Project Address

        public static DataTable GetAddressDetails(string StreetNo)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetAddressDetails";
                command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));

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

        public static DataTable GetProjectAddressList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectAddressList";
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

        public static DataRow GetProjectAddressDetailsById(int ProjectId, int AddressId)
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
                        command.CommandText = "GetProjectAddressDetailsById";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("AddressId", AddressId));

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

        public static void UpdateProjectAddress(int ProjectId, int AddressId, string StreetNo, string Address1, string Address2,
            string Town, string Village, string State, string Zip, string County, decimal latitude, decimal longitude, bool IsActive, bool DefAddress, int LkAddressType)
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
                        command.CommandText = "UpdateProjectAddress";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("AddressId", AddressId));
                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("Village", Village));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("latitude", latitude == 0 ? System.Data.SqlTypes.SqlDecimal.Null : latitude));
                        command.Parameters.Add(new SqlParameter("longitude", longitude == 0 ? System.Data.SqlTypes.SqlDecimal.Null : longitude));
                        command.Parameters.Add(new SqlParameter("IsActive", IsActive));
                        command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));
                        command.Parameters.Add(new SqlParameter("LkAddressType", LkAddressType));

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static ProjectMaintResult AddProjectAddress(int ProjectId, string StreetNo, string Address1, string Address2,
            string Town, string Village, string State, string Zip, string County, decimal latitude, decimal longitude, bool DefAddress, int LkAddressType)
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
                        command.CommandText = "AddNewProjectAddress";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("Village", Village));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("latitude", latitude == 0 ? System.Data.SqlTypes.SqlDecimal.Null : latitude));
                        command.Parameters.Add(new SqlParameter("longitude", longitude == 0 ? System.Data.SqlTypes.SqlDecimal.Null : longitude));
                        //command.Parameters.Add(new SqlParameter("IsActive", IsActive));
                        command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));
                        command.Parameters.Add(new SqlParameter("LkAddressType", LkAddressType));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

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
        #endregion

        #region Project Entity
        public static void AddProjectApplicant(int ProjectId, int AppNameId, int LkApplicantRole, bool isApplicant)
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
                        command.CommandText = "AddProjectApplicant";

                        //2 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("AppNameId", AppNameId));
                        command.Parameters.Add(new SqlParameter("LkApplicantRole", LkApplicantRole));
                        command.Parameters.Add(new SqlParameter("isApplicant", isApplicant));

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

        public static DataTable GetProjectApplicantList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectApplicantList";
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

        public static void UpdateProjectApplicant(int ProjectApplicantId, bool IsApplicant, bool IsFinLegal, int LkApplicantRole, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectApplicant";

                        //3 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectApplicantId", ProjectApplicantId));
                        command.Parameters.Add(new SqlParameter("IsApplicant", IsApplicant));
                        command.Parameters.Add(new SqlParameter("IsFinLegal", IsFinLegal));
                        command.Parameters.Add(new SqlParameter("LkApplicantRole", LkApplicantRole));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));

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
        #endregion


        public static bool AddRelatedProject(int ProjectId, int RelProjectId)
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
                        command.CommandText = "AddRelatedProject";

                        //2 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("RelProjectId", RelProjectId));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateRelatedProject(int ProjectId, int RelProjectId, bool RowIsActive)
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
                        command.CommandText = "UpdateRelatedProject";

                        //3 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("RelProjectId", RelProjectId));
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

        public static DataTable GetRelatedProjectList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetRelatedProjectList";
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

        public static DataTable GetProjectStatusList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectStatusList";
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

        public static void AddProjectStatus(int ProjectId, int LKProjStatus, DateTime StatusDate)
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
                        command.CommandText = "AddProjectStatus";

                        //3 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LKProjStatus", LKProjStatus));
                        command.Parameters.Add(new SqlParameter("StatusDate", StatusDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StatusDate));

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

        public static void UpdateProjectStatus(int ProjectStatusId, int LKProjStatus, DateTime StatusDate, bool isActive)
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
                        command.CommandText = "UpdateProjectStatus";

                        //4 Parameters
                        command.Parameters.Add(new SqlParameter("ProjectStatusId", ProjectStatusId));
                        command.Parameters.Add(new SqlParameter("LKProjStatus", LKProjStatus));
                        command.Parameters.Add(new SqlParameter("StatusDate", StatusDate));
                        command.Parameters.Add(new SqlParameter("isActive", isActive));

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

        public static DataTable GetVillages(int zip)
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
                        command.CommandText = "GetVillages";
                        command.Parameters.Add(new SqlParameter("zip", zip));

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

        public static bool IsProjectNumberExist(string ProjectNumber)
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
                        command.CommandText = "IsProjectNumberExist";
                        command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /* Event */
        public static DataTable GetProjectEventList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectEventList";
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

        public static DataTable GetEventListByEntity(int ApplicantID, bool IsActiveOnly)
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
                        command.CommandText = "GetEventListByEntity";
                        command.Parameters.Add(new SqlParameter("ApplicantID", ApplicantID));
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

        public static ProjectMaintResult AddProjectEvent(int ProjectId, int Prog, int ApplicantID, int EventID, 
            int SubEventID, DateTime Date, string Note, int UserID)
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
                        command.CommandText = "AddProjectEvent";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("Prog", Prog));
                        command.Parameters.Add(new SqlParameter("ApplicantID", ApplicantID));
                        command.Parameters.Add(new SqlParameter("EventID", EventID));
                        command.Parameters.Add(new SqlParameter("SubEventID", SubEventID));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("Note", Note));
                        command.Parameters.Add(new SqlParameter("UserID", UserID));
                        
                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

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

        public static void UpdateProjectEvent(int ProjectEventID, int ProjectId, int Prog, int ApplicantID, int EventID,
            int SubEventID, DateTime Date, string Note, int UserID, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectEvent";
                        
                        command.Parameters.Add(new SqlParameter("ProjectEventID", ProjectEventID));
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("Prog", Prog));
                        command.Parameters.Add(new SqlParameter("ApplicantID", ApplicantID));
                        command.Parameters.Add(new SqlParameter("EventID", EventID));
                        command.Parameters.Add(new SqlParameter("SubEventID", SubEventID));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("Note", Note));
                        command.Parameters.Add(new SqlParameter("UserID", UserID));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));

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

        public static DataRow GetProjectEventById(int ProjectEventID)
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
                        command.CommandText = "GetProjectEventById";
                        command.Parameters.Add(new SqlParameter("ProjectEventID", ProjectEventID));

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

        public static DataTable GetCurrentProjectApplicants(int ProjectId)
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
                        command.CommandText = "GetCurrentProjectApplicants";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        //command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

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

        public static string GetApplicantAppRole(int AppNameId)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetApplicantAppRole";
                command.Parameters.Add(new SqlParameter("AppNameId", AppNameId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    returnMsg = command.ExecuteScalar();
                    return returnMsg == null ? "" : returnMsg.ToString();
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

        public static int GetNextProjectId(string Proj_num, int Action)
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
                        command.CommandText = "GetNextProjectId";

                        command.Parameters.Add(new SqlParameter("Proj_num", Proj_num));
                        command.Parameters.Add(new SqlParameter("Action", Action));
                        
                        SqlParameter parmMessage = new SqlParameter("@ReturnProjectId", SqlDbType.Int);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.ExecuteNonQuery();

                        ProjectMaintResult objResult = new ProjectMaintResult();

                        return DataUtils.GetInt(command.Parameters["@ReturnProjectId"].Value.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    public class AddProject
    {
        public bool IsDuplicate { set; get; }
        public int ProjectId { set; get; }
    }
    public class ProjectMaintResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}