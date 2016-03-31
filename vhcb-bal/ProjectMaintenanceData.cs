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
    public class ProjectMaintenanceData
    {
        public static DataTable Getlookupvalues(int LookupType)
        {
            DataTable dtLookupvalues = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandText = "get_lookup_values";
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 60 * 5;

                        var ds = new DataSet();
                        var da = new SqlDataAdapter(command);

                        da.Fill(ds);

                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                        {
                            dtLookupvalues = ds.Tables[0];
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            
            return dtLookupvalues;
        }
    }
}
