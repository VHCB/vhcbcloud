using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataAccessLayer
{
    //Applicant
    public class EntityData
    {
        public static void AddEntity(bool IsIndividual, int EntityType, string FiscalYearEnd, string Website, string StateVendorId, int PhoneType, string Phone, string ApplicantName,
            string Fname, string Lname, int Position, string Title, string Email,
            string StreetNo, string Address1, string Address2, string Town, string State, string Zip, string County, int AddressType, bool IsActive, bool DefAddress)
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
                        command.CommandText = "add_new_applicant";

                        //25 Parameters
                        command.Parameters.Add(new SqlParameter("IsIndividual", IsIndividual));
                        command.Parameters.Add(new SqlParameter("EntityType", EntityType));
                        command.Parameters.Add(new SqlParameter("FiscalYearEnd", FiscalYearEnd == "" ? System.Data.SqlTypes.SqlString.Null : FiscalYearEnd));
                        command.Parameters.Add(new SqlParameter("Website", Website == ""? System.Data.SqlTypes.SqlString.Null : Website));
                        command.Parameters.Add(new SqlParameter("StateVendorId", StateVendorId == "" ? System.Data.SqlTypes.SqlString.Null : StateVendorId));
                        command.Parameters.Add(new SqlParameter("PhoneType", PhoneType == 0 ? System.Data.SqlTypes.SqlInt32.Null : PhoneType));
                        command.Parameters.Add(new SqlParameter("Phone", Phone == "" ? System.Data.SqlTypes.SqlString.Null : Phone));
                        command.Parameters.Add(new SqlParameter("ApplicantName", ApplicantName));

                        command.Parameters.Add(new SqlParameter("Fname", Fname));
                        command.Parameters.Add(new SqlParameter("Lname", Lname));
                        command.Parameters.Add(new SqlParameter("Position", Position == 0 ? System.Data.SqlTypes.SqlInt32.Null : Position));
                        command.Parameters.Add(new SqlParameter("Title", Title == "" ? System.Data.SqlTypes.SqlString.Null : Title));
                        command.Parameters.Add(new SqlParameter("Email", Email == "" ? System.Data.SqlTypes.SqlString.Null : Email));

                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("AddressType", AddressType));
                        command.Parameters.Add(new SqlParameter("IsActive", IsActive));
                        command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));

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

        public static void UpdateApplicantDetails(int @ApplicantId, bool IsIndividual, int EntityType, string FiscalYearEnd, string Website, string StateVendorId, int PhoneType, string Phone, string ApplicantName,
           string Fname, string Lname, int Position, string Title, string Email)
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
                        command.CommandText = "UpdateApplicantDetails";

                        //16 Parameters
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
                        command.Parameters.Add(new SqlParameter("IsIndividual", IsIndividual));
                        command.Parameters.Add(new SqlParameter("EntityType", EntityType));
                        command.Parameters.Add(new SqlParameter("FiscalYearEnd", FiscalYearEnd == "" ? System.Data.SqlTypes.SqlString.Null : FiscalYearEnd));
                        command.Parameters.Add(new SqlParameter("Website", Website == "" ? System.Data.SqlTypes.SqlString.Null : Website));
                        command.Parameters.Add(new SqlParameter("StateVendorId", StateVendorId == "" ? System.Data.SqlTypes.SqlString.Null : StateVendorId));
                        command.Parameters.Add(new SqlParameter("PhoneType", PhoneType == 0 ? System.Data.SqlTypes.SqlInt32.Null : PhoneType));
                        command.Parameters.Add(new SqlParameter("Phone", Phone == "" ? System.Data.SqlTypes.SqlString.Null : Phone));
                        command.Parameters.Add(new SqlParameter("ApplicantName", ApplicantName));

                        command.Parameters.Add(new SqlParameter("Fname", Fname));
                        command.Parameters.Add(new SqlParameter("Lname", Lname));
                        command.Parameters.Add(new SqlParameter("Position", Position == 0 ? System.Data.SqlTypes.SqlInt32.Null : Position));
                        command.Parameters.Add(new SqlParameter("Title", Title == "" ? System.Data.SqlTypes.SqlString.Null : Title));
                        command.Parameters.Add(new SqlParameter("Email", Email == "" ? System.Data.SqlTypes.SqlString.Null : Email));

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

        public static DataTable GetApplicantNameForAutoComplete(string applicantNamePrefix)
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
                        command.CommandText = "add_new_applicant";
                        command.Parameters.Add(new SqlParameter("applicantNamePrefix", applicantNamePrefix));

                        var ds = new DataSet();
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

        public static DataTable GetApplicantDetails(int AppNameId)
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
                        command.CommandText = "GetApplicantDetails";
                        command.Parameters.Add(new SqlParameter("appnameid", AppNameId));

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

        public static DataTable GetApplicantAddressDetails(int AppNameId)
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
                        command.CommandText = "GetApplicantAddressDetails";
                        command.Parameters.Add(new SqlParameter("appnameid", AppNameId));

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

        public static DataRow GetAddressDetailsByAddressId(int AddressId)
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
                        command.CommandText = "GetApplicantAddressDetailsById";
                        command.Parameters.Add(new SqlParameter("AddressId", AddressId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
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

        public static void UpdateApplicantAddress(int ApplicantId, int AddressId, string StreetNo, string Address1, string Address2,
            string Town, string State, string Zip, string County, int AddressType, bool IsActive, bool DefAddress)
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
                        command.CommandText = "UpdateApplicantAddress";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
                        command.Parameters.Add(new SqlParameter("AddressId", AddressId));
                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("AddressType", AddressType));
                        command.Parameters.Add(new SqlParameter("IsActive", IsActive));
                        command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void AddApplicantAddress(int ApplicantId, string StreetNo, string Address1, string Address2,
            string Town, string State, string Zip, string County, int AddressType, bool IsActive, bool DefAddress)
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
                        command.CommandText = "AddApplicantAddress";

                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));

                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("AddressType", AddressType));
                        command.Parameters.Add(new SqlParameter("IsActive", IsActive));
                        command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable GetApplicants(string ProcName)
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
                        command.CommandText = ProcName;
                        
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
