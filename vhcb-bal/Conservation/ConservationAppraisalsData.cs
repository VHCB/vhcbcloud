using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using VHCBCommon.DataAccessLayer;

namespace VHCBCommon.DataAccessLayer.Conservation
{
    public class ConservationAppraisalsData
    {
        public static DataRow GetConserveTotalAcres(int ProjectID)
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
                        command.CommandText = "GetConserveTotalAcres";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));

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

        #region AppraisalValue
        public static void AddConservationAppraisalValue(int ProjectID, int TotAcres, decimal Apbef, decimal Apaft, decimal Aplandopt,
            decimal Exclusion, decimal EaseValue, decimal Valperacre, string Comments, decimal FeeValue, int Type)
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
                        command.CommandText = "AddConservationAppraisalValue";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("TotAcres", TotAcres));
                        command.Parameters.Add(new SqlParameter("Apbef", Apbef));
                        command.Parameters.Add(new SqlParameter("Apaft", Apaft));
                        command.Parameters.Add(new SqlParameter("Aplandopt", Aplandopt));
                        command.Parameters.Add(new SqlParameter("Exclusion", Exclusion));
                        command.Parameters.Add(new SqlParameter("EaseValue", EaseValue));
                        command.Parameters.Add(new SqlParameter("Valperacre", Valperacre));
                        command.Parameters.Add(new SqlParameter("Comments", Comments));
                        command.Parameters.Add(new SqlParameter("FeeValue", FeeValue));
                        command.Parameters.Add(new SqlParameter("Type", Type));

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

        public static void UpdateConservationAppraisalValue(int ProjectID, int TotAcres, decimal Apbef, decimal Apaft, decimal Aplandopt,
            decimal Exclusion, decimal EaseValue, decimal Valperacre, bool IsRowIsActive, string Comments, 
            decimal FeeValue, int Type)
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
                        command.CommandText = "UpdateConservationAppraisalValue";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("TotAcres", TotAcres));
                        command.Parameters.Add(new SqlParameter("Apbef", Apbef));
                        command.Parameters.Add(new SqlParameter("Apaft", Apaft));
                        command.Parameters.Add(new SqlParameter("Aplandopt", Aplandopt));
                        command.Parameters.Add(new SqlParameter("Exclusion", Exclusion));
                        command.Parameters.Add(new SqlParameter("EaseValue", EaseValue));
                        command.Parameters.Add(new SqlParameter("Valperacre", Valperacre));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));
                        command.Parameters.Add(new SqlParameter("Comments", Comments));
                        command.Parameters.Add(new SqlParameter("FeeValue", FeeValue));
                        command.Parameters.Add(new SqlParameter("Type", Type));

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

        public static DataRow GetConservationAppraisalValueById(int ProjectID)
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
                        command.CommandText = "GetConservationAppraisalValueById";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));

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
        #endregion AppraisalValue

        #region AppraisalInfo
        public static DataTable GetConservationAppraisalInfoList(int AppraisalID, bool IsActiveOnly)
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
                        command.CommandText = "GetConservationAppraisalInfoList";
                        command.Parameters.Add(new SqlParameter("AppraisalID", AppraisalID));
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

        public static AppraisalResult AddConservationAppraisalInfo(int AppraisalID, int LkAppraiser, DateTime AppOrdered, DateTime AppRecd,
            DateTime EffDate, decimal AppCost, string Comment, DateTime NRCSSent, bool RevApproved, DateTime ReviewDate, string URL)
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
                        command.CommandText = "AddConservationAppraisalInfo";

                        command.Parameters.Add(new SqlParameter("AppraisalID", AppraisalID));
                        command.Parameters.Add(new SqlParameter("LkAppraiser", LkAppraiser));
                        command.Parameters.Add(new SqlParameter("AppOrdered", AppOrdered.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AppOrdered));
                        command.Parameters.Add(new SqlParameter("AppRecd", AppRecd.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AppRecd));
                        command.Parameters.Add(new SqlParameter("EffDate", EffDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EffDate));
                        command.Parameters.Add(new SqlParameter("AppCost", AppCost));
                        command.Parameters.Add(new SqlParameter("Comment", Comment));
                        command.Parameters.Add(new SqlParameter("NRCSSent", NRCSSent.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : NRCSSent));
                        command.Parameters.Add(new SqlParameter("RevApproved", RevApproved));
                        command.Parameters.Add(new SqlParameter("ReviewDate", ReviewDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ReviewDate));
                        command.Parameters.Add(new SqlParameter("URL", URL));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AppraisalResult ap = new AppraisalResult();

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

        public static void UpdateConservationAppraisalInfo(int AppraisalInfoID, int LkAppraiser, DateTime AppOrdered, DateTime AppRecd,
            DateTime EffDate, decimal AppCost, string Comment, DateTime NRCSSent, bool RevApproved, DateTime ReviewDate, 
            bool IsRowIsActive, string URL)
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
                        command.CommandText = "UpdateConservationAppraisalInfo";

                        command.Parameters.Add(new SqlParameter("AppraisalInfoID", AppraisalInfoID));
                        command.Parameters.Add(new SqlParameter("LkAppraiser", LkAppraiser));
                        command.Parameters.Add(new SqlParameter("AppOrdered", AppOrdered.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AppOrdered));
                        command.Parameters.Add(new SqlParameter("AppRecd", AppRecd.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : AppRecd));
                        command.Parameters.Add(new SqlParameter("EffDate", EffDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EffDate));
                        command.Parameters.Add(new SqlParameter("AppCost", AppCost));
                        command.Parameters.Add(new SqlParameter("Comment", Comment));
                        command.Parameters.Add(new SqlParameter("NRCSSent", NRCSSent.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : NRCSSent));
                        command.Parameters.Add(new SqlParameter("RevApproved", RevApproved));
                        command.Parameters.Add(new SqlParameter("ReviewDate", ReviewDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : ReviewDate));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));
                        command.Parameters.Add(new SqlParameter("URL", URL));

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

        public static DataRow GetConservationAppraisalInfoById(int AppraisalInfoID)
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
                        command.CommandText = "GetConservationAppraisalInfoById";
                        command.Parameters.Add(new SqlParameter("AppraisalInfoID", AppraisalInfoID));

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
        #endregion AppraisalInfo

        #region AppraisalPay
        public static DataTable GetConservationAppraisalPayList(int AppraisalInfoID, bool IsActiveOnly)
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
                        command.CommandText = "GetConservationAppraisalPayList";
                        command.Parameters.Add(new SqlParameter("AppraisalInfoID", AppraisalInfoID));
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

        public static void AddConservationAppraisalPay(int AppraisalInfoID, decimal PayAmt, int WhoPaid)
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
                        command.CommandText = "AddConservationAppraisalPay";

                        command.Parameters.Add(new SqlParameter("AppraisalInfoID", AppraisalInfoID));
                        command.Parameters.Add(new SqlParameter("PayAmt", PayAmt));
                        command.Parameters.Add(new SqlParameter("WhoPaid", WhoPaid));
                        
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

        public static void UpdateConservationAppraisalPay(int AppraisalPayID, decimal PayAmt, int WhoPaid, bool IsRowIsActive)
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
                        command.CommandText = "UpdateConservationAppraisalPay";

                        command.Parameters.Add(new SqlParameter("AppraisalPayID", AppraisalPayID));
                        command.Parameters.Add(new SqlParameter("PayAmt", PayAmt));
                        command.Parameters.Add(new SqlParameter("WhoPaid", WhoPaid));
                        command.Parameters.Add(new SqlParameter("IsRowIsActive", IsRowIsActive));

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

        #endregion AppraisalPay

    }

    public class AppraisalResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
