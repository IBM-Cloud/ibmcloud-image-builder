#!/bin/bash
set -ex
# prepare to build

if [[ -f "~/.ssh/id_rsa.pub" ]]; then
  export PACKER_PUBLIC_KEY=~/.ssh/id_rsa.pub
  export PACKER_PRIVATE_KEY=~/.ssh/id_rsa
else
  mkdir -p ./ssh
  chmod 0700 ./ssh
  ssh-keygen -q -t rsa -b 4096 -C "travis+syyang@ibm.com" -N '' -f ./ssh/id_rsa <<< y
  export PACKER_PUBLIC_KEY=./ssh/id_rsa.pub
  export PACKER_PRIVATE_KEY=./ssh/id_rsa
fi

sudo rm -rf output-qemu

# prepare public key image
public_key=$(cat ${PACKER_PUBLIC_KEY})
cat <<EOF > user-data
#cloud-config
ssh_authorized_keys:
  - "${public_key}"
EOF

cloud-localds disk-ssh-pub.img user-data

# ansible-galaxy install
ansible-galaxy install geerlingguy.docker

# build the images
# base

PACKER_LOG=0 packer build packer.json

# Time to make the below as a function at the next PR
NEW_IMAGE="output-qemu/ibmcloud-centos-7-docker-cloudimg-amd64-100G.qcow2"
ENCRYPTED_IMAGE="output-qemu/ibmcloud-centos-7-docker-cloudimg-amd64-100G-encrypted.qcow2"

qemu-img resize output-qemu/packer.qcow2 100G
qemu-img convert -f qcow2 -O qcow2 output-qemu/centos-7.qcow2 ${NEW_IMAGE}
qemu-img info ${NEW_IMAGE}
rm output-qemu/centos-7.qcow2

# create an example encrypted image
if [ -n "$1" ]; then
  SECRET="$1"
else
  SECRET="JustMySimpleSecret"
fi
BASE64_ENCODED_SECRET=$(echo -n $SECRET | base64)

qemu-img convert -O qcow2 \
  --object secret,id=sec0,format=base64,data=${BASE64_ENCODED_SECRET} \
  -o encrypt.format=luks,encrypt.key-secret=sec0 \
  ${NEW_IMAGE} ${ENCRYPTED_IMAGE}

qemu-img compare \
  --object secret,id=sec0,format=base64,data=${BASE64_ENCODED_SECRET} \
  --image-opts \
  driver=qcow2,file.filename=${NEW_IMAGE} \
  driver=qcow2,encrypt.key-secret=sec0,file.filename=${ENCRYPTED_IMAGE}

# upload to COS

  #TBD

# import as custom images

  #TBD
