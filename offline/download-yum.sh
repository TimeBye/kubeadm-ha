#!/bin/bash
set -eux;

# 创建缓存目录
mkdir -p ${1:-'kubernetes-yum'}
cd ${1:-'kubernetes-yum'}

yum install -y \
    yum-utils \
    createrepo \
    epel-release

# 添加docker源
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 添加kubernetes源
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=0
repo_gpgcheck=0
EOF

repotrack lvm2
repotrack audit
repotrack device-mapper-persistent-data
repotrack docker-ce-20.10.7
repotrack docker-ce-cli-20.10.7
repotrack containerd.io-1.4.6
yumdownloader --resolve docker-ce-20.10.7
yumdownloader --resolve docker-ce-cli-20.10.7
yumdownloader --resolve containerd.io-1.4.6

createrepo --update ./
tar -czvf docker-ce-20.10.7.tar.gz *.rpm repodata
mv docker-ce-20.10.7.tar.gz ..

if [ $(uname -m) == 'x86_64' ];then
  curl -o kernel-lt-5.4.92-1.el7.elrepo.x86_64.rpm \
      http://mirrors.reposnap.com/elrepo/20210127110058/kernel/el7/x86_64/RPMS/kernel-lt-5.4.92-1.el7.elrepo.x86_64.rpm
  curl -o kernel-lt-devel-5.4.92-1.el7.elrepo.x86_64.rpm \
      http://mirrors.reposnap.com/elrepo/20210127110058/kernel/el7/x86_64/RPMS/kernel-lt-devel-5.4.92-1.el7.elrepo.x86_64.rpm
fi

repotrack jq
repotrack git
repotrack curl
repotrack wget
repotrack htop
repotrack iotop
repotrack socat
repotrack ipset
repotrack sysstat
repotrack ipvsadm
repotrack nmap-ncat
repotrack nfs-utils
repotrack iscsi-initiator-utils
repotrack yum-utils
repotrack net-tools
repotrack libseccomp
repotrack conntrack-tools
repotrack bash-completion
repotrack kubeadm-1.21.4
repotrack kubectl-1.21.4
repotrack kubelet-1.21.4
yumdownloader --resolve kubeadm-1.21.4
yumdownloader --resolve kubectl-1.21.4
yumdownloader --resolve kubelet-1.21.4

createrepo --update ./
