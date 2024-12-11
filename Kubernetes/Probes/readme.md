# Kubernetes Probes

## Liveness Probe

The **liveness probe** checks if a container is still running and functioning correctly. If the liveness probe fails, Kubernetes will restart the container to recover from a failure. This probe ensures that containers are automatically restarted when they become unhealthy.

## Readiness Probe

The **readiness probe** checks if a container is ready to handle traffic. Only if the readiness probe succeeds will Kubernetes route traffic to the container. If the readiness probe fails, traffic is not sent to the container, even though it might still be running. This helps in ensuring that only fully initialized and ready containers serve requests.
