#!/bin/bash
# set -eux;

images="
nginx:1.25-alpine
haproxy:2.8-alpine
setzero/osixia_keepalived:2.0.20
setzero/chrony:3.5
calico/typha:v3.30.2
calico/cni:v3.30.2
calico/node:v3.30.2
calico/kube-controllers:v3.30.2
calico/ctl:v3.30.2
flannel/flannel:v0.27.2
flannel/flannel-cni-plugin:v1.7.1-flannel2
registry.k8s.io/kube-apiserver:v1.32.8
registry.k8s.io/kube-controller-manager:v1.32.8
registry.k8s.io/kube-scheduler:v1.32.8
registry.k8s.io/kube-proxy:v1.32.8
registry.k8s.io/pause:3.10
registry.k8s.io/etcd:3.5.16-0
registry.k8s.io/coredns/coredns:v1.11.3
registry.k8s.io/ingress-nginx/controller:v1.13.1
registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.6.1
registry.k8s.io/metrics-server/metrics-server:v0.8.0
"

dest_registry=${dest_registry:-'127.0.0.1:5000/kubeadm-ha'}
for image in $images ; do 
  docker pull --platform ${1:-linux/amd64} $image
  count=$(echo $image | grep -o '/*' | wc -l)
  if [[ $count -eq 0 ]]; then
    dest=$dest_registry/$image
  elif [[ $count -eq 1 ]]; then
    if [[ $image =~ 'registry.k8s.io' ]]; then
      dest=$dest_registry/$(echo ${image#*/} | sed 's / _ g')
    else
      dest=$dest_registry/$(echo ${image} | sed 's / _ g')
    fi
  else
    if [[ $image =~ 'coredns' ]]; then
      dest=$dest_registry/$(echo ${image##*/} | sed 's / _ g')
    else
      dest=$dest_registry/$(echo ${image#*/} | sed 's / _ g')
    fi
  fi
  docker tag $image $dest
  docker push $dest
done