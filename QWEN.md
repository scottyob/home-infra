# Home Infrastructure Project

This repository contains the configuration and deployment manifests for my home infrastructure. The setup uses GitOps principles with ArgoCD to manage Kubernetes resources.

## Overview

The project is organized to bootstrap and manage services running in a home Kubernetes cluster. Currently, it includes the initial setup for ArgoCD itself.

## Structure

- `bootstrap/argocd/` - Contains manifests for bootstrapping ArgoCD
  - `namespace.yaml` - Creates the namespace for ArgoCD
  - `install.yaml` - Installs ArgoCD components
  - `ingress.yaml` - Configures ingress for ArgoCD web interface
  - `service-external.yaml` - Configures external access to ArgoCD via external IP

## Current Status

This is an early stage setup focusing on establishing the GitOps foundation with ArgoCD. Future additions will include manifests for other services and applications running in the home infrastructure.

## Public Addresses

For tracking of public addresses currently in use, see [public-addresses.md](public-addresses.md).

### ArgoCD External Access

ArgoCD is configured with an external service that allows access via the dedicated IP address 10.11.10.4. This service complements the existing ingress configuration by providing direct IP-based access to the ArgoCD server, which is useful for scenarios where DNS resolution may not be available or desired.