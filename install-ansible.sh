#!/bin/bash

sudo yum install -y epel-release || sudo apt-get update
sudo yum install -y git python3-pip sshpass || sudo apt-get install -y git python3-pip sshpass build-essential libssl-dev libffi-dev python-dev
sudo pip3 install --no-cache-dir ansible==2.8.3 netaddr==0.7.19 -i https://mirrors.aliyun.com/pypi/simple/