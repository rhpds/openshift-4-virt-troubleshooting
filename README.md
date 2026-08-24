# openshift-5-virt

This hands-on lab puts attendees into a realistic customer environment running virtual machines and container workloads across OpenShift. They will investigate a connectivity and infrastructure issue, use OpenShift 5 AI-assisted capabilities to help with troubleshooting, validate the findings against real cluster data, and implement the appropriate fix.

The lab will also cover areas that have improved from OpenShift 4, including virtual machine networking, observability, resource optimisation, cluster management and workload mobility. Attendees will then assess a second cluster and perform a controlled workload migration.

The focus is on practical consulting skills rather than a product walkthrough: understand the problem, gather evidence, make the change and prove the outcome.


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
