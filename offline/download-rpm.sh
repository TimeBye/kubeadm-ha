#!/bin/bash
set -eux;

case "${1:-centos7}" in
  centos8)
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    ;;
esac

case "${1:-centos7}" in
  kylin10)
    echo "8" > /etc/yum/vars/releasever
    echo "centos" > /etc/yum/vars/contentdir
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
    sed -i 's|mirrors.aliyun.com/centos-vault|vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    sed -i 's|mirrors.aliyun.com|vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    ;;
  *)
    yum install -y yum-utils epel-release createrepo 
    ;;
esac

# 添加docker源
curl -o /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo

# 添加kubernetes源
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.27/rpm/
enabled=1
gpgcheck=0
repo_gpgcheck=0
EOF

if [ ! -d 'packages/repodata' ]; then
  (
    mkdir packages
    chmod 0777 packages
    cd packages
    repotrack jq
    repotrack git
    repotrack curl
    repotrack wget
    repotrack htop
    repotrack audit
    repotrack iotop
    repotrack socat
    repotrack ipset
    repotrack sysstat
    repotrack ipvsadm
    repotrack nmap-ncat
    repotrack nfs-utils
    repotrack iscsi-initiator-utils
    repotrack net-tools
    repotrack libseccomp
    repotrack conntrack-tools
    repotrack bash-completion
    repotrack iproute-tc || true
    repotrack docker-ce-20.10.24
    repotrack docker-ce-cli-20.10.24
    repotrack containerd.io-1.6.20
    yumdownloader --resolve docker-ce-20.10.24
    yumdownloader --resolve docker-ce-cli-20.10.24
    yumdownloader --resolve containerd.io-1.6.20
    repotrack kubeadm-1.30.2
    repotrack kubectl-1.30.2
    repotrack kubelet-1.30.2
    repotrack kubernetes-cni-1.4.0
    yumdownloader --resolve kubeadm-1.30.2
    yumdownloader --resolve kubectl-1.30.2
    yumdownloader --resolve kubelet-1.30.2
    yumdownloader --resolve kubernetes-cni-1.4.0
  )
  createrepo --update packages
fi

case "${1:-centos7}" in
  centos8|anolis8)
    yum install -y modulemd-tools
    repo2module -n timebye -s stable packages packages/repodata/modules.yaml
    modifyrepo_c --mdtype=modules packages/repodata/modules.yaml packages/repodata
    ;;
esac