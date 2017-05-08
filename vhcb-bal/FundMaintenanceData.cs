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
    public class FundMaintenanceData
    {
        public static DataTable GetFundName(bool RowIsActive)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundName";
                command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
                    }
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
            return dtStatus;
        }

        public static DataTable GetFundNumbers(bool RowIsActive)
        {
            DataTable dtStatus = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetFundNumbers";
                command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtStatus = ds.Tables[0];
                    }
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
            return dtStatus;
        }

        public static DataRow SearchFund(int FundId)
        {
            DataRow dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "SearchFund";

                        command.Parameters.Add(new SqlParameter("FundId", FundId));

                        command.CommandTimeout = 60 * 5;

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                        {
                            dt = ds.Tables[0].Rows[0];
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

        public static AddFund AddFund(string name, string abbrv, int LkFundType, string account, 
            int LkAcctMethod, string DeptID, string VHCBCode, bool IsMitigationFund)
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
                        command.CommandText = "AddFund";
                        command.Parameters.Add(new SqlParameter("name", name));
                        command.Parameters.Add(new SqlParameter("abbrv", abbrv));
                        command.Parameters.Add(new SqlParameter("LkFundType", LkFundType));
                        command.Parameters.Add(new SqlParameter("account", account));
                        command.Parameters.Add(new SqlParameter("LkAcctMethod", LkAcctMethod));
                        command.Parameters.Add(new SqlParameter("IsMitigationFund", IsMitigationFund));

                        if (DeptID != "NA")
                            command.Parameters.Add(new SqlParameter("DeptID", DeptID));
                        if (VHCBCode != "NA")
                            command.Parameters.Add(new SqlParameter("VHCBCode", VHCBCode));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Bit);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddFund ap = new AddFund();

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

        public static void UpdateFund(int FundId, string abbrv, int LkFundType, string account,
            int LkAcctMethod, string DeptID, string VHCBCode, bool IsRowActive, bool IsMitigationFund)
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
                        command.CommandText = "UpdateFund";

                        command.Parameters.Add(new SqlParameter("FundId", FundId));
                        //command.Parameters.Add(new SqlParameter("name", name));
                        command.Parameters.Add(new SqlParameter("abbrv", abbrv));
                        command.Parameters.Add(new SqlParameter("LkFundType", LkFundType));
                        command.Parameters.Add(new SqlParameter("account", account));
                        command.Parameters.Add(new SqlParameter("LkAcctMethod", LkAcctMethod));
                        command.Parameters.Add(new SqlParameter("DeptID", DeptID));
                        command.Parameters.Add(new SqlParameter("VHCBCode", VHCBCode));
                        command.Parameters.Add(new SqlParameter("IsMitigationFund", IsMitigationFund));
                        command.Parameters.Add(new SqlParameter("IsRowActive", IsRowActive));

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

    public class AddFund
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
