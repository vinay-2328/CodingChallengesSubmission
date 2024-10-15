using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagementSystem.Util
{
    internal static class PropertyUtil
    {
        internal static string getPropertyString()
        {
            return ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
        }
    }
}
