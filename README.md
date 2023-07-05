
# Kubernetes lab with VMware NSX ALB and CNI

Support for kubernetes cluster with Antrea.
It will also deploy NSX interworking
Support for Avi Ako as type load-balancer or ingress

## What it does

Deploy playbook performs the following tasks:

- installs kubernetes depepndencies
- initializes master node
- installs selected cni plugin
- installs NSX interworking
- installs Avi Ako

Destroy playbook performs the following tasks:

- uninstall ako helm chart and avi-system namspace
- uninstall selected cni plugin
  - installs deregister job, and waits for it to complete, which deregisters antrea from NSX, followed by deletion of interworking pods and cni pods
- resets all kubernetes nodes and deletes its files/folders (.kube/config, /etc/kubernetes, /etc/cni/net.d/)

## Usage

- To deploy: `./deploy-cluster.sh`
- To destroy: `./destroy-cluster.sh`

## Requirements

- Linux jumphost
- 3x Ubuntu 20.04 VMs: each with 2vCPU, 4GB RAM, 20GB storage
- ansible [core 2.12.1] or later
- python version = 3.8.10
- NSX-T 3.2.3 configured for container networking
- Avi 22.1.3 configured with NSXT cloud
- antrea and ako yaml files pre-configured and accessible from jumphost
- `hosts_antrea.ini` files configured to match your environment


## Initial installation

- make sure target Ubuntu VMs have passwordless login from jumphost, for example: `ssh-copy-id ubuntu@k8s-master`
- `ansible-playbook -i $hosts_file initial.yaml` can be run only once. After that it can be commented out in the `deploy-cluster.sh` script

# Changes

- removed ncp
- updated ubuntu
- upgraded kubernetes to 1.26.6
- upgraded Antrea to 1.11
- upgraded Ako to 1.9.3