#!/bin/bash

sudo yum install epel-release -y || true
sudo yum install git python36 sshpass -y || sudo apt-get install git python3-pip sshpass build-essential libssl-dev libffi-dev python-dev -y
sudo python3.6 -m ensurepip || true
sudo ln -s /usr/local/bin/pip3 /usr/bin/pip3 || true
sudo pip3 install --no-cache-dir ansible==2.7.8 netaddr==0.7.19 -i https://mirrors.aliyun.com/pypi/simple/