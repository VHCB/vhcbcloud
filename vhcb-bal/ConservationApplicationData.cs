using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace VHCBCommon.DataAccessLayer
{
    public class ConservationApplicationData
    {
        public static void ConservationApplicationPage1(string ProjNumber, DateTime DateSubmit,  DateTime BoardMeetDate, decimal ConservedAcres, decimal Funds_Requested, decimal Total_Expenses,
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
    }
}
