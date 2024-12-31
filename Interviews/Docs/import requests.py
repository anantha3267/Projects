import requests
import boto3



def get_json_response_and_store_in_s3(url, bucket_name, file):
    try:
        response = requests.get(url)
        response.raise_for_status()

        json_data= response.json()

        if "Squanchy" in json_data and "Birdperson" and "snuffles" in json_data
           s3 = boto3.client('s3')
           s3.putobject(Bucket=bucket_name, key=file, Body=json.dumps(json_data))
        else:
            print("JSON response doenst contain one or all three of the names")

    except requests.exceptions.RequestException as e:
        print(f"error fetching the JSON response: {e}")

url = "https://rickandmortyapi.com/api/character/{urlnamebody}
bucket_name = bucket1
file = "data.json"

get_json_response_and_store_in_s3(url, bucket_name, file)