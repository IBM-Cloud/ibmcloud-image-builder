#!/usr/bin/env bash
docker build -t syyang/jenkins .
docker container stop ubuntu_jenkins && docker container rm -v ubuntu_jenkins
docker run -d -p 8080:8080 -p 50000:50000 -v /voljenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --name ubuntu_jenkins syyang/jenkins
