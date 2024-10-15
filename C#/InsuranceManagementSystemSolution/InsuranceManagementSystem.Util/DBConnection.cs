using System;
using System.Data.SqlClient;

namespace InsuranceManagementSystem.Util
{
    public static class DBConnection
    {
        public static SqlConnection GetConnection()
        {
            string connectionString = PropertyUtil.getPropertyString();
            SqlConnection conn = null;

            try
            {
                conn = new SqlConnection(connectionString);
                conn.Open();
                return conn;
            }
            catch (SqlException sqlEx)
            {
                // Log or handle SQL specific exceptions
                Console.WriteLine($"SQL Error: {sqlEx.Message}");
                throw; // Rethrow the exception 
            }
            catch (Exception ex)
            {
                // Log or handle general exceptions
                Console.WriteLine($"Error: {ex.Message}");
                throw; // Rethrow the exception 
            }
            
        }
    }
}
