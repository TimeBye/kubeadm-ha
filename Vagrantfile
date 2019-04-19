# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
    (1..3).each do |i|
        config.vm.define "node#{i}" do |s|
            s.vm.box = "bento/centos-7.6"
            s.vm.box_url = "http://files.saas.hand-china.com/vagrant/bento_centos-7.6.box"
            s.vm.hostname = "node#{i}"
            n = 10 + i
            s.vm.network "private_network", ip: "192.168.56.#{n}"
            s.vm.provider "virtualbox" do |v|
                v.memory = 4096
                v.cpus = 4
            end
        end
    end
end