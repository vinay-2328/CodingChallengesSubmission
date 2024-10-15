using InsuranceManagementSystem.BusinessLayer.Services;
using InsuranceManagementSystem.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagementSystemApp.Main
{
    internal class Program
    {
        private static readonly IPolicyService policyService = new PolicyServiceImpl();
        static void Main(string[] args)
        {
            
            Console.Title="Financial Management System";

            while(true)
            {
                Console.Clear();

                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine("========================================================");
                Console.WriteLine("         Welcome to Insurance Management System         ");
                Console.WriteLine("========================================================\n");
                Console.WriteLine("1. Create Policy");
                Console.WriteLine("2. View Policy");
                Console.WriteLine("3. View All Policies");
                Console.WriteLine("4. Delete Policy");
                Console.WriteLine("5. Exit");
                Console.WriteLine("\n--------------------------------------------------------");
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Write("Select your choice: ");

                int choice = Convert.ToInt32(Console.ReadLine());
                Console.ForegroundColor = ConsoleColor.White;

                switch (choice)
                {
                    case 1:
                        CreatePolicy();
                        break;
                    case 2:
                        ViewPolicy();
                        break;
                    case 3:
                        ViewAllPolicy();
                        break;
                    case 4:
                        DeletePolicy();
                        break;
                    case 5:
                        Console.ForegroundColor= ConsoleColor.Green;
                        Console.Beep();
                        Console.WriteLine("\nPress Enter to Exit System...");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.ReadKey();
                        return;
                    default:
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.WriteLine("\nInvalid Choice select from between 1-5...");
                        Console.ForegroundColor = ConsoleColor.White;
                        break;
                }
            }
        }

        internal static void CreatePolicy()
        {
            Policy policy = new Policy();
            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("========================================");
            Console.WriteLine("         Add New Policy Details         ");
            Console.WriteLine("========================================\n");
            Console.ForegroundColor = ConsoleColor.Cyan;

            Console.Write("Policy Name: ");
            policy.PolicyName = Console.ReadLine();

            Console.Write("Policy Premium: ");
            policy.Premium = Convert.ToDecimal(Console.ReadLine());

            if (policyService.CreatePolicy(policy))
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("\nNew Policy Created Successfully!");
                Console.ForegroundColor = ConsoleColor.White;

                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("\nFailed to Create new Policy!");
                Console.ForegroundColor = ConsoleColor.White;

                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;
            }

        }

        internal static void ViewPolicy()
        {
            Policy policy = new Policy();

            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("=================================================");
            Console.WriteLine("         View Policy Details By Policy Id        ");
            Console.WriteLine("=================================================\n");
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Write("Enter the Policy ID: ");
            int policyId = Convert.ToInt32(Console.ReadLine());

            policy = policyService.GetPolicy(policyId);
            if(policy != null)
            {
                Console.WriteLine($"\nPolicy ID: {policy.PolicyId}\nPolicy Name: {policy.PolicyName}\nPolicy Premium: {policy.Premium}");

                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;
            }
            else
            {
                Console.ForegroundColor= ConsoleColor.Red;
                Console.WriteLine("\nFailed to find the Policy!");
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;
            }
        }

        internal static void ViewAllPolicy()
        {
            List<Policy> policyList = new List<Policy>();

            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("==================================================");
            Console.WriteLine("               List Of All Policies               ");
            Console.WriteLine("==================================================\n");
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine("\n-------------------------------------------------------------");
            Console.WriteLine("Policy ID\t\tPolicy Name\t\tPolicy Premium");
            Console.WriteLine("-------------------------------------------------------------");


            policyList = policyService.GetAllPolicies();

            if(policyList != null)
            {
                foreach( Policy policy in policyList )
                {
                    Console.WriteLine($"{policy.PolicyId,-10}\t{policy.PolicyName,-25}\t{policy.Premium,10:C}");
                }
                Console.WriteLine("-------------------------------------------------------------");


                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("\nFailed to find the Policy!");
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("Press Enter to go back...");
                Console.ReadKey();
                return;
            }
        }

        internal static void DeletePolicy()
        {
            List<Policy> policyList = new List<Policy>();

            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("==================================================");
            Console.WriteLine("               List Of All Policies               ");
            Console.WriteLine("==================================================\n");
            Console.ForegroundColor = ConsoleColor.Cyan;

            Console.WriteLine("\n-------------------------------------------------------------");
            Console.WriteLine("Policy ID\t\tPolicy Name\t\tPolicy Premium");
            Console.WriteLine("-------------------------------------------------------------");

            policyList = policyService.GetAllPolicies();

            if (policyList != null)
            {
                foreach (Policy policy in policyList)
                {
                    Console.WriteLine($"{policy.PolicyId,-10}\t{policy.PolicyName,-25}\t{policy.Premium,10}");
                }
                Console.WriteLine("-------------------------------------------------------------");
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("There are no policies to delete");
            }

            Console.ForegroundColor = ConsoleColor.White;
            Console.Write("\nEnter the Policy Id which you want to Delete: ");
            int policyid = Convert.ToInt32(Console.ReadLine()); 

            if(policyService.DeletePolicy(policyid))
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"\nPolicy with id {policyid} deleted Successfully");
                Console.ForegroundColor = ConsoleColor.White;

                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;
            }
            else
            {
                Console.ForegroundColor= ConsoleColor.Red;
                Console.WriteLine($"Failed to delete policy with policy ID {policyid}");
                Console.ForegroundColor = ConsoleColor.White;

                Console.WriteLine("\nPress Enter to go back...");
                Console.ReadKey();
                return;

            }
        }
    }
}
