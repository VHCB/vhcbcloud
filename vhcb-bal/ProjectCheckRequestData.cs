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
    public static class ProjectCheckRequestData
    {

        public static DataTable GetData(string ProcName)
        {
            DataTable dtData = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = ProcName;
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtData = ds.Tables[0];
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
            return dtData;
        }

        public static DataTable GetApplicantName(int ProjectId)
        {
            DataTable dtApplicantNames = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectId));
                command.CommandText = "PCR_ApplicantName";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtApplicantNames = ds.Tables[0];
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
            return dtApplicantNames;
        }

        public static DataTable GetProjectFinLegalApplicant(int ProjectId)
        {
            DataTable dtApplicantNames = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectId));
                command.CommandText = "GetProjectFinLegalApplicant";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtApplicantNames = ds.Tables[0];
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
            return dtApplicantNames;
        }
        public static DataTable PCR_Program(int ProjectId)
        {
            DataTable dtApplicantNames = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projId", ProjectId));
                command.CommandText = "PCR_Program";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtApplicantNames = ds.Tables[0];
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
            return dtApplicantNames;
        }

        public static DataTable GetProjectApplicant(int ProjectId)
        {
            DataTable dtApplicantNames = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectId));
                command.CommandText = "GetProjectApplicant";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtApplicantNames = ds.Tables[0];
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
            return dtApplicantNames;
        }

        public static DataRow GetAvailableFundsByProject(int ProjectId)
        {
            DataRow dtApplicantNames = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projid", ProjectId));
                command.CommandText = "getAvailableFundsByProject";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtApplicantNames = ds.Tables[0].Rows[0];
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
            return dtApplicantNames;
        }

        public static DataTable GetPayeeNameByProjectId(int ProjectId)
        {
            DataTable dtApplicantNames = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectId));
                command.CommandText = "GetPayeeNameByProjectId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtApplicantNames = ds.Tables[0];
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
            return dtApplicantNames;
        }

        public static DataTable GetQuestionsForApproval(int ProjectCheckReqId)
        {
            DataTable dtQuestionsForApproval = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.CommandText = "PCR_Load_Questions_For_Approval";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtQuestionsForApproval = ds.Tables[0];
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
            return dtQuestionsForApproval;
        }

        public static DataTable GetDefaultPCRQuestions(bool IsLegal, int ProjectCheckReqId)
        {
            DataTable dtDefaultQuetions = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("IsLegal", IsLegal));
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.CommandText = "GetDefaultPCRQuestions";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtDefaultQuetions = ds.Tables[0];
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
            return dtDefaultQuetions;
        }

        public static DataSet GetPCRDetails(int ProjectCheckReqId)
        {
            DataSet dsData = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.CommandText = "GetPCRDetails";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    dsData = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(dsData);
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
            return dsData;
        }

        public static DataTable GetPCRTranDetails(string TransId)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("transId", TransId));
                command.CommandText = "PCR_Trans_Detail_Load";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static DataTable GetUserByUserName(string username)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("username", username));
                command.CommandText = "GetUserByUserName";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static DataTable GetPCRNODDetails(string ProjectCheckReqId)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.CommandText = "GetNODDataByPCRID";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static DataTable GetPCRDataById(string ProjectCheckReqId)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", Convert.ToInt32(ProjectCheckReqId)));
                command.CommandText = "GetPCRDataById";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static DataTable GetExistingPCRByProjId(string ProjId)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("projId", Convert.ToInt32(ProjId)));
                command.CommandText = "GetExistingPCRByProjId";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static DataTable GetPCRQuestions(string ProjectCheckReqId)
        {
            DataTable dtTranDetails = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.CommandText = "GetQuestionsByPCRID";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtTranDetails = ds.Tables[0];
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
            return dtTranDetails;
        }

        public static DataTable GetPCRQuestions(bool IsLegal)
        {
            DataTable dtPCRQuestions = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("IsLegal", IsLegal));
                command.CommandText = "PCR_Questions";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtPCRQuestions = ds.Tables[0];
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
            return dtPCRQuestions;
        }

        public static DataTable SubmitPCR(int ProjectID, DateTime InitDate, int LkProgram, bool LegalReview,
           bool LCB, decimal MatchAmt, int LkFVGrantMatch, decimal Disbursement, int PayeeApplicant, int LkStatus, string Notes, int UserID, string LKNODs)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtPCRDet = null;
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PCR_Submit";
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("InitDate", InitDate));
                command.Parameters.Add(new SqlParameter("LkProgram", LkProgram));
                command.Parameters.Add(new SqlParameter("LegalReview", LegalReview));
                command.Parameters.Add(new SqlParameter("LCB", LCB));
                command.Parameters.Add(new SqlParameter("MatchAmt", (MatchAmt == 0) ? System.Data.SqlTypes.SqlDecimal.Null : MatchAmt));
                command.Parameters.Add(new SqlParameter("LkFVGrantMatch", (LkFVGrantMatch == 0) ? System.Data.SqlTypes.SqlInt32.Null : LkFVGrantMatch));
                command.Parameters.Add(new SqlParameter("Notes", Notes));
                command.Parameters.Add(new SqlParameter("Disbursement", Disbursement));
                command.Parameters.Add(new SqlParameter("Payee", PayeeApplicant));
                command.Parameters.Add(new SqlParameter("LkStatus", LkStatus));
                command.Parameters.Add(new SqlParameter("UserID", UserID));
                command.Parameters.Add(new SqlParameter("LKNODs", LKNODs));

                SqlParameter parmMessage = new SqlParameter("@ProjectCheckReqID", SqlDbType.Int);
                parmMessage.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmMessage);

                SqlParameter parmMessage1 = new SqlParameter("@TransID", SqlDbType.Int);
                parmMessage1.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmMessage1);

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    PCRDetails pcr = new PCRDetails();

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtPCRDet = ds.Tables[0];
                    }
                    pcr.ProjectCheckReqID = int.Parse(command.Parameters["@ProjectCheckReqID"].Value.ToString());
                    pcr.TransID = int.Parse(command.Parameters["@TransID"].Value.ToString());
                    return dtPCRDet;
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
        }

        public static DataTable UpdatePCR(int PRCID, int ProjectID, DateTime InitDate, int LkProgram, bool LegalReview,
           bool LCB, decimal MatchAmt, int LkFVGrantMatch, decimal Disbursement, int PayeeApplicant, int LkStatus, string Notes, int UserID, string LKNODs)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            DataTable dtPCRDet = null;
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PCR_Update";
                command.Parameters.Add(new SqlParameter("ProjectCheckReqID", PRCID));
                command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                command.Parameters.Add(new SqlParameter("InitDate", InitDate));
                command.Parameters.Add(new SqlParameter("LkProgram", LkProgram));
                command.Parameters.Add(new SqlParameter("LegalReview", LegalReview));
                command.Parameters.Add(new SqlParameter("LCB", LCB));
                command.Parameters.Add(new SqlParameter("MatchAmt", (MatchAmt == 0) ? System.Data.SqlTypes.SqlDecimal.Null : MatchAmt));
                command.Parameters.Add(new SqlParameter("LkFVGrantMatch", (LkFVGrantMatch == 0) ? System.Data.SqlTypes.SqlInt32.Null : LkFVGrantMatch));
                command.Parameters.Add(new SqlParameter("Notes", Notes));
                command.Parameters.Add(new SqlParameter("Disbursement", Disbursement));
                command.Parameters.Add(new SqlParameter("Payee", PayeeApplicant));
                command.Parameters.Add(new SqlParameter("LkStatus", LkStatus));
                command.Parameters.Add(new SqlParameter("UserID", UserID));
                command.Parameters.Add(new SqlParameter("LKNODs", LKNODs));

                SqlParameter parmMessage1 = new SqlParameter("@TransID", SqlDbType.Int);
                parmMessage1.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmMessage1);

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtPCRDet = ds.Tables[0];
                    }

                    PCRDetails pcr = new PCRDetails();
                    pcr.ProjectCheckReqID = int.Parse(command.Parameters["@ProjectCheckReqID"].Value.ToString()); 
                    pcr.TransID = int.Parse(command.Parameters["@TransID"].Value.ToString());

                    return dtPCRDet;
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
        }

        public static void AddDefaultPCRQuestions(bool IsLegal, int ProjectCheckReqId, int staffid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("IsLegal", IsLegal));
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.Parameters.Add(new SqlParameter("staffId", staffid));
                command.CommandText = "AddDefaultPCRQuestions";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void PCR_Submit_NOD(int ProjectCheckReqId, int LKNOD)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("ProjectCheckReqId", ProjectCheckReqId));
                command.Parameters.Add(new SqlParameter("LKNOD", LKNOD));
                command.CommandText = "PCR_Submit_NOD";
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void AddPCRTransactionFundDetails(int transid, int fundid, int fundtranstype, decimal fundamount)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PCR_Trans_Detail_Submit";
                command.Parameters.Add(new SqlParameter("transid", transid));
                command.Parameters.Add(new SqlParameter("fundid", fundid));
                command.Parameters.Add(new SqlParameter("fundtranstype", fundtranstype));
                command.Parameters.Add(new SqlParameter("fundamount", fundamount));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static void SubmitPCRForm(int ProjectCheckReqID, int LkPCRQuestionsID, int staffid)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PCR_Submit_Questions";

                command.Parameters.Add(new SqlParameter("ProjectCheckReqID", ProjectCheckReqID));
                command.Parameters.Add(new SqlParameter("LkPCRQuestionsID", LkPCRQuestionsID));
                command.Parameters.Add(new SqlParameter("staffId", staffid));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }

        public static decimal GetPCRDisbursemetDetailTotal(int ProjectCheckReqID)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                decimal total = 0;
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PCR_Disbursment_Detail_Total";
                command.Parameters.Add(new SqlParameter("ProjectCheckReqID", ProjectCheckReqID));

                SqlParameter parmMessage1 = new SqlParameter("@total", SqlDbType.Decimal);
                parmMessage1.Direction = ParameterDirection.Output;
                command.Parameters.Add(parmMessage1);

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();

                    total = decimal.Parse(command.Parameters["@total"].Value.ToString());

                    return total;
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
        }

        public static void UpdatePCRQuestionsApproval(int ProjectCheckReqQuestionid, bool isApproved, int UserID)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                object returnMsg = "";
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PCR_Update_Questions_For_Approval";

                command.Parameters.Add(new SqlParameter("ProjectCheckReqQuestionid", ProjectCheckReqQuestionid));
                command.Parameters.Add(new SqlParameter("Approved", isApproved));
                command.Parameters.Add(new SqlParameter("StaffID", UserID));

                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;
                    command.ExecuteNonQuery();
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
        }
    }

    public class PCRDetails
    {
        public int ProjectCheckReqID;
        public int TransID;
        public string pcrDetails;
    }
}
