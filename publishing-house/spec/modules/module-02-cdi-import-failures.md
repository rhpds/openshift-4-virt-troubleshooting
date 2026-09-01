# Module 2 — CDI Import Failures

### Brief Overview

VM provisioning fails because the DataVolume import process (driven by the Containerized
Data Importer, CDI) never completes. The student learns to inspect DataVolumes, importer
pods, and PVC events to distinguish the common import stalls — a WaitForFirstConsumer
scheduling deadlock, missing scratch space, registry certificate problems, and
authentication/network access failures — and to configure CDI storage correctly.

### Audience and Time

- **Persona:** Platform engineers / OpenShift administrators, intermediate level
- **Prerequisites:** Module 1 diagnostic workflow; basic understanding of PVCs and
  StorageClasses
- **Estimated duration:** 25 min

### Learning Objectives

- Inspect DataVolumes and importer pods and interpret their phases
- Analyze PVC events, including `WaitForFirstConsumer` binding behavior
- Configure CDI storage correctly (StorageClass, volume binding mode, scratch space)
- Debug image imports from private/authenticated registries and TLS-protected endpoints

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Observe the stalled DataVolume | 5 min |
| 2 | Inspect the importer pod and PVC events | 8 min |
| 3 | Classify the import failure | 7 min |
| 4 | Fix CDI/storage config and re-import | 5 min |

### Detailed Steps

1. List DataVolumes and note the one stuck importing:
   `oc get dv,pvc -n <ns>` — DataVolume phase is `ImportInProgress`/`Pending`.
2. Find and describe the importer pod:
   `oc get pods -n <ns> -l cdi.kubevirt.io=importer` then `oc describe pod importer-<dv> -n <ns>`.
3. Read importer logs: `oc logs importer-<dv> -n <ns>`.
4. Read PVC events: `oc describe pvc <dv> -n <ns>` — look for binding state.
5. Classify the fault:
   - **WaitForFirstConsumer deadlock:** PVC stays `Pending` because nothing schedules the
     consumer; import can't proceed until a consumer pod is scheduled.
   - **Missing scratch space:** importer needs a scratch PVC that cannot be provisioned.
   - **Registry certificate problem:** TLS verification failure pulling the source image.
   - **Auth/network failure:** 401/403 or connection errors reaching the source registry.
6. Apply the fix — set an appropriate StorageClass / volume binding mode, provide the
   scratch storage, add the registry CA/`certConfigMap`, or supply the pull credentials.
7. Recreate/retry the DataVolume and confirm it reaches `Succeeded`; the VM that consumes
   it can now start.

### Key Takeaways

- CDI import problems are read from the importer pod and PVC events, not the VM itself.
- `WaitForFirstConsumer` binding is the single most common "import never starts" trap.
- Registry TLS/auth and scratch space are the top external causes of import failure.

### Infrastructure Notes

- Fault can be seeded by pointing a DataVolume at an unreachable/auth-required registry or
  by using a StorageClass with `WaitForFirstConsumer` binding and no consumer.
- Storage backed by `ocp4_workload_external_odf` (ODF) from the base CI.
- **Fixed signal:** DataVolume phase `Succeeded` and its PVC `Bound`.
