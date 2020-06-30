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

# build the image
PACKER_LOG=0 packer build ubuntu.json

# prepare to upload

qemu-img resize output-qemu/ubuntu-bionic.qcow2 100G
qemu-img convert -f qcow2 -O qcow2 output-qemu/ubuntu-bionic.qcow2 output-qemu/ibmcloud-ubuntu-bionic-cloudimg-amd64-100G.qcow2
rm output-qemu/ubuntu-bionic.qcow2

# create an example encrypted image

qemu-img convert -O qcow2 \
  --object secret,id=sec0,format=base64,data=${BASE64_ENCODED_SECRET} \
  -o encrypt.format=luks,encrypt.key-secret=sec0 \
  output-qemu/ibmcloud-ubuntu-bionic-cloudimg-amd64-100G.qcow2 \
  output-qemu/ibmcloud-ubuntu-bionic-cloudimg-amd64-100G-encrypted.qcow2

# upload to COS

  #TBD

# import as custom images

  #TBD

# delete the images and cleanup
rm -rf output-qemu
rm -rf packer_cache
rm -rf ./ssh
rm -f user-data
rm -f disk-ssh-pub.img
