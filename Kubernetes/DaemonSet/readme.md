# Nginx DaemonSet Deployment

This repository contains the Kubernetes configuration for deploying an **Nginx DaemonSet** in your cluster. The DaemonSet ensures that a replica of the Nginx container is running on each node in the cluster. 

### Prerequisites

Before applying this DaemonSet, ensure the following components are set up on each node:

1. **Node Exporter**: A monitoring agent that exposes hardware and OS metrics. It is required for collecting node-level metrics for monitoring purposes.

   - You can deploy **Prometheus Node Exporter** on all nodes by creating a DaemonSet. The Node Exporter will run on each node and expose metrics at port `9100`.

2. **Fluentd**: A log collector that will collect logs from each node and forward them to a centralized logging service (e.g., Elasticsearch, Splunk, or other services).

   - Fluentd needs to be running on each node to collect logs from Nginx and other services. You can deploy **Fluentd** using a DaemonSet to ensure it is present on all nodes. Fluentd will read logs from `/var/log/` and other locations depending on your configuration.

### Why DaemonSet?

In this setup:
- **DaemonSet** is used to deploy both **Node Exporter** and **Fluentd** as well as Nginx because these services need to run on every node in the cluster. 
- DaemonSets are ideal for deploying system-level applications such as logging agents or monitoring tools, ensuring that they run on each node in your Kubernetes cluster.

### Steps to Deploy

1. Apply the Nginx DaemonSet YAML:

   ```bash
   kubectl apply -f nginx-daemonset.yaml
