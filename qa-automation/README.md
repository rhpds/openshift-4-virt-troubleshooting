# QA automation

Two playbooks, served by the runtime-automation sidecar in the Showroom pod:

```bash
SHOWROOM=https://showroom-<user>-showroom.apps.<cluster>.dyn.redhatworkshops.io
curl -sk -N "$SHOWROOM/stream/qa/healthcheck"
curl -sk -N "$SHOWROOM/stream/qa/e2e"
```

## healthcheck.yml

**Can a learner start?** Read-only, under 60 seconds, exit 0 = healthy.

Checks the shared cluster services the lab needs — operators, OpenShift
Virtualization, the `br0` bridge policy, the fedora boot image, the
bootstrap-infra Application, Quay — and the tenant's own workload: its five
namespaces, its seven lab VMs, the network attachment definitions, the migration
quota, the anchor pod, and a working lab guide.

It checks that the environment is present and running, not *how* each VM is
broken. Asserting the faults would turn the check red as soon as a learner
started working; that belongs in e2e.

Checks this tenant only. Use `-e hc_all_tenants=true` for every tenant.

Requires on the AgnosticV tenant item:

```yaml
ocp4_workload_showroom_runtime_automation_cluster_admin: true
ocp4_workload_showroom_runtime_automation_cluster_role: cluster-reader
```

## e2e.yml

**Can a learner finish?** Not implemented yet — see
`docs/superpowers/specs/2026-11-13-e2e-design.md`.
