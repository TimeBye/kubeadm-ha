FROM setzero/ansible:2.7.5-nginx-1.15.1-alpine
RUN git clone https://github.com/TimeBye/kubeadm-ha /etc/ansible && \
    cd /etc/ansible
COPY default.conf /etc/nginx/conf.d/default.conf
ADD kubernetes-1.15.1.tar.gz /kubernetes/yum
COPY kubernetes-1.15.1.tar /kubernetes
WORKDIR /etc/ansible