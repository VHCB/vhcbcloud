using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VHCBCommon.DataAccessLayer;


namespace VHCBCommon.DataAccessLayer
{
    public class ViabilityApplicationData
    {
        public static void ViabilityApplicationPage1(string ProjNumber, string PrimContact, string AllOwners, 
            string MAStreet, string MAAdd1, string MAAdd2, string MACity, string MAZip, string MAVillage, string MACounty,
            string PAStreet, string PAAdd1, string PAAdd2, string PACity, string PAZip, string PAVillage, string PACounty, 
            string WorkPhone, string CellPhone, string HomePhone, string Email, int HearAbout, string PriorParticipation, string PrimeAdvisor)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage1";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                //command.Parameters.Add(new SqlParameter("ProjType", ProjType));
                command.Parameters.Add(new SqlParameter("PrimContact", PrimContact));
                command.Parameters.Add(new SqlParameter("AllOwners", AllOwners));
                //command.Parameters.Add(new SqlParameter("MAContact", MAContact));
                command.Parameters.Add(new SqlParameter("MAStreet", MAStreet));
                command.Parameters.Add(new SqlParameter("MAAdd1", MAAdd1));
                command.Parameters.Add(new SqlParameter("MAAdd2", MAAdd2));
                command.Parameters.Add(new SqlParameter("MACity", MACity));
                command.Parameters.Add(new SqlParameter("MAZip", MAZip));
                command.Parameters.Add(new SqlParameter("MAVillage", MAVillage));
                command.Parameters.Add(new SqlParameter("MACounty", MACounty));
                //command.Parameters.Add(new SqlParameter("PAContact", PAContact));
                command.Parameters.Add(new SqlParameter("PAStreet", PAStreet));
                command.Parameters.Add(new SqlParameter("PAAdd1", PAAdd1));
                command.Parameters.Add(new SqlParameter("PAAdd2", PAAdd2));
                command.Parameters.Add(new SqlParameter("PACity", PACity));
                command.Parameters.Add(new SqlParameter("PAZip", PAZip));
                command.Parameters.Add(new SqlParameter("PAVillage", PAVillage));
                command.Parameters.Add(new SqlParameter("PACounty", PACounty));
                command.Parameters.Add(new SqlParameter("WorkPhone", WorkPhone));
                command.Parameters.Add(new SqlParameter("CellPhone", CellPhone));
                command.Parameters.Add(new SqlParameter("HomePhone", HomePhone));
                command.Parameters.Add(new SqlParameter("Email", Email));
                command.Parameters.Add(new SqlParameter("HearAbout", HearAbout)); 
                command.Parameters.Add(new SqlParameter("PriorParticipation", PriorParticipation));
                command.Parameters.Add(new SqlParameter("PrimeAdvisor", PrimeAdvisor));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }


        public static DataRow GetViabilityApplicationPage1(string ProjNumber)
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
                        command.CommandText = "GetViabilityApplicationPage1";
                        command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
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

        public static void ViabilityApplicationPage2(string ProjNumber, string OrgName, string Website, string Org_Structure,
           int Cows, int Hogs, int Poultry, string Other, int Milked_Daily, string Primary_Animals, int Herd, int Rolling_Herd,
           int Milk_Pounds, int Cull, int Somatic, string Milk_Sold, string GrossSales, string Netincome, string GrossPayroll,
           string Networth, decimal FamilyFTE, decimal NonFamilyFTE, int FiscalYr, decimal AcresInProduction, decimal AcresOwned, decimal AcresLeased, decimal PastureAcres, 
           string LandYouOwn, string LandOwnText)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage2";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("OrgName", OrgName));
                command.Parameters.Add(new SqlParameter("Website", Website));
                command.Parameters.Add(new SqlParameter("Org_Structure", Org_Structure));
                command.Parameters.Add(new SqlParameter("Cows", Cows));
                command.Parameters.Add(new SqlParameter("Hogs", Hogs));
                command.Parameters.Add(new SqlParameter("Poultry", Poultry));
                command.Parameters.Add(new SqlParameter("Other", Other));
                command.Parameters.Add(new SqlParameter("Milked_Daily", Milked_Daily));
                command.Parameters.Add(new SqlParameter("Primary_Animals", Primary_Animals));
                command.Parameters.Add(new SqlParameter("Herd", Herd));
                command.Parameters.Add(new SqlParameter("Rolling_Herd", Rolling_Herd));
                command.Parameters.Add(new SqlParameter("Milk_Pounds", Milk_Pounds));
                command.Parameters.Add(new SqlParameter("Cull", Cull));
                command.Parameters.Add(new SqlParameter("Somatic", Somatic));
                command.Parameters.Add(new SqlParameter("Milk_Sold", Milk_Sold));
                //command.Parameters.Add(new SqlParameter("Dairy_Other", Dairy_Other));
                command.Parameters.Add(new SqlParameter("GrossSales", GrossSales));
                command.Parameters.Add(new SqlParameter("Netincome", Netincome));
                command.Parameters.Add(new SqlParameter("GrossPayroll", GrossPayroll));
                command.Parameters.Add(new SqlParameter("Networth", Networth));
                command.Parameters.Add(new SqlParameter("FamilyFTE", FamilyFTE));
                command.Parameters.Add(new SqlParameter("NonFamilyFTE", NonFamilyFTE));
                command.Parameters.Add(new SqlParameter("FiscalYr", FiscalYr));
                command.Parameters.Add(new SqlParameter("AcresInProduction", AcresInProduction));
                command.Parameters.Add(new SqlParameter("AcresOwned", AcresOwned));
                command.Parameters.Add(new SqlParameter("AcresLeased", AcresLeased));
                command.Parameters.Add(new SqlParameter("PastureAcres", PastureAcres));
                command.Parameters.Add(new SqlParameter("LandYouOwn", LandYouOwn));
                command.Parameters.Add(new SqlParameter("LandOwnText", LandOwnText));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataRow GetViabilityApplicationPage2(string ProjNumber)
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
                        command.CommandText = "GetViabilityApplicationPage2";
                        command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
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

