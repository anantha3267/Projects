# Redis Deployment with Persistent Storage

In this Kubernetes deployment, we are using a `Deployment` resource to manage a Redis pod. The pod is configured to mount a volume at `/data/redis`.

### Important Notes on Data Persistence

- **EmptyDir Volume**: In the current setup, the `/data/redis` directory inside the pod is mounted using an `emptyDir` volume. This means that the data stored in this directory is **not persistent**.
- **Behavior on Pod Restart**: When the pod restarts or is deleted, the data in the `/data/redis` directory will be lost because `emptyDir` is a temporary storage solution. It is wiped out every time the pod is restarted.

### Data Persistence Issue

Since we are using `emptyDir`, the data is not stored persistently. If you need the data to persist even after pod restarts, you should replace the `emptyDir` volume with a `PersistentVolume` (PV) and `PersistentVolumeClaim` (PVC). This will ensure that the Redis data is stored outside the pod and remains intact across pod restarts or deletions.

### Solution for Data Persistence

To make the data persistent, you can update the configuration to use a `PersistentVolume` and `PersistentVolumeClaim` instead of `emptyDir`. This ensures that data is stored in a persistent volume, which will survive pod restarts.
