FROM ubuntu:20.04
LABEL "maintainer"="SeungYeop Yang"
ARG WDIR=/ibmcloud-image-builder
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Central
RUN set -ex && \
    apt-get update && \
    apt-get install -y \
    tzdata \
    git \
    mercurial \
    build-essential \
    libssl-dev \
    libbz2-dev \
    zlib1g-dev \
    libffi-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    wget \
    jq \
    vim \
    unzip \
    iputils-ping \
    dnsutils \
    qemu-utils \
    qemu \
    qemu-system-x86 \
    cloud-image-utils \
    sudo && \
    apt-get upgrade -y \
    e2fsprogs \
    libgcrypt20 \
    libgnutls30

    # golang 1.13
RUN set -ex && \
    wget https://dl.google.com/go/go1.13.9.linux-amd64.tar.gz && \
    tar xzf go1.13.9.linux-amd64.tar.gz && \
    rm go1.13.9.linux-amd64.tar.gz && \
    mv go /usr/local/go-1.13

ENV GOROOT=/usr/local/go-1.13
ENV PATH=$GOROOT/bin:${HOME}/go/bin:$PATH

    # terraform
RUN set -ex && \
    wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip && \
    unzip terraform_0.12.25_linux_amd64.zip && \
    chmod +x terraform && \
    rm terraform_0.12.25_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    # ibm provider
    wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.8.0/linux_amd64.zip && \
    unzip linux_amd64.zip && \
    chmod +x terraform-provider-ibm_* && \
    mv terraform-provider-ibm_* /usr/local/bin && \
    rm linux_amd64.zip && \
    # packer
    wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip && \
    unzip packer_1.6.0_linux_amd64.zip && \
    chmod +x packer && \
    rm packer_1.6.0_linux_amd64.zip && \
    mv packer /usr/local/bin && \
    # vault
    wget https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip && \
    unzip vault_1.4.2_linux_amd64.zip && \
    chmod +x vault && \
    rm vault_1.4.2_linux_amd64.zip && \
    mv vault /usr/local/bin

    # ibmcloud cli client
    # ibmcloud cli client installs docker
RUN set -ex && \
    curl -sL https://ibm.biz/idt-installer | bash && \
    ibmcloud plugin install vpc-infrastructure -f && \
    ibmcloud plugin install cloud-object-storage -f && \
    ibmcloud plugin install key-protect && \
    ibmcloud plugin install tke && \
    # docker-compose 1.25.5
    curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/*

ENV PYENV_ROOT "${HOME}/.pyenv"
ENV PATH "${HOME}/.pyenv/shims:${HOME}/.pyenv/bin:${PATH}"
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
ENV LC_ALL "C.UTF-8"
ENV LANG "en_US.UTF-8"

COPY requirements.txt ${HOME}/requirements.txt

RUN set -ex && \
    curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash && \
    pyenv install 3.6.9 && \
    pyenv global 3.6.9 && \
    pip install -r ${HOME}/requirements.txt && \
    rm ${HOME}/requirements.txt && \
    mkdir -p /integration-testing
    # python 3.6.9
    # install python 3.6.9 set 3.6.9 as global
    # if you want to try python 3.7.5 or higher, then
    #   run the docker container
    #   $ pyenv install 3.7.5
    #   $ pyenv global 3.7.5

WORKDIR ${WDIR}
