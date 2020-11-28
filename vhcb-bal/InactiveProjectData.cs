using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace VHCBCommon.DataAccessLayer
{
    public class InactiveProjectData
    {
        public static InactiveProjectResult AddInactiveProject(string ProjectNumber, string LoginName, string Password, bool RowIsActive)
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
                        command.CommandText = "AddInactiveProject";
                        command.Parameters.Add(new SqlParameter("ProjectNumber", ProjectNumber));
                        command.Parameters.Add(new SqlParameter("LoginName", LoginName));
                        command.Parameters.Add(new SqlParameter("Password", Password));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));


                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        InactiveProjectResult ap = new InactiveProjectResult();

                        ap.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                       

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

    public class InactiveProjectResult
    {
        public bool IsDuplicate { set; get; }
    }
}
