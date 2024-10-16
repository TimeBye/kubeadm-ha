#!/bin/bash
# set -eux;

images="
nginx:1.25-alpine
haproxy:2.8-alpine
traefik:v3.0.0
osixia/keepalived:2.0.20
setzero/chrony:3.5
calico/typha:v3.28.2
calico/cni:v3.28.2
calico/node:v3.28.2
calico/kube-controllers:v3.28.2
calico/ctl:v3.28.2
kubernetesui/dashboard:v2.7.0
kubernetesui/metrics-scraper:v1.0.8
flannel/flannel:v0.25.7
flannel/flannel-cni-plugin:v1.5.1-flannel2
quay.io/jetstack/cert-manager-cainjector:v1.14.5
quay.io/jetstack/cert-manager-webhook:v1.14.5
quay.io/jetstack/cert-manager-controller:v1.14.5
quay.io/jetstack/cert-manager-acmesolver:v1.14.5
registry.k8s.io/kube-apiserver:v1.30.5
registry.k8s.io/kube-controller-manager:v1.30.5
registry.k8s.io/kube-scheduler:v1.30.5
registry.k8s.io/kube-proxy:v1.30.5
registry.k8s.io/pause:3.9
registry.k8s.io/etcd:3.5.15-0
registry.k8s.io/coredns/coredns:v1.11.3
registry.k8s.io/ingress-nginx/controller:v1.11.3
registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.4
registry.k8s.io/metrics-server/metrics-server:v0.7.2
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