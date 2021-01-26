#!/bin/bash
set -eux;

docker pull --platform ${1:-'linux/amd64'} nginx:1.19-alpine
docker pull --platform ${1:-'linux/amd64'} calico/typha:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/cni:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/node:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/kube-controllers:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/pod2daemon-flexvol:v3.17.1
docker pull --platform ${1:-'linux/amd64'} calico/ctl:v3.17.1
docker pull --platform ${1:-'linux/amd64'} jettech/kube-webhook-certgen:v1.5.0
docker pull --platform ${1:-'linux/amd64'} kubernetesui/dashboard:v2.1.0
docker pull --platform ${1:-'linux/amd64'} kubernetesui/metrics-scraper:v1.0.6

docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-apiserver:v1.20.1
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-controller-manager:v1.20.1
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-scheduler:v1.20.1
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/kube-proxy:v1.20.1
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/pause:3.2
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/etcd:3.4.13-0
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/coredns:1.7.0
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/ingress-nginx/controller:v0.43.0
docker pull --platform ${1:-'linux/amd64'} k8s.gcr.io/metrics-server/metrics-server:v0.4.0

docker tag nginx:1.19-alpine                     registry.aliyuncs.com/kubeadm-ha/nginx:1.19-alpine
docker tag calico/typha:v3.17.1                   registry.aliyuncs.com/kubeadm-ha/calico_typha:v3.17.1
docker tag calico/cni:v3.17.1                     registry.aliyuncs.com/kubeadm-ha/calico_cni:v3.17.1
docker tag calico/node:v3.17.1                    registry.aliyuncs.com/kubeadm-ha/calico_node:v3.17.1
docker tag calico/kube-controllers:v3.17.1        registry.aliyuncs.com/kubeadm-ha/calico_kube-controllers:v3.17.1
docker tag calico/pod2daemon-flexvol:v3.17.1      registry.aliyuncs.com/kubeadm-ha/calico_pod2daemon-flexvol:v3.17.1
docker tag calico/ctl:v3.17.1                     registry.aliyuncs.com/kubeadm-ha/calico_ctl:v3.17.1
docker tag jettech/kube-webhook-certgen:v1.5.0   registry.aliyuncs.com/kubeadm-ha/jettech_kube-webhook-certgen:v1.5.0
docker tag kubernetesui/dashboard:v2.1.0         registry.aliyuncs.com/kubeadm-ha/kubernetesui_dashboard:v2.1.0
docker tag kubernetesui/metrics-scraper:v1.0.6   registry.aliyuncs.com/kubeadm-ha/kubernetesui_metrics-scraper:v1.0.6

docker tag k8s.gcr.io/kube-apiserver:v1.20.1                 registry.aliyuncs.com/kubeadm-ha/kube-apiserver:v1.20.1
docker tag k8s.gcr.io/kube-controller-manager:v1.20.1        registry.aliyuncs.com/kubeadm-ha/kube-controller-manager:v1.20.1
docker tag k8s.gcr.io/kube-scheduler:v1.20.1                 registry.aliyuncs.com/kubeadm-ha/kube-scheduler:v1.20.1
docker tag k8s.gcr.io/kube-proxy:v1.20.1                     registry.aliyuncs.com/kubeadm-ha/kube-proxy:v1.20.1
docker tag k8s.gcr.io/pause:3.2                              registry.aliyuncs.com/kubeadm-ha/pause:3.2
docker tag k8s.gcr.io/etcd:3.4.13-0                          registry.aliyuncs.com/kubeadm-ha/etcd:3.4.13-0
docker tag k8s.gcr.io/coredns:1.7.0                          registry.aliyuncs.com/kubeadm-ha/coredns:1.7.0
docker tag k8s.gcr.io/ingress-nginx/controller:v0.43.0       registry.aliyuncs.com/kubeadm-ha/ingress-nginx_controller:v0.43.0
docker tag k8s.gcr.io/metrics-server/metrics-server:v0.4.0   registry.aliyuncs.com/kubeadm-ha/metrics-server_metrics-server:v0.4.0

docker save \
    registry.aliyuncs.com/kubeadm-ha/nginx:1.19-alpine \
    registry.aliyuncs.com/kubeadm-ha/calico_typha:v3.17.1 \
    registry.aliyuncs.com/kubeadm-ha/calico_cni:v3.17.1 \
    registry.aliyuncs.com/kubeadm-ha/calico_node:v3.17.1 \
    registry.aliyuncs.com/kubeadm-ha/calico_kube-controllers:v3.17.1 \
    registry.aliyuncs.com/kubeadm-ha/calico_pod2daemon-flexvol:v3.17.1 \
    registry.aliyuncs.com/kubeadm-ha/calico_ctl:v3.17.1 \
    registry.aliyuncs.com/kubeadm-ha/jettech_kube-webhook-certgen:v1.5.0 \
    registry.aliyuncs.com/kubeadm-ha/kubernetesui_dashboard:v2.1.0 \
    registry.aliyuncs.com/kubeadm-ha/kubernetesui_metrics-scraper:v1.0.6 \
    registry.aliyuncs.com/kubeadm-ha/kube-apiserver:v1.20.1 \
    registry.aliyuncs.com/kubeadm-ha/kube-controller-manager:v1.20.1 \
    registry.aliyuncs.com/kubeadm-ha/kube-scheduler:v1.20.1 \
    registry.aliyuncs.com/kubeadm-ha/kube-proxy:v1.20.1 \
    registry.aliyuncs.com/kubeadm-ha/pause:3.2 \
    registry.aliyuncs.com/kubeadm-ha/etcd:3.4.13-0 \
    registry.aliyuncs.com/kubeadm-ha/coredns:1.7.0 \
    registry.aliyuncs.com/kubeadm-ha/ingress-nginx_controller:v0.43.0 \
    registry.aliyuncs.com/kubeadm-ha/metrics-server_metrics-server:v0.4.0 \
    | gzip -1 > kubernetes-1.20.1.tar