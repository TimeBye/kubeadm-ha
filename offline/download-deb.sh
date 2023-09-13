#/bin/bash
set -eux;

# 创建缓存目录
mkdir -p ${1:-'kubernetes-apt'}
cd ${1:-'kubernetes-apt'}
export DEBIAN_FRONTEND=noninteractive
apt-get update || true
apt-get install -y ca-certificates curl gnupg software-properties-common apt-transport-https dpkg-dev

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
apt-add-repository "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" -y



apt-get -d  install -y jq git htop curl lvm2 socat ipset iotop sysstat ipvsadm conntrack net-tools nfs-common libseccomp2 netcat-openbsd ca-certificates bash-completion apt-transport-https software-properties-common

# 下载指定版本docker
VERSION_STRING=5:20.10.21~3-0~ubuntu-focal
apt-get -d install -y docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io=1.6.15-1 docker-buildx-plugin docker-compose-plugin

# 下载k8s
# 查询版本号apt-cache madison kubeadm | awk '{ print $3 }'
apt-get -d install -y kubeadm=1.25.0-00 kubectl=1.25.0-00 kubelet=1.25.0-00 kubernetes-cni=0.8.7-00

mv /var/cache/apt/archives/*.deb .
dpkg-scanpackages .  >> Packages

# 20.04 -> focal, 22.04 -> jammy
mkdir -p dists/focal/
mkdir -p dists/focal/universe/binary-amd64/
cp Packages dists/focal/universe/binary-amd64/
cp -arf dists/focal/universe dists/focal/restricted
cp -arf dists/focal/universe dists/focal/main
cp -arf dists/focal/universe dists/focal/multiverse
cp -arf dists/focal dists/jammy


# 下载docker-ce
wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.21.tgz -O ../docker-ce-20.10.21-deb.tgz

echo 'deb [trusted=yes] http://192.168.3.7:12480/apt/ focal main restricted universe multiverse' > sources.list

离线安装docker
wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.21.tgz -O docker-ce-20.10.21-deb.tgz
tar -zxvf docker-ce-20.10.21-deb.tgz
mv docker/* /usr/bin/

cat <<EOF | tee /usr/lib/systemd/system/docker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target
[Service]
Type=notify
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s
[Install]
WantedBy=multi-user.target
EOF

systemctl start docker