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
            string ApplicantName, string Fname, string Lname, int Position, string Title, string FarmName, int LkFVEnterpriseType, int AcresInProduction,
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

        public static void UpdateEntity(int ApplicantId, int LkEntityType, int LKEntityType2, string FYend, string Website, string Email, string HomePhone, string WorkPhone, string CellPhone, string Stvendid,
            string ApplicantName, string Fname, string Lname, int Position, string Title, string FarmName, int LkFVEnterpriseType, int AcresInProduction,
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
                        command.CommandText = "UpdateEntity";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
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

        public static DataRow GetEntityData(int ApplicantId)
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
                        command.CommandText = "GetEntityData";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));

                        DataSet ds = new DataSet();
                        var da = new SqlDataAdapter(command);
                        da.Fill(ds);
                        if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
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

        public static DataTable GetEntitiesByRole(int LKEntityType2)
        {
            DataTable dtProjects = null;
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GetEntitiesByRole";
                command.Parameters.Add(new SqlParameter("LKEntityType2", LKEntityType2));
                using (connection)
                {
                    connection.Open();
                    command.Connection = connection;

                    var ds = new DataSet();
                    var da = new SqlDataAdapter(command);
                    da.Fill(ds);
                    if (ds.Tables.Count == 1 && ds.Tables[0].Rows != null)
                    {
                        dtProjects = ds.Tables[0];
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
            return dtProjects;
        }

        #region Address

        public static EntityMaintResult AddNewEntityAddress(int ApplicantId, string StreetNo, string Address1, string Address2,
            string Town, string State, string Zip, string County, int AddressType, bool DefAddress)
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
                        command.CommandText = "AddNewEntityAddress";

                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));

                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
                        command.Parameters.Add(new SqlParameter("AddressType", AddressType));
                        command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.ExecuteNonQuery();

                        EntityMaintResult objResult = new EntityMaintResult();

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

        public static void UpdateEntityAddress(int ApplicantId, int AddressId, int LkAddressType, string StreetNo, string Address1, string Address2,
            string Town, string State, string Zip, string County, bool IsActive, bool DefAddress)
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
                        command.CommandText = "UpdateEntityAddress";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
                        command.Parameters.Add(new SqlParameter("AddressId", AddressId)); 
                        command.Parameters.Add(new SqlParameter("LkAddressType", LkAddressType));
                        command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
                        command.Parameters.Add(new SqlParameter("Address1", Address1));
                        command.Parameters.Add(new SqlParameter("Address2", Address2));
                        command.Parameters.Add(new SqlParameter("Town", Town));
                        command.Parameters.Add(new SqlParameter("State", State));
                        command.Parameters.Add(new SqlParameter("Zip", Zip));
                        command.Parameters.Add(new SqlParameter("County", County));
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
        public static DataTable GetEntityAddressDetailsList(int ApplicantId, bool IsActiveOnly)
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
                        command.CommandText = "GetEntityAddressDetailsList";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
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

        public static DataRow GetEntityAddressDetailsById(int ApplicantId, int AddressId)
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
                        command.CommandText = "GetEntityAddressDetailsById";
                        command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));
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

        //public static void AddApplicantAddress(int ApplicantId, string StreetNo, string Address1, string Address2,
        //    string Town, string State, string Zip, string County, int AddressType, bool IsActive, bool DefAddress)
        //{
        //    try
        //    {
        //        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
        //        {
        //            connection.Open();

        //            using (SqlCommand command = new SqlCommand())
        //            {
        //                command.Connection = connection;
        //                command.CommandType = CommandType.StoredProcedure;
        //                command.CommandText = "AddApplicantAddress";

        //                command.Parameters.Add(new SqlParameter("ApplicantId", ApplicantId));

        //                command.Parameters.Add(new SqlParameter("StreetNo", StreetNo));
        //                command.Parameters.Add(new SqlParameter("Address1", Address1));
        //                command.Parameters.Add(new SqlParameter("Address2", Address2));
        //                command.Parameters.Add(new SqlParameter("Town", Town));
        //                command.Parameters.Add(new SqlParameter("State", State));
        //                command.Parameters.Add(new SqlParameter("Zip", Zip));
        //                command.Parameters.Add(new SqlParameter("County", County));
        //                command.Parameters.Add(new SqlParameter("AddressType", AddressType));
        //                command.Parameters.Add(new SqlParameter("IsActive", IsActive));
        //                command.Parameters.Add(new SqlParameter("DefAddress", DefAddress));

        //                command.ExecuteNonQuery();
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        #endregion Address

        #region Attribute
        public static DataTable GetFarmAttributesList(int FarmId, bool IsActiveOnly)
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
                        command.CommandText = "GetFarmAttributesList";
                        command.Parameters.Add(new SqlParameter("FarmId", FarmId));
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

        public static FormAttributeResult AddFarmAttribute(int FarmId, int LKFarmAttributeID)
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
                        command.CommandText = "AddFarmAttribute";

                        command.Parameters.Add(new SqlParameter("FarmId", FarmId));
                        command.Parameters.Add(new SqlParameter("LKFarmAttributeID", LKFarmAttributeID));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        FormAttributeResult acs = new FormAttributeResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateFarmAttribute(int FarmAttributeID, bool RowIsActive)
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
                        command.CommandText = "UpdateFarmAttribute";

                        command.Parameters.Add(new SqlParameter("FarmAttributeID", FarmAttributeID));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));

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
        #endregion Attribute

        #region Products
        public static DataTable GetFarmProductsList(int FarmId, bool IsActiveOnly)
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
                        command.CommandText = "GetFarmProductsList";
                        command.Parameters.Add(new SqlParameter("FarmId", FarmId));
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

        public static FormAttributeResult AddFarmProducts(int FarmId, int LkProductCrop, DateTime StartDate)
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
                        command.CommandText = "AddFarmProducts";

                        command.Parameters.Add(new SqlParameter("FarmId", FarmId));
                        command.Parameters.Add(new SqlParameter("LkProductCrop", LkProductCrop));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate.ToShortDateString() == "1/1/0001" ? System.Data.SqlTypes.SqlDateTime.Null : StartDate));

                        SqlParameter parmMessage = new SqlParameter("@isDuplicate", SqlDbType.Bit);
                        parmMessage.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage);

                        SqlParameter parmMessage1 = new SqlParameter("@isActive", SqlDbType.Int);
                        parmMessage1.Direction = ParameterDirection.Output;
                        command.Parameters.Add(parmMessage1);

                        command.CommandTimeout = 60 * 5;

                        command.ExecuteNonQuery();

                        FormAttributeResult acs = new FormAttributeResult();

                        acs.IsDuplicate = DataUtils.GetBool(command.Parameters["@isDuplicate"].Value.ToString());
                        acs.IsActive = DataUtils.GetBool(command.Parameters["@isActive"].Value.ToString());

                        return acs;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateFarmProducts(int FarmProductsID, bool RowIsActive, DateTime StartDate)
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
                        command.CommandText = "UpdateFarmProducts";

                        command.Parameters.Add(new SqlParameter("FarmProductsID", FarmProductsID));
                        command.Parameters.Add(new SqlParameter("RowIsActive", RowIsActive));
                        command.Parameters.Add(new SqlParameter("StartDate", StartDate));

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

        #endregion Products
    }

    public class EntityMaintResult
    {
        public bool IsDuplicate { set; get; }
        public int ApplicantId { set; get; }
        public bool IsActive { set; get; }
    }

    public class FormAttributeResult
    {
        public bool IsDuplicate { set; get; }
        public bool IsActive { set; get; }
    }
}
