FROM jenkins/jenkins

# docker run -d -p 8080:8080 -p 50000:50000 \
# -v /voljenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock \
# -v $(which docker):/usr/bin/docker --name ubuntu_jenkins syyang/jenkins
# reference : https://blog.container-solutions.com/running-docker-in-docker-via-jenkins-in-docker

# the base image above for jenkins-in-docker

# install sudo vim ansible
# sudo privilege to jenkins
# give docker group to jenkins

USER root
RUN apt update && \
    apt install -y sudo vim ansible jq
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# install ibmcloud cli, and realized that ibmcloud cli installs docker-ce
# if there is no ibmcloud cli, then you should install docker-ce instead
RUN curl -sL https://ibm.biz/idt-installer | bash
RUN usermod -aG docker jenkins

USER jenkins

# install docker-compose based on the recommendation from docker.com; no PPA packages
#   https://docs.docker.com/compose/install/
RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose && \
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
