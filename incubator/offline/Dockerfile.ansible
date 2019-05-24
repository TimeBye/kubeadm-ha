FROM nginx:1.15.1-alpine
ENV LANG=C.UTF-8

# install ansible
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
    apk del build-dependencies