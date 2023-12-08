#!/bin/bash
kubectl delete -n boutique -f release/kubernetes-manifests.yaml
kubectl delete ns boutique

