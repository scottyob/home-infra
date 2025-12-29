# Home Infrastructure Migration Plan

## Overview

This document outlines the plan to migrate home infrastructure workloads from the current setup to a remote 3-node Talos cluster, then repurpose local nodes into another Talos cluster, and finally migrate workloads back locally with Longhorn storage migration while decommissioning the remote cluster.

## Current State

- ArgoCD is installed and managing applications
- Current applications: m5-timelapse server
- Public IP addresses are allocated as per `public-addresses.md`
- GitOps approach is implemented with ArgoCD
- Tailscale is planned for secure networking (not yet implemented)

## Migration Steps

### Phase 1: Remote Cluster Setup

1. **Set up 3-node Talos cluster at remote site**
   - Install Talos on 3 remote nodes
   - Configure cluster with Tailscale integration
   - Set up initial networking

2. **Configure networking**
   - Deploy Calico or Cilium with BGP peering over Tailscale to home router
   - Ensure proper service exposure

3. **Migrate workloads**
   - Update ArgoCD applications to target remote cluster
   - Verify all services are operational on remote cluster

### Phase 2: Local Cluster Setup

4. **Reformat local nodes**
   - Clean install of Talos on local nodes
   - Configure as a new cluster with Tailscale integration

5. **Configure local networking**
   - Deploy Calico or Cilium with BGP peering over Tailscale to home router
   - Ensure proper service exposure

### Phase 3: Workload Migration & Decommissioning

6. **Migrate workloads back to local cluster**
   - Use Longhorn storage migration for persistent data
   - Update ArgoCD to manage local cluster
   - Verify all services are operational on local cluster

7. **Decommission remote cluster**
   - Ensure all workloads have been successfully migrated
   - Safely decommission remote nodes
   - Update documentation

## IP Address Management

During migration, we'll need to carefully manage IP addresses to avoid conflicts:
- Current addresses are documented in `public-addresses.md`
- Plan for potential reassignment during cluster transitions
- Update ingress configurations as needed

## Risks & Mitigation

- **Data Loss**: Ensure proper backup and Longhorn storage migration procedures
- **Service Downtime**: Schedule migrations during low-usage periods
- **Network Issues**: Test Tailscale connectivity before and after each migration step
- **Configuration Drift**: Use GitOps principles to maintain consistent configurations

## Success Criteria

- All applications running on new local cluster
- Persistent data successfully migrated
- Services accessible via existing IP addresses where applicable
- GitOps pipeline operational with new local cluster
- Remote cluster decommissioned