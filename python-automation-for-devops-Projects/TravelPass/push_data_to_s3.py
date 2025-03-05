import requests
import json
import boto3
from datetime import datetime

timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
s3_file_name = f'filtered_people_data_{timestamp}.json'
url = "http://127.0.0.1:5000/api/people"
data = requests.get(url).json()
filtered_data = []

for i in data["people"]:
    if i['name'] in ["John Doe", "Jane Smith"]:
        filtered_data.append(i)

client = boto3.client('s3')
json_data = json.dumps(filtered_data,indent=2)
response = client.put_object(
    Body=json_data,
    Bucket='examplebucketnick',
    Key=f'people_data/{s3_file_name}',
)

print(response)





