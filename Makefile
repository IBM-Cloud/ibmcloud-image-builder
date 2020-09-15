## Docker image naming; overridable by environment
IMAGE_NAME ?= ibmcloud-image-builder
IMAGE_NAME_UBUNTU ?= ibmcloud-image-builder-ubuntu
IMAGE_VERSION_LATEST ?= latest
REMOTE_BRANCH ?= main

## Options
default: all

all: build build-all cleanup

build:
	docker build . -f Dockerfile -t $(IMAGE_NAME):$(IMAGE_VERSION_LATEST)

ubuntu-build:
	docker build . -f Dockerfile.ubuntu -t $(IMAGE_NAME_UBUNTU):$(IMAGE_VERSION_LATEST)

build-all:
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/ubuntu/bionic/base   "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/ubuntu/bionic/docker "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/centos/7/base        "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/centos/7/docker      "

cleanup:
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/ubuntu/bionic/base  "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/ubuntu/bionic/docker"
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/centos/7/base       "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/centos/7/docker     "

ubuntu-bionic-base:
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/ubuntu/bionic/base   "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/ubuntu/bionic/base  "

ubuntu-bionic-docker:
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/ubuntu/bionic/docker "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/ubuntu/bionic/docker"

centos-7-base:
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/centos/7/base        "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/centos/7/base       "

centos-7-docker:
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/centos/7/docker      "
	docker run --privileged -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/centos/7/docker     "

build-image:
	$(if $(DISTRO_NAME),,$(error DISTRO_NAME is not set. [ubuntu, centos]))
	$(if $(DISTRO_VERSION),,$(error DISTRO_VERSION is not set.[bionic (ubuntu), 7 (centos)]))
	$(if $(TYPE),,$(error TYPE is not set. [base, docker]))
	docker run --privileged --rm -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-build.sh packer/${DISTRO_NAME}/${DISTRO_VERSION}/${TYPE}"
	docker run --privileged --rm -v `pwd`:/ibmcloud-image-builder ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} /bin/bash -c "./packer-delete.sh packer/${DISTRO_NAME}/${DISTRO_VERSION}/${TYPE}"

.PHONY: all
