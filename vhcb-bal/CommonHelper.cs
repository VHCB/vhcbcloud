using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VHCBCommon.DataAccessLayer
{
    public class CommonHelper
    {
        private static string _sortDirection;

        public static void GridViewSetFocus(GridViewRow row, string ControlName)
        {
            bool found = false;
            string control_name_lower = ControlName.ToLower();
            foreach (TableCell cell in row.Cells)
            {
                foreach (Control control in cell.Controls)
                {
                    if (control.ID != null && control.ID.ToLower() == control_name_lower)
                    {
                        found = true;
                        control.Focus();
                        break;
                    }
                }
                if (found)
                    break;
            }
        }

        public static void GridViewSetFocus(GridViewRow row)
        {
            bool found = false;
            foreach (TableCell cell in row.Cells)
            {
                foreach (Control control in cell.Controls)
                {
                    if (control.GetType().ToString() == "System.Web.UI.WebControls.TextBox")
                    {
                        found = true;
                        control.Focus();
                        break;
                    }
                }
                if (found)
                    break;
            }
        }

        protected static void SetSortDirection(string sortDirection)
        {
            if (sortDirection == "")
            {
                _sortDirection = "ASC";
            }
            else
            {
                _sortDirection = sortDirection;
            }
        }

        public static string GridSorting(GridView gv, DataTable dt, string SortExpression, string SortDireaction)
        {
            SetSortDirection(SortDireaction);
            if (dt != null)
            {
                //Sort the data.
                if (SortExpression != "")
                    dt.DefaultView.Sort = SortExpression + " " + _sortDirection;
                gv.DataSource = dt;
                gv.DataBind();
                return _sortDirection;
            }
            return null;
        }
    }
}
