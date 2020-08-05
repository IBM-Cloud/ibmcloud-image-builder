## Docker image naming; overridable by environment
IMAGE_NAME ?= ibmcloud-image-builder
IMAGE_VERSION_LATEST ?= latest
REMOTE_BRANCH ?= master

## Options
default: all

all: build build-images cleanup

build:
	docker build . -f Dockerfile -t $(IMAGE_NAME):$(IMAGE_VERSION_LATEST)

ubuntu-build:
	docker build . -f Dockerfile.ubuntu -t $(IMAGE_NAME):$(IMAGE_VERSION_LATEST)

build-images:
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

.PHONY: all
