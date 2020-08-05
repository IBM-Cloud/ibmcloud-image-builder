#!/bin/bash
set -ex
cd $1
# delete the images and cleanup
rm -rf output-qemu
rm -rf packer_cache
rm -rf ./ssh
rm -f user-data
rm -f disk-ssh-pub.img
