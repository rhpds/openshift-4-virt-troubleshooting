# Module Outline (spec/modules/module-04-resource-observability-and-troubleshooting.md)

### Brief Overview

This module shifts focus to ongoing operational efficiency: the student is presented with an over-provisioned VM and uses OpenShift's built-in observability tooling to identify the mismatch between allocated and actual resource usage, then right-sizes the VM accordingly. This reinforces one of the key improvements from OpenShift 4 to 5 in observability and resource optimization for virtualized workloads.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators (intermediate level)
- **Prerequisites for this module:** Completion of Modules 1–3; basic `oc` CLI familiarity; no prior OpenShift observability experience required.
- **Estimated duration:** 20 minutes

### Learning Objectives

- Scale VM resources appropriately using built-in observability (maps to design objective 4)
- Use OpenShift's built-in observability/monitoring views to identify actual VM resource utilization
- Compare allocated vCPU/memory against observed usage to detect over-provisioning
- Right-size a VM's resource requests/limits based on observed data
- Confirm the right-sized VM continues to operate correctly after the change

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1       | Locating the over-provisioned VM | 3 min |
| 2       | Reviewing resource utilization via built-in observability | 7 min |
| 3       | Right-sizing the VM | 7 min |
| 4       | Confirming healthy operation post-resize | 3 min |

### Detailed Steps

1. Navigate to the pre-seeded over-provisioned VM in the student's namespace.
2. Review its currently configured vCPU and memory allocation.
3. Open the built-in observability/monitoring dashboards for the VM and review actual CPU and memory utilization over the available time window.
4. Compare allocated resources against observed usage to quantify the degree of over-provisioning.
5. Determine a right-sized vCPU/memory allocation based on the observed utilization data.
6. Edit the VM's resource requests/limits (via console or `oc`/`virtctl`) to apply the new sizing.
7. Restart or live-migrate the VM as required for the resource change to take effect.
8. Re-check the observability dashboard to confirm the VM continues to operate correctly and utilization is now better aligned with allocation.

### Key Takeaways

- Built-in OpenShift observability provides the data needed to detect over-provisioned VM workloads without external tooling.
- Right-sizing decisions should be driven by observed utilization trends, not initial guesses.
- Resource changes to running VMs may require a restart or live migration, and should always be followed by a post-change health check.

### Infrastructure Notes

- Requires an over-provisioned VM pre-provisioned in the student's namespace with a visible gap between allocated and actual resource usage.
- Requires built-in OpenShift observability/monitoring stack enabled and populated with utilization data for the seeded VM.
- Multi-user namespacing/RBAC needed so each student's VM and metrics are isolated from other students.
