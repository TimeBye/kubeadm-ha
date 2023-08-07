FROM setzero/kubeadm-ha:1.27.4-base
ARG BRANCH=master
RUN git clone -b ${BRANCH} https://github.com/TimeBye/kubeadm-ha.git /etc/ansible
WORKDIR /etc/ansible
ENTRYPOINT ["tini", "--"]
CMD ["/bin/sh", "-c", "nginx && registry serve /etc/docker/registry/config.yml"]