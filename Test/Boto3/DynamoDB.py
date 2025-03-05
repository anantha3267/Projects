import boto3
import json

# Initialize DynamoDB client
client = boto3.client('dynamodb')

def lambda_handler(event, context):
    # Create the DynamoDB table
    response_create_table = client.create_table(
        TableName='Orders',  # Table Name
        AttributeDefinitions=[
            {
                'AttributeName': 'Customer ID',
                'AttributeType': 'S'  # String type
            },
            {
                'AttributeName': 'Product',
                'AttributeType': 'S'  # String type
            }
        ],
        KeySchema=[
            {
                'AttributeName': 'Customer ID',
                'KeyType': 'HASH'  # Partition Key
            },
            {
                'AttributeName': 'Product',
                'KeyType': 'RANGE'  # Sort Key
            }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 1,
            'WriteCapacityUnits': 1
        }
    )

    # Insert an item into the "Orders" table
    response_insert_item = client.put_item(
        TableName='Orders',
        Item={
            'Customer ID': {'S': '123'},
            'Product': {'S': 'Laptop'},
            'Quantity': {'N': '1'},
            'Price': {'N': '1200'}
        }
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "✅ Table 'Orders' created and item inserted successfully!"
        })
    }
