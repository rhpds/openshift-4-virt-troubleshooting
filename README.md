# openshift-4-virt-troubleshooting

A 120-minute hands-on Day 2 operations lab where participants troubleshoot intentionally broken OpenShift Virtualization environments that mirror real production incidents. Rather than following predefined commands, attendees learn a structured diagnostic workflow using oc, virtctl, Kubernetes events, VirtualMachineInstance (VMI) objects, CDI resources, Multus networking, and virt-launcher logs. Across five labs, they diagnose and resolve VM startup failures, CDI/DataVolume import failures, live-migration failures, network isolation issues, and guest agent synchronization gaps — finishing with a practical troubleshooting methodology they can apply in production.

**Owner:** waynedovey

---

## What was set up

1. Repository created
2. `catalog-info.yaml` added to repository
3. Registered in Developer Hub catalog
4. Orchestrator workflow started — your AI-guided content pipeline is running!

## What happens next

Claude will walk you through the entire content lifecycle — from intake and spec creation, through Jira tracking and reviews, all the way to a published lab on RHDP. Just follow the prompts!

## Getting started

### DevSpaces (recommended)

1. Open in DevSpaces: `https://devspaces.apps.ocpv-infra02.wdc07.infra.demo.redhat.com#https://github.com/rhpds/openshift-5-virt`
2. Use Claude via the **extension** or the **CLI**:
   - **Extension:** Click the **Claude** icon in the sidebar, click **New Session**. If the Claude icon is not visible, open **Extensions** (`Ctrl/Cmd+Shift+X`), find **Claude Code for VS Code** under the DevSpaces section, click it, then click **Enable (Workspace)**.
   - **CLI:** Open a terminal and run `claude`
3. Run `/rhdp-publishing-house` — and you're off!

### Local machine

1. Install the skills:
   ```
   git clone -b prod https://github.com/rhpds/rhdp-publishing-house-skills.git ~/.claude/skills/publishing-house
   ```
2. Clone the repo:
   ```
   git clone https://github.com/rhpds/openshift-5-virt
   ```
3. `cd openshift-5-virt`
4. Start Claude CLI: `claude`
5. Run `/rhdp-publishing-house` — and you're off!
