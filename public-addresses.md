# Public Addresses

This document tracks the public addresses currently in use by the home infrastructure.

## Current Addresses

| Service/App  | Public Address | Internal Address | Purpose                          | Notes                                                |
|--------------|----------------|------------------|----------------------------------|------------------------------------------------------|
| Traefik      | 10.11.1.1      |                  | Load balancer/Ingress controller |                                                      |
| Etcd         | 10.11.10.2     |                  | Key-value store for Kubernetes   |                                                      |
| CouchDB      | 10.11.10.3     |                  | Document-oriented database       |                                                      |
| ArgoCD       | 10.11.10.4     |                  | ArgoCD web interface and API     | Used via external service with service-external.yaml |
| ImageHosting | 10.11.10.5     |                  | For Esp-cam uploads              |                                                      |

## Reserved Addresses

| Address | Reservation Date | Expiration Date | Purpose | Notes |
|---------|------------------|-----------------|---------|-------|
| (None at this time) | | | | |

## Archive

| Address | Service/App | In Use Period | Reason for Release | Notes |
|---------|-------------|---------------|---------------------|-------|
| (None at this time) | | | | |
