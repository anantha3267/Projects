import boto3
import datetime

ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    # Get today's date
    today = datetime.datetime.now()
    cutoff_date = today - datetime.timedelta(days=30)
    
    # List all EBS snapshots
    snapshots = ec2_client.describe_snapshots(OwnerIds=['self'])['Snapshots']
    
    deleted_snapshots = []
    
    # Loop through all snapshots and delete those older than 30 days
    for snapshot in snapshots:
        snapshot_id = snapshot['SnapshotId']
        snapshot_date = snapshot['StartTime'].replace(tzinfo=None)
        
        if snapshot_date < cutoff_date:
            print(f"Deleting snapshot: {snapshot_id}")
            ec2_client.delete_snapshot(SnapshotId=snapshot_id)
            deleted_snapshots.append(snapshot_id)
    
    # Return a summary of deleted snapshots
    if deleted_snapshots:
        return {
            'statusCode': 200,
            'body': f"Snapshots deleted: {', '.join(deleted_snapshots)}"
        }
    else:
        return {
            'statusCode': 200,
            'body': 'No snapshots older than 30 days found.'
        }
