# -*- mode: ruby -*-
# vi: set ft=ruby :

$centos_script = <<-SCRIPT
mv /etc/yum.repos.d /etc/yum.repos.d.orig.$(date -Iseconds)
mkdir -p /etc/yum.repos.d/
curl -sSLo /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
sed "s/keepcache=0/keepcache=1/" -i /etc/yum.conf
yum install -y git
SCRIPT

$rhel7_script = <<-SCRIPT
mv /etc/yum.repos.d /etc/yum.repos.d.orig.$(date -Iseconds)
mkdir -p /etc/yum.repos.d/
wget -qO /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
sed -i 's/$releasever/7/g' /etc/yum.repos.d/CentOS-Base.repo
sed -i 's/PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
SCRIPT

$debian_script = <<-SCRIPT
cp /etc/apt/sources.list /etc/apt/sources.list.orig.$(date -Iseconds)
sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list
SCRIPT

$ubuntu_script = <<-SCRIPT
cp /etc/apt/sources.list /etc/apt/sources.list.orig.$(date -Iseconds)
sed -i 's http://.*.ubuntu.com http://mirrors.aliyun.com g' /etc/apt/sources.list
SCRIPT

Vagrant.configure(2) do |config|
    config.vm.define "node1" do |s|
        s.vm.box = "bento/centos-7.8"
        s.vm.box_url = "http://files.saas.hand-china.com/vagrant/bento_centos-7.8.box"
        s.vm.hostname = "node1"
        s.vm.network "private_network", ip: "192.168.56.11"
        # s.vm.network "forwarded_port", guest: 6443, host: 6443
        # s.vm.network "forwarded_port", guest: 8443, host: 8443
        s.vm.synced_folder ".", "/vagrant", disabled: true
        s.vm.provision "shell", inline: $centos_script
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
    config.vm.define "node2" do |s|
        s.vm.box = "generic/rhel7"
        s.vm.box_url = "http://files.saas.hand-china.com/vagrant/generic_rhel7.box"
        s.vm.hostname = "node2"
        s.vm.network "private_network", ip: "192.168.56.12"
        s.vm.synced_folder ".", "/vagrant", disabled: true
        s.vm.provision "shell", inline: $rhel7_script
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
    config.vm.define "node3" do |s|
        s.vm.box = "bento/debian-10.4"
        s.vm.box_url = "http://files.saas.hand-china.com/vagrant/bento_debian-10.4.box"
        s.vm.hostname = "node3"
        s.vm.network "private_network", ip: "192.168.56.13"
        s.vm.synced_folder ".", "/vagrant", disabled: true
        s.vm.provision "shell", inline: $debian_script
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
    config.vm.define "node4" do |s|
        s.vm.box = "bento/ubuntu-18.04"
        s.vm.box_url = "https://files.saas.hand-china.com/vagrant/bento_ubuntu-18.04.box"
        s.vm.hostname = "node4"
        s.vm.network "private_network", ip: "192.168.56.14"
        s.vm.synced_folder ".", "/vagrant", disabled: true
        s.vm.provision "shell", inline: $ubuntu_script
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
end
