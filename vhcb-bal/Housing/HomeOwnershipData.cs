using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VHCBCommon.DataAccessLayer.Housing
{
    public class HomeOwnershipData
    {
        public static DataTable GetHomeOwnershipList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetHomeOwnershipList";
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

        public static HomeOwnershipResult AddHomeOwnershipAddress(int ProjectID, int AddressID, bool MH, bool Condo, bool SFD)
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
                        command.CommandText = "AddHomeOwnershipAddress";

                        //11 Parameters 
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("AddressID", AddressID));
                        command.Parameters.Add(new SqlParameter("MH", MH));
                        command.Parameters.Add(new SqlParameter("Condo", Condo));
                        command.Parameters.Add(new SqlParameter("SFD", SFD));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HomeOwnershipResult ap = new HomeOwnershipResult();

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

        public static DataRow GetHomeOwnershipById(int HomeOwnershipID)
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
                        command.CommandText = "GetHomeOwnershipById";
                        command.Parameters.Add(new SqlParameter("HomeOwnershipID", HomeOwnershipID));

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

        public static void UpdateHouseOwnership(int HomeOwnershipID, int AddressID, bool MH, bool Condo, bool SFD, bool IsRowIsActive)
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
                        command.CommandText = "UpdateHouseOwnership";

                        command.Parameters.Add(new SqlParameter("HomeOwnershipID", HomeOwnershipID));
                        command.Parameters.Add(new SqlParameter("AddressID", AddressID));
                        command.Parameters.Add(new SqlParameter("MH", MH));
                        command.Parameters.Add(new SqlParameter("Condo", Condo));
                        command.Parameters.Add(new SqlParameter("SFD", SFD));
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


        public static DataTable GetProjectHomeOwnershipList(int HomeOwnershipID, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectHomeOwnershipList";
                        command.Parameters.Add(new SqlParameter("HomeOwnershipID", HomeOwnershipID));
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

        public static HomeOwnershipResult AddProjectHomeOwnership(int HomeOwnershipID, int Owner, int LkLender, bool vhfa, bool RDLoan, decimal VHCBGrant, decimal OwnerApprec, decimal CapImprove,
            decimal InitFee, decimal ResaleFee, decimal StewFee, decimal AssistLoan, decimal RehabLoan, DateTime PurchaseDate)
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
                        command.CommandText = "AddProjectHomeOwnership";

                        command.Parameters.Add(new SqlParameter("HomeOwnershipID", HomeOwnershipID));
                        command.Parameters.Add(new SqlParameter("Owner", Owner));
                        command.Parameters.Add(new SqlParameter("LkLender", LkLender));
                        command.Parameters.Add(new SqlParameter("vhfa", vhfa));
                        command.Parameters.Add(new SqlParameter("RDLoan", RDLoan));
                        command.Parameters.Add(new SqlParameter("VHCBGrant", VHCBGrant));
                        command.Parameters.Add(new SqlParameter("OwnerApprec", OwnerApprec));
                        command.Parameters.Add(new SqlParameter("CapImprove", CapImprove));
                        command.Parameters.Add(new SqlParameter("InitFee", InitFee));
                        command.Parameters.Add(new SqlParameter("ResaleFee", ResaleFee));
                        command.Parameters.Add(new SqlParameter("StewFee", StewFee));
                        command.Parameters.Add(new SqlParameter("AssistLoan", AssistLoan));
                        command.Parameters.Add(new SqlParameter("RehabLoan", RehabLoan));
                        command.Parameters.Add(new SqlParameter("PurchaseDate", PurchaseDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : PurchaseDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);


                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        HomeOwnershipResult ap = new HomeOwnershipResult();

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

        public static void UpdateProjectHomeOwnership(int ProjectHomeOwnershipID, int Owner, int LkLender, bool vhfa, bool RDLoan, decimal VHCBGrant, decimal OwnerApprec, decimal CapImprove,
           decimal InitFee, decimal ResaleFee, decimal StewFee, decimal AssistLoan, decimal RehabLoan, DateTime PurchaseDate, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectHomeOwnership";
                        command.Parameters.Add(new SqlParameter("ProjectHomeOwnershipID", ProjectHomeOwnershipID));
                        command.Parameters.Add(new SqlParameter("Owner", Owner));
                        command.Parameters.Add(new SqlParameter("LkLender", LkLender));
                        command.Parameters.Add(new SqlParameter("vhfa", vhfa));
                        command.Parameters.Add(new SqlParameter("RDLoan", RDLoan));
                        command.Parameters.Add(new SqlParameter("VHCBGrant", VHCBGrant));
                        command.Parameters.Add(new SqlParameter("OwnerApprec", OwnerApprec));
                        command.Parameters.Add(new SqlParameter("CapImprove", CapImprove));
                        command.Parameters.Add(new SqlParameter("InitFee", InitFee));
                        command.Parameters.Add(new SqlParameter("ResaleFee", ResaleFee));
                        command.Parameters.Add(new SqlParameter("StewFee", StewFee));
                        command.Parameters.Add(new SqlParameter("AssistLoan", AssistLoan));
                        command.Parameters.Add(new SqlParameter("RehabLoan", RehabLoan));
                        command.Parameters.Add(new SqlParameter("PurchaseDate", PurchaseDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : PurchaseDate));
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


        public static DataRow GetProjectHomeOwnershipById(int ProjectHomeOwnershipID)
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
                        command.CommandText = "GetProjectHomeOwnershipById";
                        command.Parameters.Add(new SqlParameter("ProjectHomeOwnershipID", ProjectHomeOwnershipID));

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
    }

    public class HomeOwnershipResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
