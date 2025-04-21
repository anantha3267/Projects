import requests
import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    try:
        response = requests.get(os.environ['API_ENDPOINT'])
        response.raise_for_status()
        value = response.json().get('value', 0)
        
        boto3.client('cloudwatch').put_metric_data(
            Namespace='CustomMetrics',
            MetricData=[{
                'MetricName': 'APIResponseValue',
                'Timestamp': datetime.utcnow(),
                'Value': value,
                'Unit': 'Count'
            }]
        )
        
        return {'statusCode': 200, 'body': 'Metric pushed successfully'}
    except Exception as e:
        return {'statusCode': 500, 'body': str(e)}