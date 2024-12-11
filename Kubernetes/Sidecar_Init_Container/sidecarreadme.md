# Sidecar Pattern for Logging with Kubernetes

This project demonstrates how to use the **sidecar pattern** in Kubernetes to collect and forward logs from an application container to an external logging system (e.g., Elasticsearch) using **Fluentd** as the sidecar container.

## Overview

In this setup:

- The **main application** container writes logs to a shared volume.
- The **Fluentd sidecar container** tails the logs and sends them to an external logging service (e.g., Elasticsearch).
- Both containers are deployed within the same Pod, allowing the sidecar container to access the application logs directly.

## Benefits of the Sidecar Pattern for Logging

- **Log Aggregation**: The sidecar pattern aggregates logs from application containers and forwards them to centralized storage.
- **Simplified Management**: No need to configure external agents for each container. Log forwarding is handled by the sidecar within the Pod.
- **Flexibility**: You can configure the sidecar independently for each application Pod, allowing fine-grained control over log processing.

## Components

- **Application Container**: A simple application that generates logs.
- **Fluentd Sidecar Container**: Collects logs from the application and forwards them to an external logging system.

## Prerequisites

- Kubernetes cluster (e.g., Minikube, Google Kubernetes Engine, AWS EKS).
- A centralized logging service (e.g., Elasticsearch) running and accessible from your Kubernetes cluster.

## Setup Instructions

### 1. Create Fluentd ConfigMap

First, create a **ConfigMap** that contains the Fluentd configuration. This configuration will tell Fluentd how to collect and forward logs to Elasticsearch.

**fluentd-configmap.yaml:**

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
  namespace: default
data:
  fluentd.conf: |
    <source>
      @type tail
      path /var/log/app/*.log
      pos_file /var/log/fluentd.pos
      tag app.*
      <parse>
        @type none
      </parse>
    </source>

    <match app.**>
      @type elasticsearch
      host elasticsearch.default.svc.cluster.local
      port 9200
      logstash_format true
      logstash_prefix fluentd
      flush_interval 5s
    </match>
```
