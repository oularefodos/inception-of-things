#!/bin/bash

# Update package list
sudo apt-get update

# Install prerequisites for Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker using the convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add current user to Docker group (requires logout/login to take effect)
sudo usermod -aG docker $USER

# Install K3d
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# Install Argo CD CLI
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x /usr/local/bin/argocd

# create the cluster 
sudo k3d cluster create mon-cluster --port "8080:80@loadbalancer"

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname | tr '[:upper:]' '[:lower:]')/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

#create the argocd namespace
sudo kubectl create namespace argocd

# Install Argo CD using the stable manifest
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argo_password

sudo kubectl create namespace dev

# sudo kubectl apply -f config/app.yaml -n argocd

