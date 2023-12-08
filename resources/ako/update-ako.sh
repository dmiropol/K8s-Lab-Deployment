helm upgrade $(helm list -n avi-system -q) oci://projects.registry.vmware.com/ako/helm-charts/ako -f ~/ako/values-antrea.yaml -n avi-system --version 1.11.1
