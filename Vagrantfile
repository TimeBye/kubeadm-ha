# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
    config.vm.define "node1" do |s|
        s.vm.box = "bento/centos-7.4"
        s.vm.box_url = "http://files.saas.hand-china.com/vagrant/bento_centos-7.4.box"
        s.vm.hostname = "node1"
        s.vm.network "private_network", ip: "192.168.56.11"
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
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
    config.vm.define "node3" do |s|
        s.vm.box = "bento/debian-9.6"
        s.vm.box_url = "http://files.saas.hand-china.com/vagrant/bento_debian-9.6.box"
        s.vm.hostname = "node3"
        s.vm.network "private_network", ip: "192.168.56.13"
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
    config.vm.define "node4" do |s|
        s.vm.box = "bento/ubuntu-16.04"
        s.vm.box_url = "http://files.saas.hand-china.com/vagrant/bento_ubuntu-16.04.box"
        s.vm.hostname = "node4"
        s.vm.network "private_network", ip: "192.168.56.14"
        s.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end
end