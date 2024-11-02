from kubernetes import client, config

def main():
    # Load the kubeconfig (make sure you have access to your cluster)
    config.load_kube_config()
    
    # Create an API instance
    v1 = client.CoreV1Api()
    
    # List pods in the default namespace
    print("Listing pods in the default namespace:")
    pods = v1.list_namespaced_pod(namespace="default")
    for pod in pods.items:
        print(f"Pod Name: {pod.metadata.name}")

if __name__ == "__main__":
    main()
