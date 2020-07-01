# ibmcloud-image-builder

[![Build Status](https://travis-ci.org/IBM-Cloud/ibmcloud-image-builder.svg?branch=master)](https://travis-ci.org/IBM-Cloud/ibmcloud-image-builder)

This repo is for the project that is going to build various virtual machine images in `qcow2` format. The images can be imported into IBMCLOUD Cloud Object Storage (COS) and be served as custom images.

The required tools are from open source projects such as:
* [QEMU](https://www.qemu.org)
* Hashicorp [Packer](https://github.com/hashicorp/packer)

The base images that will be built upon:
* [Ubuntu](https://cloud-images.ubuntu.com)
* [CentOS](https://cloud.centos.org/centos/7/images/)
* TBD

This repo will also provide how to encrypt the images with Linux Unified Key Setup `luks` based encryption so that those encrypted images can be imported and used to spin up Virtual Server Instances (VSI) from IBM Virtual Private Cloud Generation 2.

The development environment will be provided as a `Dockerfile` based on Ubuntu 20.04, and the development environment will include:
* [qemu](https://www.qemu.org)
* [packer](https://github.com/hashicorp/packer)
* [ibmcloud cli client](https://github.com/IBM-Cloud/ibm-cloud-cli-release) & plugins
* [terraform](https://github.com/hashicorp/terraform) & [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)
* go 1.13
* python3 3.6.9 (pyenv, pipenv)
* ansible 2.9.9


# How To

```
$ git clone git@github.com:IBM-Cloud/ibmcloud-image-builder.git
$ cd ibmcloud-image-builder
$ make
```

Note: If a new packer template needs to be created, then please repeat yourself.

ubuntu@ubuntu-jenkins:~/test/github/ibmcloud-image-builder/packer$ tree -L 5
.
├── centos
│   └── 7
│       └── base
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

18 directories, 15 files
ubuntu@ubuntu-jenkins:~/test/github/ibmcloud-image-builder/packer$
copy the existing folder and rename the directory
change either shell/user-data.sh or ansible/playbook.yml
change the image name in packer-builder.sh ... hmm, this needs to be refactored at the next PR.
Do not change any other files under the directory except ansible directory; In ansible directory you can add more sophisticated ansible practices. Still, please don't rename playbook.yml.
Maybe I will consider cookiecutter template later.


# Acknowledgement
Thanks to the colleagues and IBM for sponsoring this project.

* Albert Camacho
* Chad Huesgen
* Dan Wiggins
* Zack Grossbart
* Irene Yip
* IBM CloudLab
* IBM
