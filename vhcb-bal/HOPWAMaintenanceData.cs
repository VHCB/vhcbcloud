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
    public class HOPWAMaintenanceData
    {
        public static string GetHOPWAYearLabel(int Subtypeid)
        {
            DataTable dt = null;
            string subDescription = string.Empty;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetHOPWAYearLabel";
                        command.Parameters.Add(new SqlParameter("Subtypeid", Subtypeid));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
                        {
                            subDescription = ds.Tables[0].Rows[0]["SubDescription"].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return subDescription;
        }

        public static DataTable GetHOPWAMasterList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWAMasterList";
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

        public static DataRow GetHOPWAMasterDetailsByHOPWAID(int HopwaId)
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
                        command.CommandText = "GetHOPWAMasterDetailsByHOPWAID";
                        command.Parameters.Add(new SqlParameter("HopwaId", HopwaId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count != 0)
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

        public static HOPWAmainttResult AddHOPWAMaster(string UUID, string HHincludes, int SpecNeeds, int WithHIV, int InHousehold, int Minors, int Gender, int Age, 
            int Ethnic, int Race, decimal GMI, decimal AMI, int Beds, string Notes, int ProjectId, 
            int LivingSituationId, int PrimaryASO, int PrevHOPWAID)
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
                        command.CommandText = "AddHOPWAMaster";
                        command.Parameters.Add(new SqlParameter("UUID", UUID));
                        command.Parameters.Add(new SqlParameter("HHincludes", HHincludes));
                        command.Parameters.Add(new SqlParameter("SpecNeeds", SpecNeeds));
                        command.Parameters.Add(new SqlParameter("WithHIV", WithHIV));
                        command.Parameters.Add(new SqlParameter("InHousehold", InHousehold));
                        command.Parameters.Add(new SqlParameter("Minors", Minors));
                        command.Parameters.Add(new SqlParameter("Gender", Gender));
                        command.Parameters.Add(new SqlParameter("Age", Age));
                        command.Parameters.Add(new SqlParameter("Ethnic", Ethnic));
                        command.Parameters.Add(new SqlParameter("Race", Race));
                        command.Parameters.Add(new SqlParameter("GMI", GMI));
                        command.Parameters.Add(new SqlParameter("AMI", AMI));
                        command.Parameters.Add(new SqlParameter("Beds", Beds));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId)); 
                        command.Parameters.Add(new SqlParameter("LivingSituationId", LivingSituationId));
                        command.Parameters.Add(new SqlParameter("PrimaryASO", PrimaryASO));
                        command.Parameters.Add(new SqlParameter("PrevHOPWAID", PrevHOPWAID));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage2 = new SqlParameter("@isActive", SqlDbType.Bit);
                        parmMessage2.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage2);
                        
                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult ap = new HOPWAmainttResult();

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

        public static DataTable GetHOPWAFundName(bool RowIsActive)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetHOPWAFundName";
                command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static DataTable GetProjectCheckReqDates(int ProjectId)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectCheckReqDates";
                command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
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
            return dtStatus;
        }

        public static void UpdateHOPWAMaster(int HOPWAID, string HHincludes, int SpecNeeds, int WithHIV, int InHousehold, int Minors, int Gender, int Age,
            int Ethnic, int Race, decimal GMI, decimal AMI, int Beds, string Notes, bool IsRowIsActive, 
            int LivingSituationId, int PrevHOPWAID)
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
                        command.CommandText = "UpdateHOPWAMaster";

                        command.Parameters.Add(new SqlParameter("HOPWAID", HOPWAID));
                        command.Parameters.Add(new SqlParameter("HHincludes", HHincludes));
                        command.Parameters.Add(new SqlParameter("SpecNeeds", SpecNeeds));
                        command.Parameters.Add(new SqlParameter("WithHIV", WithHIV));
                        command.Parameters.Add(new SqlParameter("InHousehold", InHousehold));
                        command.Parameters.Add(new SqlParameter("Minors", Minors));
                        command.Parameters.Add(new SqlParameter("Gender", Gender));
                        command.Parameters.Add(new SqlParameter("Age", Age));
                        command.Parameters.Add(new SqlParameter("Ethnic", Ethnic));
                        command.Parameters.Add(new SqlParameter("Race", Race));
                        command.Parameters.Add(new SqlParameter("GMI", GMI));
                        command.Parameters.Add(new SqlParameter("AMI", AMI));
                        command.Parameters.Add(new SqlParameter("Beds", Beds));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("PrevHOPWAID", PrevHOPWAID));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));
                        command.Parameters.Add(new SqlParameter("LivingSituationId", LivingSituationId));

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

        public static DataTable GetHOPWARaceList(int HOPWAId, bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWARaceList";
                        command.Parameters.Add(new SqlParameter("HOPWAId", HOPWAId));
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

        public static HOPWAmainttResult AddHOPWARace(int HOPWAID, int Race, int HouseholdNum)
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
                        command.CommandText = "AddHOPWARace";

                        command.Parameters.Add(new SqlParameter("HOPWAID", HOPWAID));
                        command.Parameters.Add(new SqlParameter("Race", Race));
                        command.Parameters.Add(new SqlParameter("HouseholdNum", HouseholdNum));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult acs = new HOPWAmainttResult();

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

        public static void UpdateHOPWARace(int HOPWARaceID, int Race, int HouseholdNum, bool RowIsActive)
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
                        command.CommandText = "UpdateHOPWARace";

                        command.Parameters.Add(new SqlParameter("HOPWARaceID", HOPWARaceID));
                        command.Parameters.Add(new SqlParameter("Race", Race));
                        command.Parameters.Add(new SqlParameter("HouseholdNum", HouseholdNum));
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

        public static DataTable GetHOPWAEthnicityList(int HOPWAId, bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWAEthnicityList";
                        command.Parameters.Add(new SqlParameter("HOPWAId", HOPWAId));
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

        public static HOPWAmainttResult AddHOPWAEthnicity(int HOPWAID, int Ethnic, int EthnicNum)
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
                        command.CommandText = "AddHOPWAEthnicity";

                        command.Parameters.Add(new SqlParameter("HOPWAID", HOPWAID));
                        command.Parameters.Add(new SqlParameter("Ethnic", Ethnic));
                        command.Parameters.Add(new SqlParameter("EthnicNum", EthnicNum));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult acs = new HOPWAmainttResult();

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

        public static void UpdateHOPWAEthnicity(int HOPWAEthnicID, int Ethnic, int EthnicNum, bool RowIsActive)
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
                        command.CommandText = "UpdateHOPWAEthnicity";

                        command.Parameters.Add(new SqlParameter("HOPWAEthnicID", HOPWAEthnicID));
                        command.Parameters.Add(new SqlParameter("Ethnic", Ethnic));
                        command.Parameters.Add(new SqlParameter("EthnicNum", EthnicNum));
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

        public static DataTable GetHOPWAAgeList(int HOPWAId, bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWAAgeList";
                        command.Parameters.Add(new SqlParameter("HOPWAId", HOPWAId));
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

        public static HOPWAmainttResult AddHOPWAAge(int HOPWAID, int GenderAgeID, int GANum)
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
                        command.CommandText = "AddHOPWAAge";

                        command.Parameters.Add(new SqlParameter("HOPWAID", HOPWAID));
                        command.Parameters.Add(new SqlParameter("GenderAgeID", GenderAgeID));
                        command.Parameters.Add(new SqlParameter("GANum", GANum));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult acs = new HOPWAmainttResult();

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

        public static void UpdateHOPWAAge(int HOPWAAgeId, int GenderAgeID, int GANum, bool RowIsActive)
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
                        command.CommandText = "UpdateHOPWAAge";

                        command.Parameters.Add(new SqlParameter("HOPWAAgeId", HOPWAAgeId));
                        command.Parameters.Add(new SqlParameter("GenderAgeID", GenderAgeID));
                        command.Parameters.Add(new SqlParameter("GANum", GANum));
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

        public static DataTable GetHOPWAProgramList(int HOPWAId, bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWAProgramList";
                        command.Parameters.Add(new SqlParameter("HOPWAId", HOPWAId));
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

        public static DataRow GetHOPWAProgramById(int HOPWAProgramID)
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
                        command.CommandText = "GetHOPWAProgramById";
                        command.Parameters.Add(new SqlParameter("HOPWAProgramID", HOPWAProgramID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count != 0)
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

        public static HOPWAmainttResult AddHOPWAProgram(int HOPWAID, int Program, int Fund, bool Yr1, bool Yr2, bool Yr3, DateTime StartDate, DateTime EndDate, 
            string Notes)
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
                        command.CommandText = "AddHOPWAProgram";

                        command.Parameters.Add(new SqlParameter("HOPWAID", HOPWAID));
                        command.Parameters.Add(new SqlParameter("Program", Program));
                        command.Parameters.Add(new SqlParameter("Fund", Fund));
                        command.Parameters.Add(new SqlParameter("Yr1", Yr1));
                        command.Parameters.Add(new SqlParameter("Yr2", Yr2));
                        command.Parameters.Add(new SqlParameter("Yr3", Yr3));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
                        //command.Parameters.Add(new SqlParameter("LivingSituationId", LivingSituationId));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                       

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult acs = new HOPWAmainttResult();

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

        public static void UpdateHOPWAProgram(int HOPWAProgramID, int Program, int Fund, bool Yr1, bool Yr2, bool Yr3, DateTime StartDate, DateTime EndDate,
            string Notes, bool RowIsActive)
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
                        command.CommandText = "UpdateHOPWAProgram";

                        command.Parameters.Add(new SqlParameter("HOPWAProgramID", HOPWAProgramID));
                        command.Parameters.Add(new SqlParameter("Program", Program));
                        command.Parameters.Add(new SqlParameter("Fund", Fund));
                        command.Parameters.Add(new SqlParameter("Yr1", Yr1));
                        command.Parameters.Add(new SqlParameter("Yr2", Yr2));
                        command.Parameters.Add(new SqlParameter("Yr3", Yr3));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
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

        public static DataTable GetHOPWAExpList(int HOPWAProgramID, bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWAExpList";
                        command.Parameters.Add(new SqlParameter("HOPWAProgramID", HOPWAProgramID));
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

        public static DataRow GetHOPWAExpById(int HOPWAExpID)
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
                        command.CommandText = "GetHOPWAExpById";
                        command.Parameters.Add(new SqlParameter("HOPWAExpID", HOPWAExpID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count != 0)
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

        public static HOPWAmainttResult AddHOPWAExp(int HOPWAProgramID, decimal Amount, bool Rent, bool Mortgage, bool Utilities, 
            int PHPUse, DateTime Date, int DisbursementRecord, int TransType)
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
                        command.CommandText = "AddHOPWAExp";

                        command.Parameters.Add(new SqlParameter("HOPWAProgramID", HOPWAProgramID));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("Rent", Rent));
                        command.Parameters.Add(new SqlParameter("Mortgage", Mortgage));
                        command.Parameters.Add(new SqlParameter("Utilities", Utilities));
                        command.Parameters.Add(new SqlParameter("PHPUse", PHPUse));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("DisbursementRecord", DisbursementRecord));
                        command.Parameters.Add(new SqlParameter("TransType", TransType));
                        

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult acs = new HOPWAmainttResult();

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

        public static void UpdateHOPWAExp(int HOPWAExpID, decimal Amount, bool Rent, bool Mortgage, bool Utilities,
            int PHPUse, DateTime Date, int DisbursementRecord, bool RowIsActive, int TransType)
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
                        command.CommandText = "UpdateHOPWAExp";

                        command.Parameters.Add(new SqlParameter("HOPWAExpID", HOPWAExpID));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("Rent", Rent));
                        command.Parameters.Add(new SqlParameter("Mortgage", Mortgage));
                        command.Parameters.Add(new SqlParameter("Utilities", Utilities));
                        command.Parameters.Add(new SqlParameter("PHPUse", PHPUse));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("DisbursementRecord", DisbursementRecord));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));
                        command.Parameters.Add(new SqlParameter("TransType", TransType));

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
    }
    public class HOPWAmainttResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }

}
