# OpenShift Virtualization Troubleshooting Workshop: Diagnosing Real Production Failures

<!-- This file is the design document for your lab or demo. -->
<!-- Sections marked with [brackets] are placeholders — replace with real content. -->
<!-- The validation gate checks for all required sections before submission. -->

## Overview

Deploying virtual machines on OpenShift is simply the Day 1 foundation; the true test
of operational maturity begins on Day 2. Once workloads hit production, administrators
face mission-critical challenges that define platform stability: stalling image imports
(CDI), persistent storage bottlenecks, live-migration failures, network connectivity
isolation, and guest agent synchronization gaps. This lab shifts the focus from simple
deployment to resilient maintenance, equipping attendees with the diagnostic expertise
needed to troubleshoot and resolve these complex Day 2 lifecycle issues.

In this 120-minute hands-on lab, participants troubleshoot intentionally broken
OpenShift Virtualization environments that mirror real production incidents. Rather than
following predefined commands, attendees learn a structured diagnostic workflow using
`oc`, `virtctl`, Kubernetes events, VirtualMachineInstance (VMI) objects, CDI resources,
Multus networking, and virt-launcher logs. By the end of the session, attendees have a
practical troubleshooting methodology they can apply in production to rapidly identify
and resolve common OpenShift Virtualization operational issues.

## Target Audience

- **Role:** Platform engineers / OpenShift administrators / virtualization operators
- **Experience level:** Intermediate
- **What they already know:** Core Kubernetes/OpenShift concepts (pods, namespaces,
  `oc` CLI), general familiarity with virtualization and VM lifecycle concepts
- **What they don't know:** OpenShift Virtualization Day 2 troubleshooting internals —
  VMI/virt-launcher lifecycle, CDI/DataVolume import mechanics, live-migration
  prerequisites, Multus/NMState VM networking, and QEMU Guest Agent integration

## Prerequisites

- Familiarity with basic OpenShift/Kubernetes concepts (pods, namespaces, `oc` CLI)
- Comfort reading logs and Kubernetes events
- No prior OpenShift Virtualization troubleshooting experience required
- Can the lab validate these automatically? No — trust-based, consistent with the
  intermediate audience level

## Learning Objectives

1. Follow a structured troubleshooting workflow for OpenShift Virtualization using
   `oc` and `virtctl`
2. Diagnose VM startup and provisioning failures by inspecting VM/VMI lifecycle, Events,
   and virt-launcher logs
3. Troubleshoot CDI image imports and DataVolumes, including WaitForFirstConsumer
   deadlocks and registry access failures
4. Investigate live migration failures caused by storage, networking, CPU, and
   host-device constraints
5. Debug VM networking using Multus NetworkAttachmentDefinitions, NMState, and
   NetworkPolicies
6. Validate QEMU Guest Agent communication and restore Day 2 operational features

<!-- Scaled to a 120-minute lab: 6 objectives across 5 labs, each lab is a self-contained diagnostic scenario. -->

## Content Type

Lab (hands-on)

## Products & Technologies

- Red Hat OpenShift Container Platform (4.21)
- Red Hat OpenShift Virtualization (CNV / KubeVirt)
- Containerized Data Importer (CDI) / DataVolumes
- Migration Toolkit for Virtualization (MTV) — live/cross-node migration context
- Multus CNI + NetworkAttachmentDefinitions
- NMState (node network configuration / bridges)
- QEMU Guest Agent
- `oc` and `virtctl` CLIs

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | VM Stuck in Starting | 25 min |
| 2 | CDI Import Failures | 25 min |
| 3 | Live Migration Failures | 25 min |
| 4 | Network Troubleshooting | 25 min |
| 5 | Guest Agent Failures | 20 min |
| — | **Total hands-on** | **120 min** |
| — | Intro / presentation | ~0 min (fully hands-on) |
| — | **Total lab** | **~2 hours** |

<!-- Each lab is an independent, intentionally-broken scenario. Labs do not depend on
     prior state, so students can attempt them in any order (recommended order as listed). -->

## Difficulty Level

Intermediate

## Environment

**Learner view:** Each student is given access to a pre-provisioned OpenShift
Virtualization cluster with a set of intentionally broken VM scenarios seeded into their
own namespace. Each of the five labs presents a distinct failure (VM stuck in Starting,
failed CDI import, blocked live migration, network isolation, dead guest agent) that the
student must diagnose and fix using `oc`, `virtctl`, events, and logs. Students are split
across clusters to support the full class.

