import json
import boto3

def lambda_handler(event, context):
    # Initialize AWS clients
    s3_client = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb')
    
    # Get object from S3
    response = s3_client.get_object(
        Bucket='s3demo01022022abc',
        Key='DynamoDB_Samplefile.json'
    )

    # Convert from streaming data to byte
    json_data = response['Body'].read()

    # Convert data from byte to string
    data_string = json_data.decode('UTF-8')

    # Convert from JSON string to dictionary
    data_dict = json.loads(data_string)
    print(data_dict)
    print(type(data_dict))

    # Insert data into DynamoDB
    table = dynamodb.Table('RetailSales02032022')
    table.put_item(Item=data_dict)

    return {
        'statusCode': 200,
        'body': json.dumps('Data inserted successfully')
    }


# import json
# import boto3

# def lambda_handler(event, context):
#     # Initialize AWS clients
#     s3_client = boto3.client('s3')
#     dynamodb = boto3.resource('dynamodb')
    
#     # Extract bucket name and file key from the event
#     bucket_name = event['Records'][0]['s3']['bucket']['name']
#     file_key = event['Records'][0]['s3']['object']['key']
    
#     # Get object from S3 using the bucket and key from the event
#     response = s3_client.get_object(
#         Bucket=bucket_name,
#         Key=file_key
#     )

#     # Convert from streaming data to byte
#     json_data = response['Body'].read()

#     # Convert data from byte to string
#     data_string = json_data.decode('UTF-8')

#     # Convert from JSON string to dictionary
#     data_dict = json.loads(data_string)
#     print(data_dict)
#     print(type(data_dict))

#     # Insert data into DynamoDB
#     table = dynamodb.Table('RetailSales02032022')
#     table.put_item(Item=data_dict)

#     return {
#         'statusCode': 200,
#         'body': json.dumps(f'Data from {file_key} inserted successfully')
#     }
