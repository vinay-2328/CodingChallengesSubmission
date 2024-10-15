
//custom exception

namespace InsuranceManagementSystem.Exception
{
    public class PolicyNotFoundException : System.Exception
    {
        public PolicyNotFoundException(string message) : base(message) { }
    }
}
