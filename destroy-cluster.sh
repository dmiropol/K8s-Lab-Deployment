#!/bin/bash
if [ -z "$1" ] || [ "$1" != "ncp"  ] && [ "$1" != 'antrea' ]; then 
	echo "Usage: `basename "$0"` (ncp | antrea)"
    exit 1
fi
hosts_file="hosts_$1.ini"
echo "Using $hosts_file as inventory file"


echo "###################### Started Destruction of the K8s cluster ######################"
cd kube-cluster
echo "################################# Deleting load balancer... #################################"
ansible-playbook -i $hosts_file delete-loadbalancer.yaml
if [ "$1" == 'antrea' ]; then 
    echo "################################# Destroying Antrea-NSX interworking... #################################"
    ansible-playbook -i $hosts_file delete-network-addons.yaml
fi
echo "###################### Deleting cluster network... #################################"
ansible-playbook -i $hosts_file delete-network.yaml
echo "################################# Reseting cluster and cleaning up files... #################################"
ansible-playbook -i $hosts_file reset-cluster.yaml
echo "################################# Done Destroying K8s cluster #################################"
if [ "$1" == 'ncp' ]; then 
    echo "################################# Cleaning up NCP objects in NSX...  #################################"
    ~/nfs_share/Projects/ncp/cleanup-ncp.sh
fi