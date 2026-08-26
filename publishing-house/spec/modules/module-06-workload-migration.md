# Module Outline (spec/modules/module-06-workload-migration.md)

### Brief Overview

This short capstone module has the student perform a guided, interactive (Arcade-style) simulation of a cross-cluster VM migration using the Migration Toolkit for Virtualization (MTV), building directly on the readiness assessment completed in Module 5. It closes out the lab by tying together sizing, troubleshooting, isolation, and observability into an end-to-end workload mobility scenario.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators (intermediate level)
- **Prerequisites for this module:** Completion of Module 5 (migration readiness assessment); basic `oc` CLI familiarity; no prior MTV experience required.
- **Estimated duration:** 5 minutes

### Learning Objectives

- Analyze cluster readiness for workload migration by profiling node capacity, storage compatibility, and network configuration (extends design objective 5 into execution)
- Configure a cross-cluster VM migration plan using MTV
- Execute a guided, interactive simulation of a VM migration from the source to the target cluster
- Confirm successful migration of the VM workload to the target cluster

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1       | Launching the guided MTV migration simulation | 1 min |
| 2       | Configuring the migration plan | 2 min |
| 3       | Executing and observing the migration | 2 min |

### Detailed Steps

1. Launch the guided interactive (Arcade-style) simulation for cross-cluster VM migration using MTV.
2. Follow the simulation's prompts to select the source VM (from the primary cluster) and the target cluster (assessed in Module 5) for the migration plan.
3. Configure the migration plan parameters as prompted by the simulation (e.g., mapping storage and network resources between source and target).
4. Execute the migration plan within the guided simulation and observe the progression checks as the migration proceeds.
5. Confirm the simulation reports the VM workload as successfully migrated to the target cluster.

### Key Takeaways

- MTV enables cross-cluster VM migration as part of OpenShift Virtualization workload mobility.
- A successful migration depends on the readiness groundwork (node capacity, storage compatibility, network configuration) established beforehand.
- Guided interactive simulations can teach migration workflows with built-in progression checks in place of a live, fully provisioned migration.

### Infrastructure Notes

- Requires a guided interactive (Arcade-style) simulation of a cross-cluster VM migration using MTV, pre-built and wired to the student's Module 5 target cluster context.
- Assessment strategy: guided interactive simulation with built-in progression checks (no separate manual validation).
- Multi-user namespacing/RBAC needed so each student's simulation instance is isolated from other students.
