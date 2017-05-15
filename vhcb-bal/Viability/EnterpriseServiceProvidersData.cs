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
    public class EnterpriseServiceProvidersData
    {
        public static DataRow GetEnterpriseServProviderDataById(int EnterServiceProvID)
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
                        command.CommandText = "GetEnterpriseServProviderDataById";
                        command.Parameters.Add(new SqlParameter("EnterServiceProvID", EnterServiceProvID));

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

        public static ViabilityMaintResult AddEnterpriseServProviderData(int ProjectID, string Year, string BusPlans, decimal BusPlanProjCost, 
            string CashFlows, decimal CashFlowProjCost, string Yr2Followup, decimal Yr2FollowUpProjCost, 
            string AddEnrollees, decimal AddEnrolleeProjCost, string WorkshopsEvents, decimal WorkShopEventProjCost, string Notes)
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
                        command.CommandText = "AddEnterpriseServProviderData";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("BusPlans", BusPlans));
                        command.Parameters.Add(new SqlParameter("BusPlanProjCost", BusPlanProjCost));
                        command.Parameters.Add(new SqlParameter("CashFlows", CashFlows));
                        command.Parameters.Add(new SqlParameter("CashFlowProjCost", CashFlowProjCost));
                        command.Parameters.Add(new SqlParameter("Yr2Followup", Yr2Followup));
                        command.Parameters.Add(new SqlParameter("Yr2FollowUpProjCost", Yr2FollowUpProjCost));
                        command.Parameters.Add(new SqlParameter("AddEnrollees", AddEnrollees));
                        command.Parameters.Add(new SqlParameter("AddEnrolleeProjCost", AddEnrolleeProjCost));
                        command.Parameters.Add(new SqlParameter("WorkshopsEvents", WorkshopsEvents));
                        command.Parameters.Add(new SqlParameter("WorkShopEventProjCost", WorkShopEventProjCost));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));

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

        public static void UpdateEnterpriseServProviderData(int EnterServiceProvID, string Year, string BusPlans, decimal BusPlanProjCost,
            string CashFlows, decimal CashFlowProjCost, string Yr2Followup, decimal Yr2FollowUpProjCost,
            string AddEnrollees, decimal AddEnrolleeProjCost, string WorkshopsEvents, decimal WorkShopEventProjCost, string Notes, bool RowIsActive)
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
                        command.CommandText = "UpdateEnterpriseServProviderData";

                        command.Parameters.Add(new SqlParameter("EnterServiceProvID", EnterServiceProvID));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("BusPlans", BusPlans));
                        command.Parameters.Add(new SqlParameter("BusPlanProjCost", BusPlanProjCost));
                        command.Parameters.Add(new SqlParameter("CashFlows", CashFlows));
                        command.Parameters.Add(new SqlParameter("CashFlowProjCost", CashFlowProjCost));
                        command.Parameters.Add(new SqlParameter("Yr2Followup", Yr2Followup));
                        command.Parameters.Add(new SqlParameter("Yr2FollowUpProjCost", Yr2FollowUpProjCost));
                        command.Parameters.Add(new SqlParameter("AddEnrollees", AddEnrollees));
                        command.Parameters.Add(new SqlParameter("AddEnrolleeProjCost", AddEnrolleeProjCost));
                        command.Parameters.Add(new SqlParameter("WorkshopsEvents", WorkshopsEvents));
                        command.Parameters.Add(new SqlParameter("WorkShopEventProjCost", WorkShopEventProjCost));
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

        public static DataTable GetEnterpriseServProviderDataList(int ProjectID, bool IsActiveOnly)
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
                        command.CommandText = "GetEnterpriseServProviderDataList";
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
    }
}
