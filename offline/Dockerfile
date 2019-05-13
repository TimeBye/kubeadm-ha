FROM centos:centos7.5.1804 as centos
COPY offline.sh .
RUN bash offline.sh

FROM nginx:1.15.1-alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=centos /kubernetes /kubernetes/yum
RUN \
    sed -i 's dl-cdn.alpinelinux.org mirrors.aliyun.com g' /etc/apk/repositories && \
    apk add --no-cache \
        sudo \
        bash \
        python \
        py-pip \
        openssl \
        ca-certificates && \
    apk add --no-cache --virtual \
        build-dependencies \
        python-dev \
        libffi-dev \
        openssl-dev \
        build-base && \
    pip install --no-cache-dir --upgrade pip cffi -i https://mirrors.aliyun.com/pypi/simple/ && \
    pip install --no-cache-dir ansible==2.7.5 netaddr -i https://mirrors.aliyun.com/pypi/simple/ && \
    pip install --no-cache-dir --upgrade pycrypto pywinrm -i https://mirrors.aliyun.com/pypi/simple/ && \
    apk add --no-cache \
        sshpass \
        openssh-client \
        rsync && \
    apk del build-dependencies