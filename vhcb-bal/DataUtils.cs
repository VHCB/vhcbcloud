using System;

namespace VHCBCommon.DataAccessLayer
{
    public static class DataUtils
    {
        public static bool GetBool(string input)
        {
            bool result = false;

            if (string.IsNullOrWhiteSpace(input) == false)
            {
                input = input.Trim().ToLower();

                if (input.Equals("1") ||
                    input.Equals("true") ||
                    input.Equals("y") ||
                    input.Equals("yes"))
                {
                    result = true;
                }
            }

            return result;
        }

        public static int GetInt(string input)
        {
            int result = 0;

            if (string.IsNullOrWhiteSpace(input) == false)
            {
                if (int.TryParse(input, out result) == false)
                {
                    result = 0;
                }
            }

            return result;
        }

        public static decimal GetDecimal(string input)
        {
            decimal result = 0;

            if (string.IsNullOrWhiteSpace(input) == false)
            {
                if (decimal.TryParse(input, out result) == false)
                {
                    result = 0;
                }
            }

            return result;
        }

        public static bool IsDateTime(string txtDate)
        {
            DateTime tempDate;

            return DateTime.TryParse(txtDate, out tempDate) ? true : false;
        }

        public static DateTime GetDate(string input)
        {
            DateTime tempDate = DateTime.MinValue;

            if (string.IsNullOrWhiteSpace(input) == false)
            {
                if (DateTime.TryParse(input, out tempDate) == false)
                {
                    tempDate = DateTime.MinValue;
                }
            }

            return tempDate;
        }
    }
}
