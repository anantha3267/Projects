
# Kubernetes ConfigMap: Environment Variables vs Volume Mounts

This document compares the use of **ConfigMap** in Kubernetes for two common purposes: **Environment Variables** and **Volume Mounts**.

## Key Differences

| Feature                          | Environment Variables                            | Volume Mounts                         |
| --------------------------------- | ------------------------------------------------ | ------------------------------------- |
| **Data Source**                   | Data is passed as environment variables.         | Data is stored in files inside a directory. |
| **Updating Data**                 | Requires a pod restart or rollout restart.       | Data updates automatically in mounted files. |
| **Use Case**                       | Useful for simple key-value pairs.               | Useful for more complex configurations or multiple key-value pairs. |

## 1. Environment Variables

### How It Works:
- ConfigMaps are used to provide environment variables to your applications running inside a Kubernetes pod.
- The data is passed directly as key-value pairs from the `ConfigMap` to the application container as environment variables.

### Example ConfigMap for Environment Variables:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_ENV: production
  APP_DEBUG: "false"
```

### Using the ConfigMap in a Deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app-container
        image: nginx
        envFrom:
        - configMapRef:
            name: app-config
```

### When You Update Data in the ConfigMap:
- Changes to environment variables in a `ConfigMap` require a **pod restart** or a **rollout restart** to take effect.

## 2. Volume Mounts

### How It Works:
- ConfigMaps can be mounted as volumes, making the configuration data available as files inside the container.
- The keys in the `ConfigMap` become file names, and the corresponding values are the file contents.

### Example ConfigMap for Volume Mounts:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_ENV: production
  APP_DEBUG: "false"
```

### Using the ConfigMap in a Deployment with Volume Mount:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app-container
        image: nginx
        volumeMounts:
        - name: config-volume
          mountPath: /etc/config  # Mount the entire ConfigMap as a volume
      volumes:
      - name: config-volume
        configMap:
          name: app-config
```

### When You Update Data in the ConfigMap:
- Changes to the `ConfigMap` are automatically reflected in the mounted files, without requiring a pod restart. 
- However, the application must be designed to handle these changes. If it doesn't automatically reload the configuration, a pod restart may still be needed.

