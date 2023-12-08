#!/bin/bash
kubectl create ns avi-system
#helm repo add ako "oci://projects.registry.vmware.com/ako/helm-charts/ako"
export AVIcontrollerIP=192.168.110.91
export AVIusername=admin
export AVIpassword=VMware1\!

helm install --generate-name oci://projects.registry.vmware.com/ako/helm-charts/ako --version 1.11.1 -f /home/ubuntu/ako/values-antrea.yaml  --set ControllerSettings.controllerIP=$AVIcontrollerIP --set avicredentials.username=$AVIusername --set avicredentials.password=$AVIpassword --set AKOSettings.primaryInstance=true --namespace=avi-system


