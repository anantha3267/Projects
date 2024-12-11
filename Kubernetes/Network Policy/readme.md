# Kubernetes NetworkPolicy Overview

## Requirements

To use Kubernetes `NetworkPolicy`, your cluster must have a **CNI (Container Network Interface)** plugin installed that supports network policies. The CNI plugin is responsible for enforcing the network policies in the cluster, such as blocking or allowing traffic between pods.

Common CNI plugins that support `NetworkPolicy` include:

- Calico
- Cilium
- Weave Net
- Kube-router
- Canal

If you don't have a CNI plugin installed, Kubernetes `NetworkPolicy` resources will have no effect, and traffic between pods will not be restricted by any network policy rules.

## NetworkPolicy Behavior

### Default Behavior: Deny All

If you do not explicitly define any `Ingress` or `Egress` rules in a `NetworkPolicy`, Kubernetes will **deny all traffic** by default.

- **Ingress (incoming traffic)**: If you don't specify `Ingress` rules, no incoming traffic will be allowed to the pods selected by the `NetworkPolicy` unless there are other `NetworkPolicy` resources in place that allow it.
- **Egress (outgoing traffic)**: Similarly, if you don't specify `Egress` rules, all outgoing traffic from the selected pods will be blocked.

### Example 1: Deny All Traffic

If no `Ingress` or `Egress` rules are defined, traffic is blocked:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
```
