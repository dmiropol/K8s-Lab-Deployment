#!/bin/bash
#if [ -z "$1" ] || [ "$1" != "ncp"  ] && [ "$1" != 'antrea' ]; then 
#	echo "Usage: `basename "$0"` (ncp | antrea)"
#    exit 1
#fi
hosts_file="hosts_antrea.ini"
echo "Using $hosts_file as inventory file"


echo "################################# Started Deployment of the K8s cluster #################################"
cd kube-cluster

#echo "################################# Making initial configurations... #################################"
#ansible-playbook -i $hosts_file initial.yaml
#echo "################################# Installing kubernetes dependencies... #################################"
ansible-playbook -i $hosts_file kube-dependencies.yaml
echo "#################################  Initializing kubernetes cluster... #################################"
ansible-playbook -i $hosts_file master-deploy.yaml
echo "################################# Installing pod network ... #################################"
ansible-playbook -i $hosts_file network-deploy.yaml
echo "################################# Deploying worker nodes... #################################"
ansible-playbook -i $hosts_file workers-deploy.yaml
ansible-playbook -i $hosts_file network-addons.yaml
echo "################################# Deploying load-balancer... #################################"
ansible-playbook -i $hosts_file loadbalancer-deploy.yaml
echo "################################# Done Deploying K8s cluster #################################"
