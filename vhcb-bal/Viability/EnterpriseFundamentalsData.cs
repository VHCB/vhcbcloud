using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VHCBCommon.DataAccessLayer.Viability
{
    public class EnterpriseFundamentalsData
    {
        public static DataRow GetEnterpriseFundamentals(int ProjectID)
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
                        command.CommandText = "GetEnterpriseFundamentals";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count >0)
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

        public static ViabilityMaintResult AddEnterpriseFundamentals(int ProjectId, int PlanType, int ServiceProvOrg, int LeadAdvisor,
            int HearAbout, string ProjDesc, string BusDesc, string YrManageBus)
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
                        command.CommandText = "AddEnterpriseFundamentals";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("PlanType", PlanType));
                        command.Parameters.Add(new SqlParameter("ServiceProvOrg", ServiceProvOrg));
                        command.Parameters.Add(new SqlParameter("LeadAdvisor", LeadAdvisor));
                        command.Parameters.Add(new SqlParameter("HearAbout", HearAbout));
                        command.Parameters.Add(new SqlParameter("ProjDesc", ProjDesc));
                        command.Parameters.Add(new SqlParameter("BusDesc", BusDesc));
                        command.Parameters.Add(new SqlParameter("YrManageBus", YrManageBus));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        ViabilityMaintResult objResult = new ViabilityMaintResult();

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

        public static void UpdateEnterpriseFundamentals(int EnterFundamentalID, int PlanType, int ServiceProvOrg, int LeadAdvisor, 
            int HearAbout, string ProjDesc, string BusDesc, string YrManageBus, bool RowIsActive)
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
                        command.CommandText = "UpdateEnterpriseFundamentals";

                        //4 Parameters
                        command.Parameters.Add(new SqlParameter("EnterFundamentalID", EnterFundamentalID));
                        command.Parameters.Add(new SqlParameter("PlanType", PlanType));
                        command.Parameters.Add(new SqlParameter("ServiceProvOrg", ServiceProvOrg));
                        command.Parameters.Add(new SqlParameter("LeadAdvisor", LeadAdvisor));
                        command.Parameters.Add(new SqlParameter("HearAbout", HearAbout));
                        command.Parameters.Add(new SqlParameter("ProjDesc", ProjDesc));
                        command.Parameters.Add(new SqlParameter("BusDesc", BusDesc));
                        command.Parameters.Add(new SqlParameter("YrManageBus", YrManageBus));
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

        public static DataTable GetEnterpriseFinancialJobsList(int ProjectID, bool IsActiveOnly)
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
                        command.CommandText = "GetEnterpriseFinancialJobsList";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
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

        public static DataRow GetEnterpriseFinancialJobsById(int EnterFinancialJobsID)
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
                        command.CommandText = "GetEnterpriseFinancialJobsById";
                        command.Parameters.Add(new SqlParameter("EnterFinancialJobsID", EnterFinancialJobsID));

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
            return dt.Rows[0];
        }

        public static ViabilityMaintResult AddEnterpriseFinancialJobs(int ProjectId, int MilestoneID, DateTime MSDate, string Year,
            decimal GrossSales, decimal Netincome, decimal GrossPayroll, int FamilyEmp, int NonFamilyEmp)
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
                        command.CommandText = "AddEnterpriseFinancialJobs";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("MilestoneID", MilestoneID));
                        command.Parameters.Add(new SqlParameter("MSDate", MSDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MSDate));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("GrossSales", GrossSales));
                        command.Parameters.Add(new SqlParameter("Netincome", Netincome));
                        command.Parameters.Add(new SqlParameter("GrossPayroll", GrossPayroll));
                        command.Parameters.Add(new SqlParameter("FamilyEmp", FamilyEmp));
                        command.Parameters.Add(new SqlParameter("NonFamilyEmp", NonFamilyEmp));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        ViabilityMaintResult objResult = new ViabilityMaintResult();

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

        public static void UpdateEnterpriseFinancialJobs(int EnterFinancialJobsID, int MilestoneID, DateTime MSDate, string Year,
            decimal GrossSales, decimal Netincome, decimal GrossPayroll, int FamilyEmp, int NonFamilyEmp, bool RowIsActive)
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
                        command.CommandText = "UpdateEnterpriseFinancialJobs";

                        command.Parameters.Add(new SqlParameter("EnterFinancialJobsID", EnterFinancialJobsID));
                        command.Parameters.Add(new SqlParameter("MilestoneID", MilestoneID));
                        command.Parameters.Add(new SqlParameter("MSDate", MSDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MSDate));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("GrossSales", GrossSales));
                        command.Parameters.Add(new SqlParameter("Netincome", Netincome));
                        command.Parameters.Add(new SqlParameter("GrossPayroll", GrossPayroll));
                        command.Parameters.Add(new SqlParameter("FamilyEmp", FamilyEmp));
                        command.Parameters.Add(new SqlParameter("NonFamilyEmp", NonFamilyEmp));
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
    }

    public class ViabilityMaintResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
