using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VHCBCommon.DataAccessLayer
{
    public class HOPWAMaintenanceData
    {
        public static DataTable GetHOPWAMasterList(bool IsActiveOnly)
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
                        command.CommandText = "GetHOPWAMasterList";
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

        public static HOPWAmainttResult AddHOPWAMaster(string UUID, string HHincludes, int PrimaryASO, int WithHIV, int InHousehold, int Minors, int Gender, int Age, 
            int Ethnic, int Race, decimal GMI, decimal AMI, int Beds, string Notes)
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
                        command.CommandText = "AddHOPWAMaster";
                        command.Parameters.Add(new SqlParameter("UUID", UUID));
                        command.Parameters.Add(new SqlParameter("HHincludes", HHincludes));
                        command.Parameters.Add(new SqlParameter("PrimaryASO", PrimaryASO));
                        command.Parameters.Add(new SqlParameter("WithHIV", WithHIV));
                        command.Parameters.Add(new SqlParameter("InHousehold", InHousehold));
                        command.Parameters.Add(new SqlParameter("Minors", Minors));
                        command.Parameters.Add(new SqlParameter("Gender", Gender));
                        command.Parameters.Add(new SqlParameter("Age", Age));
                        command.Parameters.Add(new SqlParameter("Ethnic", Ethnic));
                        command.Parameters.Add(new SqlParameter("Race", Race));
                        command.Parameters.Add(new SqlParameter("GMI", GMI));
                        command.Parameters.Add(new SqlParameter("AMI", AMI));
                        command.Parameters.Add(new SqlParameter("Beds", Beds));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage2 = new SqlParameter("@isActive", SqlDbType.Bit);
                        parmMessage2.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage2);
                        
                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HOPWAmainttResult ap = new HOPWAmainttResult();

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

        public static void UpdateHOPWAMaster(int HOPWAID, string HHincludes, int PrimaryASO, int WithHIV, int InHousehold, int Minors, int Gender, int Age,
            int Ethnic, int Race, decimal GMI, decimal AMI, int Beds, string Notes, bool isActive)
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
                        command.CommandText = "UpdateHOPWAMaster";

                        command.Parameters.Add(new SqlParameter("HOPWAID", HOPWAID));
                        command.Parameters.Add(new SqlParameter("HHincludes", HHincludes));
                        command.Parameters.Add(new SqlParameter("PrimaryASO", PrimaryASO));
                        command.Parameters.Add(new SqlParameter("WithHIV", WithHIV));
                        command.Parameters.Add(new SqlParameter("InHousehold", InHousehold));
                        command.Parameters.Add(new SqlParameter("Minors", Minors));
                        command.Parameters.Add(new SqlParameter("Gender", Gender));
                        command.Parameters.Add(new SqlParameter("Age", Age));
                        command.Parameters.Add(new SqlParameter("Ethnic", Ethnic));
                        command.Parameters.Add(new SqlParameter("Race", Race));
                        command.Parameters.Add(new SqlParameter("GMI", GMI));
                        command.Parameters.Add(new SqlParameter("AMI", AMI));
                        command.Parameters.Add(new SqlParameter("Beds", Beds));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("isActive", isActive));

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
    public class HOPWAmainttResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }

}
