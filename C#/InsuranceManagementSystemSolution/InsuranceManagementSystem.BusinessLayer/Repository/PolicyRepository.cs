using InsuranceManagementSystem.Entity;
using InsuranceManagementSystem.Util;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using InsuranceManagementSystem.Exception;

namespace InsuranceManagementSystem.BusinessLayer.Repository
{
    internal class PolicyRepository : IPolicyRepository
    {
        //Creation of new policy
        public bool CreatePolicy(Policy policy)
        {
            bool result = false;

            try
            {
                using (SqlConnection conn = DBConnection.GetConnection())
                {
                    string query = "insert into Policies (PolicyName, Premium) values (@PolicyName, @Premium); select SCOPE_IDENTITY();";
                    SqlCommand command = new SqlCommand(query, conn);
                    command.Parameters.AddWithValue("@PolicyName", policy.PolicyName);
                    command.Parameters.AddWithValue("@Premium", policy.Premium);

                    var policyId = command.ExecuteScalar(); // New policy ID if needed
                    if (policyId != null)
                    {
                        result = true;
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Error occurred while inserting new Policy: " + ex.Message);
            }

            return result;
        }


        //getting policy by policy id
        public Policy GetPolicy(int policyId)
        {
            Policy policy = null;

            try
            {
                using (SqlConnection conn = DBConnection.GetConnection())
                {
                    string query = "select * from Policies where PolicyId = @PolicyId";
                    SqlCommand command = new SqlCommand(query, conn);
                    command.Parameters.AddWithValue("@PolicyId", policyId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            policy = new Policy() // Initialize the policy object
                            {
                                PolicyId = Convert.ToInt32(reader["PolicyId"]),
                                PolicyName = Convert.ToString(reader["PolicyName"]),
                                Premium = Convert.ToDecimal(reader["Premium"])
                            };
                        }
                    }

                    if (policy == null)
                    {
                        throw new PolicyNotFoundException("Policy Not Found!");
                    }
                }
            }
            catch (PolicyNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Database error: " + ex.Message);
            }

            return policy;
        }


        //getting all the policies
        public List<Policy> GetAllPolicies()
        {
            List<Policy> policies = new List<Policy>(); // Initialize list

            try
            {
                using (SqlConnection conn = DBConnection.GetConnection())
                {
                    string query = "select * from Policies";
                    SqlCommand command = new SqlCommand(query, conn);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Policy policy = new Policy()
                            {
                                PolicyId = Convert.ToInt32(reader["PolicyId"]),
                                PolicyName = Convert.ToString(reader["PolicyName"]),
                                Premium = Convert.ToDecimal(reader["Premium"])
                            };
                            policies.Add(policy);
                        }
                    }

                    if (policies.Count == 0)
                    {
                        throw new PolicyNotFoundException("Policies Not Found!");
                    }
                }
            }
            catch (PolicyNotFoundException ex)
            {
                Console.WriteLine(ex.Message);   
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Database error: " + ex.Message);
            }

            return policies;
        }


        //updating policy
        public bool UpdatePolicy(Policy policy)
        {
            bool result = false;
            try
            {
                using (SqlConnection conn = DBConnection.GetConnection())
                {
                    string query = "update Policies set PolicyName = @PolicyName, Premium = @Premium where PolicyId = @PolicyId;";
                    SqlCommand command = new SqlCommand(query, conn);
                    command.Parameters.AddWithValue("@PolicyName", policy.PolicyName);
                    command.Parameters.AddWithValue("@Premium", policy.Premium);
                    command.Parameters.AddWithValue("@PolicyId", policy.PolicyId);

                    int rowAffected = command.ExecuteNonQuery();

                    if (rowAffected > 0)
                    {
                        result = true; // Successfully updated
                    }
                    else
                    {
                        throw new PolicyNotFoundException($"No records found for policy ID {policy.PolicyId}");
                    }
                }
            }
            catch (PolicyNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Database error: " + ex.Message);
            }

            return result;
        }


        //deleting policy
        public bool DeletePolicy(int policyId)
        {
            bool result = false;

            try
            {
                using (SqlConnection conn = DBConnection.GetConnection())
                {
                    
                    string query = "delete from Policies where PolicyId = @PolicyId";
                    SqlCommand command = new SqlCommand(query, conn);
                    command.Parameters.AddWithValue("@PolicyId", policyId);

                    int rowAffected = command.ExecuteNonQuery();

                    if (rowAffected > 0)
                    {
                        result = true; // Successfully deleted
                    }
                    else
                    {
                        throw new PolicyNotFoundException($"No record found to delete for Policy ID {policyId}");
                    }
                }
            }
            catch (PolicyNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
                
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Database error: " + ex.Message); 
            }

            return result;
        }
    }
}
