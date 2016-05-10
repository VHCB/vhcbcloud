using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace VHCBCommon.DataAccessLayer.Conservation
{
    public class ConservationStewardshipData
    {
        #region ConserveMajorAmend
        public static DataTable GetMajorAmendmentsList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetMajorAmendmentsList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
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

        public static AddConsAmend AddConservationMajorAmend(int ProjectId, int LkConsMajAmend, DateTime ReqDate, int LkDisp, 
            DateTime DispDate)
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
                        command.CommandText = "AddConservationMajorAmend";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LkConsMajAmend", LkConsMajAmend));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddConsAmend objAddConsMajorAmend = new AddConsAmend();

                        objAddConsMajorAmend.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objAddConsMajorAmend.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objAddConsMajorAmend;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateConservationMajorAmend(int ConserveMajAmendID, DateTime ReqDate, int LkDisp, DateTime DispDate, 
            bool RowIsActive)
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
                        command.CommandText = "UpdateConservationMajorAmend";

                        command.Parameters.Add(new SqlParameter("ConserveMajAmendID", ConserveMajAmendID));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));
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

        #endregion ConserveMajorAmend

        #region ConserveMinorAmend
        public static DataTable GetMinorAmendmentsList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetMinorAmendmentsList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
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

        public static AddConsAmend AddConservationMinorAmend(int ProjectId, int LkConsMinAmend, DateTime ReqDate, int LkDisp,
            DateTime DispDate)
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
                        command.CommandText = "AddConservationMinorAmend";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LkConsMinAmend", LkConsMinAmend));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddConsAmend objAddConsMajorAmend = new AddConsAmend();

                        objAddConsMajorAmend.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objAddConsMajorAmend.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objAddConsMajorAmend;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateConservationMinorAmend(int ConserveMinAmendID, DateTime ReqDate, int LkDisp, DateTime DispDate,
            bool RowIsActive)
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
                        command.CommandText = "UpdateConservationMinorAmend";

                        command.Parameters.Add(new SqlParameter("ConserveMinAmendID", ConserveMinAmendID));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));
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
        #endregion ConserveMinorAmend

        #region ConserveViolations
        public static DataTable GetConserveViolationsList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetConserveViolationsList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
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

        public static AddConsAmend AddConserveViolations(int ProjectId, int LkConsViol, DateTime ReqDate, int LkDisp,
            DateTime DispDate)
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
                        command.CommandText = "AddConserveViolations";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LkConsViol", LkConsViol));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddConsAmend objAddConsMajorAmend = new AddConsAmend();

                        objAddConsMajorAmend.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objAddConsMajorAmend.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objAddConsMajorAmend;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateConserveViolations(int ConserveViolationsID, DateTime ReqDate, int LkDisp, DateTime DispDate,
            bool RowIsActive)
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
                        command.CommandText = "UpdateConserveViolations";

                        command.Parameters.Add(new SqlParameter("ConserveViolationsID", ConserveViolationsID));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));
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
        #endregion ConserveViolations

        #region ConserveApprovals
        public static DataTable GetConserveApprovalsList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetConserveApprovalsList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
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

        public static AddConsAmend AddConserveApprovals(int ProjectId, int LKApproval, DateTime ReqDate, int LkDisp,
            DateTime DispDate)
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
                        command.CommandText = "AddConserveApprovals";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LKApproval", LKApproval));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddConsAmend objAddConsMajorAmend = new AddConsAmend();

                        objAddConsMajorAmend.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objAddConsMajorAmend.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objAddConsMajorAmend;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateConserveApprovals(int ConserveApprovalID, DateTime ReqDate, int LkDisp, DateTime DispDate,
            bool RowIsActive)
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
                        command.CommandText = "UpdateConserveApprovals";

                        command.Parameters.Add(new SqlParameter("ConserveApprovalID", ConserveApprovalID));
                        command.Parameters.Add(new SqlParameter("ReqDate", ReqDate));
                        command.Parameters.Add(new SqlParameter("LkDisp", LkDisp));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));
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
        #endregion ConserveApprovals

        #region ConserveManagementPlans
        public static DataTable GetConservePlansList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetConservePlansList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
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

        public static AddConsAmend AddConservePlans(int ProjectId, int LKManagePlan, DateTime DispDate)
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
                        command.CommandText = "AddConservePlans";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LKManagePlan", LKManagePlan));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddConsAmend objAddConsAmend = new AddConsAmend();

                        objAddConsAmend.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objAddConsAmend.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objAddConsAmend;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateConservePlans(int ConservePlanID, DateTime DispDate, bool RowIsActive)
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
                        command.CommandText = "UpdateConservePlans";

                        command.Parameters.Add(new SqlParameter("ConservePlanID", ConservePlanID));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));
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
        #endregion ConserveManagementPlans

        #region ConserveEvent
        public static DataTable GetConserveEventList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetConserveEventList";
                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
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

        public static AddConsAmend AddConserveEvent(int ProjectId, int LKEvent, DateTime DispDate)
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
                        command.CommandText = "AddConserveEvent";

                        command.Parameters.Add(new SqlParameter("ProjectId", ProjectId));
                        command.Parameters.Add(new SqlParameter("LKEvent", LKEvent));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        AddConsAmend objAddConsAmend = new AddConsAmend();

                        objAddConsAmend.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        objAddConsAmend.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return objAddConsAmend;

                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateConserveEvent(int ConserveEventID, DateTime DispDate, bool RowIsActive)
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
                        command.CommandText = "UpdateConserveEvent";

                        command.Parameters.Add(new SqlParameter("ConserveEventID", ConserveEventID));
                        command.Parameters.Add(new SqlParameter("DispDate", DispDate));
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

        #endregion ConserveEvent
        public class AddConsAmend
        {
            public bool IsDuplicate { set; get; }
            public bool IsActive { set; get; }
        }

    }
}
