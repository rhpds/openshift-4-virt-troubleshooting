# OpenShift 5 Virtualization in Practice: Troubleshooting, Networking & Workload Mobility

<!-- This file is the design document for your lab or demo. -->
<!-- Fill in each section below, or run /rhdp-publishing-house to have the intake skill help. -->
<!-- Sections marked with [brackets] are placeholders — replace with real content. -->
<!-- The validation gate checks for all required sections before submission. -->

## Overview

This hands-on lab puts attendees into a realistic customer environment running virtual machines and container workloads across OpenShift. Participants will investigate a connectivity and infrastructure issue, use OpenShift 5 AI-assisted capabilities (OpenShift Lightspeed) to help troubleshoot, validate findings against real cluster data, and implement the appropriate fix. The lab also covers areas improved from OpenShift 4, including virtual machine networking, observability, resource optimization, cluster management, and workload mobility.

Participants will size an OpenShift Virtualization cluster from a simulated VMware estate using AI-assisted capacity planning, diagnose and fix a broken VM workload using Lightspeed, enforce network isolation with UserDefinedNetworks (UDN), right-size an over-provisioned VM using built-in observability, and finish by assessing a second cluster's readiness and performing a guided cross-cluster VM migration simulation using MTV.

## Target Audience

- **Role:** Platform engineers / OpenShift administrators
- **Experience level:** Intermediate
- **What they already know:** Core Kubernetes/OpenShift concepts (pods, namespaces, `oc` CLI), general familiarity with virtualization concepts
- **What they don't know:** OpenShift Virtualization specifics, OCP 5 AI-assisted troubleshooting and sizing workflows, UserDefinedNetworks (UDN), cross-cluster VM migration with MTV

## Prerequisites

- Familiarity with basic OpenShift/Kubernetes concepts (pods, namespaces, `oc` CLI)
- No prior OpenShift Virtualization experience required
- Can the lab validate these automatically? No — trust-based, consistent with the intermediate audience level

## Learning Objectives

1. Configure cluster sizing for an OpenShift Virtualization deployment using AI-assisted capacity planning
2. Troubleshoot workload failures using AI-assisted diagnostics (OpenShift Lightspeed)
3. Implement network isolation using UserDefinedNetworks (UDN)
4. Scale VM resources appropriately using built-in observability
5. Analyze cluster readiness for workload migration by profiling node capacity, storage compatibility, and network configuration

<!-- Scaled to a 120-minute lab: 5 objectives across 6 modules, consistent with the up-to-3-per-45-min guideline. -->

## Content Type

Lab (hands-on)

## Products & Technologies

- Red Hat OpenShift Container Platform (5.x)
- Red Hat OpenShift Virtualization (CNV)
- OpenShift Lightspeed
- Migration Toolkit for Virtualization (MTV)
- UserDefinedNetworks (UDN)

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | AI-Assisted Sizing | 30 min |
| 2 | AI-Assisted Troubleshooting | 30 min |
| 3 | Networking Troubleshooting and Isolation | 20 min |
| 4 | Resource Observability and Troubleshooting | 20 min |
| 5 | Migration Readiness Assessment | 15 min |
| 6 | Workload Migration | 5 min |
| — | **Total hands-on** | **120 min** |
| — | Intro / presentation | ~0 min (fully hands-on) |
| — | **Total lab** | **~2 hours** |

<!-- Modules build progressively: size → troubleshoot → isolate → observe/right-size → assess migration readiness → migrate. Each stage depends on cluster state produced by the prior module. -->

## Difficulty Level

Intermediate

## Environment

**Learner view:** Each student is given access to a pre-provisioned OpenShift Virtualization cluster seeded with a running VM workload, a simulated ("fake") VMware estate for the sizing exercise, and a pre-configured connectivity issue between VMs and services. Two clusters are provisioned to support the full class, with students split across them.

**Automation needed:** Yes.

Automation must provision, per module:
- A simulated VMware estate (fake VMware) with defined VM/vCPU/memory/storage counts for the sizing exercise (M1)
- A broken VM workload for AI-assisted troubleshooting (M2) — exact fault type TBD (see Open Questions)
- A pre-existing connectivity issue requiring UDN-based isolation (M3)
- An over-provisioned VM for the observability/right-sizing exercise (M4)
- A second cluster in a migratable state for the readiness assessment (M5)
- A guided interactive (Arcade-style) simulation of a cross-cluster VM migration using MTV (M6)
- Multi-user namespacing/RBAC so each student has an isolated workspace
- OpenShift Lightspeed available for AI-assisted troubleshooting and sizing (M1, M2)

## Infrastructure Requirements

- **Cloud provider:** CNV (OcpSandbox pattern)
- **Cluster type:** Multinode
- **OCP version:** 5.0 (non-GA at time of authoring — see Non-GA products below)
- **Topology:** Shared-cluster — 2 clusters, 15 users per cluster (30 students total)
- **Sizing:** Control plane: 3 × 16 vCPU / 32Gi RAM. Workers: 3 × 16 vCPU / 64Gi RAM / 100GB disk (per cluster)
- **Automation approach:** GitOps (Helm + ArgoCD)
- **AI/MaaS:** None required from this CI. OpenShift Lightspeed (`ocp4_workload_ols`, existing role) uses an external Azure-managed service — not a model deployed by lab automation
- **External services:** `registry.redhat.io` / `registry.access.redhat.com` (container image pulls); the external Azure-managed OpenShift Lightspeed backend used by `ocp4_workload_ols`
- **AAP version:** N/A — Ansible Automation Platform is not a product in this lab
- **Non-GA products:** Red Hat OpenShift Container Platform 5.x (pre-GA at time of authoring). Access plan: TBD — pending confirmation of OCP 5 availability on the CNV pool

## Assessment Strategy (Optional)

Trust-based for most modules — students validate their own fixes visually via cluster state and console output. Module 5 (Migration Readiness Assessment) uses a checklist the student fills in to produce a go/no-go recommendation. Module 6 (Workload Migration) is a guided interactive simulation (Arcade) with built-in progression checks.

## Open Questions

<!-- Carried over from source planning doc — resolve during development -->

1. What is the "broken" scenario for Module 2 (AI-Assisted Troubleshooting)? Candidates: misconfigured NetworkPolicy, wrong StorageClass, resource limits causing OOM.
2. Is UDN GA in OCP 5 at release time? If tech-preview, Module 3 needs a fallback approach.
3. When will OCP 5 be installable/available on the CNV pool?
