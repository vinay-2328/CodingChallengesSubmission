using InsuranceManagementSystem.BusinessLayer.Repository;
using InsuranceManagementSystem.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagementSystem.BusinessLayer.Services
{
    public class PolicyServiceImpl : IPolicyService
    {
        IPolicyRepository repository;

        public PolicyServiceImpl()
        {
            repository = new PolicyRepository();
        }

        public bool CreatePolicy(Policy policy)
        {
            return repository.CreatePolicy(policy);
        }
        public Policy GetPolicy(int policyId)
        {
            return repository.GetPolicy(policyId);
        }
        public List<Policy> GetAllPolicies()
        {
            return repository.GetAllPolicies();
        }
        public bool UpdatePolicy(Policy policy)
        {
            return repository.UpdatePolicy(policy);
        }
        public bool DeletePolicy(int policyId)
        {
            return repository.DeletePolicy(policyId);
        }
    }
}