**Automation needed:** Yes.

Automation must provision, per student:
- **Lab 1 — VM Stuck in Starting:** a VM that cannot start the launcher pod (seed one or
  more of: missing PVC/DataVolume, resource shortage, bad ContainerDisk reference,
  invalid cloud-init)
- **Lab 2 — CDI Import Failures:** a DataVolume whose import never completes
  (WaitForFirstConsumer deadlock, missing scratch space, registry cert/auth/network
  failure)
- **Lab 3 — Live Migration Failures:** a VM that cannot live-migrate (ReadWriteOnce
  storage, missing migration network, CPU incompatibility, or host-device dependency)
- **Lab 4 — Network Troubleshooting:** a running VM that cannot reach external systems or
  cluster resources (wrong binding, broken NAD, NMState bridge issue, restrictive
  NetworkPolicy)
- **Lab 5 — Guest Agent Failures:** a running VM whose guest agent integration is broken
  (missing/disabled QEMU Guest Agent, missing VirtIO channel, SELinux/firewall
  restriction)
- Multi-user namespacing/RBAC so each student has an isolated workspace

## Infrastructure Requirements

- **Base catalog item (agnosticV):** `openshift_cnv/ocp-virt-roadshow-2026` — reused as
  the infrastructure base and re-purposed for troubleshooting content
- **Cloud provider:** CNV (OcpSandbox pattern — `cloud: cnv, purpose: prod, virt: yes`)
- **Cluster type:** Multinode, deployed via OpenShift Assisted Installer
  (`software_to_deploy: openshift4_assisted`)
- **OCP version:** 4.21 (base CI `ocp4_installer_version: 4.21.10`)
- **Network stack:** OVNKubernetes; VM networks via linux-bridge (`br-flat`) + NMState
- **Topology:** Shared-cluster — up to 20 users per cluster; workers scale with user
  count (`worker_instance_count = max(ceil(num_users/5), 3)`)
- **Sizing (≤10 workers):** Control plane 3 × 16 vCPU / 32Gi RAM; workers ≥3 × 16 vCPU /
  64Gi RAM / 100GB disk. OcpSandbox quota: 128 CPU / 800Gi RAM per sandbox.
- **Automation approach:** GitOps (OpenShift GitOps / ArgoCD) — base CI uses
  `ocp4_workload_openshift_gitops`
- **Key workloads (from base CI):** `ocp4_workload_kubevirt`, `ocp4_workload_mtv`,
  `ocp4_workload_nmstate`, `ocp4_workload_virt_network_config`,
  `ocp4_workload_virt_roadshow_vms`, `ocp4_workload_external_odf`,
  `ocp4_workload_authentication`, `ocp4_workload_cert_manager`,
  `ocp4_workload_web_terminal`, `ocp4_workload_showroom`
- **AI/MaaS:** None — this lab uses no AI/Lightspeed
- **External services:** `registry.redhat.io` / `registry.access.redhat.com` (image and
  ContainerDisk pulls); `mirror.openshift.com` (installer clients)
- **AAP version:** N/A — Ansible Automation Platform is not a product in this lab
- **Non-GA products:** None — OCP 4.21 is GA

## Assessment Strategy (Optional)

Trust-based and outcome-driven. Each lab has a clear broken → fixed state that students
verify themselves by inspecting cluster state (VM/VMI status, Events, pod logs,
connectivity checks). Success is proven by the VM reaching the expected
running / migrated / reachable state after the fix, not by an automated grader. Each lab
outline lists the specific "how you know it's fixed" signal.

## Open Questions

<!-- Resolve during development -->

1. Which specific fault(s) does each lab seed? Some labs list multiple candidate faults
   (e.g. Lab 1 could be a missing PVC *or* a resource shortage) — development must pick
   the canonical fault per lab (and optionally rotate variants for reruns).
2. Does the base `ocp-virt-roadshow-2026` automation need new "break" roles, or can
   existing roadshow VM workloads be perturbed post-deploy? (Affects `automation/` design.)
3. Live migration (Lab 3): is a dedicated migration network available in the CNV
   sandbox, or should the ReadWriteOnce/shared-storage variant be the canonical fault?
4. Guest Agent (Lab 5): confirm the base VM images ship the QEMU Guest Agent so it can be
   deliberately disabled rather than needing installation.
