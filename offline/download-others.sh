#!/bin/bash
set -eux;

case "${1:-'amd64'}" in \
  amd64|x86_64) \
    curl -Lo packages/helm-v3.12.3-linux-amd64.tar.gz https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz; \
    curl -Lo packages/cri-dockerd-0.3.4.amd64.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.4/cri-dockerd-0.3.4.amd64.tgz; \
    ;; \
  arm64|aarch64) \
    curl -Lo packages/helm-v3.12.3-linux-arm64.tar.gz https://get.helm.sh/helm-v3.12.3-linux-arm64.tar.gz; \
    curl -Lo packages/cri-dockerd-0.3.4.arm64.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.4/cri-dockerd-0.3.4.arm64.tgz; \
    ;; \
esac