# Docker Network Setup and Troubleshooting

This document provides instructions for setting up Docker containers, managing networks, and troubleshooting connectivity issues.

Run the `login` and `logout` containers using the latest `nginx` image:

```bash
docker run -d --name login nginx:latest
docker run -d --name logout nginx:latest
docker exec -it login /bin/bash
apt-get update
apt-get install iputils-ping -y

docker exec -it logout /bin/bash
apt-get update
apt-get install iputils-ping -y

docker inspect login # IP: 172.17.0.2
docker inspect logout # IP: 172.17.0.3

docker exec -it login /bin/bash
ping 172.17.0.3 # It works

docker network ls

docker network create secure-network
docker run -d --name finance --network secure-network nginx:latest

docker inspect finance # IP: 172.19.0.2
docker exec -it login /bin/bash
ping 172.19.0.2 # It doesn't work

docker run -d --name host-demo --network=host nginx:latest
```
