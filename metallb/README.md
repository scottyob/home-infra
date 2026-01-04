# MetalLB

MetalLB is a load balancer implementation for bare metal Kubernetes clusters. It provides a network load balancer implementation for clusters that are not running on a cloud provider, using standard routing protocols.

## Configuration

MetalLB is configured through an ArgoCD Application that installs the Helm chart from the official repository. The configuration includes:

- Controller deployment
- Speaker daemonset (runs on every node)
- Webhook components
- Custom resource definitions (CRDs)

## Deployment

Because MetalLB requires special privileges to function as a network load balancer, the namespace must be created with privileged PodSecurity labels. You'll need to apply the namespace configuration first:

```bash
kubectl apply -f namespace.yaml
```

Then the ArgoCD application can be deployed which will install the MetalLB Helm chart.

## IP Address Pool

The configuration defines an IP address pool in the `config.yaml` file:

```yaml
address-pools:
- name: default
  protocol: layer2
  addresses:
  - 10.11.1.100-10.11.1.110  # Range of IPs for LoadBalancer services
```

This provides a range of IP addresses that can be assigned to Kubernetes LoadBalancer services.

## Usage

Once deployed, you can create services with `type: LoadBalancer` and Kubernetes will automatically assign them an IP address from the configured pool:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: my-app
```

## Integration with Tailscale

MetalLB works in conjunction with Tailscale to provide external access to services. For services that need to be accessible via Tailscale, you can use annotations like:

```yaml
metadata:
  annotations:
    tailscale.com/expose: "true"
```