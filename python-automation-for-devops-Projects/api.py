import requests

url ="https://www.google.com/"
response = requests.get(url)
# print(response.status_code)
print(response.headers)
print(dir(response))
print(response.headers)
print(response.text)

  

