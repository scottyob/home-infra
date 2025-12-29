# Project Summary

## Overall Goal
Migrate home infrastructure workloads from a current setup to a remote 3-node Talos cluster, then repurpose local nodes into another Talos cluster, and finally migrate workloads back locally with Longhorn storage migration while decommissioning the remote cluster.

## Key Knowledge
- Current infrastructure uses ArgoCD for GitOps management of Kubernetes resources
- Project is in `/home/scott/Documents/home-infra` directory
- Bootstrap ArgoCD configuration exists in `bootstrap/argocd/`
- Currently has at least one application (m5-timelapse) deployed via ArgoCD
- Uses Talos as the Kubernetes distribution for the planned clusters
- Longhorn storage migration needs to be considered for workload transfers
- ArgoCD provides the GitOps foundation for managing the infrastructure
- All cluster communication and services should operate over Tailscale
- Using Calico or Cilium with BGP peering over Tailscale to home router for service exposure

## Recent Actions
- Established initial ArgoCD setup with namespace, install, ingress, and external service configurations
- Documented the current structure and goals in the conversation
- Identified the need for remote Talos cluster setup as the next step
- Recognized the importance of Longhorn storage migration in the final migration step

## Current Plan
1. [TODO] Set up a 3-node Talos cluster at a remote site with Tailscale integration
2. [TODO] Configure Calico or Cilium with BGP peering over Tailscale to home router
3. [TODO] Move all workloads to the remote site using ArgoCD style
4. [TODO] Re-format local nodes, turn into another Talos cluster with Tailscale integration
5. [TODO] Configure Calico or Cilium with BGP peering over Tailscale to home router for local cluster
6. [TODO] Migrate workloads (including Longhorn storage migrate) back over locally
7. [TODO] Decommission the remote cluster

---

## Summary Metadata
**Update time**: 2025-12-23T05:51:20.042Z 
