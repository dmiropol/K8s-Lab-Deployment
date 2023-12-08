#!/bin/bash
helm delete hello-world -n hello-kubernetes
kubectl delete ns hello-kubernetes