        public static DataRow GetGrantRequest(string ProjNumber)
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
                        command.CommandText = "GetGrantRequest";
                        command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
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

        public static void InsertGrantRequest(string ProjNumber, string ProjTitle, string ProjDesc, decimal ProjCost, decimal Request, string strProjCost, string strRequest)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "InsertGrantRequest";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("ProjTitle", ProjTitle));
                command.Parameters.Add(new SqlParameter("ProjDesc", ProjDesc));
                command.Parameters.Add(new SqlParameter("ProjCost", ProjCost));
                command.Parameters.Add(new SqlParameter("Request", Request));
                command.Parameters.Add(new SqlParameter("strProjCost", strProjCost));
                command.Parameters.Add(new SqlParameter("strRequest", strRequest));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataRow GetViabilityApplicationData(string ProjNumber)
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
                        command.CommandText = "GetViabilityApplicationData";
                        command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
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

        public static void ViabilityApplicationPage6(string ProjNumber, string Budget)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage6";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("Budget", Budget));
               
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void ViabilityApplicationPage7(string ProjNumber, string FarmBusiness1, string FarmProduction2, string ProductsProduced3)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage7";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("FarmBusiness1", FarmBusiness1));
                command.Parameters.Add(new SqlParameter("FarmProduction2", FarmProduction2));
                command.Parameters.Add(new SqlParameter("ProductsProduced3", ProductsProduced3));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void ViabilityApplicationPage8(string ProjNumber, string FarmOwners4, string SurfaceWaters5, string MajorGoals6)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage8";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("FarmOwners4", FarmOwners4));
                command.Parameters.Add(new SqlParameter("SurfaceWaters5", SurfaceWaters5));
                command.Parameters.Add(new SqlParameter("MajorGoals6", MajorGoals6));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void ViabilityApplicationPage9(string ProjNumber, string PositiveImpact7, string TechAdvisors8, string LongTermPlans9, string NoGrant10, 
            string Timeline11, string NoContribution12, string NutrientManagementPlan13, string Permits14)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage9";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("PositiveImpact7", PositiveImpact7));
                command.Parameters.Add(new SqlParameter("TechAdvisors8", TechAdvisors8));
                command.Parameters.Add(new SqlParameter("LongTermPlans9", LongTermPlans9));
                command.Parameters.Add(new SqlParameter("NoGrant10", NoGrant10));
                command.Parameters.Add(new SqlParameter("Timeline11", Timeline11));
                command.Parameters.Add(new SqlParameter("NoContribution12", NoContribution12));
                command.Parameters.Add(new SqlParameter("NutrientManagementPlan13", NutrientManagementPlan13));
                command.Parameters.Add(new SqlParameter("Permits14", Permits14));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void ViabilityApplicationPage10(string ProjNumber, bool Confident_Sharing, string Confident_Funding, string Confident_Signature, DateTime Confident_Date)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ViabilityApplicationPage10";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("Confident_Sharing", Confident_Sharing));
                command.Parameters.Add(new SqlParameter("Confident_Funding", Confident_Funding));
                command.Parameters.Add(new SqlParameter("Confident_Signature", Confident_Signature));
                command.Parameters.Add(new SqlParameter("Confident_Date", Confident_Date));
               
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void WaterQualityGrants(string ProjNumber, int Farmsize, string FarmsizeText, int LKWatershed, int PrimaryProduct, string LKProducts, string SecProducts)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "WaterQualityGrants";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("Farmsize", Farmsize));
                command.Parameters.Add(new SqlParameter("FarmsizeText", FarmsizeText));
                command.Parameters.Add(new SqlParameter("LKWatershed", LKWatershed));
                command.Parameters.Add(new SqlParameter("PrimaryProduct", PrimaryProduct));
                command.Parameters.Add(new SqlParameter("LKProducts", LKProducts));
                command.Parameters.Add(new SqlParameter("SecProducts", SecProducts));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static DataRow GetWaterQualityGrants(string ProjNumber)
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
                        command.CommandText = "GetWaterQualityGrants";
                        command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
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

        public static DataRow CheckFullValidation(string ProjNumber)
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
                        command.CommandText = "CheckFullValidation";
                        command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0)
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

        public static void SubmitApplication(string ProjectNumber)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "SubmitApplication";
                command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));
               
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }
    }
}
