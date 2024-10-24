# Flask App CI/CD with Jenkins, Docker, and ArgoCD

This repository contains a CI/CD pipeline for a Flask application using Jenkins, Docker, and ArgoCD. The pipeline builds a Docker image, pushes it to Docker Hub, and updates the Kubernetes deployment YAML in the GitHub repository.

## GitHub Repositories

- **Kubernetes YAMLs Repository:** [k8s-cicd-yaml](https://github.com/anantha3267/k8s-cicd-yaml.git)  
  This repository contains the Kubernetes YAML files necessary for deploying the Flask application.

- **Flask Application Repository:** [Python](https://github.com/anantha3267/Python)  
  This repository contains the source code for the Flask application.

## Prerequisites

Before running the pipeline, ensure you have the following installed on your laptop:

- Docker
- Jenkins
- ArgoCD

## Setup Instructions

1. **Start Jenkins and Docker Daemon:**
   Before running the pipeline, you need to start the Jenkins service and Docker daemon. Open your terminal and execute the following commands:

   ```bash
   sudo service jenkins restart
   sudo dockerd &
   ```
