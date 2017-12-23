using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace CIT12
{
    public class Connections
    {
        public static SqlConnection ApplicationConnection()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["ApplicationConnection"].ConnectionString;
            SqlConnection myConnection = new SqlConnection(connectionString);
            myConnection.Open();
            return myConnection;
        }
    }
}