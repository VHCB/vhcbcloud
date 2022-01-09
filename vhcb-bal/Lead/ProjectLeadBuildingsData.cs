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
        
        public static LeadBuildResult AddProjectLeadTypeofWork(int LeadBldgID, int LeadUnitID, int TypeofWorkID)
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
                        command.CommandText = "AddProjectLeadTypeofWork";

                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("TypeofWorkID", TypeofWorkID));
                     
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

        public static DataTable GetProjectLeadTypeofWorkList(int LeadBldgID, int LeadUnitID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectLeadTypeofWorkList";
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
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

        public static void UpdateProjectLeadTypeofWork(int WorkTypeID, int typeOfWorkId, int OrderNum, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectLeadTypeofWork";

                        command.Parameters.Add(new SqlParameter("WorkTypeID", WorkTypeID));
                        command.Parameters.Add(new SqlParameter("typeOfWorkId", typeOfWorkId));
                        command.Parameters.Add(new SqlParameter("OrderNum", OrderNum));
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

        public static void UpdateWorkLocation(int WorkLocationID, int LocationID, int OrderNum, string LocationDesc,  bool IsRowIsActive)
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
                        command.CommandText = "UpdateWorkLocation";

                        command.Parameters.Add(new SqlParameter("WorkLocationID", WorkLocationID));
                        command.Parameters.Add(new SqlParameter("LocationID", LocationID));
                        command.Parameters.Add(new SqlParameter("OrderNum", OrderNum));
                        command.Parameters.Add(new SqlParameter("LocationDesc", LocationDesc));
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

        public static LeadBuildResult AddWorkLocation(int LeadBldgID, int LeadUnitID, int LocationID, int Ordernum)
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
                        command.CommandText = "AddWorkLocation";

                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("LocationID", LocationID));
                        command.Parameters.Add(new SqlParameter("Ordernum", Ordernum));

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

        public static DataTable GetWorkLocationList(int LeadBldgID, int LeadUnitID, bool IsActiveOnly)
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
                        command.CommandText = "GetWorkLocationList";
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
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

        public static DataTable GetCheckrequestInfoByProjectID(int ProjectId)
        {
            DataTable dt = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetCheckrequestInfoByProjectID";
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

        public static DataTable GetProjectMasterLeadCostsList(int ProjectId)
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
                        command.CommandText = "GetProjectMasterLeadCostsList";
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

        public static LeadBuildResult AddProjectMasterLeadCosts(int ProjectCheckReqID)
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
                        command.CommandText = "AddProjectMasterLeadCosts";

                        command.Parameters.Add(new SqlParameter("ProjectCheckReqID", ProjectCheckReqID));
                       

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

        public static LeadBuildResult AddProjectLeadCosts(int ProjectMasterLeadCostsID, int LeadUnitID, int LeadBldgID, decimal Amount, string Note)
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
                        command.CommandText = "AddProjectLeadCosts";

                        command.Parameters.Add(new SqlParameter("ProjectMasterLeadCostsID", ProjectMasterLeadCostsID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("Note", Note));

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

        public static DataTable GetProjectLeadCostsList(int ProjectMasterLeadCostsID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectLeadCostsList";
                        command.Parameters.Add(new SqlParameter("ProjectMasterLeadCostsID", ProjectMasterLeadCostsID));
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

        public static DataRow GetProjectLeadCostById(int LeadCostsID)
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
                        command.CommandText = "GetProjectLeadCostById";
                        command.Parameters.Add(new SqlParameter("LeadCostsID", LeadCostsID));

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

        public static void UpdateProjectLeadCost(int LeadCostsID, int LeadBldgID, int LeadUnitID, 
            decimal Amount, string Note, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectLeadCost";

                        command.Parameters.Add(new SqlParameter("LeadCostsID", LeadCostsID));
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("Amount", Amount));
                        command.Parameters.Add(new SqlParameter("Note", Note));
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

        public static DataTable GetLeadCategory()
        {
            DataTable dt = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLeadCategory";
                
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

        public static DataTable GetLeadSpecs(int CategoryID)
        {
            DataTable dt = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLeadSpecs";
                command.Parameters.Add(new SqlParameter("CategoryID", CategoryID));

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

        public static void AddProjectLeadSpecs(int ProjectID, int LocationID, int Spec_ID)
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
                        command.CommandText = "AddProjectLeadSpecs";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LocationID", LocationID));
                        command.Parameters.Add(new SqlParameter("Spec_ID", Spec_ID));
                       
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

        public static void DeleteProjectLeadSpecs(int ProjectID, int LocationID)
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
                        command.CommandText = "DeleteProjectLeadSpecs";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LocationID", LocationID));

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

        public static DataTable GetProjectLeadSpecs(int ProjectID, int LocationID, bool IsActiveOnly)
        {
            DataTable dt = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectLeadSpecs";
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("LocationID", LocationID));
                command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

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

        public static string GetProjectLeadSpecsNextOrderNum(int ProjectID, int LocationID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectLeadSpecsNextOrderNum";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LocationID", LocationID));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        SqlParameter parmMessage = new SqlParameter("@NextOrderNum", SqlDbType.Int);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return command.Parameters["@NextOrderNum"].Value.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string GetWorkLocationListOrderNum(int LeadBldgID, int LeadUnitID, bool IsActiveOnly)
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
                        command.CommandText = "GetWorkLocationListOrderNum";

                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        SqlParameter parmMessage = new SqlParameter("@NextOrderNum", SqlDbType.Int);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        return command.Parameters["@NextOrderNum"].Value.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataRow GetProjectLeadSpecsById(int ProjectLeadSpecID)
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
                        command.CommandText = "GetProjectLeadSpecsById";
                        command.Parameters.Add(new SqlParameter("ProjectLeadSpecID", ProjectLeadSpecID));

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

        public static void UpdateProjectLeadSpecsById(int ProjectLeadSpecID, string Spec_Detail, string Spec_Note, decimal Units, decimal UnitCost, int OrderNum, bool RowIsActive)
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
                        command.CommandText = "UpdateProjectLeadSpecsById";

                        command.Parameters.Add(new SqlParameter("ProjectLeadSpecID", ProjectLeadSpecID));
                        command.Parameters.Add(new SqlParameter("Spec_Detail", Spec_Detail));
                        command.Parameters.Add(new SqlParameter("Spec_Note", Spec_Note));
                        command.Parameters.Add(new SqlParameter("Units", Units));
                        command.Parameters.Add(new SqlParameter("UnitCost", UnitCost));
                        command.Parameters.Add(new SqlParameter("OrderNum", OrderNum));
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

        public static DataTable GetLeadSpecsAll()
        {
            DataTable dt = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetLeadSpecsAll";

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

        public static DataRow GetLeadSpecsBySpecId(int SpecId)
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
                        command.CommandText = "GetLeadSpecsBySpecId";
                        command.Parameters.Add(new SqlParameter("SpecId", SpecId));

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

        public static void UpdateLeadSpecCost(int SpecId, decimal UnitCost)
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
                        command.CommandText = "UpdateLeadSpecCost";

                        command.Parameters.Add(new SqlParameter("SpecId", SpecId));
                        command.Parameters.Add(new SqlParameter("UnitCost", UnitCost));

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

    public class LeadBuildResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
