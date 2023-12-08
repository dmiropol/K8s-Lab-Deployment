#!/bin/bash
kubectl create ns boutique
kubectl apply -n boutique -f release/kubernetes-manifests.yaml

