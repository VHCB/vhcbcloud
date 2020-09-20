using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace VHCBCommon.DataAccessLayer.Viability
{
    public class GrantEvaluationsData
    {
        public static void AddEnterpriseGrantImprovedBusiness(int EnterImpGrantID, int LkImproveBusiness)
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
                        command.CommandText = "AddEnterpriseGrantImprovedBusiness";
                        command.Parameters.Add(new SqlParameter("EnterImpGrantID", EnterImpGrantID));
                        command.Parameters.Add(new SqlParameter("LkImproveBusiness", LkImproveBusiness));

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

        public static DataTable GetEnterpriseGrantImprovedBusinessList(int EnterImpGrantID, bool IsActiveOnly)
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
                        command.CommandText = "GetEnterpriseGrantImprovedBusinessList";
                        command.Parameters.Add(new SqlParameter("EnterImpGrantID", EnterImpGrantID));
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

        public static void AddEnterpriseGrantQuestions(int EnterImpGrantID, string FarmViability, 
            string NutrientManagement, string Compliance, string OperationalEfficiency, string QualityofLife,
            decimal EquipmentHrs, decimal Acres, int Stewardship, int Soil, int Manure, int Crop, int Milk, 
            int Health, int Efficiency, int WorkEnvironment, int Financial, int Income, int Balance, bool Permission)
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
                        command.CommandText = "AddEnterpriseGrantQuestions";
                        command.Parameters.Add(new SqlParameter("EnterImpGrantID", EnterImpGrantID));
                        command.Parameters.Add(new SqlParameter("FarmViability", FarmViability));
                        command.Parameters.Add(new SqlParameter("NutrientManagement", NutrientManagement));
                        command.Parameters.Add(new SqlParameter("Compliance", Compliance));
                        command.Parameters.Add(new SqlParameter("OperationalEfficiency", OperationalEfficiency));
                        command.Parameters.Add(new SqlParameter("QualityofLife", QualityofLife));
                        command.Parameters.Add(new SqlParameter("EquipmentHrs", EquipmentHrs));
                        command.Parameters.Add(new SqlParameter("Acres", Acres));
                        command.Parameters.Add(new SqlParameter("Stewardship", Stewardship));
                        command.Parameters.Add(new SqlParameter("Soil", Soil));
                        command.Parameters.Add(new SqlParameter("Manure", Manure));
                        command.Parameters.Add(new SqlParameter("Crop", Crop));
                        command.Parameters.Add(new SqlParameter("Milk", Milk));
                        command.Parameters.Add(new SqlParameter("Health", Health));
                        command.Parameters.Add(new SqlParameter("Efficiency", Efficiency));
                        command.Parameters.Add(new SqlParameter("WorkEnvironment", WorkEnvironment));
                        command.Parameters.Add(new SqlParameter("Financial", Financial));
                        command.Parameters.Add(new SqlParameter("Income", Income));
                        command.Parameters.Add(new SqlParameter("Balance", Balance));
                        command.Parameters.Add(new SqlParameter("Permission", Permission));
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

        public static void UpdateEnterpriseGrantQuestions(int EnterImpGrantID, string FarmViability,
           string NutrientManagement, string Compliance, string OperationalEfficiency, string QualityofLife,
           decimal EquipmentHrs, decimal Acres, int Stewardship, int Soil, int Manure, int Crop, int Milk,
           int Health, int Efficiency, int WorkEnvironment, int Financial, int Income, int Balance, bool Permission)
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
                        command.CommandText = "UpdateEnterpriseGrantQuestions";
                        command.Parameters.Add(new SqlParameter("EnterImpGrantID", EnterImpGrantID));
                        command.Parameters.Add(new SqlParameter("FarmViability", FarmViability));
                        command.Parameters.Add(new SqlParameter("NutrientManagement", NutrientManagement));
                        command.Parameters.Add(new SqlParameter("Compliance", Compliance));
                        command.Parameters.Add(new SqlParameter("OperationalEfficiency", OperationalEfficiency));
                        command.Parameters.Add(new SqlParameter("QualityofLife", QualityofLife));
                        command.Parameters.Add(new SqlParameter("EquipmentHrs", EquipmentHrs));
                        command.Parameters.Add(new SqlParameter("Acres", Acres));
                        command.Parameters.Add(new SqlParameter("Stewardship", Stewardship));
                        command.Parameters.Add(new SqlParameter("Soil", Soil));
                        command.Parameters.Add(new SqlParameter("Manure", Manure));
                        command.Parameters.Add(new SqlParameter("Crop", Crop));
                        command.Parameters.Add(new SqlParameter("Milk", Milk));
                        command.Parameters.Add(new SqlParameter("Health", Health));
                        command.Parameters.Add(new SqlParameter("Efficiency", Efficiency));
                        command.Parameters.Add(new SqlParameter("WorkEnvironment", WorkEnvironment));
                        command.Parameters.Add(new SqlParameter("Financial", Financial));
                        command.Parameters.Add(new SqlParameter("Income", Income));
                        command.Parameters.Add(new SqlParameter("Balance", Balance));
                        command.Parameters.Add(new SqlParameter("Permission", Permission));
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


        public static DataRow getEnterpriseGrantQuestions(int EnterImpGrantID)
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
                        command.CommandText = "getEnterpriseGrantQuestions";
                        command.Parameters.Add(new SqlParameter("EnterImpGrantID", EnterImpGrantID));

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
    }
}
