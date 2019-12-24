FROM setzero/ansible:2.8.3-nginx-1.17.2-alpine
RUN git clone https://github.com/TimeBye/kubeadm-ha /etc/ansible && \
    cd /etc/ansible
COPY default.conf /etc/nginx/conf.d/default.conf
ADD kubernetes-1.15.7.tar.gz /kubernetes/yum
COPY kubernetes-1.15.7.tar /kubernetes
WORKDIR /etc/ansible