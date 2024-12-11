# Blue-Green Deployment with Kubernetes

This repository demonstrates a Blue-Green Deployment strategy using Kubernetes. The Blue-Green deployment ensures zero downtime when upgrading your application by routing traffic to one of two identical environments: "Blue" (the current stable version) and "Green" (the new version).

## How to Switch Traffic to the Green Version

After you have verified that the Green version is working correctly, you can switch traffic from the Blue version to the Green version by updating the Kubernetes Service selector.

1. **Before Switching**: The service selector points to the Blue version.

```yaml
selector:
  app: my-app
  version: blue # Initially points to the blue version change it to green after testing
```
