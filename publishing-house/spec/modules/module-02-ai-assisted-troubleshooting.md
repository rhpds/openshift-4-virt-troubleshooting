# Module Outline (spec/modules/module-02-ai-assisted-troubleshooting.md)

### Brief Overview

This module places the student in front of a running VM workload that has been seeded with a connectivity/infrastructure fault. Using OpenShift Lightspeed for AI-assisted diagnostics, the student investigates the failure, validates the AI's findings against real cluster data, and implements the appropriate fix. The exact fault type is not yet finalized (see design doc Open Questions — candidates include a misconfigured NetworkPolicy, wrong StorageClass, or resource limits causing OOM), so steps here are written generically and should be parameterized once the fault type is confirmed.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators (intermediate level)
- **Prerequisites for this module:** Completion of Module 1 (cluster context established); basic `oc` CLI familiarity; no prior OpenShift Virtualization troubleshooting experience required.
- **Estimated duration:** 30 minutes

### Learning Objectives

- Troubleshoot workload failures using AI-assisted diagnostics (OpenShift Lightspeed) (maps to design objective 2)
- Recognize the symptoms of a broken VM workload from cluster state and console output
- Use an AI assistant to generate a diagnostic hypothesis and a recommended remediation
- Validate an AI-generated diagnosis against real cluster data before applying a fix
- Implement the fix and confirm the VM workload returns to a healthy state

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1       | Observing the broken VM workload | 5 min |
| 2       | Gathering diagnostic data from the cluster | 5 min |
| 3       | Using OpenShift Lightspeed for AI-assisted diagnosis | 10 min |
| 4       | Validating the diagnosis and applying the fix | 10 min |

### Detailed Steps

1. Navigate to the pre-seeded VM workload in the student's namespace and observe its current (broken) state via the console and/or `virtctl`/`oc` output.
2. Identify the visible symptom of the fault (e.g., VM unreachable, workload failing to start, service not responding) — the specific symptom depends on the fault type selected for this environment (TBD).
3. Gather relevant diagnostic data: VM/pod status, events, logs, and (depending on fault type) NetworkPolicy, StorageClass, or resource limit configuration.
4. Open OpenShift Lightspeed and describe the observed symptom, or supply the gathered diagnostic data, to request an AI-assisted diagnosis.
5. Review the AI assistant's proposed root cause and recommended remediation steps.
6. Cross-check the AI's diagnosis against the actual cluster configuration and data gathered in step 3 to confirm it is consistent with the evidence.
7. Apply the recommended fix using the appropriate `oc` command or console action for the confirmed fault type.
8. Re-check the VM workload to confirm the connectivity/infrastructure issue is resolved and the workload is healthy.

### Key Takeaways

- AI-assisted diagnostics can accelerate root-cause identification but should be validated against real cluster data, not accepted blindly.
- Common OpenShift Virtualization fault classes include networking misconfiguration, storage class mismatches, and resource-limit-induced failures.
- A structured gather-diagnose-validate-fix workflow applies whether or not AI assistance is used.

### Infrastructure Notes

- Requires a broken VM workload pre-provisioned for AI-assisted troubleshooting; exact fault type is TBD (see design doc Open Questions: candidates are misconfigured NetworkPolicy, wrong StorageClass, or resource limits causing OOM). Steps and diagnostic data above should be finalized once the fault type is confirmed.
- Requires OpenShift Lightspeed available for AI-assisted troubleshooting.
- Multi-user namespacing/RBAC needed so each student's fault instance is isolated from other students.
