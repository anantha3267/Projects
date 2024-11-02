import requests
import json
import yaml

response = requests.get("https://reqres.in/api/users?page=2")
if response.status_code==200:
    data=response.json()
    print(data)
else:
    print(response.status_code)

with open("data.json",'w') as json_data:
    json.dump(data,json_data)

with open("data.yaml",'w') as yaml_data:
    yaml.dump(data,yaml_data)