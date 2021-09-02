using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VHCBCommon.DataAccessLayer;

namespace vhcbcloud
{
    public partial class GetAddressFromGoogleAPI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try { 
            DataTable dtAddress = ProjectMaintenanceData.GetAddressList();
            if (dtAddress.Rows.Count > 0)
            {
                foreach(DataRow dr in dtAddress.Rows)
                {
                    //string stNo = "";
                    //string Address1 = "1st, 2nd, and 3rd St Panton Rd";
                    //string Town = "Vergennes";
                    //string state = "VT";
                    //string zip = "05491";
                    //string address = string.Format("{0} {1}, {2}, {3}, {4}", stNo, Address1, Town, state, zip);
                    string url = string.Format("https://maps.google.com/maps/api/geocode/json?key=AIzaSyCm3xOguaZV1P3mNL0ThK7nv-H9jVyMjSU&address={0}&region=dk&sensor=false", HttpUtility.UrlEncode(dr["address"].ToString()));
                    GetData(dr, dr["ProjectID"].ToString(), dr["AddressId"].ToString(), url);
                }
            }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void GetData(DataRow dr, string ProjectID, string AddressId, string url)
        {
            string zip = "";
            string county = "";
            string village = "";
            string Lattitude = "";
            string Longitude = "";
            string town = "";

            var request = (HttpWebRequest)HttpWebRequest.Create(url);
            request.Headers.Add(HttpRequestHeader.AcceptEncoding, "gzip,deflate");
            request.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(GeoResponse));
            var res = (GeoResponse)serializer.ReadObject(request.GetResponse().GetResponseStream());

            if (res.Status == "OK")
            {
                for (var ii = 0; ii < res.Results[0].AddressComponents.Length; ii++)
                {
                    var types = string.Join(",", res.Results[0].AddressComponents[ii].Type.Select(x => x));
                    if (types == "postal_code" || types == "postal_code_prefix,postal_code")
                    {
                        if (dr["zip"].ToString() == "")
                            zip = res.Results[0].AddressComponents[ii].LongName;
                        else
                            zip = dr["zip"].ToString();
                    }

                    if (types == "administrative_area_level_2,political")
                    {
                        if (dr["County"].ToString() == "")
                            county = res.Results[0].AddressComponents[ii].ShortName.Replace("County", "");
                        else
                            county = dr["County"].ToString();
                    }
                    if (types == "neighborhood" || types == "neighborhood,political")
                    {
                        village = res.Results[0].AddressComponents[ii].ShortName;
                    }
                    if (types == "sublocality,political" || types == "locality,political" || types == "neighborhood,political" || types == "administrative_area_level_3,political")
                    {
                        town = res.Results[0].AddressComponents[ii].LongName;
                    }
                }
               

                Lattitude = res.Results[0].Geometry.Location.Latitude.ToString();
                Longitude = res.Results[0].Geometry.Location.Longitude.ToString();

                ProjectMaintenanceData.UpdateAddressLatandLang(DataUtils.GetInt(AddressId), DataUtils.GetInt(ProjectID), zip, town, county, village, Lattitude, Longitude);
            }
        }
    }
}