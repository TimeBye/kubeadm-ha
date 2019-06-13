FROM setzero/ansible:2.7.5-nginx-1.15.1-alpine
RUN git clone https://github.com/TimeBye/kubeadm-ha /etc/ansible && \
    cd /etc/ansible && \
    git checkout ${COMMIT_SHA}
COPY default.conf /etc/nginx/conf.d/default.conf
COPY kubernetes-1.14.3.tar /kubernetes/kubernetes-1.14.3.tar
COPY kubernetes /kubernetes/yum
WORKDIR /etc/ansible