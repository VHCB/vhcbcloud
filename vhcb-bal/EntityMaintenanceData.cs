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
    public class EntityMaintenanceData
    {

        public static EntityMaintResult AddNewEntity(int LkEntityType, int LKEntityType2, string FYend, string Website, string Email, string HomePhone, string WorkPhone, string CellPhone, string Stvendid,
            string ApplicantName, string Fname, string Lname, int Position, string Title, int UserID, string FarmName, int LkFVEnterpriseType, int AcresInProduction,
            int AcresOwned, int AcresLeased, int AcresLeasedOut, int TotalAcres, bool OutOFBiz, string Notes, string AgEd, int YearsManagingFarm)
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
                        command.CommandText = "AddNewEntity";
                        command.Parameters.Add(new SqlParameter("LkEntityType", LkEntityType));
                        command.Parameters.Add(new SqlParameter("LKEntityType2", LKEntityType2));
                        command.Parameters.Add(new SqlParameter("FYend", FYend));
                        command.Parameters.Add(new SqlParameter("Website", Website));
                        command.Parameters.Add(new SqlParameter("Email", Email));
                        command.Parameters.Add(new SqlParameter("HomePhone", HomePhone));
                        command.Parameters.Add(new SqlParameter("CellPhone", CellPhone));
                        command.Parameters.Add(new SqlParameter("WorkPhone", WorkPhone));
                        command.Parameters.Add(new SqlParameter("Stvendid", Stvendid));
                        command.Parameters.Add(new SqlParameter("ApplicantName", ApplicantName));
                        command.Parameters.Add(new SqlParameter("Fname", Fname));
                        command.Parameters.Add(new SqlParameter("Lname", Lname));
                        command.Parameters.Add(new SqlParameter("Position", Position));
                        command.Parameters.Add(new SqlParameter("Title", Title == "" ? System.Data.SqlTypes.SqlString.Null : Title));
                        command.Parameters.Add(new SqlParameter("UserID", UserID));

                        command.Parameters.Add(new SqlParameter("FarmName", FarmName));
                        command.Parameters.Add(new SqlParameter("LkFVEnterpriseType", LkFVEnterpriseType));
                        command.Parameters.Add(new SqlParameter("AcresInProduction", AcresInProduction));
                        command.Parameters.Add(new SqlParameter("AcresOwned", AcresOwned));
                        command.Parameters.Add(new SqlParameter("AcresLeased", AcresLeased));
                        command.Parameters.Add(new SqlParameter("AcresLeasedOut", AcresLeasedOut));
                        command.Parameters.Add(new SqlParameter("TotalAcres", TotalAcres));
                        command.Parameters.Add(new SqlParameter("OutOFBiz", OutOFBiz));
                        command.Parameters.Add(new SqlParameter("Notes", Notes));
                        command.Parameters.Add(new SqlParameter("AgEd", AgEd));
                        command.Parameters.Add(new SqlParameter("YearsManagingFarm", YearsManagingFarm));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@ApplicantId", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        EntityMaintResult ap = new EntityMaintResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        ap.ApplicantId = DataUtils.GetInt(command.Parameters["@ApplicantId"].Value.ToString());

                        return ap;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    public class EntityMaintResult
    {
        public bool IsDuplicate { set; get; }
        public int ApplicantId { set; get; }
    }
}
