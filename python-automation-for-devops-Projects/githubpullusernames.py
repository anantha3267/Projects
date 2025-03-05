import requests

data = requests.get("https://api.github.com/repos/kubernetes/kubernetes/pulls")

full_data = data.json()
print(full_data[1]["user"]["login"])

for i in full_data:
    print(i["user"]["login"])
