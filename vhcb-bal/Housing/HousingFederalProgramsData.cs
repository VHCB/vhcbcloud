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
    public class HousingFederalProgramsData
    {
        public static int GetTotalHousingUnits(int ProjectId)
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
                        command.CommandText = "GetTotalHousingUnits";
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

        public static DataTable GetProjectFederalList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectFederalList";
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

        public static HousingFederalProgramsResult AddProjectFederal(int ProjectID, int LkFedProg, int NumUnits)
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
                        command.CommandText = "AddProjectFederal";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LkFedProg", LkFedProg));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingFederalProgramsResult acs = new HousingFederalProgramsResult();

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

        public static void UpdateProjectFederal(int ProjectFederalID, int NumUnits, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectFederal";

                        command.Parameters.Add(new SqlParameter("ProjectFederalID", ProjectFederalID));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));
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

        public static void AddProjectHOMEDetail(int ProjectFederalId, int Recert, int LKAffrdPer,
            DateTime AffrdStart, DateTime AffrdEnd, bool CHDO, int CHDORecert, int freq, string IDISNum, DateTime Setup, int CompleteBy,
            DateTime FundedDate, int FundCompleteBy, DateTime IDISClose, int IDISCompleteBy)
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
                        command.CommandText = "AddProjectHOMEDetail";

                        command.Parameters.Add(new SqlParameter("ProjectFederalId", ProjectFederalId));
                        command.Parameters.Add(new SqlParameter("Recert", Recert));
                        command.Parameters.Add(new SqlParameter("LKAffrdPer", LKAffrdPer));
                        command.Parameters.Add(new SqlParameter("AffrdStart", AffrdStart.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AffrdStart));
                        command.Parameters.Add(new SqlParameter("AffrdEnd", AffrdEnd.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AffrdEnd));
                        command.Parameters.Add(new SqlParameter("CHDO", CHDO));
                        command.Parameters.Add(new SqlParameter("CHDORecert", CHDORecert));
                        command.Parameters.Add(new SqlParameter("freq", freq));
                        command.Parameters.Add(new SqlParameter("IDISNum", IDISNum));
                        command.Parameters.Add(new SqlParameter("Setup", Setup.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Setup));
                        command.Parameters.Add(new SqlParameter("CompleteBy", CompleteBy));
                        command.Parameters.Add(new SqlParameter("FundedDate", FundedDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : FundedDate));
                        command.Parameters.Add(new SqlParameter("FundCompleteBy", FundCompleteBy));
                        command.Parameters.Add(new SqlParameter("IDISClose", IDISClose.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : IDISClose));
                        command.Parameters.Add(new SqlParameter("IDISCompleteBy", IDISCompleteBy));

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

        public static void UpdateProjectHOMEDetail(int ProjectFederalDetailID, int Recert, int LKAffrdPer,
           DateTime AffrdStart, DateTime AffrdEnd, bool CHDO, int CHDORecert, int freq, string IDISNum, DateTime Setup, int CompleteBy,
           DateTime FundedDate, int FundCompleteBy, DateTime IDISClose, int IDISCompleteBy)
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
                        command.CommandText = "UpdateProjectHOMEDetail";

                        command.Parameters.Add(new SqlParameter("ProjectFederalDetailID", ProjectFederalDetailID));
                        command.Parameters.Add(new SqlParameter("Recert", Recert));
                        command.Parameters.Add(new SqlParameter("LKAffrdPer", LKAffrdPer));
                        command.Parameters.Add(new SqlParameter("AffrdStart", AffrdStart.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AffrdStart));
                        command.Parameters.Add(new SqlParameter("AffrdEnd", AffrdEnd.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AffrdEnd));
                        command.Parameters.Add(new SqlParameter("CHDO", CHDO));
                        command.Parameters.Add(new SqlParameter("CHDORecert", CHDORecert));
                        command.Parameters.Add(new SqlParameter("freq", freq));
                        command.Parameters.Add(new SqlParameter("IDISNum", IDISNum));
                        command.Parameters.Add(new SqlParameter("Setup", Setup.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Setup));
                        command.Parameters.Add(new SqlParameter("CompleteBy", CompleteBy));
                        command.Parameters.Add(new SqlParameter("FundedDate", FundedDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : FundedDate));
                        command.Parameters.Add(new SqlParameter("FundCompleteBy", FundCompleteBy));
                        command.Parameters.Add(new SqlParameter("IDISClose", IDISClose.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : IDISClose));
                        command.Parameters.Add(new SqlParameter("IDISCompleteBy", IDISCompleteBy));

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

        public static DataRow GetProjectHOMEDetailById(int ProjectFederalId)
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
                        command.CommandText = "GetProjectHOMEDetailById";
                        command.Parameters.Add(new SqlParameter("ProjectFederalId", ProjectFederalId));

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

        #region Rental Affordability
        public static DataTable GetHousingFederalAffordList(int ProjectFederalID, bool IsActiveOnly)
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
                        command.CommandText = "GetHousingFederalAffordList";
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

        public static HousingFederalProgramsResult AddHousingFederalAfford(int ProjectFederalID, int AffordType, int NumUnits)
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
                        command.CommandText = "AddHousingFederalAfford";

                        command.Parameters.Add(new SqlParameter("ProjectFederalID", ProjectFederalID));
                        command.Parameters.Add(new SqlParameter("AffordType", AffordType));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingFederalProgramsResult acs = new HousingFederalProgramsResult();

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

        public static void UpdateHousingFederalAfford(int FederalAffordID, int NumUnits, bool IsRowActive)
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
                        command.CommandText = "UpdateHousingFederalAfford";

                        command.Parameters.Add(new SqlParameter("FederalAffordID", FederalAffordID));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));
                        command.Parameters.Add(new SqlParameter("IsRowActive", IsRowActive));

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

        #endregion Rental Affordability

        #region Unit Occupancy
        public static DataTable GetFederalUnitList(int ProjectFederalID, bool IsActiveOnly)
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
                        command.CommandText = "GetFederalUnitList";
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

        public static HousingFederalProgramsResult AddHousingFederalUnit(int ProjectFederalID, int UnitType, int NumUnits)
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
                        command.CommandText = "AddHousingFederalUnit";

                        command.Parameters.Add(new SqlParameter("ProjectFederalID", ProjectFederalID));
                        command.Parameters.Add(new SqlParameter("UnitType", UnitType));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingFederalProgramsResult acs = new HousingFederalProgramsResult();

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

        public static void UpdateHousingFederalUnit(int FederalUnitID, int NumUnits, bool IsRowActive)
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
                        command.CommandText = "UpdateHousingFederalUnit";

                        command.Parameters.Add(new SqlParameter("FederalUnitID", FederalUnitID));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));
                        command.Parameters.Add(new SqlParameter("IsRowActive", IsRowActive));

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

        #endregion Unit Occupancy

        #region Median Income
        public static DataTable GetFederalMedIncomeList(int ProjectFederalID, bool IsActiveOnly)
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
                        command.CommandText = "GetFederalMedIncomeList";
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

        public static HousingFederalProgramsResult AddFederalMedIncome(int ProjectFederalID, int MedIncome, int NumUnits)
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
                        command.CommandText = "AddFederalMedIncome";

                        command.Parameters.Add(new SqlParameter("ProjectFederalID", ProjectFederalID));
                        command.Parameters.Add(new SqlParameter("MedIncome", MedIncome));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HousingFederalProgramsResult acs = new HousingFederalProgramsResult();

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

        public static void UpdateFederalMedIncome(int FederalMedIncomeID, int NumUnits, bool IsRowActive)
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
                        command.CommandText = "UpdateFederalMedIncome";

                        command.Parameters.Add(new SqlParameter("FederalMedIncomeID", FederalMedIncomeID));
                        command.Parameters.Add(new SqlParameter("NumUnits", NumUnits));
                        command.Parameters.Add(new SqlParameter("IsRowActive", IsRowActive));

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

        #endregion Median Income

        #region Inspections
        public static DataTable GetProjectHOMEInspectionList(int ProjectFederalDetailID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectHOMEInspectionList";
                        command.Parameters.Add(new SqlParameter("ProjectFederalDetailID", ProjectFederalDetailID));
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

        public static void AddProjectHOMEInspection(int ProjectFederalDetailID, DateTime InspectDate, string NextInspect, 
            int InspectStaff, DateTime InspectLetter, DateTime RespDate, bool Deficiency, DateTime InspectDeadline)
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
                        command.CommandText = "AddProjectHOMEInspection";

                        command.Parameters.Add(new SqlParameter("ProjectFederalDetailID", ProjectFederalDetailID));
                        command.Parameters.Add(new SqlParameter("InspectDate", InspectDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : InspectDate));
                        command.Parameters.Add(new SqlParameter("NextInspect", NextInspect));
                        command.Parameters.Add(new SqlParameter("InspectStaff", InspectStaff));
                        command.Parameters.Add(new SqlParameter("InspectLetter", InspectLetter.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : InspectLetter));
                        command.Parameters.Add(new SqlParameter("RespDate", RespDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : RespDate));
                        command.Parameters.Add(new SqlParameter("Deficiency", Deficiency));
                        command.Parameters.Add(new SqlParameter("InspectDeadline", InspectDeadline.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : InspectDeadline));
                        
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
        #endregion Inspections
    }

    public class HousingFederalProgramsResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
