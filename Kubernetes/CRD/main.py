import kopf
import kubernetes
from datetime import datetime, timezone, timedelta

@kopf.on.create('cleanup.example.com', 'v1', 'stalepvcs')
@kopf.on.update('cleanup.example.com', 'v1', 'stalepvcs')
def handle_stale_pvc(spec, name, namespace, logger, **_):
    pvc_name = spec['pvcName']
    max_age = spec.get('maxAgeDays', 7)

    kubernetes.config.load_incluster_config()
    v1 = kubernetes.client.CoreV1Api()

    # Check if PVC exists
    try:
        pvc = v1.read_namespaced_persistent_volume_claim(name=pvc_name, namespace=namespace)
    except kubernetes.client.exceptions.ApiException as e:
        logger.error(f"PVC {pvc_name} not found: {e}")
        return

    # Check if any pod uses it
    pods = v1.list_namespaced_pod(namespace=namespace).items
    for pod in pods:
        for vol in pod.spec.volumes or []:
            if vol.persistent_volume_claim and vol.persistent_volume_claim.claim_name == pvc_name:
                logger.info(f"PVC '{pvc_name}' still in use by pod '{pod.metadata.name}'")
                return

    # Check age
    age = datetime.now(timezone.utc) - pvc.metadata.creation_timestamp
    if age > timedelta(days=max_age):
        logger.warning(f"Deleting stale PVC '{pvc_name}' older than {max_age} days")
        v1.delete_namespaced_persistent_volume_claim(name=pvc_name, namespace=namespace)
    else:
        logger.info(f"PVC '{pvc_name}' is unused but only {age.days} days old")