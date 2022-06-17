using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace VHCBCommon.DataAccessLayer.Housing
{
    public class PortfolioDataData
    {
        public static DataRow GetPortfolioData(int ProjectId, string Year)
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
                        command.CommandText = "GetPortfolioData";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("Year", Year));

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

        public static void AddProjectPortfolio(int PortfolioType, string  Year, int  ProjectID,  int TotalUnits, 
            int MGender, int FGender, int UGender, int White, int Black, int Asian, int Indian, int Hawaiian, int UnknownRace, int Hispanic, int NonHisp, int UnknownEthnicity, int Homeless,
            int MarketRate, int I100, int I80, int I75, int I60, int I50, int I30, int I120)
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
                        command.CommandText = "AddProjectPortfolio";

                        command.Parameters.Add(new SqlParameter("PortfolioType", PortfolioType));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("TotalUnits", TotalUnits));
                        command.Parameters.Add(new SqlParameter("MGender", MGender));
                        command.Parameters.Add(new SqlParameter("FGender", FGender));
                        command.Parameters.Add(new SqlParameter("UGender", UGender));
                        command.Parameters.Add(new SqlParameter("White", White));
                        command.Parameters.Add(new SqlParameter("Black", Black));
                        command.Parameters.Add(new SqlParameter("Asian", Asian));
                        command.Parameters.Add(new SqlParameter("Indian", Indian));
                        command.Parameters.Add(new SqlParameter("Hawaiian", Hawaiian));
                        command.Parameters.Add(new SqlParameter("UnknownRace", UnknownRace));
                        command.Parameters.Add(new SqlParameter("Hispanic", Hispanic));
                        command.Parameters.Add(new SqlParameter("NonHisp", NonHisp));
                        command.Parameters.Add(new SqlParameter("UnknownEthnicity", UnknownEthnicity));
                        command.Parameters.Add(new SqlParameter("Homeless", Homeless));
                        command.Parameters.Add(new SqlParameter("MarketRate", MarketRate));
                        command.Parameters.Add(new SqlParameter("I100", I100));
                        command.Parameters.Add(new SqlParameter("I80", I80));
                        command.Parameters.Add(new SqlParameter("I75", I75));
                        command.Parameters.Add(new SqlParameter("I60", I60));
                        command.Parameters.Add(new SqlParameter("I50", I50));
                        command.Parameters.Add(new SqlParameter("I30", I30));
                        command.Parameters.Add(new SqlParameter("I120", I120));

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

        public static void UpdateProjectPortfolio(int ProjectPortfolioID, int PortfolioType, string Year, int TotalUnits,
            int MGender, int FGender, int UGender, int White, int Black, int Asian, int Indian, int Hawaiian, int UnknownRace, int Hispanic, int NonHisp, int UnknownEthnicity, int Homeless,
            int MarketRate, int I100, int I80, int I75, int I60, int I50, int I30, int I120)
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
                        command.CommandText = "UpdateProjectPortfolio";
                        
                        command.Parameters.Add(new SqlParameter("ProjectPortfolioID", @ProjectPortfolioID));
                        command.Parameters.Add(new SqlParameter("PortfolioType", PortfolioType));
                        command.Parameters.Add(new SqlParameter("Year", Year));
                        command.Parameters.Add(new SqlParameter("TotalUnits", TotalUnits));
                        command.Parameters.Add(new SqlParameter("MGender", MGender));
                        command.Parameters.Add(new SqlParameter("FGender", FGender));
                        command.Parameters.Add(new SqlParameter("UGender", UGender));
                        command.Parameters.Add(new SqlParameter("White", White));
                        command.Parameters.Add(new SqlParameter("Black", Black));
                        command.Parameters.Add(new SqlParameter("Asian", Asian));
                        command.Parameters.Add(new SqlParameter("Indian", Indian));
                        command.Parameters.Add(new SqlParameter("Hawaiian", Hawaiian));
                        command.Parameters.Add(new SqlParameter("UnknownRace", UnknownRace));
                        command.Parameters.Add(new SqlParameter("Hispanic", Hispanic));
                        command.Parameters.Add(new SqlParameter("NonHisp", NonHisp));
                        command.Parameters.Add(new SqlParameter("UnknownEthnicity", UnknownEthnicity));
                        command.Parameters.Add(new SqlParameter("Homeless", Homeless));
                        command.Parameters.Add(new SqlParameter("MarketRate", MarketRate));
                        command.Parameters.Add(new SqlParameter("I100", I100));
                        command.Parameters.Add(new SqlParameter("I80", I80));
                        command.Parameters.Add(new SqlParameter("I75", I75));
                        command.Parameters.Add(new SqlParameter("I60", I60));
                        command.Parameters.Add(new SqlParameter("I50", I50));
                        command.Parameters.Add(new SqlParameter("I30", I30));
                        command.Parameters.Add(new SqlParameter("I120", I120));

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
}
