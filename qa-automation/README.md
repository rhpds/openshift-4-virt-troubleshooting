# QA automation

Two playbooks, served by the runtime-automation sidecar in the Showroom pod:

```bash
SHOWROOM=https://showroom-<user>-showroom.apps.<cluster>.dyn.redhatworkshops.io
curl -sk -N "$SHOWROOM/stream/qa/healthcheck"
curl -sk -N "$SHOWROOM/stream/qa/e2e"
```

## healthcheck.yml

Answers one question: **can a learner start?** It checks that the services this
lab provisions are up and that the tenant workload is in place. Exit 0 = healthy.
Read-only, and completes in under 60 seconds.

Cluster scope, from the cluster catalog item:

- operators (ClusterServiceVersions) all Succeeded
- HyperConverged Available
- `br0-policy` NodeNetworkConfigurationPolicy Available
- the `fedora` DataSource Ready
- the `bootstrap-infra` ArgoCD Application Synced and Healthy
- QuayRegistry Available
- the `worker` MachineConfigPool Updated and not Degraded

Tenant scope, from the tenant catalog item:

- the five `<user>-troubleshoot-0N` namespaces Active
- all seven lab VMs present, found by the
  `app.kubernetes.io/part-of=virt-troubleshooting` label that `bootstrap_tenant`
  applies, with `vm5` and `vm6` Running and the other five not
- both NetworkAttachmentDefinitions, the `migration-quota` ResourceQuota and
  `anchor-pod` present
- the Showroom pod Running with all containers ready

### What it deliberately does not check

It does not assert *how* each VM is broken — the image vm1 pulls, the bridge name
in the NAD, the quota value, vm4's interface type, vm7's affinity rule. Those are
configuration, not service health, and a learner working through the lab would
turn them red. They belong in `e2e.yml`.

It also does not assert the specific failure reason behind a stopped VM. Those
vary with timing on a perfectly healthy environment: `vm4` was observed as both
`Starting` and `CrashLoopBackOff` an hour apart.

### Variables

| Variable | Default | Effect |
|---|---|---|
| `hc_all_tenants` | `false` | Check every tenant on the cluster instead of just this one. Each extra tenant adds no API calls, only local filtering. |

The tenant is identified from `/user_data/user_data.yml` (`user`), falling back to
the Showroom pod's own namespace with the `-showroom` suffix stripped.

### Required AgnosticV configuration

The runner ServiceAccount needs cluster-scoped reads. On the tenant item
(`rh1-2027/lb1898-ocp-virt-troubleshooting-tenant/common.yaml`):

```yaml
ocp4_workload_showroom_runtime_automation_cluster_admin: true
ocp4_workload_showroom_runtime_automation_cluster_role: cluster-reader
```

`ocp4_workload_showroom_runtime_automation_enable` is already inherited from
`rh1-2027/account.yaml` and must not be set again here.

`cluster-reader` rather than the default `cluster-admin`: the Terminal tab runs as
the showroom ServiceAccount, which can read the runtime-automation kubeconfig
Secret in its own namespace. On this shared cluster that would hand every learner
full control. `cluster-reader` covers every read above, with no Secrets and no
writes.

## e2e.yml

Answers the other question: **can a learner finish?** Not yet implemented — see
`docs/superpowers/specs/2026-11-13-e2e-design.md`. Unlike the health check it is
coupled to each module's fault and fix, and it is a pre-event gate.
