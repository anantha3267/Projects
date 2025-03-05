import boto3

def lambda_handler(event, context):
    # Create EC2 client
    ec2 = boto3.client('ec2', region_name='us-east-1')

    # Create the EC2 instance
    response = ec2.run_instances(
        ImageId='ami-05b10e08d247fb927',  # Replace with your AMI ID
        InstanceType='t2.micro',  # Instance type
        MinCount=1,  # Minimum number of instances to launch
        MaxCount=1,  # Maximum number of instances to launch
    )

    # Get the Instance ID from the response
    instance_id = response['Instances'][0]['InstanceId']
    
    # Print the instance ID
    print(f"EC2 Instance Created: {instance_id}")
