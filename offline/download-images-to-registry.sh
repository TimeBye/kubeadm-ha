#!/bin/bash
# set -eux;

images="
nginx:1.23-alpine
haproxy:2.3-alpine
traefik:2.4.8
openresty/openresty:1.19.3.1-alpine
envoyproxy/envoy:v1.16.2
osixia/keepalived:2.0.20
setzero/chrony:3.5
calico/typha:v3.19.1
calico/cni:v3.19.1
calico/node:v3.19.1
calico/kube-controllers:v3.19.1
calico/pod2daemon-flexvol:v3.19.1
calico/ctl:v3.19.1
kubernetesui/dashboard:v2.3.1
kubernetesui/metrics-scraper:v1.0.6
quay.io/coreos/flannel:v0.14.0
quay.io/jetstack/cert-manager-cainjector:v1.4.0
quay.io/jetstack/cert-manager-webhook:v1.4.0
quay.io/jetstack/cert-manager-controller:v1.4.0
k8s.gcr.io/kube-apiserver:v1.23.12
k8s.gcr.io/kube-controller-manager:v1.23.12
k8s.gcr.io/kube-scheduler:v1.23.12
k8s.gcr.io/kube-proxy:v1.23.12
k8s.gcr.io/pause:3.7
k8s.gcr.io/etcd:3.5.4-0
k8s.gcr.io/coredns/coredns:v1.8.4
k8s.gcr.io/ingress-nginx/controller:v1.2.1
k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
k8s.gcr.io/metrics-server/metrics-server:v0.6.1
"

dest_registry=${dest_registry:-'127.0.0.1:5000/kubeadm-ha'}
for image in $images ; do 
  docker pull --platform ${1:-'linux/amd64'} $image
  count=$(echo $image | grep -o '/*' | wc -l)
  if [[ $count -eq 0 ]]; then
    dest=$dest_registry/$image
  elif [[ $count -eq 1 ]]; then
    if [[ $image =~ 'k8s.gcr.io' ]]; then
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