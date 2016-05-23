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
    public class ProjectLeadDataData
    {
        public static void AddProjectLeadData(int ProjectId, DateTime StartDate, DateTime UnitsClearDate, decimal Grantamt, decimal HHIntervention, decimal Loanamt, 
            decimal Relocation, decimal ClearDecom, int Testconsult,  int PBCont, decimal TotAward)
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
                        command.CommandText = "AddProjectLeadData";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("UnitsClearDate", UnitsClearDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : UnitsClearDate));
                        command.Parameters.Add(new SqlParameter("Grantamt", Grantamt));
                        command.Parameters.Add(new SqlParameter("HHIntervention", HHIntervention));
                        command.Parameters.Add(new SqlParameter("Loanamt", Loanamt));
                        command.Parameters.Add(new SqlParameter("Relocation", Relocation));
                        command.Parameters.Add(new SqlParameter("ClearDecom", ClearDecom));
                        command.Parameters.Add(new SqlParameter("Testconsult", Testconsult));
                        command.Parameters.Add(new SqlParameter("PBCont", PBCont));
                        command.Parameters.Add(new SqlParameter("TotAward", TotAward));

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

        public static void UpdateProjectLeadData(int ProjectId, DateTime StartDate, DateTime UnitsClearDate, decimal Grantamt, decimal HHIntervention, decimal Loanamt,
            decimal Relocation, decimal ClearDecom, int Testconsult, int PBCont, decimal TotAward, bool RowIsActive)
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
                        command.CommandText = "UpdateProjectLeadData";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("UnitsClearDate", UnitsClearDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : UnitsClearDate));
                        command.Parameters.Add(new SqlParameter("Grantamt", Grantamt));
                        command.Parameters.Add(new SqlParameter("HHIntervention", HHIntervention));
                        command.Parameters.Add(new SqlParameter("Loanamt", Loanamt));
                        command.Parameters.Add(new SqlParameter("Relocation", Relocation));
                        command.Parameters.Add(new SqlParameter("ClearDecom", ClearDecom));
                        command.Parameters.Add(new SqlParameter("Testconsult", Testconsult));
                        command.Parameters.Add(new SqlParameter("PBCont", PBCont));
                        command.Parameters.Add(new SqlParameter("TotAward", TotAward));
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

        public static DataRow GetProjectLeadDataById(int ProjectId)
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
                        command.CommandText = "GetProjectLeadDataById";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));

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
