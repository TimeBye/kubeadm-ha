FROM centos:centos7.4.1708 as centos
COPY download_yum .
RUN bash download_yum

FROM nginx:1.15.1-alpine
ENV LANG=C.UTF-8
COPY default.conf /etc/nginx/conf.d/default.conf
COPY kubernetes-1.14.1.tar /kubernetes/kubernetes-1.14.1.tar
COPY --from=centos /kubernetes /kubernetes/yum
RUN apk add --no-cache \
        git \
        bash \
        rsync \
        python \
        py-pip \
        openssl \
        sshpass \
        openssh-client \
        ca-certificates && \
    apk add --no-cache --virtual \
        build-dependencies \
        python-dev \
        libffi-dev \
        openssl-dev \
        build-base && \
    pip install --no-cache-dir --upgrade pip cffi && \
    pip install --no-cache-dir ansible==2.7.5 netaddr && \
    pip install --no-cache-dir --upgrade pycrypto pywinrm && \
    git clone https://github.com/TimeBye/kubeadm-ha /etc/ansible && \
    cd /etc/ansible && \
    git checkout ${COMMIT_SHA} && \
    apk del build-dependencies
WORKDIR /etc/ansible