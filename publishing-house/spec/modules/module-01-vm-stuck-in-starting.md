# Module 1 — VM Stuck in Starting

### Brief Overview

A virtual machine never progresses beyond the `Starting` phase because the virt-launcher
pod cannot be scheduled or initialized. This module teaches the student to walk the VM →
VMI → virt-launcher pod chain, read Kubernetes Events and pod logs, and pin down why the
launcher can't come up. It is the foundational troubleshooting lab: the diagnostic
workflow established here (VM status → VMI conditions → pod events → logs) recurs in every
later lab.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators, intermediate level
- **Prerequisites:** `oc` CLI basics, ability to read pod events and logs
- **Estimated duration:** 25 min

### Learning Objectives

- Inspect the VM and VMI lifecycle and interpret the `Starting`/`Scheduling` phases
- Analyze Kubernetes Events and virt-launcher pod logs to locate the blocking condition
- Debug scheduling failures (CPU, memory, hugepages, node selectors/taints)
- Validate storage (PVC/DataVolume) and cloud-init configuration referenced by the VM

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Observe the stuck VM (VM/VMI status) | 5 min |
| 2 | Walk the chain to the virt-launcher pod | 7 min |
| 3 | Read Events and logs to isolate root cause | 8 min |
| 4 | Apply the fix and confirm the VM runs | 5 min |

### Detailed Steps

1. List VMs and note the VM stuck in `Starting`: `oc get vm,vmi -n <ns>`.
2. Describe the VMI and read its conditions: `oc describe vmi <name> -n <ns>`.
3. Find the launcher pod: `oc get pods -n <ns> -l kubevirt.io=virt-launcher` and describe
   it to see scheduling/init errors: `oc describe pod virt-launcher-<name> -n <ns>`.
4. Read Events on the namespace and object: `oc get events -n <ns> --sort-by=.lastTimestamp`.
5. Classify the fault from the evidence — one of:
   - **Missing PVC/DataVolume:** the referenced volume does not exist or is unbound.
   - **Resource shortage:** insufficient CPU/memory/hugepages → pod `Pending`/`Unschedulable`.
   - **ContainerDisk pull failure:** `ImagePullBackOff` on the launcher/container disk.
   - **Invalid cloud-init:** launcher starts but VM init fails on malformed userData.
6. Apply the corresponding fix (create/repair the DataVolume, adjust resource requests,
   correct the ContainerDisk image reference, or fix the cloud-init secret).
7. Confirm recovery: `oc get vmi <name> -n <ns>` shows `Running`; optionally
   `virtctl console <name>` to confirm the guest booted.

### Key Takeaways

- OpenShift Virtualization failures are diagnosed by walking VM → VMI → virt-launcher pod.
- Kubernetes Events and pod status usually name the blocker before you reach logs.
- Storage and cloud-init are the most common "VM won't start" root causes.

### Infrastructure Notes

- Seed exactly one canonical fault per student (see design Open Question #1); variants can
  rotate for reruns.
- The fault should be reproducible on the roadshow VM workloads (`ocp4_workload_virt_roadshow_vms`).
- **Fixed signal:** VMI reaches `Running` and the guest is reachable via console.
