using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace VHCBCommon.DataAccessLayer
{
    public class FederalRentalAffordabilityData
    {
        #region CountyRents

        public static FederalRentalAffordabilityResult AddCountyRent(int FedProgID, int County , DateTime StartDate, DateTime EndDate)
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
                        command.CommandText = "AddCountyRent";

                        command.Parameters.Add(new SqlParameter("FedProgID", FedProgID));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        FederalRentalAffordabilityResult ap = new FederalRentalAffordabilityResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateCountyRent(int CountyRentId, int FedProgID, int County, DateTime StartDate, DateTime EndDate, bool IsRowIsActive)
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
                        command.CommandText = "UpdateCountyRent";

                        command.Parameters.Add(new SqlParameter("CountyRentId", CountyRentId));
                        command.Parameters.Add(new SqlParameter("FedProgID", FedProgID));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
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

        public static DataTable GetCountyRentsList(bool IsActiveOnly)
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
                        command.CommandText = "GetCountyRentsList";
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
        #endregion CountyRents

        #region CountyUnitRents
        public static DataTable GetCountyUnitRentsList(int CountyRentID, bool IsActiveOnly)
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
                        command.CommandText = "GetCountyUnitRentsList";
                        command.Parameters.Add(new SqlParameter("CountyRentID", CountyRentID));
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

        public static FederalRentalAffordabilityResult AddCountyUnitRent(int CountyRentID, int UnitType, 
            decimal HighRent, decimal LowRent)
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
                        command.CommandText = "AddCountyUnitRent";

                        command.Parameters.Add(new SqlParameter("CountyRentID", CountyRentID));
                        command.Parameters.Add(new SqlParameter("UnitType", UnitType));
                        command.Parameters.Add(new SqlParameter("HighRent", HighRent));
                        command.Parameters.Add(new SqlParameter("LowRent", LowRent));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        FederalRentalAffordabilityResult ap = new FederalRentalAffordabilityResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateCountyUnitRent(int CountyUnitRentID, decimal HighRent, decimal LowRent, 
            bool IsRowIsActive)
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
                        command.CommandText = "UpdateCountyUnitRent";

                        command.Parameters.Add(new SqlParameter("CountyUnitRentID", CountyUnitRentID));
                        command.Parameters.Add(new SqlParameter("HighRent", HighRent));
                        command.Parameters.Add(new SqlParameter("LowRent", LowRent));
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
        #endregion CountyUnitRents
    }

    public class FederalRentalAffordabilityResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
