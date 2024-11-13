#!/bin/bash

# Update system and install Java (required for Jenkins)
sudo apt-get update
yes | sudo apt install fontconfig openjdk-17-jre

# Install Jenkins
echo "Waiting for 30 seconds before installing the Jenkins package..."
sleep 30
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
yes | sudo apt-get install jenkins
sleep 30
echo "Jenkins installation complete"

# Install Terraform
echo "Waiting for 30 seconds before installing Terraform..."
sleep 30
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_386.zip
yes | sudo apt-get install unzip
unzip 'terraform*.zip'
sudo mv terraform /usr/local/bin/
echo "Terraform installation complete"
