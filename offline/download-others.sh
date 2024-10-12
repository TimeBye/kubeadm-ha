#!/bin/bash
set -eux;

case "${1:-amd64}" in
  amd64|x86_64)
    curl -Lo packages/helm.tar.gz https://get.helm.sh/helm-v3.16.2-linux-amd64.tar.gz;
    curl -Lo packages/cri-dockerd.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.14/cri-dockerd-0.3.14.amd64.tgz;
    ;;
  arm64|aarch64)
    curl -Lo packages/helm.tar.gz https://get.helm.sh/helm-v3.16.2-linux-arm64.tar.gz;
    curl -Lo packages/cri-dockerd.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.14/cri-dockerd-0.3.14.arm64.tgz;
    ;;
esac