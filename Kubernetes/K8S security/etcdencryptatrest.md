# Accessing Kubernetes Secrets from etcd using `etcdctl`

This document explains how to access Kubernetes secrets directly from the etcd store using `etcdctl`. This method is generally not recommended for production environments as it bypasses Kubernetes' access control and security mechanisms.

## Prerequisites

1. **`etcdctl` installed**: Ensure that `etcdctl` is installed. You can download it from the [etcd GitHub releases page](https://github.com/etcd-io/etcd/releases).
2. **Access to the etcd server**: You need access to the Kubernetes etcd server, which may involve configuring certificates for secure access.

## Setting up `etcdctl`

First, ensure that `etcdctl` is set up to communicate with your Kubernetes etcd instance. If your etcd cluster is using secure TLS connections (which is common), you'll need to configure `etcdctl` with the proper certificates and endpoint.

### Example Configuration

Set the following environment variables for `etcdctl` to connect to your etcd server:

```bash
export ETCDCTL_API=3
export ETCDCTL_CACERT=/path/to/ca.crt
export ETCDCTL_CERT=/path/to/cert.crt
export ETCDCTL_KEY=/path/to/cert.key
export ETCDCTL_ENDPOINT="https://<etcd-server-ip>:2379"
```

## Querying the Secret Key

etcdctl get /registry/secrets/default/my-secret --prefix --keys-only

## Retrieving the Secret Data

etcdctl get /registry/secrets/default/my-secret

## If the hacker gets access to ETCD he can view the secret so we encrypt before putting to etcd especially secrets
