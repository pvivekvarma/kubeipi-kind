#!/usr/bin/bash

bash -c '/usr/local/bin/kind create cluster --image kindest/node:v1.17.0 --name pi-kube --config /root/kind.yml --wait 5m'

echo Modifying Kubernetes config to point to Kind master node
MASTER_IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pi-kube-control-plane)
sed -i "s/^    server:.*/    server: https:\/\/$MASTER_IP:6443/" $HOME/.kube/config