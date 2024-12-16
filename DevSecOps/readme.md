# SAST Static Application Security Testing - horusec

SAST analyzes source code for vulnerabilities

sudo docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/src horuszup/horusec-cli:latest horusec start -p /src -P $(pwd) -D

# DAST Dynamic Application Security Testing - OWASP

DAST tests running applications

docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://www.example.com

# SCA Software Composition Analysis - Snyk

Analyzes open-source components in software to identify vulnerabilities and license compliance issues.

Ex - In package.json if you have package node-emoji:1.0.0 it checks if they are up to date and if they are vulnerable

docker run -it --rm --entrypoint /bin/sh snyk/snyk test --directory <directory_path>

# Docker Image vulnerabilities

docker run aquasec/trivy image my-vulnerable-app

# Testing Terraform

tfsec
checkov
terrascan

docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src

# K8S - KubeScore

docker run -v $(pwd):/project zegl/kube-score:latest score my-app/\*.yaml
