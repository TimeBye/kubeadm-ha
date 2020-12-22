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
repotrack docker-ce-19.03.13
repotrack docker-ce-cli-19.03.13
repotrack containerd.io-1.3.7

createrepo --update ./
tar -czvf docker-ce-19.03.13.tar.gz *.rpm repodata
mv docker-ce-19.03.13.tar.gz ..

curl -o kernel-ml-4.20.13-1.el7.elrepo.x86_64.rpm \
    http://mirrors.reposnap.com/elrepo/20190306130017/kernel/el7/x86_64/RPMS/kernel-ml-4.20.13-1.el7.elrepo.x86_64.rpm
curl -o kernel-ml-devel-4.20.13-1.el7.elrepo.x86_64.rpm \
    http://mirrors.reposnap.com/elrepo/20190306130017/kernel/el7/x86_64/RPMS/kernel-ml-devel-4.20.13-1.el7.elrepo.x86_64.rpm

repotrack jq
repotrack git
repotrack curl
repotrack htop
repotrack iotop
repotrack socat
repotrack ipset
repotrack sysstat
repotrack ipvsadm
repotrack nmap-ncat
repotrack nfs-utils
repotrack yum-utils
repotrack net-tools
repotrack libseccomp
repotrack conntrack-tools
repotrack bash-completion
repotrack kubeadm-1.20.1
repotrack kubectl-1.20.1
repotrack kubelet-1.20.1

createrepo --update ./
tar -czvf kubernetes-1.20.1.tar.gz *.rpm repodata
mv kubernetes-1.20.1.tar.gz ..
