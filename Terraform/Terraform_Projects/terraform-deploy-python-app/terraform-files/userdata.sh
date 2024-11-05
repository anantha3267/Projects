#!/bin/bash
apt update

# install docker
apt install docker.io -y

#create new directory
mkdir /home/ubuntu/gitclone
mkdir /home/ubuntu/pythonapp

cd /home/ubuntu/gitclone

git clone https://github.com/anantha3267/Projects.git

cp -r Terraform_Projects/terraform-deploy-python-app/* /home/ubuntu/pythonapp

cd /home/ubuntu/pythonapp

docker build -t myflaskappv1 .

docker run -p 5000:5000 myflaskappv1