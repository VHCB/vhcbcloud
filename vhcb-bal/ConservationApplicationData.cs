using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace VHCBCommon.DataAccessLayer
{
    public class ConservationApplicationData
    {
        public static void InsertDefaultDataForConserveApp(string ProjNumber)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "InsertDefaultDataForConserveApp";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
              

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

        public static void ConservationApplicationPage1(string ProjNumber, DateTime DateSubmit,  DateTime BoardMeetDate, decimal ConservedAcres, string Funds_Requested, string Total_Expenses,
        string App_Organ, string Project_Manager, string App_Phone, string App_Email, string Landowner_Names,
        string LOStreet, string LOAdd1, string LOAdd2, string LOTown, string LOZip, string LOVillage, string LOCounty, string LOEmail, string LOHomephone, string LOCell,
        string FarmerName, string FarmerStreet, string FarmerAdd1, string FarmerAdd2, string FarmerTown, string FarmerZip, string FarmerVillage, string FarmerCounty, string FarmerEmail, string FarmerHomePhone, string FarmerCell,
        string PropertyStreet, string PropertyAdd1, string PropertyTown, string PropertyOtherTown, string PropertyZip)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ConservationApplicationPage1";       
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("DateSubmit", DateSubmit.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : DateSubmit)); 
                command.Parameters.Add(new SqlParameter("BoardMeetDate", BoardMeetDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : BoardMeetDate));
                command.Parameters.Add(new SqlParameter("ConservedAcres", ConservedAcres));
                command.Parameters.Add(new SqlParameter("Funds_Requested", Funds_Requested));
                command.Parameters.Add(new SqlParameter("Total_Expenses", Total_Expenses));
                command.Parameters.Add(new SqlParameter("App_Organ", App_Organ));
                command.Parameters.Add(new SqlParameter("Project_Manager", Project_Manager));
                command.Parameters.Add(new SqlParameter("App_Phone", App_Phone));
                command.Parameters.Add(new SqlParameter("App_Email", App_Email));
                command.Parameters.Add(new SqlParameter("Landowner_Names", Landowner_Names));
                command.Parameters.Add(new SqlParameter("LOStreet", LOStreet));
                command.Parameters.Add(new SqlParameter("LOAdd1", LOAdd1));
                command.Parameters.Add(new SqlParameter("LOAdd2", LOAdd2));
                command.Parameters.Add(new SqlParameter("LOTown", LOTown));
                command.Parameters.Add(new SqlParameter("LOZip", LOZip));
                command.Parameters.Add(new SqlParameter("LOVillage", LOVillage));
                command.Parameters.Add(new SqlParameter("LOCounty", LOCounty));
                command.Parameters.Add(new SqlParameter("LOEmail", LOEmail));
                command.Parameters.Add(new SqlParameter("LOHomephone", LOHomephone));
                command.Parameters.Add(new SqlParameter("LOCell", LOCell));
                command.Parameters.Add(new SqlParameter("FarmerName", FarmerName));
                command.Parameters.Add(new SqlParameter("FarmerStreet", FarmerStreet));
                command.Parameters.Add(new SqlParameter("FarmerAdd1", FarmerAdd1));
                command.Parameters.Add(new SqlParameter("FarmerAdd2", FarmerAdd2));
                command.Parameters.Add(new SqlParameter("FarmerTown", FarmerTown));
                command.Parameters.Add(new SqlParameter("FarmerZip", FarmerZip));
                command.Parameters.Add(new SqlParameter("FarmerVillage", FarmerVillage));
                command.Parameters.Add(new SqlParameter("FarmerCounty", FarmerCounty));
                command.Parameters.Add(new SqlParameter("FarmerEmail", FarmerEmail));
                command.Parameters.Add(new SqlParameter("FarmerHomePhone", FarmerHomePhone));
                command.Parameters.Add(new SqlParameter("FarmerCell", FarmerCell));
                command.Parameters.Add(new SqlParameter("PropertyStreet", PropertyStreet));
                command.Parameters.Add(new SqlParameter("PropertyAdd1", PropertyAdd1));
                command.Parameters.Add(new SqlParameter("PropertyTown", PropertyTown));
                command.Parameters.Add(new SqlParameter("PropertyOtherTown", PropertyOtherTown));
                command.Parameters.Add(new SqlParameter("PropertyZip", PropertyZip));


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

        public static void FarmManagement(string ProjNumber, string FarmSize, string RAPCompliance, decimal RentedLand, decimal FullTime, decimal PartTime, string GrossIncome, string GrossIncomeDescription, bool WrittenLease, bool CompletedBusinessPlan, 
            bool ShareBusinessPlan, string MitigateClimate, string HEL, string NutrientPlan, string Dumps, bool ExistingInfastructure, string InfrastuctureDescription, string ConservationMeasures, string OtherConservationMeasures, 
            string FarmOperation, bool OtherTechnicalAdvisors, bool CurrentBusinessPlan, decimal FullTimeSeasonal, decimal PartTimeSeasonal)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "FarmManagement";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("FarmSize", FarmSize));
                command.Parameters.Add(new SqlParameter("RAPCompliance", RAPCompliance));
                command.Parameters.Add(new SqlParameter("RentedLand", RentedLand));
                command.Parameters.Add(new SqlParameter("FullTime", FullTime));
                command.Parameters.Add(new SqlParameter("PartTime", PartTime));
                command.Parameters.Add(new SqlParameter("GrossIncome", GrossIncome));
                command.Parameters.Add(new SqlParameter("GrossIncomeDescription", GrossIncomeDescription));
                command.Parameters.Add(new SqlParameter("WrittenLease", WrittenLease));
                command.Parameters.Add(new SqlParameter("CompletedBusinessPlan", CompletedBusinessPlan));
                command.Parameters.Add(new SqlParameter("ShareBusinessPlan", ShareBusinessPlan));
                command.Parameters.Add(new SqlParameter("MitigateClimate", MitigateClimate));
                command.Parameters.Add(new SqlParameter("HEL", HEL));
                command.Parameters.Add(new SqlParameter("NutrientPlan", NutrientPlan));
                command.Parameters.Add(new SqlParameter("Dumps", Dumps));
                command.Parameters.Add(new SqlParameter("ExistingInfastructure", ExistingInfastructure));
                command.Parameters.Add(new SqlParameter("InfrastuctureDescription", InfrastuctureDescription));
                command.Parameters.Add(new SqlParameter("ConservationMeasures", ConservationMeasures));
                command.Parameters.Add(new SqlParameter("OtherConservationMeasures", OtherConservationMeasures));
                command.Parameters.Add(new SqlParameter("FarmOperation", FarmOperation));
                command.Parameters.Add(new SqlParameter("OtherTechnicalAdvisors", OtherTechnicalAdvisors));
                command.Parameters.Add(new SqlParameter("CurrentBusinessPlan", CurrentBusinessPlan));
                command.Parameters.Add(new SqlParameter("FullTimeSeasonal", FullTimeSeasonal));
                command.Parameters.Add(new SqlParameter("PartTimeSeasonal", PartTimeSeasonal));

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


        public static void WaterManagement(string ProjNumber, decimal Wetlands, decimal Ponds, decimal FloodPlain, decimal StreamFeet, decimal PondFeet, string WaterBodies, string Watershed, string SubWatershed, string TacticalBasin, string DrainageDitches, 
            string DrainageTiles, string WasteInfrastructure, string ProtectWater, bool ParticipateWaterGrant, string ParticipateWaterGrantDiscussion, string LivestockExcluded, string WaterQualityConcerns,
            int LKWatershed, int LKSubWatershed, int LKSecSubWatershed, int HUC12, int secHUC12, string SubBasin, string SubBasin2, int TacticalBasinInt, string SecSubWaterShed)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "WaterManagement";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("Wetlands", Wetlands));
                command.Parameters.Add(new SqlParameter("Ponds", Ponds));
                command.Parameters.Add(new SqlParameter("FloodPlain", FloodPlain));
                command.Parameters.Add(new SqlParameter("StreamFeet", StreamFeet));
                command.Parameters.Add(new SqlParameter("PondFeet", PondFeet));
                command.Parameters.Add(new SqlParameter("WaterBodies", WaterBodies));
                command.Parameters.Add(new SqlParameter("Watershed", Watershed));
                command.Parameters.Add(new SqlParameter("SubWatershed", SubWatershed));
                command.Parameters.Add(new SqlParameter("TacticalBasin", TacticalBasin));
                command.Parameters.Add(new SqlParameter("DrainageDitches", DrainageDitches));
                command.Parameters.Add(new SqlParameter("DrainageTiles", DrainageTiles));
                command.Parameters.Add(new SqlParameter("WasteInfrastructure", WasteInfrastructure));
                command.Parameters.Add(new SqlParameter("ProtectWater", ProtectWater));
                command.Parameters.Add(new SqlParameter("ParticipateWaterGrant", ParticipateWaterGrant));
                command.Parameters.Add(new SqlParameter("ParticipateWaterGrantDiscussion", ParticipateWaterGrantDiscussion));
                command.Parameters.Add(new SqlParameter("LivestockExcluded", LivestockExcluded));
                command.Parameters.Add(new SqlParameter("WaterQualityConcerns", WaterQualityConcerns));
               // command.Parameters.Add(new SqlParameter("Acretypes", Acretypes));
                command.Parameters.Add(new SqlParameter("LKWatershed", LKWatershed));
                command.Parameters.Add(new SqlParameter("LKSubWatershed", LKSubWatershed));
                command.Parameters.Add(new SqlParameter("LKSecSubWatershed", LKSecSubWatershed));
                command.Parameters.Add(new SqlParameter("HUC12", HUC12));
                command.Parameters.Add(new SqlParameter("secHUC12", secHUC12));
                command.Parameters.Add(new SqlParameter("SubBasin", SubBasin));
                command.Parameters.Add(new SqlParameter("SubBasin2", SubBasin2));
                command.Parameters.Add(new SqlParameter("TacticalBasinInt", TacticalBasinInt));
                command.Parameters.Add(new SqlParameter("SecSubWaterShed", SecSubWaterShed));

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


        public static DataRow GetConservationApplicationPage1(string ProjNumber)
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
                        command.CommandText = "GetConservationApplicationPage1";
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

        public static DataRow GetConservationApplicationPage2(string ProjNumber)
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
                        command.CommandText = "GetConservationApplicationPage2";
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

        public static void ConservationApplicationPage2(string ProjNumber, string ZoningDistrict, string MinLotSize, decimal FrontageFeet, bool PublicWater, bool PublicSewer, bool EnrolledUseValue, decimal AcresExcluded, string AcresDerived, 
            string ExcludedLand, string DeedMatch, string SurveyRequired, string DeedRestrictions)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ConservationApplicationPage2";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("ZoningDistrict", ZoningDistrict));
                command.Parameters.Add(new SqlParameter("MinLotSize", MinLotSize));
                command.Parameters.Add(new SqlParameter("FrontageFeet", FrontageFeet));
                command.Parameters.Add(new SqlParameter("PublicWater", PublicWater));
                command.Parameters.Add(new SqlParameter("PublicSewer", PublicSewer));
                command.Parameters.Add(new SqlParameter("EnrolledUseValue", EnrolledUseValue));
                command.Parameters.Add(new SqlParameter("AcresExcluded", AcresExcluded));
                command.Parameters.Add(new SqlParameter("AcresDerived", AcresDerived));
                command.Parameters.Add(new SqlParameter("ExcludedLand", ExcludedLand));
                command.Parameters.Add(new SqlParameter("DeedMatch", DeedMatch));
                command.Parameters.Add(new SqlParameter("SurveyRequired", SurveyRequired));
                command.Parameters.Add(new SqlParameter("DeedRestrictions", DeedRestrictions));

                
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

        public static DataTable GetBoardDates()
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
                        command.CommandText = "GetBoardDates1";

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

        public static DataRow GetConservationApplicationPage3(string ProjNumber)
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
                        command.CommandText = "GetConservationApplicationPage3";
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

        public static void ConservationApplicationPage3(string ProjNumber, string ExecSummary, bool SellorConvey, string FarmerTransfer, string FarmerPlans)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ConservationApplicationPage3";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("ExecSummary", ExecSummary));
                command.Parameters.Add(new SqlParameter("SellorConvey", SellorConvey));
                command.Parameters.Add(new SqlParameter("FarmerTransfer", FarmerTransfer));
                command.Parameters.Add(new SqlParameter("FarmerPlans", FarmerPlans));
                
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

        public static DataRow GetConservationApplicationPage4(string ProjNumber)
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
                        command.CommandText = "GetConservationApplicationPage4";
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

        public static void ConservationApplicationPage4(string ProjNumber, decimal Hay, decimal Pasture, decimal Vegetables,
            string VegetableTypes, decimal Fruit, string FruitTypes, decimal Livestock, string LivestockTypes, decimal ChristmasTrees, decimal NurseryStock, decimal Organic, string OrganicAreas, decimal SugarBush, decimal ManagedTimber,  decimal OtherForest, bool ManagementPlan, 
            decimal OtherAgriculture, string OtherAgricultureProduction, decimal Unmanaged, string Agritourism, bool Trails, decimal TrailFeet, string TrailNames, decimal PrimeNonNoted,
            decimal PrimeNonNotedPCent, decimal PrimeNoted, decimal PrimeNotedPCent, decimal StatewideNonNoted,
            decimal StatewideNonNotedPCent, decimal StatewideNoted, decimal StatewideNotedPCent, decimal OtherNonAgSoils, decimal OtherNonAgSoilsPCent, decimal Total, decimal Tillable, string TrailNameIds, string othertrail, string Recuses)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ConservationApplicationPage4";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("Hay", Hay));
                //command.Parameters.Add(new SqlParameter("RoundBales", RoundBales));
                //command.Parameters.Add(new SqlParameter("SquareBales", SquareBales));
                //command.Parameters.Add(new SqlParameter("TonsperacreperYear", TonsperacreperYear));
                command.Parameters.Add(new SqlParameter("Pasture", Pasture));
                command.Parameters.Add(new SqlParameter("Vegetables", Vegetables));
                command.Parameters.Add(new SqlParameter("VegetableTypes", VegetableTypes));
                command.Parameters.Add(new SqlParameter("Fruit", Fruit));
                command.Parameters.Add(new SqlParameter("FruitTypes", FruitTypes));
                command.Parameters.Add(new SqlParameter("Livestock", Livestock));
                command.Parameters.Add(new SqlParameter("LivestockTypes", LivestockTypes));
                command.Parameters.Add(new SqlParameter("ChristmasTrees", ChristmasTrees));
                command.Parameters.Add(new SqlParameter("NurseryStock", NurseryStock));
                command.Parameters.Add(new SqlParameter("Organic", Organic));
                command.Parameters.Add(new SqlParameter("OrganicAreas", OrganicAreas));
                command.Parameters.Add(new SqlParameter("SugarBush", SugarBush));
                command.Parameters.Add(new SqlParameter("ManagedTimber", ManagedTimber));
                command.Parameters.Add(new SqlParameter("OtherForest", OtherForest));
                command.Parameters.Add(new SqlParameter("ManagementPlan", ManagementPlan));
                command.Parameters.Add(new SqlParameter("OtherAgriculture", OtherAgriculture));
                command.Parameters.Add(new SqlParameter("OtherAgricultureProduction", OtherAgricultureProduction));
                command.Parameters.Add(new SqlParameter("Unmanaged", Unmanaged));
                command.Parameters.Add(new SqlParameter("Agritourism", Agritourism));
                command.Parameters.Add(new SqlParameter("Trails", Trails));
                command.Parameters.Add(new SqlParameter("TrailFeet", TrailFeet));
                command.Parameters.Add(new SqlParameter("TrailNames", TrailNames));
                //command.Parameters.Add(new SqlParameter("Agsoils", Agsoils));
                command.Parameters.Add(new SqlParameter("PrimeNonNoted", PrimeNonNoted));
                command.Parameters.Add(new SqlParameter("PrimeNonNotedPCent", PrimeNonNotedPCent));
                command.Parameters.Add(new SqlParameter("PrimeNoted", PrimeNoted));
                command.Parameters.Add(new SqlParameter("PrimeNotedPCent", PrimeNotedPCent));
                command.Parameters.Add(new SqlParameter("StatewideNonNoted", StatewideNonNoted));
                command.Parameters.Add(new SqlParameter("StatewideNonNotedPCent", StatewideNonNotedPCent));
                command.Parameters.Add(new SqlParameter("StatewideNoted", StatewideNoted));
                command.Parameters.Add(new SqlParameter("StatewideNotedPCent", StatewideNotedPCent));
                command.Parameters.Add(new SqlParameter("OtherNonAgSoils", OtherNonAgSoils));
                command.Parameters.Add(new SqlParameter("OtherNonAgSoilsPCent", OtherNonAgSoilsPCent));
                command.Parameters.Add(new SqlParameter("Total", Total));
                command.Parameters.Add(new SqlParameter("Tillable", Tillable));
                command.Parameters.Add(new SqlParameter("TrailNameIds", TrailNameIds));
                command.Parameters.Add(new SqlParameter("othertrail", othertrail));
                command.Parameters.Add(new SqlParameter("Recuses", Recuses));

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
        
        public static DataRow GetFarmManagement(string ProjNumber)
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
                        command.CommandText = "GetFarmManagement";
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

        public static DataRow GetWaterManagement(string ProjNumber)
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
                        command.CommandText = "GetWaterManagement";
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

        public static void EasementConfig(string ProjNumber, int NumEase, string EasementTerms, bool BldgComplexChk, string BldgComplex, bool SoleDiscretionChk, string SoleDiscretion, bool FarmLaborChk, string FarmLabor, bool SubdivisionChk, string Subdivision, bool CampRightChk, string CampRight,
            bool EasementTermsOtherChk, string EasementTermsOther, bool EcoZoneChk, string EcoZone, decimal EcoZoneAcres, bool WetlandZoneChk, string WetlandZone, decimal WetlandZoneAcres, bool RiparianZoneChk, string RiparianZone, decimal RiparianZoneAcres,
            bool ArcheoZoneChk, string ArcheoZone, decimal ArcheoZoneAcres,  bool RiverEasementChk, string RiverEasement, decimal RiverEasementAcres, bool HistoricProvisionChk, string HistoricProvision, decimal HistoricProvisionAcres,
            bool PublicAccessChk, string PublicAccess, decimal PublicAccessDesc, string EasementTermsOther2, bool EasementTermsOther2Chk, string ConformancePlans, string NoLeverage, string InformTowns, string LetterSentTo,
            string LetterSentToOther, string Endorsements, string DualGoals, string Clarification)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "EasementConfig";
                command.Parameters.Add(new SqlParameter("ProjNumber", ProjNumber));
                command.Parameters.Add(new SqlParameter("NumEase", NumEase));
                command.Parameters.Add(new SqlParameter("EasementTerms", EasementTerms));
                command.Parameters.Add(new SqlParameter("BldgComplex", BldgComplex));
                command.Parameters.Add(new SqlParameter("SoleDiscretion", SoleDiscretion));
                command.Parameters.Add(new SqlParameter("FarmLabor", FarmLabor));
                command.Parameters.Add(new SqlParameter("Subdivision", Subdivision));
                command.Parameters.Add(new SqlParameter("CampRight", CampRight));
                command.Parameters.Add(new SqlParameter("EasementTermsOther", EasementTermsOther));
                command.Parameters.Add(new SqlParameter("BldgComplexChk", BldgComplexChk));
                command.Parameters.Add(new SqlParameter("SoleDiscretionChk", SoleDiscretionChk));
                command.Parameters.Add(new SqlParameter("FarmLaborChk", FarmLaborChk));
                command.Parameters.Add(new SqlParameter("SubdivisionChk", SubdivisionChk));
                command.Parameters.Add(new SqlParameter("CampRightChk", CampRightChk));
                command.Parameters.Add(new SqlParameter("EasementTermsOtherChk", EasementTermsOtherChk));
                command.Parameters.Add(new SqlParameter("EcoZone", EcoZone));
                command.Parameters.Add(new SqlParameter("WetlandZone", WetlandZone));
                command.Parameters.Add(new SqlParameter("RiparianZone", RiparianZone));
                command.Parameters.Add(new SqlParameter("ArcheoZone", ArcheoZone));
                command.Parameters.Add(new SqlParameter("RiverEasement", RiverEasement));
                command.Parameters.Add(new SqlParameter("HistoricProvision", HistoricProvision));
                command.Parameters.Add(new SqlParameter("PublicAccess", PublicAccess));
                command.Parameters.Add(new SqlParameter("EcoZoneAcres", EcoZoneAcres));
                command.Parameters.Add(new SqlParameter("WetlandZoneAcres", WetlandZoneAcres));
                command.Parameters.Add(new SqlParameter("RiparianZoneAcres", RiparianZoneAcres));
                command.Parameters.Add(new SqlParameter("ArcheoZoneAcres", ArcheoZoneAcres));
                command.Parameters.Add(new SqlParameter("RiverEasementAcres", RiverEasementAcres));
                command.Parameters.Add(new SqlParameter("HistoricProvisionAcres", HistoricProvisionAcres));
                command.Parameters.Add(new SqlParameter("PublicAccessDesc", PublicAccessDesc));
                command.Parameters.Add(new SqlParameter("EasementTermsOther2", EasementTermsOther2));
                command.Parameters.Add(new SqlParameter("EcoZoneChk", EcoZoneChk));
                command.Parameters.Add(new SqlParameter("WetlandZoneChk", WetlandZoneChk));
                command.Parameters.Add(new SqlParameter("RiparianZoneChk", RiparianZoneChk));
                command.Parameters.Add(new SqlParameter("ArcheoZoneChk", ArcheoZoneChk));
                command.Parameters.Add(new SqlParameter("RiverEasementChk", RiverEasementChk));
                command.Parameters.Add(new SqlParameter("HistoricProvisionChk", HistoricProvisionChk));
                command.Parameters.Add(new SqlParameter("PublicAccessChk", PublicAccessChk));
                command.Parameters.Add(new SqlParameter("EasementTermsOther2Chk", EasementTermsOther2Chk));
                command.Parameters.Add(new SqlParameter("ConformancePlans", ConformancePlans));
                command.Parameters.Add(new SqlParameter("NoLeverage", NoLeverage));
                command.Parameters.Add(new SqlParameter("InformTowns", InformTowns));
                command.Parameters.Add(new SqlParameter("LetterSentTo", LetterSentTo));
                command.Parameters.Add(new SqlParameter("LetterSentToOther", LetterSentToOther));
                command.Parameters.Add(new SqlParameter("Endorsements", Endorsements));
                command.Parameters.Add(new SqlParameter("DualGoals", DualGoals));
                command.Parameters.Add(new SqlParameter("Clarification", Clarification));




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

        public static DataRow GetEasementConfig(string ProjNumber)
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
                        command.CommandText = "GetEasementConfig";
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
    }
}
