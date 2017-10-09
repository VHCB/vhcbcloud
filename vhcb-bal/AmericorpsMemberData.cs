using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace VHCBCommon.DataAccessLayer
{
    public class AmericorpsMemberData
    {
        public static DataRow GetAmericopMemberInfo(int ProjectID)
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
                        command.CommandText = "GetAmericopMemberInfo";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));

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

        public static DataRow GetACMember(int ApplicantId)
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
                        command.CommandText = "GetACMember";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));

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
        public static AmericorpMemberResult AddACMember(int ApplicantID, int ContactID, DateTime StartDate, DateTime EndDate, int LkSlot, int LkServiceType, 
            int Tshirt, int SweatShirt, int DietPref, string MedConcerns, string Notes)
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
                        command.CommandText = "AddACMember";

                        command.Parameters.Add(new SqlParameter("ApplicantID", ApplicantID));
                        command.Parameters.Add(new SqlParameter("ContactID", ContactID));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
                        command.Parameters.Add(new SqlParameter("LkSlot", LkSlot));
                        command.Parameters.Add(new SqlParameter("LkServiceType", LkServiceType));
                        command.Parameters.Add(new SqlParameter("Tshirt", Tshirt));
                        command.Parameters.Add(new SqlParameter("SweatShirt", SweatShirt));
                        command.Parameters.Add(new SqlParameter("DietPref", DietPref));
                        command.Parameters.Add(new SqlParameter("MedConcerns", MedConcerns));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        AmericorpMemberResult objResult = new AmericorpMemberResult();

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

        public static void UpdateACMember(int ACMemberID, DateTime StartDate, DateTime EndDate, int LkSlot, int LkServiceType,
            int Tshirt, int SweatShirt, int DietPref, string MedConcerns, string Notes)
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
                        command.CommandText = "UpdateACMember";

                        command.Parameters.Add(new SqlParameter("ACMemberID", ACMemberID));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));
                        command.Parameters.Add(new SqlParameter("EndDate", EndDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : EndDate));
                        command.Parameters.Add(new SqlParameter("LkSlot", LkSlot));
                        command.Parameters.Add(new SqlParameter("LkServiceType", LkServiceType));
                        command.Parameters.Add(new SqlParameter("Tshirt", Tshirt));
                        command.Parameters.Add(new SqlParameter("SweatShirt", SweatShirt));
                        command.Parameters.Add(new SqlParameter("DietPref", DietPref));
                        command.Parameters.Add(new SqlParameter("MedConcerns", MedConcerns));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));

                       
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateContactDOB(int ApplicantId, DateTime DOB)
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
                        command.CommandText = "UpdateContactDOB";

                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
                        command.Parameters.Add(new SqlParameter("DOB", DOB.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : DOB));

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

        public static DataRow GetApplicantAddress(int Applicantid)
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
                        command.CommandText = "GetApplicantAddress";
                        command.Parameters.Add(new SqlParameter("Applicantid", Applicantid));

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

        public static DataView GetACMemberFormData(int ACMemberID, int Groupnum, bool isActive)
        {
            DataView dt = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "GetACMemberFormData";
                        command.Parameters.Add(new SqlParameter("ACMemberID", ACMemberID));
                        command.Parameters.Add(new SqlParameter("Groupnum", Groupnum));
                        command.Parameters.Add(new SqlParameter("isActive", isActive));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dt = ds.Tables[0].DefaultView;

                            if(isActive)
                            dt.RowFilter = "RowIsActive = " + isActive;
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

        public static DataTable GetACForms(int GroupNum)
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
                        command.CommandText = "GetACForms";
                        command.Parameters.Add(new SqlParameter("GroupNum", GroupNum));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
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

        public static AmericorpMemberResult AddACMemberForm(int ACMemberID, int ACFormID, bool Received, DateTime Date, string URL, string Notes)
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
                        command.CommandText = "AddACMemberForm";

                        command.Parameters.Add(new SqlParameter("ACMemberID", ACMemberID));
                        command.Parameters.Add(new SqlParameter("ACFormID", ACFormID));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("Received", Received));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        AmericorpMemberResult objResult = new AmericorpMemberResult();

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

        public static void UpdateACMemberForm(int ACMemberFormId, bool Received, DateTime Date, string URL, string Notes, bool RowisActive)
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
                        command.CommandText = "UpdateACMemberForm";

                        command.Parameters.Add(new SqlParameter("ACMemberFormId", ACMemberFormId));
                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("Received", Received));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("RowisActive", RowisActive));

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

        public static DataRow GetACMemberFormDataById(int ACmemberformID)
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
                        command.CommandText = "GetACMemberFormDataById";
                        command.Parameters.Add(new SqlParameter("ACmemberformID", ACmemberformID));

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
    }
    
    public class AmericorpMemberResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
