#!/bin/sh
set -e

is_darwin() {
  case "$(uname -s)" in
  *darwin* ) true ;;
  *Darwin* ) true ;;
  * ) false;;
  esac
}

get_distribution() {
  lsb_dist=""
  # Every system that we officially support has /etc/os-release
  if [ -r /etc/os-release ]; then
    lsb_dist="$(. /etc/os-release && echo "$ID")"
  fi
  # Returning an empty string here should be alright since the
  # case statements don't act unless you provide an actual value
  echo "$lsb_dist"
}

do_install() {
  # perform some very rudimentary platform detection
  lsb_dist=$( get_distribution )
  lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
  # Run setup for each distro accordingly
  export LANG=en_US.UTF-8
  case "$lsb_dist" in
    ubuntu|debian|raspbian)
        sudo apt-get update
        sudo apt-get install -y git python3-pip sshpass build-essential libssl-dev libffi-dev python3-dev
        sudo pip3 install -U pip -i https://mirrors.aliyun.com/pypi/simple/
        sudo pip3 install --no-cache-dir ansible==2.10.4 netaddr -i https://mirrors.aliyun.com/pypi/simple/
        exit 0
      ;;
    centos|fedora|rhel|ol|anolis|kylin)
        sudo curl -sSLo /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo
        sudo yum install -y git python3-pip sshpass libffi-devel python3-devel openssl-devel
        sudo pip3 install -U pip -i https://mirrors.aliyun.com/pypi/simple/
        sudo pip3 install --no-cache-dir ansible==2.10.4 netaddr -i https://mirrors.aliyun.com/pypi/simple/
        exit 0
      ;;
    openeuler)
        sudo yum install -y git sshpass
        sudo pip3 install --no-cache-dir ansible==2.10.4 netaddr -i https://mirrors.aliyun.com/pypi/simple/
        exit 0
      ;;
    *)
      if [ -z "$lsb_dist" ]; then
        if is_darwin; then
          brew install ./ansible/homebrew-core/ansible.rb
          brew install ./ansible/homebrew-core/sshpass.rb
          exit 0
        fi
      fi
      echo
      echo "ERROR: Unsupported distribution '$lsb_dist'"
      echo
      exit 1
      ;;
  esac
  exit 1
}

do_install