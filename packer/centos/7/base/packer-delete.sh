#!/bin/bash
set -ex

# delete the images and cleanup
rm -rf output-qemu
rm -rf packer_cache
rm -rf ./ssh
rm -f user-data
rm -f disk-ssh-pub.img
