# Module Outline (spec/modules/module-05-migration-readiness-assessment.md)

### Brief Overview

This module introduces a second OpenShift cluster provisioned in a migratable state and asks the student to assess its readiness for workload migration. The student profiles node capacity, storage compatibility, and network configuration, then completes a checklist to produce a go/no-go recommendation. This module sets up the cross-cluster migration performed in Module 6.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators (intermediate level)
- **Prerequisites for this module:** Completion of Modules 1–4; basic `oc` CLI familiarity; no prior MTV or migration experience required.
- **Estimated duration:** 15 minutes

### Learning Objectives

- Analyze cluster readiness for workload migration by profiling node capacity, storage compatibility, and network configuration (maps to design objective 5)
- Gather node capacity data from the target (second) cluster
- Evaluate storage compatibility between the source and target clusters
- Evaluate network configuration compatibility relevant to VM migration
- Produce a go/no-go migration readiness recommendation using a structured checklist

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1       | Accessing the second cluster | 2 min |
| 2       | Profiling node capacity | 4 min |
| 3       | Assessing storage compatibility | 4 min |
| 4       | Assessing network configuration | 3 min |
| 5       | Completing the readiness checklist | 2 min |

### Detailed Steps

1. Log in to the second, pre-provisioned cluster designated as the migration target and confirm access.
2. Gather node capacity data (CPU, memory, available capacity) for the target cluster.
3. Compare the source VM's resource requirements against the target cluster's available node capacity.
4. Review the storage classes available on the target cluster and compare them against the source VM's storage requirements for compatibility.
5. Review the target cluster's network configuration (e.g., available networks, UDN/NetworkPolicy setup) relevant to the VM being migrated.
6. Fill in the provided readiness checklist, recording findings for node capacity, storage compatibility, and network configuration.
7. Use the completed checklist to produce a go/no-go recommendation for proceeding with migration.

### Key Takeaways

- Migration readiness assessment spans at least three dimensions: node capacity, storage compatibility, and network configuration.
- A structured checklist turns a fuzzy readiness question into a defensible go/no-go decision.
- Readiness assessment should happen before attempting a migration, not during or after.

### Infrastructure Notes

- Requires a second cluster provisioned in a migratable state, distinct from the primary cluster used in Modules 1–4.
- Requires a readiness checklist artifact (assessment strategy: student-completed checklist producing a go/no-go recommendation).
- Multi-user namespacing/RBAC needed so each student assesses their own isolated target cluster/workspace.
