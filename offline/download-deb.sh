#/bin/bash
set -eux;

# 创建缓存目录
mkdir packages
chmod 0777 packages
cd packages

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y ca-certificates curl gnupg software-properties-common apt-transport-https dpkg-dev

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update

apt-get -d install -y \
  jq \
  git \
  htop \
  curl \
  lvm2 \
  socat \
  ipset \
  iotop \
  sysstat \
  ipvsadm \
  conntrack \
  net-tools \
  nfs-common \
  libseccomp2 \
  netcat-openbsd \
  ca-certificates \
  bash-completion \
  apt-transport-https \
  software-properties-common

# 下载指定版本docker
VERSION_STRING=5:20.10.24~3-0~"$(. /etc/os-release && echo "$ID")"-"$(. /etc/os-release && echo "$VERSION_CODENAME")"
apt-get -d install -y \
  docker-ce=$VERSION_STRING \
  docker-ce-cli=$VERSION_STRING \
  containerd.io=1.6.20-1

# 下载k8s
# 查询版本号apt-cache madison kubeadm | awk '{ print $3 }'
apt-get -d install -y \
  kubeadm=1.27.4-00 \
  kubectl=1.27.4-00 \
  kubelet=1.27.4-00 \
  kubernetes-cni=1.2.0-00

mv /var/cache/apt/archives/*.deb .
cd ..
dpkg-scanpackages packages > packages/Packages