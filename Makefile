## Docker image naming; overridable by environment
IMAGE_NAME ?= ibmcloud-image-builder
IMAGE_NAME_UBUNTU ?= ibmcloud-image-builder-ubuntu
IMAGE_VERSION_LATEST ?= latest
REMOTE_BRANCH ?= main

## Options
default: all

all: pre-build build-all clean

pre-build:
	docker build . -f Dockerfile -t $(IMAGE_NAME):$(IMAGE_VERSION_LATEST)

ubuntu-build:
	docker build . -f Dockerfile.ubuntu -t $(IMAGE_NAME_UBUNTU):$(IMAGE_VERSION_LATEST)

build-all: ubuntu-bionic-base ubuntu-bionic-docker ubuntu-bionic-stress centos-7-base centos-7-docker

clean:
	docker run --privileged --rm -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh"

ubuntu-bionic-base:
	$(MAKE) build-image DISTRO_NAME=ubuntu DISTRO_VERSION=bionic TYPE=base

ubuntu-bionic-docker:
	$(MAKE) build-image DISTRO_NAME=ubuntu DISTRO_VERSION=bionic TYPE=docker

ubuntu-bionic-stress:
	$(MAKE) build-image DISTRO_NAME=ubuntu DISTRO_VERSION=bionic TYPE=stress

centos-7-base:
	$(MAKE) build-image DISTRO_NAME=centos DISTRO_VERSION=7 TYPE=base

centos-7-docker:
	$(MAKE) build-image DISTRO_NAME=centos DISTRO_VERSION=7 TYPE=docker

build-image:
	$(if $(DISTRO_NAME),,$(error DISTRO_NAME is not set. [ubuntu, centos]))
	$(if $(DISTRO_VERSION),,$(error DISTRO_VERSION is not set.[bionic (ubuntu), 7 (centos)]))
	$(if $(TYPE),,$(error TYPE is not set. [base, docker]))
	docker run --privileged --rm -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/${DISTRO_NAME}/${DISTRO_VERSION}/${TYPE}"

.PHONY: all
