using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VHCBCommon.DataAccessLayer.Lead
{
    public class ProjectLeadBuildingsData
    {
        public static DataTable GetProjectAddressListByProjectID(int ProjectId)
        {
            DataTable dt = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectAddressListByProjectID";
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
                        dt = ds.Tables[0];
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
            return dt;
        }

        public static DataTable GetProjectLeadBldgList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectLeadBldgList";
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

        public static LeadBuildResult AddProjectLeadBldg(int ProjectID, int Building, int AddressID, int Age, int Type, int LHCUnits, bool FloodHazard, bool FloodIns, 
            int VerifiedBy, string InsuredBy, int HistStatus, int AppendA)
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
                        command.CommandText = "AddProjectLeadBldg";

                        //11 Parameters 
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("Building", Building));
                        command.Parameters.Add(new SqlParameter("AddressID", AddressID));
                        command.Parameters.Add(new SqlParameter("Age", Age));
                       
                        command.Parameters.Add(new SqlParameter("Type", Type));
                        command.Parameters.Add(new SqlParameter("LHCUnits", LHCUnits));
                        command.Parameters.Add(new SqlParameter("FloodHazard", FloodHazard));
                        command.Parameters.Add(new SqlParameter("FloodIns", FloodIns));
                        command.Parameters.Add(new SqlParameter("VerifiedBy", VerifiedBy));
                        command.Parameters.Add(new SqlParameter("InsuredBy", InsuredBy));
                        command.Parameters.Add(new SqlParameter("HistStatus", HistStatus));
                        command.Parameters.Add(new SqlParameter("AppendA", AppendA));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LeadBuildResult ap = new LeadBuildResult();

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

        public static void UpdateProjectLeadBldg(int LeadBldgID, int Building, int AddressID, int Age, int Type, int LHCUnits, bool FloodHazard, bool FloodIns, int VerifiedBy, string InsuredBy,
       int HistStatus, int AppendA, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectLeadBldg";

                        //11 Parameters 
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("Building", Building));
                        command.Parameters.Add(new SqlParameter("AddressID", AddressID));
                        command.Parameters.Add(new SqlParameter("Age", Age));

                        command.Parameters.Add(new SqlParameter("Type", Type));
                        command.Parameters.Add(new SqlParameter("LHCUnits", LHCUnits));
                        command.Parameters.Add(new SqlParameter("FloodHazard", FloodHazard));
                        command.Parameters.Add(new SqlParameter("FloodIns", FloodIns));
                        command.Parameters.Add(new SqlParameter("VerifiedBy", VerifiedBy));
                        command.Parameters.Add(new SqlParameter("InsuredBy", InsuredBy));
                        command.Parameters.Add(new SqlParameter("HistStatus", HistStatus));
                        command.Parameters.Add(new SqlParameter("AppendA", AppendA));
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

        public static DataRow GetProjectLeadBldgById(int LeadBldgID)
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
                        command.CommandText = "GetProjectLeadBldgById";
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));

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

        public static DataTable GetProjectLeadUnitList(int LeadBldgID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectLeadUnitList";
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
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

        public static LeadBuildResult AddProjectLeadUnit(int LeadBldgID, int Unit, int EBLStatus, int HHCount, int Rooms, decimal HHIncome, bool PartyVerified, int IncomeStatus, decimal MatchFunds,
        DateTime ClearDate, DateTime CertDate, DateTime ReCertDate, decimal RelocationAmt, DateTime StartDate)
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
                        command.CommandText = "AddProjectLeadUnit";

                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("Unit", Unit));
                        command.Parameters.Add(new SqlParameter("EBLStatus", EBLStatus));
                        command.Parameters.Add(new SqlParameter("HHCount", HHCount));
                        command.Parameters.Add(new SqlParameter("Rooms", Rooms));
                        command.Parameters.Add(new SqlParameter("HHIncome", HHIncome));
                        command.Parameters.Add(new SqlParameter("PartyVerified", PartyVerified));
                        command.Parameters.Add(new SqlParameter("IncomeStatus", IncomeStatus));
                        command.Parameters.Add(new SqlParameter("MatchFunds", MatchFunds));
                        command.Parameters.Add(new SqlParameter("ClearDate", ClearDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ClearDate));
                        command.Parameters.Add(new SqlParameter("CertDate", CertDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : CertDate));
                        command.Parameters.Add(new SqlParameter("ReCertDate", ReCertDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ReCertDate));
                        command.Parameters.Add(new SqlParameter("RelocationAmt", RelocationAmt));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LeadBuildResult ap = new LeadBuildResult();

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

        public static void UpdateProjectLeadUnit(int LeadUnitID, int EBLStatus, int HHCount, int Rooms, decimal HHIncome, bool PartyVerified, int IncomeStatus, decimal MatchFunds,
        DateTime ClearDate, DateTime CertDate, DateTime ReCertDate, decimal RelocationAmt, DateTime StartDate, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectLeadUnit";

                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("EBLStatus", EBLStatus));
                        command.Parameters.Add(new SqlParameter("HHCount", HHCount));
                        command.Parameters.Add(new SqlParameter("Rooms", Rooms));
                        command.Parameters.Add(new SqlParameter("HHIncome", HHIncome));
                        command.Parameters.Add(new SqlParameter("PartyVerified", PartyVerified));
                        command.Parameters.Add(new SqlParameter("IncomeStatus", IncomeStatus));
                        command.Parameters.Add(new SqlParameter("MatchFunds", MatchFunds));
                        command.Parameters.Add(new SqlParameter("ClearDate", ClearDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ClearDate));
                        command.Parameters.Add(new SqlParameter("CertDate", CertDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : CertDate));
                        command.Parameters.Add(new SqlParameter("ReCertDate", ReCertDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ReCertDate));
                        command.Parameters.Add(new SqlParameter("RelocationAmt", RelocationAmt));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
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

        public static DataRow GetProjectLeadUnitById(int LeadUnitID)
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
                        command.CommandText = "GetProjectLeadUnitById";
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));

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
    }

    public class LeadBuildResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
