#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

curl -sfL https://get.k3s.io | sh -s - --node-ip=192.168.56.110 --tls-san=192.168.56.110

sleep 30

kubectl apply -f /config/app1.yaml
kubectl apply -f /config/app2.yaml
kubectl apply -f /config/app3.yaml
kubectl apply -f /config/ingress.yaml