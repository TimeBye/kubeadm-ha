#!/bin/bash
set -eux;

# 添加docker源
curl -o /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo

# 添加kubernetes源
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=0
repo_gpgcheck=0
EOF

case "${1:-centos7}" in
  centos7|centos8)
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
  openeuler)
    sed -i 's|$releasever|8|g' /etc/yum.repos.d/docker-ce.repo
    yum install -y findutils createrepo
    ;;
  *)
    yum install -y yum-utils epel-release createrepo
    ;;
esac

packages=(
    jq
    git
    curl
    wget
    htop
    audit
    iotop
    socat
    ipset
    sysstat
    ipvsadm
    nmap-ncat
    nfs-utils
    iscsi-initiator-utils
    net-tools
    libseccomp
    conntrack-tools
    bash-completion
    iproute
    docker-ce-20.10.24
    docker-ce-cli-20.10.24
    containerd.io-1.6.20
    kubeadm-1.30.5
    kubectl-1.30.5
    kubelet-1.30.5
    kubernetes-cni-1.4.0
)

if [ ! -d 'packages/repodata' ]; then
  (
    echo 'keepcache=1' >> /etc/yum.conf
    mkdir packages
    chmod 0777 packages
    cd packages
    repotrack ${packages[*]} || true
    yumdownloader --resolve ${packages[*]} || true
    yum install -y --downloadonly ${packages[*]}
    cp -rf `find /var/cache/{yum,dnf} -name '*.rpm'` .
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