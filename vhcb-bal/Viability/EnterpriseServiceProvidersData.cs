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
        public static bool IsYearExist(int ProjectID, string Year)
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
                        command.CommandText = "IsYearExist";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("Year", Year));

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

        public static DataTable GetEnterpriseServProviderDataById(int EnterpriseMasterServiceProvID)
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
                        command.Parameters.Add(new SqlParameter("EnterpriseMasterServiceProvID", EnterpriseMasterServiceProvID));

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

        public static void AddEnterpriseServProviderData(int ProjectID, string Year, int PrePost, string BusPlans, decimal BusPlanProjCost, 
            string CashFlows, decimal CashFlowProjCost, string Yr2Followup, decimal Yr2FollowUpProjCost, 
            string AddEnrollees, decimal AddEnrolleeProjCost, string WorkshopsEvents, decimal WorkShopEventProjCost, string SplProjects, string Notes)
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
                        command.Parameters.Add(new SqlParameter("SplProjects", SplProjects));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));

                        command.Parameters.Add(new SqlParameter("PrePost", PrePost));
                       
                       
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateEnterpriseServProviderData(int EnterpriseMasterServiceProvID, string BusPlans, decimal BusPlanProjCost,
            string CashFlows, decimal CashFlowProjCost, string Yr2Followup, decimal Yr2FollowUpProjCost,
            string AddEnrollees, decimal AddEnrolleeProjCost, string WorkshopsEvents, decimal WorkShopEventProjCost, string Notes, string SplProjects,
            string BusPlans1, decimal BusPlanProjCost1,
            string CashFlows1, decimal CashFlowProjCost1, string Yr2Followup1, decimal Yr2FollowUpProjCost1,
            string AddEnrollees1, decimal AddEnrolleeProjCost1, string WorkshopsEvents1, decimal WorkShopEventProjCost1, string SplProjects1, string Notes1, 
            bool RowIsActive)
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

                        command.Parameters.Add(new SqlParameter("EnterpriseMasterServiceProvID", EnterpriseMasterServiceProvID));
                      
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
                        command.Parameters.Add(new SqlParameter("SplProjects", SplProjects));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));

                        command.Parameters.Add(new SqlParameter("BusPlans1", BusPlans1));
                        command.Parameters.Add(new SqlParameter("BusPlanProjCost1", BusPlanProjCost1));
                        command.Parameters.Add(new SqlParameter("CashFlows1", CashFlows1));
                        command.Parameters.Add(new SqlParameter("CashFlowProjCost1", CashFlowProjCost1));
                        command.Parameters.Add(new SqlParameter("Yr2Followup1", Yr2Followup1));
                        command.Parameters.Add(new SqlParameter("Yr2FollowUpProjCost1", Yr2FollowUpProjCost1));
                        command.Parameters.Add(new SqlParameter("AddEnrollees1", AddEnrollees1));
                        command.Parameters.Add(new SqlParameter("AddEnrolleeProjCost1", AddEnrolleeProjCost1));
                        command.Parameters.Add(new SqlParameter("WorkshopsEvents1", WorkshopsEvents1));
                        command.Parameters.Add(new SqlParameter("WorkShopEventProjCost1", WorkShopEventProjCost1));
                        command.Parameters.Add(new SqlParameter("SplProjects1", SplProjects1));
                        command.Parameters.Add(new SqlParameter("Notes1", Notes1));

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
