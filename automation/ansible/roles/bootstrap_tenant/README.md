# bootstrap_tenant

Provisions one tenant's environment for the VM troubleshooting module: a
`<bootstrap_tenant_username>-vm-troubleshoot` namespace, an `edit` RoleBinding for the tenant user, and
three deliberately-broken VMs (`vm-scheduling`, `vm-imagepull`, `vm-cloudinit`) — one per
troubleshooting task. `bootstrap_tenant_state: absent` deletes the namespace (and
everything in it).

Ported from the `automation/gitops/bootstrap-tenant` Helm chart. The ArgoCD-specific
workarounds in that chart (`ignore-healthcheck` annotations, and a Job that patched the
owning Application's `ignoreDifferences` so selfHeal wouldn't revert a student's fix) are
not needed here — this role applies resources once and never reconciles drift.

## Requirements

- `kubernetes.core` collection
- An active cluster session (kubeconfig context) for `kubernetes.core.k8s` to use

## Role Variables

| Variable | Default | Description |
|----------|---------|--------------|
| `bootstrap_tenant_username` | `user1` | Tenant identity; namespace, RoleBinding, and VMs are named from this |
| `bootstrap_tenant_cluster_domain` | `apps.cluster.example.com` | Cluster apps domain; used to build the shared VM registry's external route host |
| `bootstrap_tenant_registry_image_path` | `vm-images/centos-stream9` | Path on the shared registry (provisioned by `bootstrap-infra`) that `vm-imagepull` pulls |
| `bootstrap_tenant_registry_image_tag` | `latest` | Tag on the shared registry that `vm-imagepull` pulls |
| `bootstrap_tenant_vm_scheduling_memory` | `999Gi` | Memory request on `vm-scheduling`, deliberately larger than any node can satisfy; the task's fix is lowering this |
| `bootstrap_tenant_state` | `present` | `present` to provision, `absent` to tear down |

`bootstrap_tenant_registry_image_path`/`bootstrap_tenant_registry_image_tag` must match
`bootstrap-infra`'s registry image defaults — infra and tenant have no shared state between them.

## Dependencies

None.

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - role: openshift_4_virt_troubleshooting.automation.bootstrap_tenant
      vars:
        bootstrap_tenant_username: user42
        bootstrap_tenant_cluster_domain: apps.cluster-abcde.sandbox.opentlc.com
```

## License

GPL-2.0-or-later
