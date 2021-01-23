FROM setzero/kubeadm-ha:base

COPY kubernetes-yum /kubernetes/yum
COPY default.conf /etc/nginx/conf.d/default.conf
COPY registry /var/lib/registry

RUN apk add --no-cache --virtual .build-deps \
        dpkg; \
    git clone https://github.com/TimeBye/kubeadm-ha.git /etc/ansible; \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    case "${dpkgArch}" in \
      amd64|x86_64) \
        curl -sSLo /kubernetes/helm-v3.4.2-linux-amd64.tar.gz https://get.helm.sh/helm-v3.4.2-linux-amd64.tar.gz; \
        ;; \
      aarch64|arm64) \
        curl -sSLo /kubernetes/helm-v3.4.2-linux-arm64.tar.gz https://get.helm.sh/helm-v3.4.2-linux-arm64.tar.gz; \
        ;; \
    esac; \
    apk del .build-deps

# Add Aliyun mirror source
RUN cp /etc/apk/repositories /etc/apk/repositories.bak; \
    sed -i 's dl-cdn.alpinelinux.org mirrors.aliyun.com g' /etc/apk/repositories

WORKDIR /etc/ansible
EXPOSE 80 5000
ENTRYPOINT ["tini", "--"]
CMD ["/bin/sh", "-c", "nginx && registry serve /etc/docker/registry/config.yml"]