#!/bin/bash
kubectl create ns yelb
kubectl apply -f yelb-lb.yaml
#kubectl apply -f yelb-ingress.yaml
#kubectl apply -f hostruleCRD.yaml
