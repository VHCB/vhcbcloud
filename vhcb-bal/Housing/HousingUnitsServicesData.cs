using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
 
namespace VHCBCommon.DataAccessLayer.Housing
{
    public class HousingUnitsServicesData
    {
        #region Housing
        public static void SubmitHousingUnits(int HousingID, int LkHouseCat, int Hsqft, int Previous, 
            int NewUnits, int UnitsRemoved, bool IsVermod, bool IsSash, int ServSuppUnits)
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
                        command.CommandText = "SubmitHousingUnits";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkHouseCat", LkHouseCat));
                        //command.Parameters.Add(new SqlParameter("TotalUnits", TotalUnits));
                        command.Parameters.Add(new SqlParameter("Hsqft", Hsqft));
                        command.Parameters.Add(new SqlParameter("Previous", Previous));
                        command.Parameters.Add(new SqlParameter("NewUnits", NewUnits));
                        command.Parameters.Add(new SqlParameter("UnitsRemoved", UnitsRemoved));
                        command.Parameters.Add(new SqlParameter("IsVermod", IsVermod));
                        command.Parameters.Add(new SqlParameter("IsSash", IsSash));
                        command.Parameters.Add(new SqlParameter("ServSuppUnits", ServSuppUnits));

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

        public static DataRow GetHousingDetailsById(int ProjectId)
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
                        command.CommandText = "GetHousingDetailsById";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
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

        #endregion Housing

        #region SubType
        public static DataTable GetHousingSubTypeList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingSubTypeList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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
        public static HousingUnitseResult AddHousingSubType(int HousingID, int LkHouseType, int Units)
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
                        command.CommandText = "AddHousingSubType";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkHouseType", LkHouseType));
                        command.Parameters.Add(new SqlParameter("Units", Units));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHousingSubType(int HousingTypeID, int Units, bool RowIsActive)
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
                        command.CommandText = "UpdateHousingSubType";

                        command.Parameters.Add(new SqlParameter("HousingTypeID", HousingTypeID));
                        command.Parameters.Add(new SqlParameter("Units", Units));
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
        #endregion SubType

        #region SingleCount
        public static DataTable GetHouseSingleCountList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHouseSingleCountList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddHouseSingleCount(int HousingID, int LkHouseType, int Numunits)
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
                        command.CommandText = "AddHouseSingleCount";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkUnitChar", LkHouseType));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHouseSingleCount(int ProjectHouseConsReuseRehabID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateHouseSingleCount";

                        command.Parameters.Add(new SqlParameter("ProjectHouseConsReuseRehabID", ProjectHouseConsReuseRehabID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion SingleCount

        #region MultiCount
        public static DataTable GetHouseMultiCountList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHouseMultiCountList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddHouseMultiCount(int HousingID, int LkHouseType, int Numunits)
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
                        command.CommandText = "AddHouseMultiCount";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkUnitChar", LkHouseType));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHouseMultiCount(int ProjectHouseAccessAdaptID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateHouseMultiCount";

                        command.Parameters.Add(new SqlParameter("ProjectHouseAccessAdaptID", ProjectHouseAccessAdaptID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion MultiCount

        #region Supplemental Services
        public static DataTable GetHousingSuppServList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingSuppServList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddHousingSuppServ(int HousingID, int LkSuppServ, int Numunits)
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
                        command.CommandText = "AddHousingSuppServ";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkSuppServ", LkSuppServ));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHousingSuppServ(int ProjectSuppServID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateHousingSuppServ";

                        command.Parameters.Add(new SqlParameter("ProjectSuppServID", ProjectSuppServID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion Supplemental Services

        #region Secondary Services
        public static DataTable GetHousingSecServList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingSecServList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddHousingSecServ(int HousingID, int LKSecSuppServ, int Numunits)
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
                        command.CommandText = "AddHousingSecServ";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LKSecSuppServ", LKSecSuppServ));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHousingSecServ(int ProjectSecSuppServID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateHousingSecServ";

                        command.Parameters.Add(new SqlParameter("ProjectSecSuppServID", ProjectSecSuppServID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion Secondary Services

        #region Age Restrictions
        public static DataTable GetProjectAgeRestrictList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectAgeRestrictList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddProjectAgeRestrict(int HousingID, int LKAgeRestrict, int Numunits)
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
                        command.CommandText = "AddProjectAgeRestrict";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LKAgeRestrict", LKAgeRestrict));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateProjectAgeRestrict(int ProjectAgeRestrictID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateProjectAgeRestrict";

                        command.Parameters.Add(new SqlParameter("ProjectAgeRestrictID", ProjectAgeRestrictID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion Secondary Services

        #region VHCB Affordability
        public static DataTable GetHousingVHCBAffordUnitsList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingVHCBAffordUnitsList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddHousingVHCBAffordUnits(int HousingID, int LkAffordunits, int Numunits)
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
                        command.CommandText = "AddHousingVHCBAffordUnits";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkAffordunits", LkAffordunits));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHousingVHCBAffordUnits(int ProjectVHCBAffordUnitsID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateHousingVHCBAffordUnits";

                        command.Parameters.Add(new SqlParameter("ProjectVHCBAffordUnitsID", ProjectVHCBAffordUnitsID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion VHCB Affordability

        #region  Income Restrictions
        public static DataTable GetProjectFederalIncomeRestList(int ProjectFederalID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectFederalIncomeRestList";
                        command.Parameters.Add(new SqlParameter("ProjectFederalID", ProjectFederalID));
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

        public static HousingUnitseResult AddProjectFederalIncomeRest(int ProjectFederalID, int LkAffordunits, int Numunits)
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
                        command.CommandText = "AddProjectFederalIncomeRest";

                        command.Parameters.Add(new SqlParameter("ProjectFederalID", ProjectFederalID));
                        command.Parameters.Add(new SqlParameter("LkAffordunits", LkAffordunits));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateProjectFederalIncomeRest(int ProjectFederalIncomeRestID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateProjectFederalIncomeRest";

                        command.Parameters.Add(new SqlParameter("ProjectFederalIncomeRestID", ProjectFederalIncomeRestID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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

        #endregion  Income Restrictions


        #region Home Affordability
        public static DataTable GetHousingHomeAffordUnitsList(int HousingID, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingHomeAffordUnitsList";
                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
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

        public static HousingUnitseResult AddHousingHomeAffordUnits(int HousingID, int LkAffordunits, int Numunits)
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
                        command.CommandText = "AddHousingHomeAffordUnits";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LkAffordunits", LkAffordunits));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingUnitseResult acs = new HousingUnitseResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateHousingHomeAffordUnits(int ProjectHomeAffordUnitsID, int Numunits, bool RowIsActive)
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
                        command.CommandText = "UpdateHousingHomeAffordUnits";

                        command.Parameters.Add(new SqlParameter("ProjectHomeAffordUnitsID", ProjectHomeAffordUnitsID));
                        command.Parameters.Add(new SqlParameter("Numunits", Numunits));
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
        #endregion Home Affordability

        #region Total Federal Program Units
        public static int GetTotalFederalProgramUnits(int ProjectId)
        {
            int TotalUnits = 0;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetTotalFederalProgramUnits";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        var TotalUnitsColumn = command.ExecuteScalar();

                        if (TotalUnitsColumn != null)
                        {
                            TotalUnits = DataUtils.GetInt(TotalUnitsColumn.ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return TotalUnits;
        }
        #endregion Total Federal Program Units
    }

    public class HousingUnitseResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
