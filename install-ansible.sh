#!/bin/bash

sudo yum install -y epel-release || sudo apt-get update
sudo yum install -y git python3-pip sshpass libffi-devel python3-devel openssl-devel || sudo apt-get install -y git python3-pip sshpass build-essential libssl-dev libffi-dev python3-dev
sudo pip3 install --no-cache-dir ansible==2.10.4 netaddr -i https://mirrors.aliyun.com/pypi/simple/