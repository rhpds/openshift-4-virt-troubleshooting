# `automation`

Ansible collection for this project's custom automation. Handles per-tenant VM
provisioning for the troubleshooting modules — `automation/gitops/` remains the source
of truth for cluster-wide infra.

This collection is never published to Ansible Galaxy. It's referenced straight from this
project's git repository. See the [Custom Ansible Automation](https://rhpds.github.io/rhdp-publishing-house/user/custom-automation/)
guide for the full walkthrough, including how to wire it into an AgnosticV
`requirements_content`.

## Structure

```
automation/ansible/
├── galaxy.yml
├── README.md
├── meta/
│   └── runtime.yml
└── roles/
    └── bootstrap_tenant/
        ├── README.md
        ├── defaults/
        │   └── main.yml
        ├── meta/
        │   └── main.yml
        ├── tasks/
        │   ├── main.yml
        │   ├── create.yml
        │   └── remove.yml
        └── templates/
            ├── vm-cloudinit.yaml.j2
            ├── vm-imagepull.yaml.j2
            └── vm-scheduling.yaml.j2
```

## Adding a role

```bash
ansible-galaxy role init --init-path roles/ my_role_name
```

Then reference it by its fully qualified name once the collection is installed:

```yaml
- name: Run my_role_name
  ansible.builtin.include_role:
    name: openshift_4_virt_troubleshooting.automation.my_role_name
```

## Testing locally

Install the collection straight from your working tree to confirm it's structured
correctly before pushing:

```bash
ansible-galaxy collection install . --force
```
