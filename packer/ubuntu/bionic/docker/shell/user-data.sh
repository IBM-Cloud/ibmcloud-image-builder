#!/bin/bash
echo "Install something here: TBD"
# Example user-data.sh that is installing the same package of the Dockerfile provided.
#    DEBIAN_FRONTEND=noninteractive,TZ="America/Central" \
#    sudo apt-get update && \
#    sudo apt-get install -y \
#    tzdata \
#    git \
#    mercurial \
#    build-essential \
#    libssl-dev \
#    libbz2-dev \
#    zlib1g-dev \
#    libffi-dev \
#    libreadline-dev \
#    libsqlite3-dev \
#    curl \
#    wget \
#    jq \
#    vim \
#    unzip \
#    iputils-ping \
#    dnsutils \
#    qemu-utils \
#    qemu \
#    qemu-system-x86 \
#    cloud-image-utils \
#    sudo && \
#    apt-get upgrade -y \
#    e2fsprogs \
#    libgcrypt20 \
#    libgnutls30
#
#    wget https://dl.google.com/go/go1.13.9.linux-amd64.tar.gz && \
#    tar xzf go1.13.9.linux-amd64.tar.gz && \
#    rm go1.13.9.linux-amd64.tar.gz && \
#    mv go /usr/local/go-1.13
#
#    echo "GOROOT=/usr/local/go-1.13" >> ~/.bashrc
#    echo "PATH=$GOROOT/bin:${HOME}/go/bin:$PATH" >> ~/.bashrc
#
#    wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip && \
#    unzip terraform_0.12.25_linux_amd64.zip && \
#    chmod +x terraform && \
#    rm terraform_0.12.25_linux_amd64.zip && \
#    sudo mv terraform /usr/local/bin && \
#    wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.8.0/linux_amd64.zip && \
#    unzip linux_amd64.zip && \
#    chmod +x terraform-provider-ibm_* && \
#    sudo mv terraform-provider-ibm_* /usr/local/bin && \
#    rm linux_amd64.zip && \
#    wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip && \
#    unzip packer_1.6.0_linux_amd64.zip && \
#    chmod +x packer && \
#    rm packer_1.6.0_linux_amd64.zip && \
#    sudo mv packer /usr/local/bin && \
#    wget https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip && \
#    unzip vault_1.4.2_linux_amd64.zip && \
#    chmod +x vault && \
#    rm vault_1.4.2_linux_amd64.zip && \
#    sudo mv vault /usr/local/bin
#
#    curl -sL https://ibm.biz/idt-installer | bash && \
#    ibmcloud plugin install vpc-infrastructure -f && \
#    ibmcloud plugin install cloud-object-storage -f && \
#    ibmcloud plugin install key-protect && \
#    ibmcloud plugin install tke && \
#    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#    sudo chmod +x /usr/local/bin/docker-compose
#
#    echo 'export PATH="/home/ubuntu/.pyenv/bin:$PATH"' >> ~/.bashrc
#    echo 'eval "$(pyenv init -)"'                      >> ~/.bashrc
#    echo 'eval "$(pyenv virtualenv-init -)"'           >> ~/.bashrc
#    echo 'export LC_ALL="C.UTF-8"'                     >> ~/.bashrc
#    echo 'export LANG="en_US.UTF-8"'                   >> ~/.bashrc
#    export PATH="/home/ubuntu/.pyenv/bin:$PATH"
#
#    sudo curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash && \
#    pyenv install 3.6.9 && \
#    pyenv global 3.6.9
#
