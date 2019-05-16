FROM centos:centos7.5.1804 as centos
COPY download_yum .
RUN bash download_yum

FROM nginx:1.15.1-alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY kubernetes-v1.14.1.tar /kubernetes/kubernetes-v1.14.1.tar
COPY --from=centos /kubernetes /kubernetes/yum
RUN apk add --no-cache \
        bash \
        rsync \
        python \
        py-pip \
        openssl \
        sshpass \
        openssh-client
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
    apk del build-dependencies