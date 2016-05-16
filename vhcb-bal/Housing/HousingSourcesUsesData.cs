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
    public class HousingSourcesUsesData
    {
        public static int GetHousingID(int ProjectId)
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
                        command.CommandText = "GetHousingID";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        SqlParameter parmMessage = new SqlParameter("@HousingID", SqlDbType.Int);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return DataUtils.GetInt(command.Parameters["@HousingID"].Value.ToString()); ;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static HouseResult AddHouseSource(int HousingID, int LKBudgetPeriod, int LkHouseSource, decimal Total)
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
                        command.CommandText = "AddHouseSource";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LKBudgetPeriod", LKBudgetPeriod));
                        command.Parameters.Add(new SqlParameter("LkHouseSource", LkHouseSource));
                        command.Parameters.Add(new SqlParameter("Total", Total));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HouseResult acs = new HouseResult();

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

        public static void UpdateHouseSource(int HouseSourceID, decimal Total, bool RowIsActive)
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
                        command.CommandText = "UpdateHouseSource";

                        command.Parameters.Add(new SqlParameter("HouseSourceID", HouseSourceID));
                        command.Parameters.Add(new SqlParameter("Total", Total));
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

        public static HouseResult AddHouseUse(int HousingID, int LKBudgetPeriod, int LkHouseUseVHCB, decimal VHCBTotal,
            int LKHouseUseOther, decimal OtherTotal)
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
                        command.CommandText = "AddHouseUse";

                        command.Parameters.Add(new SqlParameter("HousingID", HousingID));
                        command.Parameters.Add(new SqlParameter("LKBudgetPeriod", LKBudgetPeriod));
                        command.Parameters.Add(new SqlParameter("LkHouseUseVHCB", LkHouseUseVHCB));
                        command.Parameters.Add(new SqlParameter("VHCBTotal", VHCBTotal));
                        command.Parameters.Add(new SqlParameter("LKHouseUseOther", LKHouseUseOther));
                        command.Parameters.Add(new SqlParameter("OtherTotal", OtherTotal));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HouseResult acs = new HouseResult();

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

        public static void UpdateHouseUse(int HouseUseID, decimal VHCBTotal, decimal OtherTotal, bool RowIsActive)
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
                        command.CommandText = "UpdateHouseUse";

                        command.Parameters.Add(new SqlParameter("HouseUseID", HouseUseID));
                        command.Parameters.Add(new SqlParameter("VHCBTotal", VHCBTotal));
                        command.Parameters.Add(new SqlParameter("OtherTotal", OtherTotal));
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

        public static DataTable GetHousingSourcesList(int ProjectId, int BudgetPeriod, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingSourcesList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LKBudgetPeriod", BudgetPeriod));
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

        public static DataTable GetHousingUsesList(int ProjectId, int BudgetPeriod, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingUsesList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LKBudgetPeriod", BudgetPeriod));
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

        public static DataTable GetHouseUses(string UseType)
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
                        command.CommandText = "GetHouseUses";
                        command.Parameters.Add(new SqlParameter("UsesDescription", UseType));

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

        public static void ImportHousingBudgetPeriodData(int ProjectId, int ImportLKBudgetPeriod, int LKBudgetPeriod)
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
                        command.CommandText = "ImportHousingBudgetPeriodData";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("ImportLKBudgetPeriod", ImportLKBudgetPeriod));
                        command.Parameters.Add(new SqlParameter("LKBudgetPeriod", LKBudgetPeriod));

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

        public static int GetLatestHousingBudgetPeriod(int ProjectId)
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
                        command.CommandText = "GetLatestHousingBudgetPeriod";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                        SqlParameter parmMessage = new SqlParameter("@LKBudgetPeriod", SqlDbType.Int);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return DataUtils.GetInt(command.Parameters["@LKBudgetPeriod"].Value.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable PopulateHousingImportBudgetPeriodDropDown(int ProjectID, int LKBudgetPeriod)
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
                        command.CommandText = "PopulateHousingImportBudgetPeriodDropDown";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LKBudgetPeriod", LKBudgetPeriod));

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

        public class HouseResult
        {
            public bool IsDuplicate { set; get; }
            public bool IsActive { set; get; }
        }
    }
}
