# Module 4 — Network Troubleshooting

### Brief Overview

A VM is running but cannot communicate with external systems or cluster resources. The
student learns to inspect VM interfaces, validate the Multus NetworkAttachmentDefinition
(NAD) and its backing NMState bridge, and check for restrictive NetworkPolicies — tracing
the packet path from guest interface to bridge to physical network to isolate where
connectivity breaks.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators, intermediate level
- **Prerequisites:** Modules 1–3 diagnostic workflow; basic networking (interfaces, L2/L3)
- **Estimated duration:** 25 min

### Learning Objectives

- Inspect VM interfaces and the networks attached to a running VMI
- Validate Multus NetworkAttachmentDefinitions and their configuration
- Diagnose NMState bridge issues (bridge missing, wrong NIC, wrong VLAN)
- Diagnose network isolation caused by restrictive NetworkPolicies

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Confirm the connectivity failure from the VM | 5 min |
| 2 | Inspect VMI interfaces and the NAD | 8 min |
| 3 | Validate NMState bridge / NetworkPolicy | 7 min |
| 4 | Apply the fix and verify reachability | 5 min |

### Detailed Steps

1. From inside the VM (`virtctl console <vm>`), confirm the failure — e.g. `ping`/`curl` to
   a target service or gateway fails.
2. Inspect VMI interfaces and attached networks: `oc describe vmi <name> -n <ns>` (see
   `spec.networks` / `status.interfaces`).
3. Inspect the NAD: `oc get net-attach-def -n <ns>` and `oc describe net-attach-def <name> -n <ns>`.
4. Validate the node network config: `oc get nncp,nnce` and describe the relevant bridge
   (e.g. `br-flat`) — confirm the bridge exists and is attached to the correct NIC.
5. Check for NetworkPolicies that could block traffic: `oc get networkpolicy -n <ns>` and
   `oc describe networkpolicy <name> -n <ns>`.
6. Classify the fault:
   - **Incorrect network binding:** VM attached to the wrong network / binding type.
   - **Broken NAD:** NAD references a missing/misconfigured bridge or CNI plugin.
   - **NMState bridge issue:** bridge not created, wrong NIC, or wrong VLAN.
   - **Restrictive NetworkPolicy:** policy denies the required ingress/egress.
7. Apply the fix — correct the VM network binding, repair the NAD, fix the NMState bridge,
   or adjust the NetworkPolicy — then re-test connectivity from the VM.

### Key Takeaways

- VM networking is a chain: guest interface → NAD → NMState bridge → physical NIC.
- Multus NADs and NMState bridges are the usual culprits for L2 connectivity loss.
- NetworkPolicies silently drop traffic — always check them when a VM "can't reach" a target.

### Infrastructure Notes

- Uses `ocp4_workload_nmstate` and `ocp4_workload_virt_network_config` (linux-bridge
  `br-flat`) from the base CI.
- **Fixed signal:** the VM successfully reaches the previously-unreachable target
  (ping/curl succeeds).
