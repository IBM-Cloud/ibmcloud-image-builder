# ibmcloud-image-builder

![Docker](https://github.com/IBM-Cloud/ibmcloud-image-builder/workflows/Docker/badge.svg) [![Build Status](https://travis-ci.org/IBM-Cloud/ibmcloud-image-builder.svg?branch=master)](https://travis-ci.org/IBM-Cloud/ibmcloud-image-builder)

# Release Readiness (v0.1.0)

The first official release: v0.1.0 (packer template for Ubuntu 18.04, CentOS 7 and tools)
- [x] templates for base and docker per each OS
- [x] build locally
- [x] CI build
- [x] github releases is ready
- [x] github packages is ready
- [x] DockerHub image repository is ready

# Introduction

This repo is for the project that is going to build various virtual machine images in `qcow2` format. The images can be imported into IBMCLOUD Cloud Object Storage (COS) and be served as custom images.

The required tools are from open source projects such as:
* [QEMU](https://www.qemu.org)
* Hashicorp [Packer](https://github.com/hashicorp/packer)

The base images that will be built upon:
* [Ubuntu](https://cloud-images.ubuntu.com)
* [CentOS](https://cloud.centos.org/centos/7/images/)
* TBD

This repo will also provide how to encrypt the images with Linux Unified Key Setup `luks` based encryption so that those encrypted images can be imported and used to spin up Virtual Server Instances (VSI) from IBM Virtual Private Cloud Generation 2.

The docker image that has all the required tools to build this VM images can be pulled from docker hub: https://hub.docker.com/r/syibm/ibmcloud-image-builder

### The CI environment will be provided as a `Dockerfile` based on Alpine latest, and the CI environment will include:
* [qemu](https://www.qemu.org)
* [packer](https://github.com/hashicorp/packer)
* cloud-utils
* ansible

The building time of this Docker image is < 1 min, I guess it can be used as an alternative while preparing docker pull from docker hub.


### The development environment will be provided as a `Dockerfile.ubuntu` based on Ubuntu 20.04, and the development environment will include:
* [qemu](https://www.qemu.org)
* [packer](https://github.com/hashicorp/packer)
* [ibmcloud cli client](https://github.com/IBM-Cloud/ibm-cloud-cli-release) & plugins
* [terraform](https://github.com/hashicorp/terraform) & [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)
* cloud-utils
* go 1.13
* python3 3.6.9 (pyenv, pipenv)
* ansible 2.9.9

The building time of this Docker image is about 7 mins from my machines, it takes long. While preparing a repository in docker hub, maybe worthy to try once. It won't be changed very often any more.

# Availalble images

So far we have Ubuntu 18.04 and CentOS 7 images as below:
* Ubuntu 18.04 Base
* Ubuntu 18.04 Base + Docker Installed
* CentOS 7 Base
* CentOS 7 Base + Docker Installed

```
$ tree -L 3
.
├── centos
│   └── 7
│       ├── base
│       └── docker
└── ubuntu
    ├── bionic
    │   ├── base
    │   └── docker
    ├── focal
    └── xenial

10 directories, 0 files
```

# How To

```
$ git clone git@github.com:IBM-Cloud/ibmcloud-image-builder.git
$ cd ibmcloud-image-builder
$ make
```

Note: If a new packer template needs to be created, then please repeat yourself.
The extra `docker` templates in addtion to `base` templates are for the information purpose on how to add new templates.

1. copy the existing folder and rename the directory
2. change either shell/user-data.sh or ansible/playbook.yml
3. change the image name in packer-builder.sh ... hmm, this needs to be refactored later.

* Do not change any other files under the directory except ansible directory; In ansible directory you can add more sophisticated ansible practices.

# How to build an encrypted image with you DEK (Data Encryption Key)
```
cd "proper directory"
./packer-build.sh "Your DEK here"
```

```
$ tree -L 5
.
├── centos
│   └── 7
│       ├── base
│       │   ├── ansible
│       │   │   └── playbook.yml
│       │   ├── centos.json
│       │   ├── http
│       │   ├── packer-build.sh
│       │   ├── packer-delete.sh
│       │   └── shell
│       │       └── user-data.sh
│       └── docker
│           ├── ansible
│           │   └── playbook.yml
│           ├── centos.json
│           ├── http
│           ├── packer-build.sh
│           ├── packer-delete.sh
│           └── shell
│               └── user-data.sh
└── ubuntu
    ├── bionic
    │   ├── base
    │   │   ├── ansible
    │   │   │   └── playbook.yml
    │   │   ├── http
    │   │   ├── packer-build.sh
    │   │   ├── packer-delete.sh
    │   │   ├── shell
    │   │   │   └── user-data.sh
    │   │   └── ubuntu.json
    │   └── docker
    │       ├── ansible
    │       │   └── playbook.yml
    │       ├── http
    │       ├── packer-build.sh
    │       ├── packer-delete.sh
    │       ├── shell
    │       │   └── user-data.sh
    │       └── ubuntu.json
    ├── focal
    └── xenial

22 directories, 20 files
```



# Acknowledgement
Thanks to the colleagues and IBM for sponsoring this project.

* Albert Camacho
* Chad Huesgen
* Dan Wiggins
* Zack Grossbart
* Irene Yip
* IBM CloudLab
* IBM
