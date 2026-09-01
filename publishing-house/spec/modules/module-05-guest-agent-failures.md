# Module 5 — Guest Agent Failures

### Brief Overview

The VM is operational, but platform integrations that depend on the QEMU Guest Agent —
graceful shutdown, in-guest IP reporting, filesystem freeze/thaw, and memory ballooning —
do not work. The student learns to detect the missing/broken guest agent from the VMI
status, then diagnose whether the agent is absent, the service is disabled, the VirtIO
channel is missing, or SELinux/firewall is blocking it — and restore Day 2 management
features.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators, intermediate level
- **Prerequisites:** Modules 1–4 diagnostic workflow; basic guest OS administration
- **Estimated duration:** 20 min

### Learning Objectives

- Validate guest agent connectivity from the VMI (`AgentConnected` condition)
- Diagnose a missing or disabled QEMU Guest Agent inside the guest OS
- Identify a missing VirtIO serial channel needed for host↔guest communication
- Recognize SELinux/firewall restrictions that block the guest agent

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Observe the missing Day 2 features | 4 min |
| 2 | Check the VMI guest-agent status | 5 min |
| 3 | Diagnose inside the guest OS | 6 min |
| 4 | Restore the agent and verify | 5 min |

### Detailed Steps

1. Notice the symptom: `oc get vmi <name> -n <ns> -o wide` shows no guest IP, and graceful
   shutdown/ballooning don't work.
2. Check the guest-agent condition: `oc describe vmi <name> -n <ns>` — look for
   `AgentConnected` being absent/False.
3. Open a console (`virtctl console <vm>`) and inspect inside the guest:
   - Is the package installed? (`qemu-guest-agent`)
   - Is the service running/enabled? (`systemctl status qemu-guest-agent`)
   - Is the VirtIO channel present? (`org.qemu.guest_agent.0`)
   - Is SELinux/firewall blocking it? (audit logs / denials)
4. Classify the fault:
   - **Missing QEMU Guest Agent:** package not installed in the guest.
   - **Disabled guest agent service:** installed but stopped/disabled.
   - **Missing VirtIO channel:** VM spec lacks the guest-agent serial channel.
   - **SELinux/firewall restriction:** agent blocked from communicating.
5. Apply the fix — install/enable/start `qemu-guest-agent`, add the VirtIO channel to the
   VM spec (restart required), or resolve the SELinux/firewall restriction.
6. Verify recovery: `oc get vmi <name> -n <ns>` reports the guest IP and `AgentConnected`
   is True; `virtctl` graceful operations now work.

### Key Takeaways

- The `AgentConnected` VMI condition is the single indicator of guest-agent health.
- Guest agent enables Day 2 features (graceful shutdown, IP reporting, ballooning,
  fs-freeze) — without it, the VM runs but is "blind" to the platform.
- Both a host-side VirtIO channel and an in-guest service are required.

### Infrastructure Notes

- Confirm the base VM images ship `qemu-guest-agent` so it can be deliberately disabled
  rather than needing a fresh install (see design Open Question #4).
- Uses roadshow VM workloads (`ocp4_workload_virt_roadshow_vms`) from the base CI.
- **Fixed signal:** VMI shows guest IP and `AgentConnected: True`.
