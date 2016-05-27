using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace VHCBCommon.DataAccessLayer.Lead
{
    public class ProjectLeadMilestonesData
    {
        public static DataRow GetProjectLeadMilestoneById(int LeadMilestoneID)
        {
            DataRow dr = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetProjectLeadMilestoneById";
                command.Parameters.Add(new SqlParameter("LeadMilestoneID", LeadMilestoneID));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    DataSet ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
                    {
                        dr = ds.Tables[0].Rows[0];
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
            return dr;
        }

        public static DataTable GetProjectLeadMilestoneList(int ProjectId, bool IsActiveOnly)
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
                        command.CommandText = "GetProjectLeadMilestoneList";
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

        public static LeadMilestoneResult AddProjectLeadMilestone(int ProjectID, int LKMilestone, int LeadBldgID, int LeadUnitID, DateTime MSDate)
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
                        command.CommandText = "AddProjectLeadMilestone";

                        command.Parameters.Add(new SqlParameter("ProjectID", ProjectID));
                        command.Parameters.Add(new SqlParameter("LKMilestone", LKMilestone));
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("MSDate", MSDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MSDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        LeadMilestoneResult ap = new LeadMilestoneResult();

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

        public static void UpdateProjectLeadMilestone(int LeadMilestoneID, int LKMilestone, int LeadBldgID, int LeadUnitID, 
            DateTime MSDate, bool IsRowIsActive)
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
                        command.CommandText = "UpdateProjectLeadMilestone";

                        command.Parameters.Add(new SqlParameter("LeadMilestoneID", LeadMilestoneID));
                        command.Parameters.Add(new SqlParameter("LKMilestone", LKMilestone));
                        command.Parameters.Add(new SqlParameter("LeadBldgID", LeadBldgID));
                        command.Parameters.Add(new SqlParameter("LeadUnitID", LeadUnitID));
                        command.Parameters.Add(new SqlParameter("MSDate", MSDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : MSDate));
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
    }

    public class LeadMilestoneResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
