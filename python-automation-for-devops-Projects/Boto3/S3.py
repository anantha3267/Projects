import boto3
import json

client = boto3.client('s3')

# response = client.create_bucket(
#     Bucket='nick-yt-332025',
# )

response = client.get_bucket_acl(
    Bucket='nick-yt-332025'
)

print(json.dumps(response,indent=2))
print(response["Owner"]["DisplayName"])

response = client.delete_bucket(
    Bucket='nick-yt-332025',
)

print(response)