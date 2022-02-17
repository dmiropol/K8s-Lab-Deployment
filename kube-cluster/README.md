
# Kubernetes lab with VMware NSX ALB and CNI

Support for kubernetes cluster with NCP or Antrea.
In case of Antrea, it will also deploy NSX interworking
Support for Avi Ako as type load-balancer or ingress

## What it does

Deploy playbook performs the following tasks:

- installs kubernetes depepndencies
- initializes master node
- installs selected cni plugin
  - in case of ncp - it restarts coredns deployment
  - in case of antrea - it installs NSX interworking
- installs Avi Ako

Destroy playbook performs the following tasks:

- uninstall ako helm chart and avi-system namspace
- uninstall selected cni plugin
  - in case of ncp - it deletes all objects and also attempts to run python script to clean NSX objects created by ncp plugin
  - in case of antrea - it installs deregister job, and waits for it to complete, which deregisters antrea from NSX, followed by deletion of interworking pods and cni pods
- resets all kubernetes nodes and deletes its files/folders (.kube/config, /etc/kubernetes, /etc/cni/net.d/)

## Usage

- To deploy: `./deploy-cluster.sh (ncp | antrea)`
- To destroy: `./destroy-cluster.sh (ncp | antrea)`

## Requirements

- Linux jumphost
- 3x Ubuntu 20.04 VMs: each with 2vCPU, 4GB RAM, 20GB storage
- ansible [core 2.12.1] or later
- python version = 3.8.10
- NSX-T 3.2 configured for container networking
- Avi 21.1.3 configured with NSXT cloud
- ncp, antrea and ako yaml files pre-configured and accessible from jumphost
- `hosts_ncp.ini` or `hosts_antrea.ini` files configured to match your environment
- `nsx_policy_cleanup.py` file required for destroying clsuter with ncp. If script errors out, you may need to re-run it manually. Alternatively, create shell script `cleanup-ncp.sh` and let the `destroy-cluster.sh` script to run it after kubernetes cluster has been completely destroyed.

## Initial installation

- make sure target Ubuntu VMs have passwordless login from jumphost, for example: `ssh-copy-id ubuntu@k8s-master`
- `ansible-playbook -i $hosts_file initial.yaml` can be run only once. After that it can be commented out in the `deploy-cluster.sh` script
