# Tailscale Talos Configuration (TJT)

This directory contains the Talos Linux configuration files for setting up a cluster with Tailscale integration.

## Generate the config
```
docker run --rm --network host ghcr.io/siderolabs/booter:v0.3.0 --talos-version=v1.12.0 --schematic-id=077514df2c1b6436460bc60faabc976687b16193b8a1290fda4366c69024fec2
```

## Configuration Files

- `talos-x.yaml` - Main Talos configuration for the first node
- `tailscale-control.yaml` - Tailscale config (needs AUTHKEY replaced)

## Applying Configuration

To apply the configuration to your Talos node:

```bash
# Set up your environment with the TS_AUTHKEY
talosctl apply-config --insecure -n 192.168.1.114 --file controlplane.yaml -p talos-1.yaml -p tailscale-control.yaml
```
