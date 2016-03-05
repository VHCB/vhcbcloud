using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
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

        public static PCRDetails SubmitPCR(int ProjectID, DateTime InitDate, int LkProgram, bool LegalReview, bool Final, 
            bool LCB, decimal MatchAmt, int LkFVGrantMatch, decimal Disbursement, int PayeeApplicant, string Notes, int UserID)
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
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
                command.Parameters.Add(new SqlParameter("Final", Final));
                command.Parameters.Add(new SqlParameter("LCB", LCB));
                command.Parameters.Add(new SqlParameter("MatchAmt", MatchAmt));
                command.Parameters.Add(new SqlParameter("LkFVGrantMatch", LkFVGrantMatch));
                command.Parameters.Add(new SqlParameter("Notes", Notes));
                command.Parameters.Add(new SqlParameter("Disbursement", Disbursement));
                command.Parameters.Add(new SqlParameter("Payee", PayeeApplicant));
                command.Parameters.Add(new SqlParameter("UserID", UserID));

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
                    command.ExecuteNonQuery();

                    PCRDetails pcr = new PCRDetails();
                    pcr.ProjectCheckReqID = int.Parse(command.Parameters["@ProjectCheckReqID"].Value.ToString());
                    pcr.TransID = int.Parse(command.Parameters["@TransID"].Value.ToString());

                    return pcr;
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
    }

    public class PCRDetails
    {
        public int ProjectCheckReqID;
        public int TransID;
    }
}
