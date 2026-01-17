# Home Infra

## About
This contains all of my configuration (not secrets) for setting up all the services
on my home infrastructure.

Currently, this is managed in a three node Talos cluster.  Persistent configuration is kept
in PVCs with Longhorn.  These should be backed up off-site for a recovery plan.

## Setting up Infra

### Building the image

First step is to setup Talos with our configuration options.  We have chosen the following customizations
in the web ui.  This should allow us to have these nodes join our Tailnet and provide all of the options
needed for Longhorn distributed storage.

```
customization:
    systemExtensions:
        officialExtensions:
            - siderolabs/iscsi-tools
            - siderolabs/qemu-guest-agent
            - siderolabs/tailscale
            - siderolabs/util-linux-tools
```

You can run this on a node in your network to enable PXE / NetBooting to install (command given with 
Talos interface)
```bash
docker run --rm --network host ghcr.io/siderolabs/booter:v0.3.0 --talos-version=v1.12.0 --schematic-id=077514df2c1b6436460bc60faabc976687b16193b8a1290fda4366c69024fec2
```

### Generating the Config

We'll generate the Talos config using.  The `controlplane-cni-patch` patch here uses the very simple Flannel CNI, with IPv6 enabled, using site local addresses, and NAT on the Host for egress IPv6 Traffic.

```bash
talosctl gen config tjt https://192.168.1.200 --install-image=factory.talos.dev/installer/077514df2c1b6436460bc60faabc976687b16193b8a1290fda4366c69024fec2:v1.12.0 --config-patch @controlplane-cni-patch.yaml --force
```

### Applying the Config to a Node

This will apply our generated controlplane config to the host, with patches for static ip addresses, and one to allow scheduling workloads on controlplane nodes.

```bash
talosctl apply-config --insecure -n 192.168.1.142 --file controlplane.yaml -p talos-1.yaml -p workloads-control.yaml
talosctl apply-config --insecure -n 192.168.1.172 --file controlplane.yaml -p talos-2.yaml -p workloads-control.yaml
talosctl apply-config --insecure -n 192.168.1.101 --file controlplane.yaml -p talos-3.yaml -p workloads-control.yaml

```

Feel free to also apply the config to the other nodes in this cluster now.

### Bootstrapping a Control Plane Node

This only needs to be done to one control plane node.  The node should initialize etcd, then, assume the VIP address of the clusters control address.

```bash
talosctl bootstrap --nodes 192.168.1.201 --endpoints 192.168.1.201 --talosconfig=./talosconfig
```

### Generating a k8s config
This will generate a k8s config to allow you to run kubectl commands now on the cluster.  It should override your local config.
```bash
talosctl kubeconfig -e 192.168.1.200 -n 192.168.1.200 --talosconfig=./talosconfig
```

### Allowing nodes to be used for load balancers
As we only have three of them, and, they're all control plane nodes:
```bash
kubectl label nodes tjt-talos-cp-1 node.kubernetes.io/exclude-from-external-load-balancers-
```



## Tips

### Test pod, for testing IPv6 Connectivity
```
kubectl run ipv6-test \
  --image=ubuntu:24.04 \
  --restart=Never \
  --rm -it \
  -- bash
```

# Setting up Software Stack

There are a few piece of software that we're going to setup for our cluster:
- **Argo:** for syncing in apps from this repo
- **Tailscale Operator:** Allowing us to expose apps in remote sites via TailScale

## Argo

**Setting up Argo**
From: https://argo-cd.readthedocs.io/en/stable/getting_started/
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

**Getting the Argo initial password**
```bash
argocd admin initial-password -n argocd
REgkvK9i4o6-qxZk

kubectl port-forward svc/argocd-server -n argocd 8080:443
```
