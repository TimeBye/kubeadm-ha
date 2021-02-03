#!/bin/bash
set -eux;

docker pull --platform ${1:-'linux/amd64'} nginx:1.19-alpine
docker pull --platform ${1:-'linux/amd64'} haproxy:2.3-alpine
docker pull --platform ${1:-'linux/amd64'} traefik:2.4.0
docker pull --platform ${1:-'linux/amd64'} openresty/openresty:1.19.3.1-alpine
docker pull --platform ${1:-'linux/amd64'} envoyproxy/envoy:v1.16.2
docker pull --platform ${1:-'linux/amd64'} osixia/keepalived:2.0.20
docker pull --platform ${1:-'linux/amd64'} geoffh1977/chrony:latest

docker pull --platform ${1:-'linux/amd64'} calico/typha:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/cni:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/node:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/kube-controllers:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/pod2daemon-flexvol:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/ctl:v3.17.1

docker pull --platform ${1:-'linux/amd64'} jettech/kube-webhook-certgen:v1.5.0
docker pull --platform ${1:-'linux/amd64'} kubernetesui/dashboard:v2.1.0
docker pull --platform ${1:-'linux/amd64'} kubernetesui/metrics-scraper:v1.0.6

docker pull --platform ${1:-'linux/amd64'} quay.io/coreos/flannel:v0.13.0
docker pull --platform ${1:-'linux/amd64'} quay.io/jetstack/cert-manager-cainjector:v1.1.0
docker pull --platform ${1:-'linux/amd64'} quay.io/jetstack/cert-manager-webhook:v1.1.0
docker pull --platform ${1:-'linux/amd64'} quay.io/jetstack/cert-manager-controller:v1.1.0

docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-apiserver:v1.20.2
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-controller-manager:v1.20.2
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-scheduler:v1.20.2
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-proxy:v1.20.2
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/pause:3.2
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/etcd:3.4.13-0
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/coredns:1.7.0
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/ingress-nginx/controller:v0.43.0
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/metrics-server/metrics-server:v0.4.1

docker tag nginx:1.19-alpine                     127.0.0.1:5000/kubeadm-ha/nginx:1.19-alpine
docker tag haproxy:2.3-alpine                    127.0.0.1:5000/kubeadm-ha/haproxy:2.3-alpine                 
docker tag traefik:2.4.0                         127.0.0.1:5000/kubeadm-ha/traefik:2.4.0                      
docker tag openresty/openresty:1.19.3.1-alpine   127.0.0.1:5000/kubeadm-ha/openresty_openresty:1.19.3.1-alpine
docker tag envoyproxy/envoy:v1.16.2              127.0.0.1:5000/kubeadm-ha/envoyproxy_envoy:v1.16.2           
docker tag osixia/keepalived:2.0.20              127.0.0.1:5000/kubeadm-ha/osixia_keepalived:2.0.20           
docker tag geoffh1977/chrony:latest              127.0.0.1:5000/kubeadm-ha/geoffh1977_chrony:3.5

docker tag calico/typha:v3.17.1                  127.0.0.1:5000/kubeadm-ha/calico_typha:v3.17.1
docker tag calico/cni:v3.17.1                    127.0.0.1:5000/kubeadm-ha/calico_cni:v3.17.1
docker tag calico/node:v3.17.1                   127.0.0.1:5000/kubeadm-ha/calico_node:v3.17.1
docker tag calico/kube-controllers:v3.17.1       127.0.0.1:5000/kubeadm-ha/calico_kube-controllers:v3.17.1
docker tag calico/pod2daemon-flexvol:v3.17.1     127.0.0.1:5000/kubeadm-ha/calico_pod2daemon-flexvol:v3.17.1
docker tag calico/ctl:v3.17.1                    127.0.0.1:5000/kubeadm-ha/calico_ctl:v3.17.1

docker tag jettech/kube-webhook-certgen:v1.5.0   127.0.0.1:5000/kubeadm-ha/jettech_kube-webhook-certgen:v1.5.0
docker tag kubernetesui/dashboard:v2.1.0         127.0.0.1:5000/kubeadm-ha/kubernetesui_dashboard:v2.1.0
docker tag kubernetesui/metrics-scraper:v1.0.6   127.0.0.1:5000/kubeadm-ha/kubernetesui_metrics-scraper:v1.0.6

docker tag quay.io/coreos/flannel:v0.13.0                     127.0.0.1:5000/kubeadm-ha/coreos_flannel:v0.13.0                 
docker tag quay.io/jetstack/cert-manager-cainjector:v1.1.0    127.0.0.1:5000/kubeadm-ha/jetstack_cert-manager-cainjector:v1.1.0
docker tag quay.io/jetstack/cert-manager-webhook:v1.1.0       127.0.0.1:5000/kubeadm-ha/jetstack_cert-manager-webhook:v1.1.0   
docker tag quay.io/jetstack/cert-manager-controller:v1.1.0    127.0.0.1:5000/kubeadm-ha/jetstack_cert-manager-controller:v1.1.0

