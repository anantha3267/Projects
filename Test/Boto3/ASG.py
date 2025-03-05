import boto3
import pymysql  # Install in Lambda Layer if using RDS
import os

# AWS Clients
asg_client = boto3.client('autoscaling')

# Database Config
DB_HOST = os.getenv('DB_HOST')  # Set environment variables in Lambda
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_NAME = os.getenv('DB_NAME')

# Auto Scaling Group Name
ASG_NAME = "MyAutoScalingGroup"

def get_user_count():
    """Query database to count active users."""
    connection = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, database=DB_NAME)
    cursor = connection.cursor()
    
    cursor.execute("SELECT COUNT(*) FROM users WHERE status='active'")  # Modify query based on schema
    user_count = cursor.fetchone()[0]
    
    connection.close()
    return user_count

def adjust_asg(user_count):
    """Adjust ASG capacity based on user count."""
    if user_count < 100:
        desired_capacity = 1
    elif 100 <= user_count < 500:
        desired_capacity = 3
    else:
        desired_capacity = 5

    # Update Auto Scaling Group
    response = asg_client.update_auto_scaling_group(
        AutoScalingGroupName=ASG_NAME,
        DesiredCapacity=desired_capacity
    )
    print(f"Updated ASG {ASG_NAME}: Desired Capacity = {desired_capacity}")

def lambda_handler(event, context):
    """Main Lambda function."""
    user_count = get_user_count()
    print(f"Active Users: {user_count}")
    
    adjust_asg(user_count)


import boto3
import pymysql
import os

cloudwatch = boto3.client('cloudwatch')

# Database Configuration
DB_HOST = os.getenv('DB_HOST')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_NAME = os.getenv('DB_NAME')

def get_active_users():
    connection = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, database=DB_NAME)
    cursor = connection.cursor()
    cursor.execute("SELECT COUNT(*) FROM users WHERE status='active'")
    user_count = cursor.fetchone()[0]
    connection.close()
    return user_count

def lambda_handler(event, context):
    user_count = get_active_users()
    
    # Publish metric
    cloudwatch.put_metric_data(
        Namespace="MyApp/CustomMetrics",
        MetricData=[{
            'MetricName': "ActiveUsers",
            'Value': user_count,
            'Unit': 'Count'
        }]
    )
    
    print(f"Active Users Metric Updated: {user_count}")
