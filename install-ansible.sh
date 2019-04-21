#!/bin/bash

sudo yum install epel-release -y || true
sudo yum install git python36 sshpass -y || sudo apt-get install git python3-pip sshpass -y
sudo python3.6 -m ensurepip || true
sudo ln -s /usr/local/bin/pip3 /usr/bin/pip3 || true
sudo pip3 install --no-cache-dir ansible==2.7.5 netaddr -i https://mirrors.aliyun.com/pypi/simple/