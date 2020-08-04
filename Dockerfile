FROM alpine:latest

RUN set -ex \
        && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
        && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
        && apk update \
        && apk add --no-cache --virtual .build-python \
        && apk add bash ansible libffi-dev openssl-dev openssh qemu qemu-system-x86_64 nettle qemu-img cloud-init cloud-utils \
        && wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip \
        && unzip packer_1.6.0_linux_amd64.zip \
        && chmod +x packer \
        && rm packer_1.6.0_linux_amd64.zip \
        && mv packer /usr/local/bin

WORKDIR /ibmcloud-image-builder
