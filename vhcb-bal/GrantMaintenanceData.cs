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
    public class GrantMaintenanceData
    {
        public static DataTable SearchGrantInfo(string VHCBName, int Program, int LkGrantAgency, int Grantor, bool IsActiveOnly)
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
                        command.CommandText = "SearchGrantInfo";


                        if (string.IsNullOrWhiteSpace(VHCBName) == false)
                            command.Parameters.Add(new SqlParameter("VHCBName", VHCBName));
                        if (Program != 0)
                            command.Parameters.Add(new SqlParameter("Program", Program));

                        if (LkGrantAgency != 0)
                            command.Parameters.Add(new SqlParameter("LkGrantAgency", LkGrantAgency));

                        if (Grantor != 0)
                            command.Parameters.Add(new SqlParameter("Grantor", Grantor));

                        command.Parameters.Add(new SqlParameter("IsActiveOnly", IsActiveOnly));

                        command.CommandTimeout = 60 * 5;

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

        public static DataRow GetGrantInfo(int GrantInfoId)
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
                        command.CommandText = "GetGrantInfo";
                        command.Parameters.Add(new SqlParameter("GrantInfoID", GrantInfoId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
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

        public static DBResult AddGrantInfo(string VHCBName, decimal AwardAmt, DateTime BeginDate, DateTime EndDate, 
            int LkGrantAgency, string GrantName, int ContactID, string AwardNum, string CFDA, int LkGrantSource, int Staff, 
            int Program, bool FedFunds, bool Admin, bool Match, bool Fundsrec)
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
                        command.CommandText = "AddGrantInfoV2";

                        command.Parameters.Add(new SqlParameter("VHCBName", VHCBName));
                        command.Parameters.Add(new SqlParameter("AwardAmt", AwardAmt));
                        command.Parameters.Add(new SqlParameter("BeginDate", BeginDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : BeginDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
                        command.Parameters.Add(new SqlParameter("LkGrantAgency", LkGrantAgency == 0 ? System.Data.SqlTypes.SqlInt32.Null : LkGrantAgency));
                        command.Parameters.Add(new SqlParameter("GrantName", GrantName));
                        command.Parameters.Add(new SqlParameter("ContactID", ContactID == 0 ? System.Data.SqlTypes.SqlInt32.Null : ContactID));
                        command.Parameters.Add(new SqlParameter("AwardNum", AwardNum));
                        command.Parameters.Add(new SqlParameter("CFDA", CFDA));
                        command.Parameters.Add(new SqlParameter("LkGrantSource", LkGrantSource == 0 ? System.Data.SqlTypes.SqlInt32.Null : LkGrantSource));
                        command.Parameters.Add(new SqlParameter("Staff", Staff == 0 ? System.Data.SqlTypes.SqlInt32.Null : Staff));
                        command.Parameters.Add(new SqlParameter("Program", Program == 0 ? System.Data.SqlTypes.SqlInt32.Null : Program));
                        command.Parameters.Add(new SqlParameter("FedFunds", FedFunds));
                        command.Parameters.Add(new SqlParameter("Admin", Admin));
                        command.Parameters.Add(new SqlParameter("Match", Match));
                        command.Parameters.Add(new SqlParameter("Fundsrec", Fundsrec));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Bit);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        DBResult ap = new DBResult();

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

        public static void UpdateGrantInfo(int GrantInfoId, string VHCBName, decimal AwardAmt, DateTime BeginDate, DateTime EndDate,
            int LkGrantAgency, string GrantName, int ContactID, string AwardNum, string CFDA, int LkGrantSource, int Staff,
            int Program, bool FedFunds, bool Admin, bool Match, bool Fundsrec, bool RowIsActive)
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
                        command.CommandText = "UpdateGrantInfoV2";
                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                        command.Parameters.Add(new SqlParameter("VHCBName", VHCBName));
                        command.Parameters.Add(new SqlParameter("AwardAmt", AwardAmt));
                        command.Parameters.Add(new SqlParameter("BeginDate", BeginDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : BeginDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
                        command.Parameters.Add(new SqlParameter("LkGrantAgency", LkGrantAgency == 0 ? System.Data.SqlTypes.SqlInt32.Null : LkGrantAgency));
                        command.Parameters.Add(new SqlParameter("GrantName", GrantName));
                        command.Parameters.Add(new SqlParameter("ContactID", ContactID == 0 ? System.Data.SqlTypes.SqlInt32.Null : ContactID));
                        command.Parameters.Add(new SqlParameter("AwardNum", AwardNum));
                        command.Parameters.Add(new SqlParameter("CFDA", CFDA));
                        command.Parameters.Add(new SqlParameter("LkGrantSource", LkGrantSource == 0 ? System.Data.SqlTypes.SqlInt32.Null : LkGrantSource));
                        command.Parameters.Add(new SqlParameter("Staff", Staff == 0 ? System.Data.SqlTypes.SqlInt32.Null : Staff));
                        command.Parameters.Add(new SqlParameter("Program", Program == 0 ? System.Data.SqlTypes.SqlInt32.Null : Program));
                        command.Parameters.Add(new SqlParameter("FedFunds", FedFunds));
                        command.Parameters.Add(new SqlParameter("Admin", Admin));
                        command.Parameters.Add(new SqlParameter("Match", Match));
                        command.Parameters.Add(new SqlParameter("Fundsrec", Fundsrec));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable GetFundGrantinfoList(int GrantInfoId, bool IsActiveOnly)
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
                        command.CommandText = "GetFundGrantinfoList";
                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
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

        public static void UpdateFundGrantinfo(int GrantInfoId, bool RowIsActive)
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
                        command.CommandText = "UpdateFundGrantinfo";
                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));
                        
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static EntityMaintResult AddFundToGrantInfo(int GrantInfoId, int FundId)
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
                        command.CommandText = "AddFundToGrantInfo";

                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                        command.Parameters.Add(new SqlParameter("FundId", FundId));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        EntityMaintResult objResult = new EntityMaintResult();

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

        public static DataTable GetGrantinfoFYAmtList(int GrantInfoId, bool IsActiveOnly)
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
                        command.CommandText = "GetGrantinfoFYAmtList";
                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
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

        public static DataTable GetGrantMilestonesList(int GrantInfoId, bool IsActiveOnly)
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
                        command.CommandText = "GetGrantMilestonesList";
                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
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

        public static void AddGrantMilestones(int GrantInfoId, int MilestoneID, DateTime Date, string Note, string URL)
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
                        command.CommandText = "AddGrantMilestones";

                        command.Parameters.Add(new SqlParameter("GrantInfoId", GrantInfoId));
                        command.Parameters.Add(new SqlParameter("MilestoneID", MilestoneID));
                        command.Parameters.Add(new SqlParameter("Date", Date));
                        command.Parameters.Add(new SqlParameter("Note", Note));
                        command.Parameters.Add(new SqlParameter("URL", URL));

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateGrantMilestones(int MilestoneGrantID, int MilestoneID, DateTime Date, 
            string Note, string URL, bool RowIsActive)
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
                        command.CommandText = "UpdateGrantMilestones";

                        command.Parameters.Add(new SqlParameter("MilestoneGrantID", MilestoneGrantID));
                        command.Parameters.Add(new SqlParameter("MilestoneID", MilestoneID));
                        command.Parameters.Add(new SqlParameter("Date", Date));
                        command.Parameters.Add(new SqlParameter("Note", Note));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

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

    public class DBResult
    {
        public bool IsDuplicate { set; get; }
        public int DuplicateId { set; get; }
        public int ApplicantId { set; get; }
        public bool IsActive { set; get; }
    }
}
