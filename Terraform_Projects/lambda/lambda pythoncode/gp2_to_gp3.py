import boto3

ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    # Extract volume ID and volume type from the CloudWatch event
    volume_id = event['detail']['responseElements']['volumeId']
    volume_type = event['detail']['requestParameters']['volumeType']
    
    # Check if the volume type is GP2, then convert it to GP3
    if volume_type == 'gp2':
        try:
            # Modify the volume to change the type to GP3
            print(f"Converting volume {volume_id} from GP2 to GP3.")
            ec2_client.modify_volume(
                VolumeId=volume_id,
                VolumeType='gp3'
            )
            print(f"Volume {volume_id} successfully converted to GP3.")
            return {
                'statusCode': 200,
                'body': f"Volume {volume_id} converted to GP3."
            }
        except Exception as e:
            print(f"Error converting volume {volume_id}: {str(e)}")
            return {
                'statusCode': 500,
                'body': f"Error converting volume {volume_id}: {str(e)}"
            }
    else:
        return {
            'statusCode': 200,
            'body': f"Volume {volume_id} is not GP2, skipping conversion."
        }
