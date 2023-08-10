#!/bin/bash
# set -eux;

images="
nginx:1.23-alpine
haproxy:2.3-alpine
traefik:v2.10.4
openresty/openresty:1.19.3.1-alpine
envoyproxy/envoy:v1.16.2
osixia/keepalived:2.0.20
setzero/chrony:3.5
calico/typha:v3.26.1
calico/cni:v3.26.1
calico/node:v3.26.1
calico/kube-controllers:v3.26.1
calico/ctl:v3.26.1
kubernetesui/dashboard:v2.7.0
kubernetesui/metrics-scraper:v1.0.8
flannel/flannel:v0.22.1
flannel/flannel-cni-plugin:v1.2.0
quay.io/jetstack/cert-manager-cainjector:v1.12.3
quay.io/jetstack/cert-manager-webhook:v1.12.3
quay.io/jetstack/cert-manager-controller:v1.12.3
quay.io/jetstack/cert-manager-acmesolver:v1.12.3
registry.k8s.io/kube-apiserver:v1.27.4
registry.k8s.io/kube-controller-manager:v1.27.4
registry.k8s.io/kube-scheduler:v1.27.4
registry.k8s.io/kube-proxy:v1.27.4
registry.k8s.io/pause:3.9
registry.k8s.io/etcd:3.5.7-0
registry.k8s.io/coredns/coredns:v1.10.1
registry.k8s.io/ingress-nginx/controller:v1.8.1
registry.k8s.io/ingress-nginx/kube-webhook-certgen:v20230407
registry.k8s.io/metrics-server/metrics-server:v0.6.4
"

dest_registry=${dest_registry:-'127.0.0.1:5000/kubeadm-ha'}
for image in $images ; do 
  docker pull --platform ${1:-'linux/amd64'} $image
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