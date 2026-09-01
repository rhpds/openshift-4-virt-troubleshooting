# Module 3 — Live Migration Failures

### Brief Overview

Live migration (node-to-node within the same cluster) fails during node maintenance
because an infrastructure prerequisite isn't met. The student learns to read
VirtualMachineInstanceMigration events and VMI conditions, validate that storage is
shared (ReadWriteMany), confirm a migration network exists, and recognize when CPU model
or host-device dependencies (SR-IOV, GPU) block migration. This is a Day 2 operational
scenario — not multi-cluster or platform migration.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators, intermediate level
- **Prerequisites:** Modules 1–2 diagnostic workflow; understanding of PVC access modes
- **Estimated duration:** 25 min

### Learning Objectives

- Analyze migration events and VMI migration state to see why a migration aborts
- Validate shared storage (ReadWriteMany vs ReadWriteOnce) for migratable VMs
- Configure/confirm a dedicated migration network where required
- Understand migration prerequisites: compatible CPU model, no un-migratable host devices

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Trigger the migration and observe failure | 5 min |
| 2 | Read migration events and VMI conditions | 8 min |
| 3 | Classify the blocking prerequisite | 7 min |
| 4 | Apply the fix and re-run migration | 5 min |

### Detailed Steps

1. Attempt a live migration: `virtctl migrate <vm> -n <ns>` (or drain the node).
2. Watch the migration object:
   `oc get vmim -n <ns>` and `oc describe vmim <name> -n <ns>`.
3. Inspect VMI migration state and conditions: `oc describe vmi <name> -n <ns>` — look at
   `status.migrationState` and `LiveMigratable` condition.
4. Classify the fault:
   - **ReadWriteOnce storage:** VM disk PVC is RWO, so it cannot attach on the target node.
   - **Missing migration network:** no dedicated network configured for migration traffic.
   - **CPU incompatibility:** VM CPU model not supported/compatible on the target node.
   - **Host-device dependency:** SR-IOV/GPU/host device bound to the source node.
5. Apply the fix — move the disk to an RWX StorageClass (or use shared storage), configure
   the migration network, set a compatible CPU model, or remove/relocate the host-device
   dependency.
6. Re-run the migration and confirm success: `oc get vmim -n <ns>` shows the migration
   `Succeeded` and the VMI now runs on the target node.

### Key Takeaways

- Live migration has hard prerequisites — RWX storage and CPU compatibility are the big two.
- The `LiveMigratable` VMI condition tells you up front whether a VM can migrate at all.
- Host devices (SR-IOV/GPU) pin a VM to a node and block live migration.

### Infrastructure Notes

- Canonical fault likely the RWO/shared-storage variant unless a dedicated migration
  network is available in the CNV sandbox (see design Open Question #3).
- Uses `ocp4_workload_kubevirt` and ODF-backed storage from the base CI.
- **Fixed signal:** migration object `Succeeded`; VMI running on a different node than before.
