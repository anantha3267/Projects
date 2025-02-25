
# MongoDB Replica Set Initialization in Kubernetes

This guide explains how to initialize a MongoDB replica set in a Kubernetes environment.

## Step 1: Exec into the `mongo-0` pod

Use the following command to exec into the `mongo-0` pod:

```bash
kubectl exec -it mongo-0 -- mongosh
```

## Step 2: Initialize the Replica Set

Inside the MongoDB shell, run the following command to initialize the replica set:

```js
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongo-0.mongo.default.svc.cluster.local:27017" },
    { _id: 1, host: "mongo-1.mongo.default.svc.cluster.local:27017" },
    { _id: 2, host: "mongo-2.mongo.default.svc.cluster.local:27017" }
  ]
})
```

## Step 3: Verify the Replica Set Status

You can check the status of the replica set by running:

```js
rs.status()
```

## Conclusion

This will initialize the MongoDB replica set with three members, `mongo-0`, `mongo-1`, and `mongo-2`. Make sure the MongoDB pods and services are correctly configured in your Kubernetes cluster.
