import json
import os
import argparse
from kubernetes import client, config

def get_resource_limits(namespaces, kubeconfig_path):
    # Load kube config
    config.load_kube_config(config_file=kubeconfig_path)

    # Initialize Kubernetes API clients
    apps_v1 = client.AppsV1Api()

    # List to hold the resource information
    resource_data = []

    # Function to collect resource requests and limits
    def collect_resources(resource_type, resources, namespace):
        for resource in resources.items:
            resource_info = {
                "namespace": namespace,
                "resource_type": resource_type,
                "name": resource.metadata.name,
                "containers": []
            }

            if resource_type == "DaemonSet":
                resource_info.update({
                    "desired": resource.status.desired_number_scheduled,
                    "current": resource.status.current_number_scheduled,
                    "ready": resource.status.number_ready
                })
            else:
                resource_info.update({
                    "replicas": resource.spec.replicas,
                    "available": resource.status.available_replicas if resource.status.available_replicas is not None else 0
                })

            # Iterate through containers to get resource requests and limits
            for container in resource.spec.template.spec.containers:
                container_info = {
                    "name": container.name,
                    "cpu_requests": container.resources.requests.get('cpu', 'none') if container.resources.requests else 'none',
                    "cpu_limits": container.resources.limits.get('cpu', 'none') if container.resources.limits else 'none',
                    "memory_requests": container.resources.requests.get('memory', 'none') if container.resources.requests else 'none',
                    "memory_limits": container.resources.limits.get('memory', 'none') if container.resources.limits else 'none'
                }
                resource_info["containers"].append(container_info)

            resource_data.append(resource_info)

    # Iterate over namespaces and fetch resources
    for namespace in namespaces:
        # Fetch DaemonSets
        daemonsets = apps_v1.list_namespaced_daemon_set(namespace)
        collect_resources("DaemonSet", daemonsets, namespace)

        # Fetch Deployments
        deployments = apps_v1.list_namespaced_deployment(namespace)
        collect_resources("Deployment", deployments, namespace)

        # Fetch StatefulSets
        statefulsets = apps_v1.list_namespaced_stateful_set(namespace)
        collect_resources("StatefulSet", statefulsets, namespace)

    # Print the collected resource data as JSON
    print(json.dumps(resource_data, indent=2))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch CPU and memory requests and limits for DaemonSets, Deployments, and StatefulSets in multiple namespaces.")
    parser.add_argument("--namespaces", nargs='+', default=["python"], help="List of namespaces to query.")
    parser.add_argument("--kubeconfig", default=os.getenv("KUBECONFIG", os.path.expanduser("~/.kube/config")), help="Path to the kubeconfig file.")
    
    args = parser.parse_args()
    kubeconfig_path = os.path.expanduser(args.kubeconfig)

    get_resource_limits(args.namespaces, kubeconfig_path)
