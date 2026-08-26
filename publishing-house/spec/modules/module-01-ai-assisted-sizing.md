# Module Outline (spec/modules/module-01-ai-assisted-sizing.md)

### Brief Overview

This module opens the lab by putting the student in the shoes of a platform engineer planning a new OpenShift Virtualization deployment. Starting from a simulated ("fake") VMware estate with a defined set of VMs, vCPUs, memory, and storage, the student uses AI-assisted capacity planning to translate that inventory into a right-sized OpenShift Virtualization cluster sizing recommendation. The module establishes the cluster context (and the seeded workload) that subsequent modules build on.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators (intermediate level)
- **Prerequisites for this module:** Basic OpenShift/Kubernetes concepts (pods, namespaces, `oc` CLI); general familiarity with virtualization concepts. No prior OpenShift Virtualization experience required.
- **Estimated duration:** 30 minutes

### Learning Objectives

- Configure cluster sizing for an OpenShift Virtualization deployment using AI-assisted capacity planning (maps to design objective 1)
- Interpret a simulated VMware estate inventory (VM count, vCPU, memory, storage) as sizing input
- Use OpenShift Lightspeed (or equivalent AI-assisted tooling) to generate and interpret a capacity/sizing recommendation
- Compare AI-generated sizing recommendations against the target cluster's actual capacity

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1       | Environment orientation and accessing the fake VMware estate | 5 min |
| 2       | Reviewing the simulated VM inventory | 5 min |
| 3       | Running AI-assisted capacity planning | 10 min |
| 4       | Reviewing and validating the sizing recommendation | 10 min |

### Detailed Steps

1. Log in to the assigned OpenShift Virtualization cluster and confirm access to the student's isolated namespace/workspace.
2. Locate the simulated ("fake") VMware estate data source provided in the environment (inventory of VMs, vCPU counts, memory allocations, and storage consumption).
3. Review the inventory to identify the total workload footprint that needs to be accommodated on OpenShift Virtualization.
4. Open OpenShift Lightspeed (or the designated AI-assisted sizing tool) and provide it with the estate inventory as input.
5. Ask the AI assistant to recommend a cluster sizing (node count, CPU, memory, storage) sufficient to host the simulated estate.
6. Review the AI-generated recommendation, noting the reasoning provided for node count and resource allocations.
7. Compare the recommended sizing against the capacity of the cluster provisioned for the lab.
8. Note any discrepancies or assumptions the AI assistant made, and record the final sizing decision to close out the module.

### Key Takeaways

- AI-assisted capacity planning can translate a raw VM inventory into actionable cluster sizing guidance.
- Sizing decisions must account for vCPU, memory, and storage simultaneously, not in isolation.
- AI-generated recommendations should be reviewed and validated against actual environment constraints before being trusted.

### Infrastructure Notes

- Requires a simulated ("fake") VMware estate with defined VM/vCPU/memory/storage counts, provisioned per student/namespace.
- Requires OpenShift Lightspeed (or equivalent AI/MaaS-backed assistant) available in the environment for the sizing exercise.
- Multi-user namespacing/RBAC needed so each student works against an isolated inventory and recommendation.
