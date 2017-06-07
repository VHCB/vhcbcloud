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
    public class MilestoneData
    {
        public static MilestoneResult AddMilestone(int ProjectID, int Prog, string AppName, 
            int EventID, int SubEventID, int ProgEventID, int ProgSubEventID, int EntityMSID, int EntitySubMSID, 
            DateTime Date, string Note, string URL, int UserID)
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
                        command.CommandText = "AddMilestone";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID == 0 ? System.Data.SqlTypes.SqlInt32.Null : ProjectID));
                        command.Parameters.Add(new SqlParameter("Prog", Prog == 0 ? System.Data.SqlTypes.SqlInt32.Null : Prog));
                        command.Parameters.Add(new SqlParameter("AppName", AppName == "" ? System.Data.SqlTypes.SqlString.Null : AppName));
                        command.Parameters.Add(new SqlParameter("EventID", EventID));
                        command.Parameters.Add(new SqlParameter("SubEventID", SubEventID == 0 ? System.Data.SqlTypes.SqlInt32.Null : SubEventID));

                        command.Parameters.Add(new SqlParameter("ProgEventID", ProgEventID == 0 ? System.Data.SqlTypes.SqlInt32.Null : ProgEventID));
                        command.Parameters.Add(new SqlParameter("ProgSubEventID", ProgSubEventID == 0 ? System.Data.SqlTypes.SqlInt32.Null : ProgSubEventID));

                        command.Parameters.Add(new SqlParameter("EntityMSID", EntityMSID == 0 ? System.Data.SqlTypes.SqlInt32.Null : EntityMSID));
                        command.Parameters.Add(new SqlParameter("EntitySubMSID", EntitySubMSID == 0 ? System.Data.SqlTypes.SqlInt32.Null : EntitySubMSID));

                        command.Parameters.Add(new SqlParameter("Date", Date.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : Date));
                        command.Parameters.Add(new SqlParameter("Note", Note));
                        command.Parameters.Add(new SqlParameter("URL", URL));
                        command.Parameters.Add(new SqlParameter("UserID", UserID));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        MilestoneResult objResult = new MilestoneResult();

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

        public static DataTable GetProgramMilestonesList(int ProjectID, bool IsAll, bool IsAdmin, bool IsProgram, bool IsActiveOnly)
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
                        command.CommandText = "GetProgramMilestonesList";
                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("IsAll", IsAll));
                        command.Parameters.Add(new SqlParameter("IsAdmin", IsAdmin));
                        command.Parameters.Add(new SqlParameter("IsProgram", IsProgram));
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

        public static DataTable GetEventMilestonesList(string AppName, bool IsActiveOnly)
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
                        command.CommandText = "GetEventMilestonesList";
                        command.Parameters.Add(new SqlParameter("AppName", AppName));
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

        public static void DeleteMilestone(int ProjectEventID)
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
                        command.CommandText = "DeleteMilestone";
                        command.Parameters.Add(new SqlParameter("ProjectEventID", ProjectEventID));

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public class MilestoneResult
        {
            public bool IsDuplicate { set; get; }
            public bool IsActive { set; get; }
        }
    }
}
