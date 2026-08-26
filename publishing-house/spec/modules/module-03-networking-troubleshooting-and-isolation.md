# Module Outline (spec/modules/module-03-networking-troubleshooting-and-isolation.md)

### Brief Overview

Building on the healthy workload restored in Module 2, this module introduces a pre-existing connectivity issue between VMs and services that requires network isolation to resolve correctly. The student uses UserDefinedNetworks (UDN) — one of the key OpenShift 5 networking improvements over OpenShift 4 — to enforce isolation and correct the connectivity behavior between workloads.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators (intermediate level)
- **Prerequisites for this module:** Completion of Modules 1–2; basic `oc` CLI familiarity; no prior UDN experience required.
- **Estimated duration:** 20 minutes

### Learning Objectives

- Implement network isolation using UserDefinedNetworks (UDN) (maps to design objective 3)
- Diagnose an unwanted connectivity path between VMs and/or services
- Configure a UserDefinedNetwork to enforce isolation between workloads
- Verify that isolation is correctly enforced without breaking required connectivity

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1       | Identifying the pre-existing connectivity issue | 5 min |
| 2       | Reviewing current network configuration | 5 min |
| 3       | Configuring a UserDefinedNetwork for isolation | 7 min |
| 4       | Verifying isolation and required connectivity | 3 min |

### Detailed Steps

1. Review the environment description of the pre-existing connectivity issue between VMs and services in the student's namespace.
2. Test connectivity between the affected VMs/services to confirm and characterize the unwanted access path.
3. Inspect the current network configuration (default pod network, existing NetworkPolicies, or namespace-level settings) to understand why the workloads are not isolated.
4. Define a UserDefinedNetwork (UDN) resource scoped to the affected namespace/workloads.
5. Apply the UDN configuration and attach the relevant VM(s) to the new user-defined network.
6. Re-test connectivity to confirm the previously unwanted access path is now blocked.
7. Confirm that legitimate/required connectivity for the workload continues to function after isolation is applied.

### Key Takeaways

- UserDefinedNetworks (UDN) provide finer-grained network isolation for VM workloads than the default pod network model.
- Diagnosing a connectivity issue requires distinguishing between "no connectivity" and "unwanted connectivity" failure modes.
- Isolation changes should always be verified against both the traffic you want to block and the traffic you need to preserve.

### Infrastructure Notes

- Requires a pre-existing connectivity issue between VMs and services provisioned in the student's namespace, resolvable via UDN-based isolation.
- Design doc flags an open question: whether UDN is GA in OCP 5 at release time. If UDN is tech-preview only, this module needs a fallback approach — confirm before finalizing detailed steps.
- Multi-user namespacing/RBAC needed so each student's connectivity scenario is isolated from other students.