docker tag k8s.gcr.io/kube-apiserver:v1.20.2                 127.0.0.1:5000/kubeadm-ha/kube-apiserver:v1.20.2
docker tag k8s.gcr.io/kube-controller-manager:v1.20.2        127.0.0.1:5000/kubeadm-ha/kube-controller-manager:v1.20.2
docker tag k8s.gcr.io/kube-scheduler:v1.20.2                 127.0.0.1:5000/kubeadm-ha/kube-scheduler:v1.20.2
docker tag k8s.gcr.io/kube-proxy:v1.20.2                     127.0.0.1:5000/kubeadm-ha/kube-proxy:v1.20.2
docker tag k8s.gcr.io/pause:3.2                              127.0.0.1:5000/kubeadm-ha/pause:3.2
docker tag k8s.gcr.io/etcd:3.4.13-0                          127.0.0.1:5000/kubeadm-ha/etcd:3.4.13-0
docker tag k8s.gcr.io/coredns:1.7.0                          127.0.0.1:5000/kubeadm-ha/coredns:1.7.0
docker tag k8s.gcr.io/ingress-nginx/controller:v0.43.0       127.0.0.1:5000/kubeadm-ha/ingress-nginx_controller:v0.43.0
docker tag k8s.gcr.io/metrics-server/metrics-server:v0.4.1   127.0.0.1:5000/kubeadm-ha/metrics-server_metrics-server:v0.4.1

docker push 127.0.0.1:5000/kubeadm-ha/nginx:1.19-alpine
docker push 127.0.0.1:5000/kubeadm-ha/haproxy:2.3-alpine                 
docker push 127.0.0.1:5000/kubeadm-ha/traefik:2.4.0                      
docker push 127.0.0.1:5000/kubeadm-ha/openresty_openresty:1.19.3.1-alpine
docker push 127.0.0.1:5000/kubeadm-ha/envoyproxy_envoy:v1.16.2           
docker push 127.0.0.1:5000/kubeadm-ha/osixia_keepalived:2.0.20           
docker push 127.0.0.1:5000/kubeadm-ha/geoffh1977_chrony:3.5

docker push 127.0.0.1:5000/kubeadm-ha/calico_typha:v3.17.1
docker push 127.0.0.1:5000/kubeadm-ha/calico_cni:v3.17.1
docker push 127.0.0.1:5000/kubeadm-ha/calico_node:v3.17.1
docker push 127.0.0.1:5000/kubeadm-ha/calico_kube-controllers:v3.17.1
docker push 127.0.0.1:5000/kubeadm-ha/calico_pod2daemon-flexvol:v3.17.1
docker push 127.0.0.1:5000/kubeadm-ha/calico_ctl:v3.17.1

docker push 127.0.0.1:5000/kubeadm-ha/jettech_kube-webhook-certgen:v1.5.0
docker push 127.0.0.1:5000/kubeadm-ha/kubernetesui_dashboard:v2.1.0
docker push 127.0.0.1:5000/kubeadm-ha/kubernetesui_metrics-scraper:v1.0.6

docker push 127.0.0.1:5000/kubeadm-ha/coreos_flannel:v0.13.0                 
docker push 127.0.0.1:5000/kubeadm-ha/jetstack_cert-manager-cainjector:v1.1.0
docker push 127.0.0.1:5000/kubeadm-ha/jetstack_cert-manager-webhook:v1.1.0   
docker push 127.0.0.1:5000/kubeadm-ha/jetstack_cert-manager-controller:v1.1.0

docker push 127.0.0.1:5000/kubeadm-ha/kube-apiserver:v1.20.2
docker push 127.0.0.1:5000/kubeadm-ha/kube-controller-manager:v1.20.2
docker push 127.0.0.1:5000/kubeadm-ha/kube-scheduler:v1.20.2
docker push 127.0.0.1:5000/kubeadm-ha/kube-proxy:v1.20.2
docker push 127.0.0.1:5000/kubeadm-ha/pause:3.2
docker push 127.0.0.1:5000/kubeadm-ha/etcd:3.4.13-0
docker push 127.0.0.1:5000/kubeadm-ha/coredns:1.7.0
docker push 127.0.0.1:5000/kubeadm-ha/ingress-nginx_controller:v0.43.0
docker push 127.0.0.1:5000/kubeadm-ha/metrics-server_metrics-server:v0.4.1