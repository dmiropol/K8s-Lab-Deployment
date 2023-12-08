#!/bin/bash
cd deploy/helm
helm install --create-namespace --namespace hello-kubernetes hello-world ./hello-kubernetes
kubectl get svc hello-kubernetes-hello-world -n hello-kubernetes -o 'jsonpath={ .status.loadBalancer.ingress[0].ip }'
