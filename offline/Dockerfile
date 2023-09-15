FROM registry:2 AS registry
FROM nginx:1.25

ENV LANG=C.UTF-8

COPY --from=registry /bin/registry /bin/registry
COPY --from=registry /etc/docker/registry/config.yml /etc/docker/registry/config.yml

COPY --chmod=755 sync-images.sh /usr/bin/sync-images
COPY default.conf /etc/nginx/conf.d/default.conf

RUN DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y \
      git \
      tini \
      rsync \
      skopeo \
      sshpass \
      python3-pip \
      openssh-client; \
    rm -f /usr/lib/python3.11/EXTERNALLY-MANAGED;\
    pip3 install --upgrade pip cffi; \
    pip3 install ansible==2.10.7 netaddr; \
    rm -rf /root/.cache; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get clean;

WORKDIR /etc/ansible
ENTRYPOINT ["tini", "--"]
CMD ["/bin/sh", "-c", "nginx && registry serve /etc/docker/registry/config.yml"]